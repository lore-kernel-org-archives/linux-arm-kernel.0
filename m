From: stephanolbrich@gmx.de (stephanolbrich at gmx.de)
Date: Tue,  9 Feb 2016 19:10:34 +0100
Subject: [PATCH 3/4] spi: bcm2835aux: set up spi-mode before asserting cs-gpio
In-Reply-To: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de>
Message-ID: <1455041435-8015-4-git-send-email-stephanolbrich@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephan Olbrich <stephanolbrich@gmx.de>

When using reverse polarity for clock (spi-cpol) on a device
the clock line gets altered after chip-select has been asserted
resulting in an additional clock beat, which confuses hardware.

To avoid this situation this patch moves the setup of polarity
(spi-cpol and spi-cpha) outside of the chip-select into
prepare_message, which is run prior to asserting chip-select.

Signed-off-by: Stephan Olbrich <stephanolbrich@gmx.de>
---
 drivers/spi/spi-bcm2835aux.c | 54 +++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index d2f0067..b90aa34 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -218,9 +218,9 @@ static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
 			BCM2835_AUX_SPI_CNTL1_IDLE);
 	}
 
-	/* and if rx_len is 0 then wake up completion and disable spi */
+	/* and if rx_len is 0 then disable interrupts and wake up completion */
 	if (!bs->rx_len) {
-		bcm2835aux_spi_reset_hw(bs);
+		bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1]);
 		complete(&master->xfer_completion);
 	}
 
@@ -313,9 +313,6 @@ static int bcm2835aux_spi_transfer_one_poll(struct spi_master *master,
 		}
 	}
 
-	/* Transfer complete - reset SPI HW */
-	bcm2835aux_spi_reset_hw(bs);
-
 	/* and return without waiting for completion */
 	return 0;
 }
@@ -336,10 +333,6 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 	 * resulting (potentially) in more interrupts when transferring
 	 * more than 12 bytes
 	 */
-	bs->cntl[0] = BCM2835_AUX_SPI_CNTL0_ENABLE |
-		      BCM2835_AUX_SPI_CNTL0_VAR_WIDTH |
-		      BCM2835_AUX_SPI_CNTL0_MSBF_OUT;
-	bs->cntl[1] = BCM2835_AUX_SPI_CNTL1_MSBF_IN;
 
 	/* set clock */
 	spi_hz = tfr->speed_hz;
@@ -358,13 +351,6 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 
 	spi_used_hz = clk_hz / (2 * (speed + 1));
 
-	/* handle all the modes */
-	if (spi->mode & SPI_CPOL)
-		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPOL;
-	if (spi->mode & SPI_CPHA)
-		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPHA_OUT |
-			       BCM2835_AUX_SPI_CNTL0_CPHA_IN;
-
 	/* set transmit buffers and length */
 	bs->tx_buf = tfr->tx_buf;
 	bs->rx_buf = tfr->rx_buf;
@@ -388,6 +374,40 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 	return bcm2835aux_spi_transfer_one_irq(master, spi, tfr);
 }
 
+static int bcm2835aux_spi_prepare_message(struct spi_master *master,
+					  struct spi_message *msg)
+{
+	struct spi_device *spi = msg->spi;
+	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
+
+	bs->cntl[0] = BCM2835_AUX_SPI_CNTL0_ENABLE |
+		      BCM2835_AUX_SPI_CNTL0_VAR_WIDTH |
+		      BCM2835_AUX_SPI_CNTL0_MSBF_OUT;
+	bs->cntl[1] = BCM2835_AUX_SPI_CNTL1_MSBF_IN;
+
+	/* handle all the modes */
+	if (spi->mode & SPI_CPOL)
+		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPOL;
+	if (spi->mode & SPI_CPHA)
+		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPHA_OUT |
+			       BCM2835_AUX_SPI_CNTL0_CPHA_IN;
+
+	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1]);
+	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL0, bs->cntl[0]);
+
+	return 0;
+}
+
+static int bcm2835aux_spi_unprepare_message(struct spi_master *master,
+					    struct spi_message *msg)
+{
+	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
+
+	bcm2835aux_spi_reset_hw(bs);
+
+	return 0;
+}
+
 static void bcm2835aux_spi_handle_err(struct spi_master *master,
 				      struct spi_message *msg)
 {
@@ -416,6 +436,8 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 	master->num_chipselect = -1;
 	master->transfer_one = bcm2835aux_spi_transfer_one;
 	master->handle_err = bcm2835aux_spi_handle_err;
+	master->prepare_message = bcm2835aux_spi_prepare_message;
+	master->unprepare_message = bcm2835aux_spi_unprepare_message;
 	master->dev.of_node = pdev->dev.of_node;
 
 	bs = spi_master_get_devdata(master);
-- 
2.5.0
