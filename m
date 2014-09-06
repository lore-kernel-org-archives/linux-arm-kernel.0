From: wens@csie.org (Chen-Yu Tsai)
Date: Sat,  6 Sep 2014 18:47:28 +0800
Subject: [PATCH 7/7] dmaengine: sun6i: Remove obsolete clk muxing code
In-Reply-To: <1410000448-9999-1-git-send-email-wens@csie.org>
References: <1410000448-9999-1-git-send-email-wens@csie.org>
Message-ID: <1410000448-9999-8-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sun6i DMA controller requires the AHB1 bus clock to be
clocked from PLL6. This was originally done by the dmaengine
driver during probe time. The AHB1 clock driver has since been
unified, so the original code does not work.

Remove the clk muxing code, and replace it with DT clk default
properties.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/dma/sun6i-dma.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 1f92a56..3aa10b3 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -862,7 +862,6 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 {
 	struct sun6i_dma_dev *sdc;
 	struct resource *res;
-	struct clk *mux, *pll6;
 	int ret, i;
 
 	sdc = devm_kzalloc(&pdev->dev, sizeof(*sdc), GFP_KERNEL);
@@ -886,28 +885,6 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 		return PTR_ERR(sdc->clk);
 	}
 
-	mux = clk_get(NULL, "ahb1_mux");
-	if (IS_ERR(mux)) {
-		dev_err(&pdev->dev, "Couldn't get AHB1 Mux\n");
-		return PTR_ERR(mux);
-	}
-
-	pll6 = clk_get(NULL, "pll6");
-	if (IS_ERR(pll6)) {
-		dev_err(&pdev->dev, "Couldn't get PLL6\n");
-		clk_put(mux);
-		return PTR_ERR(pll6);
-	}
-
-	ret = clk_set_parent(mux, pll6);
-	clk_put(pll6);
-	clk_put(mux);
-
-	if (ret) {
-		dev_err(&pdev->dev, "Couldn't reparent AHB1 on PLL6\n");
-		return ret;
-	}
-
 	sdc->rstc = devm_reset_control_get(&pdev->dev, NULL);
 	if (IS_ERR(sdc->rstc)) {
 		dev_err(&pdev->dev, "No reset controller specified\n");
-- 
2.1.0
