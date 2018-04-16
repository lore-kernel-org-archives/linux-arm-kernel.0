From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 16 Apr 2018 17:40:21 +0200
Subject: [PATCH 6/6] spi: spi-s3c64xx: Allow higher transfer lengths in
 polling IO mode
In-Reply-To: <20180416154021.25626-1-s.nawrocki@samsung.com>
References: <20180416154021.25626-1-s.nawrocki@samsung.com>
 <CGME20180416154208epcas1p1774dd679e3564be916901a180315943b@epcas1p1.samsung.com>
Message-ID: <20180416154021.25626-6-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some variants of the SPI controller have no DMA support, in such case
SPI transfers longer than the FIFO length are not currently properly
handled by the driver. Fix it by doing multiple transfers in the
s3c64xx_spi_transfer_one() function if the SPI transfer length exceeds
the FIFO size.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 108 ++++++++++++++++++++++++++++++----------------
 1 file changed, 71 insertions(+), 37 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 2723fa6bed8b..b2e8ed354dac 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -349,7 +349,7 @@ static bool s3c64xx_spi_can_dma(struct spi_master *master,
 }
 
 static void s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
-				    struct spi_transfer *xfer, int dma_mode)
+				    struct spi_transfer *xfer, bool dma_mode)
 {
 	void __iomem *regs = sdd->regs;
 	u32 modecfg, chcfg;
@@ -634,11 +634,15 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 				    struct spi_transfer *xfer)
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
+	const unsigned int fifo_len = (FIFO_LVL_MASK(sdd) >> 1) + 1;
+	const void *tx_buf = NULL;
+	void *rx_buf = NULL;
+	int target_len = 0, origin_len = 0;
+	bool use_dma = false;
 	int status;
 	u32 speed;
 	u8 bpw;
 	unsigned long flags;
-	int use_dma;
 
 	reinit_completion(&sdd->xfer_completion);
 
@@ -653,48 +657,78 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 		s3c64xx_spi_config(sdd);
 	}
 
-	/* Polling method for xfers not bigger than FIFO capacity */
-	use_dma = 0;
-	if (!is_polling(sdd) &&
-	    (sdd->rx_dma.ch && sdd->tx_dma.ch &&
-	     (xfer->len > ((FIFO_LVL_MASK(sdd) >> 1) + 1))))
-		use_dma = 1;
+	if (!is_polling(sdd) && (xfer->len > fifo_len) &&
+	    sdd->rx_dma.ch && sdd->tx_dma.ch) {
+		use_dma = true;
 
-	spin_lock_irqsave(&sdd->lock, flags);
+	} else if (is_polling(sdd) && xfer->len > fifo_len) {
+		tx_buf = xfer->tx_buf;
+		rx_buf = xfer->rx_buf;
+		origin_len = xfer->len;
 
-	/* Pending only which is to be done */
-	sdd->state &= ~RXBUSY;
-	sdd->state &= ~TXBUSY;
+		target_len = xfer->len;
+		if (xfer->len > fifo_len)
+			xfer->len = fifo_len;
+	}
+
+	do {
+		spin_lock_irqsave(&sdd->lock, flags);
 
-	s3c64xx_enable_datapath(sdd, xfer, use_dma);
+		/* Pending only which is to be done */
+		sdd->state &= ~RXBUSY;
+		sdd->state &= ~TXBUSY;
 
-	/* Start the signals */
-	s3c64xx_spi_set_cs(spi, true);
+		s3c64xx_enable_datapath(sdd, xfer, use_dma);
 
-	spin_unlock_irqrestore(&sdd->lock, flags);
+		/* Start the signals */
+		s3c64xx_spi_set_cs(spi, true);
 
-	if (use_dma)
-		status = wait_for_dma(sdd, xfer);
-	else
-		status = wait_for_pio(sdd, xfer);
-
-	if (status) {
-		dev_err(&spi->dev, "I/O Error: rx-%d tx-%d res:rx-%c tx-%c len-%d\n",
-			xfer->rx_buf ? 1 : 0, xfer->tx_buf ? 1 : 0,
-			(sdd->state & RXBUSY) ? 'f' : 'p',
-			(sdd->state & TXBUSY) ? 'f' : 'p',
-			xfer->len);
-
-		if (use_dma) {
-			if (xfer->tx_buf != NULL
-			    && (sdd->state & TXBUSY))
-				dmaengine_terminate_all(sdd->tx_dma.ch);
-			if (xfer->rx_buf != NULL
-			    && (sdd->state & RXBUSY))
-				dmaengine_terminate_all(sdd->rx_dma.ch);
+		spin_unlock_irqrestore(&sdd->lock, flags);
+
+		if (use_dma)
+			status = wait_for_dma(sdd, xfer);
+		else
+			status = wait_for_pio(sdd, xfer);
+
+		if (status) {
+			dev_err(&spi->dev,
+				"I/O Error: rx-%d tx-%d res:rx-%c tx-%c len-%d\n",
+				xfer->rx_buf ? 1 : 0, xfer->tx_buf ? 1 : 0,
+				(sdd->state & RXBUSY) ? 'f' : 'p',
+				(sdd->state & TXBUSY) ? 'f' : 'p',
+				xfer->len);
+
+			if (use_dma) {
+				if (xfer->tx_buf && (sdd->state & TXBUSY))
+					dmaengine_terminate_all(sdd->tx_dma.ch);
+				if (xfer->rx_buf && (sdd->state & RXBUSY))
+					dmaengine_terminate_all(sdd->rx_dma.ch);
+			}
+		} else {
+			flush_fifo(sdd);
 		}
-	} else {
-		flush_fifo(sdd);
+
+		if (target_len > 0) {
+			target_len -= xfer->len;
+
+			if (xfer->tx_buf)
+				xfer->tx_buf += xfer->len;
+
+			if (xfer->rx_buf)
+				xfer->rx_buf += xfer->len;
+
+			if (target_len > fifo_len)
+				xfer->len = fifo_len;
+			else
+				xfer->len = target_len;
+		}
+	} while (target_len > 0);
+
+	if (origin_len) {
+		/* Restore original xfer buffers and length */
+		xfer->tx_buf = tx_buf;
+		xfer->rx_buf = rx_buf;
+		xfer->len = origin_len;
 	}
 
 	return status;
-- 
2.14.2
