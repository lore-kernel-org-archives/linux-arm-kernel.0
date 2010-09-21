From: l.majewski@samsung.com (Lukasz Majewski)
Date: Tue, 21 Sep 2010 16:18:15 +0200
Subject: [PATCH] mfd: regulator: max8998: BUCK1/2 control augmented by GPIO
	pins
Message-ID: <1285078695-24753-1-git-send-email-l.majewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch facilitates the faster voltage change for BUCK1/2 regulators. It uses
MAX8998 GPIO pins to control output voltage. This feature is extremely useful
for Dynamic Voltage Scalling (DVS) implementation.
This patch has been tested at Samsung GONI and AQUILA targets.
Corresponding platform code will be submitted in a separate patch.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mfd/max8998.c               |    5 +-
 drivers/regulator/max8998.c         |  192 +++++++++++++++++++++++++++++++----
 include/linux/mfd/max8998-private.h |    9 ++
 include/linux/mfd/max8998.h         |   42 ++++++++
 4 files changed, 228 insertions(+), 20 deletions(-)

diff --git a/drivers/mfd/max8998.c b/drivers/mfd/max8998.c
index 310fd80..a720f41 100644
--- a/drivers/mfd/max8998.c
+++ b/drivers/mfd/max8998.c
@@ -133,6 +133,7 @@ static int max8998_i2c_probe(struct i2c_client *i2c,
 	max8998->dev = &i2c->dev;
 	max8998->i2c = i2c;
 	max8998->irq = i2c->irq;
+	max8998->type = id->driver_data;
 	if (pdata) {
 		max8998->ono = pdata->ono;
 		max8998->irq_base = pdata->irq_base;
@@ -169,8 +170,8 @@ static int max8998_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id max8998_i2c_id[] = {
-	{ "max8998", 0 },
-	{ "lp3974", 0 },
+	{ "max8998", TYPE_MAX8998 },
+	{ "lp3974", TYPE_LP3974},
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max8998_i2c_id);
diff --git a/drivers/regulator/max8998.c b/drivers/regulator/max8998.c
index 7f5fe6f..7fe37b2 100644
--- a/drivers/regulator/max8998.c
+++ b/drivers/regulator/max8998.c
@@ -39,6 +39,8 @@ struct max8998_data {
 	struct max8998_dev	*iodev;
 	int			num_regulators;
 	struct regulator_dev	**rdev;
+	unsigned int		buck1_idx;
+	unsigned int		buck2_idx;
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
+		reg = MAX8998_REG_BUCK1_DVSARM1 + max8998->buck1_idx;
 		break;
 	case MAX8998_BUCK2:
-		reg = MAX8998_REG_BUCK2_DVSINT1;
+		reg = MAX8998_REG_BUCK2_DVSINT1 + max8998->buck2_idx;
 		break;
 	case MAX8998_BUCK3:
 		reg = MAX8998_REG_BUCK3;
@@ -297,19 +300,71 @@ static int max8998_get_voltage(struct regulator_dev *rdev)
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
+
+	if (ldo >= ARRAY_SIZE(ldo_voltage_map))
+		return -EINVAL;
+
+	desc = ldo_voltage_map[ldo];
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
+	int previous_vol = 0;
+	const struct voltage_map_desc *desc;
+	int ldo = max8998_get_ldo(rdev);
+	int reg, shift = 0, mask, ret;
+	int i = 0, j = 0;
 	bool en_ramp = false;
+	int difference = 0;
+	u8 dvs_arm_no = 0;
+	u8 val = 0;
 
 	if (ldo >= ARRAY_SIZE(ldo_voltage_map))
 		return -EINVAL;
@@ -332,24 +387,86 @@ static int max8998_set_voltage(struct regulator_dev *rdev,
 	if (ret)
 		return ret;
 
-	/* wait for RAMP_UP_DELAY if rdev is BUCK1/2 and
-	 * ENRAMP is ON */
-	if (ldo == MAX8998_BUCK1 || ldo == MAX8998_BUCK2) {
-		max8998_read_reg(i2c, MAX8998_REG_ONOFF4, &val);
-		if (val & (1 << 4)) {
-			en_ramp = true;
-			previous_vol = max8998_get_voltage(rdev);
+	previous_vol = max8998_get_voltage(rdev);
+
+	/* Check if voltage needs to be changed */
+	/* if previous_voltage equal new voltage, return */
+	if (previous_vol == max8998_list_voltage(rdev, i)) {
+		dev_dbg(max8998->dev, "No voltage change, old:%d, new:%d\n",
+			previous_vol, max8998_list_voltage(rdev, i));
+		return ret;
+	}
+	if (ldo == MAX8998_BUCK1) {
+
+		dvs_arm_no = ARRAY_SIZE(pdata->dvsarm);
+		dev_dbg(max8998->dev,
+			"BUCK1, i:%d, dvs1:%d, dvs2:%d, dvs3:%d, dvs4:%d\n",
+			i, pdata->dvsarm[0], pdata->dvsarm[1],
+			pdata->dvsarm[2], pdata->dvsarm[3]);
+
+		for (j = 0; j < dvs_arm_no; j++) {
+			if (pdata->dvsarm[j] == i) {
+				max8998->buck1_idx = j;
+				buck1_gpio_set(pdata->set1,
+					       pdata->set2, j);
+				break;
+			}
+			if (j == (dvs_arm_no - 1)) {
+				/* no predefine regulator found */
+				max8998->buck1_idx = j;
+				ret = max8998_get_voltage_register(rdev, &reg,
+								   &shift,
+								   &mask);
+				ret = max8998_write_reg(i2c, reg, i);
+				buck1_gpio_set(pdata->set1,
+					       pdata->set2, j);
+			}
 		}
 	}
+	if (ldo == MAX8998_BUCK2) {
+		dev_dbg(max8998->dev, "BUCK2, i:%d dvs1:%d, dvs2:%d\n", i,
+			pdata->dvsint[0], pdata->dvsint[1]);
 
-	ret = max8998_update_reg(i2c, reg, i<<shift, mask<<shift);
+		if (pdata->dvsint[0] == i) {
+			max8998->buck1_idx = 0;
+			buck2_gpio_set(pdata->set3, 0);
+		} else {
+			max8998->buck1_idx = 1;
+			ret = max8998_get_voltage_register(rdev, &reg,
+							   &shift, &mask);
+			ret = max8998_write_reg(i2c, reg, i);
+			buck2_gpio_set(pdata->set3, 1);
+		}
+	}
+
+	if ((ldo == MAX8998_BUCK3) || (ldo == MAX8998_BUCK4))
+		ret = max8998_update_reg(i2c, reg, i<<shift, mask<<shift);
 
-	if (en_ramp == true) {
-		int difference = desc->min + desc->step*i - previous_vol/1000;
+	/* Wait until voltage is stabilized */
+	max8998_read_reg(i2c, MAX8998_REG_ONOFF4, &val);
+	/* lp3974 hasn't got ENRAMP bit - ramp is assumed as true */
+	dev_dbg(max8998->dev, "name:%s\n", i2c->name);
+	if (max8998->iodev->type == TYPE_LP3974) {
+		difference = desc->min + desc->step*i - previous_vol/1000;
 		if (difference > 0)
 			udelay(difference / ((val & 0x0f) + 1));
 	}
 
+	/* MAX8998 has ENRAMP bit implemented */
+	if (max8998->iodev->type == TYPE_MAX8998) {
+		if (val & (1 << 4)) {
+			en_ramp = true;
+			difference = desc->min + desc->step*i -
+				previous_vol/1000;
+			if (difference > 0)
+				udelay(difference / ((val & 0x0f) + 1));
+		}
+	}
+
+	dev_dbg(max8998->dev, "SET1:%d, SET2:%d, SET3:%d\n",
+		gpio_get_value(pdata->set1), gpio_get_value(pdata->set2),
+		gpio_get_value(pdata->set3));
+
 	return ret;
 }
 
@@ -359,7 +476,7 @@ static struct regulator_ops max8998_ldo_ops = {
 	.enable			= max8998_ldo_enable,
 	.disable		= max8998_ldo_disable,
 	.get_voltage		= max8998_get_voltage,
-	.set_voltage		= max8998_set_voltage,
+	.set_voltage		= max8998_set_voltage_ldo,
 	.set_suspend_enable	= max8998_ldo_enable,
 	.set_suspend_disable	= max8998_ldo_disable,
 };
@@ -370,7 +487,7 @@ static struct regulator_ops max8998_buck_ops = {
 	.enable			= max8998_ldo_enable,
 	.disable		= max8998_ldo_disable,
 	.get_voltage		= max8998_get_voltage,
-	.set_voltage		= max8998_set_voltage,
+	.set_voltage		= max8998_set_voltage_buck,
 	.set_suspend_enable	= max8998_ldo_enable,
 	.set_suspend_disable	= max8998_ldo_disable,
 };
@@ -543,6 +660,8 @@ static __devinit int max8998_pmic_probe(struct platform_device *pdev)
 	struct max8998_platform_data *pdata = dev_get_platdata(iodev->dev);
 	struct regulator_dev **rdev;
 	struct max8998_data *max8998;
+	struct i2c_client *i2c;
+	u8 dvs_arm_no = 0;
 	int i, ret, size;
 
 	if (!pdata) {
@@ -566,6 +685,44 @@ static __devinit int max8998_pmic_probe(struct platform_device *pdev)
 	max8998->iodev = iodev;
 	max8998->num_regulators = pdata->num_regulators;
 	platform_set_drvdata(pdev, max8998);
+	i2c = max8998->iodev->i2c;
+
+	/* Check if platform data for max8998 has been declared */
+	if (pdata->dvsarm[0] != 0 && pdata->dvsarm[1] != 0 &&
+	    pdata->dvsarm[2] != 0 && pdata->dvsarm[3] != 0 &&
+	    pdata->dvsint[0] != 0 && pdata->dvsint[1] != 0) {
+			dvs_arm_no = ARRAY_SIZE(pdata->dvsarm);
+			pdata->dvsarm[dvs_arm_no - 1] = pdata->dvsarm_init;
+
+			for (i = 0; i < dvs_arm_no; ++i) {
+				max8998_write_reg(i2c,
+						  MAX8998_REG_BUCK1_DVSARM1 + i,
+						  pdata->dvsarm[i]);
+			}
+
+			pdata->dvsint[1] = pdata->dvsint_init;
+			max8998_write_reg(i2c, MAX8998_REG_BUCK2_DVSINT1,
+					  pdata->dvsint[0]);
+			max8998_write_reg(i2c, MAX8998_REG_BUCK2_DVSINT2,
+					  pdata->dvsint[1]);
+
+			/* Set default values */
+			max8998->buck1_idx = 3;
+			max8998->buck2_idx = 1;
+		}
+	if (pdata->set1 != 0 && pdata->set2 != 0 && pdata->set3 != 0) {
+			gpio_request(pdata->set1, "PMIC SET1");
+			gpio_direction_output(pdata->set1,
+					      max8998->buck1_idx & 0x1);
+
+			gpio_request(pdata->set2, "PMIC SET2");
+			gpio_direction_output(pdata->set2,
+					      (max8998->buck1_idx >> 1) & 0x1);
+
+			gpio_request(pdata->set3, "PMIC SET3");
+			gpio_direction_output(pdata->set3,
+					      max8998->buck2_idx & 0x1);
+		}
 
 	for (i = 0; i < pdata->num_regulators; i++) {
 		const struct voltage_map_desc *desc;
@@ -587,7 +744,6 @@ static __devinit int max8998_pmic_probe(struct platform_device *pdev)
 		}
 	}
 
-
 	return 0;
 err:
 	for (i = 0; i < max8998->num_regulators; i++)
diff --git a/include/linux/mfd/max8998-private.h b/include/linux/mfd/max8998-private.h
index 170f665..1a990b8 100644
--- a/include/linux/mfd/max8998-private.h
+++ b/include/linux/mfd/max8998-private.h
@@ -101,6 +101,13 @@ enum {
 	MAX8998_IRQ_NR,
 };
 
+/* MAX8998 various variants */
+enum {
+	TYPE_MAX8998 = 0, /* Default */
+	TYPE_LP3974,	/* National version of MAX8998 */
+	TYPE_LP3979,	/* Added AVS */
+};
+
 #define MAX8998_IRQ_DCINF_MASK		(1 << 2)
 #define MAX8998_IRQ_DCINR_MASK		(1 << 3)
 #define MAX8998_IRQ_JIGF_MASK		(1 << 4)
@@ -135,6 +142,7 @@ enum {
  * @ono: power onoff IRQ number for max8998
  * @irq_masks_cur: currently active value
  * @irq_masks_cache: cached hardware value
+ * @type: indicate which max8998 "variant" is used
  */
 struct max8998_dev {
 	struct device *dev;
@@ -148,6 +156,7 @@ struct max8998_dev {
 	int ono;
 	u8 irq_masks_cur[MAX8998_NUM_IRQ_REGS];
 	u8 irq_masks_cache[MAX8998_NUM_IRQ_REGS];
+	int type;
 };
 
 int max8998_irq_init(struct max8998_dev *max8998);
diff --git a/include/linux/mfd/max8998.h b/include/linux/mfd/max8998.h
index d47ed4c..c89686a 100644
--- a/include/linux/mfd/max8998.h
+++ b/include/linux/mfd/max8998.h
@@ -54,6 +54,41 @@ enum {
 	MAX8998_ESAFEOUT2,
 };
 
+enum {
+	MAX8998_DVS_750mV,
+	MAX8998_DVS_775mV,
+	MAX8998_DVS_800mV,
+	MAX8998_DVS_825mV,
+	MAX8998_DVS_850mV,
+	MAX8998_DVS_875mV,
+	MAX8998_DVS_900mV,
+	MAX8998_DVS_925mV,
+	MAX8998_DVS_950mV,
+	MAX8998_DVS_975mV,
+	MAX8998_DVS_1000mV,
+	MAX8998_DVS_1025mV,
+	MAX8998_DVS_1050mV,
+	MAX8998_DVS_1075mV,
+	MAX8998_DVS_1100mV,
+	MAX8998_DVS_1125mV,
+	MAX8998_DVS_1150mV,
+	MAX8998_DVS_1175mV,
+	MAX8998_DVS_1200mV,
+	MAX8998_DVS_1225mV,
+	MAX8998_DVS_1250mV,
+	MAX8998_DVS_1275mV,
+	MAX8998_DVS_1300mV,
+	MAX8998_DVS_1325mV,
+	MAX8998_DVS_1350mV,
+	MAX8998_DVS_1375mV,
+	MAX8998_DVS_1400mV,
+	MAX8998_DVS_1425mV,
+	MAX8998_DVS_1450mV,
+	MAX8998_DVS_1475mV,
+	MAX8998_DVS_1500mV,
+	MAX8998_DVS_1525mV,
+};
+
 /**
  * max8998_regulator_data - regulator data
  * @id: regulator id
@@ -76,6 +111,13 @@ struct max8998_platform_data {
 	int				num_regulators;
 	int				irq_base;
 	int				ono;
+	u8              dvsarm[4];
+	u8		dvsint[2];
+	u8              dvsarm_init;
+	u8              dvsint_init;
+	int		set1;
+	int		set2;
+	int		set3;
 };
 
 #endif /*  __LINUX_MFD_MAX8998_H */
-- 
1.7.1
