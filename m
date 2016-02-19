From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 19 Feb 2016 08:43:04 +0100
Subject: [PATCH 04/12] spi: imx: drop fallback to PIO
In-Reply-To: <1455867792-26389-1-git-send-email-s.hauer@pengutronix.de>
References: <1455867792-26389-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1455867792-26389-5-git-send-email-s.hauer@pengutronix.de>
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
 drivers/spi/spi-imx.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index b277375..5a48d07 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -945,7 +945,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 					tx->sgl, tx->nents, DMA_MEM_TO_DEV,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!desc_tx)
-			goto no_dma;
+			return -EINVAL;
 
 		desc_tx->callback = spi_imx_dma_tx_callback;
 		desc_tx->callback_param = (void *)spi_imx;
@@ -957,7 +957,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 					rx->sgl, rx->nents, DMA_DEV_TO_MEM,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!desc_rx)
-			goto no_dma;
+			return -EINVAL;
 
 		desc_rx->callback = spi_imx_dma_rx_callback;
 		desc_rx->callback_param = (void *)spi_imx;
@@ -1010,10 +1010,6 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 		ret = transfer->len;
 
 	return ret;
-
-no_dma:
-	dev_warn_once(spi_imx->dev, "DMA not available, falling back to PIO\n");
-	return -EAGAIN;
 }
 
 static int spi_imx_pio_transfer(struct spi_device *spi,
@@ -1040,15 +1036,12 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
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
