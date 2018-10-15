From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 15 Oct 2018 15:48:27 +0200
Subject: [PATCH] ARM: EXYNOS: remove no longer needed s3c_pm_check_*() calls
References: <CGME20181015134828eucas1p1b0b3287b5a330591e0976a3a83edbf11@eucas1p1.samsung.com>
Message-ID: <20181015134828eucas1p1b0b3287b5a330591e0976a3a83edbf11~dzFPt-ZL_1531815318eucas1p1t@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 6862fdf2201a ("ARM: samsung: Limit SAMSUNG_PM_CHECK
config option to non-Exynos platforms") s3c_pm_check_*() calls
are redundant and can be removed.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/suspend.c |    7 -------
 1 file changed, 7 deletions(-)

Index: b/arch/arm/mach-exynos/suspend.c
===================================================================
--- a/arch/arm/mach-exynos/suspend.c	2018-10-09 15:58:35.495122851 +0200
+++ b/arch/arm/mach-exynos/suspend.c	2018-10-15 15:08:52.420184244 +0200
@@ -508,7 +508,6 @@ static int exynos_suspend_enter(suspend_
 	if (pm_data->pm_prepare)
 		pm_data->pm_prepare();
 	flush_cache_all();
-	s3c_pm_check_store();
 
 	ret = call_firmware_op(suspend);
 	if (ret == -ENOSYS)
@@ -523,8 +522,6 @@ static int exynos_suspend_enter(suspend_
 	S3C_PMDBG("%s: wakeup stat: %08x\n", __func__,
 			pmu_raw_readl(S5P_WAKEUP_STAT));
 
-	s3c_pm_check_restore();
-
 	S3C_PMDBG("%s: resuming the system...\n", __func__);
 
 	return 0;
@@ -548,8 +545,6 @@ static int exynos_suspend_prepare(void)
 		return ret;
 	}
 
-	s3c_pm_check_prepare();
-
 	return 0;
 }
 
@@ -557,8 +552,6 @@ static void exynos_suspend_finish(void)
 {
 	int ret;
 
-	s3c_pm_check_cleanup();
-
 	ret = regulator_suspend_finish();
 	if (ret)
 		pr_warn("Failed to resume regulators from suspend (%d)\n", ret);
