From: anton.bondarenko.sama@gmail.com (Anton Bondarenko)
Date: Sat,  5 Dec 2015 17:57:04 +0100
Subject: [PATCH v5 06/11] spi: imx: return error from dma channel request
In-Reply-To: <1449334629-4715-1-git-send-email-anton.bondarenko.sama@gmail.com>
References: <1449334629-4715-1-git-send-email-anton.bondarenko.sama@gmail.com>
Message-ID: <1449334629-4715-7-git-send-email-anton.bondarenko.sama@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On SDMA initialization return exactly the same error, which is
reported by dma_request_slave_channel_reason(), it is a preceding
change to defer SPI DMA initialization, if SDMA module is not yet
available.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Signed-off-by: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
---
 drivers/spi/spi-imx.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 3525616..277dd75 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -846,10 +846,11 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	spi_imx->wml = spi_imx_get_fifosize(spi_imx) / 2;
 
 	/* Prepare for TX DMA: */
-	master->dma_tx = dma_request_slave_channel(dev, "tx");
-	if (!master->dma_tx) {
-		dev_err(dev, "cannot get the TX DMA channel!\n");
-		ret = -EINVAL;
+	master->dma_tx = dma_request_slave_channel_reason(dev, "tx");
+	if (IS_ERR(master->dma_tx)) {
+		dev_info(dev, "cannot get the TX DMA channel!\n");
+		ret = PTR_ERR(master->dma_tx);
+		master->dma_tx = NULL;
 		goto err;
 	}
 
@@ -864,10 +865,11 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	}
 
 	/* Prepare for RX : */
-	master->dma_rx = dma_request_slave_channel(dev, "rx");
-	if (!master->dma_rx) {
-		dev_dbg(dev, "cannot get the DMA channel.\n");
-		ret = -EINVAL;
+	master->dma_rx = dma_request_slave_channel_reason(dev, "rx");
+	if (IS_ERR(master->dma_rx)) {
+		dev_info(dev, "cannot get the DMA channel.\n");
+		ret = PTR_ERR(master->dma_rx);
+		master->dma_rx = NULL;
 		goto err;
 	}
 
@@ -1217,9 +1219,12 @@ static int spi_imx_probe(struct platform_device *pdev)
 	 * Only validated on i.mx6 now, can remove the constrain if validated on
 	 * other chips.
 	 */
-	if (is_imx51_ecspi(spi_imx) &&
-	    spi_imx_sdma_init(&pdev->dev, spi_imx, master, res))
-		dev_err(&pdev->dev, "dma setup error,use pio instead\n");
+	if (is_imx51_ecspi(spi_imx)) {
+		ret = spi_imx_sdma_init(&pdev->dev, spi_imx, master, res);
+		if (ret < 0)
+			dev_err(&pdev->dev, "dma setup error %d, use pio\n",
+				ret);
+	}
 
 	spi_imx->devtype_data->reset(spi_imx);
 
-- 
2.6.3
