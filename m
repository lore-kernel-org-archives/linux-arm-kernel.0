From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 05 Sep 2014 15:51:27 +0200
Subject: [PATCH v6 4/5] ARM: EXYNOS: PM: fix register setup for AFTR mode code
In-Reply-To: <1409925088-4705-1-git-send-email-b.zolnierkie@samsung.com>
References: <1409925088-4705-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1409925088-4705-5-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add S5P_CENTRAL_SEQ_OPTION register setup to cpuidle AFTR mode code
by moving the relevant code from exynos_pm_suspend() (used only by
suspend) to exynos_pm_central_suspend() (used by both suspend and
AFTR).  Without this setup AFTR mode doesn't show any benefit over
WFI one (at least on Exynos4412 SoC).  When this setup is applied
AFTR mode reduces power consumption by ~12% (as measured on Trats2
board).

This change is a preparation for adding secure firmware support to
EXYNOS cpuidle driver.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
v6:
- no changes

 arch/arm/mach-exynos/pm.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index e0b6885..3cee123 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -169,6 +169,10 @@ static void exynos_pm_central_suspend(void)
 	tmp = pmu_raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
 	tmp &= ~S5P_CENTRAL_LOWPWR_CFG;
 	pmu_raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
+
+	/* Setting SEQ_OPTION register */
+	pmu_raw_writel(S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0,
+		       S5P_CENTRAL_SEQ_OPTION);
 }
 
 static int exynos_pm_central_resume(void)
@@ -291,15 +295,8 @@ static void exynos_pm_prepare(void)
 
 static int exynos_pm_suspend(void)
 {
-	unsigned long tmp;
-
 	exynos_pm_central_suspend();
 
-	/* Setting SEQ_OPTION register */
-
-	tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
-	pmu_raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
-
 	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9)
 		exynos_cpu_save_register();
 
-- 
1.8.2.3
