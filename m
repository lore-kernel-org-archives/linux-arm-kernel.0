From: Stefan.Potyra@elektrobit.com (Stefan Potyra)
Date: Thu, 19 Apr 2018 15:03:58 +0200
Subject: [PATCH] Enable the clock before calling clk_get_rate().
Message-ID: <20180419130358.r7dva6owy2izyfus@agrajag.zerfleddert.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 142168eba9dc spi: bcm63xx-hsspi: add bcm63xx HSSPI driver
Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index cbcba614b253..46cd9b683d22 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -352,6 +352,10 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ret;
+
 	rate = clk_get_rate(clk);
 	if (!rate) {
 		struct clk *pll_clk = devm_clk_get(dev, "pll");
@@ -364,10 +368,6 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 			return -EINVAL;
 	}
 
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ret;
-
 	master = spi_alloc_master(&pdev->dev, sizeof(*bs));
 	if (!master) {
 		ret = -ENOMEM;
-- 
2.17.0
