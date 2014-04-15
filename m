From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 15 Apr 2014 15:24:59 +0800
Subject: [PATCH 1/2] spi: sirf: refactor spi transfer functions
Message-ID: <1397546700-21605-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

split sirfsoc_spi_transfer function into 3 sub-functions:
spi_sirfsoc_cmd_transfer, spi_sirfsoc_pio_transfer and
spi_sirfsoc_dma_transfer.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/spi/spi-sirf.c |  232 +++++++++++++++++++++++++----------------------
 1 files changed, 123 insertions(+), 109 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 0c039d4..2d23899 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
+#include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -309,59 +310,51 @@ static void spi_sirfsoc_dma_fini_callback(void *data)
 	complete(dma_complete);
 }
 
-static int spi_sirfsoc_transfer(struct spi_device *spi, struct spi_transfer *t)
+static int spi_sirfsoc_cmd_transfer(struct spi_device *spi,
+	struct spi_transfer *t)
 {
 	struct sirfsoc_spi *sspi;
 	int timeout = t->len * 10;
-	sspi = spi_master_get_devdata(spi->master);
+	u32 cmd;
 
-	sspi->tx = t->tx_buf ? t->tx_buf : sspi->dummypage;
-	sspi->rx = t->rx_buf ? t->rx_buf : sspi->dummypage;
-	sspi->left_tx_word = sspi->left_rx_word = t->len / sspi->word_width;
-	reinit_completion(&sspi->rx_done);
-	reinit_completion(&sspi->tx_done);
-
-	writel(SIRFSOC_SPI_INT_MASK_ALL, sspi->base + SIRFSOC_SPI_INT_STATUS);
-
-	/*
-	 * fill tx_buf into command register and wait for its completion
-	 */
-	if (sspi->tx_by_cmd) {
-		u32 cmd;
-		memcpy(&cmd, sspi->tx, t->len);
-
-		if (sspi->word_width == 1 && !(spi->mode & SPI_LSB_FIRST))
-			cmd = cpu_to_be32(cmd) >>
-				((SIRFSOC_MAX_CMD_BYTES - t->len) * 8);
-		if (sspi->word_width == 2 && t->len == 4 &&
-				(!(spi->mode & SPI_LSB_FIRST)))
-			cmd = ((cmd & 0xffff) << 16) | (cmd >> 16);
-
-		writel(cmd, sspi->base + SIRFSOC_SPI_CMD);
-		writel(SIRFSOC_SPI_FRM_END_INT_EN,
-			sspi->base + SIRFSOC_SPI_INT_EN);
-		writel(SIRFSOC_SPI_CMD_TX_EN,
-			sspi->base + SIRFSOC_SPI_TX_RX_EN);
+	sspi = spi_master_get_devdata(spi->master);
+	memcpy(&cmd, sspi->tx, t->len);
+	if (sspi->word_width == 1 && !(spi->mode & SPI_LSB_FIRST))
+		cmd = cpu_to_be32(cmd) >>
+			((SIRFSOC_MAX_CMD_BYTES - t->len) * 8);
+	if (sspi->word_width == 2 && t->len == 4 &&
+			(!(spi->mode & SPI_LSB_FIRST)))
+		cmd = ((cmd & 0xffff) << 16) | (cmd >> 16);
+	writel(cmd, sspi->base + SIRFSOC_SPI_CMD);
+	writel(SIRFSOC_SPI_FRM_END_INT_EN,
+		sspi->base + SIRFSOC_SPI_INT_EN);
+	writel(SIRFSOC_SPI_CMD_TX_EN,
+		sspi->base + SIRFSOC_SPI_TX_RX_EN);
+	if (wait_for_completion_timeout(&sspi->tx_done, timeout) == 0) {
+		dev_err(&spi->dev, "cmd transfer timeout\n");
+		return 0;
+	}
 
-		if (wait_for_completion_timeout(&sspi->tx_done, timeout) == 0) {
-			dev_err(&spi->dev, "transfer timeout\n");
-			return 0;
-		}
+	return t->len;
+}
 
-		return t->len;
-	}
+static void spi_sirfsoc_dma_transfer(struct spi_device *spi,
+	struct spi_transfer *t)
+{
+	struct sirfsoc_spi *sspi;
+	struct dma_async_tx_descriptor *rx_desc, *tx_desc;
+	int timeout = t->len * 10;
 
-	if (sspi->left_tx_word == 1) {
-		writel(readl(sspi->base + SIRFSOC_SPI_CTRL) |
-			SIRFSOC_SPI_ENA_AUTO_CLR,
-			sspi->base + SIRFSOC_SPI_CTRL);
-		writel(0, sspi->base + SIRFSOC_SPI_TX_DMA_IO_LEN);
-		writel(0, sspi->base + SIRFSOC_SPI_RX_DMA_IO_LEN);
-	} else if ((sspi->left_tx_word > 1) && (sspi->left_tx_word <
-				SIRFSOC_SPI_DAT_FRM_LEN_MAX)) {
+	sspi = spi_master_get_devdata(spi->master);
+	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
+	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
+	writel(SIRFSOC_SPI_FIFO_START, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
+	writel(SIRFSOC_SPI_FIFO_START, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
+	writel(0, sspi->base + SIRFSOC_SPI_INT_EN);
+	writel(SIRFSOC_SPI_INT_MASK_ALL, sspi->base + SIRFSOC_SPI_INT_STATUS);
+	if (sspi->left_tx_word < SIRFSOC_SPI_DAT_FRM_LEN_MAX) {
 		writel(readl(sspi->base + SIRFSOC_SPI_CTRL) |
-				SIRFSOC_SPI_MUL_DAT_MODE |
-				SIRFSOC_SPI_ENA_AUTO_CLR,
+			SIRFSOC_SPI_ENA_AUTO_CLR | SIRFSOC_SPI_MUL_DAT_MODE,
 			sspi->base + SIRFSOC_SPI_CTRL);
 		writel(sspi->left_tx_word - 1,
 				sspi->base + SIRFSOC_SPI_TX_DMA_IO_LEN);
@@ -373,88 +366,109 @@ static int spi_sirfsoc_transfer(struct spi_device *spi, struct spi_transfer *t)
 		writel(0, sspi->base + SIRFSOC_SPI_TX_DMA_IO_LEN);
 		writel(0, sspi->base + SIRFSOC_SPI_RX_DMA_IO_LEN);
 	}
-
-	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
-	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
-	writel(SIRFSOC_SPI_FIFO_START, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
-	writel(SIRFSOC_SPI_FIFO_START, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
-
-	if (IS_DMA_VALID(t)) {
-		struct dma_async_tx_descriptor *rx_desc, *tx_desc;
-
-		sspi->dst_start = dma_map_single(&spi->dev,
-				sspi->rx, t->len, (t->tx_buf != t->rx_buf) ?
-				DMA_FROM_DEVICE : DMA_BIDIRECTIONAL);
-		rx_desc = dmaengine_prep_slave_single(sspi->rx_chan,
-			sspi->dst_start, t->len, DMA_DEV_TO_MEM,
-			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-		rx_desc->callback = spi_sirfsoc_dma_fini_callback;
-		rx_desc->callback_param = &sspi->rx_done;
-
-		sspi->src_start = dma_map_single(&spi->dev,
-				(void *)sspi->tx, t->len,
-				(t->tx_buf != t->rx_buf) ?
-				DMA_TO_DEVICE : DMA_BIDIRECTIONAL);
-		tx_desc = dmaengine_prep_slave_single(sspi->tx_chan,
-			sspi->src_start, t->len, DMA_MEM_TO_DEV,
-			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-		tx_desc->callback = spi_sirfsoc_dma_fini_callback;
-		tx_desc->callback_param = &sspi->tx_done;
-
-		dmaengine_submit(tx_desc);
-		dmaengine_submit(rx_desc);
-		dma_async_issue_pending(sspi->tx_chan);
-		dma_async_issue_pending(sspi->rx_chan);
-	} else {
-		/* Send the first word to trigger the whole tx/rx process */
-		sspi->tx_word(sspi);
-
-		writel(SIRFSOC_SPI_RX_OFLOW_INT_EN |
-			SIRFSOC_SPI_TX_UFLOW_INT_EN |
-			SIRFSOC_SPI_RXFIFO_THD_INT_EN |
-			SIRFSOC_SPI_TXFIFO_THD_INT_EN |
-			SIRFSOC_SPI_FRM_END_INT_EN |
-			SIRFSOC_SPI_RXFIFO_FULL_INT_EN |
-			SIRFSOC_SPI_TXFIFO_EMPTY_INT_EN,
-			sspi->base + SIRFSOC_SPI_INT_EN);
-	}
-
+	sspi->dst_start = dma_map_single(&spi->dev, sspi->rx, t->len,
+					(t->tx_buf != t->rx_buf) ?
+					DMA_FROM_DEVICE : DMA_BIDIRECTIONAL);
+	rx_desc = dmaengine_prep_slave_single(sspi->rx_chan,
+		sspi->dst_start, t->len, DMA_DEV_TO_MEM,
+		DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	rx_desc->callback = spi_sirfsoc_dma_fini_callback;
+	rx_desc->callback_param = &sspi->rx_done;
+
+	sspi->src_start = dma_map_single(&spi->dev, (void *)sspi->tx, t->len,
+					(t->tx_buf != t->rx_buf) ?
+					DMA_TO_DEVICE : DMA_BIDIRECTIONAL);
+	tx_desc = dmaengine_prep_slave_single(sspi->tx_chan,
+		sspi->src_start, t->len, DMA_MEM_TO_DEV,
+		DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	tx_desc->callback = spi_sirfsoc_dma_fini_callback;
+	tx_desc->callback_param = &sspi->tx_done;
+
+	dmaengine_submit(tx_desc);
+	dmaengine_submit(rx_desc);
+	dma_async_issue_pending(sspi->tx_chan);
+	dma_async_issue_pending(sspi->rx_chan);
 	writel(SIRFSOC_SPI_RX_EN | SIRFSOC_SPI_TX_EN,
 			sspi->base + SIRFSOC_SPI_TX_RX_EN);
-
-	if (!IS_DMA_VALID(t)) { /* for PIO */
-		if (wait_for_completion_timeout(&sspi->rx_done, timeout) == 0)
-			dev_err(&spi->dev, "transfer timeout\n");
-	} else if (wait_for_completion_timeout(&sspi->rx_done, timeout) == 0) {
+	if (wait_for_completion_timeout(&sspi->rx_done, timeout) == 0) {
 		dev_err(&spi->dev, "transfer timeout\n");
 		dmaengine_terminate_all(sspi->rx_chan);
 	} else
 		sspi->left_rx_word = 0;
-
 	/*
 	 * we only wait tx-done event if transferring by DMA. for PIO,
 	 * we get rx data by writing tx data, so if rx is done, tx has
 	 * done earlier
 	 */
-	if (IS_DMA_VALID(t)) {
-		if (wait_for_completion_timeout(&sspi->tx_done, timeout) == 0) {
-			dev_err(&spi->dev, "transfer timeout\n");
-			dmaengine_terminate_all(sspi->tx_chan);
-		}
+	if (wait_for_completion_timeout(&sspi->tx_done, timeout) == 0) {
+		dev_err(&spi->dev, "transfer timeout\n");
+		dmaengine_terminate_all(sspi->tx_chan);
 	}
+	dma_unmap_single(&spi->dev, sspi->src_start, t->len, DMA_TO_DEVICE);
+	dma_unmap_single(&spi->dev, sspi->dst_start, t->len, DMA_FROM_DEVICE);
+	/* TX, RX FIFO stop */
+	writel(0, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
+	writel(0, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
+	if (sspi->left_tx_word >= SIRFSOC_SPI_DAT_FRM_LEN_MAX)
+		writel(0, sspi->base + SIRFSOC_SPI_TX_RX_EN);
+}
 
-	if (IS_DMA_VALID(t)) {
-		dma_unmap_single(&spi->dev,
-				sspi->src_start, t->len, DMA_TO_DEVICE);
-		dma_unmap_single(&spi->dev,
-				sspi->dst_start, t->len, DMA_FROM_DEVICE);
-	}
+static void spi_sirfsoc_pio_transfer(struct spi_device *spi,
+		struct spi_transfer *t)
+{
+	struct sirfsoc_spi *sspi;
+	int timeout = t->len * 10;
 
-	/* TX, RX FIFO stop */
+	sspi = spi_master_get_devdata(spi->master);
+	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
+	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
+	writel(SIRFSOC_SPI_FIFO_START, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
+	writel(SIRFSOC_SPI_FIFO_START, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
+	writel(0, sspi->base + SIRFSOC_SPI_INT_EN);
+	writel(SIRFSOC_SPI_INT_MASK_ALL, sspi->base + SIRFSOC_SPI_INT_STATUS);
+	writel(readl(sspi->base + SIRFSOC_SPI_CTRL) | SIRFSOC_SPI_MUL_DAT_MODE |
+		SIRFSOC_SPI_ENA_AUTO_CLR, sspi->base + SIRFSOC_SPI_CTRL);
+	writel(sspi->left_tx_word - 1,
+			sspi->base + SIRFSOC_SPI_TX_DMA_IO_LEN);
+	writel(sspi->left_rx_word - 1,
+			sspi->base + SIRFSOC_SPI_RX_DMA_IO_LEN);
+	sspi->tx_word(sspi);
+	writel(SIRFSOC_SPI_TXFIFO_EMPTY_INT_EN | SIRFSOC_SPI_TX_UFLOW_INT_EN |
+		SIRFSOC_SPI_RX_OFLOW_INT_EN | SIRFSOC_SPI_RXFIFO_THD_INT_EN |
+		SIRFSOC_SPI_TXFIFO_THD_INT_EN | SIRFSOC_SPI_FRM_END_INT_EN|
+		SIRFSOC_SPI_RXFIFO_FULL_INT_EN,
+		sspi->base + SIRFSOC_SPI_INT_EN);
+	writel(SIRFSOC_SPI_RX_EN | SIRFSOC_SPI_TX_EN,
+			sspi->base + SIRFSOC_SPI_TX_RX_EN);
+	if (wait_for_completion_timeout(&sspi->rx_done, timeout) == 0)
+		dev_err(&spi->dev, "transfer timeout\n");
 	writel(0, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
 	writel(0, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
 	writel(0, sspi->base + SIRFSOC_SPI_TX_RX_EN);
 	writel(0, sspi->base + SIRFSOC_SPI_INT_EN);
+}
+
+static int spi_sirfsoc_transfer(struct spi_device *spi, struct spi_transfer *t)
+{
+	struct sirfsoc_spi *sspi;
+	sspi = spi_master_get_devdata(spi->master);
+
+	sspi->tx = t->tx_buf ? t->tx_buf : sspi->dummypage;
+	sspi->rx = t->rx_buf ? t->rx_buf : sspi->dummypage;
+	sspi->left_tx_word = sspi->left_rx_word = t->len / sspi->word_width;
+	reinit_completion(&sspi->rx_done);
+	reinit_completion(&sspi->tx_done);
+	/*
+	 * in the transfer, if transfer data using command register with rx_buf
+	 * null, just fill command data into command register and wait for its
+	 * completion.
+	 */
+	if (sspi->tx_by_cmd)
+		spi_sirfsoc_cmd_transfer(spi, t);
+	else if (IS_DMA_VALID(t))
+		spi_sirfsoc_dma_transfer(spi, t);
+	else
+		spi_sirfsoc_pio_transfer(spi, t);
 
 	return t->len - sspi->left_rx_word * sspi->word_width;
 }
-- 
1.7.5.4
