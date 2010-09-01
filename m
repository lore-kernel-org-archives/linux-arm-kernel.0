From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 01 Sep 2010 18:44:11 +0900
Subject: [PATCH v2] MAX8952 PMIC Driver Initial Release
In-Reply-To: <20100901091519.GA17032@opensource.wolfsonmicro.com>
References: <1282283036-12641-1-git-send-email-myungjoo.ham@samsung.com>
	<20100820095351.GD13668@rakim.wolfsonmicro.main>
	<1282301229.3084.152.camel@odin>
	<011b01cb496a$cfa773d0$6ef65b70$%kim@samsung.com>
	<20100901091519.GA17032@opensource.wolfsonmicro.com>
Message-ID: <000801cb49ba$3e1e50f0$ba5af2d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Wed, Sep 01, 2010 at 09:15:36AM +0900, Kukjin Kim wrote:
> 
> > Seems almost same between the operation of max8649 and max8952 except
> output
> > voltage range.
> 
> > How do you think that can support max8952 with small modifying max8649?
> 
> Take a look at something like the WM831x drivers for how you can handle
> multiple devices with one driver - you can register I2C IDs for multiple
> devices and then select behaviour based on the name that was quoted.

MM...but I'm not sure if I can submit other patch for max8952...
Actually, Mr. Ham's max8952 code has been applied by Liam.

Anyway, could you please see below patch?
Basic functions are tested on the board...


From: Changhwan Youn <chaos.youn@samsung.com>
---
diff --git a/drivers/regulator/max8649.c b/drivers/regulator/max8649.c
index 4520ace..a13bf1d 100644
--- a/drivers/regulator/max8649.c
+++ b/drivers/regulator/max8649.c
@@ -22,6 +22,9 @@
 #define MAX8649_DCDC_STEP	10000		/* uV */
 #define MAX8649_VOL_MASK	0x3f
 
+/* difference between voltages of max8649 and max8952 */
+#define DIFF_DCDC_VOL		20000		/* uV */
+
 /* Registers */
 #define MAX8649_MODE0		0x00
 #define MAX8649_MODE1		0x01
@@ -138,7 +141,12 @@ static inline int check_range(int min_uV, int max_uV)
 
 static int max8649_list_voltage(struct regulator_dev *rdev, unsigned index)
 {
-	return (MAX8649_DCDC_VMIN + index * MAX8649_DCDC_STEP);
+	struct max8649_regulator_info *info = rdev_get_drvdata(rdev);
+	int ret = MAX8649_DCDC_VMIN + index * MAX8649_DCDC_STEP;
+
+	if (!strcmp(info->i2c->name, "max8952"))
+		ret += DIFF_DCDC_VOL;
+	return ret;
 }
 
 static int max8649_get_voltage(struct regulator_dev *rdev)
@@ -160,6 +168,11 @@ static int max8649_set_voltage(struct regulator_dev
*rdev,
 	struct max8649_regulator_info *info = rdev_get_drvdata(rdev);
 	unsigned char data, mask;
 
+	if (!strcmp(info->i2c->name, "max8952")) {
+		min_uV -= DIFF_DCDC_VOL;
+		max_uV -= DIFF_DCDC_VOL;
+	}
+
 	if (check_range(min_uV, max_uV)) {
 		dev_err(info->dev, "invalid voltage range (%d, %d) uV\n",
 			min_uV, max_uV);
@@ -263,7 +276,6 @@ static struct regulator_ops max8649_dcdc_ops = {
 	.enable_time	= max8649_enable_time,
 	.set_mode	= max8649_set_mode,
 	.get_mode	= max8649_get_mode,
-
 };
 
 static struct regulator_desc dcdc_desc = {
@@ -311,13 +323,13 @@ static int __devinit max8649_regulator_probe(struct
i2c_client *client,
 		break;
 	}
 
-	ret = max8649_reg_read(info->i2c, MAX8649_CHIP_ID1);
+	ret = max8649_reg_read(info->i2c, MAX8649_CHIP_ID2);
 	if (ret < 0) {
 		dev_err(info->dev, "Failed to detect ID of MAX8649:%d\n",
 			ret);
 		goto out;
 	}
-	dev_info(info->dev, "Detected MAX8649 (ID:%x)\n", ret);
+	dev_info(info->dev, "Detected %s (ID:%x)\n", id->name, ret);
 
 	/* enable VID0 & VID1 */
 	max8649_set_bits(info->i2c, MAX8649_CONTROL, MAX8649_VID_MASK, 0);
@@ -354,7 +366,7 @@ static int __devinit max8649_regulator_probe(struct
i2c_client *client,
 		goto out;
 	}
 
-	dev_info(info->dev, "Max8649 regulator device is detected.\n");
+	dev_info(info->dev, "%s regulator device is detected.\n", id->name);
 	return 0;
 out:
 	kfree(info);
@@ -376,6 +388,7 @@ static int __devexit max8649_regulator_remove(struct
i2c_client *client)
 
 static const struct i2c_device_id max8649_id[] = {
 	{ "max8649", 0 },
+	{ "max8952", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max8649_id);
--
1.6.2.5


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
