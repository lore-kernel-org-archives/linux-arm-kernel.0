From: b32955@freescale.com (Huang Shijie)
Date: Wed, 23 Oct 2013 16:31:50 +0800
Subject: [PATCH] spi: spi-imx: only enable the clocks when we start to
 transfer a message
Message-ID: <1382517110-29913-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current code keeps the clocks enabled all the time, it wastes the power
when there is no operaiton on the spi controller.

In order to save the power, this patch adds the two hooks:
   spi_imx_prepare_message: enable the clocks for this message
   spi_imx_unprepare_message: disable the clocks.

This patch also disables the clocks in the end of the probe.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/spi/spi-imx.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 02d9f46..b80f2f7 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -749,6 +749,35 @@ static void spi_imx_cleanup(struct spi_device *spi)
 {
 }
 
+static int
+spi_imx_prepare_message(struct spi_master *master, struct spi_message *msg)
+{
+	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
+	int ret;
+
+	ret = clk_enable(spi_imx->clk_per);
+	if (ret)
+		return ret;
+
+	ret = clk_enable(spi_imx->clk_ipg);
+	if (ret) {
+		clk_disable(spi_imx->clk_per);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int
+spi_imx_unprepare_message(struct spi_master *master, struct spi_message *msg)
+{
+	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
+
+	clk_disable(spi_imx->clk_ipg);
+	clk_disable(spi_imx->clk_per);
+	return 0;
+}
+
 static int spi_imx_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -810,6 +839,8 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->bitbang.txrx_bufs = spi_imx_transfer;
 	spi_imx->bitbang.master->setup = spi_imx_setup;
 	spi_imx->bitbang.master->cleanup = spi_imx_cleanup;
+	spi_imx->bitbang.master->prepare_message = spi_imx_prepare_message;
+	spi_imx->bitbang.master->unprepare_message = spi_imx_unprepare_message;
 	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 
 	init_completion(&spi_imx->xfer_done);
@@ -872,6 +903,8 @@ static int spi_imx_probe(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "probed\n");
 
+	clk_disable(spi_imx->clk_ipg);
+	clk_disable(spi_imx->clk_per);
 	return ret;
 
 out_clk_put:
-- 
1.7.2.rc3
