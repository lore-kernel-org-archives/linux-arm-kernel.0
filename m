From: rob.lee@linaro.org (Robert Lee)
Date: Sun, 26 Feb 2012 22:47:41 -0600
Subject: [PATCH v5 7/9] ARM: exynos: Consolidate cpuidle functionality
In-Reply-To: <1330318063-25460-1-git-send-email-rob.lee@linaro.org>
References: <1330318063-25460-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1330318063-25460-8-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added core cpuidle functionality and remove this duplicated
code from the platform cpuidle.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c |   52 ++++------------------------------------
 1 files changed, 5 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 9bf6743..87f8e3f 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -34,22 +34,12 @@
 
 #define S5P_CHECK_AFTR		0xFCBA0D10
 
-static int exynos4_enter_idle(struct cpuidle_device *dev,
-			struct cpuidle_driver *drv,
-			      int index);
 static int exynos4_enter_lowpower(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index);
 
 static struct cpuidle_state exynos4_cpuidle_set[] = {
-	[0] = {
-		.enter			= exynos4_enter_idle,
-		.exit_latency		= 1,
-		.target_residency	= 100000,
-		.flags			= CPUIDLE_FLAG_TIME_VALID,
-		.name			= "C0",
-		.desc			= "ARM clock gating(WFI)",
-	},
+	[0] = CPUIDLE_ARM_WFI_STATE,
 	[1] = {
 		.enter			= exynos4_enter_lowpower,
 		.exit_latency		= 300,
@@ -63,8 +53,9 @@ static struct cpuidle_state exynos4_cpuidle_set[] = {
 static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device);
 
 static struct cpuidle_driver exynos4_idle_driver = {
-	.name		= "exynos4_idle",
-	.owner		= THIS_MODULE,
+	.name			= "exynos4_idle",
+	.owner			= THIS_MODULE,
+	.en_core_tk_irqen	= 1,
 };
 
 /* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
@@ -103,13 +94,8 @@ static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
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
@@ -148,34 +134,6 @@ static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
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
 
@@ -190,7 +148,7 @@ static int exynos4_enter_lowpower(struct cpuidle_device *dev,
 		new_index = drv->safe_state_index;
 
 	if (new_index == 0)
-		return exynos4_enter_idle(dev, drv, new_index);
+		return cpuidle_simple_enter(dev, drv, new_index);
 	else
 		return exynos4_enter_core0_aftr(dev, drv, new_index);
 }
-- 
1.7.1
