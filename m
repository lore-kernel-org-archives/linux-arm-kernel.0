From: broonie@kernel.org (Mark Brown)
Date: Wed, 04 Oct 2017 12:29:04 +0100
Subject: Applied "regulator: axp20x: Add support for AXP813 regulators" to the
 regulator tree
In-Reply-To: <20170929032514.31727-3-wens@csie.org>
Message-ID: <E1dzhrM-0004VW-LO@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: axp20x: Add support for AXP813 regulators

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d81851c1764b26b46670c0b3bd6701308ddaab98 Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 29 Sep 2017 11:25:09 +0800
Subject: [PATCH] regulator: axp20x: Add support for AXP813 regulators

The AXP813 PMIC has 7 DC-DC buck regulators, 16 LDOs (including the
fixed RTC LDO and 2 GPIO LDOs), and 1 switchable. The drive-vbus
feature is also supported. All the hardware details are very similar
to the AXP803, with the following exceptions:

  - Extra DCDC7 buck regulator, with the same range as DCDC6

  - SWitch now has a separate supply pin, instead of being chained
    internaly from DCDC1

  - RTC LDO output voltage is now 1.8V

  - FLDO3 is an LDO with switchable supplies, but unconfigurable output
    voltage. The voltage is always half that of its supply.

Support for FLDO3 is currently unimplemented, as it requires runtime
switching of its supplies, something the regulator subsystem does not
support. It is not used in either the reference designs nor actually
produced boards available.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/axp20x-regulator.c | 102 +++++++++++++++++++++++++++++++++--
 include/linux/mfd/axp20x.h           |   3 ++
 2 files changed, 101 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 376a99b7cf5d..e1761df4cbfd 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -244,6 +244,7 @@ static const struct regulator_desc axp22x_drivevbus_regulator = {
 	.ops		= &axp20x_ops_sw,
 };
 
+/* DCDC ranges shared with AXP813 */
 static const struct regulator_linear_range axp803_dcdc234_ranges[] = {
 	REGULATOR_LINEAR_RANGE(500000, 0x0, 0x46, 10000),
 	REGULATOR_LINEAR_RANGE(1220000, 0x47, 0x4b, 20000),
@@ -426,6 +427,69 @@ static const struct regulator_desc axp809_regulators[] = {
 	AXP_DESC_SW(AXP809, SW, "sw", "swin", AXP22X_PWR_OUT_CTRL2, BIT(6)),
 };
 
+static const struct regulator_desc axp813_regulators[] = {
+	AXP_DESC(AXP813, DCDC1, "dcdc1", "vin1", 1600, 3400, 100,
+		 AXP803_DCDC1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL1, BIT(0)),
+	AXP_DESC_RANGES(AXP813, DCDC2, "dcdc2", "vin2", axp803_dcdc234_ranges,
+			76, AXP803_DCDC2_V_OUT, 0x7f, AXP22X_PWR_OUT_CTRL1,
+			BIT(1)),
+	AXP_DESC_RANGES(AXP813, DCDC3, "dcdc3", "vin3", axp803_dcdc234_ranges,
+			76, AXP803_DCDC3_V_OUT, 0x7f, AXP22X_PWR_OUT_CTRL1,
+			BIT(2)),
+	AXP_DESC_RANGES(AXP813, DCDC4, "dcdc4", "vin4", axp803_dcdc234_ranges,
+			76, AXP803_DCDC4_V_OUT, 0x7f, AXP22X_PWR_OUT_CTRL1,
+			BIT(3)),
+	AXP_DESC_RANGES(AXP813, DCDC5, "dcdc5", "vin5", axp803_dcdc5_ranges,
+			68, AXP803_DCDC5_V_OUT, 0x7f, AXP22X_PWR_OUT_CTRL1,
+			BIT(4)),
+	AXP_DESC_RANGES(AXP813, DCDC6, "dcdc6", "vin6", axp803_dcdc6_ranges,
+			72, AXP803_DCDC6_V_OUT, 0x7f, AXP22X_PWR_OUT_CTRL1,
+			BIT(5)),
+	AXP_DESC_RANGES(AXP813, DCDC7, "dcdc7", "vin7", axp803_dcdc6_ranges,
+			72, AXP813_DCDC7_V_OUT, 0x7f, AXP22X_PWR_OUT_CTRL1,
+			BIT(6)),
+	AXP_DESC(AXP813, ALDO1, "aldo1", "aldoin", 700, 3300, 100,
+		 AXP22X_ALDO1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL3, BIT(5)),
+	AXP_DESC(AXP813, ALDO2, "aldo2", "aldoin", 700, 3300, 100,
+		 AXP22X_ALDO2_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL3, BIT(6)),
+	AXP_DESC(AXP813, ALDO3, "aldo3", "aldoin", 700, 3300, 100,
+		 AXP22X_ALDO3_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL3, BIT(7)),
+	AXP_DESC(AXP813, DLDO1, "dldo1", "dldoin", 700, 3300, 100,
+		 AXP22X_DLDO1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(3)),
+	AXP_DESC_RANGES(AXP813, DLDO2, "dldo2", "dldoin", axp803_dldo2_ranges,
+			32, AXP22X_DLDO2_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2,
+			BIT(4)),
+	AXP_DESC(AXP813, DLDO3, "dldo3", "dldoin", 700, 3300, 100,
+		 AXP22X_DLDO3_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(5)),
+	AXP_DESC(AXP813, DLDO4, "dldo4", "dldoin", 700, 3300, 100,
+		 AXP22X_DLDO4_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(6)),
+	AXP_DESC(AXP813, ELDO1, "eldo1", "eldoin", 700, 1900, 50,
+		 AXP22X_ELDO1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(0)),
+	AXP_DESC(AXP813, ELDO2, "eldo2", "eldoin", 700, 1900, 50,
+		 AXP22X_ELDO2_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(1)),
+	AXP_DESC(AXP813, ELDO3, "eldo3", "eldoin", 700, 1900, 50,
+		 AXP22X_ELDO3_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(2)),
+	/* to do / check ... */
+	AXP_DESC(AXP813, FLDO1, "fldo1", "fldoin", 700, 1450, 50,
+		 AXP803_FLDO1_V_OUT, 0x0f, AXP22X_PWR_OUT_CTRL3, BIT(2)),
+	AXP_DESC(AXP813, FLDO2, "fldo2", "fldoin", 700, 1450, 50,
+		 AXP803_FLDO2_V_OUT, 0x0f, AXP22X_PWR_OUT_CTRL3, BIT(3)),
+	/*
+	 * TODO: FLDO3 = {DCDC5, FLDOIN} / 2
+	 *
+	 * This means FLDO3 effectively switches supplies at runtime,
+	 * something the regulator subsystem does not support.
+	 */
+	AXP_DESC_FIXED(AXP813, RTC_LDO, "rtc-ldo", "ips", 1800),
+	AXP_DESC_IO(AXP813, LDO_IO0, "ldo-io0", "ips", 700, 3300, 100,
+		    AXP22X_LDO_IO0_V_OUT, 0x1f, AXP20X_GPIO0_CTRL, 0x07,
+		    AXP22X_IO_ENABLED, AXP22X_IO_DISABLED),
+	AXP_DESC_IO(AXP813, LDO_IO1, "ldo-io1", "ips", 700, 3300, 100,
+		    AXP22X_LDO_IO1_V_OUT, 0x1f, AXP20X_GPIO1_CTRL, 0x07,
+		    AXP22X_IO_ENABLED, AXP22X_IO_DISABLED),
+	AXP_DESC_SW(AXP813, SW, "sw", "swin", AXP22X_PWR_OUT_CTRL2, BIT(7)),
+};
+
 static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 {
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
@@ -441,9 +505,10 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 		step = 75;
 		break;
 	case AXP803_ID:
+	case AXP813_ID:
 		/*
-		 * AXP803 DCDC work frequency setting has the same range and
-		 * step as AXP22X, but at a different register.
+		 * AXP803/AXP813 DCDC work frequency setting has the same
+		 * range and step as AXP22X, but at a different register.
 		 * Fall through to the check below.
 		 * (See include/linux/mfd/axp20x.h)
 		 */
@@ -561,6 +626,14 @@ static int axp20x_set_dcdc_workmode(struct regulator_dev *rdev, int id, u32 work
 		workmode <<= id - AXP803_DCDC1;
 		break;
 
+	case AXP813_ID:
+		if (id < AXP813_DCDC1 || id > AXP813_DCDC7)
+			return -EINVAL;
+
+		mask = AXP22X_WORKMODE_DCDCX_MASK(id - AXP813_DCDC1);
+		workmode <<= id - AXP813_DCDC1;
+		break;
+
 	default:
 		/* should not happen */
 		WARN_ON(1);
@@ -579,8 +652,8 @@ static bool axp20x_is_polyphase_slave(struct axp20x_dev *axp20x, int id)
 	u32 reg = 0;
 
 	/*
-	 * Currently in our supported AXP variants, only AXP803 and AXP806
-	 * have polyphase regulators.
+	 * Currently in our supported AXP variants, only AXP803, AXP806,
+	 * and AXP813 have polyphase regulators.
 	 */
 	switch (axp20x->variant) {
 	case AXP803_ID:
@@ -608,6 +681,17 @@ static bool axp20x_is_polyphase_slave(struct axp20x_dev *axp20x, int id)
 		}
 		break;
 
+	case AXP813_ID:
+		regmap_read(axp20x->regmap, AXP803_POLYPHASE_CTRL, &reg);
+
+		switch (id) {
+		case AXP803_DCDC3:
+			return !!(reg & BIT(6));
+		case AXP803_DCDC6:
+			return !!(reg & BIT(5));
+		}
+		break;
+
 	default:
 		return false;
 	}
@@ -656,6 +740,12 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		regulators = axp809_regulators;
 		nregulators = AXP809_REG_ID_MAX;
 		break;
+	case AXP813_ID:
+		regulators = axp813_regulators;
+		nregulators = AXP813_REG_ID_MAX;
+		drivevbus = of_property_read_bool(pdev->dev.parent->of_node,
+						  "x-powers,drive-vbus-en");
+		break;
 	default:
 		dev_err(&pdev->dev, "Unsupported AXP variant: %ld\n",
 			axp20x->variant);
@@ -677,6 +767,10 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		if (axp20x_is_polyphase_slave(axp20x, i))
 			continue;
 
+		/* Support for AXP813's FLDO3 is not implemented */
+		if (axp20x->variant == AXP813_ID && i == AXP813_FLDO3)
+			continue;
+
 		/*
 		 * Regulators DC1SW and DC5LDO are connected internally,
 		 * so we have to handle their supply names separately.
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index e9c908c4fba8..78dc85365c4f 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -131,6 +131,9 @@ enum axp20x_variants {
 #define AXP803_DCDC6_V_OUT		0x25
 #define AXP803_DCDC_FREQ_CTRL		0x3b
 
+/* Other DCDC regulator control registers are the same as AXP803 */
+#define AXP813_DCDC7_V_OUT		0x26
+
 /* Interrupt */
 #define AXP152_IRQ1_EN			0x40
 #define AXP152_IRQ2_EN			0x41
-- 
2.14.1
