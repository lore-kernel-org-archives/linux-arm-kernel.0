From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 16 Aug 2016 08:05:02 +0200
Subject: [PATCH v2] regulator: axp20x: support AXP803/AXP813 variants
Message-ID: <mailman.39.1471329469.1636.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The X-Powers AXP803 and AXP813 PMICs are close to the AXP809 with some
more outputs.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
The AXP813 has been tested in a Banana PI M3 board (needed for WiFi/BT).
v2:
- fix lack of support of dcdc frequency
- notice that the AXP803 is also handled
- send the patch to the DT maintainers
---
 Documentation/devicetree/bindings/mfd/axp20x.txt | 32 ++++++++-
 drivers/mfd/axp20x-rsb.c                         |  1 +
 drivers/mfd/axp20x.c                             |  3 +
 drivers/regulator/axp20x-regulator.c             | 83 +++++++++++++++++++++++-
 include/linux/mfd/axp20x.h                       | 38 +++++++++++
 5 files changed, 154 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
index 585a955..856a9ff 100644
--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -7,10 +7,12 @@ axp209 (X-Powers)
 axp221 (X-Powers)
 axp223 (X-Powers)
 axp809 (X-Powers)
+axp813 (X-Powers)
 
 Required properties:
 - compatible: "x-powers,axp152", "x-powers,axp202", "x-powers,axp209",
-	      "x-powers,axp221", "x-powers,axp223", "x-powers,axp809"
+	      "x-powers,axp221", "x-powers,axp223", "x-powers,axp809",
+	      "x-powers,axp813"
 - reg: The I2C slave address or RSB hardware address for the AXP chip
 - interrupt-parent: The parent interrupt controller
 - interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin
@@ -110,6 +112,34 @@ LDO_IO1		: LDO		: ips-supply		: GPIO 1
 RTC_LDO		: LDO		: ips-supply		: always on
 SW		: On/Off Switch : swin-supply
 
+AXP803/AXP813 regulators, type, and corresponding input supply names:
+
+Regulator	  Type		  Supply Name		  Notes
+---------	  ----		  -----------		  -----
+DCDC1		: DC-DC buck	: vin1-supply
+DCDC2		: DC-DC buck	: vin2-supply
+DCDC3		: DC-DC	buck	: vin3-supply
+DCDC4		: DC-DC	buck	: vin4-supply
+DCDC5		: DC-DC	buck	: vin5-supply
+DCDC6		: DC-DC	buck	: vin6-supply
+DCDC7		: DC-DC	buck	: vin7-supply		: AXP813 only
+RTC_LDO		: LDO		: ips-supply		: always on
+ALDO1		: LDO		: aldoin-supply		: shared supply
+ALDO2		: LDO		: aldoin-supply		: shared supply
+ALDO3		: LDO		: aldoin-supply		: shared supply
+DLDO1		: LDO		: dldoin-supply		: shared supply
+DLDO2		: LDO		: dldoin-supply		: shared supply
+DLDO3		: LDO		: dldoin-supply		: shared supply
+DLDO4		: LDO		: dldoin-supply		: shared supply
+ELDO1		: LDO		: eldoin-supply		: shared supply
+ELDO2		: LDO		: eldoin-supply		: shared supply
+ELDO3		: LDO		: eldoin-supply		: shared supply
+FLDO1		: LDO		: fldoin-supply		: shared supply
+FLDO2		: LDO		: fldoin-supply		: shared supply
+LDO_IO0		: LDO		: ips-supply		: GPIO 0
+LDO_IO1		: LDO		: ips-supply		: GPIO 1
+DC1SW		: On/Off Switch	:			: DCDC1 secondary output
+
 Example:
 
 axp209: pmic at 34 {
diff --git a/drivers/mfd/axp20x-rsb.c b/drivers/mfd/axp20x-rsb.c
index a407527..e34643b 100644
--- a/drivers/mfd/axp20x-rsb.c
+++ b/drivers/mfd/axp20x-rsb.c
@@ -62,6 +62,7 @@ static int axp20x_rsb_remove(struct sunxi_rsb_device *rdev)
 static const struct of_device_id axp20x_rsb_of_match[] = {
 	{ .compatible = "x-powers,axp223", .data = (void *)AXP223_ID },
 	{ .compatible = "x-powers,axp809", .data = (void *)AXP809_ID },
+	{ .compatible = "x-powers,axp813", .data = (void *)AXP813_ID },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, axp20x_rsb_of_match);
diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index fd80b09..e62d56f 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -39,6 +39,7 @@ static const char * const axp20x_model_names[] = {
 	"AXP223",
 	"AXP288",
 	"AXP809",
+	"AXP813",
 };
 
 static const struct regmap_range axp152_writeable_ranges[] = {
@@ -494,6 +495,7 @@ static const struct regmap_irq_chip axp288_regmap_irq_chip = {
 
 };
 
+/* common 803/809/813 */
 static const struct regmap_irq_chip axp809_regmap_irq_chip = {
 	.name			= "axp809",
 	.status_base		= AXP20X_IRQ1_STATE,
@@ -733,6 +735,7 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
 		axp20x->regmap_irq_chip = &axp288_regmap_irq_chip;
 		break;
 	case AXP809_ID:
+	case AXP813_ID:
 		axp20x->nr_cells = ARRAY_SIZE(axp809_cells);
 		axp20x->cells = axp809_cells;
 		axp20x->regmap_cfg = &axp22x_regmap_config;
diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 6d9ac76..3fbe2c1 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -299,6 +299,78 @@ static const struct regulator_desc axp809_regulators[] = {
 	AXP_DESC_SW(AXP809, SW, "sw", "swin", AXP22X_PWR_OUT_CTRL2, BIT(6)),
 };
 
+static const struct regulator_linear_range axp813_dcdc2_4_ranges[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0, 70, 10000),
+	REGULATOR_LINEAR_RANGE(1220000, 71, 75, 20000),
+};
+
+static const struct regulator_linear_range axp813_dcdc5_ranges[] = {
+	REGULATOR_LINEAR_RANGE(800000, 0, 32, 10000),
+	REGULATOR_LINEAR_RANGE(1140000, 33, 68, 20000),
+};
+
+static const struct regulator_linear_range axp813_dcdc6_7_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0, 50, 10000),
+	REGULATOR_LINEAR_RANGE(1120000, 51, 71, 20000),
+};
+
+static const struct regulator_desc axp813_regulators[] = {
+	AXP_DESC(AXP813, DLDO1, "dldo1", "dldoin", 700, 3300, 100,
+		 AXP22X_DLDO1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(3)),
+	AXP_DESC(AXP813, DLDO2, "dldo2", "dldoin", 700, 4200, 100,
+		 AXP22X_DLDO2_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(4)),
+	AXP_DESC(AXP813, DLDO3, "dldo3", "dldoin", 700, 3300, 100,
+		 AXP22X_DLDO2_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(5)),
+	AXP_DESC(AXP813, DLDO4, "dldo4", "dldoin", 700, 3300, 100,
+		 AXP22X_DLDO2_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(6)),
+	AXP_DESC(AXP813, ELDO1, "eldo1", "eldoin", 700, 1900, 50,
+		 AXP22X_ELDO1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(0)),
+	AXP_DESC(AXP813, ELDO2, "eldo2", "eldoin", 700, 1900, 50,
+		 AXP22X_ELDO2_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(1)),
+	AXP_DESC(AXP813, ELDO3, "eldo3", "eldoin", 700, 1900, 50,
+		 AXP22X_ELDO3_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(2)),
+	AXP_DESC(AXP813, FLDO1, "fldo1", "fldoin", 700, 1450, 50,
+		 AXP813_FLDO1_V_OUT, 0x0f, AXP22X_PWR_OUT_CTRL3, BIT(2)),
+	AXP_DESC(AXP813, FLDO2, "fldo2", "fldoin", 700, 1450, 50,
+		 AXP813_FLDO2_V_OUT, 0x0f, AXP22X_PWR_OUT_CTRL3, BIT(3)),
+	AXP_DESC(AXP813, DCDC1, "dcdc1", "vin1", 1600, 3400, 100,
+		 AXP813_DCDC1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL1, BIT(0)),
+	AXP_DESC_RANGES(AXP813, DCDC2, "dcdc2", "vin2", axp813_dcdc2_4_ranges,
+			76, AXP813_DCDC2_V_OUT, 0x7f, AXP22X_PWR_OUT_CTRL1,
+			BIT(1)),
+	AXP_DESC_RANGES(AXP813, DCDC3, "dcdc3", "vin3", axp813_dcdc2_4_ranges,
+			76, AXP813_DCDC3_V_OUT, 0x7f, AXP22X_PWR_OUT_CTRL1,
+			BIT(2)),
+	AXP_DESC_RANGES(AXP813, DCDC4, "dcdc4", "vin4", axp813_dcdc2_4_ranges,
+			76, AXP813_DCDC4_V_OUT, 0x7f, AXP22X_PWR_OUT_CTRL1,
+			BIT(3)),
+	AXP_DESC_RANGES(AXP813, DCDC5, "dcdc5", "vin5", axp813_dcdc5_ranges,
+			69, AXP813_DCDC5_V_OUT, 0x7f, AXP22X_PWR_OUT_CTRL1,
+			BIT(4)),
+	AXP_DESC_RANGES(AXP813, DCDC6, "dcdc6", "vin6", axp813_dcdc6_7_ranges,
+			72, AXP813_DCDC6_V_OUT, 0x7f, AXP22X_PWR_OUT_CTRL1,
+			BIT(5)),
+	AXP_DESC_RANGES(AXP813, DCDC7, "dcdc7", "vin7", axp813_dcdc6_7_ranges,
+			72, AXP813_DCDC7_V_OUT, 0x7f, AXP22X_PWR_OUT_CTRL1,
+			BIT(6)),
+	AXP_DESC_FIXED(AXP813, RTC_LDO, "rtc_ldo", "ips", 3000),
+	AXP_DESC(AXP813, ALDO1, "aldo1", "aldoin", 700, 3300, 100,
+		 AXP22X_ALDO1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL3, BIT(5)),
+	AXP_DESC(AXP813, ALDO2, "aldo2", "aldoin", 700, 3300, 100,
+		 AXP22X_ALDO2_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL3, BIT(6)),
+	AXP_DESC(AXP813, ALDO3, "aldo3", "aldoin", 700, 3300, 100,
+		 AXP22X_ALDO3_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL3, BIT(7)),
+	AXP_DESC_IO(AXP813, LDO_IO0, "ldo_io0", "ips", 700, 3300, 100,
+		    AXP22X_LDO_IO0_V_OUT, 0x1f, AXP20X_GPIO0_CTRL, 0x07,
+		    AXP22X_IO_ENABLED, AXP22X_IO_DISABLED),
+	AXP_DESC_IO(AXP813, LDO_IO1, "ldo_io1", "ips", 700, 3300, 100,
+		    AXP22X_LDO_IO1_V_OUT, 0x1f, AXP20X_GPIO1_CTRL, 0x07,
+		    AXP22X_IO_ENABLED, AXP22X_IO_DISABLED),
+	/* secondary switchable output of DCDC1 */
+	AXP_DESC_SW(AXP813, DC1SW, "dc1sw", NULL, AXP22X_PWR_OUT_CTRL2,
+		    BIT(7)),
+};
+
 static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 {
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
@@ -315,6 +387,7 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 	case AXP221_ID:
 	case AXP223_ID:
 	case AXP809_ID:
+	case AXP813_ID:
 		min = 1800;
 		max = 4050;
 		def = 3000;
@@ -444,6 +517,10 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		regulators = axp809_regulators;
 		nregulators = AXP809_REG_ID_MAX;
 		break;
+	case AXP813_ID:
+		regulators = axp813_regulators;
+		nregulators = AXP813_REG_ID_MAX;
+		break;
 	default:
 		dev_err(&pdev->dev, "Unsupported AXP variant: %ld\n",
 			axp20x->variant);
@@ -467,7 +544,8 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		 * name.
 		 */
 		if ((regulators == axp22x_regulators && i == AXP22X_DC1SW) ||
-		    (regulators == axp809_regulators && i == AXP809_DC1SW)) {
+		    (regulators == axp809_regulators && i == AXP809_DC1SW) ||
+		    (regulators == axp813_regulators && i == AXP813_DC1SW)) {
 			new_desc = devm_kzalloc(&pdev->dev, sizeof(*desc),
 						GFP_KERNEL);
 			*new_desc = regulators[i];
@@ -505,7 +583,8 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		 * Save AXP22X DCDC1 / DCDC5 regulator names for later.
 		 */
 		if ((regulators == axp22x_regulators && i == AXP22X_DCDC1) ||
-		    (regulators == axp809_regulators && i == AXP809_DCDC1))
+		    (regulators == axp809_regulators && i == AXP809_DCDC1) ||
+		    (regulators == axp813_regulators && i == AXP813_DCDC1))
 			of_property_read_string(rdev->dev.of_node,
 						"regulator-name",
 						&dcdc1_name);
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 0be4982..637fb7c 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -21,6 +21,7 @@ enum {
 	AXP223_ID,
 	AXP288_ID,
 	AXP809_ID,
+	AXP813_ID,
 	NR_AXP20X_VARIANTS,
 };
 
@@ -91,6 +92,16 @@ enum {
 #define AXP22X_ALDO3_V_OUT		0x2a
 #define AXP22X_CHRG_CTRL3		0x35
 
+#define AXP813_FLDO1_V_OUT		0x1c
+#define AXP813_FLDO2_V_OUT		0x1d
+#define AXP813_DCDC1_V_OUT		0x20
+#define AXP813_DCDC2_V_OUT		0x21
+#define AXP813_DCDC3_V_OUT		0x22
+#define AXP813_DCDC4_V_OUT		0x23
+#define AXP813_DCDC5_V_OUT		0x24
+#define AXP813_DCDC6_V_OUT		0x25
+#define AXP813_DCDC7_V_OUT		0x26
+
 /* Interrupt */
 #define AXP152_IRQ1_EN			0x40
 #define AXP152_IRQ2_EN			0x41
@@ -288,6 +299,33 @@ enum {
 	AXP809_REG_ID_MAX,
 };
 
+enum {
+	AXP813_DCDC1 = 0,
+	AXP813_DCDC2,
+	AXP813_DCDC3,
+	AXP813_DCDC4,
+	AXP813_DCDC5,
+	AXP813_DCDC6,
+	AXP813_DCDC7,
+	AXP813_RTC_LDO,
+	AXP813_ALDO1,
+	AXP813_ALDO2,
+	AXP813_ALDO3,
+	AXP813_DLDO1,
+	AXP813_DLDO2,
+	AXP813_DLDO3,
+	AXP813_DLDO4,
+	AXP813_ELDO1,
+	AXP813_ELDO2,
+	AXP813_ELDO3,
+	AXP813_FLDO1,
+	AXP813_FLDO2,
+	AXP813_LDO_IO0,
+	AXP813_LDO_IO1,
+	AXP813_DC1SW,
+	AXP813_REG_ID_MAX,
+};
+
 /* IRQs */
 enum {
 	AXP152_IRQ_LDO0IN_CONNECT = 1,
-- 
2.9.3
