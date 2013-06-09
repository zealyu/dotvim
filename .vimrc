runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
Helptags


" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
" map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=700
" Set to auto read when a file is changed from the outside
set autoread
" With a map leader it's possible to do extra key combinations
" " like <leader>w saves the current file
let mapleader=","
let g:mapleader=","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
" Height of the command bar
set cmdheight=2
" A buffer becomes hidden when it is abandoned
set hid
" For regular expressions turn magic on
set magic

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart way to move between windows
map <C-J> <C-W>j 
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

" Useful mappings for managing tabs
map <leader>to :tabnew<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tc :tabclose<cr>
" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
" 在新的tab中打开当前buffer的目录
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>
" Switch CWD to the directory of the open buffer
" 改变当前的工作路径为当前buffer的路径
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif


" Specify the behavior when switching between buffers 
" 当在quickfix打开一个新的buf时，在新的tab中打开，并且显示tab标签
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" netrw setting VIM自带的explore
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_winsize = 25
nmap <silent> <leader>fe :Sexplore!<cr> 


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Always show the status line
set laststatus=2

" Format the status line 这个格式化statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
" 这个是在Visual模式下在当前目录及其子目录下查找选中的字段，在当前文件中查找向下查找用*
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position 用vimgrep进行全局搜索
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<right><right><right><right><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>

" Open Quickfix window and jump between the errors
map <leader>cc :botright cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg=@"
    execute "normal! vgvy"

    let l:pattern=escape(@",'\\/.*$^~[]')
    let l:pattern=substitute(l:pattern,"\n$","","")
    
    if a:direction=='b'
	execute "normal ?" . l:pattern . "^M"
    elseif a:direction=='gv'
	"call CmdLine("vimgrep " . '/' . l:pattern . '/' . ' **/*.')
	execute "vimgrep " . '/' . l:pattern . '/' . ' **/*'
    elseif a:direction=='replace'
	"call CmdLine("%s" . '/' . l:pattern . '/')
	execute "%s" . '/' . l:pattern . '/'

    elseif a:direction=='f'
	execute "normal /" . l:pattern . "^M"
    endif

    let @/=l:pattern
    let @"=l:saved_reg
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
	return 'PASTE MODE  '
    en
    return ''
endfunction
" 以下是自己添加的
" map + _ to resize windows
map + +
map _ -
set nu
" 根据文件类型设置shiftwidth，并且fold依据indent
set shiftwidth=4
autocmd BufRead,BufNewFile *.html set shiftwidth=2
autocmd BufRead,BufNewFile *.c,*.h,*.cpp,*.hpp set shiftwidth=4
set cindent
" 语法折叠
set foldmethod=syntax
set foldlevel=100
" 自动补全
"imap <TAB> <C-P> "该自动补全是在当前文件向前local搜索,该搜索的选项可通过complete来设置，如设置是否包含头文件以及头文件的搜索路径等

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Taglist configure
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Process_File_Always=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Show_One_File=1
let Tlist_Use_Right_Window=1
let Tlist_Inc_Winwidth=0
let Tlist_Auto_Update=1
