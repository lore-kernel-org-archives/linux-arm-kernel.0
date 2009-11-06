From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 6 Nov 2009 09:22:52 -0500
Subject: [PATCH] mfd: support 88pm8606 in 860x driver
Message-ID: <mailman.19.1258102500.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88PM8606 and 88PM8607 are always used together. Although they're two discrete
chips, the logic function is tightly linked. For example, USB charger driver
is based on these two devices.

Now share one driver to these two devices. Create a logical chip structure
that contains both 8606 device and 8607 device.

All I2C operations are accessed by 860x-i2c driver. In order to support both
I2C client address, the read/write API is changed in below.

reg_read(chip, descriptor, offset)
reg_write(chip, descriptor, offset, data)

At here, descriptor is DESC_8606 or DESC_8607 that means operation on which
real device.

The benefit is that client drivers only need one kind of read/write API. I2C
and MFD driver can be shared in both 8606 and 8607.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mfd/88pm860x-core.c  |   72 ++++++++++++++++++++-------
 drivers/mfd/88pm860x-i2c.c   |  112 ++++++++++++++++++++++++++++--------------
 include/linux/mfd/88pm8607.h |   45 +++++++++++------
 3 files changed, 158 insertions(+), 71 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index d1464e5..7485eeb 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -1,5 +1,5 @@
 /*
- * Base driver for Marvell 88PM8607
+ * Base driver for Marvell 88PM860x
  *
  * Copyright (C) 2009 Marvell International Ltd.
  * 	Haojian Zhuang <haojian.zhuang@marvell.com>
@@ -67,13 +67,25 @@ static struct mfd_cell pm8607_devs[] = {
 	PM8607_REG_DEVS(ldo14, LDO14),
 };

-int pm860x_device_init(struct pm8607_chip *chip,
-		       struct pm8607_platform_data *pdata)
+static struct mixed_88pm860x mixed_chip;
+
+static int __devinit __88pm8606_init(struct pm860x_chip *chip, void *pdata)
 {
-	int i, count;
-	int ret;
+	chip->parent = &mixed_chip;
+	mixed_chip.pm8606 = chip;
+
+	return 0;
+}

-	ret = pm8607_reg_read(chip, PM8607_CHIP_ID);
+static int __devinit __88pm8607_init(struct pm860x_chip *chip,
+				     struct pm8607_plat_data *pdata)
+{
+	int ret = 0;
+
+	chip->parent = &mixed_chip;
+	mixed_chip.pm8607 = chip;
+
+	ret = pm860x_reg_read(chip->parent, DESC_8607, PM8607_CHIP_ID);
 	if (ret < 0) {
 		dev_err(chip->dev, "Failed to read CHIP ID: %d\n", ret);
 		goto out;
@@ -88,47 +100,69 @@ int pm860x_device_init(struct pm8607_chip *chip,
 	}
 	chip->chip_id = ret;

-	ret = pm8607_reg_read(chip, PM8607_BUCK3);
+	ret = pm860x_reg_read(chip->parent, DESC_8607, PM8607_BUCK3);
 	if (ret < 0) {
 		dev_err(chip->dev, "Failed to read BUCK3 register: %d\n", ret);
 		goto out;
 	}
 	if (ret & PM8607_BUCK3_DOUBLE)
-		chip->buck3_double = 1;
+		chip->parent->buck3_double = 1;

-	ret = pm8607_reg_read(chip, PM8607_MISC1);
+	ret = pm860x_reg_read(chip->parent, DESC_8607, PM8607_MISC1);
 	if (ret < 0) {
 		dev_err(chip->dev, "Failed to read MISC1 register: %d\n", ret);
 		goto out;
 	}
-	if (pdata->i2c_port == PI2C_PORT)
+	if (pdata && (pdata->i2c_port == PI2C_PORT))
 		ret |= PM8607_MISC1_PI2C;
 	else
 		ret &= ~PM8607_MISC1_PI2C;
-	ret = pm8607_reg_write(chip, PM8607_MISC1, ret);
+	ret = pm860x_reg_write(chip->parent, DESC_8607, PM8607_MISC1, ret);
 	if (ret < 0) {
 		dev_err(chip->dev, "Failed to write MISC1 register: %d\n", ret);
 		goto out;
 	}
+out:
+	return ret;
+}
+
+int __devinit pm860x_device_init(struct pm860x_chip *chip, void *pdata)
+{
+	int i, count;
+	int ret = -EINVAL;
+
+	/* Mixed chip isn't initialized yet. */
+	if ((mixed_chip.flags & MIXED_FLAG_INITIALIZED) == 0)
+		mutex_init(&mixed_chip.io_lock);

-	count = ARRAY_SIZE(pm8607_devs);
-	for (i = 0; i < count; i++) {
-		ret = mfd_add_devices(chip->dev, i, &pm8607_devs[i],
-				      1, NULL, 0);
-		if (ret != 0) {
-			dev_err(chip->dev, "Failed to add subdevs\n");
+	if (!strcmp(chip->id.name, "88PM8607")) {
+		ret = __88pm8607_init(chip, (struct pm8607_plat_data *)pdata);
+		if (ret < 0)
 			goto out;
+
+		count = ARRAY_SIZE(pm8607_devs);
+		for (i = 0; i < count; i++) {
+			ret = mfd_add_devices(chip->dev, i, &pm8607_devs[i],
+					      1, NULL, 0);
+			if (ret != 0) {
+				dev_err(chip->dev, "Failed to add subdevs\n");
+				goto out;
+			}
 		}
+	} else if (!strcmp(chip->id.name, "88PM8606")) {
+		ret = __88pm8606_init(chip, pdata);
+		if (ret < 0)
+			goto out;
 	}
 out:
 	return ret;
 }

-void pm8607_device_exit(struct pm8607_chip *chip)
+void __devexit pm8607_device_exit(struct pm860x_chip *chip)
 {
 	mfd_remove_devices(chip->dev);
 }

-MODULE_DESCRIPTION("PMIC Driver for Marvell 88PM8607");
+MODULE_DESCRIPTION("PMIC Driver for Marvell 88PM860x");
 MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/88pm860x-i2c.c b/drivers/mfd/88pm860x-i2c.c
index dda23cb..5738cf1 100644
--- a/drivers/mfd/88pm860x-i2c.c
+++ b/drivers/mfd/88pm860x-i2c.c
@@ -1,5 +1,5 @@
 /*
- * I2C driver for Marvell 88PM8607
+ * I2C driver for Marvell 88PM860x
  *
  * Copyright (C) 2009 Marvell International Ltd.
  * 	Haojian Zhuang <haojian.zhuang@marvell.com>
@@ -14,8 +14,8 @@
 #include <linux/i2c.h>
 #include <linux/mfd/88pm8607.h>

-static inline int pm8607_read_device(struct pm8607_chip *chip,
-				     int reg, int bytes, void *dest)
+static inline int __88pm860x_read(struct pm860x_chip *chip,
+				  int reg, int bytes, void *dest)
 {
 	struct i2c_client *i2c = chip->client;
 	unsigned char data;
@@ -32,8 +32,8 @@ static inline int pm8607_read_device(struct pm8607_chip *chip,
 	return 0;
 }

-static inline int pm8607_write_device(struct pm8607_chip *chip,
-				      int reg, int bytes, void *src)
+static inline int __88pm860x_write(struct pm860x_chip *chip,
+				   int reg, int bytes, void *src)
 {
 	struct i2c_client *i2c = chip->client;
 	unsigned char buf[bytes + 1];
@@ -48,82 +48,123 @@ static inline int pm8607_write_device(struct
pm8607_chip *chip,
 	return 0;
 }

-int pm8607_reg_read(struct pm8607_chip *chip, int reg)
+/* Get the chip that is specified by descriptor */
+#define MATCH_860X_CHIP(p, c, id)			\
+do {							\
+	if (p == NULL)					\
+		goto out;				\
+	if ((id == DESC_8606) && (p->pm8606))		\
+		c = p->pm8606;				\
+	else if ((id == DESC_8607) && (p->pm8607))	\
+		c = p->pm8607;				\
+	else						\
+		goto out;				\
+} while (0)
+
+int pm860x_reg_read(struct mixed_88pm860x *parent, int desc, int reg)
 {
+	struct pm860x_chip *chip = NULL;
 	unsigned char data;
 	int ret;

-	mutex_lock(&chip->io_lock);
+	MATCH_860X_CHIP(parent, chip, desc);
+
+	mutex_lock(&parent->io_lock);
 	ret = chip->read(chip, reg, 1, &data);
-	mutex_unlock(&chip->io_lock);
+	mutex_unlock(&parent->io_lock);
+	dev_dbg(chip->dev, "read [%d]:0x%x\n", reg, ret);

 	if (ret < 0)
 		return ret;
 	else
 		return (int)data;
+out:
+	return -EINVAL;
 }
-EXPORT_SYMBOL(pm8607_reg_read);
+EXPORT_SYMBOL(pm860x_reg_read);

-int pm8607_reg_write(struct pm8607_chip *chip, int reg,
+int pm860x_reg_write(struct mixed_88pm860x *parent, int desc, int reg,
 		     unsigned char data)
 {
+	struct pm860x_chip *chip = NULL;
 	int ret;

-	mutex_lock(&chip->io_lock);
+	MATCH_860X_CHIP(parent, chip, desc);
+
+	mutex_lock(&parent->io_lock);
 	ret = chip->write(chip, reg, 1, &data);
-	mutex_unlock(&chip->io_lock);
+	mutex_unlock(&parent->io_lock);
+	dev_dbg(chip->dev, "write [%d]:0x%x\n", reg, data);

 	return ret;
+out:
+	return -EINVAL;
 }
-EXPORT_SYMBOL(pm8607_reg_write);
+EXPORT_SYMBOL(pm860x_reg_write);

-int pm8607_bulk_read(struct pm8607_chip *chip, int reg,
+int pm860x_bulk_read(struct mixed_88pm860x *parent, int desc, int reg,
 		     int count, unsigned char *buf)
 {
+	struct pm860x_chip *chip = NULL;
 	int ret;

-	mutex_lock(&chip->io_lock);
+	MATCH_860X_CHIP(parent, chip, desc);
+
+	mutex_lock(&parent->io_lock);
 	ret = chip->read(chip, reg, count, buf);
-	mutex_unlock(&chip->io_lock);
+	mutex_unlock(&parent->io_lock);

 	return ret;
+out:
+	return -EINVAL;
 }
-EXPORT_SYMBOL(pm8607_bulk_read);
+EXPORT_SYMBOL(pm860x_bulk_read);

-int pm8607_bulk_write(struct pm8607_chip *chip, int reg,
+int pm860x_bulk_write(struct mixed_88pm860x *parent, int desc, int reg,
 		      int count, unsigned char *buf)
 {
+	struct pm860x_chip *chip = NULL;
 	int ret;

-	mutex_lock(&chip->io_lock);
+	MATCH_860X_CHIP(parent, chip, desc);
+
+	mutex_lock(&parent->io_lock);
 	ret = chip->write(chip, reg, count, buf);
-	mutex_unlock(&chip->io_lock);
+	mutex_unlock(&parent->io_lock);

 	return ret;
+out:
+	return -EINVAL;
 }
-EXPORT_SYMBOL(pm8607_bulk_write);
+EXPORT_SYMBOL(pm860x_bulk_write);

-int pm8607_set_bits(struct pm8607_chip *chip, int reg,
+int pm860x_set_bits(struct mixed_88pm860x *parent, int desc, int reg,
 		    unsigned char mask, unsigned char data)
 {
+	struct pm860x_chip *chip = NULL;
 	unsigned char value;
 	int ret;

-	mutex_lock(&chip->io_lock);
+	MATCH_860X_CHIP(parent, chip, desc);
+
+	mutex_lock(&parent->io_lock);
 	ret = chip->read(chip, reg, 1, &value);
 	if (ret < 0)
-		goto out;
+		goto out_rd;
 	value &= ~mask;
 	value |= data;
 	ret = chip->write(chip, reg, 1, &value);
-out:
-	mutex_unlock(&chip->io_lock);
+out_rd:
+	mutex_unlock(&parent->io_lock);
+	dev_dbg(chip->dev, "set bits [%d]:0x%x, ret:%d\n", reg, data, ret);
+
 	return ret;
+out:
+	return -EINVAL;
 }
-EXPORT_SYMBOL(pm8607_set_bits);
-

 static const struct i2c_device_id pm860x_id_table[] = {
+	{ "88PM8606", 0 },
 	{ "88PM8607", 0 },
 	{}
 };
@@ -132,31 +173,28 @@ MODULE_DEVICE_TABLE(i2c, pm860x_id_table);
 static int __devinit pm860x_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
-	struct pm8607_platform_data *pdata = client->dev.platform_data;
-	struct pm8607_chip *chip;
+	struct pm860x_chip *chip;
+	struct pm860x_plat_data *pdata;
 	int ret;

-	chip = kzalloc(sizeof(struct pm8607_chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(struct pm860x_chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;

 	chip->client = client;
 	chip->dev = &client->dev;
-	chip->read = pm8607_read_device;
-	chip->write = pm8607_write_device;
+	chip->read = __88pm860x_read;
+	chip->write = __88pm860x_write;
 	memcpy(&chip->id, id, sizeof(struct i2c_device_id));
 	i2c_set_clientdata(client, chip);

-	mutex_init(&chip->io_lock);
 	dev_set_drvdata(chip->dev, chip);
-
+	pdata = (struct pm860x_plat_data *)client->dev.platform_data;
 	ret = pm860x_device_init(chip, pdata);
 	if (ret < 0)
 		goto out;

-
 	return 0;
-
 out:
 	i2c_set_clientdata(client, NULL);
 	kfree(chip);
diff --git a/include/linux/mfd/88pm8607.h b/include/linux/mfd/88pm8607.h
index 6e4dcdc..bacc1f9 100644
--- a/include/linux/mfd/88pm8607.h
+++ b/include/linux/mfd/88pm8607.h
@@ -13,6 +13,13 @@
 #define __LINUX_MFD_88PM8607_H

 enum {
+	DESC_INVAL = 0,
+	DESC_8606,
+	DESC_8607,
+	DESC_MAX,
+};
+
+enum {
 	PM8607_ID_BUCK1 = 0,
 	PM8607_ID_BUCK2,
 	PM8607_ID_BUCK3,
@@ -180,19 +187,28 @@ enum {
 	PM8607_CHIP_B0 = 0x48,
 };

+struct pm860x_chip;

-struct pm8607_chip {
+#define MIXED_FLAG_INITIALIZED		(1 << 0)
+
+struct mixed_88pm860x {
+	struct pm860x_chip	*pm8606;
+	struct pm860x_chip	*pm8607;
+	struct mutex		io_lock;
+	int			buck3_double;	/* DVC ramp slope double */
+	int			flags;
+};
+
+struct pm860x_chip {
 	struct device		*dev;
 	struct mutex		io_lock;
 	struct i2c_client	*client;
 	struct i2c_device_id	id;
-
-	int (*read)(struct pm8607_chip *chip, int reg, int bytes, void *dest);
-	int (*write)(struct pm8607_chip *chip, int reg, int bytes, void *src);
-
-	int			buck3_double;	/* DVC ramp slope double */
+	struct mixed_88pm860x	*parent;
 	unsigned char		chip_id;

+	int (*read)(struct pm860x_chip *chip, int reg, int bytes, void *dest);
+	int (*write)(struct pm860x_chip *chip, int reg, int bytes, void *src);
 };

 #define PM8607_MAX_REGULATOR	15	/* 3 Bucks, 12 LDOs */
@@ -202,22 +218,21 @@ enum {
 	PI2C_PORT,
 };

-struct pm8607_platform_data {
+struct pm8607_plat_data {
 	int	i2c_port;	/* Controlled by GI2C or PI2C */
 	struct regulator_init_data *regulator[PM8607_MAX_REGULATOR];
 };

-extern int pm8607_reg_read(struct pm8607_chip *, int);
-extern int pm8607_reg_write(struct pm8607_chip *, int, unsigned char);
-extern int pm8607_bulk_read(struct pm8607_chip *, int, int,
+extern int pm860x_reg_read(struct mixed_88pm860x *, int, int);
+extern int pm860x_reg_write(struct mixed_88pm860x *, int, int, unsigned char);
+extern int pm860x_bulk_read(struct mixed_88pm860x *, int, int, int,
 			    unsigned char *);
-extern int pm8607_bulk_write(struct pm8607_chip *, int, int,
+extern int pm860x_bulk_write(struct mixed_88pm860x *, int, int, int,
 			     unsigned char *);
-extern int pm8607_set_bits(struct pm8607_chip *, int, unsigned char,
+extern int pm860x_set_bits(struct mixed_88pm860x *, int, int, unsigned char,
 			   unsigned char);

-extern int pm860x_device_init(struct pm8607_chip *chip,
-			      struct pm8607_platform_data *pdata);
-extern void pm860x_device_exit(struct pm8607_chip *chip);
+extern int pm860x_device_init(struct pm860x_chip *chip, void *pdata);
+extern void pm860x_device_exit(struct pm860x_chip *chip);

 #endif /* __LINUX_MFD_88PM860X_H */
-- 
1.5.6.5
