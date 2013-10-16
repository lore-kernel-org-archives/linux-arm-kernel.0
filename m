From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 16 Oct 2013 13:08:18 +0200
Subject: [PATCH 9/9] ARM: EXYNOS: pm: Drop legacy Exynos4 clock suspend/resume
 code
In-Reply-To: <1381921698-5060-1-git-send-email-t.figa@samsung.com>
References: <1381921698-5060-1-git-send-email-t.figa@samsung.com>
Message-ID: <1381921698-5060-10-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the suspend/resume handling is already implemented in Exynos4 clock
driver, so this legacy code can be safely dropped.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/pm.c | 125 +---------------------------------------------
 1 file changed, 2 insertions(+), 123 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 1f24e7f..1578d43 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -30,38 +30,11 @@
 #include <plat/regs-srom.h>
 
 #include <mach/regs-irq.h>
-#include <mach/regs-clock.h>
 #include <mach/regs-pmu.h>
 #include <mach/pm-core.h>
 
 #include "common.h"
 
-static struct sleep_save exynos4_set_clksrc[] = {
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
-static struct sleep_save exynos4210_set_clksrc[] = {
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
@@ -101,10 +74,7 @@ static void exynos_pm_prepare(void)
 
 	s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
-	if (!soc_is_exynos5250()) {
-		s3c_pm_do_save(exynos4_epll_save, ARRAY_SIZE(exynos4_epll_save));
-		s3c_pm_do_save(exynos4_vpll_save, ARRAY_SIZE(exynos4_vpll_save));
-	} else {
+	if (soc_is_exynos5250()) {
 		s3c_pm_do_save(exynos5_sys_save, ARRAY_SIZE(exynos5_sys_save));
 		/* Disable USE_RETENTION of JPEG_MEM_OPTION */
 		tmp = __raw_readl(EXYNOS5_JPEG_MEM_OPTION);
@@ -120,15 +90,6 @@ static void exynos_pm_prepare(void)
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
@@ -139,73 +100,6 @@ static int exynos_pm_add(struct device *dev, struct subsys_interface *sif)
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
@@ -257,7 +151,6 @@ int s3c_irq_wake(struct irq_data *data, unsigned int state)
 static __init int exynos_pm_drvinit(void)
 {
 	const struct exynos_wkup_irq *wkup_irq;
-	struct clk *pll_base;
 	unsigned int tmp;
 
 	if (soc_is_exynos5440())
@@ -283,15 +176,6 @@ static __init int exynos_pm_drvinit(void)
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
@@ -375,13 +259,8 @@ static void exynos_pm_resume(void)
 
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
1.8.3.2
