From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 14 May 2012 18:39:47 +1000
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20120514183947.58e82b8bff52d7f0476dfc11@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/plat-omap/counter_32k.c between commit bd0493eaaf5c ("ARM:
7413/1: move read_{boot,persistent}_clock to the architecture level")
from the arm tree and commit 1fe97c8f6a1d ("ARM: OMAP: Make OMAP
clocksource source selection using kernel param") from the arm-soc tree.

I attempted to fix it up (see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/plat-omap/counter_32k.c
index 44ae077,b2f634b..0000000
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@@ -69,55 -69,40 +70,41 @@@ static void omap_read_persistent_clock(
  	*ts = *tsp;
  }
  
- int __init omap_init_clocksource_32k(void)
+ /**
+  * omap_init_clocksource_32k - setup and register counter 32k as a
+  * kernel clocksource
+  * @pbase: base addr of counter_32k module
+  * @size: size of counter_32k to map
+  *
+  * Returns 0 upon success or negative error code upon failure.
+  *
+  */
+ int __init omap_init_clocksource_32k(void __iomem *vbase)
  {
- 	static char err[] __initdata = KERN_ERR
- 			"%s: can't register clocksource!\n";
- 
- 	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
- 		u32 pbase;
- 		unsigned long size = SZ_4K;
- 		void __iomem *base;
- 		struct clk *sync_32k_ick;
- 
- 		if (cpu_is_omap16xx()) {
- 			pbase = OMAP16XX_TIMER_32K_SYNCHRONIZED;
- 			size = SZ_1K;
- 		} else if (cpu_is_omap2420())
- 			pbase = OMAP2420_32KSYNCT_BASE + 0x10;
- 		else if (cpu_is_omap2430())
- 			pbase = OMAP2430_32KSYNCT_BASE + 0x10;
- 		else if (cpu_is_omap34xx())
- 			pbase = OMAP3430_32KSYNCT_BASE + 0x10;
- 		else if (cpu_is_omap44xx())
- 			pbase = OMAP4430_32KSYNCT_BASE + 0x10;
- 		else
- 			return -ENODEV;
- 
- 		/* For this to work we must have a static mapping in io.c for this area */
- 		base = ioremap(pbase, size);
- 		if (!base)
- 			return -ENODEV;
- 
- 		sync_32k_ick = clk_get(NULL, "omap_32ksync_ick");
- 		if (!IS_ERR(sync_32k_ick))
- 			clk_enable(sync_32k_ick);
- 
- 		timer_32k_base = base;
- 
- 		/*
- 		 * 120000 rough estimate from the calculations in
- 		 * __clocksource_updatefreq_scale.
- 		 */
- 		clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
- 				32768, NSEC_PER_SEC, 120000);
- 
- 		if (clocksource_mmio_init(base, "32k_counter", 32768, 250, 32,
- 					  clocksource_mmio_readl_up))
- 			printk(err, "32k_counter");
- 
- 		setup_sched_clock(omap_32k_read_sched_clock, 32, 32768);
- 		register_persistent_clock(NULL, omap_read_persistent_clock);
+ 	int ret;
+ 
+ 	/*
+ 	 * 32k sync Counter register offset is at 0x10
+ 	 */
+ 	sync32k_cnt_reg = vbase + OMAP2_32KSYNCNT_CR_OFF;
+ 
+ 	/*
+ 	 * 120000 rough estimate from the calculations in
+ 	 * __clocksource_updatefreq_scale.
+ 	 */
+ 	clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
+ 			32768, NSEC_PER_SEC, 120000);
+ 
+ 	ret = clocksource_mmio_init(sync32k_cnt_reg, "32k_counter", 32768,
+ 				250, 32, clocksource_mmio_readl_up);
+ 	if (ret) {
+ 		pr_err("32k_counter: can't register clocksource\n");
+ 		return ret;
  	}
+ 
+ 	setup_sched_clock(omap_32k_read_sched_clock, 32, 32768);
++	register_persistent_clock(NULL, omap_read_persistent_clock);
+ 	pr_info("OMAP clocksource: 32k_counter at 32768 Hz\n");
+ 
  	return 0;
  }
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120514/8f9c7194/attachment.sig>
