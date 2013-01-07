From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon,  7 Jan 2013 09:50:09 +0800
Subject: [v3 PATCH 08/12] spi/atmel_spi: correct 16 bits transfers using PIO
In-Reply-To: <1357523413-27209-1-git-send-email-wenyou.yang@atmel.com>
References: <1357523413-27209-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1357523413-27209-9-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Genoud <richard.genoud@gmail.com>

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
Cc: grant.likely at secretlab.ca
Cc: spi-devel-general at lists.sourceforge.net
---
 drivers/spi/spi-atmel.c |   46 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 8131aa1..5abb276 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -599,13 +599,17 @@ static void atmel_spi_next_xfer_pio(struct spi_master *master,
 	}
 
 	if (xfer->tx_buf)
-		spi_writel(as, TDR, *(u8 *)(xfer->tx_buf));
+		if (xfer->bits_per_word > 8)
+			spi_writel(as, TDR, *(u16 *)(xfer->tx_buf));
+		else
+			spi_writel(as, TDR, *(u8 *)(xfer->tx_buf));
 	else
 		spi_writel(as, TDR, 0);
 
 	dev_dbg(master->dev.parent,
-		"  start pio xfer %p: len %u tx %p rx %p\n",
-		xfer, xfer->len, xfer->tx_buf, xfer->rx_buf);
+		"  start pio xfer %p: len %u tx %p rx %p bitpw %d\n",
+		xfer, xfer->len, xfer->tx_buf, xfer->rx_buf,
+		xfer->bits_per_word);
 
 	/* Enable relevant interrupts */
 	spi_writel(as, IER, SPI_BIT(RDRF) | SPI_BIT(OVRES));
@@ -1023,21 +1027,39 @@ atmel_spi_pump_pio_data(struct atmel_spi *as, struct spi_transfer *xfer)
 {
 	u8		*txp;
 	u8		*rxp;
+	u16		*txp16;
+	u16		*rxp16;
 	unsigned long	xfer_pos = xfer->len - as->current_remaining_bytes;
 
 	if (xfer->rx_buf) {
-		rxp = ((u8 *)xfer->rx_buf) + xfer_pos;
-		*rxp = spi_readl(as, RDR);
+		if (xfer->bits_per_word > 8) {
+			rxp16 = (u16 *)(((u8 *)xfer->rx_buf) + xfer_pos);
+			*rxp16 = spi_readl(as, RDR);
+		} else {
+			rxp = ((u8 *)xfer->rx_buf) + xfer_pos;
+			*rxp = spi_readl(as, RDR);
+		}
 	} else {
 		spi_readl(as, RDR);
 	}
-
-	as->current_remaining_bytes--;
+	if (xfer->bits_per_word > 8) {
+		as->current_remaining_bytes -= 2;
+		if (as->current_remaining_bytes < 0)
+			as->current_remaining_bytes = 0;
+	} else {
+		as->current_remaining_bytes--;
+	}
 
 	if (as->current_remaining_bytes) {
 		if (xfer->tx_buf) {
-			txp = ((u8 *)xfer->tx_buf) + xfer_pos + 1;
-			spi_writel(as, TDR, *txp);
+			if (xfer->bits_per_word > 8) {
+				txp16 = (u16 *)(((u8 *)xfer->tx_buf)
+							+ xfer_pos + 2);
+				spi_writel(as, TDR, *txp16);
+			} else {
+				txp = ((u8 *)xfer->tx_buf) + xfer_pos + 1;
+				spi_writel(as, TDR, *txp);
+			}
 		} else {
 			spi_writel(as, TDR, 0);
 		}
@@ -1459,6 +1481,12 @@ static int atmel_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 				return -ENOPROTOOPT;
 			}
 		}
+		if (xfer->bits_per_word > 8) {
+			if (xfer->len % 2) {
+				dev_dbg(&spi->dev, "buffer len should be 16 bits aligned\n");
+				return -EINVAL;
+			}
+		}
 
 		/* FIXME implement these protocol options!! */
 		if (xfer->speed_hz) {
-- 
1.7.9.5
