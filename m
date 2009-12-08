From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 8 Dec 2009 09:05:28 -0500
Subject: [PATCH] mfd: support 88pm8606 in 860x driver
Message-ID: <mailman.80.1260364289.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88PM8606 and 88PM8607 are two discrete chips used for power management.
Hardware designer can use them together or only one of them according to
requirement.

There's some logic tightly linked between these two chips. For example, USB
charger driver needs to access both chips by I2C interface.

Now share one driver to these two devices. Only one I2C client is identified
in platform init data. If another chip is also used, user should mark it in
companion_addr field of platform init data. Then driver could create another
I2C client for the companion chip.

All I2C operations are accessed by 860x-i2c driver. In order to support both
I2C client address, the read/write API is changed in below.

reg_read(client, offset)
reg_write(client, offset, data)

The benefit is that client drivers only need one kind of read/write API. I2C
and MFD driver can be shared in both 8606 and 8607.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mfd/88pm860x-core.c  |   61 ++++++++----
 drivers/mfd/88pm860x-i2c.c   |  156 +++++++++++++++++++----------
 include/linux/mfd/88pm8607.h |  223 -----------------------------------------
 include/linux/mfd/88pm860x.h |  226 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 369 insertions(+), 297 deletions(-)
 delete mode 100644 include/linux/mfd/88pm8607.h
 create mode 100644 include/linux/mfd/88pm860x.h

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index d1464e5..72b0030 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -14,7 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/core.h>
-#include <linux/mfd/88pm8607.h>
+#include <linux/mfd/88pm860x.h>


 #define PM8607_REG_RESOURCE(_start, _end)		\
@@ -67,18 +67,23 @@ static struct mfd_cell pm8607_devs[] = {
 	PM8607_REG_DEVS(ldo14, LDO14),
 };

-int pm860x_device_init(struct pm8607_chip *chip,
-		       struct pm8607_platform_data *pdata)
+static void device_8606_init(struct pm860x_chip *chip, struct i2c_client *i2c,
+			     struct pm860x_platform_data *pdata)
+{
+}
+
+static void device_8607_init(struct pm860x_chip *chip, struct i2c_client *i2c,
+			     struct pm860x_platform_data *pdata)
 {
 	int i, count;
 	int ret;

-	ret = pm8607_reg_read(chip, PM8607_CHIP_ID);
+	ret = pm860x_reg_read(i2c, PM8607_CHIP_ID);
 	if (ret < 0) {
 		dev_err(chip->dev, "Failed to read CHIP ID: %d\n", ret);
 		goto out;
 	}
-	if ((ret & PM8607_ID_MASK) == PM8607_ID)
+	if ((ret & PM8607_VERSION_MASK) == PM8607_VERSION)
 		dev_info(chip->dev, "Marvell 88PM8607 (ID: %02x) detected\n",
 			 ret);
 	else {
@@ -86,9 +91,9 @@ int pm860x_device_init(struct pm8607_chip *chip,
 			"Chip ID: %02x\n", ret);
 		goto out;
 	}
-	chip->chip_id = ret;
+	chip->chip_version = ret;

-	ret = pm8607_reg_read(chip, PM8607_BUCK3);
+	ret = pm860x_reg_read(i2c, PM8607_BUCK3);
 	if (ret < 0) {
 		dev_err(chip->dev, "Failed to read BUCK3 register: %d\n", ret);
 		goto out;
@@ -96,20 +101,11 @@ int pm860x_device_init(struct pm8607_chip *chip,
 	if (ret & PM8607_BUCK3_DOUBLE)
 		chip->buck3_double = 1;

-	ret = pm8607_reg_read(chip, PM8607_MISC1);
+	ret = pm860x_reg_read(i2c, PM8607_MISC1);
 	if (ret < 0) {
 		dev_err(chip->dev, "Failed to read MISC1 register: %d\n", ret);
 		goto out;
 	}
-	if (pdata->i2c_port == PI2C_PORT)
-		ret |= PM8607_MISC1_PI2C;
-	else
-		ret &= ~PM8607_MISC1_PI2C;
-	ret = pm8607_reg_write(chip, PM8607_MISC1, ret);
-	if (ret < 0) {
-		dev_err(chip->dev, "Failed to write MISC1 register: %d\n", ret);
-		goto out;
-	}

 	count = ARRAY_SIZE(pm8607_devs);
 	for (i = 0; i < count; i++) {
@@ -121,14 +117,39 @@ int pm860x_device_init(struct pm8607_chip *chip,
 		}
 	}
 out:
-	return ret;
+	return;
+}
+
+int pm860x_device_init(struct pm860x_chip *chip,
+		       struct pm860x_platform_data *pdata)
+{
+	switch (chip->id) {
+	case CHIP_PM8606:
+		device_8606_init(chip, chip->client, pdata);
+		break;
+	case CHIP_PM8607:
+		device_8607_init(chip, chip->client, pdata);
+		break;
+	}
+
+	if (chip->companion) {
+		switch (chip->id) {
+		case CHIP_PM8607:
+			device_8606_init(chip, chip->companion, pdata);
+			break;
+		case CHIP_PM8606:
+			device_8607_init(chip, chip->companion, pdata);
+			break;
+		}
+	}
+	return 0;
 }

-void pm8607_device_exit(struct pm8607_chip *chip)
+void pm860x_device_exit(struct pm860x_chip *chip)
 {
 	mfd_remove_devices(chip->dev);
 }

-MODULE_DESCRIPTION("PMIC Driver for Marvell 88PM8607");
+MODULE_DESCRIPTION("PMIC Driver for Marvell 88PM860x");
 MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/88pm860x-i2c.c b/drivers/mfd/88pm860x-i2c.c
index dda23cb..a5c6b49 100644
--- a/drivers/mfd/88pm860x-i2c.c
+++ b/drivers/mfd/88pm860x-i2c.c
@@ -1,5 +1,5 @@
 /*
- * I2C driver for Marvell 88PM8607
+ * I2C driver for Marvell 88PM860x
  *
  * Copyright (C) 2009 Marvell International Ltd.
  * 	Haojian Zhuang <haojian.zhuang@marvell.com>
@@ -12,12 +12,13 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
-#include <linux/mfd/88pm8607.h>
+#include <linux/mfd/88pm860x.h>

-static inline int pm8607_read_device(struct pm8607_chip *chip,
+static struct mutex io_lock;
+
+static inline int pm860x_read_device(struct i2c_client *i2c,
 				     int reg, int bytes, void *dest)
 {
-	struct i2c_client *i2c = chip->client;
 	unsigned char data;
 	int ret;

@@ -32,10 +33,9 @@ static inline int pm8607_read_device(struct
pm8607_chip *chip,
 	return 0;
 }

-static inline int pm8607_write_device(struct pm8607_chip *chip,
+static inline int pm860x_write_device(struct i2c_client *i2c,
 				      int reg, int bytes, void *src)
 {
-	struct i2c_client *i2c = chip->client;
 	unsigned char buf[bytes + 1];
 	int ret;

@@ -48,116 +48,162 @@ static inline int pm8607_write_device(struct
pm8607_chip *chip,
 	return 0;
 }

-int pm8607_reg_read(struct pm8607_chip *chip, int reg)
+int pm860x_reg_read(struct i2c_client *i2c, int reg)
 {
 	unsigned char data;
 	int ret;

-	mutex_lock(&chip->io_lock);
-	ret = chip->read(chip, reg, 1, &data);
-	mutex_unlock(&chip->io_lock);
+	mutex_lock(&io_lock);
+	ret = pm860x_read_device(i2c, reg, 1, &data);
+	mutex_unlock(&io_lock);

 	if (ret < 0)
 		return ret;
 	else
 		return (int)data;
 }
-EXPORT_SYMBOL(pm8607_reg_read);
+EXPORT_SYMBOL(pm860x_reg_read);

-int pm8607_reg_write(struct pm8607_chip *chip, int reg,
+int pm860x_reg_write(struct i2c_client *i2c, int reg,
 		     unsigned char data)
 {
 	int ret;

-	mutex_lock(&chip->io_lock);
-	ret = chip->write(chip, reg, 1, &data);
-	mutex_unlock(&chip->io_lock);
+	mutex_lock(&io_lock);
+	ret = pm860x_write_device(i2c, reg, 1, &data);
+	mutex_unlock(&io_lock);

 	return ret;
 }
-EXPORT_SYMBOL(pm8607_reg_write);
+EXPORT_SYMBOL(pm860x_reg_write);

-int pm8607_bulk_read(struct pm8607_chip *chip, int reg,
+int pm860x_bulk_read(struct i2c_client *i2c, int reg,
 		     int count, unsigned char *buf)
 {
 	int ret;

-	mutex_lock(&chip->io_lock);
-	ret = chip->read(chip, reg, count, buf);
-	mutex_unlock(&chip->io_lock);
+	mutex_lock(&io_lock);
+	ret = pm860x_read_device(i2c, reg, count, buf);
+	mutex_unlock(&io_lock);

 	return ret;
 }
-EXPORT_SYMBOL(pm8607_bulk_read);
+EXPORT_SYMBOL(pm860x_bulk_read);

-int pm8607_bulk_write(struct pm8607_chip *chip, int reg,
+int pm860x_bulk_write(struct i2c_client *i2c, int reg,
 		      int count, unsigned char *buf)
 {
 	int ret;

-	mutex_lock(&chip->io_lock);
-	ret = chip->write(chip, reg, count, buf);
-	mutex_unlock(&chip->io_lock);
+	mutex_lock(&io_lock);
+	ret = pm860x_write_device(i2c, reg, count, buf);
+	mutex_unlock(&io_lock);

 	return ret;
 }
-EXPORT_SYMBOL(pm8607_bulk_write);
+EXPORT_SYMBOL(pm860x_bulk_write);

-int pm8607_set_bits(struct pm8607_chip *chip, int reg,
+int pm860x_set_bits(struct i2c_client *i2c, int reg,
 		    unsigned char mask, unsigned char data)
 {
 	unsigned char value;
 	int ret;

-	mutex_lock(&chip->io_lock);
-	ret = chip->read(chip, reg, 1, &value);
+	mutex_lock(&io_lock);
+	ret = pm860x_read_device(i2c, reg, 1, &value);
 	if (ret < 0)
 		goto out;
 	value &= ~mask;
 	value |= data;
-	ret = chip->write(chip, reg, 1, &value);
+	ret = pm860x_write_device(i2c, reg, 1, &value);
 out:
-	mutex_unlock(&chip->io_lock);
+	mutex_unlock(&io_lock);
 	return ret;
 }
-EXPORT_SYMBOL(pm8607_set_bits);
+EXPORT_SYMBOL(pm860x_set_bits);


 static const struct i2c_device_id pm860x_id_table[] = {
-	{ "88PM8607", 0 },
+	{ "88PM860x", 0 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, pm860x_id_table);

+static int verify_addr(struct i2c_client *i2c)
+{
+	unsigned short addr_8607[] = {0x30, 0x34};
+	unsigned short addr_8606[] = {0x10, 0x11};
+	int size, i;
+
+	if (i2c == NULL)
+		return 0;
+	size = ARRAY_SIZE(addr_8606);
+	for (i = 0; i < size; i++) {
+		if (i2c->addr == *(addr_8606 + i))
+			return CHIP_PM8606;
+	}
+	size = ARRAY_SIZE(addr_8607);
+	for (i = 0; i < size; i++) {
+		if (i2c->addr == *(addr_8607 + i))
+			return CHIP_PM8607;
+	}
+	return 0;
+}
+
 static int __devinit pm860x_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
-	struct pm8607_platform_data *pdata = client->dev.platform_data;
-	struct pm8607_chip *chip;
+	struct pm860x_platform_data *pdata = client->dev.platform_data;
+	struct pm860x_chip *chip;
+	struct i2c_board_info i2c_info = {
+		.type		= "88PM860x",
+		.platform_data	= client->dev.platform_data,
+	};
+	int addr_c, found_companion = 0;
 	int ret;

-	chip = kzalloc(sizeof(struct pm8607_chip), GFP_KERNEL);
-	if (chip == NULL)
-		return -ENOMEM;
-
-	chip->client = client;
-	chip->dev = &client->dev;
-	chip->read = pm8607_read_device;
-	chip->write = pm8607_write_device;
-	memcpy(&chip->id, id, sizeof(struct i2c_device_id));
-	i2c_set_clientdata(client, chip);
-
-	mutex_init(&chip->io_lock);
-	dev_set_drvdata(chip->dev, chip);
-
-	ret = pm860x_device_init(chip, pdata);
-	if (ret < 0)
-		goto out;
-
+	if (pdata == NULL) {
+		pr_info("No platform data in %s!\n", __func__);
+		return -EINVAL;
+	}
+
+	addr_c = pdata->companion_addr;
+	if (addr_c && (addr_c != client->addr)) {
+		i2c_info.addr = addr_c;
+		found_companion = 1;
+	}
+
+	if (found_companion || (addr_c == 0)) {
+		chip = kzalloc(sizeof(struct pm860x_chip), GFP_KERNEL);
+		if (chip == NULL)
+			return -ENOMEM;
+
+		chip->id = verify_addr(client);
+		chip->client = client;
+		i2c_set_clientdata(client, chip);
+		chip->dev = &client->dev;
+		mutex_init(&io_lock);
+		dev_set_drvdata(chip->dev, chip);
+
+		if (found_companion) {
+			chip->companion = i2c_new_device(client->adapter,
+							 &i2c_info);
+			i2c_set_clientdata(chip->companion, chip);
+		}
+
+		ret = pm860x_device_init(chip, pdata);
+		if (ret < 0)
+			goto out;
+	}

 	return 0;

 out:
+	if (chip->companion) {
+		i2c_unregister_device(chip->companion);
+		i2c_set_clientdata(chip->companion, NULL);
+		return 0;
+	}
 	i2c_set_clientdata(client, NULL);
 	kfree(chip);
 	return ret;
@@ -165,8 +211,10 @@ out:

 static int __devexit pm860x_remove(struct i2c_client *client)
 {
-	struct pm8607_chip *chip = i2c_get_clientdata(client);
+	struct pm860x_chip *chip = i2c_get_clientdata(client);

+	if (chip->companion)
+		i2c_unregister_device(chip->companion);
 	kfree(chip);
 	return 0;
 }
diff --git a/include/linux/mfd/88pm8607.h b/include/linux/mfd/88pm8607.h
deleted file mode 100644
index 6e4dcdc..0000000
--- a/include/linux/mfd/88pm8607.h
+++ /dev/null
@@ -1,223 +0,0 @@
-/*
- * Marvell 88PM8607 Interface
- *
- * Copyright (C) 2009 Marvell International Ltd.
- * 	Haojian Zhuang <haojian.zhuang@marvell.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __LINUX_MFD_88PM8607_H
-#define __LINUX_MFD_88PM8607_H
-
-enum {
-	PM8607_ID_BUCK1 = 0,
-	PM8607_ID_BUCK2,
-	PM8607_ID_BUCK3,
-
-	PM8607_ID_LDO1,
-	PM8607_ID_LDO2,
-	PM8607_ID_LDO3,
-	PM8607_ID_LDO4,
-	PM8607_ID_LDO5,
-	PM8607_ID_LDO6,
-	PM8607_ID_LDO7,
-	PM8607_ID_LDO8,
-	PM8607_ID_LDO9,
-	PM8607_ID_LDO10,
-	PM8607_ID_LDO12,
-	PM8607_ID_LDO14,
-
-	PM8607_ID_RG_MAX,
-};
-
-#define PM8607_ID			(0x40)	/* 8607 chip ID */
-#define PM8607_ID_MASK			(0xF8)	/* 8607 chip ID mask */
-
-/* Interrupt Registers */
-#define PM8607_STATUS_1			(0x01)
-#define PM8607_STATUS_2			(0x02)
-#define PM8607_INT_STATUS1		(0x03)
-#define PM8607_INT_STATUS2		(0x04)
-#define PM8607_INT_STATUS3		(0x05)
-#define PM8607_INT_MASK_1		(0x06)
-#define PM8607_INT_MASK_2		(0x07)
-#define PM8607_INT_MASK_3		(0x08)
-
-/* Regulator Control Registers */
-#define PM8607_LDO1			(0x10)
-#define PM8607_LDO2			(0x11)
-#define PM8607_LDO3			(0x12)
-#define PM8607_LDO4			(0x13)
-#define PM8607_LDO5			(0x14)
-#define PM8607_LDO6			(0x15)
-#define PM8607_LDO7			(0x16)
-#define PM8607_LDO8			(0x17)
-#define PM8607_LDO9			(0x18)
-#define PM8607_LDO10			(0x19)
-#define PM8607_LDO12			(0x1A)
-#define PM8607_LDO14			(0x1B)
-#define PM8607_SLEEP_MODE1		(0x1C)
-#define PM8607_SLEEP_MODE2		(0x1D)
-#define PM8607_SLEEP_MODE3		(0x1E)
-#define PM8607_SLEEP_MODE4		(0x1F)
-#define PM8607_GO			(0x20)
-#define PM8607_SLEEP_BUCK1		(0x21)
-#define PM8607_SLEEP_BUCK2		(0x22)
-#define PM8607_SLEEP_BUCK3		(0x23)
-#define PM8607_BUCK1			(0x24)
-#define PM8607_BUCK2			(0x25)
-#define PM8607_BUCK3			(0x26)
-#define PM8607_BUCK_CONTROLS		(0x27)
-#define PM8607_SUPPLIES_EN11		(0x2B)
-#define PM8607_SUPPLIES_EN12		(0x2C)
-#define PM8607_GROUP1			(0x2D)
-#define PM8607_GROUP2			(0x2E)
-#define PM8607_GROUP3			(0x2F)
-#define PM8607_GROUP4			(0x30)
-#define PM8607_GROUP5			(0x31)
-#define PM8607_GROUP6			(0x32)
-#define PM8607_SUPPLIES_EN21		(0x33)
-#define PM8607_SUPPLIES_EN22		(0x34)
-
-/* RTC Control Registers */
-#define PM8607_RTC1			(0xA0)
-#define PM8607_RTC_COUNTER1		(0xA1)
-#define PM8607_RTC_COUNTER2		(0xA2)
-#define PM8607_RTC_COUNTER3		(0xA3)
-#define PM8607_RTC_COUNTER4		(0xA4)
-#define PM8607_RTC_EXPIRE1		(0xA5)
-#define PM8607_RTC_EXPIRE2		(0xA6)
-#define PM8607_RTC_EXPIRE3		(0xA7)
-#define PM8607_RTC_EXPIRE4		(0xA8)
-#define PM8607_RTC_TRIM1		(0xA9)
-#define PM8607_RTC_TRIM2		(0xAA)
-#define PM8607_RTC_TRIM3		(0xAB)
-#define PM8607_RTC_TRIM4		(0xAC)
-#define PM8607_RTC_MISC1		(0xAD)
-#define PM8607_RTC_MISC2		(0xAE)
-#define PM8607_RTC_MISC3		(0xAF)
-
-/* Misc Registers */
-#define PM8607_CHIP_ID			(0x00)
-#define PM8607_LDO1			(0x10)
-#define PM8607_DVC3			(0x26)
-#define PM8607_MISC1			(0x40)
-
-/* bit definitions for PM8607 events */
-#define PM8607_EVENT_ONKEY		(1 << 0)
-#define PM8607_EVENT_EXTON		(1 << 1)
-#define PM8607_EVENT_CHG		(1 << 2)
-#define PM8607_EVENT_BAT		(1 << 3)
-#define PM8607_EVENT_RTC		(1 << 4)
-#define PM8607_EVENT_CC			(1 << 5)
-#define PM8607_EVENT_VBAT		(1 << 8)
-#define PM8607_EVENT_VCHG		(1 << 9)
-#define PM8607_EVENT_VSYS		(1 << 10)
-#define PM8607_EVENT_TINT		(1 << 11)
-#define PM8607_EVENT_GPADC0		(1 << 12)
-#define PM8607_EVENT_GPADC1		(1 << 13)
-#define PM8607_EVENT_GPADC2		(1 << 14)
-#define PM8607_EVENT_GPADC3		(1 << 15)
-#define PM8607_EVENT_AUDIO_SHORT	(1 << 16)
-#define PM8607_EVENT_PEN		(1 << 17)
-#define PM8607_EVENT_HEADSET		(1 << 18)
-#define PM8607_EVENT_HOOK		(1 << 19)
-#define PM8607_EVENT_MICIN		(1 << 20)
-#define PM8607_EVENT_CHG_TIMEOUT	(1 << 21)
-#define PM8607_EVENT_CHG_DONE		(1 << 22)
-#define PM8607_EVENT_CHG_FAULT		(1 << 23)
-
-/* bit definitions of Status Query Interface */
-#define PM8607_STATUS_CC		(1 << 3)
-#define PM8607_STATUS_PEN		(1 << 4)
-#define PM8607_STATUS_HEADSET		(1 << 5)
-#define PM8607_STATUS_HOOK		(1 << 6)
-#define PM8607_STATUS_MICIN		(1 << 7)
-#define PM8607_STATUS_ONKEY		(1 << 8)
-#define PM8607_STATUS_EXTON		(1 << 9)
-#define PM8607_STATUS_CHG		(1 << 10)
-#define PM8607_STATUS_BAT		(1 << 11)
-#define PM8607_STATUS_VBUS		(1 << 12)
-#define PM8607_STATUS_OV		(1 << 13)
-
-/* bit definitions of BUCK3 */
-#define PM8607_BUCK3_DOUBLE		(1 << 6)
-
-/* bit definitions of Misc1 */
-#define PM8607_MISC1_PI2C		(1 << 0)
-
-/* Interrupt Number in 88PM8607 */
-enum {
-	PM8607_IRQ_ONKEY = 0,
-	PM8607_IRQ_EXTON,
-	PM8607_IRQ_CHG,
-	PM8607_IRQ_BAT,
-	PM8607_IRQ_RTC,
-	PM8607_IRQ_VBAT = 8,
-	PM8607_IRQ_VCHG,
-	PM8607_IRQ_VSYS,
-	PM8607_IRQ_TINT,
-	PM8607_IRQ_GPADC0,
-	PM8607_IRQ_GPADC1,
-	PM8607_IRQ_GPADC2,
-	PM8607_IRQ_GPADC3,
-	PM8607_IRQ_AUDIO_SHORT = 16,
-	PM8607_IRQ_PEN,
-	PM8607_IRQ_HEADSET,
-	PM8607_IRQ_HOOK,
-	PM8607_IRQ_MICIN,
-	PM8607_IRQ_CHG_FAIL,
-	PM8607_IRQ_CHG_DONE,
-	PM8607_IRQ_CHG_FAULT,
-};
-
-enum {
-	PM8607_CHIP_A0 = 0x40,
-	PM8607_CHIP_A1 = 0x41,
-	PM8607_CHIP_B0 = 0x48,
-};
-
-
-struct pm8607_chip {
-	struct device		*dev;
-	struct mutex		io_lock;
-	struct i2c_client	*client;
-	struct i2c_device_id	id;
-
-	int (*read)(struct pm8607_chip *chip, int reg, int bytes, void *dest);
-	int (*write)(struct pm8607_chip *chip, int reg, int bytes, void *src);
-
-	int			buck3_double;	/* DVC ramp slope double */
-	unsigned char		chip_id;
-
-};
-
-#define PM8607_MAX_REGULATOR	15	/* 3 Bucks, 12 LDOs */
-
-enum {
-	GI2C_PORT = 0,
-	PI2C_PORT,
-};
-
-struct pm8607_platform_data {
-	int	i2c_port;	/* Controlled by GI2C or PI2C */
-	struct regulator_init_data *regulator[PM8607_MAX_REGULATOR];
-};
-
-extern int pm8607_reg_read(struct pm8607_chip *, int);
-extern int pm8607_reg_write(struct pm8607_chip *, int, unsigned char);
-extern int pm8607_bulk_read(struct pm8607_chip *, int, int,
-			    unsigned char *);
-extern int pm8607_bulk_write(struct pm8607_chip *, int, int,
-			     unsigned char *);
-extern int pm8607_set_bits(struct pm8607_chip *, int, unsigned char,
-			   unsigned char);
-
-extern int pm860x_device_init(struct pm8607_chip *chip,
-			      struct pm8607_platform_data *pdata);
-extern void pm860x_device_exit(struct pm8607_chip *chip);
-
-#endif /* __LINUX_MFD_88PM860X_H */
diff --git a/include/linux/mfd/88pm860x.h b/include/linux/mfd/88pm860x.h
new file mode 100644
index 0000000..b648b9f
--- /dev/null
+++ b/include/linux/mfd/88pm860x.h
@@ -0,0 +1,226 @@
+/*
+ * Marvell 88PM860x Interface
+ *
+ * Copyright (C) 2009 Marvell International Ltd.
+ * 	Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_MFD_88PM860X_H
+#define __LINUX_MFD_88PM860X_H
+
+enum {
+	CHIP_INVALID = 0,
+	CHIP_PM8606,
+	CHIP_PM8607,
+	CHIP_MAX,
+};
+
+enum {
+	PM8607_ID_BUCK1 = 0,
+	PM8607_ID_BUCK2,
+	PM8607_ID_BUCK3,
+
+	PM8607_ID_LDO1,
+	PM8607_ID_LDO2,
+	PM8607_ID_LDO3,
+	PM8607_ID_LDO4,
+	PM8607_ID_LDO5,
+	PM8607_ID_LDO6,
+	PM8607_ID_LDO7,
+	PM8607_ID_LDO8,
+	PM8607_ID_LDO9,
+	PM8607_ID_LDO10,
+	PM8607_ID_LDO12,
+	PM8607_ID_LDO14,
+
+	PM8607_ID_RG_MAX,
+};
+
+#define PM8607_VERSION			(0x40)	/* 8607 chip ID */
+#define PM8607_VERSION_MASK		(0xF0)	/* 8607 chip ID mask */
+
+/* Interrupt Registers */
+#define PM8607_STATUS_1			(0x01)
+#define PM8607_STATUS_2			(0x02)
+#define PM8607_INT_STATUS1		(0x03)
+#define PM8607_INT_STATUS2		(0x04)
+#define PM8607_INT_STATUS3		(0x05)
+#define PM8607_INT_MASK_1		(0x06)
+#define PM8607_INT_MASK_2		(0x07)
+#define PM8607_INT_MASK_3		(0x08)
+
+/* Regulator Control Registers */
+#define PM8607_LDO1			(0x10)
+#define PM8607_LDO2			(0x11)
+#define PM8607_LDO3			(0x12)
+#define PM8607_LDO4			(0x13)
+#define PM8607_LDO5			(0x14)
+#define PM8607_LDO6			(0x15)
+#define PM8607_LDO7			(0x16)
+#define PM8607_LDO8			(0x17)
+#define PM8607_LDO9			(0x18)
+#define PM8607_LDO10			(0x19)
+#define PM8607_LDO12			(0x1A)
+#define PM8607_LDO14			(0x1B)
+#define PM8607_SLEEP_MODE1		(0x1C)
+#define PM8607_SLEEP_MODE2		(0x1D)
+#define PM8607_SLEEP_MODE3		(0x1E)
+#define PM8607_SLEEP_MODE4		(0x1F)
+#define PM8607_GO			(0x20)
+#define PM8607_SLEEP_BUCK1		(0x21)
+#define PM8607_SLEEP_BUCK2		(0x22)
+#define PM8607_SLEEP_BUCK3		(0x23)
+#define PM8607_BUCK1			(0x24)
+#define PM8607_BUCK2			(0x25)
+#define PM8607_BUCK3			(0x26)
+#define PM8607_BUCK_CONTROLS		(0x27)
+#define PM8607_SUPPLIES_EN11		(0x2B)
+#define PM8607_SUPPLIES_EN12		(0x2C)
+#define PM8607_GROUP1			(0x2D)
+#define PM8607_GROUP2			(0x2E)
+#define PM8607_GROUP3			(0x2F)
+#define PM8607_GROUP4			(0x30)
+#define PM8607_GROUP5			(0x31)
+#define PM8607_GROUP6			(0x32)
+#define PM8607_SUPPLIES_EN21		(0x33)
+#define PM8607_SUPPLIES_EN22		(0x34)
+
+/* RTC Control Registers */
+#define PM8607_RTC1			(0xA0)
+#define PM8607_RTC_COUNTER1		(0xA1)
+#define PM8607_RTC_COUNTER2		(0xA2)
+#define PM8607_RTC_COUNTER3		(0xA3)
+#define PM8607_RTC_COUNTER4		(0xA4)
+#define PM8607_RTC_EXPIRE1		(0xA5)
+#define PM8607_RTC_EXPIRE2		(0xA6)
+#define PM8607_RTC_EXPIRE3		(0xA7)
+#define PM8607_RTC_EXPIRE4		(0xA8)
+#define PM8607_RTC_TRIM1		(0xA9)
+#define PM8607_RTC_TRIM2		(0xAA)
+#define PM8607_RTC_TRIM3		(0xAB)
+#define PM8607_RTC_TRIM4		(0xAC)
+#define PM8607_RTC_MISC1		(0xAD)
+#define PM8607_RTC_MISC2		(0xAE)
+#define PM8607_RTC_MISC3		(0xAF)
+
+/* Misc Registers */
+#define PM8607_CHIP_ID			(0x00)
+#define PM8607_LDO1			(0x10)
+#define PM8607_DVC3			(0x26)
+#define PM8607_MISC1			(0x40)
+
+/* bit definitions for PM8607 events */
+#define PM8607_EVENT_ONKEY		(1 << 0)
+#define PM8607_EVENT_EXTON		(1 << 1)
+#define PM8607_EVENT_CHG		(1 << 2)
+#define PM8607_EVENT_BAT		(1 << 3)
+#define PM8607_EVENT_RTC		(1 << 4)
+#define PM8607_EVENT_CC			(1 << 5)
+#define PM8607_EVENT_VBAT		(1 << 8)
+#define PM8607_EVENT_VCHG		(1 << 9)
+#define PM8607_EVENT_VSYS		(1 << 10)
+#define PM8607_EVENT_TINT		(1 << 11)
+#define PM8607_EVENT_GPADC0		(1 << 12)
+#define PM8607_EVENT_GPADC1		(1 << 13)
+#define PM8607_EVENT_GPADC2		(1 << 14)
+#define PM8607_EVENT_GPADC3		(1 << 15)
+#define PM8607_EVENT_AUDIO_SHORT	(1 << 16)
+#define PM8607_EVENT_PEN		(1 << 17)
+#define PM8607_EVENT_HEADSET		(1 << 18)
+#define PM8607_EVENT_HOOK		(1 << 19)
+#define PM8607_EVENT_MICIN		(1 << 20)
+#define PM8607_EVENT_CHG_TIMEOUT	(1 << 21)
+#define PM8607_EVENT_CHG_DONE		(1 << 22)
+#define PM8607_EVENT_CHG_FAULT		(1 << 23)
+
+/* bit definitions of Status Query Interface */
+#define PM8607_STATUS_CC		(1 << 3)
+#define PM8607_STATUS_PEN		(1 << 4)
+#define PM8607_STATUS_HEADSET		(1 << 5)
+#define PM8607_STATUS_HOOK		(1 << 6)
+#define PM8607_STATUS_MICIN		(1 << 7)
+#define PM8607_STATUS_ONKEY		(1 << 8)
+#define PM8607_STATUS_EXTON		(1 << 9)
+#define PM8607_STATUS_CHG		(1 << 10)
+#define PM8607_STATUS_BAT		(1 << 11)
+#define PM8607_STATUS_VBUS		(1 << 12)
+#define PM8607_STATUS_OV		(1 << 13)
+
+/* bit definitions of BUCK3 */
+#define PM8607_BUCK3_DOUBLE		(1 << 6)
+
+/* bit definitions of Misc1 */
+#define PM8607_MISC1_PI2C		(1 << 0)
+
+/* Interrupt Number in 88PM8607 */
+enum {
+	PM8607_IRQ_ONKEY = 0,
+	PM8607_IRQ_EXTON,
+	PM8607_IRQ_CHG,
+	PM8607_IRQ_BAT,
+	PM8607_IRQ_RTC,
+	PM8607_IRQ_VBAT = 8,
+	PM8607_IRQ_VCHG,
+	PM8607_IRQ_VSYS,
+	PM8607_IRQ_TINT,
+	PM8607_IRQ_GPADC0,
+	PM8607_IRQ_GPADC1,
+	PM8607_IRQ_GPADC2,
+	PM8607_IRQ_GPADC3,
+	PM8607_IRQ_AUDIO_SHORT = 16,
+	PM8607_IRQ_PEN,
+	PM8607_IRQ_HEADSET,
+	PM8607_IRQ_HOOK,
+	PM8607_IRQ_MICIN,
+	PM8607_IRQ_CHG_FAIL,
+	PM8607_IRQ_CHG_DONE,
+	PM8607_IRQ_CHG_FAULT,
+};
+
+enum {
+	PM8607_CHIP_A0 = 0x40,
+	PM8607_CHIP_A1 = 0x41,
+	PM8607_CHIP_B0 = 0x48,
+};
+
+struct pm860x_chip {
+	struct device		*dev;
+	struct mutex		io_lock;
+	struct i2c_client	*client;
+	struct i2c_client	*companion;	/* companion chip client */
+
+	int			buck3_double;	/* DVC ramp slope double */
+	int			id;
+	unsigned char		chip_version;
+
+};
+
+#define PM8607_MAX_REGULATOR	15	/* 3 Bucks, 12 LDOs */
+
+enum {
+	GI2C_PORT = 0,
+	PI2C_PORT,
+};
+
+struct pm860x_platform_data {
+	unsigned short	companion_addr;	/* I2C address of companion chip */
+	int		i2c_port;	/* Controlled by GI2C or PI2C */
+	struct regulator_init_data *regulator[PM8607_MAX_REGULATOR];
+};
+
+extern int pm860x_reg_read(struct i2c_client *, int);
+extern int pm860x_reg_write(struct i2c_client *, int, unsigned char);
+extern int pm860x_bulk_read(struct i2c_client *, int, int, unsigned char *);
+extern int pm860x_bulk_write(struct i2c_client *, int, int, unsigned char *);
+extern int pm860x_set_bits(struct i2c_client *, int, unsigned char,
+			   unsigned char);
+
+extern int pm860x_device_init(struct pm860x_chip *chip,
+			      struct pm860x_platform_data *pdata);
+extern void pm860x_device_exit(struct pm860x_chip *chip);
+
+#endif /* __LINUX_MFD_88PM860X_H */
-- 
1.5.6.5
