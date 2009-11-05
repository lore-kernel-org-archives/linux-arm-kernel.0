From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 5 Nov 2009 14:56:37 -0500
Subject: [PATCH] mfd: split 88pm8607 driver
Message-ID: <mailman.79.1260364251.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create 88pm8607-i2c driver to support all I2C operation of 88PM8607.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mfd/88pm8607.c       |  302 ------------------------------------------
 drivers/mfd/88pm860x-core.c  |  134 +++++++++++++++++++
 drivers/mfd/88pm860x-i2c.c   |  202 ++++++++++++++++++++++++++++
 drivers/mfd/Makefile         |    2 +-
 include/linux/mfd/88pm8607.h |   12 ++-
 5 files changed, 346 insertions(+), 306 deletions(-)
 delete mode 100644 drivers/mfd/88pm8607.c
 create mode 100644 drivers/mfd/88pm860x-core.c
 create mode 100644 drivers/mfd/88pm860x-i2c.c

diff --git a/drivers/mfd/88pm8607.c b/drivers/mfd/88pm8607.c
deleted file mode 100644
index 7e3f659..0000000
--- a/drivers/mfd/88pm8607.c
+++ /dev/null
@@ -1,302 +0,0 @@
-/*
- * Base driver for Marvell 88PM8607
- *
- * Copyright (C) 2009 Marvell International Ltd.
- * 	Haojian Zhuang <haojian.zhuang@marvell.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/i2c.h>
-#include <linux/mfd/core.h>
-#include <linux/mfd/88pm8607.h>
-
-
-#define PM8607_REG_RESOURCE(_start, _end)		\
-{							\
-	.start	= PM8607_##_start,			\
-	.end	= PM8607_##_end,			\
-	.flags	= IORESOURCE_IO,			\
-}
-
-static struct resource pm8607_regulator_resources[] = {
-	PM8607_REG_RESOURCE(BUCK1, BUCK1),
-	PM8607_REG_RESOURCE(BUCK2, BUCK2),
-	PM8607_REG_RESOURCE(BUCK3, BUCK3),
-	PM8607_REG_RESOURCE(LDO1,  LDO1),
-	PM8607_REG_RESOURCE(LDO2,  LDO2),
-	PM8607_REG_RESOURCE(LDO3,  LDO3),
-	PM8607_REG_RESOURCE(LDO4,  LDO4),
-	PM8607_REG_RESOURCE(LDO5,  LDO5),
-	PM8607_REG_RESOURCE(LDO6,  LDO6),
-	PM8607_REG_RESOURCE(LDO7,  LDO7),
-	PM8607_REG_RESOURCE(LDO8,  LDO8),
-	PM8607_REG_RESOURCE(LDO9,  LDO9),
-	PM8607_REG_RESOURCE(LDO10, LDO10),
-	PM8607_REG_RESOURCE(LDO12, LDO12),
-	PM8607_REG_RESOURCE(LDO14, LDO14),
-};
-
-#define PM8607_REG_DEVS(_name, _id)					\
-{									\
-	.name		= "88pm8607-" #_name,				\
-	.num_resources	= 1,						\
-	.resources	= &pm8607_regulator_resources[PM8607_ID_##_id],	\
-}
-
-static struct mfd_cell pm8607_devs[] = {
-	PM8607_REG_DEVS(buck1, BUCK1),
-	PM8607_REG_DEVS(buck2, BUCK2),
-	PM8607_REG_DEVS(buck3, BUCK3),
-	PM8607_REG_DEVS(ldo1,  LDO1),
-	PM8607_REG_DEVS(ldo2,  LDO2),
-	PM8607_REG_DEVS(ldo3,  LDO3),
-	PM8607_REG_DEVS(ldo4,  LDO4),
-	PM8607_REG_DEVS(ldo5,  LDO5),
-	PM8607_REG_DEVS(ldo6,  LDO6),
-	PM8607_REG_DEVS(ldo7,  LDO7),
-	PM8607_REG_DEVS(ldo8,  LDO8),
-	PM8607_REG_DEVS(ldo9,  LDO9),
-	PM8607_REG_DEVS(ldo10, LDO10),
-	PM8607_REG_DEVS(ldo12, LDO12),
-	PM8607_REG_DEVS(ldo14, LDO14),
-};
-
-static inline int pm8607_read_device(struct pm8607_chip *chip,
-				     int reg, int bytes, void *dest)
-{
-	struct i2c_client *i2c = chip->client;
-	unsigned char data;
-	int ret;
-
-	data = (unsigned char)reg;
-	ret = i2c_master_send(i2c, &data, 1);
-	if (ret < 0)
-		return ret;
-
-	ret = i2c_master_recv(i2c, dest, bytes);
-	if (ret < 0)
-		return ret;
-	return 0;
-}
-
-static inline int pm8607_write_device(struct pm8607_chip *chip,
-				      int reg, int bytes, void *src)
-{
-	struct i2c_client *i2c = chip->client;
-	unsigned char buf[bytes + 1];
-	int ret;
-
-	buf[0] = (unsigned char)reg;
-	memcpy(&buf[1], src, bytes);
-
-	ret = i2c_master_send(i2c, buf, bytes + 1);
-	if (ret < 0)
-		return ret;
-	return 0;
-}
-
-int pm8607_reg_read(struct pm8607_chip *chip, int reg)
-{
-	unsigned char data;
-	int ret;
-
-	mutex_lock(&chip->io_lock);
-	ret = chip->read(chip, reg, 1, &data);
-	mutex_unlock(&chip->io_lock);
-
-	if (ret < 0)
-		return ret;
-	else
-		return (int)data;
-}
-EXPORT_SYMBOL(pm8607_reg_read);
-
-int pm8607_reg_write(struct pm8607_chip *chip, int reg,
-		     unsigned char data)
-{
-	int ret;
-
-	mutex_lock(&chip->io_lock);
-	ret = chip->write(chip, reg, 1, &data);
-	mutex_unlock(&chip->io_lock);
-
-	return ret;
-}
-EXPORT_SYMBOL(pm8607_reg_write);
-
-int pm8607_bulk_read(struct pm8607_chip *chip, int reg,
-		     int count, unsigned char *buf)
-{
-	int ret;
-
-	mutex_lock(&chip->io_lock);
-	ret = chip->read(chip, reg, count, buf);
-	mutex_unlock(&chip->io_lock);
-
-	return ret;
-}
-EXPORT_SYMBOL(pm8607_bulk_read);
-
-int pm8607_bulk_write(struct pm8607_chip *chip, int reg,
-		      int count, unsigned char *buf)
-{
-	int ret;
-
-	mutex_lock(&chip->io_lock);
-	ret = chip->write(chip, reg, count, buf);
-	mutex_unlock(&chip->io_lock);
-
-	return ret;
-}
-EXPORT_SYMBOL(pm8607_bulk_write);
-
-int pm8607_set_bits(struct pm8607_chip *chip, int reg,
-		    unsigned char mask, unsigned char data)
-{
-	unsigned char value;
-	int ret;
-
-	mutex_lock(&chip->io_lock);
-	ret = chip->read(chip, reg, 1, &value);
-	if (ret < 0)
-		goto out;
-	value &= ~mask;
-	value |= data;
-	ret = chip->write(chip, reg, 1, &value);
-out:
-	mutex_unlock(&chip->io_lock);
-	return ret;
-}
-EXPORT_SYMBOL(pm8607_set_bits);
-
-
-static const struct i2c_device_id pm8607_id_table[] = {
-	{ "88PM8607", 0 },
-	{}
-};
-MODULE_DEVICE_TABLE(i2c, pm8607_id_table);
-
-
-static int __devinit pm8607_probe(struct i2c_client *client,
-				  const struct i2c_device_id *id)
-{
-	struct pm8607_platform_data *pdata = client->dev.platform_data;
-	struct pm8607_chip *chip;
-	int i, count;
-	int ret;
-
-	chip = kzalloc(sizeof(struct pm8607_chip), GFP_KERNEL);
-	if (chip == NULL)
-		return -ENOMEM;
-
-	chip->client = client;
-	chip->dev = &client->dev;
-	chip->read = pm8607_read_device;
-	chip->write = pm8607_write_device;
-	i2c_set_clientdata(client, chip);
-
-	mutex_init(&chip->io_lock);
-	dev_set_drvdata(chip->dev, chip);
-
-	ret = pm8607_reg_read(chip, PM8607_CHIP_ID);
-	if (ret < 0) {
-		dev_err(chip->dev, "Failed to read CHIP ID: %d\n", ret);
-		goto out;
-	}
-	if ((ret & CHIP_ID_MASK) == CHIP_ID)
-		dev_info(chip->dev, "Marvell 88PM8607 (ID: %02x) detected\n",
-			 ret);
-	else {
-		dev_err(chip->dev, "Failed to detect Marvell 88PM8607. "
-			"Chip ID: %02x\n", ret);
-		goto out;
-	}
-	chip->chip_id = ret;
-
-	ret = pm8607_reg_read(chip, PM8607_BUCK3);
-	if (ret < 0) {
-		dev_err(chip->dev, "Failed to read BUCK3 register: %d\n", ret);
-		goto out;
-	}
-	if (ret & PM8607_BUCK3_DOUBLE)
-		chip->buck3_double = 1;
-
-	ret = pm8607_reg_read(chip, PM8607_MISC1);
-	if (ret < 0) {
-		dev_err(chip->dev, "Failed to read MISC1 register: %d\n", ret);
-		goto out;
-	}
-	if (pdata->i2c_port == PI2C_PORT)
-		ret |= PM8607_MISC1_PI2C;
-	else
-		ret &= ~PM8607_MISC1_PI2C;
-	ret = pm8607_reg_write(chip, PM8607_MISC1, ret);
-	if (ret < 0) {
-		dev_err(chip->dev, "Failed to write MISC1 register: %d\n", ret);
-		goto out;
-	}
-
-
-	count = ARRAY_SIZE(pm8607_devs);
-	for (i = 0; i < count; i++) {
-		ret = mfd_add_devices(chip->dev, i, &pm8607_devs[i],
-				      1, NULL, 0);
-		if (ret != 0) {
-			dev_err(chip->dev, "Failed to add subdevs\n");
-			goto out;
-		}
-	}
-
-	return 0;
-
-out:
-	i2c_set_clientdata(client, NULL);
-	kfree(chip);
-	return ret;
-}
-
-static int __devexit pm8607_remove(struct i2c_client *client)
-{
-	struct pm8607_chip *chip = i2c_get_clientdata(client);
-
-	mfd_remove_devices(chip->dev);
-	kfree(chip);
-	return 0;
-}
-
-static struct i2c_driver pm8607_driver = {
-	.driver	= {
-		.name	= "88PM8607",
-		.owner	= THIS_MODULE,
-	},
-	.probe		= pm8607_probe,
-	.remove		= __devexit_p(pm8607_remove),
-	.id_table	= pm8607_id_table,
-};
-
-static int __init pm8607_init(void)
-{
-	int ret;
-	ret = i2c_add_driver(&pm8607_driver);
-	if (ret != 0)
-		pr_err("Failed to register 88PM8607 I2C driver: %d\n", ret);
-	return ret;
-}
-subsys_initcall(pm8607_init);
-
-static void __exit pm8607_exit(void)
-{
-	i2c_del_driver(&pm8607_driver);
-}
-module_exit(pm8607_exit);
-
-MODULE_DESCRIPTION("PMIC Driver for Marvell 88PM8607");
-MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
new file mode 100644
index 0000000..d1464e5
--- /dev/null
+++ b/drivers/mfd/88pm860x-core.c
@@ -0,0 +1,134 @@
+/*
+ * Base driver for Marvell 88PM8607
+ *
+ * Copyright (C) 2009 Marvell International Ltd.
+ * 	Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/88pm8607.h>
+
+
+#define PM8607_REG_RESOURCE(_start, _end)		\
+{							\
+	.start	= PM8607_##_start,			\
+	.end	= PM8607_##_end,			\
+	.flags	= IORESOURCE_IO,			\
+}
+
+static struct resource pm8607_regulator_resources[] = {
+	PM8607_REG_RESOURCE(BUCK1, BUCK1),
+	PM8607_REG_RESOURCE(BUCK2, BUCK2),
+	PM8607_REG_RESOURCE(BUCK3, BUCK3),
+	PM8607_REG_RESOURCE(LDO1,  LDO1),
+	PM8607_REG_RESOURCE(LDO2,  LDO2),
+	PM8607_REG_RESOURCE(LDO3,  LDO3),
+	PM8607_REG_RESOURCE(LDO4,  LDO4),
+	PM8607_REG_RESOURCE(LDO5,  LDO5),
+	PM8607_REG_RESOURCE(LDO6,  LDO6),
+	PM8607_REG_RESOURCE(LDO7,  LDO7),
+	PM8607_REG_RESOURCE(LDO8,  LDO8),
+	PM8607_REG_RESOURCE(LDO9,  LDO9),
+	PM8607_REG_RESOURCE(LDO10, LDO10),
+	PM8607_REG_RESOURCE(LDO12, LDO12),
+	PM8607_REG_RESOURCE(LDO14, LDO14),
+};
+
+#define PM8607_REG_DEVS(_name, _id)					\
+{									\
+	.name		= "88pm8607-" #_name,				\
+	.num_resources	= 1,						\
+	.resources	= &pm8607_regulator_resources[PM8607_ID_##_id],	\
+}
+
+static struct mfd_cell pm8607_devs[] = {
+	PM8607_REG_DEVS(buck1, BUCK1),
+	PM8607_REG_DEVS(buck2, BUCK2),
+	PM8607_REG_DEVS(buck3, BUCK3),
+	PM8607_REG_DEVS(ldo1,  LDO1),
+	PM8607_REG_DEVS(ldo2,  LDO2),
+	PM8607_REG_DEVS(ldo3,  LDO3),
+	PM8607_REG_DEVS(ldo4,  LDO4),
+	PM8607_REG_DEVS(ldo5,  LDO5),
+	PM8607_REG_DEVS(ldo6,  LDO6),
+	PM8607_REG_DEVS(ldo7,  LDO7),
+	PM8607_REG_DEVS(ldo8,  LDO8),
+	PM8607_REG_DEVS(ldo9,  LDO9),
+	PM8607_REG_DEVS(ldo10, LDO10),
+	PM8607_REG_DEVS(ldo12, LDO12),
+	PM8607_REG_DEVS(ldo14, LDO14),
+};
+
+int pm860x_device_init(struct pm8607_chip *chip,
+		       struct pm8607_platform_data *pdata)
+{
+	int i, count;
+	int ret;
+
+	ret = pm8607_reg_read(chip, PM8607_CHIP_ID);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to read CHIP ID: %d\n", ret);
+		goto out;
+	}
+	if ((ret & PM8607_ID_MASK) == PM8607_ID)
+		dev_info(chip->dev, "Marvell 88PM8607 (ID: %02x) detected\n",
+			 ret);
+	else {
+		dev_err(chip->dev, "Failed to detect Marvell 88PM8607. "
+			"Chip ID: %02x\n", ret);
+		goto out;
+	}
+	chip->chip_id = ret;
+
+	ret = pm8607_reg_read(chip, PM8607_BUCK3);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to read BUCK3 register: %d\n", ret);
+		goto out;
+	}
+	if (ret & PM8607_BUCK3_DOUBLE)
+		chip->buck3_double = 1;
+
+	ret = pm8607_reg_read(chip, PM8607_MISC1);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to read MISC1 register: %d\n", ret);
+		goto out;
+	}
+	if (pdata->i2c_port == PI2C_PORT)
+		ret |= PM8607_MISC1_PI2C;
+	else
+		ret &= ~PM8607_MISC1_PI2C;
+	ret = pm8607_reg_write(chip, PM8607_MISC1, ret);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to write MISC1 register: %d\n", ret);
+		goto out;
+	}
+
+	count = ARRAY_SIZE(pm8607_devs);
+	for (i = 0; i < count; i++) {
+		ret = mfd_add_devices(chip->dev, i, &pm8607_devs[i],
+				      1, NULL, 0);
+		if (ret != 0) {
+			dev_err(chip->dev, "Failed to add subdevs\n");
+			goto out;
+		}
+	}
+out:
+	return ret;
+}
+
+void pm8607_device_exit(struct pm8607_chip *chip)
+{
+	mfd_remove_devices(chip->dev);
+}
+
+MODULE_DESCRIPTION("PMIC Driver for Marvell 88PM8607");
+MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/88pm860x-i2c.c b/drivers/mfd/88pm860x-i2c.c
new file mode 100644
index 0000000..dda23cb
--- /dev/null
+++ b/drivers/mfd/88pm860x-i2c.c
@@ -0,0 +1,202 @@
+/*
+ * I2C driver for Marvell 88PM8607
+ *
+ * Copyright (C) 2009 Marvell International Ltd.
+ * 	Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/mfd/88pm8607.h>
+
+static inline int pm8607_read_device(struct pm8607_chip *chip,
+				     int reg, int bytes, void *dest)
+{
+	struct i2c_client *i2c = chip->client;
+	unsigned char data;
+	int ret;
+
+	data = (unsigned char)reg;
+	ret = i2c_master_send(i2c, &data, 1);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_master_recv(i2c, dest, bytes);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static inline int pm8607_write_device(struct pm8607_chip *chip,
+				      int reg, int bytes, void *src)
+{
+	struct i2c_client *i2c = chip->client;
+	unsigned char buf[bytes + 1];
+	int ret;
+
+	buf[0] = (unsigned char)reg;
+	memcpy(&buf[1], src, bytes);
+
+	ret = i2c_master_send(i2c, buf, bytes + 1);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+int pm8607_reg_read(struct pm8607_chip *chip, int reg)
+{
+	unsigned char data;
+	int ret;
+
+	mutex_lock(&chip->io_lock);
+	ret = chip->read(chip, reg, 1, &data);
+	mutex_unlock(&chip->io_lock);
+
+	if (ret < 0)
+		return ret;
+	else
+		return (int)data;
+}
+EXPORT_SYMBOL(pm8607_reg_read);
+
+int pm8607_reg_write(struct pm8607_chip *chip, int reg,
+		     unsigned char data)
+{
+	int ret;
+
+	mutex_lock(&chip->io_lock);
+	ret = chip->write(chip, reg, 1, &data);
+	mutex_unlock(&chip->io_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(pm8607_reg_write);
+
+int pm8607_bulk_read(struct pm8607_chip *chip, int reg,
+		     int count, unsigned char *buf)
+{
+	int ret;
+
+	mutex_lock(&chip->io_lock);
+	ret = chip->read(chip, reg, count, buf);
+	mutex_unlock(&chip->io_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(pm8607_bulk_read);
+
+int pm8607_bulk_write(struct pm8607_chip *chip, int reg,
+		      int count, unsigned char *buf)
+{
+	int ret;
+
+	mutex_lock(&chip->io_lock);
+	ret = chip->write(chip, reg, count, buf);
+	mutex_unlock(&chip->io_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(pm8607_bulk_write);
+
+int pm8607_set_bits(struct pm8607_chip *chip, int reg,
+		    unsigned char mask, unsigned char data)
+{
+	unsigned char value;
+	int ret;
+
+	mutex_lock(&chip->io_lock);
+	ret = chip->read(chip, reg, 1, &value);
+	if (ret < 0)
+		goto out;
+	value &= ~mask;
+	value |= data;
+	ret = chip->write(chip, reg, 1, &value);
+out:
+	mutex_unlock(&chip->io_lock);
+	return ret;
+}
+EXPORT_SYMBOL(pm8607_set_bits);
+
+
+static const struct i2c_device_id pm860x_id_table[] = {
+	{ "88PM8607", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, pm860x_id_table);
+
+static int __devinit pm860x_probe(struct i2c_client *client,
+				  const struct i2c_device_id *id)
+{
+	struct pm8607_platform_data *pdata = client->dev.platform_data;
+	struct pm8607_chip *chip;
+	int ret;
+
+	chip = kzalloc(sizeof(struct pm8607_chip), GFP_KERNEL);
+	if (chip == NULL)
+		return -ENOMEM;
+
+	chip->client = client;
+	chip->dev = &client->dev;
+	chip->read = pm8607_read_device;
+	chip->write = pm8607_write_device;
+	memcpy(&chip->id, id, sizeof(struct i2c_device_id));
+	i2c_set_clientdata(client, chip);
+
+	mutex_init(&chip->io_lock);
+	dev_set_drvdata(chip->dev, chip);
+
+	ret = pm860x_device_init(chip, pdata);
+	if (ret < 0)
+		goto out;
+
+
+	return 0;
+
+out:
+	i2c_set_clientdata(client, NULL);
+	kfree(chip);
+	return ret;
+}
+
+static int __devexit pm860x_remove(struct i2c_client *client)
+{
+	struct pm8607_chip *chip = i2c_get_clientdata(client);
+
+	kfree(chip);
+	return 0;
+}
+
+static struct i2c_driver pm860x_driver = {
+	.driver	= {
+		.name	= "88PM860x",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= pm860x_probe,
+	.remove		= __devexit_p(pm860x_remove),
+	.id_table	= pm860x_id_table,
+};
+
+static int __init pm860x_i2c_init(void)
+{
+	int ret;
+	ret = i2c_add_driver(&pm860x_driver);
+	if (ret != 0)
+		pr_err("Failed to register 88PM860x I2C driver: %d\n", ret);
+	return ret;
+}
+subsys_initcall(pm860x_i2c_init);
+
+static void __exit pm860x_i2c_exit(void)
+{
+	i2c_del_driver(&pm860x_driver);
+}
+module_exit(pm860x_i2c_exit);
+
+MODULE_DESCRIPTION("I2C Driver for Marvell 88PM860x");
+MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index e863c64..bb000a0 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -50,4 +50,4 @@ obj-$(CONFIG_PCF50633_ADC)	+= pcf50633-adc.o
 obj-$(CONFIG_PCF50633_GPIO)	+= pcf50633-gpio.o
 obj-$(CONFIG_AB3100_CORE)	+= ab3100-core.o
 obj-$(CONFIG_AB3100_OTP)	+= ab3100-otp.o
-obj-$(CONFIG_MFD_88PM8607)	+= 88pm8607.o
+obj-$(CONFIG_MFD_88PM8607)	+= 88pm860x-core.o 88pm860x-i2c.o
diff --git a/include/linux/mfd/88pm8607.h b/include/linux/mfd/88pm8607.h
index f41b428..6e4dcdc 100644
--- a/include/linux/mfd/88pm8607.h
+++ b/include/linux/mfd/88pm8607.h
@@ -33,8 +33,8 @@ enum {
 	PM8607_ID_RG_MAX,
 };

-#define CHIP_ID				(0x40)
-#define CHIP_ID_MASK			(0xF8)
+#define PM8607_ID			(0x40)	/* 8607 chip ID */
+#define PM8607_ID_MASK			(0xF8)	/* 8607 chip ID mask */

 /* Interrupt Registers */
 #define PM8607_STATUS_1			(0x01)
@@ -185,6 +185,7 @@ struct pm8607_chip {
 	struct device		*dev;
 	struct mutex		io_lock;
 	struct i2c_client	*client;
+	struct i2c_device_id	id;

 	int (*read)(struct pm8607_chip *chip, int reg, int bytes, void *dest);
 	int (*write)(struct pm8607_chip *chip, int reg, int bytes, void *src);
@@ -214,4 +215,9 @@ extern int pm8607_bulk_write(struct pm8607_chip *, int, int,
 			     unsigned char *);
 extern int pm8607_set_bits(struct pm8607_chip *, int, unsigned char,
 			   unsigned char);
-#endif /* __LINUX_MFD_88PM8607_H */
+
+extern int pm860x_device_init(struct pm8607_chip *chip,
+			      struct pm8607_platform_data *pdata);
+extern void pm860x_device_exit(struct pm8607_chip *chip);
+
+#endif /* __LINUX_MFD_88PM860X_H */
-- 
1.5.6.5
