From: rob.lee@linaro.org (Robert Lee)
Date: Mon,  5 Dec 2011 22:38:08 -0600
Subject: [RFC PATCH 5/8] ARM: davinci: Replace init with new common ARM
 cpuidle init code
In-Reply-To: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
References: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1323146291-10676-6-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace duplicated cpuidle init functionality with common ARM cpuidle
init implementation.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-davinci/cpuidle.c |   73 ++++++++++++--------------------------
 1 files changed, 23 insertions(+), 50 deletions(-)

diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index a30c7c5..d154c56 100644
--- a/arch/arm/mach-davinci/cpuidle.c
+++ b/arch/arm/mach-davinci/cpuidle.c
@@ -18,7 +18,7 @@
 #include <linux/io.h>
 #include <linux/export.h>
 #include <asm/proc-fns.h>
-
+#include <asm/cpuidle.h>
 #include <mach/cpuidle.h>
 #include <mach/ddr2.h>
 
@@ -36,9 +36,23 @@ struct davinci_ops {
 static struct cpuidle_driver davinci_idle_driver = {
 	.name	= "cpuidle-davinci",
 	.owner	= THIS_MODULE,
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
+		.name			= "DDR SR",
+		.desc			= "WFI and DDR Self Refresh",
+	},
+	.state_count = DAVINCI_CPUIDLE_MAX_STATES,
 };
 
-static DEFINE_PER_CPU(struct cpuidle_device, davinci_cpuidle_device);
 static void __iomem *ddr2_reg_base;
 
 static void davinci_save_ddr_power(int enter, bool pdown)
@@ -77,6 +91,8 @@ static struct davinci_ops davinci_states[DAVINCI_CPUIDLE_MAX_STATES] = {
 	},
 };
 
+void *states_usage_driver_data[DAVINCI_CPUIDLE_MAX_STATES] __initdata;
+
 /* Actual code that puts the SoC in different idle states */
 static int davinci_enter_idle(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
@@ -84,11 +100,6 @@ static int davinci_enter_idle(struct cpuidle_device *dev,
 {
 	struct cpuidle_state_usage *state_usage = &dev->states_usage[index];
 	struct davinci_ops *ops = cpuidle_get_statedata(state_usage);
-	struct timeval before, after;
-	int idle_time;
-
-	local_irq_disable();
-	do_gettimeofday(&before);
 
 	if (ops && ops->enter)
 		ops->enter(ops->flags);
@@ -97,25 +108,14 @@ static int davinci_enter_idle(struct cpuidle_device *dev,
 	if (ops && ops->exit)
 		ops->exit(ops->flags);
 
-	do_gettimeofday(&after);
-	local_irq_enable();
-	idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
-			(after.tv_usec - before.tv_usec);
-
-	dev->last_residency = idle_time;
-
 	return index;
 }
 
 static int __init davinci_cpuidle_probe(struct platform_device *pdev)
 {
 	int ret;
-	struct cpuidle_device *device;
-	struct cpuidle_driver *driver = &davinci_idle_driver;
 	struct davinci_cpuidle_config *pdata = pdev->dev.platform_data;
 
-	device = &per_cpu(davinci_cpuidle_device, smp_processor_id());
-
 	if (!pdata) {
 		dev_err(&pdev->dev, "cannot get platform data\n");
 		return -ENOENT;
@@ -123,42 +123,16 @@ static int __init davinci_cpuidle_probe(struct platform_device *pdev)
 
 	ddr2_reg_base = pdata->ddr2_ctlr_base;
 
-	/* Wait for interrupt state */
-	driver->states[0].enter = davinci_enter_idle;
-	driver->states[0].exit_latency = 1;
-	driver->states[0].target_residency = 10000;
-	driver->states[0].flags = CPUIDLE_FLAG_TIME_VALID;
-	strcpy(driver->states[0].name, "WFI");
-	strcpy(driver->states[0].desc, "Wait for interrupt");
-
-	/* Wait for interrupt and DDR self refresh state */
-	driver->states[1].enter = davinci_enter_idle;
-	driver->states[1].exit_latency = 10;
-	driver->states[1].target_residency = 10000;
-	driver->states[1].flags = CPUIDLE_FLAG_TIME_VALID;
-	strcpy(driver->states[1].name, "DDR SR");
-	strcpy(driver->states[1].desc, "WFI and DDR Self Refresh");
 	if (pdata->ddr2_pdown)
 		davinci_states[1].flags |= DAVINCI_CPUIDLE_FLAGS_DDR2_PWDN;
-	cpuidle_set_statedata(&device->states_usage[1], &davinci_states[1]);
-
-	device->state_count = DAVINCI_CPUIDLE_MAX_STATES;
-	driver->state_count = DAVINCI_CPUIDLE_MAX_STATES;
 
-	ret = cpuidle_register_driver(&davinci_idle_driver);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register driver\n");
-		return ret;
-	}
+	states_usage_driver_data[1] = &davinci_states[1];
 
-	ret = cpuidle_register_device(device);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register device\n");
-		cpuidle_unregister_driver(&davinci_idle_driver);
-		return ret;
-	}
+	ret = arm_cpuidle_init(&davinci_idle_driver,
+				davinci_enter_idle,
+				states_usage_driver_data);
 
-	return 0;
+	return ret;
 }
 
 static struct platform_driver davinci_cpuidle_driver = {
@@ -174,4 +148,3 @@ static int __init davinci_cpuidle_init(void)
 						davinci_cpuidle_probe);
 }
 device_initcall(davinci_cpuidle_init);
-
-- 
1.7.1
