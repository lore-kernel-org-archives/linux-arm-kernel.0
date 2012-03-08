From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  8 Mar 2012 22:42:29 +0100
Subject: [PATCH 2/2] spi i.MX: do not depend on grouped clocks
In-Reply-To: <1331242949-22780-1-git-send-email-s.hauer@pengutronix.de>
References: <1331242949-22780-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1331242949-22780-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/spi/spi-imx.c |   30 ++++++++++++++++++++----------
 1 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index c6e697f..dc32976 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -79,13 +79,20 @@ struct spi_imx_devtype_data {
 	enum spi_imx_devtype devtype;
 };
 
+enum {
+	CLK_PER,
+	CLK_IPG,
+};
+static const char *clknames[] = {"per", "ipg"};
+#define NUM_CLOCKS ARRAY_SIZE(clknames)
+
 struct spi_imx_data {
 	struct spi_bitbang bitbang;
 
 	struct completion xfer_done;
 	void *base;
 	int irq;
-	struct clk *clk;
+	struct clk *clk[NUM_CLOCKS];
 	unsigned long spi_clk;
 
 	unsigned int count;
@@ -846,15 +853,16 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 		goto out_iounmap;
 	}
 
-	spi_imx->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(spi_imx->clk)) {
+	ret = clk_get_array(&pdev->dev, spi_imx->clk, clknames, NUM_CLOCKS, 1);
+	if (ret) {
 		dev_err(&pdev->dev, "unable to get clock\n");
-		ret = PTR_ERR(spi_imx->clk);
 		goto out_free_irq;
 	}
 
-	clk_enable(spi_imx->clk);
-	spi_imx->spi_clk = clk_get_rate(spi_imx->clk);
+	clk_prepare_enable(spi_imx->clk[CLK_IPG]);
+	clk_prepare_enable(spi_imx->clk[CLK_PER]);
+
+	spi_imx->spi_clk = clk_get_rate(spi_imx->clk[CLK_PER]);
 
 	spi_imx->devtype_data->reset(spi_imx);
 
@@ -872,8 +880,9 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 	return ret;
 
 out_clk_put:
-	clk_disable(spi_imx->clk);
-	clk_put(spi_imx->clk);
+	clk_disable_unprepare(spi_imx->clk[CLK_PER]);
+	clk_disable_unprepare(spi_imx->clk[CLK_IPG]);
+	clk_put_array(spi_imx->clk, NUM_CLOCKS);
 out_free_irq:
 	free_irq(spi_imx->irq, spi_imx);
 out_iounmap:
@@ -901,8 +910,9 @@ static int __devexit spi_imx_remove(struct platform_device *pdev)
 	spi_bitbang_stop(&spi_imx->bitbang);
 
 	writel(0, spi_imx->base + MXC_CSPICTRL);
-	clk_disable(spi_imx->clk);
-	clk_put(spi_imx->clk);
+	clk_disable_unprepare(spi_imx->clk[CLK_PER]);
+	clk_disable_unprepare(spi_imx->clk[CLK_IPG]);
+	clk_put_array(spi_imx->clk, NUM_CLOCKS);
 	free_irq(spi_imx->irq, spi_imx);
 	iounmap(spi_imx->base);
 
-- 
1.7.9.1
