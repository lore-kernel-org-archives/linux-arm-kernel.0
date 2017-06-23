From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Fri, 23 Jun 2017 14:55:49 +0200
Subject: [PATCH 7/8] spi: stm32: enhance DMA error management
In-Reply-To: <1498222550-19092-1-git-send-email-amelie.delaunay@st.com>
References: <1498222550-19092-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1498222550-19092-8-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch reworks DMA error management. In case the DMA callback is
called while EOT (End Of Transfer) flag is not set, that means that DMA
encountered an error. This error will result in an auto-suspend of SPI
flow, which could also result in an overrun. So, in DMA mode, SUSP and
OVR flags are a condition to stop the current transfer.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/spi/spi-stm32.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 209afda..63af9d9 100644
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
-- 
1.9.1
