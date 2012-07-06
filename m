From: jtzhou@marvell.com (Jett.Zhou)
Date: Fri,  6 Jul 2012 10:58:40 +0800
Subject: [V3 1/4] regulator: 88pm860x: add pre-regulator support for 88pm860x
 regulator
In-Reply-To: <20120705141541.GO4111@opensource.wolfsonmicro.com>
References: <20120705141541.GO4111@opensource.wolfsonmicro.com>
Message-ID: <1341543520-6427-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pre-regulator of 88pm8606 is mainly for support charging based on vbus,
it needs to be enabled for charging battery, and will be disabled in
some exception condition like over-temp.
Add the pre-regulator support for 88pm860x regulator driver.

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
---
 drivers/regulator/88pm8607.c |   66 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/88pm8607.c b/drivers/regulator/88pm8607.c
index c3482b9..3c81fd0 100644
--- a/drivers/regulator/88pm8607.c
+++ b/drivers/regulator/88pm8607.c
@@ -23,6 +23,7 @@ struct pm8607_regulator_info {
 	struct pm860x_chip	*chip;
 	struct regulator_dev	*regulator;
 	struct i2c_client	*i2c;
+	struct i2c_client	*i2c_8606;
 
 	unsigned int	*vol_table;
 	unsigned int	*vol_suspend;
@@ -242,6 +243,35 @@ static int pm8607_set_voltage_sel(struct regulator_dev *rdev, unsigned selector)
 	return ret;
 }
 
+static int pm8606_preg_enable(struct regulator_dev *rdev)
+{
+	struct pm8607_regulator_info *info = rdev_get_drvdata(rdev);
+
+	return pm860x_set_bits(info->i2c, rdev->desc->enable_reg,
+			       1 << rdev->desc->enable_mask, 0);
+}
+
+static int pm8606_preg_disable(struct regulator_dev *rdev)
+{
+	struct pm8607_regulator_info *info = rdev_get_drvdata(rdev);
+
+	return pm860x_set_bits(info->i2c, rdev->desc->enable_reg,
+			       1 << rdev->desc->enable_mask,
+			       1 << rdev->desc->enable_mask);
+}
+
+static int pm8606_preg_is_enabled(struct regulator_dev *rdev)
+{
+	struct pm8607_regulator_info *info = rdev_get_drvdata(rdev);
+	int ret;
+
+	ret = pm860x_reg_read(info->i2c, rdev->desc->enable_reg);
+	if (ret < 0)
+		return ret;
+
+	return !((unsigned char)ret & (1 << rdev->desc->enable_mask));
+}
+
 static struct regulator_ops pm8607_regulator_ops = {
 	.list_voltage	= pm8607_list_voltage,
 	.set_voltage_sel = pm8607_set_voltage_sel,
@@ -251,6 +281,25 @@ static struct regulator_ops pm8607_regulator_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 };
 
+static struct regulator_ops pm8606_preg_ops = {
+	.enable		= pm8606_preg_enable,
+	.disable	= pm8606_preg_disable,
+	.is_enabled	= pm8606_preg_is_enabled,
+};
+
+#define PM8606_PREG(ereg, ebit)						\
+{									\
+	.desc	= {							\
+		.name	= "PREG",					\
+		.ops	= &pm8606_preg_ops,				\
+		.type	= REGULATOR_CURRENT,				\
+		.id	= PM8606_ID_PREG,				\
+		.owner	= THIS_MODULE,					\
+		.enable_reg = PM8606_##ereg,				\
+		.enable_mask = (ebit),					\
+	},								\
+}
+
 #define PM8607_DVC(vreg, ureg, ubit, ereg, ebit)			\
 {									\
 	.desc	= {							\
@@ -309,6 +358,8 @@ static struct pm8607_regulator_info pm8607_regulator_info[] = {
 	PM8607_LDO(12,        LDO12, 0, SUPPLIES_EN12, 5),
 	PM8607_LDO(13, VIBRATOR_SET, 1, VIBRATOR_SET, 0),
 	PM8607_LDO(14,        LDO14, 0, SUPPLIES_EN12, 6),
+
+	PM8606_PREG(PREREGULATORB, 5),
 };
 
 static int __devinit pm8607_regulator_probe(struct platform_device *pdev)
@@ -336,6 +387,8 @@ static int __devinit pm8607_regulator_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 	info->i2c = (chip->id == CHIP_PM8607) ? chip->client : chip->companion;
+	info->i2c_8606 = (chip->id == CHIP_PM8607) ? chip->companion :
+			chip->client;
 	info->chip = chip;
 
 	/* check DVC ramp slope double */
@@ -372,6 +425,18 @@ static int __devexit pm8607_regulator_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static struct platform_device_id pm8607_regulator_driver_ids[] = {
+	{
+		.name	= "88pm860x-regulator",
+		.driver_data	= 0,
+	}, {
+		.name	= "88pm860x-preg",
+		.driver_data	= 0,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, pm8607_regulator_driver_ids);
+
 static struct platform_driver pm8607_regulator_driver = {
 	.driver		= {
 		.name	= "88pm860x-regulator",
@@ -379,6 +444,7 @@ static struct platform_driver pm8607_regulator_driver = {
 	},
 	.probe		= pm8607_regulator_probe,
 	.remove		= __devexit_p(pm8607_regulator_remove),
+	.id_table	= pm8607_regulator_driver_ids,
 };
 
 static int __init pm8607_regulator_init(void)
-- 
1.7.0.4
