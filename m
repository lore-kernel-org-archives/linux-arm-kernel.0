From: 21cnbao@gmail.com (Barry Song)
Date: Sat, 18 May 2013 19:46:06 +0800
Subject: [PATCH RESEND] spi: sirf: fix the issue while transferring more than
 256 words
Message-ID: <1368877566-27812-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

currently, spi irq handler only does rx processing and fetching data from rx
fifo when "FRM_END" irq happens. FRM_END indicates one transfer completes. if
rx size is less than 256, it works well.
but the problem is that spi rx fifo size is only 256 bytes, then if data size
of one frame is more than 256, before FRM_END comes, rx fifo will be filled with
RXFIFO_OFLOW overflow interrupt, it will make us lose some data due to fifo
overflow.
Explicitly we need do fetch work from device rx fifo in irq handler not only in
"FRM_END" irq but also in "THD_REACH" irq. THD_REACH means rx fifo has come to
its threshold and will come to overflow if we don't take data from it in time.

In this patch, we fix this issue. we take data from rx fifo when either FRM_END
or RX_THD_REACH irq comes, we put data into tx fifo when either TX_FIFO_EMPTY
or TX_THD_REACH irq comes.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/spi/spi-sirf.c | 43 +++++++++++++------------------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 0808cd5..ac98cec 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -142,9 +142,6 @@ struct sirfsoc_spi {
 	unsigned int left_tx_cnt;
 	unsigned int left_rx_cnt;
 
-	/* tasklet to push tx msg into FIFO */
-	struct tasklet_struct tasklet_tx;
-
 	int chipselect[0];
 };
 
@@ -236,17 +233,6 @@ static void spi_sirfsoc_tx_word_u32(struct sirfsoc_spi *sspi)
 	sspi->left_tx_cnt--;
 }
 
-static void spi_sirfsoc_tasklet_tx(unsigned long arg)
-{
-	struct sirfsoc_spi *sspi = (struct sirfsoc_spi *)arg;
-
-	/* Fill Tx FIFO while there are left words to be transmitted */
-	while (!((readl(sspi->base + SIRFSOC_SPI_TXFIFO_STATUS) &
-			SIRFSOC_SPI_FIFO_FULL)) &&
-			sspi->left_tx_cnt)
-		sspi->tx_word(sspi);
-}
-
 static irqreturn_t spi_sirfsoc_irq(int irq, void *dev_id)
 {
 	struct sirfsoc_spi *sspi = dev_id;
@@ -261,25 +247,25 @@ static irqreturn_t spi_sirfsoc_irq(int irq, void *dev_id)
 		writel(0x0, sspi->base + SIRFSOC_SPI_INT_EN);
 	}
 
-	if (spi_stat & SIRFSOC_SPI_FRM_END) {
+	if (spi_stat & (SIRFSOC_SPI_FRM_END
+			| SIRFSOC_SPI_RXFIFO_THD_REACH))
 		while (!((readl(sspi->base + SIRFSOC_SPI_RXFIFO_STATUS)
 				& SIRFSOC_SPI_FIFO_EMPTY)) &&
 				sspi->left_rx_cnt)
 			sspi->rx_word(sspi);
 
-		/* Received all words */
-		if ((sspi->left_rx_cnt == 0) && (sspi->left_tx_cnt == 0)) {
-			complete(&sspi->done);
-			writel(0x0, sspi->base + SIRFSOC_SPI_INT_EN);
-		}
-	}
-
-	if (spi_stat & SIRFSOC_SPI_RXFIFO_THD_REACH ||
-		spi_stat & SIRFSOC_SPI_TXFIFO_THD_REACH ||
-		spi_stat & SIRFSOC_SPI_RX_FIFO_FULL ||
-		spi_stat & SIRFSOC_SPI_TXFIFO_EMPTY)
-		tasklet_schedule(&sspi->tasklet_tx);
+	if (spi_stat & (SIRFSOC_SPI_FIFO_EMPTY
+			| SIRFSOC_SPI_TXFIFO_THD_REACH))
+		while (!((readl(sspi->base + SIRFSOC_SPI_TXFIFO_STATUS)
+				& SIRFSOC_SPI_FIFO_FULL)) &&
+				sspi->left_tx_cnt)
+			sspi->tx_word(sspi);
 
+	/* Received all words */
+	if ((sspi->left_rx_cnt == 0) && (sspi->left_tx_cnt == 0)) {
+		complete(&sspi->done);
+		writel(0x0, sspi->base + SIRFSOC_SPI_INT_EN);
+	}
 	return IRQ_HANDLED;
 }
 
@@ -573,9 +559,6 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 
 	init_completion(&sspi->done);
 
-	tasklet_init(&sspi->tasklet_tx, spi_sirfsoc_tasklet_tx,
-		     (unsigned long)sspi);
-
 	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
 	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
 	writel(SIRFSOC_SPI_FIFO_START, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
-- 
1.8.2.3
