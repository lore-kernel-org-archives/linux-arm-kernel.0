From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 30 Sep 2015 16:05:43 +0200
Subject: [PATCH 3/6] regulator: core: create unlocked version of
 regulator_list_voltage
In-Reply-To: <1443621946-8712-1-git-send-email-s.hauer@pengutronix.de>
References: <1443621946-8712-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1443621946-8712-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The unlocked version will be needed when we start propagating voltage
changes to the supply regulators.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/regulator/core.c | 62 +++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e5de3d9..d148545 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2343,6 +2343,40 @@ static int _regulator_is_enabled(struct regulator_dev *rdev)
 	return rdev->desc->ops->is_enabled(rdev);
 }
 
+static int _regulator_list_voltage(struct regulator *regulator,
+				    unsigned selector, int lock)
+{
+	struct regulator_dev *rdev = regulator->rdev;
+	const struct regulator_ops *ops = rdev->desc->ops;
+	int ret;
+
+	if (rdev->desc->fixed_uV && rdev->desc->n_voltages == 1 && !selector)
+		return rdev->desc->fixed_uV;
+
+	if (ops->list_voltage) {
+		if (selector >= rdev->desc->n_voltages)
+			return -EINVAL;
+		if (lock)
+			mutex_lock(&rdev->mutex);
+		ret = ops->list_voltage(rdev, selector);
+		if (lock)
+			mutex_unlock(&rdev->mutex);
+	} else if (rdev->supply) {
+		ret = _regulator_list_voltage(rdev->supply, selector, lock);
+	} else {
+		return -EINVAL;
+	}
+
+	if (ret > 0) {
+		if (ret < rdev->constraints->min_uV)
+			ret = 0;
+		else if (ret > rdev->constraints->max_uV)
+			ret = 0;
+	}
+
+	return ret;
+}
+
 /**
  * regulator_is_enabled - is the regulator output enabled
  * @regulator: regulator source
@@ -2432,33 +2466,7 @@ EXPORT_SYMBOL_GPL(regulator_count_voltages);
  */
 int regulator_list_voltage(struct regulator *regulator, unsigned selector)
 {
-	struct regulator_dev *rdev = regulator->rdev;
-	const struct regulator_ops *ops = rdev->desc->ops;
-	int ret;
-
-	if (rdev->desc->fixed_uV && rdev->desc->n_voltages == 1 && !selector)
-		return rdev->desc->fixed_uV;
-
-	if (ops->list_voltage) {
-		if (selector >= rdev->desc->n_voltages)
-			return -EINVAL;
-		mutex_lock(&rdev->mutex);
-		ret = ops->list_voltage(rdev, selector);
-		mutex_unlock(&rdev->mutex);
-	} else if (rdev->supply) {
-		ret = regulator_list_voltage(rdev->supply, selector);
-	} else {
-		return -EINVAL;
-	}
-
-	if (ret > 0) {
-		if (ret < rdev->constraints->min_uV)
-			ret = 0;
-		else if (ret > rdev->constraints->max_uV)
-			ret = 0;
-	}
-
-	return ret;
+	return _regulator_list_voltage(regulator, selector, 1);
 }
 EXPORT_SYMBOL_GPL(regulator_list_voltage);
 
-- 
2.5.3
