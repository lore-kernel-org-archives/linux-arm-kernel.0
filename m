From: amit.kachhap@linaro.org (Amit Daniel Kachhap)
Date: Wed, 25 Apr 2012 17:41:52 +0530
Subject: [PATCH] ARM: exynos: Adapt to cpuidle core time keeping and irq enable
Message-ID: <1335355912-26063-1-git-send-email-amit.kachhap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables core cpuidle timekeeping and irq enabling and
remove those redundant parts from the exynos cpuidle drivers

CC: Daniel Lezcano <daniel.lezcano@linaro.org>
CC: Robert Lee <rob.lee@linaro.org>
Signed-off-by: Amit Daniel <amit.kachhap@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c |   53 ++++-----------------------------------
 1 files changed, 6 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 33ab4e7..26dac28 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -20,6 +20,7 @@
 #include <asm/smp_scu.h>
 #include <asm/suspend.h>
 #include <asm/unified.h>
+#include <asm/cpuidle.h>
 #include <mach/regs-pmu.h>
 #include <mach/pmu.h>
 
@@ -34,22 +35,12 @@
 
 #define S5P_CHECK_AFTR		0xFCBA0D10
 
-static int exynos4_enter_idle(struct cpuidle_device *dev,
-			struct cpuidle_driver *drv,
-			      int index);
 static int exynos4_enter_lowpower(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index);
 
 static struct cpuidle_state exynos4_cpuidle_set[] __initdata = {
-	[0] = {
-		.enter			= exynos4_enter_idle,
-		.exit_latency		= 1,
-		.target_residency	= 100000,
-		.flags			= CPUIDLE_FLAG_TIME_VALID,
-		.name			= "C0",
-		.desc			= "ARM clock gating(WFI)",
-	},
+	[0] = ARM_CPUIDLE_WFI_STATE,
 	[1] = {
 		.enter			= exynos4_enter_lowpower,
 		.exit_latency		= 300,
@@ -63,8 +54,9 @@ static struct cpuidle_state exynos4_cpuidle_set[] __initdata = {
 static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device);
 
 static struct cpuidle_driver exynos4_idle_driver = {
-	.name		= "exynos4_idle",
-	.owner		= THIS_MODULE,
+	.name			= "exynos4_idle",
+	.owner			= THIS_MODULE,
+	.en_core_tk_irqen	= 1,
 };
 
 /* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
@@ -103,13 +95,8 @@ static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index)
 {
-	struct timeval before, after;
-	int idle_time;
 	unsigned long tmp;
 
-	local_irq_disable();
-	do_gettimeofday(&before);
-
 	exynos4_set_wakeupmask();
 
 	/* Set value of power down register for aftr mode */
@@ -150,34 +137,6 @@ static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
 	/* Clear wakeup state register */
 	__raw_writel(0x0, S5P_WAKEUP_STAT);
 
-	do_gettimeofday(&after);
-
-	local_irq_enable();
-	idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
-		    (after.tv_usec - before.tv_usec);
-
-	dev->last_residency = idle_time;
-	return index;
-}
-
-static int exynos4_enter_idle(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
-				int index)
-{
-	struct timeval before, after;
-	int idle_time;
-
-	local_irq_disable();
-	do_gettimeofday(&before);
-
-	cpu_do_idle();
-
-	do_gettimeofday(&after);
-	local_irq_enable();
-	idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
-		    (after.tv_usec - before.tv_usec);
-
-	dev->last_residency = idle_time;
 	return index;
 }
 
@@ -192,7 +151,7 @@ static int exynos4_enter_lowpower(struct cpuidle_device *dev,
 		new_index = drv->safe_state_index;
 
 	if (new_index == 0)
-		return exynos4_enter_idle(dev, drv, new_index);
+		return arm_cpuidle_simple_enter(dev, drv, new_index);
 	else
 		return exynos4_enter_core0_aftr(dev, drv, new_index);
 }
-- 
1.7.1
