From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Oct 2015 00:32:18 +0800
Subject: [PATCH 2/6] mfd: axp20x: Split the driver into core and i2c bits
In-Reply-To: <1444840342-9233-1-git-send-email-wens@csie.org>
References: <1444840342-9233-1-git-send-email-wens@csie.org>
Message-ID: <1444840342-9233-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The axp20x driver assumes the device is i2c based. This is not the
case with later models, which use a proprietary 2 wire serial bus
called "Reduced Serial Bus".

This patch follows the example of mfd/wm831x and splits it into
an interface independet core, and an i2c specific glue layer.

The old MFD_AXP20X Kconfig symbol is kept until sub-device drivers
and defconfigs have migrated to the new MFD_AXP20X_CORE symbol.

Included but unused header files are removed as well.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/Kconfig                     |  18 ++++-
 drivers/mfd/Makefile                    |   3 +-
 drivers/mfd/{axp20x.c => axp20x-core.c} | 105 +++-----------------------
 drivers/mfd/axp20x-i2c.c                | 127 ++++++++++++++++++++++++++++++++
 include/linux/mfd/axp20x.h              |  33 ++++++++-
 5 files changed, 186 insertions(+), 100 deletions(-)
 rename drivers/mfd/{axp20x.c => axp20x-core.c} (87%)
 create mode 100644 drivers/mfd/axp20x-i2c.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 99d63675f073..9ba3feb3f2fc 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -79,15 +79,25 @@ config MFD_BCM590XX
 	help
 	  Support for the BCM590xx PMUs from Broadcom
 
+# Keep the old symbol until subdevice driver dependencies and defconfigs
+# have been updated.
 config MFD_AXP20X
-	bool "X-Powers AXP20X"
+	bool "X-Powers AXP series PMICs"
+	select MFD_AXP20X_I2C
+
+config MFD_AXP20X_CORE
+	bool
 	select MFD_CORE
-	select REGMAP_I2C
 	select REGMAP_IRQ
+
+config MFD_AXP20X_I2C
+	bool "X-Powers AXP series I2C PMICs"
+	select MFD_AXP20X_CORE
+	select REGMAP_I2C
 	depends on I2C=y
 	help
-	  If you say Y here you get support for the X-Powers AXP202, AXP209 and
-	  AXP288 power management IC (PMIC).
+	  If you say Y here you get support for the X-Powers AXP series I2C
+	  based power management ICs (PMICs).
 	  This driver include only the core APIs. You have to select individual
 	  components like regulators or the PEK (Power Enable Key) under the
 	  corresponding menus.
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index a59e3fcc8626..ce3ad5fd4e2f 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -106,7 +106,8 @@ obj-$(CONFIG_PMIC_DA9052)	+= da9052-irq.o
 obj-$(CONFIG_PMIC_DA9052)	+= da9052-core.o
 obj-$(CONFIG_MFD_DA9052_SPI)	+= da9052-spi.o
 obj-$(CONFIG_MFD_DA9052_I2C)	+= da9052-i2c.o
-obj-$(CONFIG_MFD_AXP20X)	+= axp20x.o
+obj-$(CONFIG_MFD_AXP20X_CORE)	+= axp20x-core.o
+obj-$(CONFIG_MFD_AXP20X_I2C)	+= axp20x-i2c.o
 
 obj-$(CONFIG_MFD_LP3943)	+= lp3943.o
 obj-$(CONFIG_MFD_LP8788)	+= lp8788.o lp8788-irq.o
diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x-core.c
similarity index 87%
rename from drivers/mfd/axp20x.c
rename to drivers/mfd/axp20x-core.c
index 3f576b76c322..dd33548d93c4 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x-core.c
@@ -5,6 +5,8 @@
  * converters, LDOs, multiple 12-bit ADCs of voltage, current and temperature
  * as well as configurable GPIOs.
  *
+ * This file contains the interface independent core functions.
+ *
  * Author: Carlo Caione <carlo@caione.org>
  *
  * This program is free software; you can redistribute it and/or modify
@@ -13,18 +15,14 @@
  */
 
 #include <linux/err.h>
-#include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
-#include <linux/slab.h>
 #include <linux/regulator/consumer.h>
 #include <linux/mfd/axp20x.h>
 #include <linux/mfd/core.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/acpi.h>
 
 #define AXP20X_OFF	0x80
@@ -361,32 +359,6 @@ static const struct regmap_irq axp288_regmap_irqs[] = {
 	INIT_REGMAP_IRQ(AXP288, BC_USB_CHNG,            5, 1),
 };
 
-static const struct of_device_id axp20x_of_match[] = {
-	{ .compatible = "x-powers,axp152", .data = (void *) AXP152_ID },
-	{ .compatible = "x-powers,axp202", .data = (void *) AXP202_ID },
-	{ .compatible = "x-powers,axp209", .data = (void *) AXP209_ID },
-	{ .compatible = "x-powers,axp221", .data = (void *) AXP221_ID },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, axp20x_of_match);
-
-/*
- * This is useless for OF-enabled devices, but it is needed by I2C subsystem
- */
-static const struct i2c_device_id axp20x_i2c_id[] = {
-	{ },
-};
-MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
-
-static const struct acpi_device_id axp20x_acpi_match[] = {
-	{
-		.id = "INT33F4",
-		.driver_data = AXP288_ID,
-	},
-	{ },
-};
-MODULE_DEVICE_TABLE(acpi, axp20x_acpi_match);
-
 static const struct regmap_irq_chip axp152_regmap_irq_chip = {
 	.name			= "axp152_irq_chip",
 	.status_base		= AXP152_IRQ1_STATE,
@@ -586,27 +558,8 @@ static void axp20x_power_off(void)
 		     AXP20X_OFF);
 }
 
-static int axp20x_match_device(struct axp20x_dev *axp20x, struct device *dev)
+int axp20x_match_device(struct axp20x_dev *axp20x, struct device *dev)
 {
-	const struct acpi_device_id *acpi_id;
-	const struct of_device_id *of_id;
-
-	if (dev->of_node) {
-		of_id = of_match_device(axp20x_of_match, dev);
-		if (!of_id) {
-			dev_err(dev, "Unable to match OF ID\n");
-			return -ENODEV;
-		}
-		axp20x->variant = (long) of_id->data;
-	} else {
-		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
-		if (!acpi_id || !acpi_id->driver_data) {
-			dev_err(dev, "Unable to match ACPI ID and data\n");
-			return -ENODEV;
-		}
-		axp20x->variant = (long) acpi_id->driver_data;
-	}
-
 	switch (axp20x->variant) {
 	case AXP152_ID:
 		axp20x->nr_cells = ARRAY_SIZE(axp152_cells);
@@ -643,37 +596,16 @@ static int axp20x_match_device(struct axp20x_dev *axp20x, struct device *dev)
 	return 0;
 }
 
-static int axp20x_i2c_probe(struct i2c_client *i2c,
-			 const struct i2c_device_id *id)
+int axp20x_device_probe(struct axp20x_dev *axp20x)
 {
-	struct axp20x_dev *axp20x;
 	int ret;
 
-	axp20x = devm_kzalloc(&i2c->dev, sizeof(*axp20x), GFP_KERNEL);
-	if (!axp20x)
-		return -ENOMEM;
-
-	ret = axp20x_match_device(axp20x, &i2c->dev);
-	if (ret)
-		return ret;
-
-	axp20x->i2c_client = i2c;
-	axp20x->dev = &i2c->dev;
-	dev_set_drvdata(axp20x->dev, axp20x);
-
-	axp20x->regmap = devm_regmap_init_i2c(i2c, axp20x->regmap_cfg);
-	if (IS_ERR(axp20x->regmap)) {
-		ret = PTR_ERR(axp20x->regmap);
-		dev_err(&i2c->dev, "regmap init failed: %d\n", ret);
-		return ret;
-	}
-
-	ret = regmap_add_irq_chip(axp20x->regmap, i2c->irq,
+	ret = regmap_add_irq_chip(axp20x->regmap, axp20x->irq,
 				  IRQF_ONESHOT | IRQF_SHARED, -1,
 				  axp20x->regmap_irq_chip,
 				  &axp20x->regmap_irqc);
 	if (ret) {
-		dev_err(&i2c->dev, "failed to add irq chip: %d\n", ret);
+		dev_err(axp20x->dev, "failed to add irq chip: %d\n", ret);
 		return ret;
 	}
 
@@ -681,8 +613,8 @@ static int axp20x_i2c_probe(struct i2c_client *i2c,
 			axp20x->nr_cells, NULL, 0, NULL);
 
 	if (ret) {
-		dev_err(&i2c->dev, "failed to add MFD devices: %d\n", ret);
-		regmap_del_irq_chip(i2c->irq, axp20x->regmap_irqc);
+		dev_err(axp20x->dev, "failed to add MFD devices: %d\n", ret);
+		regmap_del_irq_chip(axp20x->irq, axp20x->regmap_irqc);
 		return ret;
 	}
 
@@ -691,39 +623,24 @@ static int axp20x_i2c_probe(struct i2c_client *i2c,
 		pm_power_off = axp20x_power_off;
 	}
 
-	dev_info(&i2c->dev, "AXP20X driver loaded\n");
+	dev_info(axp20x->dev, "AXP20X driver loaded\n");
 
 	return 0;
 }
 
-static int axp20x_i2c_remove(struct i2c_client *i2c)
+int axp20x_device_remove(struct axp20x_dev *axp20x)
 {
-	struct axp20x_dev *axp20x = i2c_get_clientdata(i2c);
-
 	if (axp20x == axp20x_pm_power_off) {
 		axp20x_pm_power_off = NULL;
 		pm_power_off = NULL;
 	}
 
 	mfd_remove_devices(axp20x->dev);
-	regmap_del_irq_chip(axp20x->i2c_client->irq, axp20x->regmap_irqc);
+	regmap_del_irq_chip(axp20x->irq, axp20x->regmap_irqc);
 
 	return 0;
 }
 
-static struct i2c_driver axp20x_i2c_driver = {
-	.driver = {
-		.name	= "axp20x",
-		.of_match_table	= of_match_ptr(axp20x_of_match),
-		.acpi_match_table = ACPI_PTR(axp20x_acpi_match),
-	},
-	.probe		= axp20x_i2c_probe,
-	.remove		= axp20x_i2c_remove,
-	.id_table	= axp20x_i2c_id,
-};
-
-module_i2c_driver(axp20x_i2c_driver);
-
 MODULE_DESCRIPTION("PMIC MFD core driver for AXP20X");
 MODULE_AUTHOR("Carlo Caione <carlo@caione.org>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
new file mode 100644
index 000000000000..3916f5253500
--- /dev/null
+++ b/drivers/mfd/axp20x-i2c.c
@@ -0,0 +1,127 @@
+/*
+ * axp20x-i2c.c - I2C driver for the X-Powers' Power Management ICs
+ *
+ * AXP20x typically comprises an adaptive USB-Compatible PWM charger, BUCK DC-DC
+ * converters, LDOs, multiple 12-bit ADCs of voltage, current and temperature
+ * as well as configurable GPIOs.
+ *
+ * This driver supports the I2C variants.
+ *
+ * Author: Carlo Caione <carlo@caione.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mfd/axp20x.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+static const struct of_device_id axp20x_i2c_of_match[] = {
+	{ .compatible = "x-powers,axp152", .data = (void *) AXP152_ID },
+	{ .compatible = "x-powers,axp202", .data = (void *) AXP202_ID },
+	{ .compatible = "x-powers,axp209", .data = (void *) AXP209_ID },
+	{ .compatible = "x-powers,axp221", .data = (void *) AXP221_ID },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, axp20x_of_match);
+
+/*
+ * This is useless for OF-enabled devices, but it is needed by I2C subsystem
+ */
+static const struct i2c_device_id axp20x_i2c_id[] = {
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
+
+static const struct acpi_device_id axp20x_i2c_acpi_match[] = {
+	{
+		.id = "INT33F4",
+		.driver_data = AXP288_ID,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, axp20x_acpi_match);
+
+static int axp20x_i2c_match_device(struct axp20x_dev *axp20x,
+				   struct device *dev)
+{
+	const struct acpi_device_id *acpi_id;
+	const struct of_device_id *of_id;
+
+	if (dev->of_node) {
+		of_id = of_match_device(axp20x_i2c_of_match, dev);
+		if (!of_id) {
+			dev_err(dev, "Unable to match OF ID\n");
+			return -ENODEV;
+		}
+		axp20x->variant = (long) of_id->data;
+	} else {
+		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
+		if (!acpi_id || !acpi_id->driver_data) {
+			dev_err(dev, "Unable to match ACPI ID and data\n");
+			return -ENODEV;
+		}
+		axp20x->variant = (long) acpi_id->driver_data;
+	}
+
+	return axp20x_match_device(axp20x, dev);
+}
+
+static int axp20x_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
+{
+	struct axp20x_dev *axp20x;
+	int ret;
+
+	axp20x = devm_kzalloc(&i2c->dev, sizeof(*axp20x), GFP_KERNEL);
+	if (!axp20x)
+		return -ENOMEM;
+
+	ret = axp20x_i2c_match_device(axp20x, &i2c->dev);
+	if (ret)
+		return ret;
+
+	axp20x->dev = &i2c->dev;
+	axp20x->irq = i2c->irq;
+	dev_set_drvdata(axp20x->dev, axp20x);
+
+	axp20x->regmap = devm_regmap_init_i2c(i2c, axp20x->regmap_cfg);
+	if (IS_ERR(axp20x->regmap)) {
+		ret = PTR_ERR(axp20x->regmap);
+		dev_err(&i2c->dev, "regmap init failed: %d\n", ret);
+		return ret;
+	}
+
+	return axp20x_device_probe(axp20x);
+}
+
+static int axp20x_i2c_remove(struct i2c_client *i2c)
+{
+	struct axp20x_dev *axp20x = i2c_get_clientdata(i2c);
+
+	return axp20x_device_remove(axp20x);
+}
+
+static struct i2c_driver axp20x_i2c_driver = {
+	.driver = {
+		.name	= "axp20x",
+		.of_match_table	= of_match_ptr(axp20x_i2c_of_match),
+		.acpi_match_table = ACPI_PTR(axp20x_i2c_acpi_match),
+	},
+	.probe		= axp20x_i2c_probe,
+	.remove		= axp20x_i2c_remove,
+	.id_table	= axp20x_i2c_id,
+};
+
+module_i2c_driver(axp20x_i2c_driver);
+
+MODULE_DESCRIPTION("PMIC MFD I2C driver for AXP20X");
+MODULE_AUTHOR("Carlo Caione <carlo@caione.org>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index b24c771cebd5..908f97f6e2d7 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -396,7 +396,7 @@ enum axp288_irqs {
 
 struct axp20x_dev {
 	struct device			*dev;
-	struct i2c_client		*i2c_client;
+	int				irq;
 	struct regmap			*regmap;
 	struct regmap_irq_chip_data	*regmap_irqc;
 	long				variant;
@@ -462,4 +462,35 @@ static inline int axp20x_read_variable_width(struct regmap *regmap,
 	return result;
 }
 
+/**
+ * axp20x_match_device(): Setup axp20x variant related fields
+ *
+ * @axp20x: axp20x device to setup (.variant field must be set)
+ * @dev: device associated with this axp20x device
+ *
+ * This lets the axp20x core configure the mfd cells and register maps
+ * for later use.
+ */
+int axp20x_match_device(struct axp20x_dev *axp20x, struct device *dev);
+
+/**
+ * axp20x_device_probe(): Probe a configured axp20x device
+ *
+ * @axp20x: axp20x device to probe (must be configured)
+ *
+ * This function lets the axp20x core register the axp20x mfd devices
+ * and irqchip. The axp20x device passed in must be fully configured
+ * with axp20x_match_device, its irq set, and regmap created.
+ */
+int axp20x_device_probe(struct axp20x_dev *axp20x);
+
+/**
+ * axp20x_device_probe(): Remove a axp20x device
+ *
+ * @axp20x: axp20x device to remove
+ *
+ * This tells the axp20x core to remove the associated mfd devices
+ */
+int axp20x_device_remove(struct axp20x_dev *axp20x);
+
 #endif /* __LINUX_MFD_AXP20X_H */
-- 
2.6.1
