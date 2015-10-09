From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 9 Oct 2015 14:51:57 +0800
Subject: [PATCH v3 1/6] pinctrl: berlin: introduce
 berlin_pinctrl_probe_regmap()
In-Reply-To: <1444373522-2119-1-git-send-email-jszhang@marvell.com>
References: <1444373522-2119-1-git-send-email-jszhang@marvell.com>
Message-ID: <1444373522-2119-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is to prepare for the next berlin4ct support, where we won't use
simple-mfd any more.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/pinctrl/berlin/berlin.c | 26 +++++++++++++++++---------
 drivers/pinctrl/berlin/berlin.h |  4 ++++
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/berlin/berlin.c b/drivers/pinctrl/berlin/berlin.c
index f495806..898afa4 100644
--- a/drivers/pinctrl/berlin/berlin.c
+++ b/drivers/pinctrl/berlin/berlin.c
@@ -292,20 +292,14 @@ static struct pinctrl_desc berlin_pctrl_desc = {
 	.owner		= THIS_MODULE,
 };
 
-int berlin_pinctrl_probe(struct platform_device *pdev,
-			 const struct berlin_pinctrl_desc *desc)
+int berlin_pinctrl_probe_regmap(struct platform_device *pdev,
+				const struct berlin_pinctrl_desc *desc,
+				struct regmap *regmap)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *parent_np = of_get_parent(dev->of_node);
 	struct berlin_pinctrl *pctrl;
-	struct regmap *regmap;
 	int ret;
 
-	regmap = syscon_node_to_regmap(parent_np);
-	of_node_put(parent_np);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
-
 	pctrl = devm_kzalloc(dev, sizeof(*pctrl), GFP_KERNEL);
 	if (!pctrl)
 		return -ENOMEM;
@@ -330,3 +324,17 @@ int berlin_pinctrl_probe(struct platform_device *pdev,
 
 	return 0;
 }
+
+int berlin_pinctrl_probe(struct platform_device *pdev,
+			 const struct berlin_pinctrl_desc *desc)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *parent_np = of_get_parent(dev->of_node);
+	struct regmap *regmap = syscon_node_to_regmap(parent_np);
+
+	of_node_put(parent_np);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return berlin_pinctrl_probe_regmap(pdev, desc, regmap);
+}
diff --git a/drivers/pinctrl/berlin/berlin.h b/drivers/pinctrl/berlin/berlin.h
index e1aa841..dabbd2a 100644
--- a/drivers/pinctrl/berlin/berlin.h
+++ b/drivers/pinctrl/berlin/berlin.h
@@ -58,4 +58,8 @@ struct berlin_pinctrl_function {
 int berlin_pinctrl_probe(struct platform_device *pdev,
 			 const struct berlin_pinctrl_desc *desc);
 
+int berlin_pinctrl_probe_regmap(struct platform_device *pdev,
+				const struct berlin_pinctrl_desc *desc,
+				struct regmap *regmap);
+
 #endif /* __PINCTRL_BERLIN_H */
-- 
2.6.1
