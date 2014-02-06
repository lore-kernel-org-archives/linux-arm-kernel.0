From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 06 Feb 2014 19:16:56 +0100
Subject: [PATCH v2 9/9] ARM: EXYNOS: pm: Drop legacy Exynos4 clock
 suspend/resume code
In-Reply-To: <1391710616-14226-1-git-send-email-t.figa@samsung.com>
References: <1391710616-14226-1-git-send-email-t.figa@samsung.com>
Message-ID: <1391710616-14226-10-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the suspend/resume handling is already implemented in Exynos4 clock
driver, so this legacy code can be safely dropped.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/pm.c | 148 +---------------------------------------------
 1 file changed, 2 insertions(+), 146 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index e00025b..ba18214 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -35,56 +35,6 @@
 #include "common.h"
 #include "regs-pmu.h"
 
-#define EXYNOS4_EPLL_LOCK			(S5P_VA_CMU + 0x0C010)
-#define EXYNOS4_VPLL_LOCK			(S5P_VA_CMU + 0x0C020)
-
-#define EXYNOS4_EPLL_CON0			(S5P_VA_CMU + 0x0C110)
-#define EXYNOS4_EPLL_CON1			(S5P_VA_CMU + 0x0C114)
-#define EXYNOS4_VPLL_CON0			(S5P_VA_CMU + 0x0C120)
-#define EXYNOS4_VPLL_CON1			(S5P_VA_CMU + 0x0C124)
-
-#define EXYNOS4_CLKSRC_MASK_TOP			(S5P_VA_CMU + 0x0C310)
-#define EXYNOS4_CLKSRC_MASK_CAM			(S5P_VA_CMU + 0x0C320)
-#define EXYNOS4_CLKSRC_MASK_TV			(S5P_VA_CMU + 0x0C324)
-#define EXYNOS4_CLKSRC_MASK_LCD0		(S5P_VA_CMU + 0x0C334)
-#define EXYNOS4_CLKSRC_MASK_MAUDIO		(S5P_VA_CMU + 0x0C33C)
-#define EXYNOS4_CLKSRC_MASK_FSYS		(S5P_VA_CMU + 0x0C340)
-#define EXYNOS4_CLKSRC_MASK_PERIL0		(S5P_VA_CMU + 0x0C350)
-#define EXYNOS4_CLKSRC_MASK_PERIL1		(S5P_VA_CMU + 0x0C354)
-
-#define EXYNOS4_CLKSRC_MASK_DMC			(S5P_VA_CMU + 0x10300)
-
-#define EXYNOS4_EPLLCON0_LOCKED_SHIFT		(29)
-#define EXYNOS4_VPLLCON0_LOCKED_SHIFT		(29)
-
-#define EXYNOS4210_CLKSRC_MASK_LCD1		(S5P_VA_CMU + 0x0C338)
-
-static const struct sleep_save exynos4_set_clksrc[] = {
-	{ .reg = EXYNOS4_CLKSRC_MASK_TOP		, .val = 0x00000001, },
-	{ .reg = EXYNOS4_CLKSRC_MASK_CAM		, .val = 0x11111111, },
-	{ .reg = EXYNOS4_CLKSRC_MASK_TV			, .val = 0x00000111, },
-	{ .reg = EXYNOS4_CLKSRC_MASK_LCD0		, .val = 0x00001111, },
-	{ .reg = EXYNOS4_CLKSRC_MASK_MAUDIO		, .val = 0x00000001, },
-	{ .reg = EXYNOS4_CLKSRC_MASK_FSYS		, .val = 0x01011111, },
-	{ .reg = EXYNOS4_CLKSRC_MASK_PERIL0		, .val = 0x01111111, },
-	{ .reg = EXYNOS4_CLKSRC_MASK_PERIL1		, .val = 0x01110111, },
-	{ .reg = EXYNOS4_CLKSRC_MASK_DMC		, .val = 0x00010000, },
-};
-
-static const struct sleep_save exynos4210_set_clksrc[] = {
-	{ .reg = EXYNOS4210_CLKSRC_MASK_LCD1		, .val = 0x00001111, },
-};
-
-static struct sleep_save exynos4_epll_save[] = {
-	SAVE_ITEM(EXYNOS4_EPLL_CON0),
-	SAVE_ITEM(EXYNOS4_EPLL_CON1),
-};
-
-static struct sleep_save exynos4_vpll_save[] = {
-	SAVE_ITEM(EXYNOS4_VPLL_CON0),
-	SAVE_ITEM(EXYNOS4_VPLL_CON1),
-};
-
 static struct sleep_save exynos5_sys_save[] = {
 	SAVE_ITEM(EXYNOS5_SYS_I2C_CFG),
 };
@@ -124,10 +74,7 @@ static void exynos_pm_prepare(void)
 
 	s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
-	if (!soc_is_exynos5250()) {
-		s3c_pm_do_save(exynos4_epll_save, ARRAY_SIZE(exynos4_epll_save));
-		s3c_pm_do_save(exynos4_vpll_save, ARRAY_SIZE(exynos4_vpll_save));
-	} else {
+	if (soc_is_exynos5250()) {
 		s3c_pm_do_save(exynos5_sys_save, ARRAY_SIZE(exynos5_sys_save));
 		/* Disable USE_RETENTION of JPEG_MEM_OPTION */
 		tmp = __raw_readl(EXYNOS5_JPEG_MEM_OPTION);
@@ -143,15 +90,6 @@ static void exynos_pm_prepare(void)
 	/* ensure at least INFORM0 has the resume address */
 
 	__raw_writel(virt_to_phys(s3c_cpu_resume), S5P_INFORM0);
-
-	/* Before enter central sequence mode, clock src register have to set */
-
-	if (!soc_is_exynos5250())
-		s3c_pm_do_restore_core(exynos4_set_clksrc, ARRAY_SIZE(exynos4_set_clksrc));
-
-	if (soc_is_exynos4210())
-		s3c_pm_do_restore_core(exynos4210_set_clksrc, ARRAY_SIZE(exynos4210_set_clksrc));
-
 }
 
 static int exynos_pm_add(struct device *dev, struct subsys_interface *sif)
@@ -162,73 +100,6 @@ static int exynos_pm_add(struct device *dev, struct subsys_interface *sif)
 	return 0;
 }
 
-static unsigned long pll_base_rate;
-
-static void exynos4_restore_pll(void)
-{
-	unsigned long pll_con, locktime, lockcnt;
-	unsigned long pll_in_rate;
-	unsigned int p_div, epll_wait = 0, vpll_wait = 0;
-
-	if (pll_base_rate == 0)
-		return;
-
-	pll_in_rate = pll_base_rate;
-
-	/* EPLL */
-	pll_con = exynos4_epll_save[0].val;
-
-	if (pll_con & (1 << 31)) {
-		pll_con &= (PLL46XX_PDIV_MASK << PLL46XX_PDIV_SHIFT);
-		p_div = (pll_con >> PLL46XX_PDIV_SHIFT);
-
-		pll_in_rate /= 1000000;
-
-		locktime = (3000 / pll_in_rate) * p_div;
-		lockcnt = locktime * 10000 / (10000 / pll_in_rate);
-
-		__raw_writel(lockcnt, EXYNOS4_EPLL_LOCK);
-
-		s3c_pm_do_restore_core(exynos4_epll_save,
-					ARRAY_SIZE(exynos4_epll_save));
-		epll_wait = 1;
-	}
-
-	pll_in_rate = pll_base_rate;
-
-	/* VPLL */
-	pll_con = exynos4_vpll_save[0].val;
-
-	if (pll_con & (1 << 31)) {
-		pll_in_rate /= 1000000;
-		/* 750us */
-		locktime = 750;
-		lockcnt = locktime * 10000 / (10000 / pll_in_rate);
-
-		__raw_writel(lockcnt, EXYNOS4_VPLL_LOCK);
-
-		s3c_pm_do_restore_core(exynos4_vpll_save,
-					ARRAY_SIZE(exynos4_vpll_save));
-		vpll_wait = 1;
-	}
-
-	/* Wait PLL locking */
-
-	do {
-		if (epll_wait) {
-			pll_con = __raw_readl(EXYNOS4_EPLL_CON0);
-			if (pll_con & (1 << EXYNOS4_EPLLCON0_LOCKED_SHIFT))
-				epll_wait = 0;
-		}
-
-		if (vpll_wait) {
-			pll_con = __raw_readl(EXYNOS4_VPLL_CON0);
-			if (pll_con & (1 << EXYNOS4_VPLLCON0_LOCKED_SHIFT))
-				vpll_wait = 0;
-		}
-	} while (epll_wait || vpll_wait);
-}
-
 static struct subsys_interface exynos_pm_interface = {
 	.name		= "exynos_pm",
 	.subsys		= &exynos_subsys,
@@ -237,7 +108,6 @@ static struct subsys_interface exynos_pm_interface = {
 
 static __init int exynos_pm_drvinit(void)
 {
-	struct clk *pll_base;
 	unsigned int tmp;
 
 	if (soc_is_exynos5440())
@@ -251,15 +121,6 @@ static __init int exynos_pm_drvinit(void)
 	tmp |= ((0xFF << 8) | (0x1F << 1));
 	__raw_writel(tmp, S5P_WAKEUP_MASK);
 
-	if (!soc_is_exynos5250()) {
-		pll_base = clk_get(NULL, "xtal");
-
-		if (!IS_ERR(pll_base)) {
-			pll_base_rate = clk_get_rate(pll_base);
-			clk_put(pll_base);
-		}
-	}
-
 	return subsys_interface_register(&exynos_pm_interface);
 }
 arch_initcall(exynos_pm_drvinit);
@@ -343,13 +204,8 @@ static void exynos_pm_resume(void)
 
 	s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
-	if (!soc_is_exynos5250()) {
-		exynos4_restore_pll();
-
-#ifdef CONFIG_SMP
+	if (IS_ENABLED(CONFIG_SMP) && !soc_is_exynos5250())
 		scu_enable(S5P_VA_SCU);
-#endif
-	}
 
 early_wakeup:
 
-- 
1.8.5.2
