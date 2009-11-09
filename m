From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon, 9 Nov 2009 12:48:23 -0500
Subject: [PATCH] regulator: refresh 88pm8607 driver with updated api
Message-ID: <mailman.27.1258103175.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since i2c API of mfd 88pm860x driver is changed, refresh 88pm8607 driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/regulator/88pm8607.c |   34 ++++++++++++++++++----------------
 drivers/regulator/Kconfig    |    2 +-
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/regulator/88pm8607.c b/drivers/regulator/88pm8607.c
index 0471955..aad829f 100644
--- a/drivers/regulator/88pm8607.c
+++ b/drivers/regulator/88pm8607.c
@@ -14,11 +14,11 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
-#include <linux/mfd/88pm8607.h>
+#include <linux/mfd/88pm860x.h>

 struct pm8607_regulator_info {
 	struct regulator_desc	desc;
-	struct pm8607_chip	*chip;
+	struct pm860x_chip	*chip;	/* real chip device */
 	struct regulator_dev	*regulator;

 	int	min_uV;
@@ -428,7 +428,7 @@ static int pm8607_set_voltage(struct regulator_dev *rdev,
 			      int min_uV, int max_uV)
 {
 	struct pm8607_regulator_info *info = rdev_get_drvdata(rdev);
-	struct pm8607_chip *chip = info->chip;
+	struct pm860x_chip *chip = info->chip;
 	uint8_t val, mask;
 	int ret;

@@ -443,13 +443,15 @@ static int pm8607_set_voltage(struct regulator_dev *rdev,
 	val = (uint8_t)(ret << info->vol_shift);
 	mask = ((1 << info->vol_nbits) - 1)  << info->vol_shift;

-	ret = pm8607_set_bits(chip, info->vol_reg, mask, val);
+	ret = pm860x_set_bits(chip->parent, DESC_8607, info->vol_reg,
+			      mask, val);
 	if (ret)
 		return ret;
 	switch (info->desc.id) {
 	case PM8607_ID_BUCK1:
 	case PM8607_ID_BUCK3:
-		ret = pm8607_set_bits(chip, info->update_reg,
+		ret = pm860x_set_bits(chip->parent, DESC_8607,
+				      info->update_reg,
 				      1 << info->update_bit,
 				      1 << info->update_bit);
 		break;
@@ -460,11 +462,11 @@ static int pm8607_set_voltage(struct regulator_dev *rdev,
 static int pm8607_get_voltage(struct regulator_dev *rdev)
 {
 	struct pm8607_regulator_info *info = rdev_get_drvdata(rdev);
-	struct pm8607_chip *chip = info->chip;
+	struct pm860x_chip *chip = info->chip;
 	uint8_t val, mask;
 	int ret;

-	ret = pm8607_reg_read(chip, info->vol_reg);
+	ret = pm860x_reg_read(chip->parent, DESC_8607, info->vol_reg);
 	if (ret < 0)
 		return ret;

@@ -477,9 +479,9 @@ static int pm8607_get_voltage(struct regulator_dev *rdev)
 static int pm8607_enable(struct regulator_dev *rdev)
 {
 	struct pm8607_regulator_info *info = rdev_get_drvdata(rdev);
-	struct pm8607_chip *chip = info->chip;
+	struct pm860x_chip *chip = info->chip;

-	return pm8607_set_bits(chip, info->enable_reg,
+	return pm860x_set_bits(chip->parent, DESC_8607, info->enable_reg,
 			       1 << info->enable_bit,
 			       1 << info->enable_bit);
 }
@@ -487,19 +489,19 @@ static int pm8607_enable(struct regulator_dev *rdev)
 static int pm8607_disable(struct regulator_dev *rdev)
 {
 	struct pm8607_regulator_info *info = rdev_get_drvdata(rdev);
-	struct pm8607_chip *chip = info->chip;
+	struct pm860x_chip *chip = info->chip;

-	return pm8607_set_bits(chip, info->enable_reg,
+	return pm860x_set_bits(chip->parent, DESC_8607, info->enable_reg,
 			       1 << info->enable_bit, 0);
 }

 static int pm8607_is_enabled(struct regulator_dev *rdev)
 {
 	struct pm8607_regulator_info *info = rdev_get_drvdata(rdev);
-	struct pm8607_chip *chip = info->chip;
+	struct pm860x_chip *chip = info->chip;
 	int ret;

-	ret = pm8607_reg_read(chip, info->enable_reg);
+	ret = pm860x_reg_read(chip->parent, DESC_8607, info->enable_reg);
 	if (ret < 0)
 		return ret;

@@ -589,8 +591,8 @@ static inline struct pm8607_regulator_info
*find_regulator_info(int id)

 static int __devinit pm8607_regulator_probe(struct platform_device *pdev)
 {
-	struct pm8607_chip *chip = dev_get_drvdata(pdev->dev.parent);
-	struct pm8607_platform_data *pdata = chip->dev->platform_data;
+	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
+	struct pm860x_plat_data *pdata = chip->dev->platform_data;
 	struct pm8607_regulator_info *info = NULL;

 	info = find_regulator_info(pdev->id);
@@ -611,7 +613,7 @@ static int __devinit pm8607_regulator_probe(struct
platform_device *pdev)

 	/* check DVC ramp slope double */
 	if (info->desc.id == PM8607_ID_BUCK3)
-		if (info->chip->buck3_double)
+		if (info->chip->parent->buck3_double)
 			info->slope_double = 1;

 	platform_set_drvdata(pdev, info);
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
