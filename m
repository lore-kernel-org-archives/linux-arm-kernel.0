From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed,  5 Apr 2017 02:01:41 +0800
Subject: [PATCH 07/11] regulator: axp20x-regulator: add support for AXP803
In-Reply-To: <20170404180145.12897-1-icenowy@aosc.io>
References: <20170404180145.12897-1-icenowy@aosc.io>
Message-ID: <20170404180145.12897-8-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AXP803 PMIC also have a series of regulators (DCDCs and LDOs)
controllable via I2C/RSB bus.

Add support for them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/regulator/axp20x-regulator.c | 135 +++++++++++++++++++++++++++++++----
 include/linux/mfd/axp20x.h           |  37 ++++++++++
 2 files changed, 158 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 0b9d4e3e52c7..219a731df392 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -355,6 +355,81 @@ static const struct regulator_desc axp809_regulators[] = {
 	AXP_DESC_SW(AXP809, SW, "sw", "swin", AXP22X_PWR_OUT_CTRL2, BIT(6)),
 };
 
+static const struct regulator_linear_range axp803_dcdc234_ranges[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0x0, 0x46, 10000),
+	REGULATOR_LINEAR_RANGE(1200000, 0x47, 0x4b, 20000),
+};
+
+static const struct regulator_linear_range axp803_dcdc5_ranges[] = {
+	REGULATOR_LINEAR_RANGE(800000, 0x0, 0x20, 10000),
+	REGULATOR_LINEAR_RANGE(1140000, 0x21, 0x43, 20000),
+};
+
+static const struct regulator_linear_range axp803_dcdc6_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0x0, 0x32, 10000),
+	REGULATOR_LINEAR_RANGE(1120000, 0x33, 0x47, 20000),
+};
+
+static const struct regulator_linear_range axp803_dldo2_ranges[] = {
+	REGULATOR_LINEAR_RANGE(700000, 0x0, 0x1a, 100000),
+	REGULATOR_LINEAR_RANGE(3400000, 0x1b, 0x1f, 200000),
+};
+
+static const struct regulator_desc axp803_regulators[] = {
+	AXP_DESC(AXP803, DCDC1, "dcdc1", "vin1", 1600, 3400, 100,
+		 AXP803_DCDC1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL1, BIT(0)),
+	AXP_DESC_RANGES(AXP803, DCDC2, "dcdc2", "vin2", axp803_dcdc234_ranges,
+			76, AXP803_DCDC2_V_OUT, 0x7f, AXP22X_PWR_OUT_CTRL1,
+			BIT(1)),
+	AXP_DESC_RANGES(AXP803, DCDC3, "dcdc3", "vin3", axp803_dcdc234_ranges,
+			76, AXP803_DCDC3_V_OUT, 0x7f, AXP22X_PWR_OUT_CTRL1,
+			BIT(2)),
+	AXP_DESC_RANGES(AXP803, DCDC4, "dcdc4", "vin4", axp803_dcdc234_ranges,
+			76, AXP803_DCDC4_V_OUT, 0x7f, AXP22X_PWR_OUT_CTRL1,
+			BIT(3)),
+	AXP_DESC_RANGES(AXP803, DCDC5, "dcdc5", "vin5", axp803_dcdc5_ranges,
+			68, AXP803_DCDC5_V_OUT, 0x7f, AXP22X_PWR_OUT_CTRL1,
+			BIT(4)),
+	AXP_DESC_RANGES(AXP803, DCDC6, "dcdc6", "vin6", axp803_dcdc6_ranges,
+			72, AXP803_DCDC6_V_OUT, 0x7f, AXP22X_PWR_OUT_CTRL1,
+			BIT(5)),
+	/* secondary switchable output of DCDC1 */
+	AXP_DESC_SW(AXP803, DC1SW, "dc1sw", NULL, AXP22X_PWR_OUT_CTRL2,
+		    BIT(7)),
+	AXP_DESC(AXP803, ALDO1, "aldo1", "aldoin", 700, 3300, 100,
+		 AXP22X_ALDO1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL3, BIT(5)),
+	AXP_DESC(AXP803, ALDO2, "aldo2", "aldoin", 700, 3300, 100,
+		 AXP22X_ALDO2_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL3, BIT(6)),
+	AXP_DESC(AXP803, ALDO3, "aldo3", "aldoin", 700, 3300, 100,
+		 AXP22X_ALDO3_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL3, BIT(7)),
+	AXP_DESC(AXP803, DLDO1, "dldo1", "dldoin", 700, 3300, 100,
+		 AXP22X_DLDO1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(3)),
+	AXP_DESC_RANGES(AXP803, DLDO2, "dldo2", "dldoin", axp803_dldo2_ranges,
+			32, AXP22X_DLDO2_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2,
+			BIT(4)),
+	AXP_DESC(AXP803, DLDO3, "dldo3", "dldoin", 700, 3300, 100,
+		 AXP22X_DLDO3_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL3, BIT(5)),
+	AXP_DESC(AXP803, DLDO4, "dldo4", "dldoin", 700, 3300, 100,
+		 AXP22X_DLDO4_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL3, BIT(6)),
+	AXP_DESC(AXP803, ELDO1, "eldo1", "eldoin", 700, 1900, 50,
+		 AXP22X_ELDO1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(0)),
+	AXP_DESC(AXP803, ELDO2, "eldo2", "eldoin", 700, 1900, 50,
+		 AXP22X_ELDO2_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(1)),
+	AXP_DESC(AXP803, ELDO3, "eldo3", "eldoin", 700, 1900, 50,
+		 AXP22X_ELDO3_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(2)),
+	AXP_DESC(AXP803, FLDO1, "fldo1", "fldoin", 700, 1450, 50,
+		 AXP803_FLDO1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL3, BIT(2)),
+	AXP_DESC(AXP803, FLDO2, "fldo2", "fldoin", 700, 1450, 50,
+		 AXP803_FLDO2_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL3, BIT(3)),
+	AXP_DESC_IO(AXP803, LDO_IO0, "ldo_io0", "ips", 700, 3300, 100,
+		    AXP22X_LDO_IO0_V_OUT, 0x1f, AXP20X_GPIO0_CTRL, 0x07,
+		    AXP22X_IO_ENABLED, AXP22X_IO_DISABLED),
+	AXP_DESC_IO(AXP803, LDO_IO1, "ldo_io1", "ips", 700, 3300, 100,
+		    AXP22X_LDO_IO1_V_OUT, 0x1f, AXP20X_GPIO1_CTRL, 0x07,
+		    AXP22X_IO_ENABLED, AXP22X_IO_DISABLED),
+	AXP_DESC_FIXED(AXP803, RTC_LDO, "rtc_ldo", "ips", 3000),
+};
+
 static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 {
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
@@ -377,6 +452,13 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 		 * (See include/linux/mfd/axp20x.h)
 		 */
 		reg = AXP806_DCDC_FREQ_CTRL;
+	case AXP803_ID:
+		/*
+		 * AXP803 also have DCDC work frequency setting register at a
+		 * different position.
+		 */
+		if (axp20x->variant == AXP803_ID)
+			reg = AXP803_DCDC_FREQ_CTRL;
 	case AXP221_ID:
 	case AXP223_ID:
 	case AXP809_ID:
@@ -474,7 +556,13 @@ static int axp20x_set_dcdc_workmode(struct regulator_dev *rdev, int id, u32 work
 		mask = AXP22X_WORKMODE_DCDCX_MASK(id - AXP22X_DCDC1);
 		workmode <<= id - AXP22X_DCDC1;
 		break;
+	case AXP803_ID:
+		if (id < AXP803_DCDC1 || id > AXP803_DCDC6)
+			return -EINVAL;
 
+		mask = AXP22X_WORKMODE_DCDCX_MASK(id - AXP803_DCDC1);
+		workmode <<= id - AXP803_DCDC1;
+		break;
 	default:
 		/* should not happen */
 		WARN_ON(1);
@@ -492,20 +580,34 @@ static bool axp20x_is_polyphase_slave(struct axp20x_dev *axp20x, int id)
 {
 	u32 reg = 0;
 
-	/* Only AXP806 has poly-phase outputs */
-	if (axp20x->variant != AXP806_ID)
+	/*
+	 * Currently in our supported AXP variants, only AXP806 and AXP803
+	 * have polyphase regulators.
+	 */
+	switch (axp20x->variant) {
+	case AXP806_ID:
+		regmap_read(axp20x->regmap, AXP806_DCDC_MODE_CTRL2, &reg);
+
+		switch (id) {
+		case AXP806_DCDCB:
+			return (((reg & GENMASK(7, 6)) == BIT(6)) ||
+				((reg & GENMASK(7, 6)) == BIT(7)));
+		case AXP806_DCDCC:
+			return ((reg & GENMASK(7, 6)) == BIT(7));
+		case AXP806_DCDCE:
+			return !!(reg & BIT(5));
+		}
+	case AXP803_ID:
+		regmap_read(axp20x->regmap, AXP803_POLYPHASE_CTRL, &reg);
+
+		switch (id) {
+		case AXP803_DCDC3:
+			return !!(reg & BIT(6));
+		case AXP803_DCDC6:
+			return !!(reg & BIT(7));
+		}
+	default:
 		return false;
-
-	regmap_read(axp20x->regmap, AXP806_DCDC_MODE_CTRL2, &reg);
-
-	switch (id) {
-	case AXP806_DCDCB:
-		return (((reg & GENMASK(7, 6)) == BIT(6)) ||
-			((reg & GENMASK(7, 6)) == BIT(7)));
-	case AXP806_DCDCC:
-		return ((reg & GENMASK(7, 6)) == BIT(7));
-	case AXP806_DCDCE:
-		return !!(reg & BIT(5));
 	}
 
 	return false;
@@ -548,6 +650,10 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		regulators = axp809_regulators;
 		nregulators = AXP809_REG_ID_MAX;
 		break;
+	case AXP803_ID:
+		regulators = axp803_regulators;
+		nregulators = AXP803_REG_ID_MAX;
+		break;
 	default:
 		dev_err(&pdev->dev, "Unsupported AXP variant: %ld\n",
 			axp20x->variant);
@@ -579,7 +685,8 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		 * name.
 		 */
 		if ((regulators == axp22x_regulators && i == AXP22X_DC1SW) ||
-		    (regulators == axp809_regulators && i == AXP809_DC1SW)) {
+		    (regulators == axp809_regulators && i == AXP809_DC1SW) ||
+		    (regulators == axp803_regulators && i == AXP803_DC1SW)) {
 			new_desc = devm_kzalloc(&pdev->dev, sizeof(*desc),
 						GFP_KERNEL);
 			*new_desc = regulators[i];
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index b3220ef374d3..858d5b1b43b9 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -119,6 +119,17 @@ enum axp20x_variants {
 #define AXP806_BUS_ADDR_EXT		0xfe
 #define AXP806_REG_ADDR_EXT		0xff
 
+#define AXP803_POLYPHASE_CTRL		0x14
+#define AXP803_FLDO1_V_OUT		0x1c
+#define AXP803_FLDO2_V_OUT		0x1d
+#define AXP803_DCDC1_V_OUT		0x20
+#define AXP803_DCDC2_V_OUT		0x21
+#define AXP803_DCDC3_V_OUT		0x22
+#define AXP803_DCDC4_V_OUT		0x23
+#define AXP803_DCDC5_V_OUT		0x24
+#define AXP803_DCDC6_V_OUT		0x25
+#define AXP803_DCDC_FREQ_CTRL		0x3b
+
 /* Interrupt */
 #define AXP152_IRQ1_EN			0x40
 #define AXP152_IRQ2_EN			0x41
@@ -350,6 +361,32 @@ enum {
 	AXP809_REG_ID_MAX,
 };
 
+enum {
+	AXP803_DCDC1 = 0,
+	AXP803_DCDC2,
+	AXP803_DCDC3,
+	AXP803_DCDC4,
+	AXP803_DCDC5,
+	AXP803_DCDC6,
+	AXP803_DC1SW,
+	AXP803_ALDO1,
+	AXP803_ALDO2,
+	AXP803_ALDO3,
+	AXP803_DLDO1,
+	AXP803_DLDO2,
+	AXP803_DLDO3,
+	AXP803_DLDO4,
+	AXP803_ELDO1,
+	AXP803_ELDO2,
+	AXP803_ELDO3,
+	AXP803_FLDO1,
+	AXP803_FLDO2,
+	AXP803_RTC_LDO,
+	AXP803_LDO_IO0,
+	AXP803_LDO_IO1,
+	AXP803_REG_ID_MAX,
+};
+
 /* IRQs */
 enum {
 	AXP152_IRQ_LDO0IN_CONNECT = 1,
-- 
2.12.2
