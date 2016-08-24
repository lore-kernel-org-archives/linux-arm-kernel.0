From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 24 Aug 2016 15:40:30 +0900
Subject: [PATCH 2/2] reset: uniphier: use of_device_get_match_data() to get
 matched data
In-Reply-To: <1472020830-16059-1-git-send-email-yamada.masahiro@socionext.com>
References: <1472020830-16059-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1472020830-16059-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use of_device_get_match_data() instead of of_match_node().  With
this, we can retrieve the .data field of the OF match table more
easily.  No more need to define (or declare) the match table before
the probe callback.  I prefer to collect boilerplates at the bottom
of the file, so moved it below.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/reset/reset-uniphier.c | 81 +++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 41 deletions(-)

diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
index 41c62af..9b3f2cd 100644
--- a/drivers/reset/reset-uniphier.c
+++ b/drivers/reset/reset-uniphier.c
@@ -16,6 +16,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
@@ -285,6 +286,45 @@ static const struct reset_control_ops uniphier_reset_ops = {
 	.status = uniphier_reset_status,
 };
 
+static int uniphier_reset_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct uniphier_reset_priv *priv;
+	const struct uniphier_reset_data *p, *data;
+	struct regmap *regmap;
+	struct device_node *parent;
+	unsigned int nr_resets = 0;
+
+	data = of_device_get_match_data(dev);
+	WARN_ON(!data);
+
+	parent = of_get_parent(dev->of_node); /* parent should be syscon node */
+	regmap = syscon_node_to_regmap(parent);
+	of_node_put(parent);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "failed to get regmap (error %ld)\n",
+			PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	for (p = data; p->id != UNIPHIER_RESET_ID_END; p++)
+		nr_resets = max(nr_resets, p->id + 1);
+
+	priv->rcdev.ops = &uniphier_reset_ops;
+	priv->rcdev.owner = dev->driver->owner;
+	priv->rcdev.of_node = dev->of_node;
+	priv->rcdev.nr_resets = nr_resets;
+	priv->dev = dev;
+	priv->regmap = regmap;
+	priv->data = data;
+
+	return devm_reset_controller_register(&pdev->dev, &priv->rcdev);
+}
+
 static const struct of_device_id uniphier_reset_match[] = {
 	/* System reset */
 	{
@@ -385,47 +425,6 @@ static const struct of_device_id uniphier_reset_match[] = {
 };
 MODULE_DEVICE_TABLE(of, uniphier_reset_match);
 
-static int uniphier_reset_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	const struct of_device_id *match;
-	struct uniphier_reset_priv *priv;
-	const struct uniphier_reset_data *p;
-	struct regmap *regmap;
-	struct device_node *parent;
-	unsigned int nr_resets = 0;
-
-	match = of_match_node(uniphier_reset_match, pdev->dev.of_node);
-	if (!match)
-		return -ENODEV;
-
-	parent = of_get_parent(dev->of_node); /* parent should be syscon node */
-	regmap = syscon_node_to_regmap(parent);
-	of_node_put(parent);
-	if (IS_ERR(regmap)) {
-		dev_err(dev, "failed to get regmap (error %ld)\n",
-			PTR_ERR(regmap));
-		return PTR_ERR(regmap);
-	}
-
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	for (p = match->data; p->id != UNIPHIER_RESET_ID_END; p++)
-		nr_resets = max(nr_resets, p->id + 1);
-
-	priv->rcdev.ops = &uniphier_reset_ops;
-	priv->rcdev.owner = dev->driver->owner;
-	priv->rcdev.of_node = dev->of_node;
-	priv->rcdev.nr_resets = nr_resets;
-	priv->dev = dev;
-	priv->regmap = regmap;
-	priv->data = match->data;
-
-	return devm_reset_controller_register(&pdev->dev, &priv->rcdev);
-}
-
 static struct platform_driver uniphier_reset_driver = {
 	.probe = uniphier_reset_probe,
 	.driver = {
-- 
1.9.1
