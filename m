From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Tue, 27 Jan 2015 16:33:27 +0530
Subject: [PATCH 6/7] spi: spi-fsl-dspi: split the resuable code
Message-ID: <1422356608-15961-1-git-send-email-bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Fu <B44548@freescale.com>

Add two functions:
- dspi_data_from_popr
- dspi_data_to_pushr

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 drivers/spi/spi-fsl-dspi.c | 118 +++++++++++++++++++++++----------------------
 1 file changed, 60 insertions(+), 58 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index b20dbb5..e0ce906 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -167,12 +167,68 @@ static void hz_to_spi_baud(char *pbr, char *br, int speed_hz,
 	*br =  ARRAY_SIZE(brs) - 1;
 }
 
+static u32 dspi_data_to_pushr(struct fsl_dspi *dspi, int tx_word)
+{
+	u16 d16;
+	u8 d8;
+
+	if (tx_word) {
+		if (!(dspi->dataflags & TRAN_STATE_TX_VOID)) {
+			d16 = *(u16 *)dspi->tx;
+			dspi->tx += 2;
+		} else {
+			d16 = dspi->void_write_data;
+		}
+
+		dspi->len -= 2;
+
+		return	SPI_PUSHR_TXDATA(d16) |
+			SPI_PUSHR_PCS(dspi->cs) |
+			SPI_PUSHR_CTAS(dspi->cs) |
+			SPI_PUSHR_CONT;
+	} else {
+		if (!(dspi->dataflags & TRAN_STATE_TX_VOID)) {
+
+			d8 = *(u8 *)dspi->tx;
+			dspi->tx++;
+		} else {
+			d8 = (u8)dspi->void_write_data;
+		}
+
+		dspi->len--;
+
+		return SPI_PUSHR_TXDATA(d8) |
+			SPI_PUSHR_PCS(dspi->cs) |
+			SPI_PUSHR_CTAS(dspi->cs) |
+			SPI_PUSHR_CONT;
+	}
+}
+
+static void dspi_data_from_popr(struct fsl_dspi *dspi, int rx_word)
+{
+	u16 d;
+	unsigned int val;
+
+	if (rx_word) {
+		regmap_read(dspi->regmap, SPI_POPR, &val);
+		d = SPI_POPR_RXDATA(val);
+
+		if (!(dspi->dataflags & TRAN_STATE_RX_VOID))
+			*(u16 *)dspi->rx = d;
+		dspi->rx += 2;
+	} else {
+		regmap_read(dspi->regmap, SPI_POPR, &val);
+		d = SPI_POPR_RXDATA(val);
+		if (!(dspi->dataflags & TRAN_STATE_RX_VOID))
+			*(u8 *)dspi->rx = d;
+		dspi->rx++;
+	}
+}
+
 static int dspi_transfer_write(struct fsl_dspi *dspi)
 {
 	int tx_count = 0;
 	int tx_word;
-	u16 d16;
-	u8  d8;
 	u32 dspi_pushr = 0;
 	int first = 1;
 
@@ -190,39 +246,7 @@ static int dspi_transfer_write(struct fsl_dspi *dspi)
 	}
 
 	while (dspi->len && (tx_count < DSPI_FIFO_SIZE)) {
-		if (tx_word) {
-			if (dspi->len == 1)
-				break;
-
-			if (!(dspi->dataflags & TRAN_STATE_TX_VOID)) {
-				d16 = *(u16 *)dspi->tx;
-				dspi->tx += 2;
-			} else {
-				d16 = dspi->void_write_data;
-			}
-
-			dspi_pushr = SPI_PUSHR_TXDATA(d16) |
-				SPI_PUSHR_PCS(dspi->cs) |
-				SPI_PUSHR_CTAS(dspi->cs) |
-				SPI_PUSHR_CONT;
-
-			dspi->len -= 2;
-		} else {
-			if (!(dspi->dataflags & TRAN_STATE_TX_VOID)) {
-
-				d8 = *(u8 *)dspi->tx;
-				dspi->tx++;
-			} else {
-				d8 = (u8)dspi->void_write_data;
-			}
-
-			dspi_pushr = SPI_PUSHR_TXDATA(d8) |
-				SPI_PUSHR_PCS(dspi->cs) |
-				SPI_PUSHR_CTAS(dspi->cs) |
-				SPI_PUSHR_CONT;
-
-			dspi->len--;
-		}
+		dspi_pushr = dspi_data_to_pushr(dspi, tx_word);
 
 		if (dspi->len == 0 || tx_count == DSPI_FIFO_SIZE - 1) {
 			/* last transfer in the transfer */
@@ -249,32 +273,10 @@ static int dspi_transfer_read(struct fsl_dspi *dspi)
 {
 	int rx_count = 0;
 	int rx_word = is_double_byte_mode(dspi);
-	u16 d;
 
 	while ((dspi->rx < dspi->rx_end)
 			&& (rx_count < DSPI_FIFO_SIZE)) {
-		if (rx_word) {
-			unsigned int val;
-
-			if ((dspi->rx_end - dspi->rx) == 1)
-				break;
-
-			regmap_read(dspi->regmap, SPI_POPR, &val);
-			d = SPI_POPR_RXDATA(val);
-
-			if (!(dspi->dataflags & TRAN_STATE_RX_VOID))
-				*(u16 *)dspi->rx = d;
-			dspi->rx += 2;
-
-		} else {
-			unsigned int val;
-
-			regmap_read(dspi->regmap, SPI_POPR, &val);
-			d = SPI_POPR_RXDATA(val);
-			if (!(dspi->dataflags & TRAN_STATE_RX_VOID))
-				*(u8 *)dspi->rx = d;
-			dspi->rx++;
-		}
+		dspi_data_from_popr(dspi, rx_word);
 		rx_count++;
 	}
 
-- 
2.2.2
