From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 9 Dec 2009 15:51:26 -0500
Subject: [PATCH] regulator: refresh 88pm8607 driver with updated api
Message-ID: <mailman.87.1260364706.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since i2c API of mfd 88pm860x driver is changed, refresh 88pm8607 driver.
Remove the support of 88PM8607 A0/A1 stepping.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/regulator/88pm8607.c |  320 ++++++++++++------------------------------
 drivers/regulator/Kconfig    |    2 +-
 2 files changed, 92 insertions(+), 230 deletions(-)

diff --git a/drivers/regulator/88pm8607.c b/drivers/regulator/88pm8607.c
index 0471955..d912acf 100644
--- a/drivers/regulator/88pm8607.c
+++ b/drivers/regulator/88pm8607.c
@@ -11,15 +11,17 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/err.h>
+#include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
-#include <linux/mfd/88pm8607.h>
+#include <linux/mfd/88pm860x.h>

 struct pm8607_regulator_info {
 	struct regulator_desc	desc;
-	struct pm8607_chip	*chip;
+	struct pm860x_chip	*chip;
 	struct regulator_dev	*regulator;
+	struct i2c_client	*i2c;

 	int	min_uV;
 	int	max_uV;
@@ -46,7 +48,6 @@ static inline int check_range(struct
pm8607_regulator_info *info,
 static int pm8607_list_voltage(struct regulator_dev *rdev, unsigned index)
 {
 	struct pm8607_regulator_info *info = rdev_get_drvdata(rdev);
-	uint8_t chip_id = info->chip->chip_id;
 	int ret = -EINVAL;

 	switch (info->desc.id) {
@@ -88,79 +89,29 @@ static int pm8607_list_voltage(struct
regulator_dev *rdev, unsigned index)
 	case PM8607_ID_LDO2:
 	case PM8607_ID_LDO3:
 	case PM8607_ID_LDO9:
-		switch (chip_id) {
-		case PM8607_CHIP_A0:
-		case PM8607_CHIP_A1:
-			ret = (index < 3) ? (index * 50000 + 1800000) :
-				((index < 8) ? (index * 50000 + 2550000) :
-				 -EINVAL);
-			break;
-		case PM8607_CHIP_B0:
-			ret = (index < 3) ? (index * 50000 + 1800000) :
-				((index < 7) ? (index * 50000 + 2550000) :
-				3300000);
-			break;
-		}
+		ret = (index < 3) ? (index * 50000 + 1800000) :
+			((index < 7) ? (index * 50000 + 2550000) :
+			3300000);
 		break;
 	case PM8607_ID_LDO4:
-		switch (chip_id) {
-		case PM8607_CHIP_A0:
-		case PM8607_CHIP_A1:
-			ret = (index < 3) ? (index * 50000 + 1800000) :
-				((index < 8) ? (index * 50000 + 2550000) :
-				 -EINVAL);
-			break;
-		case PM8607_CHIP_B0:
-			ret = (index < 3) ? (index * 50000 + 1800000) :
-				((index < 6) ? (index * 50000 + 2550000) :
-				((index == 6) ? 2900000 : 3300000));
-			break;
-		}
+		ret = (index < 3) ? (index * 50000 + 1800000) :
+			((index < 6) ? (index * 50000 + 2550000) :
+			((index == 6) ? 2900000 : 3300000));
 		break;
 	case PM8607_ID_LDO6:
-		switch (chip_id) {
-		case PM8607_CHIP_A0:
-		case PM8607_CHIP_A1:
-			ret = (index < 3) ? (index * 50000 + 1800000) :
-				((index < 8) ? (index * 50000 + 2450000) :
-				-EINVAL);
-			break;
-		case PM8607_CHIP_B0:
-			ret = (index < 2) ? (index * 50000 + 1800000) :
-				((index < 7) ? (index * 50000 + 2500000) :
-				3300000);
-			break;
-		}
+		ret = (index < 2) ? (index * 50000 + 1800000) :
+			((index < 7) ? (index * 50000 + 2500000) :
+			3300000);
 		break;
 	case PM8607_ID_LDO10:
-		switch (chip_id) {
-		case PM8607_CHIP_A0:
-		case PM8607_CHIP_A1:
-			ret = (index < 3) ? (index * 50000 + 1800000) :
-				((index < 8) ? (index * 50000 + 2550000) :
-				1200000);
-			break;
-		case PM8607_CHIP_B0:
-			ret = (index < 3) ? (index * 50000 + 1800000) :
-				((index < 7) ? (index * 50000 + 2550000) :
-				((index == 7) ? 3300000 : 1200000));
-			break;
-		}
+		ret = (index < 3) ? (index * 50000 + 1800000) :
+			((index < 7) ? (index * 50000 + 2550000) :
+			((index == 7) ? 3300000 : 1200000));
 		break;
 	case PM8607_ID_LDO14:
-		switch (chip_id) {
-		case PM8607_CHIP_A0:
-		case PM8607_CHIP_A1:
-			ret = (index < 3) ? (index * 50000 + 1800000) :
-				((index < 8) ? (index * 50000 + 2550000) :
-				 -EINVAL);
-			break;
-		case PM8607_CHIP_B0:
-			ret = (index < 2) ? (index * 50000 + 1800000) :
-				((index < 7) ? (index * 50000 + 2600000) :
-				3300000);
-			break;
-		}
+		ret = (index < 2) ? (index * 50000 + 1800000) :
+			((index < 7) ? (index * 50000 + 2600000) :
+			3300000);
 		break;
 	}
 	return ret;
@@ -169,7 +120,6 @@ static int pm8607_list_voltage(struct
regulator_dev *rdev, unsigned index)
 static int choose_voltage(struct regulator_dev *rdev, int min_uV, int max_uV)
 {
 	struct pm8607_regulator_info *info = rdev_get_drvdata(rdev);
-	uint8_t chip_id = info->chip->chip_id;
 	int val = -ENOENT;
 	int ret;

@@ -254,161 +204,77 @@ static int choose_voltage(struct regulator_dev
*rdev, int min_uV, int max_uV)
 	case PM8607_ID_LDO2:
 	case PM8607_ID_LDO3:
 	case PM8607_ID_LDO9:
-		switch (chip_id) {
-		case PM8607_CHIP_A0:
-		case PM8607_CHIP_A1:
-			if (min_uV < 2700000)	/* 1800mV ~ 1900mV / 50mV */
-				if (min_uV <= 1800000)
-					val = 0;
-				else if (min_uV <= 1900000)
-					val = (min_uV - 1750001) / 50000;
-				else
-					val = 3;	/* 2700mV */
-			else {			/* 2700mV ~ 2900mV / 50mV */
-				if (min_uV <= 2900000) {
-					val = (min_uV - 2650001) / 50000;
-					val += 3;
-				} else
-					val = -EINVAL;
-			}
-			break;
-		case PM8607_CHIP_B0:
-			if (min_uV < 2700000) {	/* 1800mV ~ 1900mV / 50mV */
-				if (min_uV <= 1800000)
-					val = 0;
-				else if (min_uV <= 1900000)
-					val = (min_uV - 1750001) / 50000;
-				else
-					val = 3;	/* 2700mV */
-			} else {		 /* 2700mV ~ 2850mV / 50mV */
-				if (min_uV <= 2850000) {
-					val = (min_uV - 2650001) / 50000;
-					val += 3;
-				} else if (min_uV <= 3300000)
-					val = 7;
-				else
-					val = -EINVAL;
-			}
-			break;
+		if (min_uV < 2700000) {	/* 1800mV ~ 1900mV / 50mV */
+			if (min_uV <= 1800000)
+				val = 0;
+			else if (min_uV <= 1900000)
+				val = (min_uV - 1750001) / 50000;
+			else
+				val = 3;	/* 2700mV */
+		} else {		 /* 2700mV ~ 2850mV / 50mV */
+			if (min_uV <= 2850000) {
+				val = (min_uV - 2650001) / 50000;
+				val += 3;
+			} else if (min_uV <= 3300000)
+				val = 7;
+			else
+				val = -EINVAL;
 		}
 		break;
 	case PM8607_ID_LDO4:
-		switch (chip_id) {
-		case PM8607_CHIP_A0:
-		case PM8607_CHIP_A1:
-			if (min_uV < 2700000)	/* 1800mV ~ 1900mV / 50mV */
-				if (min_uV <= 1800000)
-					val = 0;
-				else if (min_uV <= 1900000)
-					val = (min_uV - 1750001) / 50000;
-				else
-					val = 3;	/* 2700mV */
-			else {			/* 2700mV ~ 2900mV / 50mV */
-				if (min_uV <= 2900000) {
-					val = (min_uV - 2650001) / 50000;
-					val += 3;
-				} else
-					val = -EINVAL;
-			}
-			break;
-		case PM8607_CHIP_B0:
-			if (min_uV < 2700000) {	/* 1800mV ~ 1900mV / 50mV */
-				if (min_uV <= 1800000)
-					val = 0;
-				else if (min_uV <= 1900000)
-					val = (min_uV - 1750001) / 50000;
-				else
-					val = 3;	/* 2700mV */
-			} else {		 /* 2700mV ~ 2800mV / 50mV */
-				if (min_uV <= 2850000) {
-					val = (min_uV - 2650001) / 50000;
-					val += 3;
-				} else if (min_uV <= 2900000)
-					val = 6;
-				else if (min_uV <= 3300000)
-					val = 7;
-				else
-					val = -EINVAL;
-			}
-			break;
+		if (min_uV < 2700000) {	/* 1800mV ~ 1900mV / 50mV */
+			if (min_uV <= 1800000)
+				val = 0;
+			else if (min_uV <= 1900000)
+				val = (min_uV - 1750001) / 50000;
+			else
+				val = 3;	/* 2700mV */
+		} else {		 /* 2700mV ~ 2800mV / 50mV */
+			if (min_uV <= 2850000) {
+				val = (min_uV - 2650001) / 50000;
+				val += 3;
+			} else if (min_uV <= 2900000)
+				val = 6;
+			else if (min_uV <= 3300000)
+				val = 7;
+			else
+				val = -EINVAL;
 		}
 		break;
 	case PM8607_ID_LDO6:
-		switch (chip_id) {
-		case PM8607_CHIP_A0:
-		case PM8607_CHIP_A1:
-			if (min_uV < 2600000) {	/* 1800mV ~ 1900mV / 50mV */
-				if (min_uV <= 1800000)
-					val = 0;
-				else if (min_uV <= 1900000)
-					val = (min_uV - 1750001) / 50000;
-				else
-					val = 3;	/* 2600mV */
-			} else {		/* 2600mV ~ 2800mV / 50mV */
-				if (min_uV <= 2800000) {
-					val = (min_uV - 2550001) / 50000;
-					val += 3;
-				} else
-					val = -EINVAL;
-			}
-			break;
-		case PM8607_CHIP_B0:
-			if (min_uV < 2600000) {	/* 1800mV ~ 1850mV / 50mV */
-				if (min_uV <= 1800000)
-					val = 0;
-				else if (min_uV <= 1850000)
-					val = (min_uV - 1750001) / 50000;
-				else
-					val = 2;	/* 2600mV */
-			} else {		/* 2600mV ~ 2800mV / 50mV */
-				if (min_uV <= 2800000) {
-					val = (min_uV - 2550001) / 50000;
-					val += 2;
-				} else if (min_uV <= 3300000)
-					val = 7;
-				else
-					val = -EINVAL;
-			}
-			break;
+		if (min_uV < 2600000) {	/* 1800mV ~ 1850mV / 50mV */
+			if (min_uV <= 1800000)
+				val = 0;
+			else if (min_uV <= 1850000)
+				val = (min_uV - 1750001) / 50000;
+			else
+				val = 2;	/* 2600mV */
+		} else {		/* 2600mV ~ 2800mV / 50mV */
+			if (min_uV <= 2800000) {
+				val = (min_uV - 2550001) / 50000;
+				val += 2;
+			} else if (min_uV <= 3300000)
+				val = 7;
+			else
+				val = -EINVAL;
 		}
 		break;
 	case PM8607_ID_LDO14:
-		switch (chip_id) {
-		case PM8607_CHIP_A0:
-		case PM8607_CHIP_A1:
-			if (min_uV < 2700000) {	/* 1800mV ~ 1900mV / 50mV */
-				if (min_uV <= 1800000)
-					val = 0;
-				else if (min_uV <= 1900000)
-					val = (min_uV - 1750001) / 50000;
-				else
-					val = 3;	/* 2700mV */
-			} else {		 /* 2700mV ~ 2900mV / 50mV */
-				if (min_uV <= 2900000) {
-					val = (min_uV - 2650001) / 50000;
-					val += 3;
-				} else
-					val = -EINVAL;
-			}
-			break;
-		case PM8607_CHIP_B0:
-			if (min_uV < 2700000) {	/* 1800mV ~ 1850mV / 50mV */
-				if (min_uV <= 1800000)
-					val = 0;
-				else if (min_uV <= 1850000)
-					val = (min_uV - 1750001) / 50000;
-				else
-					val = 2;	/* 2700mV */
-			} else {		 /* 2700mV ~ 2900mV / 50mV */
-				if (min_uV <= 2900000) {
-					val = (min_uV - 2650001) / 50000;
-					val += 2;
-				} else if (min_uV <= 3300000)
-					val = 7;
-				else
-					val = -EINVAL;
-			}
-			break;
+		if (min_uV < 2700000) {	/* 1800mV ~ 1850mV / 50mV */
+			if (min_uV <= 1800000)
+				val = 0;
+			else if (min_uV <= 1850000)
+				val = (min_uV - 1750001) / 50000;
+			else
+				val = 2;	/* 2700mV */
+		} else {		 /* 2700mV ~ 2900mV / 50mV */
+			if (min_uV <= 2900000) {
+				val = (min_uV - 2650001) / 50000;
+				val += 2;
+			} else if (min_uV <= 3300000)
+				val = 7;
+			else
+				val = -EINVAL;
 		}
 		break;
 	}
@@ -428,7 +294,6 @@ static int pm8607_set_voltage(struct regulator_dev *rdev,
 			      int min_uV, int max_uV)
 {
 	struct pm8607_regulator_info *info = rdev_get_drvdata(rdev);
-	struct pm8607_chip *chip = info->chip;
 	uint8_t val, mask;
 	int ret;

@@ -443,13 +308,13 @@ static int pm8607_set_voltage(struct regulator_dev *rdev,
 	val = (uint8_t)(ret << info->vol_shift);
 	mask = ((1 << info->vol_nbits) - 1)  << info->vol_shift;

-	ret = pm8607_set_bits(chip, info->vol_reg, mask, val);
+	ret = pm860x_set_bits(info->i2c, info->vol_reg, mask, val);
 	if (ret)
 		return ret;
 	switch (info->desc.id) {
 	case PM8607_ID_BUCK1:
 	case PM8607_ID_BUCK3:
-		ret = pm8607_set_bits(chip, info->update_reg,
+		ret = pm860x_set_bits(info->i2c, info->update_reg,
 				      1 << info->update_bit,
 				      1 << info->update_bit);
 		break;
@@ -460,11 +325,10 @@ static int pm8607_set_voltage(struct regulator_dev *rdev,
 static int pm8607_get_voltage(struct regulator_dev *rdev)
 {
 	struct pm8607_regulator_info *info = rdev_get_drvdata(rdev);
-	struct pm8607_chip *chip = info->chip;
 	uint8_t val, mask;
 	int ret;

-	ret = pm8607_reg_read(chip, info->vol_reg);
+	ret = pm860x_reg_read(info->i2c, info->vol_reg);
 	if (ret < 0)
 		return ret;

@@ -477,9 +341,8 @@ static int pm8607_get_voltage(struct regulator_dev *rdev)
 static int pm8607_enable(struct regulator_dev *rdev)
 {
 	struct pm8607_regulator_info *info = rdev_get_drvdata(rdev);
-	struct pm8607_chip *chip = info->chip;

-	return pm8607_set_bits(chip, info->enable_reg,
+	return pm860x_set_bits(info->i2c, info->enable_reg,
 			       1 << info->enable_bit,
 			       1 << info->enable_bit);
 }
@@ -487,19 +350,17 @@ static int pm8607_enable(struct regulator_dev *rdev)
 static int pm8607_disable(struct regulator_dev *rdev)
 {
 	struct pm8607_regulator_info *info = rdev_get_drvdata(rdev);
-	struct pm8607_chip *chip = info->chip;

-	return pm8607_set_bits(chip, info->enable_reg,
+	return pm860x_set_bits(info->i2c, info->enable_reg,
 			       1 << info->enable_bit, 0);
 }

 static int pm8607_is_enabled(struct regulator_dev *rdev)
 {
 	struct pm8607_regulator_info *info = rdev_get_drvdata(rdev);
-	struct pm8607_chip *chip = info->chip;
 	int ret;

-	ret = pm8607_reg_read(chip, info->enable_reg);
+	ret = pm860x_reg_read(info->i2c, info->enable_reg);
 	if (ret < 0)
 		return ret;

@@ -589,8 +450,8 @@ static inline struct pm8607_regulator_info
*find_regulator_info(int id)

 static int __devinit pm8607_regulator_probe(struct platform_device *pdev)
 {
-	struct pm8607_chip *chip = dev_get_drvdata(pdev->dev.parent);
-	struct pm8607_platform_data *pdata = chip->dev->platform_data;
+	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
+	struct pm860x_platform_data *pdata = chip->dev->platform_data;
 	struct pm8607_regulator_info *info = NULL;

 	info = find_regulator_info(pdev->id);
@@ -599,6 +460,7 @@ static int __devinit pm8607_regulator_probe(struct
platform_device *pdev)
 		return -EINVAL;
 	}

+	info->i2c = (chip->id == CHIP_PM8607) ? chip->client : chip->companion;
 	info->chip = chip;

 	info->regulator = regulator_register(&info->desc, &pdev->dev,
@@ -667,7 +529,7 @@ static int __init pm8607_regulator_init(void)
 	}
 	return 0;
 }
-subsys_initcall(pm8607_regulator_init);
+module_init(pm8607_regulator_init);

 static void __exit pm8607_regulator_exit(void)
 {
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 39cb6b5..e0d978b 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -166,7 +166,7 @@ config REGULATOR_TPS6507X

 config REGULATOR_88PM8607
 	bool "Marvell 88PM8607 Power regulators"
-	depends on MFD_88PM8607=y
+	depends on MFD_88PM860X=y
 	help
 	  This driver supports 88PM8607 voltage regulator chips.

-- 
1.5.6.5
