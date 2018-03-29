From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Thu, 29 Mar 2018 21:59:03 +0300
Subject: [PATCH 2/6] spi: sun4i: restrict transfer length in PIO-mode
In-Reply-To: <20180329185907.27281-1-ssuloev@orpaltech.com>
References: <20180329185907.27281-1-ssuloev@orpaltech.com>
Message-ID: <20180329185907.27281-3-ssuloev@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to handle 3/4 empty/full interrupts
as the maximum supported transfer length in PIO mode
is 64 bytes for sun4i-family SoCs. As long as a
problem was reported previously with filling FIFO
on A10s then we stick with 63 bytes depth.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>

---
 drivers/spi/spi-sun4i.c | 50 ++++++++++++-------------------------------------
 1 file changed, 12 insertions(+), 38 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 4141003..2a49c22 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -22,7 +22,12 @@
 
 #include <linux/spi/spi.h>
 
-#define SUN4I_FIFO_DEPTH		64
+/*
+ * FIFO length is 64 bytes
+ * But filling the FIFO fully might cause a timeout
+ * on some devices, for example on spi2 on A10s
+ */
+#define SUN4I_FIFO_DEPTH		63
 
 #define SUN4I_RXDATA_REG		0x00
 
@@ -202,7 +207,7 @@ static void sun4i_spi_set_cs(struct spi_device *spi, bool enable)
 
 static size_t sun4i_spi_max_transfer_size(struct spi_device *spi)
 {
-	return SUN4I_FIFO_DEPTH - 1;
+	return SUN4I_FIFO_DEPTH;
 }
 
 static int sun4i_spi_transfer_one(struct spi_master *master,
@@ -216,11 +221,8 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	int ret = 0;
 	u32 reg;
 
-	/* We don't support transfer larger than the FIFO */
-	if (tfr->len > SUN4I_MAX_XFER_SIZE)
-		return -EMSGSIZE;
-
-	if (tfr->tx_buf && tfr->len >= SUN4I_MAX_XFER_SIZE)
+	/* We don't support transfers larger than FIFO depth */
+	if (tfr->len > SUN4I_FIFO_DEPTH)
 		return -EMSGSIZE;
 
 	reinit_completion(&sspi->done);
@@ -313,17 +315,11 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 
 	/*
 	 * Fill the TX FIFO
-	 * Filling the FIFO fully causes timeout for some reason
-	 * at least on spi2 on A10s
 	 */
-	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH - 1);
+	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
 
-	/* Enable the interrupts */
-	sun4i_spi_enable_interrupt(sspi, SUN4I_INT_CTL_TC |
-					 SUN4I_INT_CTL_RF_F34);
-	/* Only enable Tx FIFO interrupt if we really need it */
-	if (tx_len > SUN4I_FIFO_DEPTH)
-		sun4i_spi_enable_interrupt(sspi, SUN4I_INT_CTL_TF_E34);
+	/* Enable the transfer complete interrupt */
+	sun4i_spi_enable_interrupt(sspi, SUN4I_INT_CTL_TC);
 
 	/* Start the transfer */
 	reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
@@ -363,28 +359,6 @@ static irqreturn_t sun4i_spi_handler(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
-	/* Receive FIFO 3/4 full */
-	if (status & SUN4I_INT_CTL_RF_F34) {
-		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
-		/* Only clear the interrupt _after_ draining the FIFO */
-		sun4i_spi_write(sspi, SUN4I_INT_STA_REG, SUN4I_INT_CTL_RF_F34);
-		return IRQ_HANDLED;
-	}
-
-	/* Transmit FIFO 3/4 empty */
-	if (status & SUN4I_INT_CTL_TF_E34) {
-		sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
-
-		if (!sspi->len)
-			/* nothing left to transmit */
-			sun4i_spi_disable_interrupt(sspi, SUN4I_INT_CTL_TF_E34);
-
-		/* Only clear the interrupt _after_ re-seeding the FIFO */
-		sun4i_spi_write(sspi, SUN4I_INT_STA_REG, SUN4I_INT_CTL_TF_E34);
-
-		return IRQ_HANDLED;
-	}
-
 	return IRQ_NONE;
 }
 
-- 
2.16.2
