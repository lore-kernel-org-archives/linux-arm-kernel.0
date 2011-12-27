From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Dec 2011 23:33:17 +0000
Subject: [GIT PULL] Samsung devel-dt for v3.3
In-Reply-To: <087d01ccc1d5$c6aa8300$53ff8900$%kim@samsung.com>
References: <087d01ccc1d5$c6aa8300$53ff8900$%kim@samsung.com>
Message-ID: <201112272333.18024.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 24 December 2011, Kukjin Kim wrote:
> Hi Arnd and Olof,
> 
> Please pull the samsung-devel-dt for v3.3.
> It includes support DT for Samsung EXYNOS4. 

Pulled into next/dt, thanks a lot!

Unfortunately, this got two conflicts against "ARM: exynos4: convert to
CONFIG_MULTI_IRQ_HANDLER" from Marc Zyngier, and I suspect my temporary
resolution is incorrect:

--- a/arch/arm/mach-exynos/cpu.c
+++ b/arch/arm/mach-exynos/cpu.c
@@@ -206,6 -209,24 +208,13 @@@ void __init exynos4_init_clocks(int xta
        exynos4_setup_clocks();
  }
  
 -static void exynos4_gic_irq_fix_base(struct irq_data *d)
 -{
 -      struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
 -
 -      gic_data->cpu_base = S5P_VA_GIC_CPU +
 -                          (gic_bank_offset * smp_processor_id());
 -
 -      gic_data->dist_base = S5P_VA_GIC_DIST +
 -                          (gic_bank_offset * smp_processor_id());
 -}
 -
+ #ifdef CONFIG_OF
+ static const struct of_device_id exynos4_dt_irq_match[] = {
+       { .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
+       {},
+ };
+ #endif
+ 
  void __init exynos4_init_irq(void)
  {
        int irq;
@@@ -213,8 -233,17 +222,13 @@@
  
        gic_bank_offset = soc_is_exynos4412() ? 0x4000 : 0x8000;
  
-       gic_init_bases(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU, gic_bank_offset);
+       if (!of_have_populated_dt())
 -              gic_init(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU);
++              gic_init_bases(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU, gic_bank_offset);
+ #ifdef CONFIG_OF
+       else
+               of_irq_init(exynos4_dt_irq_match);
+ #endif
  
 -      gic_arch_extn.irq_eoi = exynos4_gic_irq_fix_base;
 -      gic_arch_extn.irq_unmask = exynos4_gic_irq_fix_base;
 -      gic_arch_extn.irq_mask = exynos4_gic_irq_fix_base;
 -
        for (irq = 0; irq < MAX_COMBINER_NR; irq++) {
  
                combiner_init(irq, (void __iomem *)S5P_VA_COMBINER(irq),


The other conflict was a one-line change from 1fb3726cf3 "ARM: SAMSUNG: Move timer irq
numbers to end of linux irq space" (from Thomas Abraham) in code that was removed
by Marc's patch, so I kept removing that.

Maybe you can do a merge of your branch with Russell's devel-stable branch and tell me
which conflict resolution you would like.

	Arnd
