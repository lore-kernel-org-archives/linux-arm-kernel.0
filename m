From: jtzhou@marvell.com (Jett.Zhou)
Date: Fri, 11 Nov 2011 13:35:11 +0800
Subject: [V2] mfd: Convert pm860x to use regmap api
Message-ID: <1320989711-29179-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two banks in 88pm8607. One is the normal bank, and the other
one is the test bank.
For normal bank , convert the register read/write code to use the
register map API;
For test bank, it needs a special I2C sequence as below,
    Touching to 0xFA address
    Touching to 0xFB address
    Touching to 0xFF address
    Accessing bank register
    Touching to 0xFE address
    Touching to 0xFC address
This sequence can't be interrupted. It means that we can't use
i2c_transfef() to implement touching 0xFA address. Otherwise, other i2c
operation may be inserted into 0xFA and 0xFB operation since the lock of
i2c_adapter is already released.
So for test bank we implemented specific i2c read/write operation;

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
---
 drivers/mfd/88pm860x-i2c.c   |  240 ++++++++++++++++++++++++------------------
 drivers/mfd/Kconfig          |    1 +
 include/linux/mfd/88pm860x.h |    2 +
 3 files changed, 140 insertions(+), 103 deletions(-)

diff --git a/drivers/mfd/88pm860x-i2c.c b/drivers/mfd/88pm860x-i2c.c
index e017dc8..bf5b3e0 100644
--- a/drivers/mfd/88pm860x-i2c.c
+++ b/drivers/mfd/88pm860x-i2c.c
@@ -12,50 +12,20 @@
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
+				: chip->regmap_companion;
+	unsigned int data;
 	int ret;
 
-	mutex_lock(&chip->io_lock);
-	ret = pm860x_read_device(i2c, reg, 1, &data);
-	mutex_unlock(&chip->io_lock);
+	ret = regmap_read(map, reg, &data);
 
 	if (ret < 0)
 		return ret;
@@ -68,12 +38,11 @@ int pm860x_reg_write(struct i2c_client *i2c, int reg,
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
@@ -82,12 +51,11 @@ int pm860x_bulk_read(struct i2c_client *i2c, int reg,
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
@@ -96,12 +64,11 @@ int pm860x_bulk_write(struct i2c_client *i2c, int reg,
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
@@ -110,39 +77,79 @@ int pm860x_set_bits(struct i2c_client *i2c, int reg,
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
 
+static int read_device(struct i2c_client *i2c, int reg,
+		       int bytes, void *dest)
+{
+	unsigned char msgbuf0[I2C_SMBUS_BLOCK_MAX + 3];
+	unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX + 2];
+	struct i2c_adapter *adap = i2c->adapter;
+	struct i2c_msg msg[2] = {{i2c->addr, 0, 1, msgbuf0},
+				 {i2c->addr, I2C_M_RD, 0, msgbuf1},
+				};
+	int num = 1, ret = 0;
+
+	if (dest == NULL)
+		return -EINVAL;
+	msgbuf0[0] = (unsigned char)reg;	/* command */
+	msg[1].len = bytes;
+
+	/* if data needs to read back, num should be 2 */
+	if (bytes > 0)
+		num = 2;
+	ret = adap->algo->master_xfer(adap, msg, num);
+	memcpy(dest, msgbuf1, bytes);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static int write_device(struct i2c_client *i2c, int reg,
+			int bytes, void *src)
+{
+	unsigned char buf[bytes + 1];
+	struct i2c_adapter *adap = i2c->adapter;
+	struct i2c_msg msg;
+	int ret;
+
+	buf[0] = (unsigned char)reg;
+	memcpy(&buf[1], src, bytes);
+	msg.addr = i2c->addr;
+	msg.flags = 0;
+	msg.len = bytes + 1;
+	msg.buf = buf;
+
+	ret = adap->algo->master_xfer(adap, &msg, 1);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
 int pm860x_page_reg_read(struct i2c_client *i2c, int reg)
 {
-	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
 	unsigned char zero = 0;
 	unsigned char data;
 	int ret;
 
-	mutex_lock(&chip->io_lock);
-	pm860x_write_device(i2c, 0xFA, 0, &zero);
-	pm860x_write_device(i2c, 0xFB, 0, &zero);
-	pm860x_write_device(i2c, 0xFF, 0, &zero);
-	ret = pm860x_read_device(i2c, reg, 1, &data);
+	i2c_lock_adapter(i2c->adapter);
+	read_device(i2c, 0xFA, 0, &zero);
+	read_device(i2c, 0xFB, 0, &zero);
+	read_device(i2c, 0xFF, 0, &zero);
+	ret = read_device(i2c, reg, 1, &data);
 	if (ret >= 0)
 		ret = (int)data;
-	pm860x_write_device(i2c, 0xFE, 0, &zero);
-	pm860x_write_device(i2c, 0xFC, 0, &zero);
-	mutex_unlock(&chip->io_lock);
+	read_device(i2c, 0xFE, 0, &zero);
+	read_device(i2c, 0xFC, 0, &zero);
+	i2c_unlock_adapter(i2c->adapter);
+
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_page_reg_read);
@@ -150,18 +157,18 @@ EXPORT_SYMBOL(pm860x_page_reg_read);
 int pm860x_page_reg_write(struct i2c_client *i2c, int reg,
 			  unsigned char data)
 {
-	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
 	unsigned char zero;
 	int ret;
 
-	mutex_lock(&chip->io_lock);
-	pm860x_write_device(i2c, 0xFA, 0, &zero);
-	pm860x_write_device(i2c, 0xFB, 0, &zero);
-	pm860x_write_device(i2c, 0xFF, 0, &zero);
-	ret = pm860x_write_device(i2c, reg, 1, &data);
-	pm860x_write_device(i2c, 0xFE, 0, &zero);
-	pm860x_write_device(i2c, 0xFC, 0, &zero);
-	mutex_unlock(&chip->io_lock);
+	i2c_lock_adapter(i2c->adapter);
+	read_device(i2c, 0xFA, 0, &zero);
+	read_device(i2c, 0xFB, 0, &zero);
+	read_device(i2c, 0xFF, 0, &zero);
+	ret = write_device(i2c, reg, 1, &data);
+	read_device(i2c, 0xFE, 0, &zero);
+	read_device(i2c, 0xFC, 0, &zero);
+	i2c_unlock_adapter(i2c->adapter);
+
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_page_reg_write);
@@ -169,18 +176,18 @@ EXPORT_SYMBOL(pm860x_page_reg_write);
 int pm860x_page_bulk_read(struct i2c_client *i2c, int reg,
 			  int count, unsigned char *buf)
 {
-	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
 	unsigned char zero = 0;
 	int ret;
 
-	mutex_lock(&chip->io_lock);
-	pm860x_write_device(i2c, 0xFA, 0, &zero);
-	pm860x_write_device(i2c, 0xFB, 0, &zero);
-	pm860x_write_device(i2c, 0xFF, 0, &zero);
-	ret = pm860x_read_device(i2c, reg, count, buf);
-	pm860x_write_device(i2c, 0xFE, 0, &zero);
-	pm860x_write_device(i2c, 0xFC, 0, &zero);
-	mutex_unlock(&chip->io_lock);
+	i2c_lock_adapter(i2c->adapter);
+	read_device(i2c, 0xfa, 0, &zero);
+	read_device(i2c, 0xfb, 0, &zero);
+	read_device(i2c, 0xff, 0, &zero);
+	ret = read_device(i2c, reg, count, buf);
+	read_device(i2c, 0xFE, 0, &zero);
+	read_device(i2c, 0xFC, 0, &zero);
+	i2c_unlock_adapter(i2c->adapter);
+
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_page_bulk_read);
@@ -189,17 +196,21 @@ int pm860x_page_bulk_write(struct i2c_client *i2c, int reg,
 			   int count, unsigned char *buf)
 {
 	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
+	struct regmap *map = (i2c == chip->client) ? chip->regmap
+					: chip->regmap_companion;
 	unsigned char zero = 0;
 	int ret;
 
-	mutex_lock(&chip->io_lock);
-	pm860x_write_device(i2c, 0xFA, 0, &zero);
-	pm860x_write_device(i2c, 0xFB, 0, &zero);
-	pm860x_write_device(i2c, 0xFF, 0, &zero);
-	ret = pm860x_write_device(i2c, reg, count, buf);
-	pm860x_write_device(i2c, 0xFE, 0, &zero);
-	pm860x_write_device(i2c, 0xFC, 0, &zero);
-	mutex_unlock(&chip->io_lock);
+	i2c_lock_adapter(i2c->adapter);
+	read_device(i2c, 0xFA, 0, &zero);
+	read_device(i2c, 0xFB, 0, &zero);
+	read_device(i2c, 0xFF, 0, &zero);
+	ret = write_device(i2c, reg, count, buf);
+	read_device(i2c, 0xFE, 0, &zero);
+	read_device(i2c, 0xFC, 0, &zero);
+	i2c_unlock_adapter(i2c->adapter);
+	i2c_unlock_adapter(i2c->adapter);
+
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_page_bulk_write);
@@ -207,25 +218,26 @@ EXPORT_SYMBOL(pm860x_page_bulk_write);
 int pm860x_page_set_bits(struct i2c_client *i2c, int reg,
 			 unsigned char mask, unsigned char data)
 {
-	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
 	unsigned char zero;
 	unsigned char value;
 	int ret;
 
-	mutex_lock(&chip->io_lock);
-	pm860x_write_device(i2c, 0xFA, 0, &zero);
-	pm860x_write_device(i2c, 0xFB, 0, &zero);
-	pm860x_write_device(i2c, 0xFF, 0, &zero);
-	ret = pm860x_read_device(i2c, reg, 1, &value);
+	i2c_lock_adapter(i2c->adapter);
+	read_device(i2c, 0xFA, 0, &zero);
+	read_device(i2c, 0xFB, 0, &zero);
+	read_device(i2c, 0xFF, 0, &zero);
+	ret = read_device(i2c, reg, 1, &value);
 	if (ret < 0)
 		goto out;
 	value &= ~mask;
 	value |= data;
-	ret = pm860x_write_device(i2c, reg, 1, &value);
+	ret = write_device(i2c, reg, 1, &value);
+
 out:
-	pm860x_write_device(i2c, 0xFE, 0, &zero);
-	pm860x_write_device(i2c, 0xFC, 0, &zero);
-	mutex_unlock(&chip->io_lock);
+	read_device(i2c, 0xFE, 0, &zero);
+	read_device(i2c, 0xFC, 0, &zero);
+	i2c_unlock_adapter(i2c->adapter);
+
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_page_set_bits);
@@ -257,11 +269,17 @@ static int verify_addr(struct i2c_client *i2c)
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
@@ -273,6 +291,14 @@ static int __devinit pm860x_probe(struct i2c_client *client,
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
@@ -290,6 +316,14 @@ static int __devinit pm860x_probe(struct i2c_client *client,
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
