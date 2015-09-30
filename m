From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 30 Sep 2015 16:05:44 +0200
Subject: [PATCH 4/6] regulator: core: Propagate voltage changes to supply
 regulators
In-Reply-To: <1443621946-8712-1-git-send-email-s.hauer@pengutronix.de>
References: <1443621946-8712-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1443621946-8712-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until now changing the voltage of a regulator only ever effected the
regulator itself, but never its supplies. It's a common pattern though
to put LDO regulators behind switching regulators. The switching
regulators efficiently drop the input voltage but have a high ripple on
their output. The output is then cleaned up by the LDOs. For higher
energy efficiency the voltage drop at the LDOs should be minimized. This
patch adds support for such a scenario.

A new min_dropout_uv field is added to struct regulator_desc. Regulators
can specify the minimun dropout voltage they need for proper function
here. Now when the voltage is changed on a regulator the regulator core
makes sure that
a) before increasing the voltage on the current regulator the supply
   provides at least the desired voltage plus the minimum dropout
b) after decreasing the voltage on the current regulator the supply
   is optimized to the minimum required voltage within the needs of
   the consumers of the supply.

Calculating the optimum voltage for the supply regulator is a bit tricky
since the simple approach of just adding the desired minimum voltage and
the minimum dropout is not enough. It may happen that the current
regulator does not support the desired minimum voltage, but only a
higher one. This means we have to figure out the lowest voltage
supported by the regulator that is higher than the minimum desired
voltage. The regulator_get_voltage_floor introduced with this patch does
exactly that.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/regulator/core.c         | 136 ++++++++++++++++++++++++++++++++-------
 include/linux/regulator/driver.h |   2 +
 2 files changed, 116 insertions(+), 22 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d148545..36da924 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2756,32 +2756,54 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 	return ret;
 }
 
-/**
- * regulator_set_voltage - set regulator output voltage
- * @regulator: regulator source
- * @min_uV: Minimum required voltage in uV
- * @max_uV: Maximum acceptable voltage in uV
- *
- * Sets a voltage regulator to the desired output voltage. This can be set
- * during any regulator state. IOW, regulator can be disabled or enabled.
- *
- * If the regulator is enabled then the voltage will change to the new value
- * immediately otherwise if the regulator is disabled the regulator will
- * output at the new voltage when enabled.
- *
- * NOTE: If the regulator is shared between several devices then the lowest
- * request voltage that meets the system constraints will be used.
- * Regulator system constraints must be set for this regulator before
- * calling this function otherwise this call will fail.
+/*
+ * Return the minimum voltage supported by a regulator that is higher or equal
+ * to a given voltage.
  */
-int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
+static int regulator_get_voltage_floor(struct regulator *regulator, int min_uV)
+{
+	struct regulator_dev *rdev = regulator->rdev;
+	int num_voltages;
+	int best = INT_MAX;
+	int max_uV = INT_MAX;
+	int i, now, ret;
+
+	/* constraints check */
+	ret = regulator_check_voltage(rdev, &min_uV, &max_uV);
+	if (ret < 0)
+		return ret;
+
+	ret = regulator_check_consumers(rdev, &min_uV, &max_uV);
+	if (ret < 0)
+		return ret;
+
+	num_voltages = regulator_count_voltages(regulator);
+	if (num_voltages < 0)
+		return num_voltages;
+
+	for (i = 0; i < num_voltages; i++) {
+		now = _regulator_list_voltage(regulator, i, 0);
+		if (now < 0)
+			continue;
+		if (now < best && now >= min_uV)
+			best = now;
+	}
+
+	if (best > max_uV)
+		return -EINVAL;
+
+	return best;
+}
+
+static int regulator_set_voltage_unlocked(struct regulator *regulator,
+					  int min_uV, int max_uV)
 {
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret = 0;
 	int old_min_uV, old_max_uV;
 	int current_uV;
-
-	mutex_lock(&rdev->mutex);
+	int best_supply_uV = 0;
+	int supply_change_uV = 0;
 
 	/* If we're setting the same range as last time the change
 	 * should be a noop (some cpufreq implementations use the same
@@ -2825,17 +2847,87 @@ int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
 	if (ret < 0)
 		goto out2;
 
+	if (rdev->supply) {
+		int current_supply_uV;
+
+		best_supply_uV = regulator_get_voltage_floor(regulator, min_uV);
+		if (best_supply_uV < 0) {
+			ret = best_supply_uV;
+			goto out2;
+		}
+
+		best_supply_uV += rdev->desc->min_dropout_uv;
+
+		current_supply_uV = _regulator_get_voltage(rdev->supply->rdev);
+		if (current_supply_uV < 0) {
+			ret = current_supply_uV;
+			goto out2;
+		}
+
+		supply_change_uV = best_supply_uV - current_supply_uV;
+	}
+
+	if (supply_change_uV > 0) {
+		ret = regulator_set_voltage_unlocked(rdev->supply,
+				best_supply_uV, INT_MAX);
+		if (ret) {
+			dev_err(&rdev->dev, "Failed to increase supply voltage: %d\n",
+					ret);
+			goto out2;
+		}
+	}
+
 	ret = _regulator_do_set_voltage(rdev, min_uV, max_uV);
 	if (ret < 0)
 		goto out2;
 
+	if (supply_change_uV < 0) {
+		ret = regulator_set_voltage_unlocked(rdev->supply,
+				best_supply_uV, INT_MAX);
+		if (ret)
+			dev_warn(&rdev->dev, "Failed to decrease supply voltage: %d\n",
+					ret);
+		/* No need to fail here */
+		ret = 0;
+	}
+
 out:
-	mutex_unlock(&rdev->mutex);
 	return ret;
 out2:
 	regulator->min_uV = old_min_uV;
 	regulator->max_uV = old_max_uV;
-	mutex_unlock(&rdev->mutex);
+
+	return ret;
+}
+
+/**
+ * regulator_set_voltage - set regulator output voltage
+ * @regulator: regulator source
+ * @min_uV: Minimum required voltage in uV
+ * @max_uV: Maximum acceptable voltage in uV
+ *
+ * Sets a voltage regulator to the desired output voltage. This can be set
+ * during any regulator state. IOW, regulator can be disabled or enabled.
+ *
+ * If the regulator is enabled then the voltage will change to the new value
+ * immediately otherwise if the regulator is disabled the regulator will
+ * output at the new voltage when enabled.
+ *
+ * NOTE: If the regulator is shared between several devices then the lowest
+ * request voltage that meets the system constraints will be used.
+ * Regulator system constraints must be set for this regulator before
+ * calling this function otherwise this call will fail.
+ */
+int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
+{
+	int ret = 0;
+
+	regulator_lock_supply(regulator->rdev);
+
+	ret = regulator_set_voltage_unlocked(regulator, min_uV, max_uV);
+
+	regulator_unlock_supply(regulator->rdev);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_set_voltage);
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 4593222..a3815bd 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -245,6 +245,7 @@ enum regulator_type {
  * @linear_min_sel: Minimal selector for starting linear mapping
  * @fixed_uV: Fixed voltage of rails.
  * @ramp_delay: Time to settle down after voltage change (unit: uV/us)
+ * @min_dropout_uv: The minimum dropout voltage this regulator can handle
  * @linear_ranges: A constant table of possible voltage ranges.
  * @n_linear_ranges: Number of entries in the @linear_ranges table.
  * @volt_table: Voltage mapping table (if table based mapping)
@@ -292,6 +293,7 @@ struct regulator_desc {
 	unsigned int linear_min_sel;
 	int fixed_uV;
 	unsigned int ramp_delay;
+	int min_dropout_uv;
 
 	const struct regulator_linear_range *linear_ranges;
 	int n_linear_ranges;
-- 
2.5.3
