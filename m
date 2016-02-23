From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 23 Feb 2016 10:23:50 +0100
Subject: [PATCH 1/9] spi: imx: drop fallback to PIO
In-Reply-To: <1456219438-21205-1-git-send-email-s.hauer@pengutronix.de>
References: <1456219438-21205-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1456219438-21205-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the moment the driver decides to fallback to PIO mode the buffers
are already mapped for DMA. It's a bug to access them with the CPU
afterwards, so we cannot just fallback to PIO mode.
It should not be necessary anyway, since we only use DMA when we
verified that it's possible in the fist place, so when prep_slave_sg
fails it's a bug, either in the SDMA driver or in the can_dma
implementation.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/spi/spi-imx.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 6497fc9..a61b1b1 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -945,7 +945,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 					tx->sgl, tx->nents, DMA_MEM_TO_DEV,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!desc_tx)
-			goto tx_nodma;
+			return -EINVAL;
 
 		desc_tx->callback = spi_imx_dma_tx_callback;
 		desc_tx->callback_param = (void *)spi_imx;
@@ -956,8 +956,10 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 		desc_rx = dmaengine_prep_slave_sg(master->dma_rx,
 					rx->sgl, rx->nents, DMA_DEV_TO_MEM,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-		if (!desc_rx)
-			goto rx_nodma;
+		if (!desc_rx) {
+			dmaengine_terminate_all(master->dma_tx);
+			return -EINVAL;
+		}
 
 		desc_rx->callback = spi_imx_dma_rx_callback;
 		desc_rx->callback_param = (void *)spi_imx;
@@ -1010,12 +1012,6 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 		ret = transfer->len;
 
 	return ret;
-
-rx_nodma:
-	dmaengine_terminate_all(master->dma_tx);
-tx_nodma:
-	dev_warn_once(spi_imx->dev, "DMA not available, falling back to PIO\n");
-	return -EAGAIN;
 }
 
 static int spi_imx_pio_transfer(struct spi_device *spi,
@@ -1042,15 +1038,12 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 static int spi_imx_transfer(struct spi_device *spi,
 				struct spi_transfer *transfer)
 {
-	int ret;
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 
 	if (spi_imx->bitbang.master->can_dma &&
 	    spi_imx_can_dma(spi_imx->bitbang.master, spi, transfer)) {
 		spi_imx->usedma = true;
-		ret = spi_imx_dma_transfer(spi_imx, transfer);
-		if (ret != -EAGAIN)
-			return ret;
+		return spi_imx_dma_transfer(spi_imx, transfer);
 	}
 	spi_imx->usedma = false;
 
-- 
2.7.0
