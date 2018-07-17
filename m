From: maxime.chevallier@bootlin.com (Maxime Chevallier)
Date: Tue, 17 Jul 2018 16:31:51 +0200
Subject: [PATCH RESEND 2/5] spi: imx: Use dynamic bursts only when
 bits_per_word is 8, 16 or 32
In-Reply-To: <20180717143154.28241-1-maxime.chevallier@bootlin.com>
References: <20180717143154.28241-1-maxime.chevallier@bootlin.com>
Message-ID: <20180717143154.28241-3-maxime.chevallier@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dynamic bursts mode allows to group together multiple words into a
single burst. To do so, it's necessary that words can be packed into the
32-bits FIFO entries, so we can't allow using this mode with bit_per_words
different to 8, 16 or 32.

This prevents shitfing out extra clock ticks for transfers with
bit_per_word values not aligned on 8 bits.

With that , we are sure that only the correct number of bits is
shifted out at each transfer, so we don't need to mask out the remaining
parts of the words.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/spi/spi-imx.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index d75153c995af..ecafbda5ec94 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -95,7 +95,6 @@ struct spi_imx_data {
 	const void *tx_buf;
 	unsigned int txfifo; /* number of words pushed in tx FIFO */
 	unsigned int dynamic_burst, read_u32;
-	unsigned int word_mask;
 
 	/* Slave mode */
 	bool slave_mode;
@@ -291,7 +290,6 @@ static void spi_imx_buf_rx_swap_u32(struct spi_imx_data *spi_imx)
 		else if (bytes_per_word == 2)
 			val = (val << 16) | (val >> 16);
 #endif
-		val &= spi_imx->word_mask;
 		*(u32 *)spi_imx->rx_buf = val;
 		spi_imx->rx_buf += sizeof(u32);
 	}
@@ -322,7 +320,6 @@ static void spi_imx_buf_tx_swap_u32(struct spi_imx_data *spi_imx)
 
 	if (spi_imx->tx_buf) {
 		val = *(u32 *)spi_imx->tx_buf;
-		val &= spi_imx->word_mask;
 		spi_imx->tx_buf += sizeof(u32);
 	}
 
@@ -1102,25 +1099,23 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	spi_imx->bits_per_word = t->bits_per_word;
 	spi_imx->speed_hz  = t->speed_hz;
 
-	/* Initialize the functions for transfer */
-	if (spi_imx->devtype_data->dynamic_burst && !spi_imx->slave_mode) {
-		u32 mask;
+	/*
+	 * Initialize the functions for transfer. To transfer non byte-aligned
+	 * words, we have to use multiple word-size bursts, we can't use
+	 * dynamic_burst in that case.
+	 */
+	if (spi_imx->devtype_data->dynamic_burst && !spi_imx->slave_mode &&
+	    (spi_imx->bits_per_word == 8 ||
+	    spi_imx->bits_per_word == 16 ||
+	    spi_imx->bits_per_word == 32)) {
 
 		spi_imx->read_u32  = 1;
 
-		mask = (1 << spi_imx->bits_per_word) - 1;
 		spi_imx->rx = spi_imx_buf_rx_swap;
 		spi_imx->tx = spi_imx_buf_tx_swap;
 		spi_imx->dynamic_burst = 1;
 		spi_imx->remainder = t->len;
 
-		if (spi_imx->bits_per_word <= 8)
-			spi_imx->word_mask = mask << 24 | mask << 16
-					     | mask << 8 | mask;
-		else if (spi_imx->bits_per_word <= 16)
-			spi_imx->word_mask = mask << 16 | mask;
-		else
-			spi_imx->word_mask = mask;
 	} else {
 		if (spi_imx->bits_per_word <= 8) {
 			spi_imx->rx = spi_imx_buf_rx_u8;
-- 
2.11.0
