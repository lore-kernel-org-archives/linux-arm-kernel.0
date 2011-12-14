From: rob.lee@linaro.org (Robert Lee)
Date: Wed, 14 Dec 2011 01:02:05 -0600
Subject: [RFC PATCH v2 1/2] cpuidle: Add common init interface and idle
 functionality
In-Reply-To: <1323846126-7516-1-git-send-email-rob.lee@linaro.org>
References: <1323846126-7516-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1323846126-7516-2-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds some cpuidle initialization functionality commonly
duplicated by many platforms.  The duplicate cpuidle init code of
various platfroms has been consolidated to use this common code
and successfully rebuilt.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-at91/cpuidle.c     |   98 ++++++++++----------------
 arch/arm/mach-davinci/cpuidle.c  |  143 +++++++++++---------------------------
 arch/arm/mach-exynos/cpuidle.c   |   73 +++----------------
 arch/arm/mach-kirkwood/cpuidle.c |   94 ++++++++-----------------
 arch/arm/mach-shmobile/cpuidle.c |   40 ++---------
 drivers/cpuidle/Makefile         |    2 +-
 drivers/cpuidle/common.c         |  124 +++++++++++++++++++++++++++++++++
 include/linux/cpuidle.h          |   26 +++++++
 8 files changed, 277 insertions(+), 323 deletions(-)
 create mode 100644 drivers/cpuidle/common.c

diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
index a851e6c..b162aab 100644
--- a/arch/arm/mach-at91/cpuidle.c
+++ b/arch/arm/mach-at91/cpuidle.c
@@ -1,6 +1,4 @@
 /*
- * based on arch/arm/mach-kirkwood/cpuidle.c
- *
  * CPU idle support for AT91 SoC
  *
  * This file is licensed under the terms of the GNU General Public
@@ -17,84 +15,60 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/cpuidle.h>
-#include <asm/proc-fns.h>
 #include <linux/io.h>
 #include <linux/export.h>
-
+#include <asm/proc-fns.h>
 #include "pm.h"
 
-#define AT91_MAX_STATES	2
-
-static DEFINE_PER_CPU(struct cpuidle_device, at91_cpuidle_device);
-
-static struct cpuidle_driver at91_idle_driver = {
-	.name =         "at91_idle",
-	.owner =        THIS_MODULE,
-};
+#define AT91_MAX_STATES 2
 
 /* Actual code that puts the SoC in different idle states */
-static int at91_enter_idle(struct cpuidle_device *dev,
+static int at91_idle_dram(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			       int index)
 {
-	struct timeval before, after;
-	int idle_time;
 	u32 saved_lpr;
 
-	local_irq_disable();
-	do_gettimeofday(&before);
-	if (index == 0)
-		/* Wait for interrupt state */
-		cpu_do_idle();
-	else if (index == 1) {
-		asm("b 1f; .align 5; 1:");
-		asm("mcr p15, 0, r0, c7, c10, 4");	/* drain write buffer */
-		saved_lpr = sdram_selfrefresh_enable();
-		cpu_do_idle();
-		sdram_selfrefresh_disable(saved_lpr);
-	}
-	do_gettimeofday(&after);
-	local_irq_enable();
-	idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
-			(after.tv_usec - before.tv_usec);
+	asm("b 1f; .align 5; 1:");
+	asm("mcr p15, 0, r0, c7, c10, 4");	/* drain write buffer */
+	saved_lpr = sdram_selfrefresh_enable();
+	cpu_do_idle();
+	sdram_selfrefresh_disable(saved_lpr);
 
-	dev->last_residency = idle_time;
 	return index;
 }
 
+static struct cpuidle_driver at91_idle_driver = {
+	.name =         "at91_idle",
+	.owner =        THIS_MODULE,
+	.states[0] = {
+		.enter			= cpuidle_def_idle,
+		.exit_latency		= 1,
+		.target_residency	= 100000,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "WFI",
+		.desc			= "Wait for interrupt",
+	},
+	.states[1] = {
+		.enter			= at91_idle_dram,
+		.exit_latency		= 10,
+		.target_residency	= 100000,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "RAM_SR",
+		.desc			= "WFI and RAM Self Refresh",
+	},
+	.state_count = AT91_MAX_STATES,
+};
+
 /* Initialize CPU idle by registering the idle states */
-static int at91_init_cpuidle(void)
+static int __init at91_init_cpuidle(void)
 {
-	struct cpuidle_device *device;
-	struct cpuidle_driver *driver = &at91_idle_driver;
+	int ret;
 
-	device = &per_cpu(at91_cpuidle_device, smp_processor_id());
-	device->state_count = AT91_MAX_STATES;
-	driver->state_count = AT91_MAX_STATES;
+	ret = common_cpuidle_init(&at91_idle_driver,
+					true,
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
diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index a30c7c5..b12f30b 100644
--- a/arch/arm/mach-davinci/cpuidle.c
+++ b/arch/arm/mach-davinci/cpuidle.c
@@ -18,104 +18,69 @@
 #include <linux/io.h>
 #include <linux/export.h>
 #include <asm/proc-fns.h>
-
 #include <mach/cpuidle.h>
 #include <mach/ddr2.h>
 
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
+						int index)
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
+static struct cpuidle_driver davinci_idle_driver = {
+	.name	= "cpuidle-davinci",
+	.owner	= THIS_MODULE,
+	.states[0] = {
+		.enter			= cpuidle_def_idle,
+		.exit_latency		= 1,
+		.target_residency	= 100000,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "WFI",
+		.desc			= "Wait for interrupt",
 	},
+	.states[1] = {
+		.enter			= davinci_idle_ddr,
+		.exit_latency		= 10,
+		.target_residency	= 100000,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "DDR SR",
+		.desc			= "WFI and DDR Self Refresh",
+	},
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
@@ -123,42 +88,15 @@ static int __init davinci_cpuidle_probe(struct platform_device *pdev)
 
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
@@ -174,4 +112,3 @@ static int __init davinci_cpuidle_init(void)
 						davinci_cpuidle_probe);
 }
 device_initcall(davinci_cpuidle_init);
-
diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 4ebb382..7c863ca 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -13,80 +13,29 @@
 #include <linux/cpuidle.h>
 #include <linux/io.h>
 #include <linux/export.h>
-#include <linux/time.h>
-
 #include <asm/proc-fns.h>
 
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
+		.enter			= cpuidle_def_idle,
 		.exit_latency		= 1,
 		.target_residency	= 100000,
 		.flags			= CPUIDLE_FLAG_TIME_VALID,
 		.name			= "IDLE",
 		.desc			= "ARM clock gating(WFI)",
 	},
+	.state_count = 1,
 };
 
-static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device);
-
-static struct cpuidle_driver exynos4_idle_driver = {
-	.name		= "exynos4_idle",
-	.owner		= THIS_MODULE,
-};
-
-static int exynos4_enter_idle(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
-			      int index)
-{
-	struct timeval before, after;
-	int idle_time;
-
-	local_irq_disable();
-	do_gettimeofday(&before);
-
-	cpu_do_idle();
-
-	do_gettimeofday(&after);
-	local_irq_enable();
-	idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
-		    (after.tv_usec - before.tv_usec);
-
-	dev->last_residency = idle_time;
-	return index;
-}
-
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
+	ret = common_cpuidle_init(&exynos4_idle_driver,
+					true,
+					NULL);
+	return ret;
 }
 device_initcall(exynos4_init_cpuidle);
diff --git a/arch/arm/mach-kirkwood/cpuidle.c b/arch/arm/mach-kirkwood/cpuidle.c
index 7088180..965cf25 100644
--- a/arch/arm/mach-kirkwood/cpuidle.c
+++ b/arch/arm/mach-kirkwood/cpuidle.c
@@ -24,80 +24,48 @@
 
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
+	.name =         "kirkwood_idle",
+	.owner =        THIS_MODULE,
+	.states[0] = {
+		.enter			= cpuidle_def_idle,
+		.exit_latency		= 1,
+		.target_residency	= 100000,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "WFI",
+		.desc			= "Wait for interrupt",
+	},
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
+	int ret;
 
-	/* Wait for interrupt state */
-	driver->states[0].enter = kirkwood_enter_idle;
-	driver->states[0].exit_latency = 1;
-	driver->states[0].target_residency = 10000;
-	driver->states[0].flags = CPUIDLE_FLAG_TIME_VALID;
-	strcpy(driver->states[0].name, "WFI");
-	strcpy(driver->states[0].desc, "Wait for interrupt");
+	ret = common_cpuidle_init(&kirkwood_idle_driver,
+					true,
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
diff --git a/arch/arm/mach-shmobile/cpuidle.c b/arch/arm/mach-shmobile/cpuidle.c
index 1b23342..3e6a393 100644
--- a/arch/arm/mach-shmobile/cpuidle.c
+++ b/arch/arm/mach-shmobile/cpuidle.c
@@ -16,42 +16,22 @@
 #include <asm/system.h>
 #include <asm/io.h>
 
-static void shmobile_enter_wfi(void)
-{
-	cpu_do_idle();
-}
-
-void (*shmobile_cpuidle_modes[CPUIDLE_STATE_MAX])(void) = {
-	shmobile_enter_wfi, /* regular sleep mode */
-};
+void (*shmobile_cpuidle_modes[CPUIDLE_STATE_MAX])(void);
 
 static int shmobile_cpuidle_enter(struct cpuidle_device *dev,
 				  struct cpuidle_driver *drv,
 				  int index)
 {
-	ktime_t before, after;
-
-	before = ktime_get();
-
-	local_irq_disable();
-	local_fiq_disable();
-
 	shmobile_cpuidle_modes[index]();
 
-	local_irq_enable();
-	local_fiq_enable();
-
-	after = ktime_get();
-	dev->last_residency = ktime_to_ns(ktime_sub(after, before)) >> 10;
-
 	return index;
 }
 
-static struct cpuidle_device shmobile_cpuidle_dev;
 static struct cpuidle_driver shmobile_cpuidle_driver = {
 	.name =		"shmobile_cpuidle",
 	.owner =	THIS_MODULE,
 	.states[0] = {
+		.enter = cpuidle_def_idle,
 		.name = "C1",
 		.desc = "WFI",
 		.exit_latency = 1,
@@ -64,23 +44,19 @@ static struct cpuidle_driver shmobile_cpuidle_driver = {
 
 void (*shmobile_cpuidle_setup)(struct cpuidle_driver *drv);
 
-static int shmobile_cpuidle_init(void)
+static int __init shmobile_cpuidle_init(void)
 {
-	struct cpuidle_device *dev = &shmobile_cpuidle_dev;
+	int i, ret;
 	struct cpuidle_driver *drv = &shmobile_cpuidle_driver;
-	int i;
 
-	for (i = 0; i < CPUIDLE_STATE_MAX; i++)
+	for (i = drv->state_count; i < CPUIDLE_STATE_MAX; i++)
 		drv->states[i].enter = shmobile_cpuidle_enter;
 
 	if (shmobile_cpuidle_setup)
-		shmobile_cpuidle_setup(drv);
-
-	cpuidle_register_driver(drv);
+		shmobile_cpuidle_setup(&shmobile_cpuidle_driver);
 
-	dev->state_count = drv->state_count;
-	cpuidle_register_device(dev);
+	ret = common_cpuidle_init(&shmobile_cpuidle_driver, true, NULL);
 
-	return 0;
+	return ret;
 }
 late_initcall(shmobile_cpuidle_init);
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 5634f88..2928d93 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -2,4 +2,4 @@
 # Makefile for cpuidle.
 #
 
-obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
+obj-y += cpuidle.o driver.o governor.o sysfs.o common.o governors/
diff --git a/drivers/cpuidle/common.c b/drivers/cpuidle/common.c
new file mode 100644
index 0000000..c9d6c14
--- /dev/null
+++ b/drivers/cpuidle/common.c
@@ -0,0 +1,124 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/*
+ * This code performs provides some commonly used cpuidle setup functionality
+ * used by many ARM SoC platforms.  Providing this functionality here
+ * reduces the duplication of this code for each ARM platform that uses it.
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/cpuidle.h>
+#include <linux/hrtimer.h>
+#include <linux/err.h>
+#include <asm/proc-fns.h>
+
+static struct cpuidle_device __percpu * common_cpuidle_devices;
+
+static int (*do_idle[CPUIDLE_STATE_MAX])(struct cpuidle_device *dev,
+			       struct cpuidle_driver *drv, int index);
+
+int cpuidle_def_idle(struct cpuidle_device *dev,
+			       struct cpuidle_driver *drv, int index) {
+	cpu_do_idle();
+	return index;
+}
+
+static int simple_enter(struct cpuidle_device *dev,
+			       struct cpuidle_driver *drv, int index)
+{
+	ktime_t time_start, time_end;
+
+	local_irq_disable();
+
+	time_start = ktime_get();
+
+	index = do_idle[index](dev, drv, index);
+
+	time_end = ktime_get();
+
+	local_irq_enable();
+
+	dev->last_residency =
+		(int)ktime_to_us(ktime_sub(time_end, time_start));
+
+	return index;
+}
+
+void common_cpuidle_devices_uninit(void)
+{
+	int cpu_id;
+	struct cpuidle_device *dev;
+
+	for_each_possible_cpu(cpu_id) {
+		dev = per_cpu_ptr(common_cpuidle_devices, cpu_id);
+		cpuidle_unregister_device(dev);
+	}
+
+	free_percpu(common_cpuidle_devices);
+}
+
+int __init common_cpuidle_init(struct cpuidle_driver *drv, bool simple,
+			 void (*driver_data_init)(struct cpuidle_device *dev))
+{
+	struct cpuidle_device *dev;
+	int i, cpu_id, ret;
+
+	if (!drv || drv->state_count > CPUIDLE_STATE_MAX) {
+		pr_err("%s: Invalid Input\n", __func__);
+		return -EINVAL;
+	}
+
+	for (i = 0; simple && (i < drv->state_count); i++) {
+		do_idle[i] = drv->states[i].enter;
+		drv->states[i].enter = simple_enter;
+	}
+
+	if (cpuidle_register_driver(drv)) {
+		pr_err("%s: Failed to register cpuidle driver\n", __func__);
+		return -ENODEV;
+	}
+
+	common_cpuidle_devices = alloc_percpu(struct cpuidle_device);
+	if (common_cpuidle_devices == NULL) {
+		ret = -ENOMEM;
+		goto unregister_drv;
+	}
+
+	/* initialize state data for each cpuidle_device */
+	for_each_possible_cpu(cpu_id) {
+		dev = per_cpu_ptr(common_cpuidle_devices, cpu_id);
+		dev->cpu = cpu_id;
+		dev->state_count = drv->state_count;
+
+		if (driver_data_init)
+			driver_data_init(dev);
+
+		if (cpuidle_register_device(dev)) {
+			pr_err("%s: Failed to register cpu %u\n",
+				__func__, cpu_id);
+			ret = -ENODEV;
+			goto uninit;
+		}
+	}
+
+	return 0;
+uninit:
+
+	common_cpuidle_devices_uninit();
+
+unregister_drv:
+
+	cpuidle_unregister_driver(drv);
+	return ret;
+}
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 7408af8..3ce6955 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -142,6 +142,25 @@ extern void cpuidle_resume_and_unlock(void);
 extern int cpuidle_enable_device(struct cpuidle_device *dev);
 extern void cpuidle_disable_device(struct cpuidle_device *dev);
 
+/* provide a default idle function */
+extern int cpuidle_def_idle(struct cpuidle_device *dev,
+		       struct cpuidle_driver *drv, int index);
+
+/*
+ * Common cpuidle init interface to provide common cpuidle functionality
+ * used by many platforms.
+ *
+ * Set simple to true if you want to use the provided common handling
+ * for each enter() callback.
+ *
+ * Provide a callback function if you want to modify the cpuidle_device
+ * data after it has been created and before the cpuidle_device has been
+ * registered.
+ */
+extern int common_cpuidle_init(struct cpuidle_driver *drv, bool simple,
+			 void (*driver_data_init)(struct cpuidle_device *dev));
+extern void common_cpuidle_devices_uninit(void);
+
 #else
 static inline void disable_cpuidle(void) { }
 static inline int cpuidle_idle_call(void) { return -ENODEV; }
@@ -159,6 +178,13 @@ static inline void cpuidle_resume_and_unlock(void) { }
 static inline int cpuidle_enable_device(struct cpuidle_device *dev)
 {return -ENODEV; }
 static inline void cpuidle_disable_device(struct cpuidle_device *dev) { }
+static inline int cpuidle_def_idle(struct cpuidle_device *dev,
+		       struct cpuidle_driver *drv, int index)
+{return -ENODEV; }
+static inline int common_cpuidle_init(struct cpuidle_driver *drv,
+	bool simple, void (*driver_data_init)(struct cpuidle_device *dev))
+{return -ENODEV; }
+static inline void common_cpuidle_devices_uninit(void) { }
 
 #endif
 
-- 
1.7.1
