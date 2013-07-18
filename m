From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 18 Jul 2013 14:54:27 +0200
Subject: [PATCH 1/4] ARM: exynos: cpuidle: Fallback to WFI,
 when AFTR is selected
Message-ID: <1374152070-21008-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When there are several cpus online, the AFTR state does not work.

The AFTR must be selected only when there is one cpu online.

The previous code was already handling this case.

Simplified the code, especially the init routine to have the same init
pattern than the other drivers.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 17a18ff..cc4b097 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -147,16 +147,11 @@ static int exynos4_enter_lowpower(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index)
 {
-	int new_index = index;
-
 	/* This mode only can be entered when other core's are offline */
 	if (num_online_cpus() > 1)
-		new_index = drv->safe_state_index;
+		return drv->states[0].enter(dev, drv, 0);
 
-	if (new_index == 0)
-		return arm_cpuidle_simple_enter(dev, drv, new_index);
-	else
-		return exynos4_enter_core0_aftr(dev, drv, new_index);
+	return exynos4_enter_core0_aftr(dev, drv, index);
 }
 
 static void __init exynos5_core_down_clk(void)
@@ -209,10 +204,6 @@ static int __init exynos4_init_cpuidle(void)
 		device = &per_cpu(exynos4_cpuidle_device, cpu_id);
 		device->cpu = cpu_id;
 
-		/* Support IDLE only */
-		if (cpu_id != 0)
-			device->state_count = 1;
-
 		ret = cpuidle_register_device(device);
 		if (ret) {
 			printk(KERN_ERR "CPUidle register device failed\n");
-- 
1.7.9.5
