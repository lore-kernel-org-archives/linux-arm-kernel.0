From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 16 Jul 2015 23:46:58 +0530
Subject: [PATCH 5/5] regulator: 88pm800: Add support for configuration of dual
 phase on BUCK1
In-Reply-To: <1437070618-21330-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1437070618-21330-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1437070618-21330-6-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88PM860 device supports dual phase mode on BUCK1 output.
In normal usecase, BUCK1A and BUCK1B operates independently with 3A
capacity. And they both can work as a dual phase providing 6A capacity.

This patch adds support for regulator_ops.set_current_limit() callback fn,
in turn enabling support for current min and max supply constraint on BUCK1
(and optionally on BUCK1B). Based on that driver enables dual-phase mode.

Note that, if max current supply constraint is > 3A on BUCK1(A) then driver
enables the dual-phase mode, irrespective of BUCK1B constraint.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/regulator/88pm800.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/88pm80x.h |  3 +++
 2 files changed, 41 insertions(+)

diff --git a/drivers/regulator/88pm800.c b/drivers/regulator/88pm800.c
index e846e4c..1da18fa 100644
--- a/drivers/regulator/88pm800.c
+++ b/drivers/regulator/88pm800.c
@@ -185,6 +185,43 @@ static int pm800_get_current_limit(struct regulator_dev *rdev)
 	return info->max_ua;
 }
 
+/*
+ * 88pm860 device supports dual-phase mode on BUCK1, where BUCK1A and BUCK1B can
+ * be used together to supply 6A current.  Note that, independently, they can
+ * source 3A each.
+ *
+ * So, this function checks for max_uA for BUCK1 (only), and if it is more than
+ * 3A, then enable dual-phase mode.
+ */
+static int pm800_set_current_limit(struct regulator_dev *rdev,
+				int min_uA, int max_uA)
+{
+	struct pm800_regulators *pm800_data =
+				dev_get_drvdata(rdev_get_dev(rdev)->parent);
+	struct pm80x_chip *chip = pm800_data->chip;
+	int ret;
+
+	/* Currently only supported on 88pm860 device */
+	if (chip->type != CHIP_PM860)
+		return 0;
+
+	if (rdev->desc->id == PM800_ID_BUCK1) {
+		/* If max_uA is greater that 3A, enable dual-phase on BUCK1 */
+		if (max_uA > 3000000) {
+			ret = regmap_update_bits(chip->subchip->regmap_power,
+					PM860_BUCK1_MISC,
+					BUCK1_DUAL_PHASE_SEL,
+					BUCK1_DUAL_PHASE_SEL);
+			if (ret) {
+				dev_err(chip->dev, "failed to access registers\n");
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static struct regulator_ops pm800_volt_range_ops = {
 	.list_voltage		= regulator_list_voltage_linear_range,
 	.map_voltage		= regulator_map_voltage_linear_range,
@@ -194,6 +231,7 @@ static struct regulator_ops pm800_volt_range_ops = {
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
 	.get_current_limit	= pm800_get_current_limit,
+	.set_current_limit	= pm800_set_current_limit,
 };
 
 static struct regulator_ops pm800_volt_table_ops = {
diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
index a92d173..05d9bad 100644
--- a/include/linux/mfd/88pm80x.h
+++ b/include/linux/mfd/88pm80x.h
@@ -295,6 +295,9 @@ enum {
 #define PM860_BUCK4_MISC2		(0x82)
 #define PM860_BUCK4_FULL_DRV		BIT(2)
 
+#define PM860_BUCK1_MISC		(0x8E)
+#define BUCK1_DUAL_PHASE_SEL		BIT(2)
+
 struct pm80x_rtc_pdata {
 	int		vrtc;
 	int		rtc_wakeup;
-- 
1.9.1
