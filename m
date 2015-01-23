From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Fri, 23 Jan 2015 17:08:36 +0100
Subject: [PATCH 04/18] spi-xilinx: Simplify spi_fill_tx_fifo
In-Reply-To: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
References: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <1422029330-10971-5-git-send-email-ricardo.ribalda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of checking the TX_FULL flag for every transaction, find out the
size of the buffer at probe time and use it.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/spi/spi-xilinx.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 416b227..17480a2 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -88,6 +88,7 @@ struct xilinx_spi {
 	const u8 *tx_ptr;	/* pointer in the Rx buffer */
 	int remaining_bytes;	/* the number of bytes left to transfer */
 	u8 bits_per_word;
+	int buffer_size;	/* buffer size in words */
 	unsigned int (*read_fn)(void __iomem *);
 	void (*write_fn)(u32, void __iomem *);
 	void (*tx_fn)(struct xilinx_spi *);
@@ -221,24 +222,16 @@ static int xilinx_spi_setup_transfer(struct spi_device *spi,
 	return 0;
 }
 
-static int xilinx_spi_fill_tx_fifo(struct xilinx_spi *xspi)
+static void xilinx_spi_fill_tx_fifo(struct xilinx_spi *xspi, int n_words)
 {
-	u8 sr;
-	int n_words = 0;
+	xspi->remaining_bytes -= n_words * xspi->bits_per_word / 8;
 
-	/* Fill the Tx FIFO with as many bytes as possible */
-	sr = xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
-	while ((sr & XSPI_SR_TX_FULL_MASK) == 0 && xspi->remaining_bytes > 0) {
+	while (n_words--)
 		if (xspi->tx_ptr)
 			xspi->tx_fn(xspi);
 		else
 			xspi->write_fn(0, xspi->regs + XSPI_TXD_OFFSET);
-		xspi->remaining_bytes -= xspi->bits_per_word / 8;
-		sr = xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
-		n_words++;
-	}
-
-	return n_words;
+	return;
 }
 
 static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
@@ -265,7 +258,10 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 		u16 cr;
 		int n_words;
 
-		n_words = xilinx_spi_fill_tx_fifo(xspi);
+		n_words = (xspi->remaining_bytes * 8) / xspi->bits_per_word;
+		n_words = min(n_words, xspi->buffer_size);
+
+		xilinx_spi_fill_tx_fifo(xspi, n_words);
 
 		/* Start the transfer by not inhibiting the transmitter any
 		 * longer
@@ -322,6 +318,21 @@ static irqreturn_t xilinx_spi_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int xilinx_spi_find_buffer_size(struct xilinx_spi *xspi)
+{
+	u8 sr;
+	int n_words = 0;
+
+	/* Fill the Tx FIFO with as many words as possible */
+	do {
+		xspi->write_fn(0, xspi->regs + XSPI_TXD_OFFSET);
+		sr = xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
+		n_words++;
+	} while (!(sr & XSPI_SR_TX_FULL_MASK));
+
+	return n_words;
+}
+
 static const struct of_device_id xilinx_spi_of_match[] = {
 	{ .compatible = "xlnx,xps-spi-2.00.a", },
 	{ .compatible = "xlnx,xps-spi-2.00.b", },
@@ -413,6 +424,8 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		goto put_master;
 	}
 
+	xspi->buffer_size = xilinx_spi_find_buffer_size(xspi);
+
 	/* SPI controller initializations */
 	xspi_init_hw(xspi);
 
-- 
2.1.4
