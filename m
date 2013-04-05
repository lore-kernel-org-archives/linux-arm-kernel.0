From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 5 Apr 2013 16:22:52 +0200
Subject: [PATCH 10/14] ARM: ux500: split out prcmu initialization
In-Reply-To: <1365171776-8463-1-git-send-email-linus.walleij@stericsson.com>
References: <1365171776-8463-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1365171776-8463-11-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

This untangles the final bits of the prcmu code from the platform
code:

* The IRQ_PRCMU_* definitions move from irqs-db8500.h into prcmu.c
  because they are only of local significance.
* u8500_thsens_device goes into the prcmu, because it uses a PRCMU
  IRQ that the platform does not see.
* IRQ_DB8500_AB8500 and IRQ_PRCMU_BASE go into the platform data
  because the PRCMU does not see it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[Fixed a oneliner bug]
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c             |  58 ----------
 arch/arm/mach-ux500/devices-db8500.c           |   2 +
 arch/arm/mach-ux500/include/mach/irqs-db8500.h |  25 -----
 drivers/mfd/db8500-prcmu.c                     | 142 +++++++++++++++++++------
 include/linux/mfd/dbx500-prcmu.h               |   2 +
 5 files changed, 116 insertions(+), 113 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index caad80e..e1b38ef 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -206,63 +206,6 @@ struct ab8500_platform_data ab8500_platdata = {
 	.codec		= &ab8500_codec_pdata,
 };
 
-/*
- * Thermal Sensor
- */
-
-static struct resource db8500_thsens_resources[] = {
-	{
-		.name = "IRQ_HOTMON_LOW",
-		.start  = IRQ_PRCMU_HOTMON_LOW,
-		.end    = IRQ_PRCMU_HOTMON_LOW,
-		.flags  = IORESOURCE_IRQ,
-	},
-	{
-		.name = "IRQ_HOTMON_HIGH",
-		.start  = IRQ_PRCMU_HOTMON_HIGH,
-		.end    = IRQ_PRCMU_HOTMON_HIGH,
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
-static struct db8500_thsens_platform_data db8500_thsens_data = {
-	.trip_points[0] = {
-		.temp = 70000,
-		.type = THERMAL_TRIP_ACTIVE,
-		.cdev_name = {
-			[0] = "thermal-cpufreq-0",
-		},
-	},
-	.trip_points[1] = {
-		.temp = 75000,
-		.type = THERMAL_TRIP_ACTIVE,
-		.cdev_name = {
-			[0] = "thermal-cpufreq-0",
-		},
-	},
-	.trip_points[2] = {
-		.temp = 80000,
-		.type = THERMAL_TRIP_ACTIVE,
-		.cdev_name = {
-			[0] = "thermal-cpufreq-0",
-		},
-	},
-	.trip_points[3] = {
-		.temp = 85000,
-		.type = THERMAL_TRIP_CRITICAL,
-	},
-	.num_trips = 4,
-};
-
-static struct platform_device u8500_thsens_device = {
-	.name           = "db8500-thermal",
-	.resource       = db8500_thsens_resources,
-	.num_resources  = ARRAY_SIZE(db8500_thsens_resources),
-	.dev	= {
-		.platform_data	= &db8500_thsens_data,
-	},
-};
-
 static struct platform_device u8500_cpufreq_cooling_device = {
 	.name           = "db8500-cpufreq-cooling",
 };
@@ -622,7 +565,6 @@ static struct platform_device *snowball_platform_devs[] __initdata = {
 	&snowball_key_dev,
 	&snowball_sbnet_dev,
 	&snowball_gpio_en_3v3_regulator_dev,
-	&u8500_thsens_device,
 	&u8500_cpufreq_cooling_device,
 };
 
diff --git a/arch/arm/mach-ux500/devices-db8500.c b/arch/arm/mach-ux500/devices-db8500.c
index 38467bf..4c0ef14 100644
--- a/arch/arm/mach-ux500/devices-db8500.c
+++ b/arch/arm/mach-ux500/devices-db8500.c
@@ -199,6 +199,8 @@ struct platform_device u8500_ske_keypad_device = {
 
 struct prcmu_pdata db8500_prcmu_pdata = {
 	.ab_platdata	= &ab8500_platdata,
+	.ab_irq		= IRQ_DB8500_AB8500,
+	.irq_base	= IRQ_PRCMU_BASE,
 	.version_offset	= DB8500_PRCMU_FW_VERSION_OFFSET,
 	.legacy_offset	= DB8500_PRCMU_LEGACY_OFFSET,
 };
diff --git a/arch/arm/mach-ux500/include/mach/irqs-db8500.h b/arch/arm/mach-ux500/include/mach/irqs-db8500.h
index 68bc149..f3a9d59 100644
--- a/arch/arm/mach-ux500/include/mach/irqs-db8500.h
+++ b/arch/arm/mach-ux500/include/mach/irqs-db8500.h
@@ -109,31 +109,6 @@
 
 /* Virtual interrupts corresponding to the PRCMU wakeups.  */
 #define IRQ_PRCMU_BASE IRQ_SOC_START
-#define NUM_PRCMU_WAKEUPS (IRQ_PRCMU_END - IRQ_PRCMU_BASE)
-
-#define IRQ_PRCMU_RTC (IRQ_PRCMU_BASE)
-#define IRQ_PRCMU_RTT0 (IRQ_PRCMU_BASE + 1)
-#define IRQ_PRCMU_RTT1 (IRQ_PRCMU_BASE + 2)
-#define IRQ_PRCMU_HSI0 (IRQ_PRCMU_BASE + 3)
-#define IRQ_PRCMU_HSI1 (IRQ_PRCMU_BASE + 4)
-#define IRQ_PRCMU_CA_WAKE (IRQ_PRCMU_BASE + 5)
-#define IRQ_PRCMU_USB (IRQ_PRCMU_BASE + 6)
-#define IRQ_PRCMU_ABB (IRQ_PRCMU_BASE + 7)
-#define IRQ_PRCMU_ABB_FIFO (IRQ_PRCMU_BASE + 8)
-#define IRQ_PRCMU_ARM (IRQ_PRCMU_BASE + 9)
-#define IRQ_PRCMU_MODEM_SW_RESET_REQ (IRQ_PRCMU_BASE + 10)
-#define IRQ_PRCMU_GPIO0 (IRQ_PRCMU_BASE + 11)
-#define IRQ_PRCMU_GPIO1 (IRQ_PRCMU_BASE + 12)
-#define IRQ_PRCMU_GPIO2 (IRQ_PRCMU_BASE + 13)
-#define IRQ_PRCMU_GPIO3 (IRQ_PRCMU_BASE + 14)
-#define IRQ_PRCMU_GPIO4 (IRQ_PRCMU_BASE + 15)
-#define IRQ_PRCMU_GPIO5 (IRQ_PRCMU_BASE + 16)
-#define IRQ_PRCMU_GPIO6 (IRQ_PRCMU_BASE + 17)
-#define IRQ_PRCMU_GPIO7 (IRQ_PRCMU_BASE + 18)
-#define IRQ_PRCMU_GPIO8 (IRQ_PRCMU_BASE + 19)
-#define IRQ_PRCMU_CA_SLEEP (IRQ_PRCMU_BASE + 20)
-#define IRQ_PRCMU_HOTMON_LOW (IRQ_PRCMU_BASE + 21)
-#define IRQ_PRCMU_HOTMON_HIGH (IRQ_PRCMU_BASE + 22)
 #define IRQ_PRCMU_END (IRQ_PRCMU_BASE + 23)
 
 /*
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 03e2aed..8eb8c49 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -33,7 +33,7 @@
 #include <linux/regulator/machine.h>
 #include <linux/cpufreq.h>
 #include <linux/platform_data/ux500_wdt.h>
-#include <mach/irqs.h>
+#include <linux/platform_data/db8500_thermal.h>
 #include "dbx500-prcmu-regs.h"
 
 /* Index of different voltages to be used when accessing AVSData */
@@ -273,8 +273,34 @@ static struct irq_domain *db8500_irq_domain;
  * the bits in the bit field are not. (The bits also have a tendency to move
  * around, to further complicate matters.)
  */
-#define IRQ_INDEX(_name) ((IRQ_PRCMU_##_name) - IRQ_PRCMU_BASE)
+#define IRQ_INDEX(_name) ((IRQ_PRCMU_##_name))
 #define IRQ_ENTRY(_name)[IRQ_INDEX(_name)] = (WAKEUP_BIT_##_name)
+
+#define IRQ_PRCMU_RTC 0
+#define IRQ_PRCMU_RTT0 1
+#define IRQ_PRCMU_RTT1 2
+#define IRQ_PRCMU_HSI0 3
+#define IRQ_PRCMU_HSI1 4
+#define IRQ_PRCMU_CA_WAKE 5
+#define IRQ_PRCMU_USB 6
+#define IRQ_PRCMU_ABB 7
+#define IRQ_PRCMU_ABB_FIFO 8
+#define IRQ_PRCMU_ARM 9
+#define IRQ_PRCMU_MODEM_SW_RESET_REQ 10
+#define IRQ_PRCMU_GPIO0 11
+#define IRQ_PRCMU_GPIO1 12
+#define IRQ_PRCMU_GPIO2 13
+#define IRQ_PRCMU_GPIO3 14
+#define IRQ_PRCMU_GPIO4 15
+#define IRQ_PRCMU_GPIO5 16
+#define IRQ_PRCMU_GPIO6 17
+#define IRQ_PRCMU_GPIO7 18
+#define IRQ_PRCMU_GPIO8 19
+#define IRQ_PRCMU_CA_SLEEP 20
+#define IRQ_PRCMU_HOTMON_LOW 21
+#define IRQ_PRCMU_HOTMON_HIGH 22
+#define NUM_PRCMU_WAKEUPS 23
+
 static u32 prcmu_irq_bit[NUM_PRCMU_WAKEUPS] = {
 	IRQ_ENTRY(RTC),
 	IRQ_ENTRY(RTT0),
@@ -2649,14 +2675,13 @@ static struct irq_domain_ops db8500_irq_ops = {
 	.xlate  = irq_domain_xlate_twocell,
 };
 
-static int db8500_irq_init(struct device_node *np)
+static int db8500_irq_init(struct device_node *np, int irq_base)
 {
-	int irq_base = 0;
 	int i;
 
 	/* In the device tree case, just take some IRQs */
-	if (!np)
-		irq_base = IRQ_PRCMU_BASE;
+	if (np)
+		irq_base = 0;
 
 	db8500_irq_domain = irq_domain_add_simple(
 		np, NUM_PRCMU_WAKEUPS, irq_base,
@@ -2717,7 +2742,7 @@ void __init db8500_prcmu_early_init(u32 phy_base, u32 size)
 	 * subsequently replaces with a real remap. After the merge of
 	 * the mailbox subsystem all of this early code goes away, and the
 	 * clock driver can probe independently. An early initcall will
-	 * still be needed, but it can be diverted into drivers/clk/ux500/*.
+	 * still be needed, but it can be diverted into drivers/clk/ux500/.
 	 */
 	prcmu_base = ioremap(phy_base, size);
 	if (!prcmu_base)
@@ -2988,18 +3013,57 @@ static struct regulator_init_data db8500_regulators[DB8500_NUM_REGULATORS] = {
 	},
 };
 
-static struct resource ab8500_resources[] = {
-	[0] = {
-		.start	= IRQ_DB8500_AB8500,
-		.end	= IRQ_DB8500_AB8500,
-		.flags	= IORESOURCE_IRQ
-	}
-};
-
 static struct ux500_wdt_data db8500_wdt_pdata = {
 	.timeout = 600, /* 10 minutes */
 	.has_28_bits_resolution = true,
 };
+/*
+ * Thermal Sensor
+ */
+
+static struct resource db8500_thsens_resources[] = {
+	{
+		.name = "IRQ_HOTMON_LOW",
+		.start  = IRQ_PRCMU_HOTMON_LOW,
+		.end    = IRQ_PRCMU_HOTMON_LOW,
+		.flags  = IORESOURCE_IRQ,
+	},
+	{
+		.name = "IRQ_HOTMON_HIGH",
+		.start  = IRQ_PRCMU_HOTMON_HIGH,
+		.end    = IRQ_PRCMU_HOTMON_HIGH,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct db8500_thsens_platform_data db8500_thsens_data = {
+	.trip_points[0] = {
+		.temp = 70000,
+		.type = THERMAL_TRIP_ACTIVE,
+		.cdev_name = {
+			[0] = "thermal-cpufreq-0",
+		},
+	},
+	.trip_points[1] = {
+		.temp = 75000,
+		.type = THERMAL_TRIP_ACTIVE,
+		.cdev_name = {
+			[0] = "thermal-cpufreq-0",
+		},
+	},
+	.trip_points[2] = {
+		.temp = 80000,
+		.type = THERMAL_TRIP_ACTIVE,
+		.cdev_name = {
+			[0] = "thermal-cpufreq-0",
+		},
+	},
+	.trip_points[3] = {
+		.temp = 85000,
+		.type = THERMAL_TRIP_CRITICAL,
+	},
+	.num_trips = 4,
+};
 
 static struct mfd_cell db8500_prcmu_devs[] = {
 	{
@@ -3021,11 +3085,10 @@ static struct mfd_cell db8500_prcmu_devs[] = {
 		.id = -1,
 	},
 	{
-		.name = "ab8500-core",
-		.of_compatible = "stericsson,ab8500",
-		.num_resources = ARRAY_SIZE(ab8500_resources),
-		.resources = ab8500_resources,
-		.id = AB8500_VERSION_AB8500,
+		.name = "db8500-thermal",
+		.num_resources = ARRAY_SIZE(db8500_thsens_resources),
+		.resources = db8500_thsens_resources,
+		.platform_data = &db8500_thsens_data,
 	},
 };
 
@@ -3037,6 +3100,24 @@ static void db8500_prcmu_update_cpufreq(void)
 	}
 }
 
+static int db8500_prcmu_register_ab8500(struct device *parent,
+					struct ab8500_platform_data *pdata,
+					int irq)
+{
+	struct resource ab8500_resource = DEFINE_RES_IRQ(irq);
+	struct mfd_cell ab8500_cell = {
+		.name = "ab8500-core",
+		.of_compatible = "stericsson,ab8500",
+		.id = AB8500_VERSION_AB8500,
+		.platform_data = pdata,
+		.pdata_size = sizeof(struct ab8500_platform_data),
+		.resources = &ab8500_resource,
+		.num_resources = 1,
+	};
+
+	return mfd_add_devices(parent, 0, &ab8500_cell, 1, NULL, 0, NULL);
+}
+
 /**
  * prcmu_fw_init - arch init call for the Linux PRCMU fw init logic
  *
@@ -3045,7 +3126,7 @@ static int db8500_prcmu_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct prcmu_pdata *pdata = dev_get_platdata(&pdev->dev);
-	int irq = 0, err = 0, i;
+	int irq = 0, err = 0;
 	struct resource *res;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "prcmu");
@@ -3086,26 +3167,27 @@ static int db8500_prcmu_probe(struct platform_device *pdev)
 		goto no_irq_return;
 	}
 
-	db8500_irq_init(np);
-
-	for (i = 0; i < ARRAY_SIZE(db8500_prcmu_devs); i++) {
-		if (!strcmp(db8500_prcmu_devs[i].name, "ab8500-core")) {
-			db8500_prcmu_devs[i].platform_data = pdata->ab_platdata;
-			db8500_prcmu_devs[i].pdata_size = sizeof(struct ab8500_platform_data);
-		}
-	}
+	db8500_irq_init(np, pdata->irq_base);
 
 	prcmu_config_esram0_deep_sleep(ESRAM0_DEEP_SLEEP_STATE_RET);
 
 	db8500_prcmu_update_cpufreq();
 
 	err = mfd_add_devices(&pdev->dev, 0, db8500_prcmu_devs,
-			      ARRAY_SIZE(db8500_prcmu_devs), NULL, 0, NULL);
+			      ARRAY_SIZE(db8500_prcmu_devs), NULL, 0, db8500_irq_domain);
 	if (err) {
 		pr_err("prcmu: Failed to add subdevices\n");
 		return err;
 	}
 
+	err = db8500_prcmu_register_ab8500(&pdev->dev, pdata->ab_platdata,
+					   pdata->ab_irq);
+	if (err) {
+		mfd_remove_devices(&pdev->dev);
+		pr_err("prcmu: Failed to add ab8500 subdevice\n");
+		goto no_irq_return;
+	}
+
 	pr_info("DB8500 PRCMU initialized\n");
 
 no_irq_return:
diff --git a/include/linux/mfd/dbx500-prcmu.h b/include/linux/mfd/dbx500-prcmu.h
index fc43cec..689e6a0 100644
--- a/include/linux/mfd/dbx500-prcmu.h
+++ b/include/linux/mfd/dbx500-prcmu.h
@@ -237,6 +237,8 @@ struct prcmu_pdata
 	bool enable_set_ddr_opp;
 	bool enable_ape_opp_100_voltage;
 	struct ab8500_platform_data *ab_platdata;
+	int ab_irq;
+	int irq_base;
 	u32 version_offset;
 	u32 legacy_offset;
 	u32 adt_offset;
-- 
1.7.11.3
