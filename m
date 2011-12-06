From: rob.lee@linaro.org (Robert Lee)
Date: Mon,  5 Dec 2011 22:38:05 -0600
Subject: [RFC PATCH 2/8] ARM: at91: Replace init with new common ARM cpuidle
 init code
In-Reply-To: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
References: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1323146291-10676-3-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace duplicated cpuidle init functionality with common ARM cpuidle
init implementation.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-at91/cpuidle.c |   68 ++++++++++++++---------------------------
 1 files changed, 23 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
index a851e6c..bd0bbfc 100644
--- a/arch/arm/mach-at91/cpuidle.c
+++ b/arch/arm/mach-at91/cpuidle.c
@@ -1,6 +1,4 @@
 /*
- * based on arch/arm/mach-kirkwood/cpuidle.c
- *
  * CPU idle support for AT91 SoC
  *
  * This file is licensed under the terms of the GNU General Public
@@ -17,19 +15,32 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/cpuidle.h>
-#include <asm/proc-fns.h>
 #include <linux/io.h>
 #include <linux/export.h>
-
+#include <asm/proc-fns.h>
+#include <asm/cpuidle.h>
 #include "pm.h"
 
-#define AT91_MAX_STATES	2
-
-static DEFINE_PER_CPU(struct cpuidle_device, at91_cpuidle_device);
+#define AT91_MAX_STATES 2
 
 static struct cpuidle_driver at91_idle_driver = {
 	.name =         "at91_idle",
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
+		.target_residency	= 100000,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "RAM_SR",
+		.desc			= "WFI and RAM Self Refresh",
+	},
+	.state_count = AT91_MAX_STATES,
 };
 
 /* Actual code that puts the SoC in different idle states */
@@ -37,12 +48,8 @@ static int at91_enter_idle(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			       int index)
 {
-	struct timeval before, after;
-	int idle_time;
 	u32 saved_lpr;
 
-	local_irq_disable();
-	do_gettimeofday(&before);
 	if (index == 0)
 		/* Wait for interrupt state */
 		cpu_do_idle();
@@ -53,48 +60,19 @@ static int at91_enter_idle(struct cpuidle_device *dev,
 		cpu_do_idle();
 		sdram_selfrefresh_disable(saved_lpr);
 	}
-	do_gettimeofday(&after);
-	local_irq_enable();
-	idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
-			(after.tv_usec - before.tv_usec);
 
-	dev->last_residency = idle_time;
 	return index;
 }
 
 /* Initialize CPU idle by registering the idle states */
 static int at91_init_cpuidle(void)
 {
-	struct cpuidle_device *device;
-	struct cpuidle_driver *driver = &at91_idle_driver;
+	int ret;
 
-	device = &per_cpu(at91_cpuidle_device, smp_processor_id());
-	device->state_count = AT91_MAX_STATES;
-	driver->state_count = AT91_MAX_STATES;
+	ret = arm_cpuidle_init(&at91_idle_driver,
+					at91_enter_idle,
+					NULL);
 
-	/* Wait for interrupt state */
-	driver->states[0].enter = at91_enter_idle;
-	driver->states[0].exit_latency = 1;
-	driver->states[0].target_residency = 10000;
-	driver->states[0].flags = CPUIDLE_FLAG_TIME_VALID;
-	strcpy(driver->states[0].name, "WFI");
-	strcpy(driver->states[0].desc, "Wait for interrupt");
-
-	/* Wait for interrupt and RAM self refresh state */
-	driver->states[1].enter = at91_enter_idle;
-	driver->states[1].exit_latency = 10;
-	driver->states[1].target_residency = 10000;
-	driver->states[1].flags = CPUIDLE_FLAG_TIME_VALID;
-	strcpy(driver->states[1].name, "RAM_SR");
-	strcpy(driver->states[1].desc, "WFI and RAM Self Refresh");
-
-	cpuidle_register_driver(&at91_idle_driver);
-
-	if (cpuidle_register_device(device)) {
-		printk(KERN_ERR "at91_init_cpuidle: Failed registering\n");
-		return -EIO;
-	}
-	return 0;
+	return ret;
 }
-
 device_initcall(at91_init_cpuidle);
-- 
1.7.1
