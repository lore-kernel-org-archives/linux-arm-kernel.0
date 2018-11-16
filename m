From: matthias.bgg@kernel.org (matthias.bgg at kernel.org)
Date: Fri, 16 Nov 2018 13:54:49 +0100
Subject: [PATCH v5 12/12] clk: mediatek: mt6797: Probe with new compatible
In-Reply-To: <20181116125449.23581-1-matthias.bgg@kernel.org>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
Message-ID: <20181116125449.23581-13-matthias.bgg@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Brugger <mbrugger@suse.com>

The clock node is now a child of the mmsys node.
Update the driver to support this and thenew compatible
in the driver.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/clk/mediatek/clk-mt6797-mm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt6797-mm.c b/drivers/clk/mediatek/clk-mt6797-mm.c
index c57d3eed270d..051bab99d10f 100644
--- a/drivers/clk/mediatek/clk-mt6797-mm.c
+++ b/drivers/clk/mediatek/clk-mt6797-mm.c
@@ -101,7 +101,7 @@ static const struct mtk_gate mm_clks[] = {
 };
 
 static const struct of_device_id of_match_clk_mt6797_mm[] = {
-	{ .compatible = "mediatek,mt6797-mmsys", },
+	{ .compatible = "mediatek,mt6797-mmsys-clk", },
 	{}
 };
 
@@ -109,14 +109,15 @@ static int clk_mt6797_mm_probe(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
 	int r;
-	struct device_node *node = pdev->dev.of_node;
+	struct device *parent = pdev->dev.parent;
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR);
 
-	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
+	mtk_clk_register_gates(parent->of_node, mm_clks, ARRAY_SIZE(mm_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_provider(parent->of_node, of_clk_src_onecell_get,
+			clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
-- 
2.19.1
