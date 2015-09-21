From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 21 Sep 2015 18:04:15 +0800
Subject: [PATCH v2 1/6] pinctrl: berlin: regmap as an extra argument of
 berlin_pinctrl_probe()
In-Reply-To: <1442829860-4647-1-git-send-email-jszhang@marvell.com>
References: <1442829860-4647-1-git-send-email-jszhang@marvell.com>
Message-ID: <1442829860-4647-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let berlin_pinctrl_probe() accepts an extra argument: regmap, this is to
prepare for the next berlin4ct support, where we won't use simple-mfd
any more.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/pinctrl/berlin/berlin-bg2.c   | 10 +++++++++-
 drivers/pinctrl/berlin/berlin-bg2cd.c | 10 +++++++++-
 drivers/pinctrl/berlin/berlin-bg2q.c  | 10 +++++++++-
 drivers/pinctrl/berlin/berlin.c       |  9 +--------
 drivers/pinctrl/berlin/berlin.h       |  1 +
 5 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/berlin/berlin-bg2.c b/drivers/pinctrl/berlin/berlin-bg2.c
index 274c553..4aede2e 100644
--- a/drivers/pinctrl/berlin/berlin-bg2.c
+++ b/drivers/pinctrl/berlin/berlin-bg2.c
@@ -10,6 +10,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -233,8 +234,15 @@ static int berlin2_pinctrl_probe(struct platform_device *pdev)
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
index 0cb793a..6378dd8 100644
--- a/drivers/pinctrl/berlin/berlin-bg2cd.c
+++ b/drivers/pinctrl/berlin/berlin-bg2cd.c
@@ -10,6 +10,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -176,8 +177,15 @@ static int berlin2cd_pinctrl_probe(struct platform_device *pdev)
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
index a466054..907bdf0 100644
--- a/drivers/pinctrl/berlin/berlin-bg2q.c
+++ b/drivers/pinctrl/berlin/berlin-bg2q.c
@@ -10,6 +10,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -395,8 +396,15 @@ static int berlin2q_pinctrl_probe(struct platform_device *pdev)
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
index f495806..0557bbe 100644
--- a/drivers/pinctrl/berlin/berlin.c
+++ b/drivers/pinctrl/berlin/berlin.c
@@ -11,7 +11,6 @@
  */
 
 #include <linux/io.h>
-#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -293,19 +292,13 @@ static struct pinctrl_desc berlin_pctrl_desc = {
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
2.5.3
