From: inderpal.singh@linaro.org (Inderpal Singh)
Date: Tue, 21 Jun 2011 11:02:31 +0530
Subject: [PATCH] ARM: EXYNOS4: Suspend to RAM fix
Message-ID: <1308634351-8511-1-git-send-email-inderpal.singh@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Inderpal Singh <inderpal.s@samsung.com>

This patch caters to the case when there is no wake up source. The system should abort the suspend and resume properly.

1. It implements the pm_suspend function to save the core registers so  that they can be restored in pm_resume function.
Earlier these resgisters were getting saved in pm_prepare, but pm_prepare never gets invoked when there is no wake up
source enabled and restoration used to hang while resuming.

2. As per the L2 cache controller spec, the cache controller registers should not be modified if cache is already enabled.
Hence have made restoration of cache controller registers conditional based on whether it is already enabled or not.

Signed-off-by: Inderpal Singh <inderpal.s@samsung.com>
---
 arch/arm/mach-exynos4/pm.c |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-exynos4/pm.c b/arch/arm/mach-exynos4/pm.c
index 8755ca8..f483dae 100644
--- a/arch/arm/mach-exynos4/pm.c
+++ b/arch/arm/mach-exynos4/pm.c
@@ -324,8 +324,9 @@ static void exynos4_pm_prepare(void)
 {
 	u32 tmp;
 
-	s3c_pm_do_save(exynos4_core_save, ARRAY_SIZE(exynos4_core_save));
+#ifdef CONFIG_CACHE_L2X0
 	s3c_pm_do_save(exynos4_l2cc_save, ARRAY_SIZE(exynos4_l2cc_save));
+#endif
 
 	tmp = __raw_readl(S5P_INFORM1);
 
@@ -410,15 +411,26 @@ static void exynos4_pm_resume(void)
 	exynos4_scu_enable(S5P_VA_SCU);
 
 #ifdef CONFIG_CACHE_L2X0
-	s3c_pm_do_restore_core(exynos4_l2cc_save, ARRAY_SIZE(exynos4_l2cc_save));
-	outer_inv_all();
-	/* enable L2X0*/
-	writel_relaxed(1, S5P_VA_L2CC + L2X0_CTRL);
+	/* Restore the cache controller registers only if it is not enabled already*/
+	if (!(__raw_readl(S5P_VA_L2CC + L2X0_CTRL)&1)) {
+
+		s3c_pm_do_restore_core(exynos4_l2cc_save, ARRAY_SIZE(exynos4_l2cc_save));
+		outer_inv_all();
+		/* enable L2X0*/
+		writel_relaxed(1, S5P_VA_L2CC + L2X0_CTRL);
+	}
 #endif
 }
 
+static int exynos4_pm_suspend(void)
+{
+	s3c_pm_do_save(exynos4_core_save, ARRAY_SIZE(exynos4_core_save));
+	return 0;
+}
+
 static struct syscore_ops exynos4_pm_syscore_ops = {
 	.resume		= exynos4_pm_resume,
+	.suspend	= exynos4_pm_suspend,
 };
 
 static __init int exynos4_pm_syscore_init(void)
-- 
1.7.1
