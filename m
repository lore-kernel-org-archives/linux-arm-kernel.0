From: rob.lee@linaro.org (Robert Lee)
Date: Mon,  5 Dec 2011 22:38:06 -0600
Subject: [RFC PATCH 3/8] ARM: kirkwood: Replace init with new common ARM
 cpuidle init code
In-Reply-To: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
References: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1323146291-10676-4-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace duplicated cpuidle init functionality with common ARM cpuidle
init implementation.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-kirkwood/cpuidle.c |   63 ++++++++++++-------------------------
 1 files changed, 21 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-kirkwood/cpuidle.c b/arch/arm/mach-kirkwood/cpuidle.c
index 7088180..6913ffd 100644
--- a/arch/arm/mach-kirkwood/cpuidle.c
+++ b/arch/arm/mach-kirkwood/cpuidle.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 #include <linux/export.h>
 #include <asm/proc-fns.h>
+#include <asm/cpuidle.h>
 #include <mach/kirkwood.h>
 
 #define KIRKWOOD_MAX_STATES	2
@@ -27,20 +28,28 @@
 static struct cpuidle_driver kirkwood_idle_driver = {
 	.name =         "kirkwood_idle",
 	.owner =        THIS_MODULE,
+	.states[0] = {
+		.exit_latency		= 1,
+		.target_residency	= 100000,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "WFI",
+		.desc			= "Wait for interrupt",
+	},
+	.states[1] = {
+		.exit_latency		= 10,
+		.target_residency	= 10000,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "DDR SR",
+		.desc			= "WFI and DDR Self Refresh",
+	},
+	.state_count = KIRKWOOD_MAX_STATES,
 };
 
-static DEFINE_PER_CPU(struct cpuidle_device, kirkwood_cpuidle_device);
-
 /* Actual code that puts the SoC in different idle states */
 static int kirkwood_enter_idle(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 			       int index)
 {
-	struct timeval before, after;
-	int idle_time;
-
-	local_irq_disable();
-	do_gettimeofday(&before);
 	if (index == 0)
 		/* Wait for interrupt state */
 		cpu_do_idle();
@@ -55,13 +64,6 @@ static int kirkwood_enter_idle(struct cpuidle_device *dev,
 		writel(0x7, DDR_OPERATION_BASE);
 		cpu_do_idle();
 	}
-	do_gettimeofday(&after);
-	local_irq_enable();
-	idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
-			(after.tv_usec - before.tv_usec);
-
-	/* Update last residency */
-	dev->last_residency = idle_time;
 
 	return index;
 }
@@ -69,35 +71,12 @@ static int kirkwood_enter_idle(struct cpuidle_device *dev,
 /* Initialize CPU idle by registering the idle states */
 static int kirkwood_init_cpuidle(void)
 {
-	struct cpuidle_device *device;
-	struct cpuidle_driver *driver = &kirkwood_idle_driver;
-
-	device = &per_cpu(kirkwood_cpuidle_device, smp_processor_id());
-	device->state_count = KIRKWOOD_MAX_STATES;
-	driver->state_count = KIRKWOOD_MAX_STATES;
+	int ret;
 
-	/* Wait for interrupt state */
-	driver->states[0].enter = kirkwood_enter_idle;
-	driver->states[0].exit_latency = 1;
-	driver->states[0].target_residency = 10000;
-	driver->states[0].flags = CPUIDLE_FLAG_TIME_VALID;
-	strcpy(driver->states[0].name, "WFI");
-	strcpy(driver->states[0].desc, "Wait for interrupt");
+	ret = arm_cpuidle_init(&kirkwood_idle_driver,
+					kirkwood_enter_idle,
+					NULL);
 
-	/* Wait for interrupt and DDR self refresh state */
-	driver->states[1].enter = kirkwood_enter_idle;
-	driver->states[1].exit_latency = 10;
-	driver->states[1].target_residency = 10000;
-	driver->states[1].flags = CPUIDLE_FLAG_TIME_VALID;
-	strcpy(driver->states[1].name, "DDR SR");
-	strcpy(driver->states[1].desc, "WFI and DDR Self Refresh");
-
-	cpuidle_register_driver(&kirkwood_idle_driver);
-	if (cpuidle_register_device(device)) {
-		printk(KERN_ERR "kirkwood_init_cpuidle: Failed registering\n");
-		return -EIO;
-	}
-	return 0;
+	return ret;
 }
-
 device_initcall(kirkwood_init_cpuidle);
-- 
1.7.1
