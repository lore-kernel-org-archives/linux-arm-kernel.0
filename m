From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 22:19:53 +0200
Subject: [GIT PULL 02/10] 2nd irq-s3c24xx for v3.10
In-Reply-To: <516309D9.7000609@samsung.com>
References: <516309D9.7000609@samsung.com>
Message-ID: <201304092219.54078.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 April 2013, Kukjin Kim wrote:
> s3c24xx irq cleanup and move into drivers/irqchip

I had a little trouble applying this because of the interface change to
CLOCKSOURCE_OF_DECLARE. This is the rather complex merge I did. Please
check that it still works.

	Arnd

commit 682f619ef995c6bc7e07b356451b8d762caefc5e
Merge: 894b738 354599f
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Tue Apr 9 22:07:37 2013 +0200

    Merge tag 'mct-exynos-for-v3.10' of git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung into next/drivers
    
    From Kukjin Kim <kgene.kim@samsung.com>:
    
    add support exynos mct device tree and move into drivers/clocksource
    
    * tag 'mct-exynos-for-v3.10' of git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung:
      clocksource: mct: Add terminating entry for exynos_mct_ids table
      clocksource: mct: Add missing semicolons in exynos_mct.c
      ARM: EXYNOS: move mct driver to drivers/clocksource
      ARM: EXYNOS: remove static io-remapping of mct registers for Exynos5
      ARM: dts: add mct device tree node for all supported Exynos SoC's
      ARM: EXYNOS: allow dt based discovery of mct controller using clocksource_of_init
      ARM: EXYNOS: add device tree support for MCT controller driver
      ARM: EXYNOS: prepare an array of MCT interrupt numbers and use it
      ARM: EXYNOS: add a register base address variable in mct controller driver
    
    Conflicts:
    	drivers/clocksource/Makefile
    	drivers/clocksource/exynos_mct.c
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --cc drivers/clocksource/Makefile
index e74c8ce,1c1b15d..cd1f09c
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@@ -19,7 -19,7 +19,8 @@@ obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835_t
  obj-$(CONFIG_SUNXI_TIMER)	+= sunxi_timer.o
  obj-$(CONFIG_ARCH_TEGRA)	+= tegra20_timer.o
  obj-$(CONFIG_VT8500_TIMER)	+= vt8500_timer.o
- obj-$(CONFIG_CADENCE_TTC_TIMER)		+= cadence_ttc_timer.o
++obj-$(CONFIG_CADENCE_TTC_TIMER)	+= cadence_ttc_timer.o
+ obj-$(CONFIG_CLKSRC_EXYNOS_MCT)	+= exynos_mct.o
  
  obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
  obj-$(CONFIG_CLKSRC_METAG_GENERIC)	+= metag_generic.o
diff --cc drivers/clocksource/exynos_mct.c
index c9d6650,d3f1327..957af86
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@@ -445,13 -477,17 +477,17 @@@ static struct local_timer_ops exynos4_m
  };
  #endif /* CONFIG_LOCAL_TIMERS */
  
- static void __init exynos4_timer_resources(void)
 -static void __init exynos4_timer_resources(struct device_node *np)
++static void __init exynos4_timer_resources(void __iomem *base)
  {
  	struct clk *mct_clk;
  	mct_clk = clk_get(NULL, "xtal");
  
  	clk_rate = clk_get_rate(mct_clk);
  
 -	reg_base = np ? of_iomap(np, 0) : S5P_VA_SYSTIMER;
++	reg_base = base;
+ 	if (!reg_base)
+ 		panic("%s: unable to ioremap mct address space\n", __func__);
+ 
  #ifdef CONFIG_LOCAL_TIMERS
  	if (mct_int_type == MCT_INT_PPI) {
  		int err;
@@@ -467,19 -503,49 +503,54 @@@
  #endif /* CONFIG_LOCAL_TIMERS */
  }
  
- void __init exynos4_timer_init(void)
 -static const struct of_device_id exynos_mct_ids[] = {
 -	{ .compatible = "samsung,exynos4210-mct", .data = (void *)MCT_INT_SPI },
 -	{ .compatible = "samsung,exynos4412-mct", .data = (void *)MCT_INT_PPI },
 -	{ }
 -};
 -
+ void __init mct_init(void)
  {
- 	if (soc_is_exynos5440()) {
- 		arch_timer_of_register();
- 		return;
 -	struct device_node *np = NULL;
 -	const struct of_device_id *match;
 -	u32 nr_irqs, i;
 -
 -#ifdef CONFIG_OF
 -	np = of_find_matching_node_and_match(NULL, exynos_mct_ids, &match);
 -#endif
 -	if (np) {
 -		mct_int_type = (u32)(match->data);
 -
 -		/* This driver uses only one global timer interrupt */
 -		mct_irqs[MCT_G0_IRQ] = irq_of_parse_and_map(np, MCT_G0_IRQ);
 -
 -		/*
 -		 * Find out the number of local irqs specified. The local
 -		 * timer irqs are specified after the four global timer
 -		 * irqs are specified.
 -		 */
 -#ifdef CONFIG_OF
 -		nr_irqs = of_irq_count(np);
 -#endif
 -		for (i = MCT_L0_IRQ; i < nr_irqs; i++)
 -			mct_irqs[i] = irq_of_parse_and_map(np, i);
 -	} else if (soc_is_exynos4210()) {
++	if (soc_is_exynos4210()) {
+ 		mct_irqs[MCT_G0_IRQ] = EXYNOS4_IRQ_MCT_G0;
+ 		mct_irqs[MCT_L0_IRQ] = EXYNOS4_IRQ_MCT_L0;
+ 		mct_irqs[MCT_L1_IRQ] = EXYNOS4_IRQ_MCT_L1;
+ 		mct_int_type = MCT_INT_SPI;
+ 	} else {
+ 		panic("unable to determine mct controller type\n");
  	}
  
- 	if ((soc_is_exynos4210()) || (soc_is_exynos5250()))
- 		mct_int_type = MCT_INT_SPI;
- 	else
- 		mct_int_type = MCT_INT_PPI;
 -	exynos4_timer_resources(np);
++	exynos4_timer_resources(S5P_VA_SYSTIMER);
+ 	exynos4_clocksource_init();
+ 	exynos4_clockevent_init();
+ }
 -CLOCKSOURCE_OF_DECLARE(exynos4210, "samsung,exynos4210-mct", mct_init);
 -CLOCKSOURCE_OF_DECLARE(exynos4412, "samsung,exynos4412-mct", mct_init);
 +
- 	exynos4_timer_resources();
++static void __init mct_init_dt(struct device_node *np, unsigned int int_type)
++{
++	u32 nr_irqs, i;
++
++	mct_int_type = int_type;
++
++	/* This driver uses only one global timer interrupt */
++	mct_irqs[MCT_G0_IRQ] = irq_of_parse_and_map(np, MCT_G0_IRQ);
++
++	/*
++	 * Find out the number of local irqs specified. The local
++	 * timer irqs are specified after the four global timer
++	 * irqs are specified.
++	 */
++	nr_irqs = of_irq_count(np);
++	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
++		mct_irqs[i] = irq_of_parse_and_map(np, i);
++
++	exynos4_timer_resources(of_iomap(np, 0));
 +	exynos4_clocksource_init();
 +	exynos4_clockevent_init();
 +}
++
++
++static void __init mct_init_spi(struct device_node *np)
++{
++	return mct_init_dt(np, MCT_INT_SPI);
++}
++
++static void __init mct_init_ppi(struct device_node *np)
++{
++	return mct_init_dt(np, MCT_INT_PPI);
++}
++CLOCKSOURCE_OF_DECLARE(exynos4210, "samsung,exynos4210-mct", mct_init_spi);
++CLOCKSOURCE_OF_DECLARE(exynos4412, "samsung,exynos4412-mct", mct_init_ppi);
