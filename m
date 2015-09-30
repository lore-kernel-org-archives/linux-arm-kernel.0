From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 30 Sep 2015 14:39:46 +0800
Subject: [PATCH v2 2/3] regulator: axp20x: set supply names for AXP22X
 DC1SW/DC5LDO internally
In-Reply-To: <1443595188-1283-1-git-send-email-wens@csie.org>
References: <1443595188-1283-1-git-send-email-wens@csie.org>
Message-ID: <1443595188-1283-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DC1SW and DC5LDO regulators in the AXP22X are internally chained
to DCDC1 and DCDC5, hence the names. The original bindings used the
parent regulator names for the supply regulator property.

Since they are internally connected, the relationship should not be
represented in the device tree, but handled internally by the driver.

This patch has the driver remember the regulator names for the parent
DCDC1/DCDC5, and use them as supply names for DC1SW/DC5LDO.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/regulator/axp20x-regulator.c | 54 +++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index a9567af7cec0..35de22fdb7a0 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -196,10 +196,10 @@ static const struct regulator_desc axp22x_regulators[] = {
 	AXP_DESC(AXP22X, DCDC5, "dcdc5", "vin5", 1000, 2550, 50,
 		 AXP22X_DCDC5_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL1, BIT(5)),
 	/* secondary switchable output of DCDC1 */
-	AXP_DESC_SW(AXP22X, DC1SW, "dc1sw", "dcdc1", 1600, 3400, 100,
+	AXP_DESC_SW(AXP22X, DC1SW, "dc1sw", NULL, 1600, 3400, 100,
 		    AXP22X_DCDC1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(7)),
 	/* LDO regulator internally chained to DCDC5 */
-	AXP_DESC(AXP22X, DC5LDO, "dc5ldo", "dcdc5", 700, 1400, 100,
+	AXP_DESC(AXP22X, DC5LDO, "dc5ldo", NULL, 700, 1400, 100,
 		 AXP22X_DC5LDO_V_OUT, 0x7, AXP22X_PWR_OUT_CTRL1, BIT(0)),
 	AXP_DESC(AXP22X, ALDO1, "aldo1", "aldoin", 700, 3300, 100,
 		 AXP22X_ALDO1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL1, BIT(6)),
@@ -350,6 +350,8 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 	};
 	int ret, i, nregulators;
 	u32 workmode;
+	const char *axp22x_dc1_name = axp22x_regulators[AXP22X_DCDC1].name;
+	const char *axp22x_dc5_name = axp22x_regulators[AXP22X_DCDC5].name;
 
 	switch (axp20x->variant) {
 	case AXP202_ID:
@@ -371,8 +373,37 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 	axp20x_regulator_parse_dt(pdev);
 
 	for (i = 0; i < nregulators; i++) {
-		rdev = devm_regulator_register(&pdev->dev, &regulators[i],
-					       &config);
+		const struct regulator_desc *desc = &regulators[i];
+		struct regulator_desc *new_desc;
+
+		/*
+		 * Regulators DC1SW and DC5LDO are connected internally,
+		 * so we have to handle their supply names separately.
+		 *
+		 * We always register the regulators in proper sequence,
+		 * so the supply names are correctly read. See the last
+		 * part of this loop to see where we save the DT defined
+		 * name.
+		 */
+		if (regulators == axp22x_regulators) {
+			if (i == AXP22X_DC1SW) {
+				new_desc = devm_kzalloc(&pdev->dev,
+							sizeof(*desc),
+							GFP_KERNEL);
+				*new_desc = regulators[i];
+				new_desc->supply_name = axp22x_dc1_name;
+				desc = new_desc;
+			} else if (i == AXP22X_DC5LDO) {
+				new_desc = devm_kzalloc(&pdev->dev,
+							sizeof(*desc),
+							GFP_KERNEL);
+				*new_desc = regulators[i];
+				new_desc->supply_name = axp22x_dc5_name;
+				desc = new_desc;
+			}
+		}
+
+		rdev = devm_regulator_register(&pdev->dev, desc, &config);
 		if (IS_ERR(rdev)) {
 			dev_err(&pdev->dev, "Failed to register %s\n",
 				regulators[i].name);
@@ -388,6 +419,21 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 				dev_err(&pdev->dev, "Failed to set workmode on %s\n",
 					rdev->desc->name);
 		}
+
+		/*
+		 * Save AXP22X DCDC1 / DCDC5 regulator names for later.
+		 */
+		if (regulators == axp22x_regulators) {
+			/* Can we use rdev->constraints->name instead? */
+			if (i == AXP22X_DCDC1)
+				of_property_read_string(rdev->dev.of_node,
+							"regulator-name",
+							&axp22x_dc1_name);
+			else if (i == AXP22X_DCDC5)
+				of_property_read_string(rdev->dev.of_node,
+							"regulator-name",
+							&axp22x_dc5_name);
+		}
 	}
 
 	return 0;
-- 
2.5.3
