From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri,  4 Jan 2013 17:59:58 +0100
Subject: [PATCH 4/5] ARM: exynos: only register cpuidle for cpu0
In-Reply-To: <1357318799-24378-1-git-send-email-daniel.lezcano@linaro.org>
References: <1357318799-24378-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1357318799-24378-4-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We register the device for cpu1 but with only one state which
is actually WFI. This one is already the default idle function
when no cpuidle device is set for the cpu.

We can remove the cpuidle device for this cpu as it is the same
code path than the pm_idle callback.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c |   22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 6e90bed..e6f006b 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -40,7 +40,7 @@ static int exynos4_enter_lowpower(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index);
 
-static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device);
+static struct cpuidle_device exynos4_cpuidle_device;
 
 static struct cpuidle_driver exynos4_idle_driver = {
 	.name			= "exynos4_idle",
@@ -193,8 +193,7 @@ static void __init exynos5_core_down_clk(void)
 
 static int __init exynos4_init_cpuidle(void)
 {
-	int cpu_id, ret;
-	struct cpuidle_device *device;
+	int ret;
 
 	if (soc_is_exynos5250())
 		exynos5_core_down_clk();
@@ -205,19 +204,10 @@ static int __init exynos4_init_cpuidle(void)
 		return ret;
 	}
 
-	for_each_online_cpu(cpu_id) {
-		device = &per_cpu(exynos4_cpuidle_device, cpu_id);
-		device->cpu = cpu_id;
-
-                /* Support IDLE only */
-		if (cpu_id != 0)
-			device->state_count = 1;
-
-		ret = cpuidle_register_device(device);
-		if (ret) {
-			printk(KERN_ERR "CPUidle register device failed\n");
-			return ret;
-		}
+	ret = cpuidle_register_device(&exynos4_cpuidle_device);
+	if (ret) {
+		printk(KERN_ERR "CPUidle register device failed\n");
+		return ret;
 	}
 
 	return 0;
-- 
1.7.9.5
