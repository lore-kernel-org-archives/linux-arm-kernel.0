From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri,  4 Jan 2013 17:59:56 +0100
Subject: [PATCH 2/5] ARM: exynos: handle properly the return values
In-Reply-To: <1357318799-24378-1-git-send-email-daniel.lezcano@linaro.org>
References: <1357318799-24378-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1357318799-24378-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpuidle_register_driver return value is not checked.
The init function returns always -EIO when cpuidle_register_device
fails but the error could be different.

This patch fixes that by checking the cpuidle_register_driver properly
and returning the correct value when cpuidle_register_device fails.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index f8dd1cd..a5fe194 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -193,13 +193,17 @@ static void __init exynos5_core_down_clk(void)
 
 static int __init exynos4_init_cpuidle(void)
 {
-	int cpu_id;
+	int cpu_id, ret;
 	struct cpuidle_device *device;
 
 	if (soc_is_exynos5250())
 		exynos5_core_down_clk();
 
-	cpuidle_register_driver(&exynos4_idle_driver);
+	ret = cpuidle_register_driver(&exynos4_idle_driver);
+	if (ret) {
+		printk(KERN_ERR "CPUidle failed to register driver\n");
+		return ret;
+	}
 
 	for_each_cpu(cpu_id, cpu_online_mask) {
 		device = &per_cpu(exynos4_cpuidle_device, cpu_id);
@@ -209,9 +213,10 @@ static int __init exynos4_init_cpuidle(void)
 		if (cpu_id != 0)
 			device->state_count = 1;
 
-		if (cpuidle_register_device(device)) {
-			printk(KERN_ERR "CPUidle register device failed\n,");
-			return -EIO;
+		ret = cpuidle_register_device(device);
+		if (ret) {
+			printk(KERN_ERR "CPUidle register device failed\n");
+			return ret;
 		}
 	}
 
-- 
1.7.9.5
