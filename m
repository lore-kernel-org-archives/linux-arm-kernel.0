From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 14 Mar 2012 07:26:27 -0700
Subject: [PATCH 2/5] ARM: EXYNOS: Rename of function for pm.c
In-Reply-To: <1331735190-28773-1-git-send-email-kgene.kim@samsung.com>
References: <1331735190-28773-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1331735190-28773-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jongpill Lee <boyko.lee@samsung.com>

This patch changes the function name of pmc. to support new
EXYNOS SoCs commonly.

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/pm.c |   55 +++++++++++++++++++++++----------------------
 1 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 696f0bf..abc1def 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -1,9 +1,8 @@
-/* linux/arch/arm/mach-exynos4/pm.c
- *
- * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+/*
+ * Copyright (c) 2011-2012 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * EXYNOS4210 - Power Management support
+ * EXYNOS - Power Management support
  *
  * Based on arch/arm/mach-s3c2410/pm.c
  * Copyright (c) 2006 Simtec Electronics
@@ -63,7 +62,7 @@ static struct sleep_save exynos4_vpll_save[] = {
 	SAVE_ITEM(EXYNOS4_VPLL_CON1),
 };
 
-static struct sleep_save exynos4_core_save[] = {
+static struct sleep_save exynos_core_save[] = {
 	/* SROM side */
 	SAVE_ITEM(S5P_SROM_BW),
 	SAVE_ITEM(S5P_SROM_BC0),
@@ -83,7 +82,7 @@ static struct sleep_save exynos4_l2cc_save[] = {
 /* For Cortex-A9 Diagnostic and Power control register */
 static unsigned int save_arm_register[2];
 
-static int exynos4_cpu_suspend(unsigned long arg)
+static int exynos_cpu_suspend(unsigned long arg)
 {
 	outer_flush_all();
 
@@ -94,11 +93,11 @@ static int exynos4_cpu_suspend(unsigned long arg)
 	panic("sleep resumed to originator?");
 }
 
-static void exynos4_pm_prepare(void)
+static void exynos_pm_prepare(void)
 {
 	u32 tmp;
 
-	s3c_pm_do_save(exynos4_core_save, ARRAY_SIZE(exynos4_core_save));
+	s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 	s3c_pm_do_save(exynos4_l2cc_save, ARRAY_SIZE(exynos4_l2cc_save));
 	s3c_pm_do_save(exynos4_epll_save, ARRAY_SIZE(exynos4_epll_save));
 	s3c_pm_do_save(exynos4_vpll_save, ARRAY_SIZE(exynos4_vpll_save));
@@ -123,10 +122,10 @@ static void exynos4_pm_prepare(void)
 
 }
 
-static int exynos4_pm_add(struct device *dev, struct subsys_interface *sif)
+static int exynos_pm_add(struct device *dev, struct subsys_interface *sif)
 {
-	pm_cpu_prep = exynos4_pm_prepare;
-	pm_cpu_sleep = exynos4_cpu_suspend;
+	pm_cpu_prep = exynos_pm_prepare;
+	pm_cpu_sleep = exynos_cpu_suspend;
 
 	return 0;
 }
@@ -198,13 +197,13 @@ static void exynos4_restore_pll(void)
 	} while (epll_wait || vpll_wait);
 }
 
-static struct subsys_interface exynos4_pm_interface = {
+static struct subsys_interface exynos_pm_interface = {
 	.name		= "exynos4_pm",
 	.subsys		= &exynos4_subsys,
-	.add_dev	= exynos4_pm_add,
+	.add_dev	= exynos_pm_add,
 };
 
-static __init int exynos4_pm_drvinit(void)
+static __init int exynos_pm_drvinit(void)
 {
 	struct clk *pll_base;
 	unsigned int tmp;
@@ -217,18 +216,20 @@ static __init int exynos4_pm_drvinit(void)
 	tmp |= ((0xFF << 8) | (0x1F << 1));
 	__raw_writel(tmp, S5P_WAKEUP_MASK);
 
-	pll_base = clk_get(NULL, "xtal");
+	if (!soc_is_exynos5250()) {
+		pll_base = clk_get(NULL, "xtal");
 
-	if (!IS_ERR(pll_base)) {
-		pll_base_rate = clk_get_rate(pll_base);
-		clk_put(pll_base);
+		if (!IS_ERR(pll_base)) {
+			pll_base_rate = clk_get_rate(pll_base);
+			clk_put(pll_base);
+		}
 	}
 
-	return subsys_interface_register(&exynos4_pm_interface);
+	return subsys_interface_register(&exynos_pm_interface);
 }
-arch_initcall(exynos4_pm_drvinit);
+arch_initcall(exynos_pm_drvinit);
 
-static int exynos4_pm_suspend(void)
+static int exynos_pm_suspend(void)
 {
 	unsigned long tmp;
 
@@ -258,7 +259,7 @@ static int exynos4_pm_suspend(void)
 	return 0;
 }
 
-static void exynos4_pm_resume(void)
+static void exynos_pm_resume(void)
 {
 	unsigned long tmp;
 
@@ -297,7 +298,7 @@ static void exynos4_pm_resume(void)
 	__raw_writel((1 << 28), S5P_PAD_RET_EBIA_OPTION);
 	__raw_writel((1 << 28), S5P_PAD_RET_EBIB_OPTION);
 
-	s3c_pm_do_restore_core(exynos4_core_save, ARRAY_SIZE(exynos4_core_save));
+	s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
 	exynos4_restore_pll();
 
@@ -316,14 +317,14 @@ early_wakeup:
 	return;
 }
 
-static struct syscore_ops exynos4_pm_syscore_ops = {
-	.suspend	= exynos4_pm_suspend,
-	.resume		= exynos4_pm_resume,
+static struct syscore_ops exynos_pm_syscore_ops = {
+	.suspend	= exynos_pm_suspend,
+	.resume		= exynos_pm_resume,
 };
 
 static __init int exynos4_pm_syscore_init(void)
 {
-	register_syscore_ops(&exynos4_pm_syscore_ops);
+	register_syscore_ops(&exynos_pm_syscore_ops);
 	return 0;
 }
 arch_initcall(exynos4_pm_syscore_init);
-- 
1.7.4.4
