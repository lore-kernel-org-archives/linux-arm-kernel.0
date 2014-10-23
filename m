From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 23 Oct 2014 13:57:33 +0300
Subject: Koelsch boot broken on 3.18-rc1 ?
In-Reply-To: <10893192.WlcHQvfHhT@avalon>
References: <10893192.WlcHQvfHhT@avalon>
Message-ID: <2518560.zidYLyznbr@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(And, while at it, CC'ing Marek and LAKML)

On Thursday 23 October 2014 13:53:03 Laurent Pinchart wrote:
> Hello,
> 
> While rebasing my rcar-dmac patches on top of 3.18-rc1 I ran into issues
> booting the Koelsch board.
> 
> Bisecting the problem pointed to
> 
> commit 95b0e655f9148881907fdbe5baba6a9f5d094fee
> Author: Marek Szyprowski <m.szyprowski@samsung.com>
> Date:   Thu Oct 9 15:26:49 2014 -0700
> 
>     ARM: mm: don't limit default CMA region only to low memory
> 
> With LPAE enabled this results in the sh-eth driver failing with
> 
> [    1.170000] irq 194: nobody cared (try booting with the "irqpoll" option)
> 
> and from time to time with an Address Error message as well (which got
> pushed out of my console log, I'll try to reproduce that again to get the
> exact message).
> 
> I then tried to disable LPAE, and got greeted by the following oops.
> 
> [    0.210000] Unable to handle kernel NULL pointer dereference at virtual
> address 00000000
> [    0.220000] pgd = c0004000
> [    0.220000] [00000000] *pgd=00000000
> [    0.220000] Internal error: Oops: 805 [#1] SMP ARM
> [    0.220000] Modules linked in:
> [    0.220000] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 3.17.0-05652-g0d2ac24-dirty #2697
> [    0.220000] task: eb03eb80 ti: eb05e000 task.ti: eb05e000
> [    0.220000] PC is at __mutex_lock_slowpath+0xb0/0x278
> [    0.220000] LR is at __mutex_lock_slowpath+0x84/0x278
> [    0.220000] pc : [<c033932c>]    lr : [<c0339300>]    psr: a0000113
> [    0.220000] sp : eb05fdb0  ip : eb05fdb0  fp : eb05fdec
> [    0.220000] r10: 00000002  r9 : c06ce53c  r8 : c06ce538
> [    0.220000] r7 : eb03eb80  r6 : ffffffff  r5 : eb05e000  r4 : c06ce534
> [    0.220000] r3 : 00000000  r2 : eb05fdb4  r1 : 00000000  r0 : c06ce538
> [    0.220000] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment
> kernel
> [    0.220000] Control: 10c5387d  Table: 4000406a  DAC: 00000015
> [    0.220000] Process swapper/0 (pid: 1, stack limit = 0xeb05e240)
> [    0.220000] Stack: (0xeb05fdb0 to 0xeb060000)
> [    0.220000] fda0:                                     eb137b00 c06ce53c
> 00000000 eb05fdc8
> [    0.220000] fdc0: c01840a0 c06ce534 c049a518 00000040 eb05fe9c 00000040
> 00000000 00004000
> [    0.220000] fde0: eb05fe04 eb05fdf0 c033955c c0339288 00000000 c06ce524
> eb05fe4c eb05fe08
> [    0.220000] fe00: c00c738c c0339500 eb05fe64 eb05fe18 c0183c38 0000003f
> 00000040 c06ce534
> [    0.220000] fe20: ffffffff 00040000 c049a518 00000040 eb05fe9c 00000000
> 00000000 00000647
> [    0.220000] fe40: eb05fe5c eb05fe50 c01f4390 c00c72b8 eb05fe8c eb05fe60
> c0016b78 c01f4360
> [    0.220000] fe60: eb137b00 0000005e 00000647 c049a518 eb137b00 0000005e
> c045da48 eb05e000
> [    0.220000] fe80: eb05febc eb05fe90 c045dab4 c0016b48 c045da48 c018632c
> 00000000 c049a518
> [    0.220000] fea0: c049a518 c049a518 c049a518 eb137b00 eb05ff54 eb05fec0
> c000979c c045da54
> [    0.220000] fec0: 0000019f 00000000 00000000 00000000 eb05fefc 00000001
> c011a9fc c04a435c
> [    0.220000] fee0: eb05ff0c eb05fef0 eb05ff0c eb05fef8 c045a5ec ebfffc7f
> c03503c8 0000005e
> [    0.220000] ff00: eb05ff54 eb05ff10 c003b978 c045a5f8 eb05ff34 00000002 
ebfffc8a 00000002
> [    0.220000] ff20: c0457be4 c03fada4 eb05ff54 c048ccf4 00000002 c04c2000
> 0000005e c045a5ec
> [    0.220000] ff40: c0484598 c04845b4 eb05ff94 eb05ff58 c045ad9c c0009720
> 00000002 00000002
> [    0.220000] ff60: c045a5ec d219cae9 55325c9a c04c2000 c03330fc 00000000 
00000000 00000000
> [    0.220000] ff80: 00000000 00000000 eb05ffac eb05ff98 c0333110 c045aca4
> 00000000 00000000
> [    0.220000] ffa0: 00000000 eb05ffb0 c000f9b8 c0333108 00000000 00000000
> 00000000 00000000
> [    0.220000] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000
> [    0.220000] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
> 01942251 7964e304
> [    0.220000]
> Backtrace:
> [    0.220000] [<c033927c>] (__mutex_lock_slowpath) from [<c033955c>]
> (mutex_lock+0x68/0x70)
> [    0.220000]  r10:00004000 r9:00000000 r8:00000040 r7:eb05fe9c r6:00000040
> r5:c049a518
> [    0.220000]  r4:c06ce534
> [    0.220000] [<c03394f4>] (mutex_lock) from [<c00c738c>]
> (cma_alloc+0xe0/0x15c)
> [    0.220000]  r4:c06ce524 r3:00000000
> [    0.220000] [<c00c72ac>] (cma_alloc) from [<c01f4390>]
> (dma_alloc_from_contiguous+0x3c/0x44)
> [    0.220000]  r10:00000647 r9:00000000 r8:00000000 r7:eb05fe9c r6:00000040
> r5:c049a518
> [    0.220000]  r4:00040000
> [    0.220000] [<c01f4354>] (dma_alloc_from_contiguous) from [<c0016b78>]
> (__alloc_from_contiguous+0x3c/0xe8)
> [    0.220000] [<c0016b3c>] (__alloc_from_contiguous) from [<c045dab4>]
> (atomic_pool_init+0x6c/0x158)
> [    0.220000]  r10:eb05e000 r8:c045da48 r7:0000005e r6:eb137b00 r5:c049a518
> r4:00000647
> [    0.220000] [<c045da48>] (atomic_pool_init) from [<c000979c>]
> (do_one_initcall+0x88/0x1cc)
> [    0.220000]  r6:eb137b00 r5:c049a518 r4:c049a518
> [    0.220000] [<c0009714>] (do_one_initcall) from [<c045ad9c>]
> (kernel_init_freeable+0x104/0x1d0)
> [    0.220000]  r10:c04845b4 r9:c0484598 r8:c045a5ec r7:0000005e r6:c04c2000
> r5:00000002
> [    0.220000]  r4:c048ccf4
> [    0.220000] [<c045ac98>] (kernel_init_freeable) from [<c0333110>]
> (kernel_init+0x14/0xf4)
> [    0.220000]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000
> r5:c03330fc
> [    0.220000]  r4:c04c2000
> [    0.220000] [<c03330fc>] (kernel_init) from [<c000f9b8>]
> (ret_from_fork+0x14/0x3c)
> [    0.220000]  r4:00000000 r3:00000000
> [    0.220000] Code: e50b9038 e3e06000 e50b3034 e3a0a002 (e5832000)
> [    0.230000] ---[ end trace b5eab08126729646 ]---
> 
> This is likely related to a failure earlier in the boot process:
> 
> [    0.000000] cma: Reserved 256 MiB at 70000000
> [    0.000000] cma: Reserved 64 MiB at 6c000000
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] BUG: mapping for 0xe6e60000 at 0xffe60000 out of vmalloc
> space
> 
> I'm trying to fix this now. Has anyone noticed (and possibly investigated)
> the issue ? If so please let me know to avoid duplicating efforts.

-- 
Regards,

Laurent Pinchart
