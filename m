From: matthias.bgg@kernel.org (matthias.bgg at kernel.org)
Date: Fri, 16 Nov 2018 13:54:48 +0100
Subject: [PATCH v5 11/12] clk: mediatek: mt2712e: Probe with new compatible
In-Reply-To: <20181116125449.23581-1-matthias.bgg@kernel.org>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
Message-ID: <20181116125449.23581-12-matthias.bgg@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Brugger <mbrugger@suse.com>

The clock node is now a child of the mmsys node.
Update the driver to support this and thenew compatible
in the driver.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/clk/mediatek/clk-mt2712-mm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2712-mm.c b/drivers/clk/mediatek/clk-mt2712-mm.c
index a8b4b6d42488..5f4ee8f0deaa 100644
--- a/drivers/clk/mediatek/clk-mt2712-mm.c
+++ b/drivers/clk/mediatek/clk-mt2712-mm.c
@@ -138,14 +138,15 @@ static int clk_mt2712_mm_probe(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
 	int r;
-	struct device_node *node = pdev->dev.of_node;
+	struct device	parent = pdev->dev.parent;
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
 
-	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
+	mtk_clk_register_gates(parent->of_node, mm_clks, ARRAY_SIZE(mm_clks),
 			clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_provider(parent->of_node, of_clk_src_onecell_get,
+			clk_data);
 
 	if (r != 0)
 		pr_err("%s(): could not register clock provider: %d\n",
@@ -155,7 +156,7 @@ static int clk_mt2712_mm_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id of_match_clk_mt2712_mm[] = {
-	{ .compatible = "mediatek,mt2712-mmsys", },
+	{ .compatible = "mediatek,mt2712-mmsys-clk", },
 	{}
 };
 
-- 
2.19.1
