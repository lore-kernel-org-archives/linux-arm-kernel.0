From: rob.lee@linaro.org (Robert Lee)
Date: Mon, 23 Jan 2012 22:37:32 -0600
Subject: [PATCH v3 5/7] ARM: davinci: Modify to use new common cpuidle code.
In-Reply-To: <1327379854-12403-1-git-send-email-rob.lee@linaro.org>
References: <1327379854-12403-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1327379854-12403-6-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make necessary changes for consolidation with new common cpuidle code.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-davinci/cpuidle.c |  135 ++++++++++-----------------------------
 1 files changed, 33 insertions(+), 102 deletions(-)

diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index a30c7c5..8cfc0be 100644
--- a/arch/arm/mach-davinci/cpuidle.c
+++ b/arch/arm/mach-davinci/cpuidle.c
@@ -24,98 +24,57 @@
 
 #define DAVINCI_CPUIDLE_MAX_STATES	2
 
-struct davinci_ops {
-	void (*enter) (u32 flags);
-	void (*exit) (u32 flags);
-	u32 flags;
-};
-
-/* fields in davinci_ops.flags */
-#define DAVINCI_CPUIDLE_FLAGS_DDR2_PWDN	BIT(0)
-
-static struct cpuidle_driver davinci_idle_driver = {
-	.name	= "cpuidle-davinci",
-	.owner	= THIS_MODULE,
-};
-
-static DEFINE_PER_CPU(struct cpuidle_device, davinci_cpuidle_device);
+u32 __initdata ddr_reg_mask;
 static void __iomem *ddr2_reg_base;
 
-static void davinci_save_ddr_power(int enter, bool pdown)
+/* idle that includes ddr low power */
+static int davinci_idle_ddr(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv,
+				int index)
 {
 	u32 val;
 
 	val = __raw_readl(ddr2_reg_base + DDR2_SDRCR_OFFSET);
 
-	if (enter) {
-		if (pdown)
-			val |= DDR2_SRPD_BIT;
-		else
-			val &= ~DDR2_SRPD_BIT;
-		val |= DDR2_LPMODEN_BIT;
-	} else {
-		val &= ~(DDR2_SRPD_BIT | DDR2_LPMODEN_BIT);
-	}
+	val |= (u32)dev->states_usage[index].driver_data;
 
 	__raw_writel(val, ddr2_reg_base + DDR2_SDRCR_OFFSET);
-}
 
-static void davinci_c2state_enter(u32 flags)
-{
-	davinci_save_ddr_power(1, !!(flags & DAVINCI_CPUIDLE_FLAGS_DDR2_PWDN));
-}
+	/* Wait for interrupt state */
+	cpu_do_idle();
 
-static void davinci_c2state_exit(u32 flags)
-{
-	davinci_save_ddr_power(0, !!(flags & DAVINCI_CPUIDLE_FLAGS_DDR2_PWDN));
+	val &= ~(DDR2_SRPD_BIT | DDR2_LPMODEN_BIT);
+	__raw_writel(val, ddr2_reg_base + DDR2_SDRCR_OFFSET);
+
+	return index;
 }
 
-static struct davinci_ops davinci_states[DAVINCI_CPUIDLE_MAX_STATES] = {
-	[1] = {
-		.enter	= davinci_c2state_enter,
-		.exit	= davinci_c2state_exit,
+static struct cpuidle_driver davinci_idle_driver __initdata = {
+	.name	= "cpuidle-davinci",
+	.owner	= THIS_MODULE,
+	.states[0] = CPUIDLE_ARM_WFI_STATE,
+	.states[1] = {
+		.enter			= davinci_idle_ddr,
+		.exit_latency		= 10,
+		.target_residency	= 100000,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "DDR SR",
+		.desc			= "WFI and DDR Self Refresh",
 	},
+	.state_count = DAVINCI_CPUIDLE_MAX_STATES,
 };
 
-/* Actual code that puts the SoC in different idle states */
-static int davinci_enter_idle(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
-						int index)
+/* use drive_data field to hold the configured ddr low power bitmask */
+static void __init davinci_cpuidle_dd_init(struct cpuidle_device * dev)
 {
-	struct cpuidle_state_usage *state_usage = &dev->states_usage[index];
-	struct davinci_ops *ops = cpuidle_get_statedata(state_usage);
-	struct timeval before, after;
-	int idle_time;
-
-	local_irq_disable();
-	do_gettimeofday(&before);
-
-	if (ops && ops->enter)
-		ops->enter(ops->flags);
-	/* Wait for interrupt state */
-	cpu_do_idle();
-	if (ops && ops->exit)
-		ops->exit(ops->flags);
-
-	do_gettimeofday(&after);
-	local_irq_enable();
-	idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
-			(after.tv_usec - before.tv_usec);
-
-	dev->last_residency = idle_time;
-
-	return index;
+	dev->states_usage[1].driver_data = (void *)ddr_reg_mask;
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
@@ -123,42 +82,15 @@ static int __init davinci_cpuidle_probe(struct platform_device *pdev)
 
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
-		davinci_states[1].flags |= DAVINCI_CPUIDLE_FLAGS_DDR2_PWDN;
-	cpuidle_set_statedata(&device->states_usage[1], &davinci_states[1]);
+		ddr_reg_mask = (DDR2_SRPD_BIT | DDR2_LPMODEN_BIT);
+	else
+		ddr_reg_mask = (DDR2_LPMODEN_BIT);
 
-	device->state_count = DAVINCI_CPUIDLE_MAX_STATES;
-	driver->state_count = DAVINCI_CPUIDLE_MAX_STATES;
+	ret = common_cpuidle_init(&davinci_idle_driver, true,
+					davinci_cpuidle_dd_init);
 
-	ret = cpuidle_register_driver(&davinci_idle_driver);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register driver\n");
-		return ret;
-	}
-
-	ret = cpuidle_register_device(device);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register device\n");
-		cpuidle_unregister_driver(&davinci_idle_driver);
-		return ret;
-	}
-
-	return 0;
+	return ret;
 }
 
 static struct platform_driver davinci_cpuidle_driver = {
@@ -174,4 +106,3 @@ static int __init davinci_cpuidle_init(void)
 						davinci_cpuidle_probe);
 }
 device_initcall(davinci_cpuidle_init);
-
-- 
1.7.1
