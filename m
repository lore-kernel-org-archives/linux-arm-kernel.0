From: jtzhou@marvell.com (Jett.Zhou)
Date: Thu, 10 Nov 2011 19:43:26 +0800
Subject: [V1] mfd: Convert pm860x to use regmap api
Message-ID: <1320925406-7445-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the register read/write code to use the register map API. We
still need some pm860x specific code and locking in place to make sure
test page read/write can not be interrupted by other i2c operation based
on pm860x chip;

Change-Id: I4d5c616d021ff62672477b9e08e118985c4d6af0
Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
---
 drivers/mfd/88pm860x-i2c.c   |  162 +++++++++++++++++++++---------------------
 drivers/mfd/Kconfig          |    1 +
 include/linux/mfd/88pm860x.h |    2 +
 3 files changed, 83 insertions(+), 82 deletions(-)

diff --git a/drivers/mfd/88pm860x-i2c.c b/drivers/mfd/88pm860x-i2c.c
index e017dc8..fd3e7f7 100644
--- a/drivers/mfd/88pm860x-i2c.c
+++ b/drivers/mfd/88pm860x-i2c.c
@@ -12,49 +12,21 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
+#include <linux/err.h>
 #include <linux/mfd/88pm860x.h>
 #include <linux/slab.h>
-
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
+#include <linux/regmap.h>
 
 int pm860x_reg_read(struct i2c_client *i2c, int reg)
 {
 	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
-	unsigned char data;
+	struct regmap *map = (i2c == chip->client) ? chip->regmap
+					: chip->regmap_companion;
+	unsigned int data;
 	int ret;
 
 	mutex_lock(&chip->io_lock);
-	ret = pm860x_read_device(i2c, reg, 1, &data);
+	ret = regmap_read(map, reg, &data);
 	mutex_unlock(&chip->io_lock);
 
 	if (ret < 0)
@@ -68,10 +40,12 @@ int pm860x_reg_write(struct i2c_client *i2c, int reg,
 		     unsigned char data)
 {
 	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
+	struct regmap *map = (i2c == chip->client) ? chip->regmap
+					: chip->regmap_companion;
 	int ret;
 
 	mutex_lock(&chip->io_lock);
-	ret = pm860x_write_device(i2c, reg, 1, &data);
+	ret = regmap_write(map, reg, data);
 	mutex_unlock(&chip->io_lock);
 
 	return ret;
@@ -82,10 +56,12 @@ int pm860x_bulk_read(struct i2c_client *i2c, int reg,
 		     int count, unsigned char *buf)
 {
 	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
+	struct regmap *map = (i2c == chip->client) ? chip->regmap
+					: chip->regmap_companion;
 	int ret;
 
 	mutex_lock(&chip->io_lock);
-	ret = pm860x_read_device(i2c, reg, count, buf);
+	ret = regmap_raw_read(map, reg, buf, count);
 	mutex_unlock(&chip->io_lock);
 
 	return ret;
@@ -96,10 +72,12 @@ int pm860x_bulk_write(struct i2c_client *i2c, int reg,
 		      int count, unsigned char *buf)
 {
 	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
+	struct regmap *map = (i2c == chip->client) ? chip->regmap
+					: chip->regmap_companion;
 	int ret;
 
 	mutex_lock(&chip->io_lock);
-	ret = pm860x_write_device(i2c, reg, count, buf);
+	ret = regmap_raw_write(map, reg, buf, count);
 	mutex_unlock(&chip->io_lock);
 
 	return ret;
@@ -110,17 +88,12 @@ int pm860x_set_bits(struct i2c_client *i2c, int reg,
 		    unsigned char mask, unsigned char data)
 {
 	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
-	unsigned char value;
+	struct regmap *map = (i2c == chip->client) ? chip->regmap
+					: chip->regmap_companion;
 	int ret;
 
 	mutex_lock(&chip->io_lock);
-	ret = pm860x_read_device(i2c, reg, 1, &value);
-	if (ret < 0)
-		goto out;
-	value &= ~mask;
-	value |= data;
-	ret = pm860x_write_device(i2c, reg, 1, &value);
-out:
+	ret = regmap_update_bits(map, reg, mask, data);
 	mutex_unlock(&chip->io_lock);
 	return ret;
 }
@@ -129,19 +102,21 @@ EXPORT_SYMBOL(pm860x_set_bits);
 int pm860x_page_reg_read(struct i2c_client *i2c, int reg)
 {
 	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
+	struct regmap *map = (i2c == chip->client) ? chip->regmap
+					: chip->regmap_companion;
 	unsigned char zero = 0;
 	unsigned char data;
 	int ret;
 
 	mutex_lock(&chip->io_lock);
-	pm860x_write_device(i2c, 0xFA, 0, &zero);
-	pm860x_write_device(i2c, 0xFB, 0, &zero);
-	pm860x_write_device(i2c, 0xFF, 0, &zero);
-	ret = pm860x_read_device(i2c, reg, 1, &data);
+	regmap_raw_write(map, 0xFA, &zero, 0);
+	regmap_raw_write(map, 0xFB, &zero, 0);
+	regmap_raw_write(map, 0xFF, &zero, 0);
+	ret = regmap_raw_read(map, reg, &data, 1);
 	if (ret >= 0)
 		ret = (int)data;
-	pm860x_write_device(i2c, 0xFE, 0, &zero);
-	pm860x_write_device(i2c, 0xFC, 0, &zero);
+	regmap_raw_write(map, 0xFE, &zero, 0);
+	regmap_raw_write(map, 0xFC, &zero, 0);
 	mutex_unlock(&chip->io_lock);
 	return ret;
 }
@@ -151,16 +126,18 @@ int pm860x_page_reg_write(struct i2c_client *i2c, int reg,
 			  unsigned char data)
 {
 	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
+	struct regmap *map = (i2c == chip->client) ? chip->regmap
+					: chip->regmap_companion;
 	unsigned char zero;
 	int ret;
 
 	mutex_lock(&chip->io_lock);
-	pm860x_write_device(i2c, 0xFA, 0, &zero);
-	pm860x_write_device(i2c, 0xFB, 0, &zero);
-	pm860x_write_device(i2c, 0xFF, 0, &zero);
-	ret = pm860x_write_device(i2c, reg, 1, &data);
-	pm860x_write_device(i2c, 0xFE, 0, &zero);
-	pm860x_write_device(i2c, 0xFC, 0, &zero);
+	regmap_raw_write(map, 0xFA, &zero, 0);
+	regmap_raw_write(map, 0xFB, &zero, 0);
+	regmap_raw_write(map, 0xFF, &zero, 0);
+	ret = regmap_raw_write(map, reg, &data, 1);
+	regmap_raw_write(map, 0xFE, &zero, 0);
+	regmap_raw_write(map, 0xFC, &zero, 0);
 	mutex_unlock(&chip->io_lock);
 	return ret;
 }
@@ -170,16 +147,18 @@ int pm860x_page_bulk_read(struct i2c_client *i2c, int reg,
 			  int count, unsigned char *buf)
 {
 	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
+	struct regmap *map = (i2c == chip->client) ? chip->regmap
+					: chip->regmap_companion;
 	unsigned char zero = 0;
 	int ret;
 
 	mutex_lock(&chip->io_lock);
-	pm860x_write_device(i2c, 0xFA, 0, &zero);
-	pm860x_write_device(i2c, 0xFB, 0, &zero);
-	pm860x_write_device(i2c, 0xFF, 0, &zero);
-	ret = pm860x_read_device(i2c, reg, count, buf);
-	pm860x_write_device(i2c, 0xFE, 0, &zero);
-	pm860x_write_device(i2c, 0xFC, 0, &zero);
+	regmap_raw_write(map, 0xFA, &zero, 0);
+	regmap_raw_write(map, 0xFB, &zero, 0);
+	regmap_raw_write(map, 0xFF, &zero, 0);
+	ret = regmap_raw_read(map, reg, buf, count);
+	regmap_raw_write(map, 0xFE, &zero, 0);
+	regmap_raw_write(map, 0xFC, &zero, 0);
 	mutex_unlock(&chip->io_lock);
 	return ret;
 }
@@ -189,16 +168,18 @@ int pm860x_page_bulk_write(struct i2c_client *i2c, int reg,
 			   int count, unsigned char *buf)
 {
 	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
+	struct regmap *map = (i2c == chip->client) ? chip->regmap
+					: chip->regmap_companion;
 	unsigned char zero = 0;
 	int ret;
 
 	mutex_lock(&chip->io_lock);
-	pm860x_write_device(i2c, 0xFA, 0, &zero);
-	pm860x_write_device(i2c, 0xFB, 0, &zero);
-	pm860x_write_device(i2c, 0xFF, 0, &zero);
-	ret = pm860x_write_device(i2c, reg, count, buf);
-	pm860x_write_device(i2c, 0xFE, 0, &zero);
-	pm860x_write_device(i2c, 0xFC, 0, &zero);
+	regmap_raw_write(map, 0xFA, &zero, 0);
+	regmap_raw_write(map, 0xFB, &zero, 0);
+	regmap_raw_write(map, 0xFF, &zero, 0);
+	ret = regmap_raw_write(map, reg, buf, count);
+	regmap_raw_write(map, 0xFE, &zero, 0);
+	regmap_raw_write(map, 0xFC, &zero, 0);
 	mutex_unlock(&chip->io_lock);
 	return ret;
 }
@@ -208,23 +189,18 @@ int pm860x_page_set_bits(struct i2c_client *i2c, int reg,
 			 unsigned char mask, unsigned char data)
 {
 	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
+	struct regmap *map = (i2c == chip->client) ? chip->regmap
+					: chip->regmap_companion;
 	unsigned char zero;
-	unsigned char value;
 	int ret;
 
 	mutex_lock(&chip->io_lock);
-	pm860x_write_device(i2c, 0xFA, 0, &zero);
-	pm860x_write_device(i2c, 0xFB, 0, &zero);
-	pm860x_write_device(i2c, 0xFF, 0, &zero);
-	ret = pm860x_read_device(i2c, reg, 1, &value);
-	if (ret < 0)
-		goto out;
-	value &= ~mask;
-	value |= data;
-	ret = pm860x_write_device(i2c, reg, 1, &value);
-out:
-	pm860x_write_device(i2c, 0xFE, 0, &zero);
-	pm860x_write_device(i2c, 0xFC, 0, &zero);
+	regmap_raw_write(map, 0xFA, &zero, 0);
+	regmap_raw_write(map, 0xFB, &zero, 0);
+	regmap_raw_write(map, 0xFF, &zero, 0);
+	ret = regmap_update_bits(map, reg, mask, data);
+	regmap_raw_write(map, 0xFE, &zero, 0);
+	regmap_raw_write(map, 0xFC, &zero, 0);
 	mutex_unlock(&chip->io_lock);
 	return ret;
 }
@@ -257,11 +233,17 @@ static int verify_addr(struct i2c_client *i2c)
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
@@ -273,6 +255,14 @@ static int __devinit pm860x_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	chip->id = verify_addr(client);
+
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
@@ -290,6 +280,14 @@ static int __devinit pm860x_probe(struct i2c_client *client,
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
index 63b4fb8..f860547 100644
--- a/include/linux/mfd/88pm860x.h
+++ b/include/linux/mfd/88pm860x.h
@@ -301,6 +301,8 @@ struct pm860x_chip {
 	struct mutex		irq_lock;
 	struct i2c_client	*client;
 	struct i2c_client	*companion;	/* companion chip client */
+	struct regmap           *regmap;
+	struct regmap           *regmap_companion;
 
 	int			buck3_double;	/* DVC ramp slope double */
 	unsigned short		companion_addr;
-- 
1.7.0.4
