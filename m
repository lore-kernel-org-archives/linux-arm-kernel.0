From: amit.kachhap@linaro.org (Amit Daniel Kachhap)
Date: Tue, 21 Feb 2012 11:49:49 +0530
Subject: [PATCH V6 4/5] ARM: exynos: remove useless code to save/restore L2
In-Reply-To: <1329805190-8874-1-git-send-email-amit.kachhap@linaro.org>
References: <1329805190-8874-1-git-send-email-amit.kachhap@linaro.org>
Message-ID: <1329805190-8874-5-git-send-email-amit.kachhap@linaro.org>
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
index e190130..4816827 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -155,13 +155,6 @@ static struct sleep_save exynos4_core_save[] = {
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
@@ -182,7 +175,6 @@ static void exynos4_pm_prepare(void)
 	u32 tmp;
 
 	s3c_pm_do_save(exynos4_core_save, ARRAY_SIZE(exynos4_core_save));
-	s3c_pm_do_save(exynos4_l2cc_save, ARRAY_SIZE(exynos4_l2cc_save));
 	s3c_pm_do_save(exynos4_epll_save, ARRAY_SIZE(exynos4_epll_save));
 	s3c_pm_do_save(exynos4_vpll_save, ARRAY_SIZE(exynos4_vpll_save));
 
@@ -388,13 +380,6 @@ static void exynos4_pm_resume(void)
 	scu_enable(S5P_VA_SCU);
 #endif
 
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
