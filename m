From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Wed, 28 Jan 2015 13:23:54 +0100
Subject: [PATCH v2 15/15] spi/xilinx: Use polling mode on small transfers
In-Reply-To: <1422447834-23116-1-git-send-email-ricardo.ribalda@gmail.com>
References: <1422447834-23116-1-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <1422447834-23116-16-git-send-email-ricardo.ribalda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Small transfers generally can be accomplished faster in polling mode.
This patch select the transfer which size is bellow the buffer size to
be done on polling mode

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/spi/spi-xilinx.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 134d8cd..c6b0a6e 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -130,7 +130,6 @@ static void xilinx_spi_rx(struct xilinx_spi *xspi)
 static void xspi_init_hw(struct xilinx_spi *xspi)
 {
 	void __iomem *regs_base = xspi->regs;
-	u32 inhibit;
 
 	/* Reset the SPI device */
 	xspi->write_fn(XIPIF_V123B_RESET_MASK,
@@ -140,22 +139,15 @@ static void xspi_init_hw(struct xilinx_spi *xspi)
 	 */
 	xspi->write_fn(XSPI_INTR_TX_EMPTY,
 			regs_base + XIPIF_V123B_IIER_OFFSET);
-	/* Enable the global IPIF interrupt */
-	if (xspi->irq >= 0) {
-		xspi->write_fn(XIPIF_V123B_GINTR_ENABLE,
-			regs_base + XIPIF_V123B_DGIER_OFFSET);
-		inhibit = XSPI_CR_TRANS_INHIBIT;
-	} else {
-		xspi->write_fn(0, regs_base + XIPIF_V123B_DGIER_OFFSET);
-		inhibit = 0;
-	}
+	/* Disable the global IPIF interrupt */
+	xspi->write_fn(0, regs_base + XIPIF_V123B_DGIER_OFFSET);
 	/* Deselect the slave on the SPI bus */
 	xspi->write_fn(0xffff, regs_base + XSPI_SSR_OFFSET);
 	/* Disable the transmitter, enable Manual Slave Select Assertion,
 	 * put SPI controller into master mode, and enable it */
-	xspi->write_fn(inhibit | XSPI_CR_MANUAL_SSELECT |
-		XSPI_CR_MASTER_MODE | XSPI_CR_ENABLE | XSPI_CR_TXFIFO_RESET |
-		XSPI_CR_RXFIFO_RESET, regs_base + XSPI_CR_OFFSET);
+	xspi->write_fn(XSPI_CR_MANUAL_SSELECT |	XSPI_CR_MASTER_MODE |
+		XSPI_CR_ENABLE | XSPI_CR_TXFIFO_RESET |	XSPI_CR_RXFIFO_RESET,
+		regs_base + XSPI_CR_OFFSET);
 }
 
 static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)
@@ -214,6 +206,8 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct xilinx_spi *xspi = spi_master_get_devdata(spi->master);
 	int remaining_words;	/* the number of words left to transfer */
+	bool use_irq = false;
+	u16 cr = 0;
 
 	/* We get here with transmitter inhibited */
 
@@ -222,8 +216,20 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 	remaining_words = t->len / xspi->bytes_per_word;
 	reinit_completion(&xspi->done);
 
+	if (xspi->irq >= 0 &&  remaining_words > xspi->buffer_size) {
+		use_irq = true;
+		xspi->write_fn(XSPI_INTR_TX_EMPTY,
+				xspi->regs + XIPIF_V123B_IISR_OFFSET);
+		/* Enable the global IPIF interrupt */
+		xspi->write_fn(XIPIF_V123B_GINTR_ENABLE,
+				xspi->regs + XIPIF_V123B_DGIER_OFFSET);
+		/* Inhibit irq to avoid spurious irqs on tx_empty*/
+		cr = xspi->read_fn(xspi->regs + XSPI_CR_OFFSET);
+		xspi->write_fn(cr | XSPI_CR_TRANS_INHIBIT,
+			       xspi->regs + XSPI_CR_OFFSET);
+	}
+
 	while (remaining_words) {
-		u16 cr = 0;
 		int n_words, tx_words, rx_words;
 
 		n_words = min(remaining_words, xspi->buffer_size);
@@ -236,9 +242,7 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 		 * longer
 		 */
 
-		if (xspi->irq >= 0) {
-			cr = xspi->read_fn(xspi->regs + XSPI_CR_OFFSET) &
-							~XSPI_CR_TRANS_INHIBIT;
+		if (use_irq) {
 			xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);
 			wait_for_completion(&xspi->done);
 		} else
@@ -251,7 +255,7 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 		 * transmitter while the Isr refills the transmit register/FIFO,
 		 * or make sure it is stopped if we're done.
 		 */
-		if (xspi->irq >= 0)
+		if (use_irq)
 			xspi->write_fn(cr | XSPI_CR_TRANS_INHIBIT,
 			       xspi->regs + XSPI_CR_OFFSET);
 
@@ -263,6 +267,9 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 		remaining_words -= n_words;
 	}
 
+	if (use_irq)
+		xspi->write_fn(0, xspi->regs + XIPIF_V123B_DGIER_OFFSET);
+
 	return t->len;
 }
 
-- 
2.1.4
