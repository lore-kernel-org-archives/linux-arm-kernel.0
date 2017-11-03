From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 3 Nov 2017 07:18:06 +0300
Subject: next-20171102: ARM64 dies on boot
Message-ID: <20171103041806.ya7e7vfrau3dx5de@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I reproduce it with qemu. The exact reason of panic is the NULL-dereference
in memory_present:
(gdb) bt
#0  0xffff000008dd8c6c in sparse_index_init (nid=<optimized out>, section_nr=<optimized out>)
    at mm/sparse.c:80
#1  memory_present (nid=0, start=18446462598881083392, end=0) at mm/sparse.c:215
#2  0xffff000008dc518c in arm64_memory_present () at arch/arm64/mm/init.c:307
#3  bootmem_init () at arch/arm64/mm/init.c:500
#4  0xffff000008dc28fc in setup_arch (cmdline_p=<optimized out>) at arch/arm64/kernel/setup.c:287
#5  0xffff000008dc083c in start_kernel () at init/main.c:530
#6  0x0000000000000000 in ?? ()

B+ ?0xffff000008dd8c10 <memory_present>     stp    x29, x30, [sp, #-80]!                              ?
   ?0xffff000008dd8c14 <memory_present+4>   and    x1, x1, #0xfffffffffffc0000                        ?
   ?0xffff000008dd8c18 <memory_present+8>   mov    x29, sp                                            ?
   ?0xffff000008dd8c1c <memory_present+12>  stp    x23, x24, [sp, #48]                                ?
   ?0xffff000008dd8c20 <memory_present+16>  mov    w23, w0                                            ?
   ?0xffff000008dd8c24 <memory_present+20>  stp    x19, x20, [sp, #16]                                ?
   ?0xffff000008dd8c28 <memory_present+24>  lsl    w20, w23, #3                                       ?
   ?0xffff000008dd8c2c <memory_present+28>  stp    x21, x22, [sp, #32]                                ?
   ?0xffff000008dd8c30 <memory_present+32>  add    x0, x29, #0x48                                     ?
   ?0xffff000008dd8c34 <memory_present+36>  stp    x2, x1, [x29, #64]                                 ?
   ?0xffff000008dd8c38 <memory_present+40>  orr    w20, w20, #0x4                                     ?
   ?0xffff000008dd8c3c <memory_present+44>  add    x1, x29, #0x40                                     ?
   ?0xffff000008dd8c40 <memory_present+48>  bl     0xffff000008e16a1c <mminit_validate_memmodel_limits?
   ?0xffff000008dd8c44 <memory_present+52>  ldr    x21, [x29, #72]                                    ?
   ?0xffff000008dd8c48 <memory_present+56>  adrp   x22, 0xffff000009023000 <preferred_node_policy+8>  ?
   ?0xffff000008dd8c4c <memory_present+60>  sxtw   x20, w20                                           ?
   ?0xffff000008dd8c50 <memory_present+64>  mov    x24, x22                                           ?
   ?0xffff000008dd8c54 <memory_present+68>  ldr    x0, [x29, #64]                                     ?
   ?0xffff000008dd8c58 <memory_present+72>  cmp    x0, x21                                            ?
   ?0xffff000008dd8c5c <memory_present+76>  b.ls   0xffff000008dd8ce4 <memory_present+212>  // b.plast?
   ?0xffff000008dd8c60 <memory_present+80>  lsr    x19, x21, #26                                      ?
   ?0xffff000008dd8c64 <memory_present+84>  ldr    x0, [x22, #96]                                     ?
   ?0xffff000008dd8c68 <memory_present+88>  lsl    x19, x19, #3                                       ?
  >?0xffff000008dd8c6c <memory_present+92>  ldr    x0, [x0, x19]  				      | <<<<<< HERE
   ?0xffff000008dd8c70 <memory_present+96>  cbnz   x0, 0xffff000008dd8c88 <memory_present+120>        ?
   ?0xffff000008dd8c74 <memory_present+100> mov    w0, w23                                            ?
   ?0xffff000008dd8c78 <memory_present+104> bl     0xffff0000089824e4 <sparse_index_alloc>            ?
   ?0xffff000008dd8c7c <memory_present+108> cbz    x0, 0xffff000008dd8c88 <memory_present+120>        ?
   ?0xffff000008dd8c80 <memory_present+112> ldr    x1, [x22, #96]                                     ?
   ?0xffff000008dd8c84 <memory_present+116> str    x0, [x1, x19]                                      ?
   ?0xffff000008dd8c88 <memory_present+120> ldr    x0, [x24, #96]                                     ?
   ?0xffff000008dd8c8c <memory_present+124> cbz    x0, 0xffff000008dd8ca4 <memory_present+148>        ?
   ?0xffff000008dd8c90 <memory_present+128> ldr    x5, [x0, x19]                                      ?
   ?0xffff000008dd8c94 <memory_present+132> cbz    x5, 0xffff000008dd8ca8 <memory_present+152>        ?
   ?0xffff000008dd8c98 <memory_present+136> ubfx   x0, x21, #18, #8                                   ?
   ?0xffff000008dd8c9c <memory_present+140> add    x5, x5, x0, lsl #4                                 ?
   ?0xffff000008dd8ca0 <memory_present+144> b      0xffff000008dd8ca8 <memory_present+152>            ?
   ?0xffff000008dd8ca4 <memory_present+148> mov    x5, #0x0                        // #0              ?
   ?0xffff000008dd8ca8 <memory_present+152> ldr    x0, [x5]                                           ?
   ?0xffff000008dd8cac <memory_present+156> cbnz   x0, 0xffff000008dd8cdc <memory_present+204>        ?
   ?0xffff000008dd8cb0 <memory_present+160> str    x20, [x5]                                          ?
   ?0xffff000008dd8cb4 <memory_present+164> mov    x0, x5                                             ?
   ?0xffff000008dd8cb8 <memory_present+168> bl     0xffff0000081e4670 <__section_nr>                  ?
   ?0xffff000008dd8cbc <memory_present+172> add    x1, x24, #0x60                                     ?
   ?0xffff000008dd8cc0 <memory_present+176> ldr    w2, [x1, #8]                                       ?
   ?0xffff000008dd8cc4 <memory_present+180> cmp    w0, w2                                             ?
   ?0xffff000008dd8cc8 <memory_present+184> b.le   0xffff000008dd8cd0 <memory_present+192>            ?
   ?0xffff000008dd8ccc <memory_present+188> str    w0, [x1, #8]                                       ?
   ?0xffff000008dd8cd0 <memory_present+192> ldr    x0, [x5]                                           ?
   ?0xffff000008dd8cd4 <memory_present+196> orr    x0, x0, #0x1                                       ?
   ?0xffff000008dd8cd8 <memory_present+200> str    x0, [x5]                                           ?
   ?0xffff000008dd8cdc <memory_present+204> add    x21, x21, #0x40, lsl #12                           ?
   ?0xffff000008dd8ce0 <memory_present+208> b      0xffff000008dd8c54 <memory_present+68>             ?
   ?0xffff000008dd8ce4 <memory_present+212> ldp    x19, x20, [sp, #16]                                ?
   ?0xffff000008dd8ce8 <memory_present+216> ldp    x21, x22, [sp, #32]                                ?
   ?0xffff000008dd8cec <memory_present+220> ldp    x23, x24, [sp, #48]                                ?
   ?0xffff000008dd8cf0 <memory_present+224> ldp    x29, x30, [sp], #80                                ?
   ?0xffff000008dd8cf4 <memory_present+228> ret                                                       |

This is very early stage, so there's no messages in console.
Config is attached. If no ideas, I can bisect it later.

Yury
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.next.gz
Type: application/gzip
Size: 36805 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171103/f302c471/attachment-0001.gz>
