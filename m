From: w.egorov@phytec.de (Wadim Egorov)
Date: Fri, 15 Apr 2016 11:16:28 +0200
Subject: [PATCH 4/6] regulator: rk8xx: Migrate to regulator core's simplified
 DT parsing code
In-Reply-To: <1460711790-22646-1-git-send-email-w.egorov@phytec.de>
References: <1460711790-22646-1-git-send-email-w.egorov@phytec.de>
Message-ID: <1460711790-22646-5-git-send-email-w.egorov@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A common simplified DT parsing code for regulators was introduced in
commit a0c7b164ad11 ("regulator: of: Provide simplified DT parsing
method")

While at it also added RK8XX_DESC and RK8XX_DESC_SWITCH macros for the
regulator_desc struct initialization. This just makes the driver more compact.
Remove also linear ranges definitions with only one range.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
Changes since RFC:
* dropped of_regulator_match
---
 drivers/regulator/rk8xx-regulator.c | 308 +++++++++++++-----------------------
 1 file changed, 114 insertions(+), 194 deletions(-)

diff --git a/drivers/regulator/rk8xx-regulator.c b/drivers/regulator/rk8xx-regulator.c
index fc75957..4a29726 100644
--- a/drivers/regulator/rk8xx-regulator.c
+++ b/drivers/regulator/rk8xx-regulator.c
@@ -55,6 +55,42 @@
 /* max steps for increase voltage of Buck1/2, equal 100mv*/
 #define MAX_STEPS_ONE_TIME 8
 
+#define RK8XX_DESC(_id, _match, _supply, _min, _max, _step, _vreg,	\
+	_vmask, _ereg, _emask, _etime)					\
+	[_id] = {							\
+		.name		= (_match),				\
+		.supply_name	= (_supply),				\
+		.of_match	= of_match_ptr(_match),			\
+		.regulators_node = of_match_ptr("regulators"),		\
+		.type		= REGULATOR_VOLTAGE,			\
+		.id		= (_id),				\
+		.n_voltages	= (((_max) - (_min)) / (_step) + 1),	\
+		.owner		= THIS_MODULE,				\
+		.min_uV		= (_min) * 1000,			\
+		.uV_step	= (_step) * 1000,			\
+		.vsel_reg	= (_vreg),				\
+		.vsel_mask	= (_vmask),				\
+		.enable_reg	= (_ereg),				\
+		.enable_mask	= (_emask),				\
+		.enable_time	= (_etime),				\
+		.ops		= &rk808_reg_ops,			\
+	}
+
+#define RK8XX_DESC_SWITCH(_id, _match, _supply, _ereg, _emask)		\
+	[_id] = {							\
+		.name		= (_match),				\
+		.supply_name	= (_supply),				\
+		.of_match	= of_match_ptr(_match),			\
+		.regulators_node = of_match_ptr("regulators"),		\
+		.type		= REGULATOR_VOLTAGE,			\
+		.id		= (_id),				\
+		.enable_reg	= (_ereg),				\
+		.enable_mask	= (_emask),				\
+		.owner		= THIS_MODULE,				\
+		.ops		= &rk808_switch_ops			\
+	}
+
+
 struct rk808_regulator_data {
 	struct gpio_desc *dvs_gpio[2];
 };
@@ -66,27 +102,11 @@ static const int rk808_buck_config_regs[] = {
 	RK808_BUCK4_CONFIG_REG,
 };
 
-static const struct regulator_linear_range rk808_buck_voltage_ranges[] = {
-	REGULATOR_LINEAR_RANGE(712500, 0, 63, 12500),
-};
-
-static const struct regulator_linear_range rk808_buck4_voltage_ranges[] = {
-	REGULATOR_LINEAR_RANGE(1800000, 0, 15, 100000),
-};
-
-static const struct regulator_linear_range rk808_ldo_voltage_ranges[] = {
-	REGULATOR_LINEAR_RANGE(1800000, 0, 16, 100000),
-};
-
 static const struct regulator_linear_range rk808_ldo3_voltage_ranges[] = {
 	REGULATOR_LINEAR_RANGE(800000, 0, 13, 100000),
 	REGULATOR_LINEAR_RANGE(2500000, 15, 15, 0),
 };
 
-static const struct regulator_linear_range rk808_ldo6_voltage_ranges[] = {
-	REGULATOR_LINEAR_RANGE(800000, 0, 17, 100000),
-};
-
 static int rk808_buck1_2_get_voltage_sel_regmap(struct regulator_dev *rdev)
 {
 	struct rk808_regulator_data *pdata = rdev_get_drvdata(rdev);
@@ -239,7 +259,7 @@ static int rk808_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
 				  RK808_RAMP_RATE_MASK, ramp_value);
 }
 
-static int rk808_set_suspend_voltage(struct regulator_dev *rdev, int uv)
+static int rk808_set_suspend_voltage_range(struct regulator_dev *rdev, int uv)
 {
 	unsigned int reg;
 	int sel = regulator_map_voltage_linear_range(rdev, uv, uv);
@@ -254,6 +274,21 @@ static int rk808_set_suspend_voltage(struct regulator_dev *rdev, int uv)
 				  sel);
 }
 
+static int rk808_set_suspend_voltage(struct regulator_dev *rdev, int uv)
+{
+	unsigned int reg;
+	int sel = regulator_map_voltage_linear(rdev, uv, uv);
+
+	if (sel < 0)
+		return -EINVAL;
+
+	reg = rdev->desc->vsel_reg + RK808_SLP_REG_OFFSET;
+
+	return regmap_update_bits(rdev->regmap, reg,
+				  rdev->desc->vsel_mask,
+				  sel);
+}
+
 static int rk808_set_suspend_enable(struct regulator_dev *rdev)
 {
 	unsigned int reg;
@@ -291,7 +326,7 @@ static struct regulator_ops rk808_buck1_2_ops = {
 	.set_suspend_disable	= rk808_set_suspend_disable,
 };
 
-static struct regulator_ops rk808_reg_ops = {
+static struct regulator_ops rk808_reg_ops_ranges = {
 	.list_voltage		= regulator_list_voltage_linear_range,
 	.map_voltage		= regulator_map_voltage_linear_range,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
@@ -299,6 +334,19 @@ static struct regulator_ops rk808_reg_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
+	.set_suspend_voltage	= rk808_set_suspend_voltage_range,
+	.set_suspend_enable	= rk808_set_suspend_enable,
+	.set_suspend_disable	= rk808_set_suspend_disable,
+};
+
+static struct regulator_ops rk808_reg_ops = {
+	.list_voltage		= regulator_list_voltage_linear,
+	.map_voltage		= regulator_map_voltage_linear,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
 	.set_suspend_voltage	= rk808_set_suspend_voltage,
 	.set_suspend_enable	= rk808_set_suspend_enable,
 	.set_suspend_disable	= rk808_set_suspend_disable,
@@ -316,12 +364,14 @@ static const struct regulator_desc rk808_reg[] = {
 	{
 		.name = "DCDC_REG1",
 		.supply_name = "vcc1",
+		.of_match = of_match_ptr("DCDC_REG1"),
+		.regulators_node = of_match_ptr("regulators"),
 		.id = RK808_ID_DCDC1,
 		.ops = &rk808_buck1_2_ops,
 		.type = REGULATOR_VOLTAGE,
+		.min_uV = 712500,
+		.uV_step = 12500,
 		.n_voltages = 64,
-		.linear_ranges = rk808_buck_voltage_ranges,
-		.n_linear_ranges = ARRAY_SIZE(rk808_buck_voltage_ranges),
 		.vsel_reg = RK808_BUCK1_ON_VSEL_REG,
 		.vsel_mask = RK808_BUCK_VSEL_MASK,
 		.enable_reg = RK808_DCDC_EN_REG,
@@ -330,12 +380,14 @@ static const struct regulator_desc rk808_reg[] = {
 	}, {
 		.name = "DCDC_REG2",
 		.supply_name = "vcc2",
+		.of_match = of_match_ptr("DCDC_REG2"),
+		.regulators_node = of_match_ptr("regulators"),
 		.id = RK808_ID_DCDC2,
 		.ops = &rk808_buck1_2_ops,
 		.type = REGULATOR_VOLTAGE,
+		.min_uV = 712500,
+		.uV_step = 12500,
 		.n_voltages = 64,
-		.linear_ranges = rk808_buck_voltage_ranges,
-		.n_linear_ranges = ARRAY_SIZE(rk808_buck_voltage_ranges),
 		.vsel_reg = RK808_BUCK2_ON_VSEL_REG,
 		.vsel_mask = RK808_BUCK_VSEL_MASK,
 		.enable_reg = RK808_DCDC_EN_REG,
@@ -344,6 +396,8 @@ static const struct regulator_desc rk808_reg[] = {
 	}, {
 		.name = "DCDC_REG3",
 		.supply_name = "vcc3",
+		.of_match = of_match_ptr("DCDC_REG3"),
+		.regulators_node = of_match_ptr("regulators"),
 		.id = RK808_ID_DCDC3,
 		.ops = &rk808_switch_ops,
 		.type = REGULATOR_VOLTAGE,
@@ -351,55 +405,23 @@ static const struct regulator_desc rk808_reg[] = {
 		.enable_reg = RK808_DCDC_EN_REG,
 		.enable_mask = BIT(2),
 		.owner = THIS_MODULE,
-	}, {
-		.name = "DCDC_REG4",
-		.supply_name = "vcc4",
-		.id = RK808_ID_DCDC4,
-		.ops = &rk808_reg_ops,
-		.type = REGULATOR_VOLTAGE,
-		.n_voltages = 16,
-		.linear_ranges = rk808_buck4_voltage_ranges,
-		.n_linear_ranges = ARRAY_SIZE(rk808_buck4_voltage_ranges),
-		.vsel_reg = RK808_BUCK4_ON_VSEL_REG,
-		.vsel_mask = RK808_BUCK4_VSEL_MASK,
-		.enable_reg = RK808_DCDC_EN_REG,
-		.enable_mask = BIT(3),
-		.owner = THIS_MODULE,
-	}, {
-		.name = "LDO_REG1",
-		.supply_name = "vcc6",
-		.id = RK808_ID_LDO1,
-		.ops = &rk808_reg_ops,
-		.type = REGULATOR_VOLTAGE,
-		.n_voltages = 17,
-		.linear_ranges = rk808_ldo_voltage_ranges,
-		.n_linear_ranges = ARRAY_SIZE(rk808_ldo_voltage_ranges),
-		.vsel_reg = RK808_LDO1_ON_VSEL_REG,
-		.vsel_mask = RK808_LDO_VSEL_MASK,
-		.enable_reg = RK808_LDO_EN_REG,
-		.enable_mask = BIT(0),
-		.enable_time = 400,
-		.owner = THIS_MODULE,
-	}, {
-		.name = "LDO_REG2",
-		.supply_name = "vcc6",
-		.id = RK808_ID_LDO2,
-		.ops = &rk808_reg_ops,
-		.type = REGULATOR_VOLTAGE,
-		.n_voltages = 17,
-		.linear_ranges = rk808_ldo_voltage_ranges,
-		.n_linear_ranges = ARRAY_SIZE(rk808_ldo_voltage_ranges),
-		.vsel_reg = RK808_LDO2_ON_VSEL_REG,
-		.vsel_mask = RK808_LDO_VSEL_MASK,
-		.enable_reg = RK808_LDO_EN_REG,
-		.enable_mask = BIT(1),
-		.enable_time = 400,
-		.owner = THIS_MODULE,
-	}, {
+	},
+	RK8XX_DESC(RK808_ID_DCDC4, "DCDC_REG4", "vcc4", 1800, 3300, 100,
+		RK808_BUCK4_ON_VSEL_REG, RK808_BUCK4_VSEL_MASK,
+		RK808_DCDC_EN_REG, BIT(3), 0),
+	RK8XX_DESC(RK808_ID_LDO1, "LDO_REG1", "vcc6", 1800, 3400, 100,
+		RK808_LDO1_ON_VSEL_REG, RK808_LDO_VSEL_MASK, RK808_LDO_EN_REG,
+		BIT(0), 400),
+	RK8XX_DESC(RK808_ID_LDO2, "LDO_REG2", "vcc6", 1800, 3400, 100,
+		RK808_LDO2_ON_VSEL_REG, RK808_LDO_VSEL_MASK, RK808_LDO_EN_REG,
+		BIT(1), 400),
+	{
 		.name = "LDO_REG3",
 		.supply_name = "vcc7",
+		.of_match = of_match_ptr("LDO_REG3"),
+		.regulators_node = of_match_ptr("regulators"),
 		.id = RK808_ID_LDO3,
-		.ops = &rk808_reg_ops,
+		.ops = &rk808_reg_ops_ranges,
 		.type = REGULATOR_VOLTAGE,
 		.n_voltages = 16,
 		.linear_ranges = rk808_ldo3_voltage_ranges,
@@ -410,117 +432,26 @@ static const struct regulator_desc rk808_reg[] = {
 		.enable_mask = BIT(2),
 		.enable_time = 400,
 		.owner = THIS_MODULE,
-	}, {
-		.name = "LDO_REG4",
-		.supply_name = "vcc9",
-		.id = RK808_ID_LDO4,
-		.ops = &rk808_reg_ops,
-		.type = REGULATOR_VOLTAGE,
-		.n_voltages = 17,
-		.linear_ranges = rk808_ldo_voltage_ranges,
-		.n_linear_ranges = ARRAY_SIZE(rk808_ldo_voltage_ranges),
-		.vsel_reg = RK808_LDO4_ON_VSEL_REG,
-		.vsel_mask = RK808_LDO_VSEL_MASK,
-		.enable_reg = RK808_LDO_EN_REG,
-		.enable_mask = BIT(3),
-		.enable_time = 400,
-		.owner = THIS_MODULE,
-	}, {
-		.name = "LDO_REG5",
-		.supply_name = "vcc9",
-		.id = RK808_ID_LDO5,
-		.ops = &rk808_reg_ops,
-		.type = REGULATOR_VOLTAGE,
-		.n_voltages = 17,
-		.linear_ranges = rk808_ldo_voltage_ranges,
-		.n_linear_ranges = ARRAY_SIZE(rk808_ldo_voltage_ranges),
-		.vsel_reg = RK808_LDO5_ON_VSEL_REG,
-		.vsel_mask = RK808_LDO_VSEL_MASK,
-		.enable_reg = RK808_LDO_EN_REG,
-		.enable_mask = BIT(4),
-		.enable_time = 400,
-		.owner = THIS_MODULE,
-	}, {
-		.name = "LDO_REG6",
-		.supply_name = "vcc10",
-		.id = RK808_ID_LDO6,
-		.ops = &rk808_reg_ops,
-		.type = REGULATOR_VOLTAGE,
-		.n_voltages = 18,
-		.linear_ranges = rk808_ldo6_voltage_ranges,
-		.n_linear_ranges = ARRAY_SIZE(rk808_ldo6_voltage_ranges),
-		.vsel_reg = RK808_LDO6_ON_VSEL_REG,
-		.vsel_mask = RK808_LDO_VSEL_MASK,
-		.enable_reg = RK808_LDO_EN_REG,
-		.enable_mask = BIT(5),
-		.enable_time = 400,
-		.owner = THIS_MODULE,
-	}, {
-		.name = "LDO_REG7",
-		.supply_name = "vcc7",
-		.id = RK808_ID_LDO7,
-		.ops = &rk808_reg_ops,
-		.type = REGULATOR_VOLTAGE,
-		.n_voltages = 18,
-		.linear_ranges = rk808_ldo6_voltage_ranges,
-		.n_linear_ranges = ARRAY_SIZE(rk808_ldo6_voltage_ranges),
-		.vsel_reg = RK808_LDO7_ON_VSEL_REG,
-		.vsel_mask = RK808_LDO_VSEL_MASK,
-		.enable_reg = RK808_LDO_EN_REG,
-		.enable_mask = BIT(6),
-		.enable_time = 400,
-		.owner = THIS_MODULE,
-	}, {
-		.name = "LDO_REG8",
-		.supply_name = "vcc11",
-		.id = RK808_ID_LDO8,
-		.ops = &rk808_reg_ops,
-		.type = REGULATOR_VOLTAGE,
-		.n_voltages = 17,
-		.linear_ranges = rk808_ldo_voltage_ranges,
-		.n_linear_ranges = ARRAY_SIZE(rk808_ldo_voltage_ranges),
-		.vsel_reg = RK808_LDO8_ON_VSEL_REG,
-		.vsel_mask = RK808_LDO_VSEL_MASK,
-		.enable_reg = RK808_LDO_EN_REG,
-		.enable_mask = BIT(7),
-		.enable_time = 400,
-		.owner = THIS_MODULE,
-	}, {
-		.name = "SWITCH_REG1",
-		.supply_name = "vcc8",
-		.id = RK808_ID_SWITCH1,
-		.ops = &rk808_switch_ops,
-		.type = REGULATOR_VOLTAGE,
-		.enable_reg = RK808_DCDC_EN_REG,
-		.enable_mask = BIT(5),
-		.owner = THIS_MODULE,
-	}, {
-		.name = "SWITCH_REG2",
-		.supply_name = "vcc12",
-		.id = RK808_ID_SWITCH2,
-		.ops = &rk808_switch_ops,
-		.type = REGULATOR_VOLTAGE,
-		.enable_reg = RK808_DCDC_EN_REG,
-		.enable_mask = BIT(6),
-		.owner = THIS_MODULE,
 	},
-};
-
-static struct of_regulator_match rk808_reg_matches[] = {
-	[RK808_ID_DCDC1]	= { .name = "DCDC_REG1" },
-	[RK808_ID_DCDC2]	= { .name = "DCDC_REG2" },
-	[RK808_ID_DCDC3]	= { .name = "DCDC_REG3" },
-	[RK808_ID_DCDC4]	= { .name = "DCDC_REG4" },
-	[RK808_ID_LDO1]		= { .name = "LDO_REG1" },
-	[RK808_ID_LDO2]		= { .name = "LDO_REG2" },
-	[RK808_ID_LDO3]		= { .name = "LDO_REG3" },
-	[RK808_ID_LDO4]		= { .name = "LDO_REG4" },
-	[RK808_ID_LDO5]		= { .name = "LDO_REG5" },
-	[RK808_ID_LDO6]		= { .name = "LDO_REG6" },
-	[RK808_ID_LDO7]		= { .name = "LDO_REG7" },
-	[RK808_ID_LDO8]		= { .name = "LDO_REG8" },
-	[RK808_ID_SWITCH1]	= { .name = "SWITCH_REG1" },
-	[RK808_ID_SWITCH2]	= { .name = "SWITCH_REG2" },
+	RK8XX_DESC(RK808_ID_LDO4, "LDO_REG4", "vcc9", 1800, 3400, 100,
+		RK808_LDO4_ON_VSEL_REG, RK808_LDO_VSEL_MASK, RK808_LDO_EN_REG,
+		BIT(3), 400),
+	RK8XX_DESC(RK808_ID_LDO5, "LDO_REG5", "vcc9", 1800, 3400, 100,
+		RK808_LDO5_ON_VSEL_REG, RK808_LDO_VSEL_MASK, RK808_LDO_EN_REG,
+		BIT(4), 400),
+	RK8XX_DESC(RK808_ID_LDO6, "LDO_REG6", "vcc10", 800, 2500, 100,
+		RK808_LDO6_ON_VSEL_REG, RK808_LDO_VSEL_MASK, RK808_LDO_EN_REG,
+		BIT(5), 400),
+	RK8XX_DESC(RK808_ID_LDO7, "LDO_REG7", "vcc7", 800, 2500, 100,
+		RK808_LDO7_ON_VSEL_REG, RK808_LDO_VSEL_MASK, RK808_LDO_EN_REG,
+		BIT(6), 400),
+	RK8XX_DESC(RK808_ID_LDO8, "LDO_REG8", "vcc11", 1800, 3400, 100,
+		RK808_LDO8_ON_VSEL_REG, RK808_LDO_VSEL_MASK, RK808_LDO_EN_REG,
+		BIT(7), 400),
+	RK8XX_DESC_SWITCH(RK808_ID_SWITCH1, "SWITCH_REG1", "vcc8",
+		RK808_DCDC_EN_REG, BIT(5)),
+	RK8XX_DESC_SWITCH(RK808_ID_SWITCH2, "SWITCH_REG2", "vcc12",
+		RK808_DCDC_EN_REG, BIT(6)),
 };
 
 static int rk8xx_regulator_dt_parse_pdata(struct device *dev,
@@ -529,17 +460,12 @@ static int rk8xx_regulator_dt_parse_pdata(struct device *dev,
 				   struct rk808_regulator_data *pdata)
 {
 	struct device_node *np;
-	int tmp, ret, i;
+	int tmp, ret = 0, i;
 
 	np = of_get_child_by_name(client_dev->of_node, "regulators");
 	if (!np)
 		return -ENXIO;
 
-	ret = of_regulator_match(dev, np, rk808_reg_matches,
-				 RK808_NUM_REGULATORS);
-	if (ret < 0)
-		goto dt_parse_end;
-
 	for (i = 0; i < ARRAY_SIZE(pdata->dvs_gpio); i++) {
 		pdata->dvs_gpio[i] =
 			devm_gpiod_get_index_optional(client_dev, "dvs", i,
@@ -586,18 +512,12 @@ static int rk8xx_regulator_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pdata);
 
+	config.dev = &client->dev;
+	config.driver_data = pdata;
+	config.regmap = rk8xx->regmap;
+
 	/* Instantiate the regulators */
 	for (i = 0; i < RK808_NUM_REGULATORS; i++) {
-		if (!rk808_reg_matches[i].init_data ||
-		    !rk808_reg_matches[i].of_node)
-			continue;
-
-		config.dev = &client->dev;
-		config.driver_data = pdata;
-		config.regmap = rk8xx->regmap;
-		config.of_node = rk808_reg_matches[i].of_node;
-		config.init_data = rk808_reg_matches[i].init_data;
-
 		rk8xx_rdev = devm_regulator_register(&pdev->dev,
 						     &rk808_reg[i], &config);
 		if (IS_ERR(rk8xx_rdev)) {
-- 
1.9.1
