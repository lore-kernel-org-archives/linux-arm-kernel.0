From: yoshihiro.shimoda.uh@renesas.com (Yoshihiro Shimoda)
Date: Wed, 30 Sep 2015 09:06:45 +0000
Subject: [PATCH 30/31] ARM: shmobile: r8a7791: add USB-DMAC device nodes
In-Reply-To: <560B11FF.3010305@cogentembedded.com>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
 <e3e25edc1116ebf44b1813aff03b02b7737d41ca.1431565427.git.horms+renesas@verge.net.au>
 <560B11FF.3010305@cogentembedded.com>
Message-ID: <SG2PR06MB0919932925BB68EC82538044D84D0@SG2PR06MB0919.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

> Sent: Wednesday, September 30, 2015 7:35 AM
> 
> Hello!
> 
> On 05/14/2015 04:06 AM, Simon Horman wrote:
> 
> > From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >   arch/arm/boot/dts/r8a7791.dtsi | 22 ++++++++++++++++++++++
> >   1 file changed, 22 insertions(+)
> 
>     When the USB-DMAC driver is enabled, this causes kernel oops on at least
> the R8A7791 Henninger/Porter boards (haven't checked the others yet) with
> renesas-devel-20150928-v4.3-rc3 and even earlier tag. The oops can only be
> seen with the earlyprintk=serial kernel parameter, otherwise the kernel just
> hangs with a blank console.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000014
> SuperH (H)SCI(F) driver initialized
> e6e60000.serial: ttySC0 at MMIO 0xe6e60000 (irq = 105, base_baud = 0) is a scif
> pgd = c0004000
> [00000014] *pgd=00000000
> Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 0 PID: 47 Comm: kworker/0:1 Not tainted 4.3.0-rc3-dirty #936
> Hardware name: Generic R8A7791 (Flattened Device Tree)
> Workqueue: pm pm_runtime_work
> task: ee933100 ti: ee998000 task.ti: ee998000
> PC is at usb_dmac_chan_halt+0x14/0xd0
> LR is at usb_dmac_runtime_suspend+0x2c/0x40
> pc : [<c027f0e0>]    lr : [<c027f1c8>]    psr: 80000113
> sp : ee999da8  ip : ee999dc0  fp : ee999dbc
> r10: ee802400  r9 : c02dcb18  r8 : ee93d810
> r7 : 6bd8a034  r6 : 00000090  r5 : eebd1210  r4 : 00000001
> r3 : 00000000  r2 : 6bd8a034  r1 : 0000012e  r0 : eebd1210
> Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 4000406a  DAC: 00000051
> Process kworker/0:1 (pid: 47, stack limit = 0xee998210)
> Stack: (0xee999da8 to 0xee99a000)
> 9da0:                   00000001 eebdaf50 ee999ddc ee999dc0 c027f1c8 c027f0d8
> 9dc0: c027f19c ee93d810 c02ddfc4 00000000 ee999dec ee999de0 c02d60e0 c027f1a8
> 9de0: ee999dfc ee999df0 c02dcba0 c02d60b8 ee999e34 ee999e00 c02de040 c02dcb24
> 9e00: 6bd8a034 00000000 00000000 ee93d810 c02ddfc4 00000000 0000000a 00000000
> 9e20: 00000003 00000008 ee999e4c ee999e38 c02d78cc c02ddfd0 ee93d810 c02ddfc4
> 9e40: ee999e64 ee999e50 c02d7964 c02d78a0 ee93d810 c02ddfc4 ee999eb4 ee999e68
> 9e60: c02d7ee4 c02d7900 ee999e84 ee999e80 c0531e44 c0045518 ee999eb4 ee999e88
> 9e80: c005a1d8 c0531e20 00000000 ee93d810 00000000 00000002 c0726100 eefc9700
> 9ea0: 00000000 00000000 ee999ed4 ee999eb8 c02d813c c02d7cd0 00000000 ee93d8b8
> 9ec0: ee93d874 eefc3700 ee999eec ee999ed8 c02d8c84 c02d80d0 ee938000 ee93d8b8
> 9ee0: ee999f2c ee999ef0 c003c13c c02d8c28 ee999f14 ee999f00 c004827c c0048174
> 9f00: 00000000 ee938000 eefc3700 eefc3714 c0726100 ee938018 00000008 00000000
> 9f20: ee999f5c ee999f30 c003c554 c003bf90 ee933100 ee9065c0 00000000 ee938000
> 9f40: c003c2c0 00000000 00000000 00000000 ee999fac ee999f60 c0040e24 c003c2cc
> 9f60: fffefffa 00000000 febbfffa ee938000 00000000 00000000 ee999f78 ee999f78
> 9f80: 00000000 00000000 ee999f88 ee999f88 ee9065c0 c0040d34 00000000 00000000
> 9fa0: 00000000 ee999fb0 c00105d8 c0040d40 00000000 00000000 00000000 00000000
> 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 ddffddfa dff45ff7
> Backtrace:
> [<c027f0cc>] (usb_dmac_chan_halt) from [<c027f1c8>] (usb_dmac_runtime_suspend+0)
>   r5:eebdaf50 r4:00000001
> [<c027f19c>] (usb_dmac_runtime_suspend) from [<c02d60e0>] (pm_generic_runtime_s)
>   r6:00000000 r5:c02ddfc4 r4:ee93d810 r3:c027f19c
> [<c02d60ac>] (pm_generic_runtime_suspend) from [<c02dcba0>] (pm_genpd_default_s)
> [<c02dcb18>] (pm_genpd_default_save_state) from [<c02de040>] (pm_genpd_runtime_)
> [<c02ddfc4>] (pm_genpd_runtime_suspend) from [<c02d78cc>] (__rpm_callback+0x38/)
>   r10:00000008 r9:00000003 r8:00000000 r7:0000000a r6:00000000 r5:c02ddfc4
>   r4:ee93d810
> [<c02d7894>] (__rpm_callback) from [<c02d7964>] (rpm_callback+0x70/0x88)
>   r5:c02ddfc4 r4:ee93d810
> [<c02d78f4>] (rpm_callback) from [<c02d7ee4>] (rpm_suspend+0x220/0x38c)
>   r5:c02ddfc4 r4:ee93d810
> [<c02d7cc4>] (rpm_suspend) from [<c02d813c>] (rpm_idle+0x78/0x128)
>   r10:00000000 r9:00000000 r8:eefc9700 r7:c0726100 r6:00000002 r5:00000000
>   r4:ee93d810

I'm not sure but I am guessing this issue related runtime PM? (suspend)
I checked the usb-dmac driver roughly, and if the usb_dmac_runtime_suspend()
is called before usb_dmac_chan_probe() runs, it might happen because dmac->iomem is NULL.

What do you think?

Best regards,
Yoshihiro Shimoda

> [<c02d80c4>] (rpm_idle) from [<c02d8c84>] (pm_runtime_work+0x68/0x94)
>   r6:eefc3700 r5:ee93d874 r4:ee93d8b8 r3:00000000
> [<c02d8c1c>] (pm_runtime_work) from [<c003c13c>] (process_one_work+0x1b8/0x308)
>   r5:ee93d8b8 r4:ee938000



> [<c003bf84>] (process_one_work) from [<c003c554>] (worker_thread+0x294/0x408)
>   r10:00000000 r9:00000008 r8:ee938018 r7:c0726100 r6:eefc3714 r5:eefc3700
>   r4:ee938000
> [<c003c2c0>] (worker_thread) from [<c0040e24>] (kthread+0xf0/0x104)
>   r10:00000000 r9:00000000 r8:00000000 r7:c003c2c0 r6:ee938000 r5:00000000
>   r4:ee9065c0 r3:ee933100
> [<c0040d34>] (kthread) from [<c00105d8>] (ret_from_fork+0x14/0x3c)
>   r7:00000000 r6:00000000 r5:c0040d34 r4:ee9065c0
> Code: e92dd830 e24cb004 e590306c e1a05000 (e5934014)
> console [ttySC0] enabled
> console [ttySC0] enabled
> bootconsole [earlycon0] disabled
> bootconsole [earlycon0] disabled
> [drm] Initialized drm 1.1.0 20060810
> ---[ end trace ef953a249b09c4af ]---
> Unable to handle kernel paging request at virtual address ffffffec
> pgd = c0004000
> [ffffffec] *pgd=6f7fd861, *pte=00000000, *ppte=00000000
> Internal error: Oops: 37 [#2] PREEMPT SMP ARM
> Modules linked in:
> CPU: 0 PID: 47 Comm: kworker/0:1 Tainted: G      D         4.3.0-rc3-dirty #936
> Hardware name: Generic R8A7791 (Flattened Device Tree)
> task: ee933100 ti: ee998000 task.ti: ee998000
> PC is at kthread_data+0x10/0x18
> LR is at wq_worker_sleeping+0x14/0xd8
> pc : [<c0041438>]    lr : [<c003cbb4>]    psr: 00000193
> sp : ee999b08  ip : ee999b18  fp : ee999b14
> r10: ee933320  r9 : c0650b95  r8 : c052ea2c
> r7 : ee9333a8  r6 : 00000000  r5 : eefc3b80  r4 : 00000000
> r3 : 00000000  r2 : ac9a9d49  r1 : 00000000  r0 : ee933100
> Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 4000406a  DAC: 00000051
> Process kworker/0:1 (pid: 47, stack limit = 0xee998210)
> Stack: (0xee999b08 to 0xee99a000)
> 9b00:                   ee999b2c ee999b18 c003cbb4 c0041434 0420806c ee933100
> 9b20: ee999b6c ee999b30 c052e428 c003cbac c001296c c001353c 00000000 c0013ed4
> 9b40: ee999b64 ee933100 ee999b88 ee99994c c027f0e0 00000001 c0650b95 ee933320
> 9b60: ee999b7c ee999b70 c052ea2c c052e350 ee999ba4 ee999b80 c0029a48 c052e998
> 9b80: ee999bf2 c027f0e0 ee999b88 ee999b88 c0026f30 c027f0e0 ee999c24 ee999ba8
> 9ba0: c0013ed4 c002921c ee998210 0000000b ee999bd4 c0650b8d 60000113 00000000
> 9bc0: 65650dcb 64643239 20303338 63343265 34303062 39356520 36303330 31652063
> 9be0: 30353061 28203030 33393565 34313034 c0002029 c009c594 c0650dcb 00000014
> 9c00: 00000005 00000000 ee999d58 00000000 c02dcb18 00000005 ee999c3c ee999c28
> 9c20: c00212b0 c0013b24 ee999d58 ee933100 ee999c8c ee999c40 c001cd58 c0021260
> 9c40: c065a8e2 ef5cf060 ee999c84 ee999c58 c001296c c001353c 00000000 c00a42a8
> 9c60: ee999c84 00000005 00000014 c0729fa4 00000005 ee93d810 c02dcb18 ee802400
> 9c80: ee999cac ee999c90 c001ce7c c001cab0 00000005 00000014 c0729fa4 ee999d58
> 9ca0: ee999d54 ee999cb0 c000a2bc c001ce64 ee999d3c ee999cc0 c00a42bc c001f4c0
> 9cc0: 00000141 fec334d1 effd3bb9 d17b5fc0 00000000 ee8333fc ee999cfc ee999ce8
> 9ce0: ee999cfc fffffffa 00000001 c07246ae ee999d1c ee999d00 c0013554 c0012904
> 9d00: c0012928 00000000 ee999da8 00000000 ee999d4c ee999d20 c001296c c001353c
> 9d20: 00000000 c052adc8 ee999d4c ee999d38 c004817c c005d66c c027f0e0 80000113
> 9d40: ffffffff ee999d8c ee999dbc ee999d58 c0014620 c000a28c eebd1210 0000012e
> 9d60: 6bd8a034 00000000 00000001 eebd1210 00000090 6bd8a034 ee93d810 c02dcb18
> 9d80: ee802400 ee999dbc ee999dc0 ee999da8 c027f1c8 c027f0e0 80000113 ffffffff
> 9da0: 00000051 c052b038 00000001 eebdaf50 ee999ddc ee999dc0 c027f1c8 c027f0d8
> 9dc0: c027f19c ee93d810 c02ddfc4 00000000 ee999dec ee999de0 c02d60e0 c027f1a8
> 9de0: ee999dfc ee999df0 c02dcba0 c02d60b8 ee999e34 ee999e00 c02de040 c02dcb24
> 9e00: 6bd8a034 00000000 00000000 ee93d810 c02ddfc4 00000000 0000000a 00000000
> 9e20: 00000003 00000008 ee999e4c ee999e38 c02d78cc c02ddfd0 ee93d810 c02ddfc4
> 9e40: ee999e64 ee999e50 c02d7964 c02d78a0 ee93d810 c02ddfc4 ee999eb4 ee999e68
> 9e60: c02d7ee4 c02d7900 ee999e84 ee999e80 c0531e44 c0045518 ee999eb4 ee999e88
> 9e80: c005a1d8 c0531e20 00000000 ee93d810 00000000 00000002 c0726100 eefc9700
> 9ea0: 00000000 00000000 ee999ed4 ee999eb8 c02d813c c02d7cd0 00000000 ee93d8b8
> 9ec0: ee93d874 eefc3700 ee999eec ee999ed8 c02d8c84 c02d80d0 ee938000 ee93d8b8
> 9ee0: ee999f2c ee999ef0 c003c13c c02d8c28 ee999f14 ee999f00 c004827c c0048174
> 9f00: 00000000 ee938000 eefc3700 eefc3714 c0726100 ee938018 00000008 00000000
> 9f20: ee999f5c ee999f30 c003c554 c003bf90 ee933100 ee9065c0 00000000 ee938000
> 9f40: c003c2c0 00000000 00000000 00000000 ee999fac ee999f60 c0040e24 c003c2cc
> 9f60: fffefffa 00000000 febbfffa ee938000 00000000 00000000 ee999f78 ee999f78
> 9f80: 00000001 00010001 ee999f88 ee999f88 ee9065c0 c0040d34 00000000 00000000
> 9fa0: 00000000 ee999fb0 c00105d8 c0040d40 00000000 00000000 00000000 00000000
> 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 ddffddfa dff45ff7
> Backtrace:
> [<c0041428>] (kthread_data) from [<c003cbb4>] (wq_worker_sleeping+0x14/0xd8)
> [<c003cba0>] (wq_worker_sleeping) from [<c052e428>] (__schedule+0xe4/0x4b0)
>   r4:ee933100 r3:0420806c
> [<c052e344>] (__schedule) from [<c052ea2c>] (schedule+0xa0/0xc4)
>   r10:ee933320 r9:c0650b95 r8:00000001 r7:c027f0e0 r6:ee99994c r5:ee999b88
>   r4:ee933100
> [<c052e98c>] (schedule) from [<c0029a48>] (do_exit+0x838/0x880)
> [<c0029210>] (do_exit) from [<c0013ed4>] (die+0x3bc/0x438)
>   r7:c027f0e0
> [<c0013b18>] (die) from [<c00212b0>] (__do_kernel_fault.part.0+0x5c/0xdac)
>   r10:00000005 r9:c02dcb18 r8:00000000 r7:ee999d58 r6:00000000 r5:00000005
>   r4:00000014
> [<c0021254>] (__do_kernel_fault.part.0) from [<c001cd58>] (do_page_fault+0x2b4/)
>   r7:ee933100 r3:ee999d58
> [<c001caa4>] (do_page_fault) from [<c001ce7c>] (do_translation_fault+0x24/0xb4)
>   r10:ee802400 r9:c02dcb18 r8:ee93d810 r7:00000005 r6:c0729fa4 r5:00000014
>   r4:00000005
> [<c001ce58>] (do_translation_fault) from [<c000a2bc>] (do_DataAbort+0x3c/0xbc)
>   r7:ee999d58 r6:c0729fa4 r5:00000014 r4:00000005
> [<c000a280>] (do_DataAbort) from [<c0014620>] (__dabt_svc+0x40/0x60)
> Exception stack(0xee999d58 to 0xee999da0)
> 9d40:                                                       eebd1210 0000012e
> 9d60: 6bd8a034 00000000 00000001 eebd1210 00000090 6bd8a034 ee93d810 c02dcb18
> 9d80: ee802400 ee999dbc ee999dc0 ee999da8 c027f1c8 c027f0e0 80000113 ffffffff
>   r7:ee999d8c r6:ffffffff r5:80000113 r4:c027f0e0
> [<c027f0cc>] (usb_dmac_chan_halt) from [<c027f1c8>] (usb_dmac_runtime_suspend+0)
>   r5:eebdaf50 r4:00000001
> [<c027f19c>] (usb_dmac_runtime_suspend) from [<c02d60e0>] (pm_generic_runtime_s)
>   r6:00000000 r5:c02ddfc4 r4:ee93d810 r3:c027f19c
> [<c02d60ac>] (pm_generic_runtime_suspend) from [<c02dcba0>] (pm_genpd_default_s)
> [<c02dcb18>] (pm_genpd_default_save_state) from [<c02de040>] (pm_genpd_runtime_)
> [<c02ddfc4>] (pm_genpd_runtime_suspend) from [<c02d78cc>] (__rpm_callback+0x38/)
>   r10:00000008 r9:00000003 r8:00000000 r7:0000000a r6:00000000 r5:c02ddfc4
>   r4:ee93d810
> [<c02d7894>] (__rpm_callback) from [<c02d7964>] (rpm_callback+0x70/0x88)
>   r5:c02ddfc4 r4:ee93d810
> [<c02d78f4>] (rpm_callback) from [<c02d7ee4>] (rpm_suspend+0x220/0x38c)
>   r5:c02ddfc4 r4:ee93d810
> [<c02d7cc4>] (rpm_suspend) from [<c02d813c>] (rpm_idle+0x78/0x128)
>   r10:00000000 r9:00000000 r8:eefc9700 r7:c0726100 r6:00000002 r5:00000000
>   r4:ee93d810
> [<c02d80c4>] (rpm_idle) from [<c02d8c84>] (pm_runtime_work+0x68/0x94)
>   r6:eefc3700 r5:ee93d874 r4:ee93d8b8 r3:00000000
> [<c02d8c1c>] (pm_runtime_work) from [<c003c13c>] (process_one_work+0x1b8/0x308)
>   r5:ee93d8b8 r4:ee938000
> [<c003bf84>] (process_one_work) from [<c003c554>] (worker_thread+0x294/0x408)
>   r10:00000000 r9:00000008 r8:ee938018 r7:c0726100 r6:eefc3714 r5:eefc3700
>   r4:ee938000
> [<c003c2c0>] (worker_thread) from [<c0040e24>] (kthread+0xf0/0x104)
>   r10:00000000 r9:00000000 r8:00000000 r7:c003c2c0 r6:ee938000 r5:00000000
>   r4:ee9065c0 r3:ee933100
> [<c0040d34>] (kthread) from [<c00105d8>] (ret_from_fork+0x14/0x3c)
>   r7:00000000 r6:00000000 r5:c0040d34 r4:ee9065c0
> Code: e1a0c00d e92dd800 e24cb004 e5903278 (e5130014)
> ---[ end trace ef953a249b09c4b0 ]---
> Fixing recursive fault but reboot is needed!
> 
> MBR, Sergei
