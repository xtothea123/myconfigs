" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" COLORS
set t_Co=256
set cursorline
"hi cursorline ctermbg=darkred <-- see bottom
"set foldcolumn=4
set foldmethod=marker


" syntax
if has('syntax') && (&t_Co > 2)
    syntax on
endif


let mapleader      = ","
let maplocalleader = "\\"


nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>eh :split $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

vnoremap <leader>7 :s/^/\/\/<CR> :let @/ = ""<CR>
"vnoremap <leader><S-7> :s/^\/\//<CR> <-- see bottom


nnoremap _ yyddkkp
nnoremap - yyddp
inoremap <C-d> <ESC>ddi
inoremap <C-u> <ESC>g~iwi



" disable stupid auto tabs after each newline when pasting text
"set paste

" some tab options
set autoindent
set backspace=2
set tabstop=4
set expandtab
set smarttab

" #### SET ALT and ALT MAPPINGS
nmap <A-Left> <C-W>h
nmap <A-Right> <C-W>l 
nmap <A-Up> <C-W>k 
nmap <A-Down> <C-W>j 

imap <A-Left> <C-O><C-W>h
imap <A-Right> <C-O><C-W>l
imap <A-Up> <C-O><C-W>k
imap <A-Down> <C-O><C-W>j


" change window size

nmap <S-Left> <C-W><
nmap <S-Right> <C-W>> 
nmap <S-Up> <C-W>-
nmap <S-Down> <C-W>+

imap <S-Left> <C-O><C-W><
imap <S-Right> <C-O><C-W>> 
imap <S-Up> <C-O><C-W>-
imap <S-Down> <C-O><C-W>+

" CTRL+s for save (needs stty stop undef in .bashrc)
nnoremap <C-S> <ESC>:w<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:w<CR>
inoremap <silent> <C+O>         <C-O>:q<CR>


"inoremap <C-Left> <ESC>0<CR>
"inoremap { { <ENTER><ENTER>}<C-O>k<TAB>
"inoremap [  <C-O>[]<CR>
"inoremap (  <C-O>()<CR>


" numbers on the left
set number
nnoremap <leader>n :set nonumber!<CR>
" shift width (length in spaces)
set shiftwidth=4
set hlsearch
set hidden

" clear highlight search
nmap <C-N> <ESC>:let @/ = ""<CR>
vmap <C-N> <ESC>:let @/ = ""<CR>

"########################################
"########## GREP  #######################
"########################################
":nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>
nnoremap <leader>g :execute " grep -srnw --binary-files=without-match --exclude-dir=.svn --exclude=.svn . -e " . expand("<cword>") . " " <bar> cwindow<CR>

"########## VISUAL MODE #################
"########################################
" replace highlighted search pattern
"vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
" easy replacing
"vnoremap <C-R> :s///g <Left><Left><Left><Left>
"nnoremap <C-R> :%s///g <Left><Left><Left><Left>


" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>



"########################################
"########## TABS ########################
"########################################

function MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction



function MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return bufname(buflist[winnr - 1])
endfunction


" some mappings for tabs
map <F2> <Esc>:tabn<CR>
map <F3> <Esc>:tabp<CR>
imap <F2> <Esc>:tabn<CR>
imap <F3> <Esc>:tabp<CR>
nnoremap <silent> <F2> :tabn<CR>
nnoremap <silent> <F3> :tabp<CR>
nnoremap <silent> <C-t> :tabnew<CR>
nnoremap <silent> <C-e> :tabclose<CR>




" tag list plugin commands
nnoremap <F5> <Esc>:TlistToggle<CR>
nnoremap <F6> <Esc>:TlistOpen<CR>
" useful mappings for command mode
" nore ; :
" nore , ;

" code completion




"#### COLORS ####
colorscheme jellybeans
"colorscheme advantage 



" statusline
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}[%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
hi statusline   ctermbg=6B8E23 ctermfg=black
hi statuslineNC ctermbg=2E8B57 ctermfg=black
" Mode Indication -Prominent!
function! InsertStatuslineColor(mode)
    if a:mode == 'i'
        hi statusline ctermbg=red
        set cursorcolumn
    elseif a:mode == 'r'
        hi statusline ctermbg=blue
    else
        hi statusline ctermbg=cyan
    endif
endfunction

function! InsertLeaveActions()
    hi statusline ctermbg=cyan
    set nocursorcolumn
endfunction



" to handle exiting insert mode via a control-C
inoremap <c-c> <c-o>:call InsertLeaveActions()<cr><c-c>

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * call InsertLeaveActions()

"##########################  SMARTY ######################################
"au BufRead,BufNewFile *.tpl set filetype=smarty 



"#########################################################################
"##########################  PHP SPECIFIC ################################
"#########################################################################

" php lang constructs

" phpdoc
autocmd FileType php inoremap <C-L> <ESC>:call PhpDocSingle()<CR>i
autocmd FileType php nnoremap <C-L> :call PhpDocSingle()<CR>
autocmd FileType php vnoremap <C-L> :call PhpDocRange()<CR> 

" omnicompete
"autocmd FileType php set omnifunc=phpcomplete#CompletePHP
"set tags+=/mnt/files/projekte/reps/tags



" #### php syntax ####
let php_sql_query=1
let php_htmlInStrings=1
" run file with PHP CLI (CTRL-M)
":autocmd FileType php noremap <C-M> :w!<CR>:!/usr/bin/php %<CR>
" PHP parser check (CTRL-L)
":autocmd FileType php noremap <C-L> :!/usr/bin/php -l %<CR>



"#########################################################################
" #### NERD TREE ####
"#########################################################################

"autocmd VimEnter * NERDTree /mnt/files/projekte
autocmd VimEnter * wincmd p
autocmd BufEnter * NERDTreeMirror
nnoremap <F7> <ESC>:NERDTreeToggle /mnt/files/projekte<CR>
let NERDTreeShowLineNumbers = 0
let NERDChristmasTree = 1
let NERDTreeShowFiles = 1
let NERDTreeWinSIze   = 37
let NERDTreeChDirMode = 1 





"#### TAG LIST ####
let Tlist_Use_Right_Window = 1
"let Tlist_Close_On_Select = 1 "close taglist window once we selected something
let Tlist_Exit_OnlyWindow  = 1 "if taglist window is the only window left, exit vim
let Tlist_Show_Menu        = 1 "show Tags menu in gvim
let Tlist_Show_One_File    = 1 "show tags of only one file
let Tlist_GainFocus_On_ToggleOpen = 1 "automatically switch to taglist window
let Tlist_Highlight_Tag_On_BufEnter = 1 "highlight current tag in taglist window
let Tlist_Process_File_Always = 1 "even without taglist window, create tags file, required for displaying tag in statusline
let Tlist_Use_Right_Window = 1 "display taglist window on the right
let Tlist_Display_Prototype = 1 "display full prototype instead of just function name
"let Tlist_Ctags_Cmd = /path/to/exuberant/ctags
"let tlist_php_settings = 'php;c:class;f:function;d:constant' " set the names of flags
"let Tlist_File_Fold_Auto_Close = 1 " 
let Tlist_WinWidth = 50 " width of window

"#########################################################################
"##########################  SVN SPECIFIC ################################
"#########################################################################
noremap <F9> :call Svndiff("prev")<CR>
noremap <F10> :call Svndiff("next")<CR>
noremap <F11> :call Svndiff("clear")<CR> 





" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> "+x
vnoremap <S-Del> "+x

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y

" CTRL-V and SHIFT-Insert are Paste
map <C-V>       "+gP
map <S-Insert>      "+gP

cmap <C-V>      <C-R>+
cmap <S-Insert>     <C-R>+


" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.

exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

imap <S-Insert>     <C-V>
vmap <S-Insert>     <C-V>

" Use CTRL-Q to do what CTRL-V used to do
noremap <C-Q>       <C-V>

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.  Add to that some tricks to leave the cursor in
" the right position, also for "gi".
if has("virtualedit")
  let paste#paste_cmd = {'n': ":call paste#Paste()<CR>"}
  let paste#paste_cmd['v'] = '"-c<Esc>' . paste#paste_cmd['n']
  let paste#paste_cmd['i'] = 'x<BS><Esc>' . paste#paste_cmd['n'] . 'gi'

  func! paste#Paste()
    let ove = &ve
    set ve=all
    normal! `^
    if @+ != ''
      normal! "+gP
    endif
    let c = col(".")
    normal! i
    if col(".") < c " compensate for i<ESC> moving the cursor left
      normal! l
    endif
  endfunction
  let paste#paste_cmd = {'n': "\"=@+.'xy'<CR>gPFx\"_2x"}
  let paste#paste_cmd['v'] = '"-c<Esc>gix<Esc>' . paste#paste_cmd['n'] . '"_x'
  let paste#paste_cmd['i'] = 'x<Esc>' . paste#paste_cmd['n'] . '"_s'
endif



"VUNDLE
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
"PHPQA
Bundle 'joonty/vim-phpqa.git'
nnoremap <F8> <Esc>:Phpcs<CR>
let g:phpqa_messdetector_autorun = 0
let g:phpqa_messdetector_ruleset = "~/phpmd/phpmd.xml"
let g:phpqa_codesniffer_args = "--error-severity=6 --warning-severity=7 --standard=Zend"
let g:phpqa_codesniffer_autorun = 0


"let mapleader = "\\"
"set guifont=Consolas:h11

"Multi Line Comments
noremap <silent> ,/ :call CommentLineToEnd('// ')<CR>+




"################### HELP FUNCTIONS #######################
"##########################################################

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
" search in visual mode
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


hi cursorline ctermbg=16

vnoremap <leader>/ :s/^\/\///  <CR>

"########################### MAKE ###########################
autocmd FileType make setlocal noexpandtab

