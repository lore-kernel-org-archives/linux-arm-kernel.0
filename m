From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Apr 2012 15:45:18 +0200
Subject: [PATCH 05/40] spi i.MX: do not depend on grouped clocks
In-Reply-To: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334065553-7565-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the current i.MX clock support groups together unrelated clocks
to a single clock which is then used by the driver. This can't
be accomplished with the generic clock framework so we instead
request the individual clocks in the driver. For i.MX there are
generally three different clocks:

ipg: bus clock (needed to access registers)
ahb: dma relevant clock, sometimes referred to as hclk in the datasheet
per: bit clock, pixel clock

This patch changes the driver to request the individual clocks.
Currently all clk_get will get the same clock until the SoCs
are converted to the generic clock framework

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/spi/spi-imx.c |   30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 31054e3..b54bfe8 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -85,7 +85,8 @@ struct spi_imx_data {
 	struct completion xfer_done;
 	void *base;
 	int irq;
-	struct clk *clk;
+	struct clk *clk_per;
+	struct clk *clk_ipg;
 	unsigned long spi_clk;
 
 	unsigned int count;
@@ -841,15 +842,22 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 		goto out_iounmap;
 	}
 
-	spi_imx->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(spi_imx->clk)) {
-		dev_err(&pdev->dev, "unable to get clock\n");
-		ret = PTR_ERR(spi_imx->clk);
+	spi_imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(spi_imx->clk_ipg)) {
+		ret = PTR_ERR(spi_imx->clk_ipg);
 		goto out_free_irq;
 	}
 
-	clk_enable(spi_imx->clk);
-	spi_imx->spi_clk = clk_get_rate(spi_imx->clk);
+	spi_imx->clk_per = devm_clk_get(&pdev->dev, "per");
+	if (IS_ERR(spi_imx->clk_per)) {
+		ret = PTR_ERR(spi_imx->clk_per);
+		goto out_free_irq;
+	}
+
+	clk_prepare_enable(spi_imx->clk_per);
+	clk_prepare_enable(spi_imx->clk_ipg);
+
+	spi_imx->spi_clk = clk_get_rate(spi_imx->clk_per);
 
 	spi_imx->devtype_data->reset(spi_imx);
 
@@ -867,8 +875,8 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 	return ret;
 
 out_clk_put:
-	clk_disable(spi_imx->clk);
-	clk_put(spi_imx->clk);
+	clk_disable_unprepare(spi_imx->clk_per);
+	clk_disable_unprepare(spi_imx->clk_ipg);
 out_free_irq:
 	free_irq(spi_imx->irq, spi_imx);
 out_iounmap:
@@ -896,8 +904,8 @@ static int __devexit spi_imx_remove(struct platform_device *pdev)
 	spi_bitbang_stop(&spi_imx->bitbang);
 
 	writel(0, spi_imx->base + MXC_CSPICTRL);
-	clk_disable(spi_imx->clk);
-	clk_put(spi_imx->clk);
+	clk_disable_unprepare(spi_imx->clk_per);
+	clk_disable_unprepare(spi_imx->clk_ipg);
 	free_irq(spi_imx->irq, spi_imx);
 	iounmap(spi_imx->base);
 
-- 
1.7.9.5
