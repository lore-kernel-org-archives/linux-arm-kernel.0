From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 19 May 2017 17:58:01 +0200
Subject: [PATCH 1/5] clk: mvebu: ap806: cosmetic improvement
In-Reply-To: <cover.fd6093dbad53cdac70eef4e53b238768721218ac.1495209464.git-series.gregory.clement@free-electrons.com>
References: <cover.fd6093dbad53cdac70eef4e53b238768721218ac.1495209464.git-series.gregory.clement@free-electrons.com>
Message-ID: <5a55e081d96fc6d2a28331b59df90f56d32a9f24.1495209464.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of using &pdev->dev all over the place, introduce a pointer
variable for it.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/clk/mvebu/ap806-system-controller.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mvebu/ap806-system-controller.c b/drivers/clk/mvebu/ap806-system-controller.c
index 8155baccc98e..b2666b5c944f 100644
--- a/drivers/clk/mvebu/ap806-system-controller.c
+++ b/drivers/clk/mvebu/ap806-system-controller.c
@@ -36,20 +36,21 @@ static int ap806_syscon_clk_probe(struct platform_device *pdev)
 {
 	unsigned int freq_mode, cpuclk_freq;
 	const char *name, *fixedclk_name;
-	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct regmap *regmap;
 	u32 reg;
 	int ret;
 
 	regmap = syscon_node_to_regmap(np);
 	if (IS_ERR(regmap)) {
-		dev_err(&pdev->dev, "cannot get regmap\n");
+		dev_err(dev, "cannot get regmap\n");
 		return PTR_ERR(regmap);
 	}
 
 	ret = regmap_read(regmap, AP806_SAR_REG, &reg);
 	if (ret) {
-		dev_err(&pdev->dev, "cannot read from regmap\n");
+		dev_err(dev, "cannot read from regmap\n");
 		return ret;
 	}
 
@@ -89,7 +90,7 @@ static int ap806_syscon_clk_probe(struct platform_device *pdev)
 		cpuclk_freq = 600;
 		break;
 	default:
-		dev_err(&pdev->dev, "invalid SAR value\n");
+		dev_err(dev, "invalid SAR value\n");
 		return -EINVAL;
 	}
 
@@ -99,7 +100,7 @@ static int ap806_syscon_clk_probe(struct platform_device *pdev)
 	/* CPU clocks depend on the Sample At Reset configuration */
 	of_property_read_string_index(np, "clock-output-names",
 				      0, &name);
-	ap806_clks[0] = clk_register_fixed_rate(&pdev->dev, name, NULL,
+	ap806_clks[0] = clk_register_fixed_rate(dev, name, NULL,
 						0, cpuclk_freq);
 	if (IS_ERR(ap806_clks[0])) {
 		ret = PTR_ERR(ap806_clks[0]);
@@ -108,7 +109,7 @@ static int ap806_syscon_clk_probe(struct platform_device *pdev)
 
 	of_property_read_string_index(np, "clock-output-names",
 				      1, &name);
-	ap806_clks[1] = clk_register_fixed_rate(&pdev->dev, name, NULL, 0,
+	ap806_clks[1] = clk_register_fixed_rate(dev, name, NULL, 0,
 						cpuclk_freq);
 	if (IS_ERR(ap806_clks[1])) {
 		ret = PTR_ERR(ap806_clks[1]);
@@ -118,7 +119,7 @@ static int ap806_syscon_clk_probe(struct platform_device *pdev)
 	/* Fixed clock is always 1200 Mhz */
 	of_property_read_string_index(np, "clock-output-names",
 				      2, &fixedclk_name);
-	ap806_clks[2] = clk_register_fixed_rate(&pdev->dev, fixedclk_name, NULL,
+	ap806_clks[2] = clk_register_fixed_rate(dev, fixedclk_name, NULL,
 						0, 1200 * 1000 * 1000);
 	if (IS_ERR(ap806_clks[2])) {
 		ret = PTR_ERR(ap806_clks[2]);
-- 
git-series 0.9.1
