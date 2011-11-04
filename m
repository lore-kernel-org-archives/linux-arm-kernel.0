From: amit.kachhap@linaro.org (amit.kachhap at linaro.org)
Date: Fri,  4 Nov 2011 13:03:48 -0400
Subject: [PATCH 4/4] ARM: exynos4: remove useless code to save/restore L2 and
	GIC state
In-Reply-To: <1320426228-21746-1-git-send-email-amit.kachhap@linaro.org>
References: <1320426228-21746-1-git-send-email-amit.kachhap@linaro.org>
Message-ID: <1320426228-21746-5-git-send-email-amit.kachhap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Amit Daniel Kachhap <amit.kachhap@linaro.org>

Following the merge of CPU PM notifiers and L2 resume code, this patch
removes useless code to save and restore L2 and GIC registers.

This is now automatically covered by suspend calls which integrated
CPU PM notifiers and new sleep code that allows to resume L2 before MMU
is turned on.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
---
 arch/arm/mach-exynos4/pm.c |   86 --------------------------------------------
 1 files changed, 0 insertions(+), 86 deletions(-)

diff --git a/arch/arm/mach-exynos4/pm.c b/arch/arm/mach-exynos4/pm.c
index 62e4f43..7499f14 100644
--- a/arch/arm/mach-exynos4/pm.c
+++ b/arch/arm/mach-exynos4/pm.c
@@ -63,77 +63,6 @@ static struct sleep_save exynos4_vpll_save[] = {
 };
 
 static struct sleep_save exynos4_core_save[] = {
-	/* GIC side */
-	SAVE_ITEM(S5P_VA_GIC_CPU + 0x000),
-	SAVE_ITEM(S5P_VA_GIC_CPU + 0x004),
-	SAVE_ITEM(S5P_VA_GIC_CPU + 0x008),
-	SAVE_ITEM(S5P_VA_GIC_CPU + 0x00C),
-	SAVE_ITEM(S5P_VA_GIC_CPU + 0x014),
-	SAVE_ITEM(S5P_VA_GIC_CPU + 0x018),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x000),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x004),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x100),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x104),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x108),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x300),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x304),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x308),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x400),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x404),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x408),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x40C),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x410),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x414),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x418),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x41C),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x420),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x424),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x428),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x42C),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x430),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x434),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x438),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x43C),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x440),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x444),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x448),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x44C),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x450),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x454),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x458),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x45C),
-
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x800),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x804),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x808),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x80C),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x810),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x814),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x818),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x81C),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x820),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x824),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x828),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x82C),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x830),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x834),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x838),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x83C),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x840),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x844),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x848),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x84C),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x850),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x854),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x858),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x85C),
-
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC00),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC04),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC08),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC0C),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC10),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC14),
 
 	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x000),
 	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x010),
@@ -154,13 +83,6 @@ static struct sleep_save exynos4_core_save[] = {
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
@@ -181,7 +103,6 @@ static void exynos4_pm_prepare(void)
 	u32 tmp;
 
 	s3c_pm_do_save(exynos4_core_save, ARRAY_SIZE(exynos4_core_save));
-	s3c_pm_do_save(exynos4_l2cc_save, ARRAY_SIZE(exynos4_l2cc_save));
 	s3c_pm_do_save(exynos4_epll_save, ARRAY_SIZE(exynos4_epll_save));
 	s3c_pm_do_save(exynos4_vpll_save, ARRAY_SIZE(exynos4_vpll_save));
 
@@ -397,13 +318,6 @@ static void exynos4_pm_resume(void)
 
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
1.7.5.4
