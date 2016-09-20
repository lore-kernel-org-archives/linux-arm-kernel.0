From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 20 Sep 2016 18:09:40 +0200
Subject: [PATCH 1/3] regulator: axp20x: simplify poly-phase handling
In-Reply-To: <cover.1474616699.git.moinejf@free.fr>
References: <cover.1474616699.git.moinejf@free.fr>
Message-ID: <098a013d31924dfd6dff81927a70e91381b1f8d3.1474616699.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building a list (bitmap) of the slaves included in poly-phase groups
at probe startup time simplifies the treatment in the regulator
creation loop.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/regulator/axp20x-regulator.c | 45 +++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 54382ef..4e5e7c8 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -477,30 +477,24 @@ static int axp20x_set_dcdc_workmode(struct regulator_dev *rdev, int id, u32 work
 }
 
 /*
- * This function checks whether a regulator is part of a poly-phase
- * output setup based on the registers settings. Returns true if it is.
+ * This function checks which regulators are part of poly-phase
+ * output setups based on the registers settings.
+ * Returns a bitmap of these regulators.
  */
-static bool axp20x_is_polyphase_slave(struct axp20x_dev *axp20x, int id)
+static u32 axp20x_polyphase_slave(struct axp20x_dev *axp20x)
 {
-	u32 reg = 0;
-
-	/* Only AXP806 has poly-phase outputs */
-	if (axp20x->variant != AXP806_ID)
-		return false;
+	u32 reg = 0, bitmap = 0;
 
 	regmap_read(axp20x->regmap, AXP806_DCDC_MODE_CTRL2, &reg);
 
-	switch (id) {
-	case AXP806_DCDCB:
-		return (((reg & GENMASK(7, 6)) == BIT(6)) ||
-			((reg & GENMASK(7, 6)) == BIT(7)));
-	case AXP806_DCDCC:
-		return ((reg & GENMASK(7, 6)) == BIT(7));
-	case AXP806_DCDCE:
-		return !!(reg & BIT(5));
-	}
+	if ((reg & GENMASK(7, 6)) == BIT(5))
+		bitmap |= 1 << AXP806_DCDCE;
+	if ((reg & GENMASK(7, 6)) == BIT(6))
+		bitmap |= 1 << AXP806_DCDCB;
+	if ((reg & GENMASK(7, 6)) == BIT(7))
+		bitmap |= (1 << AXP806_DCDCB) | (1 << AXP806_DCDCC);
 
-	return false;
+	return bitmap;
 }
 
 static int axp20x_regulator_probe(struct platform_device *pdev)
@@ -518,6 +512,7 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 	const char *dcdc1_name = axp22x_regulators[AXP22X_DCDC1].name;
 	const char *dcdc5_name = axp22x_regulators[AXP22X_DCDC5].name;
 	bool drivevbus = false;
+	u32 skip_bitmap = 0;
 
 	switch (axp20x->variant) {
 	case AXP202_ID:
@@ -535,6 +530,13 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 	case AXP806_ID:
 		regulators = axp806_regulators;
 		nregulators = AXP806_REG_ID_MAX;
+
+		/*
+		 * The regulators which are slave in a poly-phase setup
+		 * are skipped, as their controls are bound to the master
+		 * regulator and won't work.
+		 */
+		skip_bitmap |= axp20x_polyphase_slave(axp20x);
 		break;
 	case AXP809_ID:
 		regulators = axp809_regulators;
@@ -553,12 +555,7 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		const struct regulator_desc *desc = &regulators[i];
 		struct regulator_desc *new_desc;
 
-		/*
-		 * If this regulator is a slave in a poly-phase setup,
-		 * skip it, as its controls are bound to the master
-		 * regulator and won't work.
-		 */
-		if (axp20x_is_polyphase_slave(axp20x, i))
+		if (skip_bitmap & (1 << i))
 			continue;
 
 		/*
-- 
2.10.0
