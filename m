From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Apr 2018 12:40:38 +0100
Subject: Applied "spi: spi-s3c64xx: Allow higher transfer lengths in polling
 IO mode" to the spi tree
In-Reply-To: <20180417142954.5507-8-s.nawrocki@samsung.com>
Message-ID: <E1f8lS2-00023M-Sa@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: spi-s3c64xx: Allow higher transfer lengths in polling IO mode

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 0af7af7da6510f12595b81ba98bb15dd7ffed1f3 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Tue, 17 Apr 2018 16:29:54 +0200
Subject: [PATCH] spi: spi-s3c64xx: Allow higher transfer lengths in polling IO
 mode

Some variants of the SPI controller have no DMA support, in such case
SPI transfers longer than the FIFO length are not currently properly
handled by the driver. Fix it by doing multiple transfers in the
s3c64xx_spi_transfer_one() function if the SPI transfer length exceeds
the FIFO size.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Reviewed-by: Andi Shyti <andi@etezian.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 99 ++++++++++++++++++++++++++-------------
 1 file changed, 66 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 27cd8c59eabf..755ab2dc6969 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -635,11 +635,14 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
 	const unsigned int fifo_len = (FIFO_LVL_MASK(sdd) >> 1) + 1;
+	const void *tx_buf = NULL;
+	void *rx_buf = NULL;
+	int target_len = 0, origin_len = 0;
+	int use_dma = 0;
 	int status;
 	u32 speed;
 	u8 bpw;
 	unsigned long flags;
-	int use_dma;
 
 	reinit_completion(&sdd->xfer_completion);
 
@@ -654,47 +657,77 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 		s3c64xx_spi_config(sdd);
 	}
 
-	/* Polling method for xfers not bigger than FIFO capacity */
-	use_dma = 0;
 	if (!is_polling(sdd) && (xfer->len > fifo_len) &&
-	    sdd->rx_dma.ch && sdd->tx_dma.ch)
+	    sdd->rx_dma.ch && sdd->tx_dma.ch) {
 		use_dma = 1;
 
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
-		status = s3c64xx_wait_for_dma(sdd, xfer);
-	else
-		status = s3c64xx_wait_for_pio(sdd, xfer);
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
+			status = s3c64xx_wait_for_dma(sdd, xfer);
+		else
+			status = s3c64xx_wait_for_pio(sdd, xfer);
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
+			s3c64xx_flush_fifo(sdd);
 		}
-	} else {
-		s3c64xx_flush_fifo(sdd);
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
2.17.0
