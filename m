From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 11 Apr 2014 12:39:59 +0200
Subject: [PATCH V5 04/20] ARM: exynos: cpuidle: Change function name prefix
In-Reply-To: <1397212815-16068-1-git-send-email-daniel.lezcano@linaro.org>
References: <1397212815-16068-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1397212815-16068-5-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver was initially written for exynos4 but the driver is used also for
exynos5.

Change the function prefix name exynos4 -> exynos

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/cpuidle.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 61e1481..f565186 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -1,4 +1,4 @@
-/* linux/arch/arm/mach-exynos4/cpuidle.c
+/* linux/arch/arm/mach-exynos/cpuidle.c
  *
  * Copyright (c) 2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
@@ -41,7 +41,7 @@
 #define S5P_CHECK_AFTR		0xFCBA0D10
 
 /* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
-static void exynos4_set_wakeupmask(void)
+static void exynos_set_wakeupmask(void)
 {
 	__raw_writel(0x0000ff3e, S5P_WAKEUP_MASK);
 }
@@ -72,13 +72,13 @@ static int idle_finisher(unsigned long flags)
 	return 1;
 }
 
-static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
+static int exynos_enter_core0_aftr(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index)
 {
 	unsigned long tmp;
 
-	exynos4_set_wakeupmask();
+	exynos_set_wakeupmask();
 
 	/* Set value of power down register for aftr mode */
 	exynos_sys_powerdown_conf(SYS_AFTR);
@@ -122,7 +122,7 @@ static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
 	return index;
 }
 
-static int exynos4_enter_lowpower(struct cpuidle_device *dev,
+static int exynos_enter_lowpower(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index)
 {
@@ -135,16 +135,16 @@ static int exynos4_enter_lowpower(struct cpuidle_device *dev,
 	if (new_index == 0)
 		return arm_cpuidle_simple_enter(dev, drv, new_index);
 	else
-		return exynos4_enter_core0_aftr(dev, drv, new_index);
+		return exynos_enter_core0_aftr(dev, drv, new_index);
 }
 
-static struct cpuidle_driver exynos4_idle_driver = {
-	.name			= "exynos4_idle",
+static struct cpuidle_driver exynos_idle_driver = {
+	.name			= "exynos_idle",
 	.owner			= THIS_MODULE,
 	.states = {
 		[0] = ARM_CPUIDLE_WFI_STATE,
 		[1] = {
-			.enter			= exynos4_enter_lowpower,
+			.enter			= exynos_enter_lowpower,
 			.exit_latency		= 300,
 			.target_residency	= 100000,
 			.flags			= CPUIDLE_FLAG_TIME_VALID,
@@ -161,9 +161,9 @@ static int exynos_cpuidle_probe(struct platform_device *pdev)
 	int ret;
 
 	if (soc_is_exynos5440())
-		exynos4_idle_driver.state_count = 1;
+		exynos_idle_driver.state_count = 1;
 
-	ret = cpuidle_register(&exynos4_idle_driver, NULL);
+	ret = cpuidle_register(&exynos_idle_driver, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register cpuidle driver\n");
 		return ret;
-- 
1.7.9.5
