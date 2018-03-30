From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Fri, 30 Mar 2018 10:22:40 +0300
Subject: [PATCH 3/6] spi: sun6i: restrict transfer length in PIO-mode
In-Reply-To: <20180330072243.19368-1-ssuloev@orpaltech.com>
References: <20180330072243.19368-1-ssuloev@orpaltech.com>
Message-ID: <20180330072243.19368-4-ssuloev@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to handle 3/4 empty/full interrupts as
the maximum supported transfer length in PIO mode is
128 bytes for sun6i- and 64 bytes for sun8i-family SoCs.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>

---
 drivers/spi/spi-sun6i.c | 61 ++++++++++++++-----------------------------------
 1 file changed, 17 insertions(+), 44 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index f992a7d..13396bd 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -207,7 +207,10 @@ static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
 
 static size_t sun6i_spi_max_transfer_size(struct spi_device *spi)
 {
-	return SUN6I_MAX_XFER_SIZE - 1;
+	struct spi_master *master = spi->master;
+	struct sun6i_spi *sspi = spi_master_get_devdata(master);
+
+	return sspi->fifo_depth;
 }
 
 static int sun6i_spi_prepare_message(struct spi_master *master,
@@ -259,13 +262,18 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	struct sun6i_spi *sspi = spi_master_get_devdata(master);
 	unsigned int mclk_rate, div, timeout;
 	unsigned int start, end, tx_time;
-	unsigned int trig_level;
 	unsigned int tx_len = 0;
 	int ret = 0;
 	u32 reg;
 
-	if (tfr->len > SUN6I_MAX_XFER_SIZE)
-		return -EINVAL;
+	/* A zero length transfer never finishes if programmed
+	   in the hardware */
+	if (!tfr->len)
+		return 0;
+
+	/* Don't support transfer larger than the FIFO */
+	if (tfr->len > sspi->fifo_depth)
+		return -EMSGSIZE;
 
 	reinit_completion(&sspi->done);
 	sspi->tx_buf = tfr->tx_buf;
@@ -279,17 +287,6 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG,
 			SUN6I_FIFO_CTL_RF_RST | SUN6I_FIFO_CTL_TF_RST);
 
-	/*
-	 * Setup FIFO interrupt trigger level
-	 * Here we choose 3/4 of the full fifo depth, as it's the hardcoded
-	 * value used in old generation of Allwinner SPI controller.
-	 * (See spi-sun4i.c)
-	 */
-	trig_level = sspi->fifo_depth / 4 * 3;
-	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG,
-			(trig_level << SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_BITS) |
-			(trig_level << SUN6I_FIFO_CTL_TF_ERQ_TRIG_LEVEL_BITS));
-
 
 	/* Ensure that we have a parent clock fast enough */
 	mclk_rate = clk_get_rate(sspi->mclk);
@@ -338,12 +335,8 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	/* Fill the TX FIFO */
 	sun6i_spi_fill_fifo(sspi, sspi->fifo_depth);
 
-	/* Enable the interrupts */
-	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, SUN6I_INT_CTL_TC);
-	sun6i_spi_enable_interrupt(sspi, SUN6I_INT_CTL_TC |
-					 SUN6I_INT_CTL_RF_RDY);
-	if (tx_len > sspi->fifo_depth)
-		sun6i_spi_enable_interrupt(sspi, SUN6I_INT_CTL_TF_ERQ);
+	/* Enable transfer complete interrupt */
+	sun6i_spi_enable_interrupt(sspi, SUN6I_INT_CTL_TC);
 
 	/* Start the transfer */
 	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
@@ -372,7 +365,9 @@ out:
 static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
 {
 	struct sun6i_spi *sspi = dev_id;
-	u32 status = sun6i_spi_read(sspi, SUN6I_INT_STA_REG);
+	u32 status;
+
+	status = sun6i_spi_read(sspi, SUN6I_INT_STA_REG);
 
 	/* Transfer complete */
 	if (status & SUN6I_INT_CTL_TC) {
@@ -382,28 +377,6 @@ static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
-	/* Receive FIFO 3/4 full */
-	if (status & SUN6I_INT_CTL_RF_RDY) {
-		sun6i_spi_drain_fifo(sspi, SUN6I_FIFO_DEPTH);
-		/* Only clear the interrupt _after_ draining the FIFO */
-		sun6i_spi_write(sspi, SUN6I_INT_STA_REG, SUN6I_INT_CTL_RF_RDY);
-		return IRQ_HANDLED;
-	}
-
-	/* Transmit FIFO 3/4 empty */
-	if (status & SUN6I_INT_CTL_TF_ERQ) {
-		sun6i_spi_fill_fifo(sspi, SUN6I_FIFO_DEPTH);
-
-		if (!sspi->len)
-			/* nothing left to transmit */
-			sun6i_spi_disable_interrupt(sspi, SUN6I_INT_CTL_TF_ERQ);
-
-		/* Only clear the interrupt _after_ re-seeding the FIFO */
-		sun6i_spi_write(sspi, SUN6I_INT_STA_REG, SUN6I_INT_CTL_TF_ERQ);
-
-		return IRQ_HANDLED;
-	}
-
 	return IRQ_NONE;
 }
 
-- 
2.16.2
