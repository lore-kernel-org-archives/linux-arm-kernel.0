From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Tue, 27 Jun 2017 17:45:19 +0200
Subject: [PATCHv2 7/9] spi: stm32: enhance DMA error management
In-Reply-To: <1498578321-13980-1-git-send-email-amelie.delaunay@st.com>
References: <1498578321-13980-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1498578321-13980-8-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch reworks DMA error management. In case the DMA callback is
called while EOT (End Of Transfer) flag is not set, that means that DMA
encountered an error. This error will result in an auto-suspend of SPI
flow, which could also result in an overrun. So, in DMA mode, SUSP and
OVR flags are a condition to stop the current transfer.

Moreover, stm32_spi_can_dma doesn't care about the state of dma channels.
During driver probe, master->can_dma is initialised if dma channel request
is successful. That's why we must use master->can_dma to know if dma
use is possible (dma channel are successfully requested and the transfer
size is greater than fifo size).

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/spi/spi-stm32.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 209afda..fdbc648 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -514,6 +514,12 @@ static irqreturn_t stm32_spi_irq(int irq, void *dev_id)
 		dev_warn(spi->dev, "Communication suspended\n");
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
 			stm32_spi_read_rxfifo(spi, false);
+		/*
+		 * If communication is suspended while using DMA, it means
+		 * that something went wrong, so stop the current transfer
+		 */
+		if (spi->cur_usedma)
+			end = true;
 	}
 
 	if (sr & SPI_SR_MODF) {
@@ -525,6 +531,12 @@ static irqreturn_t stm32_spi_irq(int irq, void *dev_id)
 		dev_warn(spi->dev, "Overrun: received value discarded\n");
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
 			stm32_spi_read_rxfifo(spi, false);
+		/*
+		 * If overrun is detected while using DMA, it means that
+		 * something went wrong, so stop the current transfer
+		 */
+		if (spi->cur_usedma)
+			end = true;
 	}
 
 	if (sr & SPI_SR_EOT) {
@@ -645,12 +657,10 @@ static void stm32_spi_dma_cb(void *data)
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
-	if (!(sr & SPI_SR_EOT)) {
-		dev_warn(spi->dev, "DMA callback (sr=0x%08x)\n", sr);
+	if (!(sr & SPI_SR_EOT))
+		dev_warn(spi->dev, "DMA error (sr=0x%08x)\n", sr);
 
-		spi_finalize_current_transfer(spi->master);
-		stm32_spi_disable(spi);
-	}
+	/* Now wait for EOT, or SUSP or OVR in case of error */
 }
 
 /**
@@ -986,7 +996,8 @@ static int stm32_spi_transfer_one(struct spi_master *master,
 	spi->tx_len = spi->tx_buf ? transfer->len : 0;
 	spi->rx_len = spi->rx_buf ? transfer->len : 0;
 
-	spi->cur_usedma = stm32_spi_can_dma(master, spi_dev, transfer);
+	spi->cur_usedma = (master->can_dma &&
+			   stm32_spi_can_dma(master, spi_dev, transfer));
 
 	ret = stm32_spi_transfer_one_setup(spi, spi_dev, transfer);
 	if (ret) {
-- 
1.9.1
