From: dianders@chromium.org (Doug Anderson)
Date: Wed, 10 Dec 2014 12:58:02 -0800
Subject: [PATCH 1/4] regulator: core: Support trying to get close to a certain
 voltage
Message-ID: <1418245085-9754-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some cases where you'd like to set a voltage for a regulator
and a range of voltages are OK, but you'd really like to get as close
as you can to a specific voltage if at all possible.

The VQMMC (IO voltage) regulator for SD cards is the inspiration for
needing this function.  A few things about SD cards to justify its
need:

1. In old systems (before UHS), the VMMC and VQMMC were provided by
the same regulator.  That means that SD cards were all tested with
VMMC and VQMMC being exactly the same.  With UHS we need to have two
regulators providing VMMC and VQMMC.  For maximum compatibility, we'd
like to keep those two regulators providing the exact same voltage
when we're using "3.3V signaling".  Note: VMMC is managed with very
specific rules in the MMC core and we tend to pick the _highest_
supported voltage in range.

2. On UHS systems we'll eventually negotiate the IO voltage (VQMMC)
down to 1.8V.  Note that we don't provide a 1.8V reference voltage to
the SD card so it comes up with 1.8V on its own based on VMMC (perhaps
using an on-card LDO).  While the SD card spec says that VQMMC can be
1.7V to 1.95V, it seems best to try to get the closest voltage.
Trying to achieve 1.8V means that the card and controller drive the IO
lines (which are push-pull) with as close to the same voltage as
possible.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/regulator/core.c           | 62 ++++++++++++++++++++++++++++++++++++++
 include/linux/regulator/consumer.h |  9 ++++++
 2 files changed, 71 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e225711..ce91b20 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2664,6 +2664,68 @@ out2:
 EXPORT_SYMBOL_GPL(regulator_set_voltage);
 
 /**
+ * regulator_set_closest_voltage - set voltage trying to reach a certain one.
+ * @regulator: regulator source
+ * @min_uV: Minimum required voltage in uV
+ * @ideal_uV: Try to get as close to this voltage as possible
+ * @max_uV: Maximum acceptable voltage in uV
+ *
+ * This function is useful in cases where we want to try to get as close to
+ * a target voltage as possible but we would accept other voltages as fallback.
+ */
+int regulator_set_closest_voltage(struct regulator *regulator, int min_uV,
+				  int ideal_uV, int max_uV)
+{
+	int best_uV, delta, best_delta;
+	int i, voltages, ret;
+	struct regulator_dev *rdev = regulator->rdev;
+
+	if (ideal_uV < min_uV || ideal_uV > max_uV)
+		return -EINVAL;
+
+	/* Handle continuous ranges */
+	if (rdev->desc->continuous_voltage_range) {
+		min_uV = max(min_uV, rdev->constraints->min_uV);
+		max_uV = min(max_uV, rdev->constraints->max_uV);
+
+		if (min_uV > max_uV)
+			return -EINVAL;
+
+		best_uV = min(max(ideal_uV, min_uV), max_uV);
+		return regulator_set_voltage(regulator, best_uV, best_uV);
+	}
+
+	ret = regulator_count_voltages(regulator);
+	if (ret < 0)
+		return ret;
+	voltages = ret;
+
+	best_uV = 0;
+	best_delta = INT_MAX;
+	for (i = 0; i < voltages; i++) {
+		ret = regulator_list_voltage(regulator, i);
+
+		if (ret < min_uV || ret > max_uV)
+			continue;
+
+		delta = ideal_uV - ret;
+		delta = abs(delta);
+
+		if (delta < best_delta) {
+			best_delta = delta;
+			best_uV = ret;
+		}
+	}
+
+	/* If no voltages, let regulator_set_voltage() decide if we're OK */
+	if (best_uV == 0)
+		return regulator_set_voltage(regulator, min_uV, max_uV);
+
+	return regulator_set_voltage(regulator, best_uV, best_uV);
+}
+EXPORT_SYMBOL_GPL(regulator_set_closest_voltage);
+
+/**
  * regulator_set_voltage_time - get raise/fall time
  * @regulator: regulator source
  * @old_uV: starting voltage in microvolts
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index d17e1ff..71c9ec2 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -228,6 +228,8 @@ int regulator_is_supported_voltage(struct regulator *regulator,
 				   int min_uV, int max_uV);
 unsigned int regulator_get_linear_step(struct regulator *regulator);
 int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV);
+int regulator_set_closest_voltage(struct regulator *regulator, int min_uV,
+				  int ideal_uV, int max_uV);
 int regulator_set_voltage_time(struct regulator *regulator,
 			       int old_uV, int new_uV);
 int regulator_get_voltage(struct regulator *regulator);
@@ -440,6 +442,13 @@ static inline int regulator_set_voltage(struct regulator *regulator,
 	return 0;
 }
 
+static inline int regulator_set_closest_voltage(struct regulator *regulator,
+						int min_uV, int ideal_uV,
+						int max_uV)
+{
+	return 0;
+}
+
 static inline int regulator_set_voltage_time(struct regulator *regulator,
 					     int old_uV, int new_uV)
 {
-- 
2.2.0.rc0.207.ga3a616c
