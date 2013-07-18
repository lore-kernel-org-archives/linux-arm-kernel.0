From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 18 Jul 2013 14:54:28 +0200
Subject: [PATCH 2/4] ARM: exynos: cpuidle: Use the common cpuidle register
 routine
In-Reply-To: <1374152070-21008-1-git-send-email-daniel.lezcano@linaro.org>
References: <1374152070-21008-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1374152070-21008-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now we have the same routine than the one handled by the cpuidle framework.

Let's use it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c |   24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index cc4b097..d8fc1a2 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -41,8 +41,6 @@ static int exynos4_enter_lowpower(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index);
 
-static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device);
-
 static struct cpuidle_driver exynos4_idle_driver = {
 	.name			= "exynos4_idle",
 	.owner			= THIS_MODULE,
@@ -188,29 +186,9 @@ static void __init exynos5_core_down_clk(void)
 
 static int __init exynos4_init_cpuidle(void)
 {
-	int cpu_id, ret;
-	struct cpuidle_device *device;
-
 	if (soc_is_exynos5250())
 		exynos5_core_down_clk();
 
-	ret = cpuidle_register_driver(&exynos4_idle_driver);
-	if (ret) {
-		printk(KERN_ERR "CPUidle failed to register driver\n");
-		return ret;
-	}
-
-	for_each_online_cpu(cpu_id) {
-		device = &per_cpu(exynos4_cpuidle_device, cpu_id);
-		device->cpu = cpu_id;
-
-		ret = cpuidle_register_device(device);
-		if (ret) {
-			printk(KERN_ERR "CPUidle register device failed\n");
-			return ret;
-		}
-	}
-
-	return 0;
+	return cpuidle_register(&exynos4_idle_driver, NULL);
 }
 device_initcall(exynos4_init_cpuidle);
-- 
1.7.9.5
