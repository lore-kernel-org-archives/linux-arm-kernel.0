From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 24 Feb 2016 09:20:33 +0100
Subject: [PATCH 9/9] spi: imx: drop bogus tests for rx/tx bufs in DMA transfer
In-Reply-To: <1456302033-25638-1-git-send-email-s.hauer@pengutronix.de>
References: <1456302033-25638-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1456302033-25638-10-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver tries to be clever by only setting up DMA channels when
the corresponding sg tables are non NULL. The sg tables are embedded
structs in struct spi_transfer, so they are guaranteed to be non NULL
which makes the if(tx)/if(rx) tests completely bogus. The driver even
sets the SPI_MASTER_MUST_RX / SPI_MASTER_MUST_TX flags which makes sure
the sg tables are not only present but also non empty.
Drop the tests and make the DMA path easier to follow.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/spi/spi-imx.c | 82 +++++++++++++++++++++------------------------------
 1 file changed, 34 insertions(+), 48 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 91890b2..e7a19be 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -974,51 +974,40 @@ static int spi_imx_calculate_timeout(struct spi_imx_data *spi_imx, int size)
 static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 				struct spi_transfer *transfer)
 {
-	struct dma_async_tx_descriptor *desc_tx = NULL, *desc_rx = NULL;
-	int ret;
+	struct dma_async_tx_descriptor *desc_tx, *desc_rx;
 	unsigned long transfer_timeout;
 	unsigned long timeout;
 	struct spi_master *master = spi_imx->bitbang.master;
 	struct sg_table *tx = &transfer->tx_sg, *rx = &transfer->rx_sg;
 
-	if (tx) {
-		desc_tx = dmaengine_prep_slave_sg(master->dma_tx,
-					tx->sgl, tx->nents, DMA_MEM_TO_DEV,
-					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-		if (!desc_tx)
-			return -EINVAL;
-
-		desc_tx->callback = spi_imx_dma_tx_callback;
-		desc_tx->callback_param = (void *)spi_imx;
-		dmaengine_submit(desc_tx);
-	}
+	/*
+	 * The TX DMA setup starts the transfer, so make sure RX is configured
+	 * before TX.
+	 */
+	desc_rx = dmaengine_prep_slave_sg(master->dma_rx,
+				rx->sgl, rx->nents, DMA_DEV_TO_MEM,
+				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc_rx)
+		return -EINVAL;
 
-	if (rx) {
-		desc_rx = dmaengine_prep_slave_sg(master->dma_rx,
-					rx->sgl, rx->nents, DMA_DEV_TO_MEM,
-					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-		if (!desc_rx) {
-			dmaengine_terminate_all(master->dma_tx);
-			return -EINVAL;
-		}
+	desc_rx->callback = spi_imx_dma_rx_callback;
+	desc_rx->callback_param = (void *)spi_imx;
+	dmaengine_submit(desc_rx);
+	reinit_completion(&spi_imx->dma_rx_completion);
+	dma_async_issue_pending(master->dma_rx);
 
-		desc_rx->callback = spi_imx_dma_rx_callback;
-		desc_rx->callback_param = (void *)spi_imx;
-		dmaengine_submit(desc_rx);
+	desc_tx = dmaengine_prep_slave_sg(master->dma_tx,
+				tx->sgl, tx->nents, DMA_MEM_TO_DEV,
+				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc_tx) {
+		dmaengine_terminate_all(master->dma_tx);
+		return -EINVAL;
 	}
 
-	reinit_completion(&spi_imx->dma_rx_completion);
+	desc_tx->callback = spi_imx_dma_tx_callback;
+	desc_tx->callback_param = (void *)spi_imx;
+	dmaengine_submit(desc_tx);
 	reinit_completion(&spi_imx->dma_tx_completion);
-
-	/*
-	 * Set these order to avoid potential RX overflow. The overflow may
-	 * happen if we enable SPI HW before starting RX DMA due to rescheduling
-	 * for another task and/or interrupt.
-	 * So RX DMA enabled first to make sure data would be read out from FIFO
-	 * ASAP. TX DMA enabled next to start filling TX FIFO with new data.
-	 * And finaly SPI HW enabled to start actual data transfer.
-	 */
-	dma_async_issue_pending(master->dma_rx);
 	dma_async_issue_pending(master->dma_tx);
 
 	transfer_timeout = spi_imx_calculate_timeout(spi_imx, transfer->len);
@@ -1030,22 +1019,19 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 		dev_err(spi_imx->dev, "I/O Error in DMA TX\n");
 		dmaengine_terminate_all(master->dma_tx);
 		dmaengine_terminate_all(master->dma_rx);
-	} else {
-		timeout = wait_for_completion_timeout(
-				&spi_imx->dma_rx_completion, transfer_timeout);
-		if (!timeout) {
-			dev_err(spi_imx->dev, "I/O Error in DMA RX\n");
-			spi_imx->devtype_data->reset(spi_imx);
-			dmaengine_terminate_all(master->dma_rx);
-		}
+		return -ETIMEDOUT;
 	}
 
-	if (!timeout)
-		ret = -ETIMEDOUT;
-	else
-		ret = transfer->len;
+	timeout = wait_for_completion_timeout(&spi_imx->dma_rx_completion,
+					      transfer_timeout);
+	if (!timeout) {
+		dev_err(&master->dev, "I/O Error in DMA RX\n");
+		spi_imx->devtype_data->reset(spi_imx);
+		dmaengine_terminate_all(master->dma_rx);
+		return -ETIMEDOUT;
+	}
 
-	return ret;
+	return transfer->len;
 }
 
 static int spi_imx_pio_transfer(struct spi_device *spi,
-- 
2.7.0
