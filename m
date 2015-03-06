From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri,  6 Mar 2015 16:05:23 +0100
Subject: [PATCH v2 05/10] pinctrl: berlin: use the regmap provided by syscon
In-Reply-To: <1425654328-26298-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1425654328-26298-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1425654328-26298-6-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Berlin pin controller nodes are now sub-nodes of the soc-controller
and the system-controller nodes. The register bank is managed by syscon,
which provides a regmap.

Remove the regmap setup from the Berlin pinctrl driver and use the one
provided by syscon.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/pinctrl/berlin/berlin-bg2.c   | 22 ----------------------
 drivers/pinctrl/berlin/berlin-bg2cd.c | 22 ----------------------
 drivers/pinctrl/berlin/berlin-bg2q.c  | 22 ----------------------
 drivers/pinctrl/berlin/berlin.c       |  9 ++++++---
 4 files changed, 6 insertions(+), 69 deletions(-)

diff --git a/drivers/pinctrl/berlin/berlin-bg2.c b/drivers/pinctrl/berlin/berlin-bg2.c
index b71a6fffef1b..368ec0b9b8ba 100644
--- a/drivers/pinctrl/berlin/berlin-bg2.c
+++ b/drivers/pinctrl/berlin/berlin-bg2.c
@@ -233,28 +233,6 @@ static int berlin2_pinctrl_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match =
 		of_match_device(berlin2_pinctrl_match, &pdev->dev);
-	struct regmap_config *rmconfig;
-	struct regmap *regmap;
-	struct resource *res;
-	void __iomem *base;
-
-	rmconfig = devm_kzalloc(&pdev->dev, sizeof(*rmconfig), GFP_KERNEL);
-	if (!rmconfig)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	rmconfig->reg_bits = 32,
-	rmconfig->val_bits = 32,
-	rmconfig->reg_stride = 4,
-	rmconfig->max_register = resource_size(res);
-
-	regmap = devm_regmap_init_mmio(&pdev->dev, base, rmconfig);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
 
 	return berlin_pinctrl_probe(pdev, match->data);
 }
diff --git a/drivers/pinctrl/berlin/berlin-bg2cd.c b/drivers/pinctrl/berlin/berlin-bg2cd.c
index 19ac5a22c947..6b9cae029ef7 100644
--- a/drivers/pinctrl/berlin/berlin-bg2cd.c
+++ b/drivers/pinctrl/berlin/berlin-bg2cd.c
@@ -176,28 +176,6 @@ static int berlin2cd_pinctrl_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match =
 		of_match_device(berlin2cd_pinctrl_match, &pdev->dev);
-	struct regmap_config *rmconfig;
-	struct regmap *regmap;
-	struct resource *res;
-	void __iomem *base;
-
-	rmconfig = devm_kzalloc(&pdev->dev, sizeof(*rmconfig), GFP_KERNEL);
-	if (!rmconfig)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	rmconfig->reg_bits = 32,
-	rmconfig->val_bits = 32,
-	rmconfig->reg_stride = 4,
-	rmconfig->max_register = resource_size(res);
-
-	regmap = devm_regmap_init_mmio(&pdev->dev, base, rmconfig);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
 
 	return berlin_pinctrl_probe(pdev, match->data);
 }
diff --git a/drivers/pinctrl/berlin/berlin-bg2q.c b/drivers/pinctrl/berlin/berlin-bg2q.c
index bd9662e57ad3..11aa10cc0e3e 100644
--- a/drivers/pinctrl/berlin/berlin-bg2q.c
+++ b/drivers/pinctrl/berlin/berlin-bg2q.c
@@ -395,28 +395,6 @@ static int berlin2q_pinctrl_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match =
 		of_match_device(berlin2q_pinctrl_match, &pdev->dev);
-	struct regmap_config *rmconfig;
-	struct regmap *regmap;
-	struct resource *res;
-	void __iomem *base;
-
-	rmconfig = devm_kzalloc(&pdev->dev, sizeof(*rmconfig), GFP_KERNEL);
-	if (!rmconfig)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	rmconfig->reg_bits = 32,
-	rmconfig->val_bits = 32,
-	rmconfig->reg_stride = 4,
-	rmconfig->max_register = resource_size(res);
-
-	regmap = devm_regmap_init_mmio(&pdev->dev, base, rmconfig);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
 
 	return berlin_pinctrl_probe(pdev, match->data);
 }
diff --git a/drivers/pinctrl/berlin/berlin.c b/drivers/pinctrl/berlin/berlin.c
index 7f0b0f93242b..2e3a8b8858ec 100644
--- a/drivers/pinctrl/berlin/berlin.c
+++ b/drivers/pinctrl/berlin/berlin.c
@@ -12,6 +12,7 @@
 
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -295,13 +296,15 @@ int berlin_pinctrl_probe(struct platform_device *pdev,
 			 const struct berlin_pinctrl_desc *desc)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *parent_np = of_get_parent(dev->of_node);
 	struct berlin_pinctrl *pctrl;
 	struct regmap *regmap;
 	int ret;
 
-	regmap = dev_get_regmap(&pdev->dev, NULL);
-	if (!regmap)
-		return -ENODEV;
+	regmap = syscon_node_to_regmap(parent_np);
+	of_node_put(parent_np);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
 
 	pctrl = devm_kzalloc(dev, sizeof(*pctrl), GFP_KERNEL);
 	if (!pctrl)
-- 
2.3.1
