From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue,  8 Apr 2014 14:19:32 +0200
Subject: [PATCH V3 10/17] ARM: exynos: cpuidle: Move exynos_set_wakeupmask in
 the cpu_pm notifier
In-Reply-To: <1396959579-18268-1-git-send-email-daniel.lezcano@linaro.org>
References: <1396959579-18268-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1396959579-18268-11-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's encapsulate more the PM code inside the PM file by moving the
'exynos_set_wakeupmask' function inside the pm.c and the call in the cpu_pm
notifier.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/cpuidle.c |    7 -------
 arch/arm/mach-exynos/pm.c      |    7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index ce31004..01444ed 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -58,15 +58,8 @@
 #define PWR_CTRL2_CORE2_UP_RATIO		(1 << 4)
 #define PWR_CTRL2_CORE1_UP_RATIO		(1 << 0)
 
-/* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
-static void exynos_set_wakeupmask(void)
-{
-	__raw_writel(0x0000ff3e, S5P_WAKEUP_MASK);
-}
-
 static int idle_finisher(unsigned long flags)
 {
-	exynos_set_wakeupmask();
 
 	__raw_writel(virt_to_phys(s3c_cpu_resume), REG_DIRECTGO_ADDR);
 	__raw_writel(S5P_CHECK_AFTR, REG_DIRECTGO_FLAG);
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 9773a00..c8b3dc4 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -322,6 +322,12 @@ static const struct platform_suspend_ops exynos_suspend_ops = {
 	.valid		= suspend_valid_only_mem,
 };
 
+/* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
+static void exynos_set_wakeupmask(void)
+{
+	__raw_writel(0x0000ff3e, S5P_WAKEUP_MASK);
+}
+
 static int exynos_cpu_pm_notifier(struct notifier_block *self,
 				  unsigned long cmd, void *v)
 {
@@ -331,6 +337,7 @@ static int exynos_cpu_pm_notifier(struct notifier_block *self,
 	case CPU_PM_ENTER:
 		if (cpu == 0) {
 			exynos_cpu_save_register();
+			exynos_set_wakeupmask();
 		}
 		break;
 
-- 
1.7.9.5
