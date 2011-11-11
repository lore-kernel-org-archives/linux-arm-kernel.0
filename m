From: amit.kachhap@linaro.org (Amit Daniel Kachhap)
Date: Fri, 11 Nov 2011 11:59:36 +0530
Subject: [PATCH V2 4/5] ARM: exynos4: remove useless code to save/restore L2
In-Reply-To: <1320992977-11589-1-git-send-email-amit.kachhap@linaro.org>
References: <1320992977-11589-1-git-send-email-amit.kachhap@linaro.org>
Message-ID: <1320992977-11589-5-git-send-email-amit.kachhap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following the merge of CPU PM notifiers and L2 resume code, this patch
removes useless code to save and restore L2 registers.

This is now automatically covered by suspend calls which integrated
CPU PM notifiers and new sleep code that allows to resume L2 before MMU
is turned on.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
---
 arch/arm/mach-exynos/pm.c |   15 ---------------
 1 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 509a435..0c264e1 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -154,13 +154,6 @@ static struct sleep_save exynos4_core_save[] = {
 	SAVE_ITEM(S5P_SROM_BC3),
 };
 
-static struct sleep_save exynos4_l2cc_save[] = {
-	SAVE_ITEM(S5P_VA_L2CC + L2X0_TAG_LATENCY_CTRL),
-	SAVE_ITEM(S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL),
-	SAVE_ITEM(S5P_VA_L2CC + L2X0_PREFETCH_CTRL),
-	SAVE_ITEM(S5P_VA_L2CC + L2X0_POWER_CTRL),
-	SAVE_ITEM(S5P_VA_L2CC + L2X0_AUX_CTRL),
-};
 
 /* For Cortex-A9 Diagnostic and Power control register */
 static unsigned int save_arm_register[2];
@@ -181,7 +174,6 @@ static void exynos4_pm_prepare(void)
 	u32 tmp;
 
 	s3c_pm_do_save(exynos4_core_save, ARRAY_SIZE(exynos4_core_save));
-	s3c_pm_do_save(exynos4_l2cc_save, ARRAY_SIZE(exynos4_l2cc_save));
 	s3c_pm_do_save(exynos4_epll_save, ARRAY_SIZE(exynos4_epll_save));
 	s3c_pm_do_save(exynos4_vpll_save, ARRAY_SIZE(exynos4_vpll_save));
 
@@ -404,13 +396,6 @@ static void exynos4_pm_resume(void)
 
 	exynos4_scu_enable(S5P_VA_SCU);
 
-#ifdef CONFIG_CACHE_L2X0
-	s3c_pm_do_restore_core(exynos4_l2cc_save, ARRAY_SIZE(exynos4_l2cc_save));
-	outer_inv_all();
-	/* enable L2X0*/
-	writel_relaxed(1, S5P_VA_L2CC + L2X0_CTRL);
-#endif
-
 early_wakeup:
 	return;
 }
-- 
1.7.1
