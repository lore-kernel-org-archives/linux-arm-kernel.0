From: inderpal.singh@linaro.org (Inderpal Singh)
Date: Tue, 10 May 2011 11:43:50 +0530
Subject: [PATCH] ARM: EXYNOS4: Suspend to RAM fix
Message-ID: <1305008030-31983-1-git-send-email-inderpal.s@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch caters to the case when there is no wake up source. The system should abort the suspend and resume properly.

1. It implements the pm_suspend function to save the core registers so  that they can be restored in pm_resume function.
   Earlier these resgisters were getting saved in pm_prepare, but pm_prepare never gets invoked when there is no wake up
   source enabled and restoration used to hang while resuming.

2. As per the L2 cache controller spec, the cache controller registers should not be modified if cache is already enabled.
   Hence have made restoration of cache controller registers conditional based on whether it is already enabled or not.

Signed-off-by: Inderpal Singh <inderpal.s@samsung.com>
Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
---
 arch/arm/mach-exynos4/pm.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/pm.c b/arch/arm/mach-exynos4/pm.c
index 10d917d..af4794b 100644
--- a/arch/arm/mach-exynos4/pm.c
+++ b/arch/arm/mach-exynos4/pm.c
@@ -323,8 +323,9 @@ static void exynos4_pm_prepare(void)
 {
 	u32 tmp;
 
-	s3c_pm_do_save(exynos4_core_save, ARRAY_SIZE(exynos4_core_save));
+#ifdef CONFIG_CACHE_L2X0
 	s3c_pm_do_save(exynos4_l2cc_save, ARRAY_SIZE(exynos4_l2cc_save));
+#endif
 
 	tmp = __raw_readl(S5P_INFORM1);
 
@@ -389,6 +390,10 @@ static int exynos4_pm_resume(struct sys_device *dev)
 	exynos4_scu_enable(S5P_VA_SCU);
 
 #ifdef CONFIG_CACHE_L2X0
+	/* Restore the cache controller registers only if it is not enabled already*/
+	if((__raw_readl(S5P_VA_L2CC + L2X0_CTRL)&1))
+		return 0;
+
 	s3c_pm_do_restore_core(exynos4_l2cc_save, ARRAY_SIZE(exynos4_l2cc_save));
 	outer_inv_all();
 	/* enable L2X0*/
@@ -398,9 +403,16 @@ static int exynos4_pm_resume(struct sys_device *dev)
 	return 0;
 }
 
+static int exynos4_pm_suspend(struct sys_device *dev,pm_message_t state)
+{
+	s3c_pm_do_save(exynos4_core_save, ARRAY_SIZE(exynos4_core_save));
+	return 0;
+}
+
 static struct sysdev_driver exynos4_pm_driver = {
 	.add		= exynos4_pm_add,
 	.resume		= exynos4_pm_resume,
+	.suspend	= exynos4_pm_suspend,
 };
 
 static __init int exynos4_pm_drvinit(void)
-- 
1.7.1
