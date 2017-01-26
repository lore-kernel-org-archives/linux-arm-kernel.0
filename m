From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Thu, 26 Jan 2017 22:26:39 +0100 (CET)
Subject: [PATCH 4/5] regulator: axp20x: Add support for the AXP808 PMIC
In-Reply-To: <cover.1485456003.git.rask@formelder.dk>
References: <cover.1485456003.git.rask@formelder.dk>
Message-ID: <8c2849be991beef08db2b6560938d16e9cd7758d.1485456006.git.rask@formelder.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The regulators are the same as on the AXP806.

Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
---
 drivers/regulator/axp20x-regulator.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index a3ade9e..034dce8 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -370,6 +370,7 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 		step = 75;
 		break;
 	case AXP806_ID:
+	case AXP808_ID:
 		/*
 		 * AXP806 DCDC work frequency setting has the same range and
 		 * step as AXP22X, but at a different register.
@@ -459,6 +460,7 @@ static int axp20x_set_dcdc_workmode(struct regulator_dev *rdev, int id, u32 work
 		break;
 
 	case AXP806_ID:
+	case AXP808_ID:
 		reg = AXP806_DCDC_MODE_CTRL2;
 		/*
 		 * AXP806 DCDC regulator IDs have the same range as AXP22X.
@@ -492,8 +494,8 @@ static bool axp20x_is_polyphase_slave(struct axp20x_dev *axp20x, int id)
 {
 	u32 reg = 0;
 
-	/* Only AXP806 has poly-phase outputs */
-	if (axp20x->variant != AXP806_ID)
+	/* Only AXP806 and AXP808 have poly-phase outputs */
+	if (axp20x->variant != AXP806_ID && axp20x->variant != AXP808_ID)
 		return false;
 
 	regmap_read(axp20x->regmap, AXP806_DCDC_MODE_CTRL2, &reg);
@@ -541,6 +543,7 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 						  "x-powers,drive-vbus-en");
 		break;
 	case AXP806_ID:
+	case AXP808_ID:
 		regulators = axp806_regulators;
 		nregulators = AXP806_REG_ID_MAX;
 		break;
-- 
2.10.2
