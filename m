From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 10 Apr 2014 11:55:33 +0200
Subject: [PATCH V4 02/20] ARM: exynos: cpuidle: Use cpuidle_register
In-Reply-To: <1397123751-1957-1-git-send-email-daniel.lezcano@linaro.org>
References: <1397123751-1957-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1397123751-1957-3-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the cpuidle generic function 'cpuidle_register'. That saves us from some
extra lines of code and unneeded variables.

A side effect of this change is a bug fix where before the cpuidle driver was
registered for each_online_cpu and now it is for each_possible_cpu.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/cpuidle.c |   18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 9623a05..b7cd75b 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -59,8 +59,6 @@
 #define PWR_CTRL2_CORE2_UP_RATIO		(1 << 4)
 #define PWR_CTRL2_CORE1_UP_RATIO		(1 << 0)
 
-static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device);
-
 /* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
 static void exynos4_set_wakeupmask(void)
 {
@@ -211,8 +209,7 @@ static struct cpuidle_driver exynos4_idle_driver = {
 
 static int exynos_cpuidle_probe(struct platform_device *pdev)
 {
-	int cpu_id, ret;
-	struct cpuidle_device *device;
+	int ret;
 
 	if (soc_is_exynos5250())
 		exynos5_core_down_clk();
@@ -220,23 +217,12 @@ static int exynos_cpuidle_probe(struct platform_device *pdev)
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
