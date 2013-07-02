From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 02 Jul 2013 18:28:06 +0900
Subject: [PATCH 05/08] ARM: shmobile: Use DT for GIC on EMEV2 and KZM9D
In-Reply-To: <20130702092725.32066.54861.sendpatchset@w520>
References: <20130702092725.32066.54861.sendpatchset@w520>
Message-ID: <20130702092806.32066.58281.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove the C version of the EMEV2 GIC setup code,
instead rely on GIC information provided by DT.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-kzm9d.c        |    2 --
 arch/arm/mach-shmobile/include/mach/emev2.h |    1 -
 arch/arm/mach-shmobile/setup-emev2.c        |   15 ---------------
 3 files changed, 18 deletions(-)

--- 0002/arch/arm/mach-shmobile/board-kzm9d.c
+++ work/arch/arm/mach-shmobile/board-kzm9d.c	2013-07-02 15:01:32.000000000 +0900
@@ -86,8 +86,6 @@ DT_MACHINE_START(KZM9D_DT, "kzm9d")
 	.smp		= smp_ops(emev2_smp_ops),
 	.map_io		= emev2_map_io,
 	.init_early	= emev2_init_delay,
-	.nr_irqs	= NR_IRQS_LEGACY,
-	.init_irq	= emev2_init_irq,
 	.init_machine	= kzm9d_add_standard_devices,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= kzm9d_boards_compat_dt,
--- 0002/arch/arm/mach-shmobile/include/mach/emev2.h
+++ work/arch/arm/mach-shmobile/include/mach/emev2.h	2013-07-02 15:01:48.000000000 +0900
@@ -2,7 +2,6 @@
 #define __ASM_EMEV2_H__
 
 extern void emev2_map_io(void);
-extern void emev2_init_irq(void);
 extern void emev2_init_delay(void);
 extern void emev2_add_standard_devices(void);
 extern void emev2_clock_init(void);
--- 0003/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c	2013-07-02 15:01:17.000000000 +0900
@@ -202,20 +202,6 @@ void __init emev2_init_delay(void)
 	shmobile_setup_delay(533, 1, 3); /* Cortex-A9 @ 533MHz */
 }
 
-void __init emev2_init_irq(void)
-{
-	void __iomem *gic_dist_base;
-	void __iomem *gic_cpu_base;
-
-	/* Static mappings, never released */
-	gic_dist_base = ioremap(0xe0028000, PAGE_SIZE);
-	gic_cpu_base = ioremap(0xe0020000, PAGE_SIZE);
-	BUG_ON(!gic_dist_base || !gic_cpu_base);
-
-	/* Use GIC to handle interrupts */
-	gic_init(0, 29, gic_dist_base, gic_cpu_base);
-}
-
 #ifdef CONFIG_USE_OF
 static const struct of_dev_auxdata emev2_auxdata_lookup[] __initconst = {
 	{ }
@@ -235,7 +221,6 @@ static const char *emev2_boards_compat_d
 DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
 	.smp		= smp_ops(emev2_smp_ops),
 	.init_early	= emev2_init_delay,
-	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_machine	= emev2_add_standard_devices_dt,
 	.dt_compat	= emev2_boards_compat_dt,
 MACHINE_END
