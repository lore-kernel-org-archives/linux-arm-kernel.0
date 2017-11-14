From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 14 Nov 2017 22:41:10 +0100
Subject: [PATCH 4/8] clk: mediatek: mt2701-mm: switch to mfd device
In-Reply-To: <20171114214114.15793-1-mbrugger@suse.com>
References: <20171114214114.15793-1-mbrugger@suse.com>
Message-ID: <20171114214114.15793-5-mbrugger@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the new mfd device is in place, switch probing
for the MMSYS to support invocation from the mfd device.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/clk/mediatek/clk-mt2701-mm.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-mm.c b/drivers/clk/mediatek/clk-mt2701-mm.c
index fe1f85072fc5..1725c2c17ca3 100644
--- a/drivers/clk/mediatek/clk-mt2701-mm.c
+++ b/drivers/clk/mediatek/clk-mt2701-mm.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/mfd/mmsys.h>
 #include <linux/platform_device.h>
 
 #include "clk-mtk.h"
@@ -87,16 +88,15 @@ static const struct mtk_gate mm_clks[] = {
 	GATE_DISP1(CLK_MM_TVE_FMM, "mm_tve_fmm", "mm_sel", 14),
 };
 
-static const struct of_device_id of_match_clk_mt2701_mm[] = {
-	{ .compatible = "mediatek,mt2701-mmsys", },
-	{}
-};
-
 static int clk_mt2701_mm_probe(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
 	int r;
-	struct device_node *node = pdev->dev.of_node;
+	struct device_node *node;
+	struct mmsys_dev *mmsys_private;
+
+	mmsys_private = dev_get_drvdata(pdev->dev.parent);
+	node = mmsys_private->of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR);
 
@@ -116,7 +116,6 @@ static struct platform_driver clk_mt2701_mm_drv = {
 	.probe = clk_mt2701_mm_probe,
 	.driver = {
 		.name = "clk-mt2701-mm",
-		.of_match_table = of_match_clk_mt2701_mm,
 	},
 };
 
-- 
2.14.2
