From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri,  4 Jan 2013 17:59:55 +0100
Subject: [PATCH 1/5] ARM: exynos: factor out the idle states
Message-ID: <1357318799-24378-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The states are defined in the driver. We can get rid of the
intermediate cpuidle states initialization and the memcpy by
directly initializing the driver states.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c |   45 +++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 0509241..f8dd1cd 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -40,24 +40,25 @@ static int exynos4_enter_lowpower(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index);
 
-static struct cpuidle_state exynos4_cpuidle_set[] __initdata = {
-	[0] = ARM_CPUIDLE_WFI_STATE,
-	[1] = {
-		.enter			= exynos4_enter_lowpower,
-		.exit_latency		= 300,
-		.target_residency	= 100000,
-		.flags			= CPUIDLE_FLAG_TIME_VALID,
-		.name			= "C1",
-		.desc			= "ARM power down",
-	},
-};
-
 static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device);
 
 static struct cpuidle_driver exynos4_idle_driver = {
 	.name			= "exynos4_idle",
 	.owner			= THIS_MODULE,
 	.en_core_tk_irqen	= 1,
+	.states = {
+		[0] = ARM_CPUIDLE_WFI_STATE,
+		[1] = {
+			.enter            = exynos4_enter_lowpower,
+			.exit_latency     = 300,
+			.target_residency = 100000,
+			.flags            = CPUIDLE_FLAG_TIME_VALID,
+			.name             = "C1",
+			.desc             = "ARM power down",
+		},
+	},
+	.state_count = 2,
+	.safe_state_index = 0,
 };
 
 /* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
@@ -192,33 +193,21 @@ static void __init exynos5_core_down_clk(void)
 
 static int __init exynos4_init_cpuidle(void)
 {
-	int i, max_cpuidle_state, cpu_id;
+	int cpu_id;
 	struct cpuidle_device *device;
-	struct cpuidle_driver *drv = &exynos4_idle_driver;
 
 	if (soc_is_exynos5250())
 		exynos5_core_down_clk();
 
-	/* Setup cpuidle driver */
-	drv->state_count = (sizeof(exynos4_cpuidle_set) /
-				       sizeof(struct cpuidle_state));
-	max_cpuidle_state = drv->state_count;
-	for (i = 0; i < max_cpuidle_state; i++) {
-		memcpy(&drv->states[i], &exynos4_cpuidle_set[i],
-				sizeof(struct cpuidle_state));
-	}
-	drv->safe_state_index = 0;
 	cpuidle_register_driver(&exynos4_idle_driver);
 
 	for_each_cpu(cpu_id, cpu_online_mask) {
 		device = &per_cpu(exynos4_cpuidle_device, cpu_id);
 		device->cpu = cpu_id;
 
-		if (cpu_id == 0)
-			device->state_count = (sizeof(exynos4_cpuidle_set) /
-					       sizeof(struct cpuidle_state));
-		else
-			device->state_count = 1;	/* Support IDLE only */
+                /* Support IDLE only */
+		if (cpu_id != 0)
+			device->state_count = 1;
 
 		if (cpuidle_register_device(device)) {
 			printk(KERN_ERR "CPUidle register device failed\n,");
-- 
1.7.9.5
