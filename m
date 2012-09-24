From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 24 Sep 2012 18:56:53 +0100
Subject: [RFC] regulator: core: Support for continuous voltage range
Message-ID: <1348509414-21261-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some regulators can set any voltage within the constraints range,
not being limited to specified operating points.

This patch makes it possible to describe such regulator and makes
the regulator_is_supported_voltage() function behave correctly.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/regulator/core.c         |    5 +++++
 include/linux/regulator/driver.h |    3 +++
 2 files changed, 8 insertions(+)

Hi Mark,

This is roughly what we discussed last week. Alternatively, it could be
also a "universal" unsigned regulator_desc.flags field with #define
REGULATOR_FLAG_CONTINUOUS_VOLTAGE_RAGE 0x1.

Regards

Pawel

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 4838531..808928a 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1947,6 +1947,11 @@ int regulator_is_supported_voltage(struct regulator *regulator,
 			return ret;
 	}
 
+	/* Any voltage within constrains range is fine? */
+	if (rdev->desc->continuous_voltage_range)
+		return min_uV >= rdev->constraints->min_uV &&
+				max_uV <= rdev->constraints->max_uV;
+
 	ret = regulator_count_voltages(regulator);
 	if (ret < 0)
 		return ret;
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index bac4c87..2f915b9 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -171,6 +171,8 @@ enum regulator_type {
  * @type: Indicates if the regulator is a voltage or current regulator.
  * @owner: Module providing the regulator, used for refcounting.
  *
+ * @continuous_voltage_range: Indicates if the regulator can set any
+ *                            voltage within constrains range.
  * @n_voltages: Number of selectors available for ops.list_voltage().
  *
  * @min_uV: Voltage given by the lowest selector (if linear mapping)
@@ -189,6 +191,7 @@ struct regulator_desc {
 	const char *name;
 	const char *supply_name;
 	int id;
+	bool continuous_voltage_range;
 	unsigned n_voltages;
 	struct regulator_ops *ops;
 	int irq;
-- 
1.7.9.5
