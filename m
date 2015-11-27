From: anton.bondarenko.sama@gmail.com (Anton Bondarenko)
Date: Sat, 28 Nov 2015 00:16:04 +0100
Subject: [PATCH v4 6/7] spi: imx: return error from dma channel request
In-Reply-To: <1448666165-7473-1-git-send-email-anton.bondarenko.sama@gmail.com>
References: <1448666165-7473-1-git-send-email-anton.bondarenko.sama@gmail.com>
Message-ID: <1448666165-7473-7-git-send-email-anton.bondarenko.sama@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On SDMA initialization return exactly the same error, which is
reported by dma_request_slave_channel_reason(), it is a preceding
change to defer SPI DMA initialization, if SDMA module is not yet
available.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Signed-off-by: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
---
 drivers/spi/spi-imx.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index f556eaa..aaa32c2 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -923,18 +923,20 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
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
 
-- 
2.6.3
