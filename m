From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 16 May 2015 02:23:37 +0200
Subject: [PATCH 08/14] pinctrl: berlin: drop SoC stub provided regmap
In-Reply-To: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1431735823-28006-9-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antoine Tenart <antoine.tenart@free-electrons.com>

With convertsion to simple-mfd sub-nodes, drop the regmap registration
by SoC stubs.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/berlin/berlin-bg2.c   | 30 ------------------------------
 drivers/pinctrl/berlin/berlin-bg2cd.c | 30 ------------------------------
 drivers/pinctrl/berlin/berlin-bg2q.c  | 30 ------------------------------
 drivers/pinctrl/berlin/berlin.c       |  4 +---
 4 files changed, 1 insertion(+), 93 deletions(-)

diff --git a/drivers/pinctrl/berlin/berlin-bg2.c b/drivers/pinctrl/berlin/berlin-bg2.c
index 6931ce4b1e12..3769eaedf519 100644
--- a/drivers/pinctrl/berlin/berlin-bg2.c
+++ b/drivers/pinctrl/berlin/berlin-bg2.c
@@ -218,14 +218,6 @@ static const struct berlin_pinctrl_desc berlin2_sysmgr_pinctrl_data = {
 
 static const struct of_device_id berlin2_pinctrl_match[] = {
 	{
-		.compatible = "marvell,berlin2-chip-ctrl",
-		.data = &berlin2_soc_pinctrl_data
-	},
-	{
-		.compatible = "marvell,berlin2-system-ctrl",
-		.data = &berlin2_sysmgr_pinctrl_data
-	},
-	{
 		.compatible = "marvell,berlin2-soc-pinctrl",
 		.data = &berlin2_soc_pinctrl_data
 	},
@@ -241,28 +233,6 @@ static int berlin2_pinctrl_probe(struct platform_device *pdev)
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
index 18e1af0e6b8c..9e11f191d643 100644
--- a/drivers/pinctrl/berlin/berlin-bg2cd.c
+++ b/drivers/pinctrl/berlin/berlin-bg2cd.c
@@ -161,14 +161,6 @@ static const struct berlin_pinctrl_desc berlin2cd_sysmgr_pinctrl_data = {
 
 static const struct of_device_id berlin2cd_pinctrl_match[] = {
 	{
-		.compatible = "marvell,berlin2cd-chip-ctrl",
-		.data = &berlin2cd_soc_pinctrl_data
-	},
-	{
-		.compatible = "marvell,berlin2cd-system-ctrl",
-		.data = &berlin2cd_sysmgr_pinctrl_data
-	},
-	{
 		.compatible = "marvell,berlin2cd-soc-pinctrl",
 		.data = &berlin2cd_soc_pinctrl_data
 	},
@@ -184,28 +176,6 @@ static int berlin2cd_pinctrl_probe(struct platform_device *pdev)
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
index 24e4cbb4d044..ba7a8a8ad010 100644
--- a/drivers/pinctrl/berlin/berlin-bg2q.c
+++ b/drivers/pinctrl/berlin/berlin-bg2q.c
@@ -380,14 +380,6 @@ static const struct berlin_pinctrl_desc berlin2q_sysmgr_pinctrl_data = {
 
 static const struct of_device_id berlin2q_pinctrl_match[] = {
 	{
-		.compatible = "marvell,berlin2q-chip-ctrl",
-		.data = &berlin2q_soc_pinctrl_data,
-	},
-	{
-		.compatible = "marvell,berlin2q-system-ctrl",
-		.data = &berlin2q_sysmgr_pinctrl_data,
-	},
-	{
 		.compatible = "marvell,berlin2q-soc-pinctrl",
 		.data = &berlin2q_soc_pinctrl_data,
 	},
@@ -403,28 +395,6 @@ static int berlin2q_pinctrl_probe(struct platform_device *pdev)
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
index 28551123d04f..65b0e211b89e 100644
--- a/drivers/pinctrl/berlin/berlin.c
+++ b/drivers/pinctrl/berlin/berlin.c
@@ -301,9 +301,7 @@ int berlin_pinctrl_probe(struct platform_device *pdev,
 	struct regmap *regmap;
 	int ret;
 
-	regmap = dev_get_regmap(&pdev->dev, NULL);
-	if (!regmap)
-		regmap = syscon_node_to_regmap(parent_np);
+	regmap = syscon_node_to_regmap(parent_np);
 	of_node_put(parent_np);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
-- 
2.1.0
