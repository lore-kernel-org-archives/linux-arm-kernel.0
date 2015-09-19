From: jszhang@marvell.com (Jisheng Zhang)
Date: Sat, 19 Sep 2015 18:02:32 +0800
Subject: [PATCH 1/5] pinctrl: berlin: regmap as an extra argument of
 berlin_pinctrl_probe()
In-Reply-To: <1442656956-5740-1-git-send-email-jszhang@marvell.com>
References: <1442656956-5740-1-git-send-email-jszhang@marvell.com>
Message-ID: <1442656956-5740-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let berlin_pinctrl_probe() accepts an extra argument: regmap, this is to
prepare for the next berlin4ct support, where we won't use simple-mfd
any more.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/pinctrl/berlin/berlin-bg2.c   | 9 ++++++++-
 drivers/pinctrl/berlin/berlin-bg2cd.c | 9 ++++++++-
 drivers/pinctrl/berlin/berlin-bg2q.c  | 9 ++++++++-
 drivers/pinctrl/berlin/berlin.c       | 8 +-------
 drivers/pinctrl/berlin/berlin.h       | 1 +
 5 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/berlin/berlin-bg2.c b/drivers/pinctrl/berlin/berlin-bg2.c
index 274c553..b2be9be 100644
--- a/drivers/pinctrl/berlin/berlin-bg2.c
+++ b/drivers/pinctrl/berlin/berlin-bg2.c
@@ -233,8 +233,15 @@ static int berlin2_pinctrl_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match =
 		of_match_device(berlin2_pinctrl_match, &pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct device_node *parent_np = of_get_parent(dev->of_node);
+	struct regmap *regmap = syscon_node_to_regmap(parent_np);
 
-	return berlin_pinctrl_probe(pdev, match->data);
+	of_node_put(parent_np);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return berlin_pinctrl_probe(pdev, regmap, match->data);
 }
 
 static struct platform_driver berlin2_pinctrl_driver = {
diff --git a/drivers/pinctrl/berlin/berlin-bg2cd.c b/drivers/pinctrl/berlin/berlin-bg2cd.c
index 0cb793a..f88a6e5 100644
--- a/drivers/pinctrl/berlin/berlin-bg2cd.c
+++ b/drivers/pinctrl/berlin/berlin-bg2cd.c
@@ -176,8 +176,15 @@ static int berlin2cd_pinctrl_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match =
 		of_match_device(berlin2cd_pinctrl_match, &pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct device_node *parent_np = of_get_parent(dev->of_node);
+	struct regmap *regmap = syscon_node_to_regmap(parent_np);
 
-	return berlin_pinctrl_probe(pdev, match->data);
+	of_node_put(parent_np);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return berlin_pinctrl_probe(pdev, regmap, match->data);
 }
 
 static struct platform_driver berlin2cd_pinctrl_driver = {
diff --git a/drivers/pinctrl/berlin/berlin-bg2q.c b/drivers/pinctrl/berlin/berlin-bg2q.c
index a466054..c0bc0ec 100644
--- a/drivers/pinctrl/berlin/berlin-bg2q.c
+++ b/drivers/pinctrl/berlin/berlin-bg2q.c
@@ -395,8 +395,15 @@ static int berlin2q_pinctrl_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match =
 		of_match_device(berlin2q_pinctrl_match, &pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct device_node *parent_np = of_get_parent(dev->of_node);
+	struct regmap *regmap = syscon_node_to_regmap(parent_np);
 
-	return berlin_pinctrl_probe(pdev, match->data);
+	of_node_put(parent_np);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return berlin_pinctrl_probe(pdev, regmap, match->data);
 }
 
 static struct platform_driver berlin2q_pinctrl_driver = {
diff --git a/drivers/pinctrl/berlin/berlin.c b/drivers/pinctrl/berlin/berlin.c
index f495806..6d593b5 100644
--- a/drivers/pinctrl/berlin/berlin.c
+++ b/drivers/pinctrl/berlin/berlin.c
@@ -293,19 +293,13 @@ static struct pinctrl_desc berlin_pctrl_desc = {
 };
 
 int berlin_pinctrl_probe(struct platform_device *pdev,
+			 struct regmap *regmap,
 			 const struct berlin_pinctrl_desc *desc)
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
diff --git a/drivers/pinctrl/berlin/berlin.h b/drivers/pinctrl/berlin/berlin.h
index e1aa841..bf5781a 100644
--- a/drivers/pinctrl/berlin/berlin.h
+++ b/drivers/pinctrl/berlin/berlin.h
@@ -56,6 +56,7 @@ struct berlin_pinctrl_function {
 #define BERLIN_PINCTRL_FUNCTION_UNKNOWN		{}
 
 int berlin_pinctrl_probe(struct platform_device *pdev,
+			 struct regmap *regmap,
 			 const struct berlin_pinctrl_desc *desc);
 
 #endif /* __PINCTRL_BERLIN_H */
-- 
2.5.1
