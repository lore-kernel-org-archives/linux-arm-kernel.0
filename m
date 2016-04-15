From: w.egorov@phytec.de (Wadim Egorov)
Date: Fri, 15 Apr 2016 11:16:29 +0200
Subject: [PATCH 5/6] regulator: rk8xx: Add regulator driver for RK818
In-Reply-To: <1460711790-22646-1-git-send-email-w.egorov@phytec.de>
References: <1460711790-22646-1-git-send-email-w.egorov@phytec.de>
Message-ID: <1460711790-22646-6-git-send-email-w.egorov@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the rk818 regulator. The regulator module consists
of 4 DCDCs, 9 LDOs, 1 switch and 1 BOOST converter which is used to
power OTG and HDMI5V.

The output voltages are configurable and are meant to supply power
to the main processor and other components.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 drivers/regulator/rk8xx-regulator.c | 139 ++++++++++++++++++++++++++++++++++--
 1 file changed, 134 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/rk8xx-regulator.c b/drivers/regulator/rk8xx-regulator.c
index 4a29726..57f2c72 100644
--- a/drivers/regulator/rk8xx-regulator.c
+++ b/drivers/regulator/rk8xx-regulator.c
@@ -6,6 +6,10 @@
  * Author: Chris Zhong <zyw@rock-chips.com>
  * Author: Zhang Qing <zhangqing@rock-chips.com>
  *
+ * Copyright (C) 2016 PHYTEC Messtechnik GmbH
+ *
+ * Author: Wadim Egorov <w.egorov@phytec.de>
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
  * version 2, as published by the Free Software Foundation.
@@ -32,6 +36,12 @@
 #define RK808_BUCK4_VSEL_MASK	0xf
 #define RK808_LDO_VSEL_MASK	0x1f
 
+#define RK818_BUCK_VSEL_MASK		0x3f
+#define RK818_BUCK4_VSEL_MASK		0x1f
+#define RK818_LDO_VSEL_MASK		0x1f
+#define RK818_LDO3_ON_VSEL_MASK		0xf
+#define RK818_BOOST_ON_VSEL_MASK	0xe0
+
 /* Ramp rate definitions for buck1 / buck2 only */
 #define RK808_RAMP_RATE_OFFSET		3
 #define RK808_RAMP_RATE_MASK		(3 << RK808_RAMP_RATE_OFFSET)
@@ -454,6 +464,108 @@ static const struct regulator_desc rk808_reg[] = {
 		RK808_DCDC_EN_REG, BIT(6)),
 };
 
+static const struct regulator_desc rk818_reg[] = {
+	{
+		.name = "DCDC_REG1",
+		.supply_name = "vcc1",
+		.of_match = of_match_ptr("DCDC_REG1"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = RK818_ID_DCDC1,
+		.ops = &rk808_reg_ops,
+		.type = REGULATOR_VOLTAGE,
+		.min_uV = 712500,
+		.uV_step = 12500,
+		.n_voltages = 64,
+		.vsel_reg = RK818_BUCK1_ON_VSEL_REG,
+		.vsel_mask = RK818_BUCK_VSEL_MASK,
+		.enable_reg = RK818_DCDC_EN_REG,
+		.enable_mask = BIT(0),
+		.owner = THIS_MODULE,
+	}, {
+		.name = "DCDC_REG2",
+		.supply_name = "vcc2",
+		.of_match = of_match_ptr("DCDC_REG2"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = RK818_ID_DCDC2,
+		.ops = &rk808_reg_ops,
+		.type = REGULATOR_VOLTAGE,
+		.min_uV = 712500,
+		.uV_step = 12500,
+		.n_voltages = 64,
+		.vsel_reg = RK818_BUCK2_ON_VSEL_REG,
+		.vsel_mask = RK818_BUCK_VSEL_MASK,
+		.enable_reg = RK818_DCDC_EN_REG,
+		.enable_mask = BIT(1),
+		.owner = THIS_MODULE,
+	}, {
+		.name = "DCDC_REG3",
+		.supply_name = "vcc3",
+		.of_match = of_match_ptr("DCDC_REG3"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = RK818_ID_DCDC3,
+		.ops = &rk808_switch_ops,
+		.type = REGULATOR_VOLTAGE,
+		.n_voltages = 1,
+		.enable_reg = RK818_DCDC_EN_REG,
+		.enable_mask = BIT(2),
+		.owner = THIS_MODULE,
+	},
+	RK8XX_DESC(RK818_ID_DCDC4, "DCDC_REG4", "vcc4", 1800, 3600, 100,
+		RK818_BUCK4_ON_VSEL_REG, RK818_BUCK4_VSEL_MASK,
+		RK818_DCDC_EN_REG, BIT(3), 0),
+	RK8XX_DESC(RK818_ID_BOOST, "DCDC_BOOST", "boost", 4700, 5400, 100,
+		RK818_BOOST_LDO9_ON_VSEL_REG, RK818_BOOST_ON_VSEL_MASK,
+		RK818_DCDC_EN_REG, BIT(4), 0),
+	RK8XX_DESC(RK818_ID_LDO1, "LDO_REG1", "vcc6", 1800, 3400, 100,
+		RK818_LDO1_ON_VSEL_REG, RK818_LDO_VSEL_MASK, RK818_LDO_EN_REG,
+		BIT(0), 400),
+	RK8XX_DESC(RK818_ID_LDO2, "LDO_REG2", "vcc6", 1800, 3400, 100,
+		RK818_LDO1_ON_VSEL_REG, RK818_LDO_VSEL_MASK, RK818_LDO_EN_REG,
+		BIT(1), 400),
+	{
+		.name = "LDO_REG3",
+		.supply_name = "vcc7",
+		.of_match = of_match_ptr("LDO_REG3"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = RK818_ID_LDO3,
+		.ops = &rk808_reg_ops_ranges,
+		.type = REGULATOR_VOLTAGE,
+		.n_voltages = 16,
+		.linear_ranges = rk808_ldo3_voltage_ranges,
+		.n_linear_ranges = ARRAY_SIZE(rk808_ldo3_voltage_ranges),
+		.vsel_reg = RK818_LDO3_ON_VSEL_REG,
+		.vsel_mask = RK818_LDO3_ON_VSEL_MASK,
+		.enable_reg = RK818_LDO_EN_REG,
+		.enable_mask = BIT(2),
+		.enable_time = 400,
+		.owner = THIS_MODULE,
+	},
+	RK8XX_DESC(RK818_ID_LDO4, "LDO_REG4", "vcc8", 1800, 3400, 100,
+		RK818_LDO4_ON_VSEL_REG, RK818_LDO_VSEL_MASK, RK818_LDO_EN_REG,
+		BIT(3), 400),
+	RK8XX_DESC(RK818_ID_LDO5, "LDO_REG5", "vcc7", 1800, 3400, 100,
+		RK818_LDO5_ON_VSEL_REG, RK818_LDO_VSEL_MASK, RK818_LDO_EN_REG,
+		BIT(4), 400),
+	RK8XX_DESC(RK818_ID_LDO6, "LDO_REG6", "vcc8", 800, 2500, 100,
+		RK818_LDO6_ON_VSEL_REG, RK818_LDO_VSEL_MASK, RK818_LDO_EN_REG,
+		BIT(5), 400),
+	RK8XX_DESC(RK818_ID_LDO7, "LDO_REG7", "vcc7", 800, 2500, 100,
+		RK818_LDO7_ON_VSEL_REG, RK818_LDO_VSEL_MASK, RK818_LDO_EN_REG,
+		BIT(6), 400),
+	RK8XX_DESC(RK818_ID_LDO8, "LDO_REG8", "vcc8", 1800, 3400, 100,
+		RK818_LDO8_ON_VSEL_REG, RK818_LDO_VSEL_MASK, RK818_LDO_EN_REG,
+		BIT(7), 400),
+	RK8XX_DESC(RK818_ID_LDO9, "LDO_REG9", "vcc9", 1800, 3400, 100,
+		RK818_BOOST_LDO9_ON_VSEL_REG, RK818_LDO_VSEL_MASK,
+		RK818_DCDC_EN_REG, BIT(5), 400),
+	RK8XX_DESC_SWITCH(RK818_ID_SWITCH, "SWITCH_REG", "vcc9",
+		RK818_DCDC_EN_REG, BIT(6)),
+	RK8XX_DESC_SWITCH(RK818_ID_HDMI_SWITCH, "HDMI_SWITCH", "h_5v",
+		RK818_H5V_EN_REG, BIT(0)),
+	RK8XX_DESC_SWITCH(RK818_ID_OTG_SWITCH, "OTG_SWITCH", "usb",
+		RK818_DCDC_EN_REG, BIT(7)),
+};
+
 static int rk8xx_regulator_dt_parse_pdata(struct device *dev,
 				   struct device *client_dev,
 				   struct regmap *map,
@@ -499,7 +611,8 @@ static int rk8xx_regulator_probe(struct platform_device *pdev)
 	struct regulator_config config = {};
 	struct regulator_dev *rk8xx_rdev;
 	struct rk808_regulator_data *pdata;
-	int ret, i;
+	const struct regulator_desc *regulators;
+	int ret, i, nregulators;
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -512,14 +625,29 @@ static int rk8xx_regulator_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pdata);
 
+	switch (rk8xx->variant) {
+	case RK808_ID:
+		regulators = rk808_reg;
+		nregulators = RK808_NUM_REGULATORS;
+		break;
+	case RK818_ID:
+		regulators = rk818_reg;
+		nregulators = RK818_NUM_REGULATORS;
+		break;
+	default:
+		dev_err(&client->dev, "unsupported RK8XX ID %lu\n",
+			rk8xx->variant);
+		return -EINVAL;
+	}
+
 	config.dev = &client->dev;
 	config.driver_data = pdata;
 	config.regmap = rk8xx->regmap;
 
 	/* Instantiate the regulators */
-	for (i = 0; i < RK808_NUM_REGULATORS; i++) {
+	for (i = 0; i < nregulators; i++) {
 		rk8xx_rdev = devm_regulator_register(&pdev->dev,
-						     &rk808_reg[i], &config);
+						     &regulators[i], &config);
 		if (IS_ERR(rk8xx_rdev)) {
 			dev_err(&client->dev,
 				"failed to register %d regulator\n", i);
@@ -541,7 +669,8 @@ static struct platform_driver rk8xx_regulator_driver = {
 module_platform_driver(rk8xx_regulator_driver);
 
 MODULE_DESCRIPTION("regulator driver for the rk8xx series PMICs");
-MODULE_AUTHOR("Chris Zhong<zyw@rock-chips.com>");
-MODULE_AUTHOR("Zhang Qing<zhangqing@rock-chips.com>");
+MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
+MODULE_AUTHOR("Zhang Qing <zhangqing@rock-chips.com>");
+MODULE_AUTHOR("Wadim Egorov <w.egorov@phytec.de>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:rk8xx-regulator");
-- 
1.9.1
