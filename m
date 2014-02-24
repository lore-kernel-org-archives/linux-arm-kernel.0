From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 24 Feb 2014 11:10:30 +0100
Subject: [PATCH v4 05/16] mfd: max14577: Add detection of device type
In-Reply-To: <1393236641-14977-1-git-send-email-k.kozlowski@samsung.com>
References: <1393236641-14977-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1393236641-14977-6-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch continues the preparation for adding support for max77836
device to existing max14577 driver.

Add enum for types of devices supported by this driver. The device type
will be detected by matching of_device_id, or i2c_device_id as a
fallback.

The patch also moves to separate function the code related to displaying
DeviceID register values.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/max14577.c               |   64 ++++++++++++++++++++++++----------
 include/linux/mfd/max14577-private.h |   12 ++++---
 2 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
index b217c9f0a755..3a3530814d9c 100644
--- a/drivers/mfd/max14577.c
+++ b/drivers/mfd/max14577.c
@@ -20,6 +20,7 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/of_device.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/max14577.h>
 #include <linux/mfd/max14577-private.h>
@@ -36,6 +37,14 @@ static struct mfd_cell max14577_devs[] = {
 	{ .name = "max14577-charger", },
 };
 
+static struct of_device_id max14577_dt_match[] = {
+	{
+		.compatible = "maxim,max14577",
+		.data = (void *)MAXIM_DEVICE_TYPE_MAX14577,
+	},
+	{},
+};
+
 static bool max14577_muic_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -82,13 +91,34 @@ static const struct regmap_irq_chip max14577_irq_chip = {
 	.num_irqs		= ARRAY_SIZE(max14577_irqs),
 };
 
+static void max14577_print_dev_type(struct maxim_core *maxim_core)
+{
+	u8 reg_data, vendor_id, device_id;
+	int ret;
+
+	ret = max14577_read_reg(maxim_core->regmap_muic,
+			MAXIM_MUIC_REG_DEVICEID, &reg_data);
+	if (ret) {
+		dev_err(maxim_core->dev,
+			"Failed to read DEVICEID register: %d\n", ret);
+		return;
+	}
+
+	vendor_id = ((reg_data & MAXIM_DEVID_VENDORID_MASK) >>
+				MAXIM_DEVID_VENDORID_SHIFT);
+	device_id = ((reg_data & MAXIM_DEVID_DEVICEID_MASK) >>
+				MAXIM_DEVID_DEVICEID_SHIFT);
+
+	dev_info(maxim_core->dev, "Device type: %u (ID: 0x%x, vendor: 0x%x)\n",
+			maxim_core->dev_type, device_id, vendor_id);
+}
+
 static int max14577_i2c_probe(struct i2c_client *i2c,
 			      const struct i2c_device_id *id)
 {
 	struct maxim_core *maxim_core;
 	struct max14577_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct device_node *np = i2c->dev.of_node;
-	u8 reg_data;
 	int ret = 0;
 
 	if (np) {
@@ -121,19 +151,17 @@ static int max14577_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	ret = max14577_read_reg(maxim_core->regmap_muic,
-			MAXIM_MUIC_REG_DEVICEID, &reg_data);
-	if (ret) {
-		dev_err(maxim_core->dev, "Device not found on this channel: %d\n",
-				ret);
-		return ret;
+	if (np) {
+		const struct of_device_id *of_id;
+
+		of_id = of_match_device(max14577_dt_match, &i2c->dev);
+		if (of_id)
+			maxim_core->dev_type = (unsigned int)of_id->data;
+	} else {
+		maxim_core->dev_type = id->driver_data;
 	}
-	maxim_core->vendor_id = ((reg_data & MAXIM_DEVID_VENDORID_MASK) >>
-				MAXIM_DEVID_VENDORID_SHIFT);
-	maxim_core->device_id = ((reg_data & MAXIM_DEVID_DEVICEID_MASK) >>
-				MAXIM_DEVID_DEVICEID_SHIFT);
-	dev_info(maxim_core->dev, "Device ID: 0x%x, vendor: 0x%x\n",
-			maxim_core->device_id, maxim_core->vendor_id);
+
+	max14577_print_dev_type(maxim_core);
 
 	ret = regmap_add_irq_chip(maxim_core->regmap_muic, maxim_core->irq,
 				  IRQF_TRIGGER_FALLING | IRQF_ONESHOT, 0,
@@ -172,7 +200,7 @@ static int max14577_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id max14577_i2c_id[] = {
-	{ "max14577", 0 },
+	{ "max14577", MAXIM_DEVICE_TYPE_MAX14577, },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max14577_i2c_id);
@@ -215,11 +243,6 @@ static int max14577_resume(struct device *dev)
 }
 #endif /* CONFIG_PM_SLEEP */
 
-static struct of_device_id max14577_dt_match[] = {
-	{ .compatible = "maxim,max14577", },
-	{},
-};
-
 static SIMPLE_DEV_PM_OPS(max14577_pm, max14577_suspend, max14577_resume);
 
 static struct i2c_driver max14577_i2c_driver = {
@@ -236,6 +259,9 @@ static struct i2c_driver max14577_i2c_driver = {
 
 static int __init max14577_i2c_init(void)
 {
+	BUILD_BUG_ON(ARRAY_SIZE(max14577_i2c_id) != MAXIM_DEVICE_TYPE_NUM);
+	BUILD_BUG_ON(ARRAY_SIZE(max14577_dt_match) != MAXIM_DEVICE_TYPE_NUM);
+
 	return i2c_add_driver(&max14577_i2c_driver);
 }
 subsys_initcall(max14577_i2c_init);
diff --git a/include/linux/mfd/max14577-private.h b/include/linux/mfd/max14577-private.h
index d69c56f02eac..afa4e525f9b7 100644
--- a/include/linux/mfd/max14577-private.h
+++ b/include/linux/mfd/max14577-private.h
@@ -22,6 +22,13 @@
 #include <linux/i2c.h>
 #include <linux/regmap.h>
 
+enum maxim_device_type {
+	MAXIM_DEVICE_TYPE_UNKNOWN	= 0,
+	MAXIM_DEVICE_TYPE_MAX14577,
+
+	MAXIM_DEVICE_TYPE_NUM,
+};
+
 /* Slave addr = 0x4A: MUIC and Charger */
 enum maxim_muic_reg {
 	MAXIM_MUIC_REG_DEVICEID			= 0x00,
@@ -250,15 +257,12 @@ enum maxim_irq {
 struct maxim_core {
 	struct device *dev;
 	struct i2c_client *i2c; /* Slave addr = 0x4A */
+	enum maxim_device_type dev_type;
 
 	struct regmap *regmap_muic;
 
 	struct regmap_irq_chip_data *irq_data_muic;
 	int irq;
-
-	/* Device ID */
-	u8 vendor_id;	/* Vendor Identification */
-	u8 device_id;	/* Chip Version */
 };
 
 /* MAX14577 shared regmap API function */
-- 
1.7.9.5
