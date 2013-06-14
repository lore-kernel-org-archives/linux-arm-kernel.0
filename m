From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 15 Jun 2013 00:40:05 +0200
Subject: [PATCH 00/28] Twenty eight patches big Exynos cleanup
In-Reply-To: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
References: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
Message-ID: <44606956.qkeEi5jTbO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fwiw, I compared the patches now, and got to this diff. You had more things
that I missed, these are the ones I found that you didn't have.

Feel free to integrate them into your series, with or without my signed-off-by,
as they are all trivial and they still need to be split up and described.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index fe75a65..f36a762 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -110,23 +110,6 @@ config MACH_EXYNOS5_DT
 	  Machine support for Samsung EXYNOS5 machine with device tree enabled.
 	  Select this if a fdt blob is available for the EXYNOS5 SoC based board.
 
-if ARCH_EXYNOS4
-
-comment "Configuration for HSMMC 8-bit bus width"
-
-config EXYNOS4_SDHCI_CH0_8BIT
-	bool "Channel 0 with 8-bit bus"
-	help
-	  Support HSMMC Channel 0 8-bit bus.
-	  If selected, Channel 1 is disabled.
-
-config EXYNOS4_SDHCI_CH2_8BIT
-	bool "Channel 2 with 8-bit bus"
-	help
-	  Support HSMMC Channel 2 8-bit bus.
-	  If selected, Channel 3 is disabled.
-endif
-
 endmenu
 
 endif
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 7b53e4c..a14ef64 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -60,8 +60,6 @@ static void exynos5_map_io(void);
 static void exynos5440_map_io(void);
 static int exynos_init(void);
 
-unsigned long xxti_f = 0, xusbxti_f = 0;
-
 static struct cpu_table cpu_ids[] __initdata = {
 	{
 		.idcode		= EXYNOS4210_CPU_ID,
@@ -322,7 +320,7 @@ void __init exynos_init_late(void)
 	exynos_pm_late_initcall();
 }
 
-int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
+static int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
 					int depth, void *data)
 {
 	struct map_desc iodesc;
@@ -351,15 +349,12 @@ int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
  * register the standard cpu IO areas
  */
 
-void __init exynos_init_io(struct map_desc *mach_desc, int size)
+void __init exynos_init_io(void)
 {
 	debug_ll_io_init();
 
 	of_scan_flat_dt(exynos_fdt_map_chipid, NULL);
 
-	if (mach_desc)
-		iotable_init(mach_desc, size);
-
 	/* detect cpu id and rev. */
 	s5p_init_cpu(S5P_VA_CHIPID);
 
@@ -400,12 +395,7 @@ void __init exynos_init_time(void)
 	clocksource_of_init();
 }
 
-void __init exynos4_init_irq(void)
-{
-	irqchip_init();
-}
-
-void __init exynos5_init_irq(void)
+void __init exynos_init_irq(void)
 {
 	irqchip_init();
 }
@@ -425,7 +415,6 @@ static int __init exynos_core_init(void)
 }
 core_initcall(exynos_core_init);
 
-#ifdef CONFIG_CACHE_L2X0
 static int __init exynos4_l2x0_cache_init(void)
 {
 	int ret;
@@ -437,47 +426,10 @@ static int __init exynos4_l2x0_cache_init(void)
 	if (!ret) {
 		l2x0_regs_phys = virt_to_phys(&l2x0_saved_regs);
 		clean_dcache_area(&l2x0_regs_phys, sizeof(unsigned long));
-		return 0;
 	}
-
-	if (!(__raw_readl(S5P_VA_L2CC + L2X0_CTRL) & 0x1)) {
-		l2x0_saved_regs.phy_base = EXYNOS4_PA_L2CC;
-		/* TAG, Data Latency Control: 2 cycles */
-		l2x0_saved_regs.tag_latency = 0x110;
-
-		if (soc_is_exynos4212() || soc_is_exynos4412())
-			l2x0_saved_regs.data_latency = 0x120;
-		else
-			l2x0_saved_regs.data_latency = 0x110;
-
-		l2x0_saved_regs.prefetch_ctrl = 0x30000007;
-		l2x0_saved_regs.pwr_ctrl =
-			(L2X0_DYNAMIC_CLK_GATING_EN | L2X0_STNDBY_MODE_EN);
-
-		l2x0_regs_phys = virt_to_phys(&l2x0_saved_regs);
-
-		__raw_writel(l2x0_saved_regs.tag_latency,
-				S5P_VA_L2CC + L2X0_TAG_LATENCY_CTRL);
-		__raw_writel(l2x0_saved_regs.data_latency,
-				S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL);
-
-		/* L2X0 Prefetch Control */
-		__raw_writel(l2x0_saved_regs.prefetch_ctrl,
-				S5P_VA_L2CC + L2X0_PREFETCH_CTRL);
-
-		/* L2X0 Power Control */
-		__raw_writel(l2x0_saved_regs.pwr_ctrl,
-				S5P_VA_L2CC + L2X0_POWER_CTRL);
-
-		clean_dcache_area(&l2x0_regs_phys, sizeof(unsigned long));
-		clean_dcache_area(&l2x0_saved_regs, sizeof(struct l2x0_regs));
-	}
-
-	l2x0_init(S5P_VA_L2CC, L2_AUX_VAL, L2_AUX_MASK);
-	return 0;
+	return ret;
 }
 early_initcall(exynos4_l2x0_cache_init);
-#endif
 
 static int __init exynos_init(void)
 {
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 11fc1e2..4410885 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -19,9 +19,8 @@ void exynos_init_time(void);
 extern unsigned long xxti_f, xusbxti_f;
 
 struct map_desc;
-void exynos_init_io(struct map_desc *mach_desc, int size);
-void exynos4_init_irq(void);
-void exynos5_init_irq(void);
+void exynos_init_io(void);
+void exynos_init_irq(void);
 void exynos4_restart(char mode, const char *cmd);
 void exynos5_restart(char mode, const char *cmd);
 void exynos_init_late(void);
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 7b046b5..7966407 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -23,6 +23,10 @@
 
 #include <plat/map-s5p.h>
 
+/*
+ * FIXME: go through the list and remove from iotable
+ * all that are not essential
+ */
 #define EXYNOS4_PA_SYSRAM0		0x02025000
 #define EXYNOS4_PA_SYSRAM1		0x02020000
 #define EXYNOS5_PA_SYSRAM		0x02020000
diff --git a/arch/arm/mach-exynos/include/mach/pm-core.h b/arch/arm/mach-exynos/include/mach/pm-core.h
index 71e6b89..e40aa87 100644
--- a/arch/arm/mach-exynos/include/mach/pm-core.h
+++ b/arch/arm/mach-exynos/include/mach/pm-core.h
@@ -34,10 +34,7 @@ static inline void s3c_pm_debug_init_uart(void)
 
 static inline void s3c_pm_arch_prepare_irqs(void)
 {
-	u32 eintmask = s3c_irqwake_eintmask;
-
-	if (of_have_populated_dt())
-		eintmask = exynos_get_eint_wake_mask();
+	u32 eintmask = exynos_get_eint_wake_mask();
 
 	__raw_writel(eintmask, S5P_EINT_WAKEUP_MASK);
 	__raw_writel(s3c_irqwake_intmask & ~(1 << 31), S5P_WAKEUP_MASK);
diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index b9ed834..20f0c04 100644
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@ -23,15 +23,7 @@
 
 #include "common.h"
 
-static void __init exynos4_dt_map_io(void)
-{
-	exynos_init_io(NULL, 0);
-}
 
-static void __init exynos4_dt_machine_init(void)
-{
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
 
 static char const *exynos4_dt_compat[] __initdata = {
 	"samsung,exynos4210",
@@ -55,10 +47,9 @@ static void __init exynos4_reserve(void)
 DT_MACHINE_START(EXYNOS4210_DT, "Samsung Exynos4 (Flattened Device Tree)")
 	/* Maintainer: Thomas Abraham <thomas.abraham@linaro.org> */
 	.smp		= smp_ops(exynos_smp_ops),
-	.init_irq	= exynos4_init_irq,
-	.map_io		= exynos4_dt_map_io,
+	.init_irq	= exynos_init_irq,
+	.map_io		= exynos_init_io,
 	.init_early	= exynos_firmware_init,
-	.init_machine	= exynos4_dt_machine_init,
 	.init_late	= exynos_init_late,
 	.init_time	= exynos_init_time,
 	.dt_compat	= exynos4_dt_compat,
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index 9596861..ef2b010 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -27,11 +27,6 @@
 static u64 dma_mask64 = DMA_BIT_MASK(64);
 static u64 dma_mask32 = DMA_BIT_MASK(32);
 
-static void __init exynos5_dt_map_io(void)
-{
-	exynos_init_io(NULL, 0);
-}
-
 static int exynos5440_platform_notifier(struct notifier_block *nb,
 				  unsigned long event, void *__dev)
 {
@@ -104,9 +99,9 @@ static void __init exynos5_reserve(void)
 
 DT_MACHINE_START(EXYNOS5_DT, "SAMSUNG EXYNOS5 (Flattened Device Tree)")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
-	.init_irq	= exynos5_init_irq,
 	.smp		= smp_ops(exynos_smp_ops),
-	.map_io		= exynos5_dt_map_io,
+	.init_irq	= exynos_init_irq,
+	.map_io		= exynos_init_io,
 	.init_machine	= exynos5_dt_machine_init,
 	.init_late	= exynos_init_late,
 	.init_time	= exynos_init_time,
