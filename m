From: rob.lee@linaro.org (Robert Lee)
Date: Sun, 26 Feb 2012 22:47:42 -0600
Subject: [PATCH v5 8/9] ARM: kirkwood: Consolidate cpuidle functionality
In-Reply-To: <1330318063-25460-1-git-send-email-rob.lee@linaro.org>
References: <1330318063-25460-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1330318063-25460-9-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added core cpuidle functionality and remove this duplicated
code from the platform cpuidle.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-kirkwood/cpuidle.c |   71 +++++++++++---------------------------
 1 files changed, 20 insertions(+), 51 deletions(-)

diff --git a/arch/arm/mach-kirkwood/cpuidle.c b/arch/arm/mach-kirkwood/cpuidle.c
index 7088180..261a2a8 100644
--- a/arch/arm/mach-kirkwood/cpuidle.c
+++ b/arch/arm/mach-kirkwood/cpuidle.c
@@ -24,73 +24,42 @@
 
 #define KIRKWOOD_MAX_STATES	2
 
-static struct cpuidle_driver kirkwood_idle_driver = {
-	.name =         "kirkwood_idle",
-	.owner =        THIS_MODULE,
-};
-
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
 
+static struct cpuidle_driver kirkwood_idle_driver = {
+	.name			= "kirkwood_idle",
+	.owner			= THIS_MODULE,
+	.en_core_tk_irqen	= 1,
+	.states[0] = CPUIDLE_ARM_WFI_STATE,
+	.states[1] = {
+		.enter			= kirkwood_enter_idle,
+		.exit_latency		= 10,
+		.target_residency	= 100000,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "DDR SR",
+		.desc			= "WFI and DDR Self Refresh",
+	},
+	.state_count = KIRKWOOD_MAX_STATES,
+};
+
+static DEFINE_PER_CPU(struct cpuidle_device, kirkwood_cpuidle_device);
+
 /* Initialize CPU idle by registering the idle states */
 static int kirkwood_init_cpuidle(void)
 {
 	struct cpuidle_device *device;
-	struct cpuidle_driver *driver = &kirkwood_idle_driver;
 
 	device = &per_cpu(kirkwood_cpuidle_device, smp_processor_id());
 	device->state_count = KIRKWOOD_MAX_STATES;
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
 
 	cpuidle_register_driver(&kirkwood_idle_driver);
 	if (cpuidle_register_device(device)) {
-- 
1.7.1
