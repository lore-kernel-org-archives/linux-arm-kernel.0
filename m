From: jtzhou@marvell.com (Jett.Zhou)
Date: Mon, 14 Nov 2011 13:48:48 +0800
Subject: [V3 2/2] mfd: Convert 88pm860x to use regmap api
Message-ID: <1321249728-27336-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the 88pm860x normal bank register read/write to
use the register map API.

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
---
 drivers/mfd/88pm860x-i2c.c   |  105 +++++++++++++++++------------------------
 drivers/mfd/Kconfig          |    1 +
 include/linux/mfd/88pm860x.h |    3 +-
 3 files changed, 47 insertions(+), 62 deletions(-)

diff --git a/drivers/mfd/88pm860x-i2c.c b/drivers/mfd/88pm860x-i2c.c
index f629d6f..9121a47 100644
--- a/drivers/mfd/88pm860x-i2c.c
+++ b/drivers/mfd/88pm860x-i2c.c
@@ -12,51 +12,20 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/regmap.h>
 #include <linux/mfd/88pm860x.h>
 #include <linux/slab.h>
 
-static inline int pm860x_read_device(struct i2c_client *i2c,
-				     int reg, int bytes, void *dest)
-{
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
-static inline int pm860x_write_device(struct i2c_client *i2c,
-				      int reg, int bytes, void *src)
-{
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
 int pm860x_reg_read(struct i2c_client *i2c, int reg)
 {
 	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
-	unsigned char data;
+	struct regmap *map = (i2c == chip->client) ? chip->regmap
+				: chip->regmap_companion;
+	unsigned int data;
 	int ret;
 
-	mutex_lock(&chip->io_lock);
-	ret = pm860x_read_device(i2c, reg, 1, &data);
-	mutex_unlock(&chip->io_lock);
-
+	ret = regmap_read(map, reg, &data);
 	if (ret < 0)
 		return ret;
 	else
@@ -68,12 +37,11 @@ int pm860x_reg_write(struct i2c_client *i2c, int reg,
 		     unsigned char data)
 {
 	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
+	struct regmap *map = (i2c == chip->client) ? chip->regmap
+				: chip->regmap_companion;
 	int ret;
 
-	mutex_lock(&chip->io_lock);
-	ret = pm860x_write_device(i2c, reg, 1, &data);
-	mutex_unlock(&chip->io_lock);
-
+	ret = regmap_write(map, reg, data);
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_reg_write);
@@ -82,12 +50,11 @@ int pm860x_bulk_read(struct i2c_client *i2c, int reg,
 		     int count, unsigned char *buf)
 {
 	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
+	struct regmap *map = (i2c == chip->client) ? chip->regmap
+				: chip->regmap_companion;
 	int ret;
 
-	mutex_lock(&chip->io_lock);
-	ret = pm860x_read_device(i2c, reg, count, buf);
-	mutex_unlock(&chip->io_lock);
-
+	ret = regmap_raw_read(map, reg, buf, count);
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_bulk_read);
@@ -96,12 +63,11 @@ int pm860x_bulk_write(struct i2c_client *i2c, int reg,
 		      int count, unsigned char *buf)
 {
 	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
+	struct regmap *map = (i2c == chip->client) ? chip->regmap
+				: chip->regmap_companion;
 	int ret;
 
-	mutex_lock(&chip->io_lock);
-	ret = pm860x_write_device(i2c, reg, count, buf);
-	mutex_unlock(&chip->io_lock);
-
+	ret = regmap_raw_write(map, reg, buf, count);
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_bulk_write);
@@ -110,18 +76,11 @@ int pm860x_set_bits(struct i2c_client *i2c, int reg,
 		    unsigned char mask, unsigned char data)
 {
 	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
-	unsigned char value;
+	struct regmap *map = (i2c == chip->client) ? chip->regmap
+				: chip->regmap_companion;
 	int ret;
 
-	mutex_lock(&chip->io_lock);
-	ret = pm860x_read_device(i2c, reg, 1, &value);
-	if (ret < 0)
-		goto out;
-	value &= ~mask;
-	value |= data;
-	ret = pm860x_write_device(i2c, reg, 1, &value);
-out:
-	mutex_unlock(&chip->io_lock);
+	ret = regmap_update_bits(map, reg, mask, data);
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_set_bits);
@@ -300,11 +259,17 @@ static int verify_addr(struct i2c_client *i2c)
 	return 0;
 }
 
+static struct regmap_config pm860x_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
 static int __devinit pm860x_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
 	struct pm860x_platform_data *pdata = client->dev.platform_data;
 	struct pm860x_chip *chip;
+	int ret;
 
 	if (!pdata) {
 		pr_info("No platform data in %s!\n", __func__);
@@ -316,10 +281,16 @@ static int __devinit pm860x_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	chip->id = verify_addr(client);
+	chip->regmap = regmap_init_i2c(client, &pm860x_regmap_config);
+	if (IS_ERR(chip->regmap)) {
+		ret = PTR_ERR(chip->regmap);
+		dev_err(&client->dev, "Failed to allocate register map: %d\n",
+				ret);
+		return ret;
+	}
 	chip->client = client;
 	i2c_set_clientdata(client, chip);
 	chip->dev = &client->dev;
-	mutex_init(&chip->io_lock);
 	dev_set_drvdata(chip->dev, chip);
 
 	/*
@@ -333,6 +304,14 @@ static int __devinit pm860x_probe(struct i2c_client *client,
 		chip->companion_addr = pdata->companion_addr;
 		chip->companion = i2c_new_dummy(chip->client->adapter,
 						chip->companion_addr);
+		chip->regmap_companion = regmap_init_i2c(chip->companion,
+							&pm860x_regmap_config);
+		if (IS_ERR(chip->regmap_companion)) {
+			ret = PTR_ERR(chip->regmap_companion);
+			dev_err(&chip->companion->dev,
+				"Failed to allocate register map: %d\n", ret);
+			return ret;
+		}
 		i2c_set_clientdata(chip->companion, chip);
 	}
 
@@ -345,7 +324,11 @@ static int __devexit pm860x_remove(struct i2c_client *client)
 	struct pm860x_chip *chip = i2c_get_clientdata(client);
 
 	pm860x_device_exit(chip);
-	i2c_unregister_device(chip->companion);
+	if (chip->companion) {
+		regmap_exit(chip->regmap_companion);
+		i2c_unregister_device(chip->companion);
+	}
+	regmap_exit(chip->regmap);
 	kfree(chip);
 	return 0;
 }
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index a67adcb..1973b23 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -27,6 +27,7 @@ config MFD_CORE
 config MFD_88PM860X
 	bool "Support Marvell 88PM8606/88PM8607"
 	depends on I2C=y && GENERIC_HARDIRQS
+	select REGMAP_I2C
 	select MFD_CORE
 	help
 	  This supports for Marvell 88PM8606/88PM8607 Power Management IC.
diff --git a/include/linux/mfd/88pm860x.h b/include/linux/mfd/88pm860x.h
index 63b4fb8..92be347 100644
--- a/include/linux/mfd/88pm860x.h
+++ b/include/linux/mfd/88pm860x.h
@@ -297,10 +297,11 @@ enum {
 
 struct pm860x_chip {
 	struct device		*dev;
-	struct mutex		io_lock;
 	struct mutex		irq_lock;
 	struct i2c_client	*client;
 	struct i2c_client	*companion;	/* companion chip client */
+	struct regmap           *regmap;
+	struct regmap           *regmap_companion;
 
 	int			buck3_double;	/* DVC ramp slope double */
 	unsigned short		companion_addr;
-- 
1.7.0.4
