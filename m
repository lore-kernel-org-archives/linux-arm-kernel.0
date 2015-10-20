From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Oct 2015 14:37:27 +0200
Subject: [PATCH 1/3] regulator: core: Factor out regulator_map_voltage
In-Reply-To: <1445344649-9559-1-git-send-email-s.hauer@pengutronix.de>
References: <1445344649-9559-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1445344649-9559-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

_regulator_call_set_voltage has code to translate a minimum/maximum
voltage pair into a selector. This code is useful for others aswell,
so create a regulator_map_voltage function.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/regulator/core.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 5bd54a5..fd22380 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2663,6 +2663,23 @@ int regulator_is_supported_voltage(struct regulator *regulator,
 }
 EXPORT_SYMBOL_GPL(regulator_is_supported_voltage);
 
+static int regulator_map_voltage(struct regulator_dev *rdev, int min_uV,
+				 int max_uV)
+{
+	const struct regulator_desc *desc = rdev->desc;
+
+	if (desc->ops->map_voltage)
+		return desc->ops->map_voltage(rdev, min_uV, max_uV);
+
+	if (desc->ops->list_voltage == regulator_list_voltage_linear)
+		return regulator_map_voltage_linear(rdev, min_uV, max_uV);
+
+	if (desc->ops->list_voltage == regulator_list_voltage_linear_range)
+		return regulator_map_voltage_linear_range(rdev, min_uV, max_uV);
+
+	return regulator_map_voltage_iterate(rdev, min_uV, max_uV);
+}
+
 static int _regulator_call_set_voltage(struct regulator_dev *rdev,
 				       int min_uV, int max_uV,
 				       unsigned *selector)
@@ -2751,23 +2768,7 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 		}
 
 	} else if (rdev->desc->ops->set_voltage_sel) {
-		if (rdev->desc->ops->map_voltage) {
-			ret = rdev->desc->ops->map_voltage(rdev, min_uV,
-							   max_uV);
-		} else {
-			if (rdev->desc->ops->list_voltage ==
-			    regulator_list_voltage_linear)
-				ret = regulator_map_voltage_linear(rdev,
-								min_uV, max_uV);
-			else if (rdev->desc->ops->list_voltage ==
-				 regulator_list_voltage_linear_range)
-				ret = regulator_map_voltage_linear_range(rdev,
-								min_uV, max_uV);
-			else
-				ret = regulator_map_voltage_iterate(rdev,
-								min_uV, max_uV);
-		}
-
+		ret = regulator_map_voltage(rdev, min_uV, max_uV);
 		if (ret >= 0) {
 			best_val = rdev->desc->ops->list_voltage(rdev, ret);
 			if (min_uV <= best_val && max_uV >= best_val) {
-- 
2.6.1
