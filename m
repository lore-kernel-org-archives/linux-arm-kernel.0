From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Tue,  3 Apr 2018 18:44:46 +0300
Subject: [PATCH v3 3/6] spi: sun6i: restrict transfer length in PIO-mode
In-Reply-To: <20180403154449.2443-1-ssuloev@orpaltech.com>
References: <20180403154449.2443-1-ssuloev@orpaltech.com>
Message-ID: <20180403154449.2443-4-ssuloev@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to handle 3/4 empty interrupt as the maximum
supported transfer length in PIO mode is equal to FIFO depth,
i.e. 128 bytes for sun6i and 64 bytes for sun8i SoCs.

Changes in v3:
1) Restored processing of 3/4 FIFO full interrupt.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
---
 drivers/spi/spi-sun6i.c | 41 +++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 78acc1f..c09ad10 100644
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
@@ -255,8 +258,14 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
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
@@ -278,8 +287,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	 */
 	trig_level = sspi->fifo_depth / 4 * 3;
 	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG,
-			(trig_level << SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_BITS) |
-			(trig_level << SUN6I_FIFO_CTL_TF_ERQ_TRIG_LEVEL_BITS));
+			(trig_level << SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_BITS));
 
 
 	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
@@ -343,11 +351,8 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	sun6i_spi_fill_fifo(sspi, sspi->fifo_depth);
 
 	/* Enable the interrupts */
-	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, SUN6I_INT_CTL_TC);
 	sun6i_spi_enable_interrupt(sspi, SUN6I_INT_CTL_TC |
 					 SUN6I_INT_CTL_RF_RDY);
-	if (tx_len > sspi->fifo_depth)
-		sun6i_spi_enable_interrupt(sspi, SUN6I_INT_CTL_TF_ERQ);
 
 	/* Start the transfer */
 	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
@@ -376,7 +381,9 @@ out:
 static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
 {
 	struct sun6i_spi *sspi = dev_id;
-	u32 status = sun6i_spi_read(sspi, SUN6I_INT_STA_REG);
+	u32 status;
+
+	status = sun6i_spi_read(sspi, SUN6I_INT_STA_REG);
 
 	/* Transfer complete */
 	if (status & SUN6I_INT_CTL_TC) {
@@ -388,26 +395,12 @@ static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
 
 	/* Receive FIFO 3/4 full */
 	if (status & SUN6I_INT_CTL_RF_RDY) {
-		sun6i_spi_drain_fifo(sspi, SUN6I_FIFO_DEPTH);
+		sun6i_spi_drain_fifo(sspi, sspi->fifo_depth);
 		/* Only clear the interrupt _after_ draining the FIFO */
 		sun6i_spi_write(sspi, SUN6I_INT_STA_REG, SUN6I_INT_CTL_RF_RDY);
 		return IRQ_HANDLED;
 	}
 
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
