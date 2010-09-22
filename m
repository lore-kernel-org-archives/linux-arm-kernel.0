From: l.majewski@samsung.com (Lukasz Majewski)
Date: Wed, 22 Sep 2010 17:30:08 +0200
Subject: [PATCH v2 1/3] mfd: regulator: max8998: set_voltage_buck routine added
In-Reply-To: <1285169410-22343-1-git-send-email-l.majewski@samsung.com>
References: <1285169410-22343-1-git-send-email-l.majewski@samsung.com>
Message-ID: <1285169410-22343-2-git-send-email-l.majewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate routine for setting BUCK regulators voltage.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/regulator/max8998.c |  154 +++++++++++++++++++++++++++++++++++++------
 1 files changed, 133 insertions(+), 21 deletions(-)

diff --git a/drivers/regulator/max8998.c b/drivers/regulator/max8998.c
index 7f5fe6f..36d214a 100644
--- a/drivers/regulator/max8998.c
+++ b/drivers/regulator/max8998.c
@@ -39,6 +39,8 @@ struct max8998_data {
 	struct max8998_dev	*iodev;
 	int			num_regulators;
 	struct regulator_dev	**rdev;
+	unsigned int		buck1_idx; /* voltage index (0 to 3) */
+	unsigned int		buck2_idx; /* voltage index (0 to 1) */
 };
 
 struct voltage_map_desc {
@@ -218,6 +220,7 @@ static int max8998_get_voltage_register(struct regulator_dev *rdev,
 				int *_reg, int *_shift, int *_mask)
 {
 	int ldo = max8998_get_ldo(rdev);
+	struct max8998_data *max8998 = rdev_get_drvdata(rdev);
 	int reg, shift = 0, mask = 0xff;
 
 	switch (ldo) {
@@ -254,10 +257,10 @@ static int max8998_get_voltage_register(struct regulator_dev *rdev,
 		reg = MAX8998_REG_LDO12 + (ldo - MAX8998_LDO12);
 		break;
 	case MAX8998_BUCK1:
-		reg = MAX8998_REG_BUCK1_DVSARM1;
+		reg = MAX8998_REG_BUCK1_VOL1 + max8998->buck1_idx;
 		break;
 	case MAX8998_BUCK2:
-		reg = MAX8998_REG_BUCK2_DVSINT1;
+		reg = MAX8998_REG_BUCK2_VOL1 + max8998->buck2_idx;
 		break;
 	case MAX8998_BUCK3:
 		reg = MAX8998_REG_BUCK3;
@@ -297,19 +300,16 @@ static int max8998_get_voltage(struct regulator_dev *rdev)
 	return max8998_list_voltage(rdev, val);
 }
 
-static int max8998_set_voltage(struct regulator_dev *rdev,
+static int max8998_set_voltage_ldo(struct regulator_dev *rdev,
 				int min_uV, int max_uV)
 {
 	struct max8998_data *max8998 = rdev_get_drvdata(rdev);
 	struct i2c_client *i2c = max8998->iodev->i2c;
 	int min_vol = min_uV / 1000, max_vol = max_uV / 1000;
-	int previous_vol = 0;
 	const struct voltage_map_desc *desc;
 	int ldo = max8998_get_ldo(rdev);
 	int reg, shift = 0, mask, ret;
 	int i = 0;
-	u8 val;
-	bool en_ramp = false;
 
 	if (ldo >= ARRAY_SIZE(ldo_voltage_map))
 		return -EINVAL;
@@ -332,24 +332,135 @@ static int max8998_set_voltage(struct regulator_dev *rdev,
 	if (ret)
 		return ret;
 
-	/* wait for RAMP_UP_DELAY if rdev is BUCK1/2 and
-	 * ENRAMP is ON */
-	if (ldo == MAX8998_BUCK1 || ldo == MAX8998_BUCK2) {
-		max8998_read_reg(i2c, MAX8998_REG_ONOFF4, &val);
-		if (val & (1 << 4)) {
-			en_ramp = true;
-			previous_vol = max8998_get_voltage(rdev);
-		}
+	ret = max8998_update_reg(i2c, reg, i<<shift, mask<<shift);
+
+	return ret;
+}
+
+static inline void buck1_gpio_set(int gpio1, int gpio2, int v)
+{
+	gpio_set_value(gpio1, v & 0x1);
+	gpio_set_value(gpio2, (v >> 1) & 0x1);
+}
+
+static inline void buck2_gpio_set(int gpio, int v)
+{
+	gpio_set_value(gpio, v & 0x1);
+}
+
+static int max8998_set_voltage_buck(struct regulator_dev *rdev,
+				    int min_uV, int max_uV)
+{
+	struct max8998_data *max8998 = rdev_get_drvdata(rdev);
+	struct max8998_platform_data *pdata =
+		dev_get_platdata(max8998->iodev->dev);
+	struct i2c_client *i2c = max8998->iodev->i2c;
+	int min_vol = min_uV / 1000, max_vol = max_uV / 1000;
+	const struct voltage_map_desc *desc;
+	int buck = max8998_get_ldo(rdev);
+	int reg, shift = 0, mask, ret;
+	int difference = 0, i = 0, j = 0, previous_vol = 0;
+	u8 val = 0;
+
+	if (buck >= ARRAY_SIZE(ldo_voltage_map))
+		return -EINVAL;
+
+	desc = ldo_voltage_map[buck];
+	if (desc == NULL)
+		return -EINVAL;
+
+	if (max_vol < desc->min || min_vol > desc->max)
+		return -EINVAL;
+
+	while (desc->min + desc->step*i < min_vol &&
+	       desc->min + desc->step*i < desc->max)
+		i++;
+
+	if (desc->min + desc->step*i > max_vol)
+		return -EINVAL;
+
+	ret = max8998_get_voltage_register(rdev, &reg, &shift, &mask);
+	if (ret)
+		return ret;
+
+	previous_vol = max8998_get_voltage(rdev);
+
+	/* Check if voltage needs to be changed */
+	/* if previous_voltage equal new voltage, return */
+	if (previous_vol == max8998_list_voltage(rdev, i)) {
+		dev_dbg(max8998->dev, "No voltage change, old:%d, new:%d\n",
+			previous_vol, max8998_list_voltage(rdev, i));
+		return ret;
 	}
 
-	ret = max8998_update_reg(i2c, reg, i<<shift, mask<<shift);
+	switch (buck) {
+	case MAX8998_BUCK1:
+		dev_dbg(max8998->dev,
+			"BUCK1, i:%d, buck1_vol1:%d, buck1_vol2:%d\n\
+			 buck1_vol3:%d, buck1_vol4:%d\n",
+			i, pdata->buck1_vol[0], pdata->buck1_vol[1],
+			pdata->buck1_vol[2], pdata->buck1_vol[3]);
+
+		for (j = 0; j < ARRAY_SIZE(pdata->buck1_vol); j++) {
+			if (pdata->buck1_vol[j] == i) {
+				max8998->buck1_idx = j;
+				buck1_gpio_set(pdata->buck1_set1,
+					       pdata->buck1_set2, j);
+				break;
+			}
+			if (j == (ARRAY_SIZE(pdata->buck1_vol) - 1)) {
+				/* no predefine regulator found */
+				max8998->buck1_idx = j;
+				ret = max8998_get_voltage_register(rdev, &reg,
+								   &shift,
+								   &mask);
+				ret = max8998_write_reg(i2c, reg, i);
+				buck1_gpio_set(pdata->buck1_set1,
+					       pdata->buck1_set2, j);
+			}
+		}
+		break;
+
+	case MAX8998_BUCK2:
+		dev_dbg(max8998->dev,
+			"BUCK2, i:%d buck2_vol1:%d, buck2_vol2:%d\n"
+			, i, pdata->buck2_vol[0], pdata->buck2_vol[1]);
+
+		if (pdata->buck2_vol[0] == i) {
+			max8998->buck1_idx = 0;
+			buck2_gpio_set(pdata->buck2_set3, 0);
+		} else {
+			max8998->buck1_idx = 1;
+			ret = max8998_get_voltage_register(rdev, &reg,
+							   &shift, &mask);
+			ret = max8998_write_reg(i2c, reg, i);
+			buck2_gpio_set(pdata->buck2_set3, 1);
+		}
+		break;
 
-	if (en_ramp == true) {
-		int difference = desc->min + desc->step*i - previous_vol/1000;
-		if (difference > 0)
-			udelay(difference / ((val & 0x0f) + 1));
+	case MAX8998_BUCK3:
+	case MAX8998_BUCK4:
+		ret = max8998_update_reg(i2c, reg, i<<shift, mask<<shift);
+		break;
 	}
 
+	/* Voltage stabilization */
+	max8998_read_reg(i2c, MAX8998_REG_ONOFF4, &val);
+
+	dev_dbg(max8998->dev, "%s: SET1:%d, SET2:%d, SET3:%d\n",
+		i2c->name, gpio_get_value(pdata->buck1_set1),
+		gpio_get_value(pdata->buck1_set2),
+		gpio_get_value(pdata->buck2_set3));
+
+	/* lp3974 hasn't got ENRAMP bit - ramp is assumed as true */
+	/* MAX8998 has ENRAMP bit implemented, so test it*/
+	if (max8998->iodev->type == TYPE_MAX8998 && !(val & MAX8998_ENRAMP))
+		return ret;
+
+	difference = desc->min + desc->step*i - previous_vol/1000;
+	if (difference > 0)
+		udelay(difference / ((val & 0x0f) + 1));
+
 	return ret;
 }
 
@@ -359,7 +470,7 @@ static struct regulator_ops max8998_ldo_ops = {
 	.enable			= max8998_ldo_enable,
 	.disable		= max8998_ldo_disable,
 	.get_voltage		= max8998_get_voltage,
-	.set_voltage		= max8998_set_voltage,
+	.set_voltage		= max8998_set_voltage_ldo,
 	.set_suspend_enable	= max8998_ldo_enable,
 	.set_suspend_disable	= max8998_ldo_disable,
 };
@@ -370,7 +481,7 @@ static struct regulator_ops max8998_buck_ops = {
 	.enable			= max8998_ldo_enable,
 	.disable		= max8998_ldo_disable,
 	.get_voltage		= max8998_get_voltage,
-	.set_voltage		= max8998_set_voltage,
+	.set_voltage		= max8998_set_voltage_buck,
 	.set_suspend_enable	= max8998_ldo_enable,
 	.set_suspend_disable	= max8998_ldo_disable,
 };
@@ -543,6 +654,7 @@ static __devinit int max8998_pmic_probe(struct platform_device *pdev)
 	struct max8998_platform_data *pdata = dev_get_platdata(iodev->dev);
 	struct regulator_dev **rdev;
 	struct max8998_data *max8998;
+	struct i2c_client *i2c;
 	int i, ret, size;
 
 	if (!pdata) {
-- 
1.7.1
