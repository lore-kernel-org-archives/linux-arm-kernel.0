From: jtzhou@marvell.com (Jett.Zhou)
Date: Thu, 21 Jun 2012 19:31:23 +0800
Subject: [V3 1/3] regulator: add pre-regulator support for 88pm860x
In-Reply-To: <20120621101536.GR4037@opensource.wolfsonmicro.com>
References: <20120621101536.GR4037@opensource.wolfsonmicro.com>
Message-ID: <1340278283-16423-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pre-regulator of 88pm8606 is mainly for support charging based on vbus,
it needs to be enabled for charging battery, and will be disabled in
some exception condition like over-temp.

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
---
 drivers/mfd/88pm860x-core.c  |   23 ++++++++++++++
 drivers/regulator/88pm8607.c |   66 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/88pm860x.h |    1 +
 3 files changed, 90 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 87bd5ba..d09918c 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -90,6 +90,10 @@ static struct resource charger_resources[] __devinitdata = {
 	{PM8607_IRQ_VCHG, PM8607_IRQ_VCHG, "vchg voltage",    IORESOURCE_IRQ,},
 };
 
+static struct resource preg_resources[] __devinitdata = {
+	{PM8606_ID_PREG,  PM8606_ID_PREG,  "preg",   IORESOURCE_IO,},
+};
+
 static struct resource rtc_resources[] __devinitdata = {
 	{PM8607_IRQ_RTC, PM8607_IRQ_RTC, "rtc", IORESOURCE_IRQ,},
 };
@@ -142,9 +146,19 @@ static struct mfd_cell codec_devs[] = {
 	{"88pm860x-codec", -1,},
 };
 
+static struct regulator_consumer_supply preg_supply[] = {
+	REGULATOR_SUPPLY("preg", "charger-manager"),
+};
+
+static struct regulator_init_data preg_init_data = {
+	.num_consumer_supplies	= ARRAY_SIZE(preg_supply),
+	.consumer_supplies	= &preg_supply[0],
+};
+
 static struct mfd_cell power_devs[] = {
 	{"88pm860x-battery", -1,},
 	{"88pm860x-charger", -1,},
+	{"88pm860x-preg",    -1,},
 };
 
 static struct mfd_cell rtc_devs[] = {
@@ -768,6 +782,15 @@ static void __devinit device_power_init(struct pm860x_chip *chip,
 			      &charger_resources[0], chip->irq_base);
 	if (ret < 0)
 		dev_err(chip->dev, "Failed to add charger subdev\n");
+
+	power_devs[2].platform_data = &preg_init_data;
+	power_devs[2].pdata_size = sizeof(struct regulator_init_data);
+	power_devs[2].num_resources = ARRAY_SIZE(preg_resources);
+	power_devs[2].resources = &preg_resources[0],
+	ret = mfd_add_devices(chip->dev, 0, &power_devs[2], 1,
+			      &preg_resources[0], chip->irq_base);
+	if (ret < 0)
+		dev_err(chip->dev, "Failed to add preg subdev\n");
 }
 
 static void __devinit device_onkey_init(struct pm860x_chip *chip,
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
diff --git a/include/linux/mfd/88pm860x.h b/include/linux/mfd/88pm860x.h
index 84d071a..7b24943 100644
--- a/include/linux/mfd/88pm860x.h
+++ b/include/linux/mfd/88pm860x.h
@@ -136,6 +136,7 @@ enum {
 	PM8607_ID_LDO13,
 	PM8607_ID_LDO14,
 	PM8607_ID_LDO15,
+	PM8606_ID_PREG,
 
 	PM8607_ID_RG_MAX,
 };
-- 
1.7.0.4
