From: tony@atomide.com (Tony Lindgren)
Date: Fri, 29 Apr 2011 04:57:44 -0700
Subject: [patch 07/16] arm: omap: Use clocksource based sched_clock
In-Reply-To: <20110423205132.221790438@linutronix.de>
References: <20110423205036.795894921@linutronix.de>
	<20110423205132.221790438@linutronix.de>
Message-ID: <20110429115744.GZ3755@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thomas Gleixner <tglx@linutronix.de> [110423 13:51]:
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/arm/mach-omap1/time.c               |   62 +--------------------------
>  arch/arm/mach-omap2/timer-gp.c           |   17 -------
>  arch/arm/plat-omap/counter_32k.c         |   71 ++-----------------------------
>  arch/arm/plat-omap/dmtimer.c             |    4 -
>  arch/arm/plat-omap/include/plat/common.h |    1 
>  5 files changed, 13 insertions(+), 142 deletions(-)

This one needs the following patch to compile. Also, this
fails with following, probably because the clocks are not
set up at that point.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 80000005 [#1] SMP
last sysfs file: 
Modules linked in:
CPU: 0    Not tainted  (2.6.39-rc5-00081-gc3dec8c #166)
PC is at 0x0
LR is at read_persistent_clock+0x24/0xb4
pc : [<00000000>]    lr : [<c007f86c>]    psr: 600001d3
sp : c05a3fa8  ip : c05a2000  fp : 00000000
r10: 00000000  r9 : 411fc092  r8 : 80000000
r7 : c05bc144  r6 : c05a3fc0  r5 : c0624bf4  r4 : c05f9120
r3 : 00000000  r2 : 00000001  r1 : c009bb24  r0 : c05f9120
Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7f  Table: 8000404a  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc05a22f8)
Stack: (0xc05a3fa8 to 0xc05a4000)
3fa0:                   c0035d3c 00000001 c0623bc0 c001ce10 00000000 00000001
3fc0: 00000000 c0400a48 c0035d3c c0035d3c 00000001 c0008a04 c0008640 00000870
3fe0: 80000100 c0035d3c 10c53c7d c05b78dc c0035d0c 8000803c 00000000 00000000
[<c007f86c>] (read_persistent_clock+0x24/0xb4) from [<c001ce10>] (timekeeping_init+0x10/0x114)
[<c001ce10>] (timekeeping_init+0x10/0x114) from [<c0008a04>] (start_kernel+0x188/0x2ec)
[<c0008a04>] (start_kernel+0x188/0x2ec) from [<8000803c>] (0x8000803c)
Code: bad PC value
---[ end trace 1b75b31a2719ed1c ]---

The generic code should probably just return 0 until the clocks are
initialized. Or do you have some other solution for that in mind?

Tony


--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -139,8 +139,6 @@ int __init omap_init_clocksource_32k(void)
 		if (!IS_ERR(sync_32k_ick))
 			clk_enable(sync_32k_ick);
 
-		offset_32k = clocksource_32k.read(&clocksource_32k);
-
 		if (clocksource_register_hz(&clocksource_32k, 32768))
 			printk(err, clocksource_32k.name);
 	}
