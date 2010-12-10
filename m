From: bengt.g.jonsson@stericsson.com (Bengt Jonsson)
Date: Fri, 10 Dec 2010 11:08:46 +0100
Subject: [PATCH 7/9] regulators: Added verbose debug messages to ab8500
	regulators
In-Reply-To: <1291975728-12525-1-git-send-email-bengt.g.jonsson@stericsson.com>
References: <1291975728-12525-1-git-send-email-bengt.g.jonsson@stericsson.com>
Message-ID: <1291975728-12525-8-git-send-email-bengt.g.jonsson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The verbose debug outputs register writes and reads that can be
used to debug the driver.

Signed-off-by: Bengt Jonsson <bengt.g.jonsson@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/regulator/ab8500.c |   63 +++++++++++++++++++++++++++++++++++--------
 1 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index 2a15b63..7d372b8 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -114,6 +114,12 @@ static int ab8500_regulator_enable(struct regulator_dev *rdev)
 	if (ret < 0)
 		dev_err(rdev_get_dev(rdev),
 			"couldn't set enable bits for regulator\n");
+
+	dev_vdbg(rdev_get_dev(rdev),
+		"%s-enable (bank, reg, mask, value): 0x%x, 0x%x, 0x%x, 0x%x\n",
+		info->desc.name, info->update_bank, info->update_reg,
+		info->update_mask, info->update_val_enable);
+
 	return ret;
 }
 
@@ -133,6 +139,12 @@ static int ab8500_regulator_disable(struct regulator_dev *rdev)
 	if (ret < 0)
 		dev_err(rdev_get_dev(rdev),
 			"couldn't set disable bits for regulator\n");
+
+	dev_vdbg(rdev_get_dev(rdev),
+		"%s-disable (bank, reg, mask, value): 0x%x, 0x%x, 0x%x, 0x%x\n",
+		info->desc.name, info->update_bank, info->update_reg,
+		info->update_mask, 0x0);
+
 	return ret;
 }
 
@@ -140,7 +152,7 @@ static int ab8500_regulator_is_enabled(struct regulator_dev *rdev)
 {
 	int ret;
 	struct ab8500_regulator_info *info = rdev_get_drvdata(rdev);
-	u8 value;
+	u8 regval;
 
 	if (info == NULL) {
 		dev_err(rdev_get_dev(rdev), "regulator info null pointer\n");
@@ -148,14 +160,20 @@ static int ab8500_regulator_is_enabled(struct regulator_dev *rdev)
 	}
 
 	ret = abx500_get_register_interruptible(info->dev,
-		info->update_bank, info->update_reg, &value);
+		info->update_bank, info->update_reg, &regval);
 	if (ret < 0) {
 		dev_err(rdev_get_dev(rdev),
 			"couldn't read 0x%x register\n", info->update_reg);
 		return ret;
 	}
 
-	if (value & info->update_mask)
+	dev_vdbg(rdev_get_dev(rdev),
+		"%s-is_enabled (bank, reg, mask, value): 0x%x, 0x%x, 0x%x,"
+		" 0x%x\n",
+		info->desc.name, info->update_bank, info->update_reg,
+		info->update_mask, regval);
+
+	if (regval & info->update_mask)
 		return true;
 	else
 		return false;
@@ -182,29 +200,35 @@ static int ab8500_list_voltage(struct regulator_dev *rdev, unsigned selector)
 
 static int ab8500_regulator_get_voltage(struct regulator_dev *rdev)
 {
-	int ret;
+	int ret, val;
 	struct ab8500_regulator_info *info = rdev_get_drvdata(rdev);
-	u8 value;
+	u8 regval;
 
 	if (info == NULL) {
 		dev_err(rdev_get_dev(rdev), "regulator info null pointer\n");
 		return -EINVAL;
 	}
 
-	ret = abx500_get_register_interruptible(info->dev, info->voltage_bank,
-		info->voltage_reg, &value);
+	ret = abx500_get_register_interruptible(info->dev,
+			info->voltage_bank, info->voltage_reg, &regval);
 	if (ret < 0) {
 		dev_err(rdev_get_dev(rdev),
 			"couldn't read voltage reg for regulator\n");
 		return ret;
 	}
 
+	dev_vdbg(rdev_get_dev(rdev),
+		"%s-get_voltage (bank, reg, mask, value): 0x%x, 0x%x, 0x%x,"
+		" 0x%x\n",
+		info->desc.name, info->voltage_bank, info->voltage_reg,
+		info->voltage_mask, regval);
+
 	/* vintcore has a different layout */
-	value &= info->voltage_mask;
+	val = regval & info->voltage_mask;
 	if (info->desc.id == AB8500_LDO_INTCORE)
-		ret = info->voltages[value >> 0x3];
+		ret = info->voltages[val >> 0x3];
 	else
-		ret = info->voltages[value];
+		ret = info->voltages[val];
 
 	return ret;
 }
@@ -231,6 +255,7 @@ static int ab8500_regulator_set_voltage(struct regulator_dev *rdev,
 {
 	int ret;
 	struct ab8500_regulator_info *info = rdev_get_drvdata(rdev);
+	u8 regval;
 
 	if (info == NULL) {
 		dev_err(rdev_get_dev(rdev), "regulator info null pointer\n");
@@ -248,13 +273,20 @@ static int ab8500_regulator_set_voltage(struct regulator_dev *rdev,
 	*selector = ret;
 
 	/* set the registers for the request */
+	regval = (u8)ret;
 	ret = abx500_mask_and_set_register_interruptible(info->dev,
-		info->voltage_bank, info->voltage_reg,
-		info->voltage_mask, (u8)ret);
+			info->voltage_bank, info->voltage_reg,
+			info->voltage_mask, regval);
 	if (ret < 0)
 		dev_err(rdev_get_dev(rdev),
 		"couldn't set voltage reg for regulator\n");
 
+	dev_vdbg(rdev_get_dev(rdev),
+		"%s-set_voltage (bank, reg, mask, value): 0x%x, 0x%x, 0x%x,"
+		" 0x%x\n",
+		info->desc.name, info->voltage_bank, info->voltage_reg,
+		info->voltage_mask, regval);
+
 	return ret;
 }
 
@@ -418,6 +450,9 @@ static __devinit int ab8500_regulator_probe(struct platform_device *pdev)
 			}
 			return err;
 		}
+
+		dev_vdbg(rdev_get_dev(info->regulator),
+			"%s-probed\n", info->desc.name);
 	}
 
 	return 0;
@@ -430,6 +465,10 @@ static __devexit int ab8500_regulator_remove(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(ab8500_regulator_info); i++) {
 		struct ab8500_regulator_info *info = NULL;
 		info = &ab8500_regulator_info[i];
+
+		dev_vdbg(rdev_get_dev(info->regulator),
+			"%s-remove\n", info->desc.name);
+
 		regulator_unregister(info->regulator);
 	}
 
-- 
1.7.2.2
