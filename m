From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Wed, 28 Jan 2015 13:23:41 +0100
Subject: [PATCH v2 02/15] spi/xilinx: Leave the IRQ always enabled.
In-Reply-To: <1422447834-23116-1-git-send-email-ricardo.ribalda@gmail.com>
References: <1422447834-23116-1-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <1422447834-23116-3-git-send-email-ricardo.ribalda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of enabling the IRQ and disabling it for every transaction.

Specially the small transactions (1,2 words) benefit from removing 3 bus
accesses.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/spi/spi-xilinx.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 1890af8..d933207 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -167,8 +167,11 @@ static void xspi_init_hw(struct xilinx_spi *xspi)
 	/* Reset the SPI device */
 	xspi->write_fn(XIPIF_V123B_RESET_MASK,
 		regs_base + XIPIF_V123B_RESETR_OFFSET);
-	/* Disable all the interrupts just in case */
-	xspi->write_fn(0, regs_base + XIPIF_V123B_IIER_OFFSET);
+	/* Enable the transmit empty interrupt, which we use to determine
+	 * progress on the transmission.
+	 */
+	xspi->write_fn(XSPI_INTR_TX_EMPTY,
+			regs_base + XIPIF_V123B_IIER_OFFSET);
 	/* Enable the global IPIF interrupt */
 	xspi->write_fn(XIPIF_V123B_GINTR_ENABLE,
 		regs_base + XIPIF_V123B_DGIER_OFFSET);
@@ -237,7 +240,6 @@ static void xilinx_spi_fill_tx_fifo(struct xilinx_spi *xspi, int n_words)
 static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct xilinx_spi *xspi = spi_master_get_devdata(spi->master);
-	u32 ipif_ier;
 
 	/* We get here with transmitter inhibited */
 
@@ -246,14 +248,6 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 	xspi->remaining_bytes = t->len;
 	reinit_completion(&xspi->done);
 
-
-	/* Enable the transmit empty interrupt, which we use to determine
-	 * progress on the transmission.
-	 */
-	ipif_ier = xspi->read_fn(xspi->regs + XIPIF_V123B_IIER_OFFSET);
-	xspi->write_fn(ipif_ier | XSPI_INTR_TX_EMPTY,
-		xspi->regs + XIPIF_V123B_IIER_OFFSET);
-
 	for (;;) {
 		u16 cr;
 		int n_words;
@@ -290,9 +284,6 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 			break;
 	}
 
-	/* Disable the transmit empty interrupt */
-	xspi->write_fn(ipif_ier, xspi->regs + XIPIF_V123B_IIER_OFFSET);
-
 	return t->len - xspi->remaining_bytes;
 }
 
-- 
2.1.4
