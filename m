From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 22 Apr 2013 11:57:25 +0200
Subject: [PATCH 14/23] regulator: ab3100: device tree support
Message-ID: <1366624645-6614-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This implements device tree support for the AB3100 regulators
driver. The initial settings are moved out of platform data
and into the driver for the device tree case, as it appears
that there is no way to supply this as AUXDATA for an I2C
device. The style and bindings are heavily inspired by
Lee Jones' style for AB8500.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi Mark, seeking an ACK on this to take it through the ARM
SoC tree.
---
 drivers/mfd/ab3100-core.c  |   1 +
 drivers/regulator/ab3100.c | 123 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 118 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/ab3100-core.c b/drivers/mfd/ab3100-core.c
index 2ec7725..a9bb140 100644
--- a/drivers/mfd/ab3100-core.c
+++ b/drivers/mfd/ab3100-core.c
@@ -753,6 +753,7 @@ static struct mfd_cell ab3100_devs[] = {
 	},
 	{
 		.name = "ab3100-regulators",
+		.of_compatible = "stericsson,ab3100-regulators",
 		.id = -1,
 	},
 	{
diff --git a/drivers/regulator/ab3100.c b/drivers/regulator/ab3100.c
index 740735d..be1e6ad 100644
--- a/drivers/regulator/ab3100.c
+++ b/drivers/regulator/ab3100.c
@@ -17,6 +17,8 @@
 #include <linux/regulator/driver.h>
 #include <linux/mfd/ab3100.h>
 #include <linux/mfd/abx500.h>
+#include <linux/of.h>
+#include <linux/regulator/of_regulator.h>
 
 /* LDO registers and some handy masking definitions for AB3100 */
 #define AB3100_LDO_A		0x40
@@ -345,7 +347,11 @@ static int ab3100_get_voltage_regulator_external(struct regulator_dev *reg)
 {
 	struct ab3100_regulator *abreg = rdev_get_drvdata(reg);
 
-	return abreg->plfdata->external_voltage;
+	if (abreg->plfdata)
+		return abreg->plfdata->external_voltage;
+	else
+		/* TODO: encode external voltage into device tree */
+		return 0;
 }
 
 static struct regulator_ops regulator_ops_fixed = {
@@ -490,6 +496,8 @@ ab3100_regulator_desc[AB3100_NUM_REGULATORS] = {
 
 static int ab3100_regulator_register(struct platform_device *pdev,
 				     struct ab3100_platform_data *plfdata,
+				     struct regulator_init_data *init_data,
+				     struct device_node *np,
 				     int id)
 {
 	struct regulator_desc *desc;
@@ -518,9 +526,11 @@ static int ab3100_regulator_register(struct platform_device *pdev,
 	 */
 	reg->dev = &pdev->dev;
 	if (plfdata) {
-		/* This will be replaced by device tree data */
 		reg->plfdata = plfdata;
 		config.init_data = &plfdata->reg_constraints[i];
+	} else if (np) {
+		config.of_node = np;
+		config.init_data = init_data;
 	}
 	config.dev = &pdev->dev;
 	config.driver_data = reg;
@@ -540,15 +550,103 @@ static int ab3100_regulator_register(struct platform_device *pdev,
 	return 0;
 }
 
+static struct of_regulator_match ab3100_regulator_matches[] = {
+	{ .name = "ab3100_ldo_a", .driver_data = (void *) AB3100_LDO_A, },
+	{ .name = "ab3100_ldo_c", .driver_data = (void *) AB3100_LDO_C, },
+	{ .name = "ab3100_ldo_d", .driver_data = (void *) AB3100_LDO_D, },
+	{ .name = "ab3100_ldo_e", .driver_data = (void *) AB3100_LDO_E, },
+	{ .name = "ab3100_ldo_f", .driver_data = (void *) AB3100_LDO_F },
+	{ .name = "ab3100_ldo_g", .driver_data = (void *) AB3100_LDO_G },
+	{ .name = "ab3100_ldo_h", .driver_data = (void *) AB3100_LDO_H },
+	{ .name = "ab3100_ldo_k", .driver_data = (void *) AB3100_LDO_K },
+	{ .name = "ab3100_ext", .driver_data = (void *) AB3100_LDO_EXT },
+	{ .name = "ab3100_buck", .driver_data = (void *) AB3100_BUCK },
+};
+
 /*
- * NOTE: the following functions are regulators pluralis - it is the
- * binding to the AB3100 core driver and the parent platform device
- * for all the different regulators.
+ * Initial settings of ab3100 registers.
+ * Common for below LDO regulator settings are that
+ * bit 7-5 controls voltage. Bit 4 turns regulator ON(1) or OFF(0).
+ * Bit 3-2 controls sleep enable and bit 1-0 controls sleep mode.
  */
+/* LDO_A 0x16: 2.75V, ON, SLEEP_A, SLEEP OFF GND */
+#define LDO_A_SETTING		0x16
+/* LDO_C 0x10: 2.65V, ON, SLEEP_A or B, SLEEP full power */
+#define LDO_C_SETTING		0x10
+/* LDO_D 0x10: 2.65V, ON, sleep mode not used */
+#define LDO_D_SETTING		0x10
+/* LDO_E 0x10: 1.8V, ON, SLEEP_A or B, SLEEP full power */
+#define LDO_E_SETTING		0x10
+/* LDO_E SLEEP 0x00: 1.8V, not used, SLEEP_A or B, not used */
+#define LDO_E_SLEEP_SETTING	0x00
+/* LDO_F 0xD0: 2.5V, ON, SLEEP_A or B, SLEEP full power */
+#define LDO_F_SETTING		0xD0
+/* LDO_G 0x00: 2.85V, OFF, SLEEP_A or B, SLEEP full power */
+#define LDO_G_SETTING		0x00
+/* LDO_H 0x18: 2.75V, ON, SLEEP_B, SLEEP full power */
+#define LDO_H_SETTING		0x18
+/* LDO_K 0x00: 2.75V, OFF, SLEEP_A or B, SLEEP full power */
+#define LDO_K_SETTING		0x00
+/* LDO_EXT 0x00: Voltage not set, OFF, not used, not used */
+#define LDO_EXT_SETTING		0x00
+/* BUCK 0x7D: 1.2V, ON, SLEEP_A and B, SLEEP low power */
+#define BUCK_SETTING	0x7D
+/* BUCK SLEEP 0xAC: 1.05V, Not used, SLEEP_A and B, Not used */
+#define BUCK_SLEEP_SETTING	0xAC
+
+static const u8 ab3100_reg_initvals[] = {
+	LDO_A_SETTING,
+	LDO_C_SETTING,
+	LDO_E_SETTING,
+	LDO_E_SLEEP_SETTING,
+	LDO_F_SETTING,
+	LDO_G_SETTING,
+	LDO_H_SETTING,
+	LDO_K_SETTING,
+	LDO_EXT_SETTING,
+	BUCK_SETTING,
+	BUCK_SLEEP_SETTING,
+	LDO_D_SETTING,
+};
+
+static int
+ab3100_regulator_of_probe(struct platform_device *pdev, struct device_node *np)
+{
+	int err, i;
+
+	/*
+	 * Set up the regulator registers, as was previously done with
+	 * platform data.
+	 */
+	/* Set up regulators */
+	for (i = 0; i < ARRAY_SIZE(ab3100_reg_init_order); i++) {
+		err = abx500_set_register_interruptible(&pdev->dev, 0,
+					ab3100_reg_init_order[i],
+					ab3100_reg_initvals[i]);
+		if (err) {
+			dev_err(&pdev->dev, "regulator initialization failed with error %d\n",
+				err);
+			return err;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ab3100_regulator_matches); i++) {
+		err = ab3100_regulator_register(
+			pdev, NULL, ab3100_regulator_matches[i].init_data,
+			ab3100_regulator_matches[i].of_node,
+			(int) ab3100_regulator_matches[i].driver_data);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 
 static int ab3100_regulators_probe(struct platform_device *pdev)
 {
 	struct ab3100_platform_data *plfdata = pdev->dev.platform_data;
+	struct device_node *np = pdev->dev.of_node;
 	int err = 0;
 	u8 data;
 	int i;
@@ -567,6 +665,18 @@ static int ab3100_regulators_probe(struct platform_device *pdev)
 		dev_notice(&pdev->dev,
 			   "chip is in inactive mode (Cold start)\n");
 
+	if (np) {
+		err = of_regulator_match(&pdev->dev, np,
+					 ab3100_regulator_matches,
+					 ARRAY_SIZE(ab3100_regulator_matches));
+		if (err < 0) {
+			dev_err(&pdev->dev,
+				"Error parsing regulator init data: %d\n", err);
+			return err;
+		}
+		return ab3100_regulator_of_probe(pdev, np);
+	}
+
 	/* Set up regulators */
 	for (i = 0; i < ARRAY_SIZE(ab3100_reg_init_order); i++) {
 		err = abx500_set_register_interruptible(&pdev->dev, 0,
@@ -583,7 +693,8 @@ static int ab3100_regulators_probe(struct platform_device *pdev)
 	for (i = 0; i < AB3100_NUM_REGULATORS; i++) {
 		struct regulator_desc *desc = &ab3100_regulator_desc[i];
 
-		err = ab3100_regulator_register(pdev, plfdata, desc->id);
+		err = ab3100_regulator_register(pdev, plfdata, NULL, NULL,
+						desc->id);
 		if (err)
 			return err;
 	}
-- 
1.7.11.3
