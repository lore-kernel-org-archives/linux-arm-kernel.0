From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Wed, 28 Jan 2015 13:23:50 +0100
Subject: [PATCH v2 11/15] spi/xilinx: Convert bits_per_word in bytes_per_word
In-Reply-To: <1422447834-23116-1-git-send-email-ricardo.ribalda@gmail.com>
References: <1422447834-23116-1-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <1422447834-23116-12-git-send-email-ricardo.ribalda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simplify the code by using the unit used on most of the code logic.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/spi/spi-xilinx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 8ed306e..b16fccf 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -87,7 +87,7 @@ struct xilinx_spi {
 	u8 *rx_ptr;		/* pointer in the Tx buffer */
 	const u8 *tx_ptr;	/* pointer in the Rx buffer */
 	int remaining_words;	/* the number of words left to transfer */
-	u8 bits_per_word;
+	u8 bytes_per_word;
 	int buffer_size;	/* buffer size in words */
 	u32 cs_inactive;	/* Level of the CS pins when inactive*/
 	unsigned int (*read_fn)(void __iomem *);
@@ -121,7 +121,7 @@ static void xilinx_spi_tx(struct xilinx_spi *xspi)
 		return;
 	}
 	xspi->write_fn(*(u32 *)(xspi->tx_ptr), xspi->regs + XSPI_TXD_OFFSET);
-	xspi->tx_ptr += xspi->bits_per_word / 8;
+	xspi->tx_ptr += xspi->bytes_per_word;
 }
 
 static void xilinx_spi_rx(struct xilinx_spi *xspi)
@@ -131,19 +131,19 @@ static void xilinx_spi_rx(struct xilinx_spi *xspi)
 	if (!xspi->rx_ptr)
 		return;
 
-	switch (xspi->bits_per_word) {
-	case 8:
+	switch (xspi->bytes_per_word) {
+	case 1:
 		*(u8 *)(xspi->rx_ptr) = data;
 		break;
-	case 16:
+	case 2:
 		*(u16 *)(xspi->rx_ptr) = data;
 		break;
-	case 32:
+	case 4:
 		*(u32 *)(xspi->rx_ptr) = data;
 		break;
 	}
 
-	xspi->rx_ptr += xspi->bits_per_word / 8;
+	xspi->rx_ptr += xspi->bytes_per_word;
 }
 
 static void xspi_init_hw(struct xilinx_spi *xspi)
@@ -246,7 +246,7 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 
 	xspi->tx_ptr = t->tx_buf;
 	xspi->rx_ptr = t->rx_buf;
-	xspi->remaining_words = (t->len * 8) / xspi->bits_per_word;
+	xspi->remaining_words = t->len / xspi->bytes_per_word;
 	reinit_completion(&xspi->done);
 
 	while (xspi->remaining_words) {
@@ -410,7 +410,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 	}
 
 	master->bits_per_word_mask = SPI_BPW_MASK(bits_per_word);
-	xspi->bits_per_word = bits_per_word;
+	xspi->bytes_per_word = bits_per_word / 8;
 	xspi->buffer_size = xilinx_spi_find_buffer_size(xspi);
 
 	xspi->irq = platform_get_irq(pdev, 0);
-- 
2.1.4
