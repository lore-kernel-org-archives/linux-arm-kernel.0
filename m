From: l.majewski@samsung.com (Lukasz Majewski)
Date: Mon, 27 Sep 2010 14:32:27 +0200
Subject: [PATCH v3 5/5] mfd: regulator: max8998: BUCK1/2 voltage change with
	use of GPIOs
In-Reply-To: <1285590747-32404-1-git-send-email-l.majewski@samsung.com>
References: <1285590747-32404-1-git-send-email-l.majewski@samsung.com>
Message-ID: <1285590747-32404-6-git-send-email-l.majewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

max8998_pmic_probe:
- modified to check if valid pins are defined at platform
data
- maximal voltage values (predefined at platform data) are uploaded to
max8998 device

max8998_set_voltage_buck:
- BUCK1/2 voltages change between values already defined
- Checks if valid GPIO pins are passed from platform data
- If requested voltage cannot be satisfied from already defined values,
then one of free slots is used
- Predefined maximum voltages (as defined at platform data) are always
available

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/regulator/max8998.c |  214 ++++++++++++++++++++++++++++++++++++++----
 1 files changed, 193 insertions(+), 21 deletions(-)

diff --git a/drivers/regulator/max8998.c b/drivers/regulator/max8998.c
index 7ae0639..5c20756 100644
--- a/drivers/regulator/max8998.c
+++ b/drivers/regulator/max8998.c
@@ -340,24 +340,37 @@ static int max8998_set_voltage_ldo(struct regulator_dev *rdev,
 	return ret;
 }
 
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
 static int max8998_set_voltage_buck(struct regulator_dev *rdev,
-				int min_uV, int max_uV)
+				    int min_uV, int max_uV)
 {
 	struct max8998_data *max8998 = rdev_get_drvdata(rdev);
+	struct max8998_platform_data *pdata =
+		dev_get_platdata(max8998->iodev->dev);
 	struct i2c_client *i2c = max8998->iodev->i2c;
 	int min_vol = min_uV / 1000, max_vol = max_uV / 1000;
-	int previous_vol = 0;
 	const struct voltage_map_desc *desc;
-	int ldo = max8998_get_ldo(rdev);
+	int buck = max8998_get_ldo(rdev);
 	int reg, shift = 0, mask, ret;
-	int i = 0;
-	u8 val;
-	bool en_ramp = false;
+	int difference = 0, i = 0, j = 0, previous_vol = 0;
+	u8 val = 0;
+	static u8 buck1_last_val;
 
-	if (ldo >= ARRAY_SIZE(ldo_voltage_map))
+	if (buck >= ARRAY_SIZE(ldo_voltage_map))
 		return -EINVAL;
 
-	desc = ldo_voltage_map[ldo];
+	desc = ldo_voltage_map[buck];
+
 	if (desc == NULL)
 		return -EINVAL;
 
@@ -375,24 +388,102 @@ static int max8998_set_voltage_buck(struct regulator_dev *rdev,
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
+			i, max8998->buck1_vol[0], max8998->buck1_vol[1],
+			max8998->buck1_vol[2], max8998->buck1_vol[3]);
+
+		if (gpio_is_valid(pdata->buck1_set1) &&
+		    gpio_is_valid(pdata->buck1_set2)) {
+
+			/* check if requested voltage */
+			/* value is already defined */
+			for (j = 0; j < ARRAY_SIZE(max8998->buck1_vol); j++) {
+				if (max8998->buck1_vol[j] == i) {
+					max8998->buck1_idx = j;
+					buck1_gpio_set(pdata->buck1_set1,
+						       pdata->buck1_set2, j);
+					goto buck1_exit;
+				}
+			}
+
+			/* no predefine regulator found */
+			max8998->buck1_idx = (buck1_last_val % 2) + 2;
+			dev_dbg(max8998->dev, "max8998->buck1_idx:%d\n",
+				max8998->buck1_idx);
+			max8998->buck1_vol[max8998->buck1_idx] = i;
+			ret = max8998_get_voltage_register(rdev, &reg,
+							   &shift,
+							   &mask);
+			ret = max8998_write_reg(i2c, reg, i);
+			buck1_gpio_set(pdata->buck1_set1,
+				       pdata->buck1_set2, max8998->buck1_idx);
+			buck1_last_val++;
+buck1_exit:
+			dev_dbg(max8998->dev, "%s: SET1:%d, SET2:%d\n",
+				i2c->name, gpio_get_value(pdata->buck1_set1),
+				gpio_get_value(pdata->buck1_set2));
+			break;
+		} else {
+			ret = max8998_write_reg(i2c, reg, i);
+		}
+		break;
 
-	if (en_ramp == true) {
-		int difference = desc->min + desc->step*i - previous_vol/1000;
-		if (difference > 0)
-			udelay(difference / ((val & 0x0f) + 1));
+	case MAX8998_BUCK2:
+		dev_dbg(max8998->dev,
+			"BUCK2, i:%d buck2_vol1:%d, buck2_vol2:%d\n"
+			, i, max8998->buck2_vol[0], max8998->buck2_vol[1]);
+		if (gpio_is_valid(pdata->buck2_set3)) {
+			if (max8998->buck2_vol[0] == i) {
+				max8998->buck1_idx = 0;
+				buck2_gpio_set(pdata->buck2_set3, 0);
+			} else {
+				max8998->buck1_idx = 1;
+				ret = max8998_get_voltage_register(rdev, &reg,
+								   &shift,
+								   &mask);
+				ret = max8998_write_reg(i2c, reg, i);
+				max8998->buck2_vol[1] = i;
+				buck2_gpio_set(pdata->buck2_set3, 1);
+			}
+			dev_dbg(max8998->dev, "%s: SET3:%d\n", i2c->name,
+				gpio_get_value(pdata->buck2_set3));
+		} else {
+			ret = max8998_write_reg(i2c, reg, i);
+		}
+		break;
+
+	case MAX8998_BUCK3:
+	case MAX8998_BUCK4:
+		ret = max8998_update_reg(i2c, reg, i<<shift, mask<<shift);
+		break;
 	}
 
+	/* Voltage stabilization */
+	max8998_read_reg(i2c, MAX8998_REG_ONOFF4, &val);
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
 
@@ -586,6 +677,7 @@ static __devinit int max8998_pmic_probe(struct platform_device *pdev)
 	struct max8998_platform_data *pdata = dev_get_platdata(iodev->dev);
 	struct regulator_dev **rdev;
 	struct max8998_data *max8998;
+	struct i2c_client *i2c;
 	int i, ret, size;
 
 	if (!pdata) {
@@ -609,6 +701,86 @@ static __devinit int max8998_pmic_probe(struct platform_device *pdev)
 	max8998->iodev = iodev;
 	max8998->num_regulators = pdata->num_regulators;
 	platform_set_drvdata(pdev, max8998);
+	i2c = max8998->iodev->i2c;
+
+	/* NOTE: */
+	/* For unused GPIO NOT marked as -1 (thereof equal to 0)  WARN_ON */
+	/* will be displayed */
+
+	/* Check if MAX8998 voltage selection GPIOs are defined */
+	if (gpio_is_valid(pdata->buck1_set1) &&
+	    gpio_is_valid(pdata->buck1_set2)) {
+		/* Check if SET1 is not equal to 0 */
+		if (!pdata->buck1_set1) {
+			printk(KERN_ERR "MAX8998 SET1 GPIO defined as 0 !\n");
+			WARN_ON(!pdata->buck1_set1);
+			return -EIO;
+		}
+		/* Check if SET2 is not equal to 0 */
+		if (!pdata->buck1_set2) {
+			printk(KERN_ERR "MAX8998 SET2 GPIO defined as 0 !\n");
+			WARN_ON(!pdata->buck1_set2);
+			return -EIO;
+		}
+
+		gpio_request(pdata->buck1_set1, "MAX8998 BUCK1_SET1");
+		gpio_direction_output(pdata->buck1_set1,
+				      max8998->buck1_idx & 0x1);
+
+
+		gpio_request(pdata->buck1_set2, "MAX8998 BUCK1_SET2");
+		gpio_direction_output(pdata->buck1_set2,
+				      (max8998->buck1_idx >> 1) & 0x1);
+		/* Set predefined value for BUCK1 register 1 */
+		i = 0;
+		while (buck12_voltage_map_desc.min +
+		       buck12_voltage_map_desc.step*i
+		       != (pdata->buck1_max_voltage1 / 1000))
+			i++;
+		printk(KERN_ERR "i:%d, buck1_idx:%d\n", i, max8998->buck1_idx);
+		max8998->buck1_vol[0] = i;
+		ret = max8998_write_reg(i2c, MAX8998_REG_BUCK1_VOLTAGE1, i);
+
+		/* Set predefined value for BUCK1 register 2 */
+		i = 0;
+		while (buck12_voltage_map_desc.min +
+		       buck12_voltage_map_desc.step*i
+		       != (pdata->buck1_max_voltage2 / 1000))
+			i++;
+
+		max8998->buck1_vol[1] = i;
+		printk(KERN_ERR "i:%d, buck1_idx:%d\n", i, max8998->buck1_idx);
+		ret = max8998_write_reg(i2c, MAX8998_REG_BUCK1_VOLTAGE2, i)
+			+ ret;
+		if (ret)
+			return ret;
+
+	}
+
+	if (gpio_is_valid(pdata->buck2_set3)) {
+		/* Check if SET3 is not equal to 0 */
+		if (!pdata->buck2_set3) {
+			printk(KERN_ERR "MAX8998 SET3 GPIO defined as 0 !\n");
+			WARN_ON(!pdata->buck2_set3);
+			return -EIO;
+		}
+		gpio_request(pdata->buck2_set3, "MAX8998 BUCK2_SET3");
+		gpio_direction_output(pdata->buck2_set3,
+				      max8998->buck2_idx & 0x1);
+
+		/* BUCK2 - set preset default voltage value to buck2_vol[0] */
+		i = 0;
+		while (buck12_voltage_map_desc.min +
+		       buck12_voltage_map_desc.step*i
+		       != (pdata->buck2_max_voltage / 1000))
+			i++;
+		printk(KERN_ERR "i:%d, buck2_idx:%d\n", i, max8998->buck2_idx);
+		max8998->buck2_vol[0] = i;
+		ret = max8998_write_reg(i2c, MAX8998_REG_BUCK2_VOLTAGE1, i);
+		if (ret)
+			return ret;
+
+	}
 
 	for (i = 0; i < pdata->num_regulators; i++) {
 		const struct voltage_map_desc *desc;
-- 
1.7.1
