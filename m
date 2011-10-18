From: jhbird.choi@samsung.com (jhbird.choi at samsung.com)
Date: Tue, 18 Oct 2011 16:23:55 +0900
Subject: [PATCH] regulator: max8649 Convert max8649 to user regmap api
Message-ID: <1318922635-24703-1-git-send-email-jhbird.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonghwan Choi <jhbird.choi@samsung.com>

Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
---
 drivers/regulator/Kconfig   |    1 +
 drivers/regulator/max8649.c |  113 +++++++++++++++----------------------------
 2 files changed, 41 insertions(+), 73 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index c7fd2c0..c4f9e1c 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -83,6 +83,7 @@ config REGULATOR_MAX1586
 config REGULATOR_MAX8649
 	tristate "Maxim 8649 voltage regulator"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  This driver controls a Maxim 8649 voltage output regulator via
 	  I2C bus.
diff --git a/drivers/regulator/max8649.c b/drivers/regulator/max8649.c
index 30eb9e5..04f8682 100644
--- a/drivers/regulator/max8649.c
+++ b/drivers/regulator/max8649.c
@@ -16,6 +16,7 @@
 #include <linux/regulator/driver.h>
 #include <linux/slab.h>
 #include <linux/regulator/max8649.h>
+#include <linux/regmap.h>
 
 #define MAX8649_DCDC_VMIN	750000		/* uV */
 #define MAX8649_DCDC_VMAX	1380000		/* uV */
@@ -49,9 +50,8 @@
 
 struct max8649_regulator_info {
 	struct regulator_dev	*regulator;
-	struct i2c_client	*i2c;
 	struct device		*dev;
-	struct mutex		io_lock;
+	struct regmap		*regmap;
 
 	int		vol_reg;
 	unsigned	mode:2;	/* bit[1:0] = VID1, VID0 */
@@ -63,69 +63,23 @@ struct max8649_regulator_info {
 
 /* I2C operations */
 
-static inline int max8649_read_device(struct i2c_client *i2c,
-				      int reg, int bytes, void *dest)
+static int max8649_reg_read(struct max8649_regulator_info *info, int reg)
 {
-	unsigned char data;
-	int ret;
-
-	data = (unsigned char)reg;
-	ret = i2c_master_send(i2c, &data, 1);
-	if (ret < 0)
-		return ret;
-	ret = i2c_master_recv(i2c, dest, bytes);
-	if (ret < 0)
-		return ret;
-	return 0;
-}
-
-static inline int max8649_write_device(struct i2c_client *i2c,
-				       int reg, int bytes, void *src)
-{
-	unsigned char buf[bytes + 1];
+	unsigned int val;
 	int ret;
 
-	buf[0] = (unsigned char)reg;
-	memcpy(&buf[1], src, bytes);
+	ret = regmap_read(info->regmap, reg, &val);
 
-	ret = i2c_master_send(i2c, buf, bytes + 1);
-	if (ret < 0)
+	if (ret != 0)
 		return ret;
-	return 0;
-}
 
-static int max8649_reg_read(struct i2c_client *i2c, int reg)
-{
-	struct max8649_regulator_info *info = i2c_get_clientdata(i2c);
-	unsigned char data;
-	int ret;
-
-	mutex_lock(&info->io_lock);
-	ret = max8649_read_device(i2c, reg, 1, &data);
-	mutex_unlock(&info->io_lock);
-
-	if (ret < 0)
-		return ret;
-	return (int)data;
+	return val;
 }
 
-static int max8649_set_bits(struct i2c_client *i2c, int reg,
+static int max8649_set_bits(struct max8649_regulator_info *info, int reg,
 			    unsigned char mask, unsigned char data)
 {
-	struct max8649_regulator_info *info = i2c_get_clientdata(i2c);
-	unsigned char value;
-	int ret;
-
-	mutex_lock(&info->io_lock);
-	ret = max8649_read_device(i2c, reg, 1, &value);
-	if (ret < 0)
-		goto out;
-	value &= ~mask;
-	value |= data;
-	ret = max8649_write_device(i2c, reg, 1, &value);
-out:
-	mutex_unlock(&info->io_lock);
-	return ret;
+	return regmap_update_bits(info->regmap, reg, mask, data);
 }
 
 static inline int check_range(int min_uV, int max_uV)
@@ -147,7 +101,7 @@ static int max8649_get_voltage(struct regulator_dev *rdev)
 	unsigned char data;
 	int ret;
 
-	ret = max8649_reg_read(info->i2c, info->vol_reg);
+	ret = max8649_reg_read(info, info->vol_reg);
 	if (ret < 0)
 		return ret;
 	data = (unsigned char)ret & MAX8649_VOL_MASK;
@@ -170,14 +124,14 @@ static int max8649_set_voltage(struct regulator_dev *rdev,
 	mask = MAX8649_VOL_MASK;
 	*selector = data & mask;
 
-	return max8649_set_bits(info->i2c, info->vol_reg, mask, data);
+	return max8649_set_bits(info, info->vol_reg, mask, data);
 }
 
 /* EN_PD means pulldown on EN input */
 static int max8649_enable(struct regulator_dev *rdev)
 {
 	struct max8649_regulator_info *info = rdev_get_drvdata(rdev);
-	return max8649_set_bits(info->i2c, MAX8649_CONTROL, MAX8649_EN_PD, 0);
+	return max8649_set_bits(info, MAX8649_CONTROL, MAX8649_EN_PD, 0);
 }
 
 /*
@@ -187,7 +141,7 @@ static int max8649_enable(struct regulator_dev *rdev)
 static int max8649_disable(struct regulator_dev *rdev)
 {
 	struct max8649_regulator_info *info = rdev_get_drvdata(rdev);
-	return max8649_set_bits(info->i2c, MAX8649_CONTROL, MAX8649_EN_PD,
+	return max8649_set_bits(info, MAX8649_CONTROL, MAX8649_EN_PD,
 				MAX8649_EN_PD);
 }
 
@@ -196,7 +150,7 @@ static int max8649_is_enabled(struct regulator_dev *rdev)
 	struct max8649_regulator_info *info = rdev_get_drvdata(rdev);
 	int ret;
 
-	ret = max8649_reg_read(info->i2c, MAX8649_CONTROL);
+	ret = max8649_reg_read(info, MAX8649_CONTROL);
 	if (ret < 0)
 		return ret;
 	return !((unsigned char)ret & MAX8649_EN_PD);
@@ -208,14 +162,14 @@ static int max8649_enable_time(struct regulator_dev *rdev)
 	int voltage, rate, ret;
 
 	/* get voltage */
-	ret = max8649_reg_read(info->i2c, info->vol_reg);
+	ret = max8649_reg_read(info, info->vol_reg);
 	if (ret < 0)
 		return ret;
 	ret &= MAX8649_VOL_MASK;
 	voltage = max8649_list_voltage(rdev, (unsigned char)ret); /* uV */
 
 	/* get rate */
-	ret = max8649_reg_read(info->i2c, MAX8649_RAMP);
+	ret = max8649_reg_read(info, MAX8649_RAMP);
 	if (ret < 0)
 		return ret;
 	ret = (ret & MAX8649_RAMP_MASK) >> 5;
@@ -230,11 +184,11 @@ static int max8649_set_mode(struct regulator_dev *rdev, unsigned int mode)
 
 	switch (mode) {
 	case REGULATOR_MODE_FAST:
-		max8649_set_bits(info->i2c, info->vol_reg, MAX8649_FORCE_PWM,
+		max8649_set_bits(info, info->vol_reg, MAX8649_FORCE_PWM,
 				 MAX8649_FORCE_PWM);
 		break;
 	case REGULATOR_MODE_NORMAL:
-		max8649_set_bits(info->i2c, info->vol_reg,
+		max8649_set_bits(info, info->vol_reg,
 				 MAX8649_FORCE_PWM, 0);
 		break;
 	default:
@@ -248,7 +202,7 @@ static unsigned int max8649_get_mode(struct regulator_dev *rdev)
 	struct max8649_regulator_info *info = rdev_get_drvdata(rdev);
 	int ret;
 
-	ret = max8649_reg_read(info->i2c, info->vol_reg);
+	ret = max8649_reg_read(info, info->vol_reg);
 	if (ret & MAX8649_FORCE_PWM)
 		return REGULATOR_MODE_FAST;
 	return REGULATOR_MODE_NORMAL;
@@ -275,6 +229,11 @@ static struct regulator_desc dcdc_desc = {
 	.owner		= THIS_MODULE,
 };
 
+static struct regmap_config max8649_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
 static int __devinit max8649_regulator_probe(struct i2c_client *client,
 					     const struct i2c_device_id *id)
 {
@@ -289,9 +248,14 @@ static int __devinit max8649_regulator_probe(struct i2c_client *client,
 		return -ENOMEM;
 	}
 
-	info->i2c = client;
+	info->regmap = regmap_init_i2c(client, &max8649_regmap_config);
+	if (IS_ERR(info->regmap)) {
+		ret = PTR_ERR(info->regmap);
+		dev_err(&client->dev, "Failed to allocate register map: %d\n", ret);
+		goto fail;
+	}
+
 	info->dev = &client->dev;
-	mutex_init(&info->io_lock);
 	i2c_set_clientdata(client, info);
 
 	info->mode = pdata->mode;
@@ -312,7 +276,7 @@ static int __devinit max8649_regulator_probe(struct i2c_client *client,
 		break;
 	}
 
-	ret = max8649_reg_read(info->i2c, MAX8649_CHIP_ID1);
+	ret = max8649_reg_read(info, MAX8649_CHIP_ID1);
 	if (ret < 0) {
 		dev_err(info->dev, "Failed to detect ID of MAX8649:%d\n",
 			ret);
@@ -321,28 +285,28 @@ static int __devinit max8649_regulator_probe(struct i2c_client *client,
 	dev_info(info->dev, "Detected MAX8649 (ID:%x)\n", ret);
 
 	/* enable VID0 & VID1 */
-	max8649_set_bits(info->i2c, MAX8649_CONTROL, MAX8649_VID_MASK, 0);
+	max8649_set_bits(info, MAX8649_CONTROL, MAX8649_VID_MASK, 0);
 
 	/* enable/disable external clock synchronization */
 	info->extclk = pdata->extclk;
 	data = (info->extclk) ? MAX8649_SYNC_EXTCLK : 0;
-	max8649_set_bits(info->i2c, info->vol_reg, MAX8649_SYNC_EXTCLK, data);
+	max8649_set_bits(info, info->vol_reg, MAX8649_SYNC_EXTCLK, data);
 	if (info->extclk) {
 		/* set external clock frequency */
 		info->extclk_freq = pdata->extclk_freq;
-		max8649_set_bits(info->i2c, MAX8649_SYNC, MAX8649_EXT_MASK,
+		max8649_set_bits(info, MAX8649_SYNC, MAX8649_EXT_MASK,
 				 info->extclk_freq << 6);
 	}
 
 	if (pdata->ramp_timing) {
 		info->ramp_timing = pdata->ramp_timing;
-		max8649_set_bits(info->i2c, MAX8649_RAMP, MAX8649_RAMP_MASK,
+		max8649_set_bits(info, MAX8649_RAMP, MAX8649_RAMP_MASK,
 				 info->ramp_timing << 5);
 	}
 
 	info->ramp_down = pdata->ramp_down;
 	if (info->ramp_down) {
-		max8649_set_bits(info->i2c, MAX8649_RAMP, MAX8649_RAMP_DOWN,
+		max8649_set_bits(info, MAX8649_RAMP, MAX8649_RAMP_DOWN,
 				 MAX8649_RAMP_DOWN);
 	}
 
@@ -358,6 +322,8 @@ static int __devinit max8649_regulator_probe(struct i2c_client *client,
 	dev_info(info->dev, "Max8649 regulator device is detected.\n");
 	return 0;
 out:
+	regmap_exit(info->regmap);
+fail:
 	kfree(info);
 	return ret;
 }
@@ -369,6 +335,7 @@ static int __devexit max8649_regulator_remove(struct i2c_client *client)
 	if (info) {
 		if (info->regulator)
 			regulator_unregister(info->regulator);
+		regmap_exit(info->regmap);
 		kfree(info);
 	}
 
-- 
1.7.1
