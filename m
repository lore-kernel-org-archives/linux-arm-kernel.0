From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Fri, 23 Jan 2015 17:08:49 +0100
Subject: [PATCH 17/18] spi/xilinx: Remove remaining_words driver data variable
In-Reply-To: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
References: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <1422029330-10971-18-git-send-email-ricardo.ribalda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The variable never leaves the scope of txrx_bufs.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/spi/spi-xilinx.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 8c25c59..026f4c5 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -86,7 +86,6 @@ struct xilinx_spi {
 
 	u8 *rx_ptr;		/* pointer in the Tx buffer */
 	const u8 *tx_ptr;	/* pointer in the Rx buffer */
-	int remaining_words;	/* the number of words left to transfer */
 	u8 bytes_per_word;
 	int buffer_size;	/* buffer size in words */
 	u32 cs_inactive;	/* Level of the CS pins when inactive*/
@@ -209,33 +208,27 @@ static int xilinx_spi_setup_transfer(struct spi_device *spi,
 	return 0;
 }
 
-static void xilinx_spi_fill_tx_fifo(struct xilinx_spi *xspi, int n_words)
-{
-	xspi->remaining_words -= n_words;
-
-	while (n_words--)
-		xilinx_spi_tx(xspi);
-	return;
-}
-
 static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct xilinx_spi *xspi = spi_master_get_devdata(spi->master);
+	int remaining_words;	/* the number of words left to transfer */
 
 	/* We get here with transmitter inhibited */
 
 	xspi->tx_ptr = t->tx_buf;
 	xspi->rx_ptr = t->rx_buf;
-	xspi->remaining_words = t->len / xspi->bytes_per_word;
+	remaining_words = t->len / xspi->bytes_per_word;
 	reinit_completion(&xspi->done);
 
-	while (xspi->remaining_words) {
+	while (remaining_words) {
 		u16 cr = 0;
-		int n_words;
+		int n_words, tx_words, rx_words;
 
-		n_words = min(xspi->remaining_words, xspi->buffer_size);
+		n_words = min(remaining_words, xspi->buffer_size);
 
-		xilinx_spi_fill_tx_fifo(xspi, n_words);
+		tx_words = n_words;
+		while (tx_words--)
+			xilinx_spi_tx(xspi);
 
 		/* Start the transfer by not inhibiting the transmitter any
 		 * longer
@@ -261,8 +254,11 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 			       xspi->regs + XSPI_CR_OFFSET);
 
 		/* Read out all the data from the Rx FIFO */
-		while (n_words--)
+		rx_words = n_words;
+		while (rx_words--)
 			xilinx_spi_rx(xspi);
+
+		remaining_words -= n_words;
 	}
 
 	return t->len;
-- 
2.1.4
