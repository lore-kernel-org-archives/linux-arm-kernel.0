From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 30 Dec 2017 19:30:40 +0800
Subject: [PATCH v4 3/6] clk: sunxi-ng: add support for Allwinner A64 DE2 CCU
In-Reply-To: <20171230113043.30237-1-icenowy@aosc.io>
References: <20171230113043.30237-1-icenowy@aosc.io>
Message-ID: <20171230113043.30237-4-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A64's DE2 needs to claim a section of SRAM (SRAM C) to work.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v4:
- Use a struct to maintain both ccu desc and quirks as Chen-Yu Tsai
  suggested.

 drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 117 +++++++++++++++++++++++------------
 1 file changed, 77 insertions(+), 40 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
index 468d1abaf0ee..b65953b32bd0 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -17,6 +17,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
+#include <linux/soc/sunxi/sunxi_sram.h>
 
 #include "ccu_common.h"
 #include "ccu_div.h"
@@ -156,44 +157,70 @@ static struct ccu_reset_map sun50i_a64_de2_resets[] = {
 	[RST_WB]	= { 0x08, BIT(2) },
 };
 
-static const struct sunxi_ccu_desc sun8i_a83t_de2_clk_desc = {
-	.ccu_clks	= sun8i_a83t_de2_clks,
-	.num_ccu_clks	= ARRAY_SIZE(sun8i_a83t_de2_clks),
+struct de2_ccu {
+	struct sunxi_ccu_desc desc;
+	bool sram_needed;
+};
+
+static const struct de2_ccu sun8i_a83t_de2_clk = {
+	.desc = {
+		.ccu_clks	= sun8i_a83t_de2_clks,
+		.num_ccu_clks	= ARRAY_SIZE(sun8i_a83t_de2_clks),
+
+		.hw_clks	= &sun8i_a83t_de2_hw_clks,
+
+		.resets		= sun8i_a83t_de2_resets,
+		.num_resets	= ARRAY_SIZE(sun8i_a83t_de2_resets),
+	},
+};
+
+static const struct de2_ccu sun8i_h3_de2_clk = {
+	.desc = {
+		.ccu_clks	= sun8i_h3_de2_clks,
+		.num_ccu_clks	= ARRAY_SIZE(sun8i_h3_de2_clks),
 
-	.hw_clks	= &sun8i_a83t_de2_hw_clks,
+		.hw_clks	= &sun8i_h3_de2_hw_clks,
 
-	.resets		= sun8i_a83t_de2_resets,
-	.num_resets	= ARRAY_SIZE(sun8i_a83t_de2_resets),
+		.resets		= sun8i_a83t_de2_resets,
+		.num_resets	= ARRAY_SIZE(sun8i_a83t_de2_resets),
+	},
 };
 
-static const struct sunxi_ccu_desc sun8i_h3_de2_clk_desc = {
-	.ccu_clks	= sun8i_h3_de2_clks,
-	.num_ccu_clks	= ARRAY_SIZE(sun8i_h3_de2_clks),
+static const struct de2_ccu sun50i_a64_de2_clk = {
+	.desc = {
+		.ccu_clks	= sun8i_h3_de2_clks,
+		.num_ccu_clks	= ARRAY_SIZE(sun8i_h3_de2_clks),
 
-	.hw_clks	= &sun8i_h3_de2_hw_clks,
+		.hw_clks	= &sun8i_h3_de2_hw_clks,
 
-	.resets		= sun8i_a83t_de2_resets,
-	.num_resets	= ARRAY_SIZE(sun8i_a83t_de2_resets),
+		.resets		= sun50i_a64_de2_resets,
+		.num_resets	= ARRAY_SIZE(sun50i_a64_de2_resets),
+	},
+	.sram_needed = true,
 };
 
-static const struct sunxi_ccu_desc sun50i_a64_de2_clk_desc = {
-	.ccu_clks	= sun8i_h3_de2_clks,
-	.num_ccu_clks	= ARRAY_SIZE(sun8i_h3_de2_clks),
+static const struct de2_ccu sun50i_h5_de2_clk = {
+	.desc = {
+		.ccu_clks	= sun8i_h3_de2_clks,
+		.num_ccu_clks	= ARRAY_SIZE(sun8i_h3_de2_clks),
 
-	.hw_clks	= &sun8i_h3_de2_hw_clks,
+		.hw_clks	= &sun8i_h3_de2_hw_clks,
 
-	.resets		= sun50i_a64_de2_resets,
-	.num_resets	= ARRAY_SIZE(sun50i_a64_de2_resets),
+		.resets		= sun50i_a64_de2_resets,
+		.num_resets	= ARRAY_SIZE(sun50i_a64_de2_resets),
+	},
 };
 
-static const struct sunxi_ccu_desc sun8i_v3s_de2_clk_desc = {
-	.ccu_clks	= sun8i_v3s_de2_clks,
-	.num_ccu_clks	= ARRAY_SIZE(sun8i_v3s_de2_clks),
+static const struct de2_ccu sun8i_v3s_de2_clk = {
+	.desc = {
+		.ccu_clks	= sun8i_v3s_de2_clks,
+		.num_ccu_clks	= ARRAY_SIZE(sun8i_v3s_de2_clks),
 
-	.hw_clks	= &sun8i_v3s_de2_hw_clks,
+		.hw_clks	= &sun8i_v3s_de2_hw_clks,
 
-	.resets		= sun8i_a83t_de2_resets,
-	.num_resets	= ARRAY_SIZE(sun8i_a83t_de2_resets),
+		.resets		= sun8i_a83t_de2_resets,
+		.num_resets	= ARRAY_SIZE(sun8i_a83t_de2_resets),
+	},
 };
 
 static int sunxi_de2_clk_probe(struct platform_device *pdev)
@@ -202,11 +229,11 @@ static int sunxi_de2_clk_probe(struct platform_device *pdev)
 	struct clk *bus_clk, *mod_clk;
 	struct reset_control *rstc;
 	void __iomem *reg;
-	const struct sunxi_ccu_desc *ccu_desc;
+	const struct de2_ccu *ccu;
 	int ret;
 
-	ccu_desc = of_device_get_match_data(&pdev->dev);
-	if (!ccu_desc)
+	ccu = of_device_get_match_data(&pdev->dev);
+	if (!ccu)
 		return -EINVAL;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -239,11 +266,20 @@ static int sunxi_de2_clk_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (ccu->sram_needed) {
+		ret = sunxi_sram_claim(&pdev->dev);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Error couldn't map SRAM to device\n");
+			return ret;
+		}
+	}
+
 	/* The clocks need to be enabled for us to access the registers */
 	ret = clk_prepare_enable(bus_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "Couldn't enable bus clk: %d\n", ret);
-		return ret;
+		goto err_release_sram;
 	}
 
 	ret = clk_prepare_enable(mod_clk);
@@ -260,7 +296,7 @@ static int sunxi_de2_clk_probe(struct platform_device *pdev)
 		goto err_disable_mod_clk;
 	}
 
-	ret = sunxi_ccu_probe(pdev->dev.of_node, reg, ccu_desc);
+	ret = sunxi_ccu_probe(pdev->dev.of_node, reg, &ccu->desc);
 	if (ret)
 		goto err_assert_reset;
 
@@ -272,33 +308,34 @@ static int sunxi_de2_clk_probe(struct platform_device *pdev)
 	clk_disable_unprepare(mod_clk);
 err_disable_bus_clk:
 	clk_disable_unprepare(bus_clk);
+err_release_sram:
+	if (ccu->sram_needed)
+		sunxi_sram_release(&pdev->dev);
+
 	return ret;
 }
 
 static const struct of_device_id sunxi_de2_clk_ids[] = {
 	{
 		.compatible = "allwinner,sun8i-a83t-de2-clk",
-		.data = &sun8i_a83t_de2_clk_desc,
+		.data = &sun8i_a83t_de2_clk,
 	},
 	{
 		.compatible = "allwinner,sun8i-h3-de2-clk",
-		.data = &sun8i_h3_de2_clk_desc,
+		.data = &sun8i_h3_de2_clk,
 	},
 	{
 		.compatible = "allwinner,sun8i-v3s-de2-clk",
-		.data = &sun8i_v3s_de2_clk_desc,
+		.data = &sun8i_v3s_de2_clk,
+	},
+	{
+		.compatible = "allwinner,sun50i-a64-de2-clk",
+		.data = &sun50i_a64_de2_clk,
 	},
 	{
 		.compatible = "allwinner,sun50i-h5-de2-clk",
-		.data = &sun50i_a64_de2_clk_desc,
+		.data = &sun50i_h5_de2_clk,
 	},
-	/*
-	 * The Allwinner A64 SoC needs some bit to be poke in syscon to make
-	 * DE2 really working.
-	 * So there's currently no A64 compatible here.
-	 * H5 shares the same reset line with A64, so here H5 is using the
-	 * clock description of A64.
-	 */
 	{ }
 };
 
-- 
2.14.2
