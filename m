From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 10 Apr 2014 11:55:47 +0200
Subject: [PATCH V4 16/20] ARM: exynos: cpuidle: Move the power sequence call
 in the cpu_pm notifier
In-Reply-To: <1397123751-1957-1-git-send-email-daniel.lezcano@linaro.org>
References: <1397123751-1957-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1397123751-1957-17-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code to initiate and exit the powerdown sequence is the same in pm.c and
cpuidle.c.

Let's split the common part in the pm.c and reuse it from the cpu_pm notifier.

That is one more step forward to make the cpuidle driver arch indenpendant.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/cpuidle.c |   22 ----------------------
 arch/arm/mach-exynos/pm.c      |   24 ++++++++++++++++++++----
 2 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 5c5a4d1..0651293 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -28,7 +28,6 @@
 #include <mach/map.h>
 
 #include "common.h"
-#include "regs-pmu.h"
 
 static int idle_finisher(unsigned long flags)
 {
@@ -42,31 +41,10 @@ static int exynos_enter_core0_aftr(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index)
 {
-	unsigned long tmp;
-
-	/* Setting Central Sequence Register for power down mode */
-	tmp = __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
-	tmp &= ~S5P_CENTRAL_LOWPWR_CFG;
-	__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
-
 	cpu_pm_enter();
 	cpu_suspend(0, idle_finisher);
 	cpu_pm_exit();
 
-	/*
-	 * If PMU failed while entering sleep mode, WFI will be
-	 * ignored by PMU and then exiting cpu_do_idle().
-	 * S5P_CENTRAL_LOWPWR_CFG bit will not be set automatically
-	 * in this situation.
-	 */
-	tmp = __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
-	if (!(tmp & S5P_CENTRAL_LOWPWR_CFG)) {
-		tmp |= S5P_CENTRAL_LOWPWR_CFG;
-		__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
-		/* Clear wakeup state register */
-		__raw_writel(0x0, S5P_WAKEUP_STAT);
-	}
-
 	return index;
 }
 
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index f75d9b9..a943e97 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -245,15 +245,21 @@ static void exynos_pm_prepare(void)
 	__raw_writel(virt_to_phys(exynos_cpu_resume), S5P_INFORM0);
 }
 
-static int exynos_pm_suspend(void)
+static void exynos_pm_central_suspend(void)
 {
 	unsigned long tmp;
 
 	/* Setting Central Sequence Register for power down mode */
-
 	tmp = __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
 	tmp &= ~S5P_CENTRAL_LOWPWR_CFG;
 	__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
+}
+
+static int exynos_pm_suspend(void)
+{
+	unsigned long tmp;
+
+	exynos_pm_central_suspend();
 
 	/* Setting SEQ_OPTION register */
 
@@ -266,7 +272,7 @@ static int exynos_pm_suspend(void)
 	return 0;
 }
 
-static void exynos_pm_resume(void)
+static int exynos_pm_central_resume(void)
 {
 	unsigned long tmp;
 
@@ -283,9 +289,17 @@ static void exynos_pm_resume(void)
 		/* clear the wakeup state register */
 		__raw_writel(0x0, S5P_WAKEUP_STAT);
 		/* No need to perform below restore code */
-		goto early_wakeup;
+		return -1;
 	}
 
+	return 0;
+}
+
+static void exynos_pm_resume(void)
+{
+	if (exynos_pm_central_resume())
+		goto early_wakeup;
+
 	if (!soc_is_exynos5250())
 		exynos_cpu_restore_register();
 
@@ -394,6 +408,7 @@ static int exynos_cpu_pm_notifier(struct notifier_block *self,
 	switch (cmd) {
 	case CPU_PM_ENTER:
 		if (cpu == 0) {
+			exynos_pm_central_suspend();
 			exynos_cpu_save_register();
 		}
 		break;
@@ -403,6 +418,7 @@ static int exynos_cpu_pm_notifier(struct notifier_block *self,
 			if (!soc_is_exynos5250())
 				scu_enable(S5P_VA_SCU);
 			exynos_cpu_restore_register();
+			exynos_pm_central_resume();
 		}
 		break;
 	}
-- 
1.7.9.5
