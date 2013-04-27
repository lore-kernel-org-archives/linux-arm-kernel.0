From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 27 Apr 2013 10:29:24 +0400
Subject: [PATCH v2 1/2] regulator: mc13xxx: Add warning of incorrect names of
 regulators
Message-ID: <1367044165-6373-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a warning about incorrect regulators instead of
printing the names of non-information message about the wrong amount.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/regulator/mc13892-regulator.c      | 39 +++---------------------------
 drivers/regulator/mc13xxx-regulator-core.c | 17 +++++++++----
 drivers/regulator/mc13xxx.h                |  4 +--
 3 files changed, 17 insertions(+), 43 deletions(-)

diff --git a/drivers/regulator/mc13892-regulator.c b/drivers/regulator/mc13892-regulator.c
index 714377c..b716283 100644
--- a/drivers/regulator/mc13892-regulator.c
+++ b/drivers/regulator/mc13892-regulator.c
@@ -536,7 +536,7 @@ static int mc13892_regulator_probe(struct platform_device *pdev)
 	struct mc13xxx_regulator_init_data *mc13xxx_data;
 	struct regulator_config config = { };
 	int i, ret;
-	int num_regulators = 0, num_parsed;
+	int num_regulators = 0;
 	u32 val;
 
 	num_regulators = mc13xxx_get_num_regulators_dt(pdev);
@@ -546,8 +546,6 @@ static int mc13892_regulator_probe(struct platform_device *pdev)
 	if (num_regulators <= 0)
 		return -EINVAL;
 
-	num_parsed = num_regulators;
-
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv) +
 		num_regulators * sizeof(priv->regulators[0]),
 		GFP_KERNEL);
@@ -590,40 +588,9 @@ static int mc13892_regulator_probe(struct platform_device *pdev)
 		= mc13892_vcam_get_mode;
 
 	mc13xxx_data = mc13xxx_parse_regulators_dt(pdev, mc13892_regulators,
-					ARRAY_SIZE(mc13892_regulators),
-					&num_parsed);
-
-	/*
-	 * Perform a little sanity check on the regulator tree - if we found
-	 * a number of regulators from mc13xxx_get_num_regulators_dt and
-	 * then parsed a smaller number in mc13xxx_parse_regulators_dt then
-	 * there is a regulator defined in the regulators node which has
-	 * not matched any usable regulator in the driver. In this case,
-	 * there is one missing and what will happen is the first regulator
-	 * will get registered again.
-	 *
-	 * Fix this by basically making our number of registerable regulators
-	 * equal to the number of regulators we parsed. We are allocating
-	 * too much memory for priv, but this is unavoidable at this point.
-	 *
-	 * As an example of how this can happen, try making a typo in your
-	 * regulators node (vviohi {} instead of viohi {}) so that the name
-	 * does not match..
-	 *
-	 * The check will basically pass for platform data (non-DT) because
-	 * mc13xxx_parse_regulators_dt for !CONFIG_OF will not touch num_parsed.
-	 *
-	 */
-	if (num_parsed != num_regulators) {
-		dev_warn(&pdev->dev,
-		"parsed %d != regulators %d - check your device tree!\n",
-			num_parsed, num_regulators);
-
-		num_regulators = num_parsed;
-		priv->num_regulators = num_regulators;
-	}
+					ARRAY_SIZE(mc13892_regulators));
 
-	for (i = 0; i < num_regulators; i++) {
+	for (i = 0; i < priv->num_regulators; i++) {
 		struct regulator_init_data *init_data;
 		struct regulator_desc *desc;
 		struct device_node *node = NULL;
diff --git a/drivers/regulator/mc13xxx-regulator-core.c b/drivers/regulator/mc13xxx-regulator-core.c
index 23cf9f9..da48592 100644
--- a/drivers/regulator/mc13xxx-regulator-core.c
+++ b/drivers/regulator/mc13xxx-regulator-core.c
@@ -180,15 +180,13 @@ EXPORT_SYMBOL_GPL(mc13xxx_get_num_regulators_dt);
 
 struct mc13xxx_regulator_init_data *mc13xxx_parse_regulators_dt(
 	struct platform_device *pdev, struct mc13xxx_regulator *regulators,
-	int num_regulators, int *num_parsed)
+	int num_regulators)
 {
 	struct mc13xxx_regulator_priv *priv = platform_get_drvdata(pdev);
 	struct mc13xxx_regulator_init_data *data, *p;
 	struct device_node *parent, *child;
 	int i, parsed = 0;
 
-	*num_parsed = 0;
-
 	of_node_get(pdev->dev.parent->of_node);
 	parent = of_find_node_by_name(pdev->dev.parent->of_node, "regulators");
 	if (!parent)
@@ -204,10 +202,13 @@ struct mc13xxx_regulator_init_data *mc13xxx_parse_regulators_dt(
 	p = data;
 
 	for_each_child_of_node(parent, child) {
+		int found = 0;
+
 		for (i = 0; i < num_regulators; i++) {
+			if (!regulators[i].desc.name)
+				continue;
 			if (!of_node_cmp(child->name,
 					 regulators[i].desc.name)) {
-
 				p->id = i;
 				p->init_data = of_get_regulator_init_data(
 							&pdev->dev, child);
@@ -215,13 +216,19 @@ struct mc13xxx_regulator_init_data *mc13xxx_parse_regulators_dt(
 				p++;
 
 				parsed++;
+				found = 1;
 				break;
 			}
 		}
+
+		if (!found)
+			dev_warn(&pdev->dev,
+				 "Unknown regulator: %s\n", child->name);
 	}
 	of_node_put(parent);
 
-	*num_parsed = parsed;
+	priv->num_regulators = parsed;
+
 	return data;
 }
 EXPORT_SYMBOL_GPL(mc13xxx_parse_regulators_dt);
diff --git a/drivers/regulator/mc13xxx.h b/drivers/regulator/mc13xxx.h
index 007f833..06c8903 100644
--- a/drivers/regulator/mc13xxx.h
+++ b/drivers/regulator/mc13xxx.h
@@ -39,7 +39,7 @@ extern int mc13xxx_fixed_regulator_set_voltage(struct regulator_dev *rdev,
 extern int mc13xxx_get_num_regulators_dt(struct platform_device *pdev);
 extern struct mc13xxx_regulator_init_data *mc13xxx_parse_regulators_dt(
 	struct platform_device *pdev, struct mc13xxx_regulator *regulators,
-	int num_regulators, int *num_parsed);
+	int num_regulators);
 #else
 static inline int mc13xxx_get_num_regulators_dt(struct platform_device *pdev)
 {
@@ -48,7 +48,7 @@ static inline int mc13xxx_get_num_regulators_dt(struct platform_device *pdev)
 
 static inline struct mc13xxx_regulator_init_data *mc13xxx_parse_regulators_dt(
 	struct platform_device *pdev, struct mc13xxx_regulator *regulators,
-	int num_regulators, int *num_parsed)
+	int num_regulators)
 {
 	return NULL;
 }
-- 
1.8.1.5
