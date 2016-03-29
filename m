From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 29 Mar 2016 17:22:27 +0800
Subject: [PATCH resend v2 4/9] regulator: axp20x: support AXP809 variant
In-Reply-To: <1459243352-23344-1-git-send-email-wens@csie.org>
References: <1459243352-23344-1-git-send-email-wens@csie.org>
Message-ID: <1459243352-23344-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The X-Powers AXP809 PMIC has a similar set of regulators as the AXP221,
though a few LDOs were removed, and a new switch output added. Like the
AXP221, AXP809 also has DC1SW and DC5LDO, which are internally chained
to DCDC1 and DCDC5, respectively.

Add support for this new variant. Also remove the "axp22x_" prefix from
DC1SW/DC5LDO supply handling code, as the AXP809 uses it as well.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/regulator/axp20x-regulator.c | 119 ++++++++++++++++++++++++++---------
 1 file changed, 90 insertions(+), 29 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 40cd894e4df5..6a601f377019 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -224,6 +224,61 @@ static const struct regulator_desc axp22x_regulators[] = {
 	AXP_DESC_FIXED(AXP22X, RTC_LDO, "rtc_ldo", "ips", 3000),
 };
 
+static const struct regulator_linear_range axp809_dcdc4_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0x0, 0x2f, 20000),
+	REGULATOR_LINEAR_RANGE(1800000, 0x30, 0x38, 100000),
+};
+
+static const struct regulator_linear_range axp809_dldo1_ranges[] = {
+	REGULATOR_LINEAR_RANGE(700000, 0x0, 0x1a, 100000),
+	REGULATOR_LINEAR_RANGE(3400000, 0x1b, 0x1f, 200000),
+};
+
+static const struct regulator_desc axp809_regulators[] = {
+	AXP_DESC(AXP809, DCDC1, "dcdc1", "vin1", 1600, 3400, 100,
+		 AXP22X_DCDC1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL1, BIT(1)),
+	AXP_DESC(AXP809, DCDC2, "dcdc2", "vin2", 600, 1540, 20,
+		 AXP22X_DCDC2_V_OUT, 0x3f, AXP22X_PWR_OUT_CTRL1, BIT(2)),
+	AXP_DESC(AXP809, DCDC3, "dcdc3", "vin3", 600, 1860, 20,
+		 AXP22X_DCDC3_V_OUT, 0x3f, AXP22X_PWR_OUT_CTRL1, BIT(3)),
+	AXP_DESC_RANGES(AXP809, DCDC4, "dcdc4", "vin4", axp809_dcdc4_ranges,
+			57, AXP22X_DCDC4_V_OUT, 0x3f, AXP22X_PWR_OUT_CTRL1,
+			BIT(4)),
+	AXP_DESC(AXP809, DCDC5, "dcdc5", "vin5", 1000, 2550, 50,
+		 AXP22X_DCDC5_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL1, BIT(5)),
+	/* secondary switchable output of DCDC1 */
+	AXP_DESC_SW(AXP809, DC1SW, "dc1sw", NULL, AXP22X_PWR_OUT_CTRL2,
+		    BIT(7)),
+	/* LDO regulator internally chained to DCDC5 */
+	AXP_DESC(AXP809, DC5LDO, "dc5ldo", NULL, 700, 1400, 100,
+		 AXP22X_DC5LDO_V_OUT, 0x7, AXP22X_PWR_OUT_CTRL1, BIT(0)),
+	AXP_DESC(AXP809, ALDO1, "aldo1", "aldoin", 700, 3300, 100,
+		 AXP22X_ALDO1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL1, BIT(6)),
+	AXP_DESC(AXP809, ALDO2, "aldo2", "aldoin", 700, 3300, 100,
+		 AXP22X_ALDO2_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL1, BIT(7)),
+	AXP_DESC(AXP809, ALDO3, "aldo3", "aldoin", 700, 3300, 100,
+		 AXP22X_ALDO3_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(5)),
+	AXP_DESC_RANGES(AXP809, DLDO1, "dldo1", "dldoin", axp809_dldo1_ranges,
+			32, AXP22X_DLDO1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2,
+			BIT(3)),
+	AXP_DESC(AXP809, DLDO2, "dldo2", "dldoin", 700, 3300, 100,
+		 AXP22X_DLDO2_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(4)),
+	AXP_DESC(AXP809, ELDO1, "eldo1", "eldoin", 700, 3300, 100,
+		 AXP22X_ELDO1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(0)),
+	AXP_DESC(AXP809, ELDO2, "eldo2", "eldoin", 700, 3300, 100,
+		 AXP22X_ELDO2_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(1)),
+	AXP_DESC(AXP809, ELDO3, "eldo3", "eldoin", 700, 3300, 100,
+		 AXP22X_ELDO3_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(2)),
+	AXP_DESC_IO(AXP809, LDO_IO0, "ldo_io0", "ips", 700, 3300, 100,
+		    AXP22X_LDO_IO0_V_OUT, 0x1f, AXP20X_GPIO0_CTRL, 0x07,
+		    AXP22X_IO_ENABLED, AXP22X_IO_DISABLED),
+	AXP_DESC_IO(AXP809, LDO_IO1, "ldo_io1", "ips", 700, 3300, 100,
+		    AXP22X_LDO_IO1_V_OUT, 0x1f, AXP20X_GPIO1_CTRL, 0x07,
+		    AXP22X_IO_ENABLED, AXP22X_IO_DISABLED),
+	AXP_DESC_FIXED(AXP809, RTC_LDO, "rtc_ldo", "ips", 1800),
+	AXP_DESC_SW(AXP809, SW, "sw", "swin", AXP22X_PWR_OUT_CTRL2, BIT(6)),
+};
+
 static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 {
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
@@ -239,6 +294,7 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 		break;
 	case AXP221_ID:
 	case AXP223_ID:
+	case AXP809_ID:
 		min = 1800;
 		max = 4050;
 		def = 3000;
@@ -318,6 +374,7 @@ static int axp20x_set_dcdc_workmode(struct regulator_dev *rdev, int id, u32 work
 
 	case AXP221_ID:
 	case AXP223_ID:
+	case AXP809_ID:
 		if (id < AXP22X_DCDC1 || id > AXP22X_DCDC5)
 			return -EINVAL;
 
@@ -346,8 +403,8 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 	};
 	int ret, i, nregulators;
 	u32 workmode;
-	const char *axp22x_dc1_name = axp22x_regulators[AXP22X_DCDC1].name;
-	const char *axp22x_dc5_name = axp22x_regulators[AXP22X_DCDC5].name;
+	const char *dcdc1_name = axp22x_regulators[AXP22X_DCDC1].name;
+	const char *dcdc5_name = axp22x_regulators[AXP22X_DCDC5].name;
 
 	switch (axp20x->variant) {
 	case AXP202_ID:
@@ -360,6 +417,10 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		regulators = axp22x_regulators;
 		nregulators = AXP22X_REG_ID_MAX;
 		break;
+	case AXP809_ID:
+		regulators = axp809_regulators;
+		nregulators = AXP809_REG_ID_MAX;
+		break;
 	default:
 		dev_err(&pdev->dev, "Unsupported AXP variant: %ld\n",
 			axp20x->variant);
@@ -382,22 +443,22 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		 * part of this loop to see where we save the DT defined
 		 * name.
 		 */
-		if (regulators == axp22x_regulators) {
-			if (i == AXP22X_DC1SW) {
-				new_desc = devm_kzalloc(&pdev->dev,
-							sizeof(*desc),
-							GFP_KERNEL);
-				*new_desc = regulators[i];
-				new_desc->supply_name = axp22x_dc1_name;
-				desc = new_desc;
-			} else if (i == AXP22X_DC5LDO) {
-				new_desc = devm_kzalloc(&pdev->dev,
-							sizeof(*desc),
-							GFP_KERNEL);
-				*new_desc = regulators[i];
-				new_desc->supply_name = axp22x_dc5_name;
-				desc = new_desc;
-			}
+		if ((regulators == axp22x_regulators && i == AXP22X_DC1SW) ||
+		    (regulators == axp809_regulators && i == AXP809_DC1SW)) {
+			new_desc = devm_kzalloc(&pdev->dev, sizeof(*desc),
+						GFP_KERNEL);
+			*new_desc = regulators[i];
+			new_desc->supply_name = dcdc1_name;
+			desc = new_desc;
+		}
+
+		if ((regulators == axp22x_regulators && i == AXP22X_DC5LDO) ||
+		    (regulators == axp809_regulators && i == AXP809_DC5LDO)) {
+			new_desc = devm_kzalloc(&pdev->dev, sizeof(*desc),
+						GFP_KERNEL);
+			*new_desc = regulators[i];
+			new_desc->supply_name = dcdc5_name;
+			desc = new_desc;
 		}
 
 		rdev = devm_regulator_register(&pdev->dev, desc, &config);
@@ -420,17 +481,17 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		/*
 		 * Save AXP22X DCDC1 / DCDC5 regulator names for later.
 		 */
-		if (regulators == axp22x_regulators) {
-			/* Can we use rdev->constraints->name instead? */
-			if (i == AXP22X_DCDC1)
-				of_property_read_string(rdev->dev.of_node,
-							"regulator-name",
-							&axp22x_dc1_name);
-			else if (i == AXP22X_DCDC5)
-				of_property_read_string(rdev->dev.of_node,
-							"regulator-name",
-							&axp22x_dc5_name);
-		}
+		if ((regulators == axp22x_regulators && i == AXP22X_DCDC1) ||
+		    (regulators == axp809_regulators && i == AXP809_DCDC1))
+			of_property_read_string(rdev->dev.of_node,
+						"regulator-name",
+						&dcdc1_name);
+
+		if ((regulators == axp22x_regulators && i == AXP22X_DCDC5) ||
+		    (regulators == axp809_regulators && i == AXP809_DCDC5))
+			of_property_read_string(rdev->dev.of_node,
+						"regulator-name",
+						&dcdc5_name);
 	}
 
 	return 0;
-- 
2.7.0
