From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri,  4 Apr 2014 09:47:48 +0200
Subject: [PATCH 02/17] ARM: exynos: cpuidle: use cpuidle_register
In-Reply-To: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1396597683-6969-3-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the cpuidle generic function 'cpuidle_register'. That saves us from some
extra lines of code and unneeded variables.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c |   18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index bd2142a..b9e9a90 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -60,8 +60,6 @@
 #define PWR_CTRL2_CORE2_UP_RATIO		(1 << 4)
 #define PWR_CTRL2_CORE1_UP_RATIO		(1 << 0)
 
-static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device);
-
 /* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
 static void exynos4_set_wakeupmask(void)
 {
@@ -212,8 +210,7 @@ static struct cpuidle_driver exynos4_idle_driver = {
 
 static int exynos_cpuidle_probe(struct platform_device *pdev)
 {
-	int cpu_id, ret;
-	struct cpuidle_device *device;
+	int ret;
 
 	if (soc_is_exynos5250())
 		exynos5_core_down_clk();
@@ -221,23 +218,12 @@ static int exynos_cpuidle_probe(struct platform_device *pdev)
 	if (soc_is_exynos5440())
 		exynos4_idle_driver.state_count = 1;
 
-	ret = cpuidle_register_driver(&exynos4_idle_driver);
+	ret = cpuidle_register(&exynos4_idle_driver, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register cpuidle driver\n");
 		return ret;
 	}
 
-	for_each_online_cpu(cpu_id) {
-		device = &per_cpu(exynos4_cpuidle_device, cpu_id);
-		device->cpu = cpu_id;
-
-		ret = cpuidle_register_device(device);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to register cpuidle device\n");
-			return ret;
-		}
-	}
-
 	return 0;
 }
 
-- 
1.7.9.5
