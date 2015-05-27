From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 May 2015 14:40:07 +0200
Subject: [PATCH v2 5/5] arm64: add KASan support
In-Reply-To: <1431698344-28054-6-git-send-email-a.ryabinin@samsung.com>
References: <1431698344-28054-1-git-send-email-a.ryabinin@samsung.com>
 <1431698344-28054-6-git-send-email-a.ryabinin@samsung.com>
Message-ID: <CACRpkdapJXZuv4O=gDh7QD=7DgRxE+Mf=fSF6OxwGSpGb=2bOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 15, 2015 at 3:59 PM, Andrey Ryabinin <a.ryabinin@samsung.com> wrote:

> This patch adds arch specific code for kernel address sanitizer
> (see Documentation/kasan.txt).

OK fixed a newer GCC (4.9.3, so still just KASAN_OUTLINE), compiled
and booted on the ARM Juno Development System:

kasan test: kmalloc_large_oob_rigth kmalloc large allocation:
out-of-bounds to right
==================================================================
BUG: KASan: out of bounds access in kmalloc_large_oob_rigth+0x60/0x78
at addr ffffffc06516a00a
Write of size 1 by task swapper/0/1
page:ffffffbdc3945a00 count:1 mapcount:0 mapping:          (null) index:0x0
flags: 0x4000(head)
page dumped because: kasan: bad access detected
CPU: 2 PID: 1 Comm: swapper/0 Tainted: G    B           4.1.0-rc4+ #9
Hardware name: ARM Juno development board (r0) (DT)
Call trace:
[<ffffffc00008aea8>] dump_backtrace+0x0/0x15c
[<ffffffc00008b014>] show_stack+0x10/0x1c
[<ffffffc00080997c>] dump_stack+0xac/0x104
[<ffffffc0001ea4d8>] kasan_report_error+0x3e4/0x400
[<ffffffc0001ea5dc>] kasan_report+0x40/0x4c
[<ffffffc0001e9a8c>] __asan_store1+0x70/0x78
[<ffffffc000a5ae78>] kmalloc_large_oob_rigth+0x5c/0x78
[<ffffffc000a5b6c0>] kmalloc_tests_init+0x14/0x4c
[<ffffffc000082940>] do_one_initcall+0xa0/0x1f4
[<ffffffc000a3bdbc>] kernel_init_freeable+0x1ec/0x294
[<ffffffc000804c5c>] kernel_init+0xc/0xec
Memory state around the buggy address:
 ffffffc065169f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffc065169f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffffc06516a000: 00 02 fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                      ^
 ffffffc06516a080: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffffffc06516a100: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================
kasan test: kmalloc_oob_krealloc_more out-of-bounds after krealloc more
==================================================================
BUG: KASan: out of bounds access in
kmalloc_oob_krealloc_more+0xa0/0xc0 at addr ffffffc06501cd93
Write of size 1 by task swapper/0/1
=============================================================================
BUG kmalloc-64 (Tainted: G    B          ): kasan: bad access detected
-----------------------------------------------------------------------------

INFO: Allocated in kmalloc_oob_krealloc_more+0x48/0xc0 age=4 cpu=2 pid=1
        alloc_debug_processing+0x170/0x17c
        __slab_alloc.isra.59.constprop.61+0x34c/0x36c
        kmem_cache_alloc+0x1a4/0x1e0
        kmalloc_oob_krealloc_more+0x44/0xc0
        kmalloc_tests_init+0x18/0x4c
        do_one_initcall+0xa0/0x1f4
        kernel_init_freeable+0x1ec/0x294
        kernel_init+0xc/0xec
        ret_from_fork+0xc/0x50
INFO: Slab 0xffffffbdc3940700 objects=21 used=19 fp=0xffffffc06501d080
flags=0x4080
INFO: Object 0xffffffc06501cd80 @offset=3456 fp=0xffffffc06501cf00

Bytes b4 ffffffc06501cd70: 00 08 00 00 08 08 01 01 00 00 00 00 02 10
00 00  ................
Object ffffffc06501cd80: 00 cf 01 65 c0 ff ff ff 01 04 0c 00 01 04 10
c1  ...e............
Object ffffffc06501cd90: 00 82 60 28 58 01 04 43 98 48 48 24 01 81 b4
40  ..`(X..C.HH$...@
Object ffffffc06501cda0: 00 80 09 0a 69 a1 3d 82 08 01 34 65 21 31 b0
00  ....i.=...4e!1..
Object ffffffc06501cdb0: 04 42 4d a7 10 26 18 52 27 23 c2 1e 08 01 40
81  .BM..&.R'#.... at .
Padding ffffffc06501cef0: 81 20 00 50 00 08 00 0b 00 0c 50 40 01 48 40
42  . .P......P at .H@B
CPU: 2 PID: 1 Comm: swapper/0 Tainted: G    B           4.1.0-rc4+ #9
Hardware name: ARM Juno development board (r0) (DT)
Call trace:
[<ffffffc00008aea8>] dump_backtrace+0x0/0x15c
[<ffffffc00008b014>] show_stack+0x10/0x1c
[<ffffffc00080997c>] dump_stack+0xac/0x104
[<ffffffc0001e3940>] print_trailer+0xdc/0x140
[<ffffffc0001e8384>] object_err+0x38/0x4c
[<ffffffc0001ea2a4>] kasan_report_error+0x1b0/0x400
[<ffffffc0001ea5dc>] kasan_report+0x40/0x4c
[<ffffffc0001e9a8c>] __asan_store1+0x70/0x78
[<ffffffc000a5b3a4>] kmalloc_oob_krealloc_more+0x9c/0xc0
[<ffffffc000a5b6c4>] kmalloc_tests_init+0x18/0x4c
[<ffffffc000082940>] do_one_initcall+0xa0/0x1f4
[<ffffffc000a3bdbc>] kernel_init_freeable+0x1ec/0x294
[<ffffffc000804c5c>] kernel_init+0xc/0xec
Memory state around the buggy address:
 ffffffc06501cc80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffffffc06501cd00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffffffc06501cd80: 00 00 03 fc fc fc fc fc fc fc fc fc fc fc fc fc
                         ^
 ffffffc06501ce00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffffffc06501ce80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

(etc)

This is how it should look I guess, so:
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Now I have to fix all the naturally occuring KASan OOB bugs
that started to appear in my boot crawl :O

Yours,
Linus Walleij
