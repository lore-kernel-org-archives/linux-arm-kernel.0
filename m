From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu,  1 Dec 2011 17:21:07 +0800
Subject: [PATCH v2 3/4] regulator: mc13892: add device tree probe support
In-Reply-To: <1322731268-12158-1-git-send-email-shawn.guo@linaro.org>
References: <1322731268-12158-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1322731268-12158-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds device tree probe support for mc13892-regulator driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
---
 drivers/regulator/mc13892-regulator.c      |   43 +++++++++++++++-----
 drivers/regulator/mc13xxx-regulator-core.c |   57 ++++++++++++++++++++++++++++
 drivers/regulator/mc13xxx.h                |   20 ++++++++++
 include/linux/mfd/mc13xxx.h                |    1 +
 4 files changed, 110 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/mc13892-regulator.c b/drivers/regulator/mc13892-regulator.c
index 2824804..46bfa4a 100644
--- a/drivers/regulator/mc13892-regulator.c
+++ b/drivers/regulator/mc13892-regulator.c
@@ -527,18 +527,27 @@ static int __devinit mc13892_regulator_probe(struct platform_device *pdev)
 	struct mc13xxx *mc13892 = dev_get_drvdata(pdev->dev.parent);
 	struct mc13xxx_regulator_platform_data *pdata =
 		dev_get_platdata(&pdev->dev);
-	struct mc13xxx_regulator_init_data *init_data;
+	struct mc13xxx_regulator_init_data *mc13xxx_data;
 	int i, ret;
+	int num_regulators = 0;
 	u32 val;
 
+	num_regulators = mc13xxx_get_num_regulators_dt(pdev);
+	if (num_regulators <= 0 && pdata)
+		num_regulators = pdata->num_regulators;
+	if (num_regulators <= 0)
+		return -EINVAL;
+
 	priv = kzalloc(sizeof(*priv) +
-		pdata->num_regulators * sizeof(priv->regulators[0]),
+		num_regulators * sizeof(priv->regulators[0]),
 		GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	priv->num_regulators = num_regulators;
 	priv->mc13xxx_regulators = mc13892_regulators;
 	priv->mc13xxx = mc13892;
+	platform_set_drvdata(pdev, priv);
 
 	mc13xxx_lock(mc13892);
 	ret = mc13xxx_reg_read(mc13892, MC13892_REVISION, &val);
@@ -569,11 +578,27 @@ static int __devinit mc13892_regulator_probe(struct platform_device *pdev)
 		= mc13892_vcam_set_mode;
 	mc13892_regulators[MC13892_VCAM].desc.ops->get_mode
 		= mc13892_vcam_get_mode;
-	for (i = 0; i < pdata->num_regulators; i++) {
-		init_data = &pdata->regulators[i];
+
+	mc13xxx_data = mc13xxx_parse_regulators_dt(pdev, mc13892_regulators,
+					ARRAY_SIZE(mc13892_regulators));
+	for (i = 0; i < num_regulators; i++) {
+		struct regulator_init_data *init_data;
+		struct regulator_desc *desc;
+		struct device_node *node = NULL;
+		int id;
+
+		if (mc13xxx_data) {
+			id = mc13xxx_data[i].id;
+			init_data = mc13xxx_data[i].init_data;
+			node = mc13xxx_data[i].node;
+		} else {
+			id = pdata->regulators[i].id;
+			init_data = pdata->regulators[i].init_data;
+		}
+		desc = &mc13892_regulators[id].desc;
+
 		priv->regulators[i] = regulator_register(
-			&mc13892_regulators[init_data->id].desc,
-			&pdev->dev, init_data->init_data, priv, NULL);
+			desc, &pdev->dev, init_data, priv, node);
 
 		if (IS_ERR(priv->regulators[i])) {
 			dev_err(&pdev->dev, "failed to register regulator %s\n",
@@ -583,8 +608,6 @@ static int __devinit mc13892_regulator_probe(struct platform_device *pdev)
 		}
 	}
 
-	platform_set_drvdata(pdev, priv);
-
 	return 0;
 err:
 	while (--i >= 0)
@@ -600,13 +623,11 @@ err_free:
 static int __devexit mc13892_regulator_remove(struct platform_device *pdev)
 {
 	struct mc13xxx_regulator_priv *priv = platform_get_drvdata(pdev);
-	struct mc13xxx_regulator_platform_data *pdata =
-		dev_get_platdata(&pdev->dev);
 	int i;
 
 	platform_set_drvdata(pdev, NULL);
 
-	for (i = 0; i < pdata->num_regulators; i++)
+	for (i = 0; i < priv->num_regulators; i++)
 		regulator_unregister(priv->regulators[i]);
 
 	kfree(priv);
diff --git a/drivers/regulator/mc13xxx-regulator-core.c b/drivers/regulator/mc13xxx-regulator-core.c
index 6532853..80ecafe 100644
--- a/drivers/regulator/mc13xxx-regulator-core.c
+++ b/drivers/regulator/mc13xxx-regulator-core.c
@@ -18,12 +18,14 @@
 #include <linux/mfd/mc13xxx.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
 #include <linux/platform_device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include "mc13xxx.h"
 
 static int mc13xxx_regulator_enable(struct regulator_dev *rdev)
@@ -236,6 +238,61 @@ int mc13xxx_sw_regulator_is_enabled(struct regulator_dev *rdev)
 }
 EXPORT_SYMBOL_GPL(mc13xxx_sw_regulator_is_enabled);
 
+#ifdef CONFIG_OF
+int __devinit mc13xxx_get_num_regulators_dt(struct platform_device *pdev)
+{
+	struct device_node *parent, *child;
+	int num = 0;
+
+	of_node_get(pdev->dev.parent->of_node);
+	parent = of_find_node_by_name(pdev->dev.parent->of_node, "regulators");
+	if (!parent)
+		return -ENODEV;
+
+	for_each_child_of_node(parent, child)
+		num++;
+
+	return num;
+}
+
+struct mc13xxx_regulator_init_data * __devinit mc13xxx_parse_regulators_dt(
+	struct platform_device *pdev, struct mc13xxx_regulator *regulators,
+	int num_regulators)
+{
+	struct mc13xxx_regulator_priv *priv = platform_get_drvdata(pdev);
+	struct mc13xxx_regulator_init_data *data, *p;
+	struct device_node *parent, *child;
+	int i;
+
+	of_node_get(pdev->dev.parent->of_node);
+	parent = of_find_node_by_name(pdev->dev.parent->of_node, "regulators");
+	if (!parent)
+		return NULL;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data) * priv->num_regulators,
+			    GFP_KERNEL);
+	if (!data)
+		return NULL;
+	p = data;
+
+	for_each_child_of_node(parent, child) {
+		for (i = 0; i < num_regulators; i++) {
+			if (!of_node_cmp(child->name,
+					 regulators[i].desc.name)) {
+				p->id = i;
+				p->init_data = of_get_regulator_init_data(
+							&pdev->dev, child);
+				p->node = child;
+				p++;
+				break;
+			}
+		}
+	}
+
+	return data;
+}
+#endif
+
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Yong Shen <yong.shen@linaro.org>");
 MODULE_DESCRIPTION("Regulator Driver for Freescale MC13xxx PMIC");
diff --git a/drivers/regulator/mc13xxx.h b/drivers/regulator/mc13xxx.h
index 2775826..419aee5 100644
--- a/drivers/regulator/mc13xxx.h
+++ b/drivers/regulator/mc13xxx.h
@@ -29,6 +29,7 @@ struct mc13xxx_regulator_priv {
 	struct mc13xxx *mc13xxx;
 	u32 powermisc_pwgt_state;
 	struct mc13xxx_regulator *mc13xxx_regulators;
+	int num_regulators;
 	struct regulator_dev *regulators[];
 };
 
@@ -42,6 +43,25 @@ extern int mc13xxx_fixed_regulator_set_voltage(struct regulator_dev *rdev,
 		int min_uV, int max_uV, unsigned *selector);
 extern int mc13xxx_fixed_regulator_get_voltage(struct regulator_dev *rdev);
 
+#ifdef CONFIG_OF
+extern int mc13xxx_get_num_regulators_dt(struct platform_device *pdev);
+extern struct mc13xxx_regulator_init_data *mc13xxx_parse_regulators_dt(
+	struct platform_device *pdev, struct mc13xxx_regulator *regulators,
+	int num_regulators);
+#else
+static inline int mc13xxx_get_num_regulators_dt(struct platform_device *pdev)
+{
+	return -ENODEV;
+}
+
+static inline struct mc13xxx_regulator_init_data *mc13xxx_parse_regulators_dt(
+	struct platform_device *pdev, struct mc13xxx_regulator *regulators,
+	int num_regulators)
+{
+	return NULL;
+}
+#endif
+
 extern struct regulator_ops mc13xxx_regulator_ops;
 extern struct regulator_ops mc13xxx_fixed_regulator_ops;
 
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index 3816c2f..a98e2a3 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -69,6 +69,7 @@ struct regulator_init_data;
 struct mc13xxx_regulator_init_data {
 	int id;
 	struct regulator_init_data *init_data;
+	struct device_node *node;
 };
 
 struct mc13xxx_regulator_platform_data {
-- 
1.7.4.1
