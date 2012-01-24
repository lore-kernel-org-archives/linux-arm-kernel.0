From: rob.lee@linaro.org (Robert Lee)
Date: Mon, 23 Jan 2012 22:37:31 -0600
Subject: [PATCH v3 4/7] ARM: kirkwood: Modify to use new common cpuidle code.
In-Reply-To: <1327379854-12403-1-git-send-email-rob.lee@linaro.org>
References: <1327379854-12403-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1327379854-12403-5-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make necessary changes for consolidation with new common cpuidle code.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-kirkwood/cpuidle.c |   89 ++++++++++----------------------------
 1 files changed, 23 insertions(+), 66 deletions(-)

diff --git a/arch/arm/mach-kirkwood/cpuidle.c b/arch/arm/mach-kirkwood/cpuidle.c
index 7088180..8b2d1ab 100644
--- a/arch/arm/mach-kirkwood/cpuidle.c
+++ b/arch/arm/mach-kirkwood/cpuidle.c
@@ -24,80 +24,37 @@
 
 #define KIRKWOOD_MAX_STATES	2
 
-static struct cpuidle_driver kirkwood_idle_driver = {
-	.name =         "kirkwood_idle",
-	.owner =        THIS_MODULE,
-};
-
-static DEFINE_PER_CPU(struct cpuidle_device, kirkwood_cpuidle_device);
-
 /* Actual code that puts the SoC in different idle states */
-static int kirkwood_enter_idle(struct cpuidle_device *dev,
+static int kirkwood_idle_ddr(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
-			       int index)
+				int index)
 {
-	struct timeval before, after;
-	int idle_time;
-
-	local_irq_disable();
-	do_gettimeofday(&before);
-	if (index == 0)
-		/* Wait for interrupt state */
-		cpu_do_idle();
-	else if (index == 1) {
-		/*
-		 * Following write will put DDR in self refresh.
-		 * Note that we have 256 cycles before DDR puts it
-		 * self in self-refresh, so the wait-for-interrupt
-		 * call afterwards won't get the DDR from self refresh
-		 * mode.
-		 */
-		writel(0x7, DDR_OPERATION_BASE);
-		cpu_do_idle();
-	}
-	do_gettimeofday(&after);
-	local_irq_enable();
-	idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
-			(after.tv_usec - before.tv_usec);
-
-	/* Update last residency */
-	dev->last_residency = idle_time;
+	writel(0x7, DDR_OPERATION_BASE);
+	cpu_do_idle();
 
 	return index;
 }
 
+static struct cpuidle_driver kirkwood_idle_driver __initdata = {
+	.name =         "kirkwood_idle",
+	.owner =        THIS_MODULE,
+	.states[0] = CPUIDLE_ARM_WFI_STATE,
+	.states[1] = {
+		.enter			= kirkwood_idle_ddr,
+		.exit_latency		= 10,
+		.target_residency	= 10000,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "DDR SR",
+		.desc			= "WFI and DDR Self Refresh",
+	},
+	.state_count = KIRKWOOD_MAX_STATES,
+};
+
 /* Initialize CPU idle by registering the idle states */
-static int kirkwood_init_cpuidle(void)
+static int __init kirkwood_init_cpuidle(void)
 {
-	struct cpuidle_device *device;
-	struct cpuidle_driver *driver = &kirkwood_idle_driver;
-
-	device = &per_cpu(kirkwood_cpuidle_device, smp_processor_id());
-	device->state_count = KIRKWOOD_MAX_STATES;
-	driver->state_count = KIRKWOOD_MAX_STATES;
-
-	/* Wait for interrupt state */
-	driver->states[0].enter = kirkwood_enter_idle;
-	driver->states[0].exit_latency = 1;
-	driver->states[0].target_residency = 10000;
-	driver->states[0].flags = CPUIDLE_FLAG_TIME_VALID;
-	strcpy(driver->states[0].name, "WFI");
-	strcpy(driver->states[0].desc, "Wait for interrupt");
-
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
+	return common_cpuidle_init(&kirkwood_idle_driver,
+					true,
+					NULL);
 }
-
 device_initcall(kirkwood_init_cpuidle);
-- 
1.7.1
