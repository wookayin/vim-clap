" Author: liuchengxu <xuliuchengxlc@gmail.com>
" Description: List the open buffers and oldfiles in order.

let s:save_cpo = &cpo
set cpo&vim

let s:history = {}

function! s:all_files()
  return uniq(map(
    \ filter([expand('%')], 'len(v:val)')
    \   + filter(map(clap#util#buflisted_sorted(), 'bufname(v:val)'), 'len(v:val)')
    \   + filter(copy(v:oldfiles), "filereadable(fnamemodify(v:val, ':p'))"),
    \ 'fnamemodify(v:val, ":~:.")'))
endfunction

let s:history.sink = 'e'
let s:history.source = function('s:all_files')

let g:clap#provider#history# = s:history

let &cpo = s:save_cpo
unlet s:save_cpo
