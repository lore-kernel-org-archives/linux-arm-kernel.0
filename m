From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Wed, 22 Mar 2017 18:53:08 +0200
Subject: [RFC 6/8] regulator: core: Add regulator_is_bypass function
In-Reply-To: <cover.1490199005.git.leonard.crestez@nxp.com>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
Message-ID: <e74c2f4d2b452cbe01aa2a48edde5c024212ffcb.1490199005.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a simple kernel API to query the bypass state of a regulator.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/regulator/core.c           | 26 ++++++++++++++++++++++++++
 include/linux/regulator/consumer.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 9d893aa..7d4f59e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3554,6 +3554,32 @@ int regulator_allow_bypass(struct regulator *regulator, bool enable)
 EXPORT_SYMBOL_GPL(regulator_allow_bypass);
 
 /**
+ * regulator_is_bypass - Determine if the regulator is in bypass mode
+ *
+ * @regulator: Regulator to examine
+ *
+ * @return 0 or 1 for true/false or errno on failure
+ *
+ * Returns zero on a regulator without bypass support.
+ */
+int regulator_is_bypass(struct regulator *regulator)
+{
+	struct regulator_dev *rdev = regulator->rdev;
+	bool bypass;
+	int ret = 0;
+
+	if (!rdev->desc->ops->get_bypass)
+		return 0;
+
+	mutex_lock(&rdev->mutex);
+	ret = rdev->desc->ops->get_bypass(rdev, &bypass);
+	mutex_unlock(&rdev->mutex);
+
+	return ret ? ret : !!bypass;
+}
+EXPORT_SYMBOL_GPL(regulator_is_bypass);
+
+/**
  * regulator_register_notifier - register regulator event notifier
  * @regulator: regulator source
  * @nb: notifier block
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index ea0fffa..ba78511 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -261,6 +261,7 @@ int regulator_get_error_flags(struct regulator *regulator,
 int regulator_set_load(struct regulator *regulator, int load_uA);
 
 int regulator_allow_bypass(struct regulator *regulator, bool allow);
+int regulator_is_bypass(struct regulator *regulator);
 
 struct regmap *regulator_get_regmap(struct regulator *regulator);
 int regulator_get_hardware_vsel_register(struct regulator *regulator,
-- 
2.7.4
