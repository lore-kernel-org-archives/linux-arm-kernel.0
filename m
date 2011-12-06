From: rob.lee@linaro.org (Robert Lee)
Date: Mon,  5 Dec 2011 22:38:07 -0600
Subject: [RFC PATCH 4/8] ARM: exynos: Replace init with new common ARM cpuidle
 init code
In-Reply-To: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
References: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1323146291-10676-5-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace duplicated cpuidle init functionality with common ARM cpuidle
init implementation.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c |   66 +++++++--------------------------------
 1 files changed, 12 insertions(+), 54 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 4ebb382..a21b7da 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -13,80 +13,38 @@
 #include <linux/cpuidle.h>
 #include <linux/io.h>
 #include <linux/export.h>
-#include <linux/time.h>
-
 #include <asm/proc-fns.h>
+#include <asm/cpuidle.h>
 
-static int exynos4_enter_idle(struct cpuidle_device *dev,
-			struct cpuidle_driver *drv,
-			      int index);
-
-static struct cpuidle_state exynos4_cpuidle_set[] = {
-	[0] = {
-		.enter			= exynos4_enter_idle,
+static struct cpuidle_driver exynos4_idle_driver = {
+	.name		= "exynos4_idle",
+	.owner		= THIS_MODULE,
+	.states[0] = {
 		.exit_latency		= 1,
 		.target_residency	= 100000,
 		.flags			= CPUIDLE_FLAG_TIME_VALID,
 		.name			= "IDLE",
 		.desc			= "ARM clock gating(WFI)",
 	},
-};
-
-static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device);
-
-static struct cpuidle_driver exynos4_idle_driver = {
-	.name		= "exynos4_idle",
-	.owner		= THIS_MODULE,
+	.state_count = 1,
 };
 
 static int exynos4_enter_idle(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
+			struct cpuidle_driver *drv,
 			      int index)
 {
-	struct timeval before, after;
-	int idle_time;
-
-	local_irq_disable();
-	do_gettimeofday(&before);
-
 	cpu_do_idle();
 
-	do_gettimeofday(&after);
-	local_irq_enable();
-	idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
-		    (after.tv_usec - before.tv_usec);
-
-	dev->last_residency = idle_time;
 	return index;
 }
 
 static int __init exynos4_init_cpuidle(void)
 {
-	int i, max_cpuidle_state, cpu_id;
-	struct cpuidle_device *device;
-	struct cpuidle_driver *drv = &exynos4_idle_driver;
-
-	/* Setup cpuidle driver */
-	drv->state_count = (sizeof(exynos4_cpuidle_set) /
-				       sizeof(struct cpuidle_state));
-	max_cpuidle_state = drv->state_count;
-	for (i = 0; i < max_cpuidle_state; i++) {
-		memcpy(&drv->states[i], &exynos4_cpuidle_set[i],
-				sizeof(struct cpuidle_state));
-	}
-	cpuidle_register_driver(&exynos4_idle_driver);
-
-	for_each_cpu(cpu_id, cpu_online_mask) {
-		device = &per_cpu(exynos4_cpuidle_device, cpu_id);
-		device->cpu = cpu_id;
-
-		device->state_count = drv->state_count;
+	int ret;
 
-		if (cpuidle_register_device(device)) {
-			printk(KERN_ERR "CPUidle register device failed\n,");
-			return -EIO;
-		}
-	}
-	return 0;
+	ret = arm_cpuidle_init(&exynos4_idle_driver,
+					exynos4_enter_idle,
+					NULL);
+	return ret;
 }
 device_initcall(exynos4_init_cpuidle);
-- 
1.7.1
