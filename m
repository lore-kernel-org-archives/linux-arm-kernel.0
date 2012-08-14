From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 14 Aug 2012 15:49:20 +0200
Subject: [PATCH 06/23] spi/atmel_spi: status information passed through
 controller data
In-Reply-To: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
References: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1344952177-18385-7-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>

The status of transfer is stored in controller data structure
so that it can be used not only by atmel_spi_msg_done() function.
This will be useful for upcoming dmaengine enabled driver.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-atmel.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 39285ef..49a7f4f 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -201,6 +201,7 @@ struct atmel_spi {
 	unsigned long		current_remaining_bytes;
 	struct spi_transfer	*next_transfer;
 	unsigned long		next_remaining_bytes;
+	int			done_status;
 
 	/* scratch buffer */
 	void			*buffer;
@@ -545,15 +546,15 @@ static void atmel_spi_dma_unmap_xfer(struct spi_master *master,
 
 static void
 atmel_spi_msg_done(struct spi_master *master, struct atmel_spi *as,
-		struct spi_message *msg, int status, int stay)
+		struct spi_message *msg, int stay)
 {
-	if (!stay || status < 0)
+	if (!stay || as->done_status < 0)
 		cs_deactivate(as, msg->spi);
 	else
 		as->stay = msg->spi;
 
 	list_del(&msg->queue);
-	msg->status = status;
+	msg->status = as->done_status;
 
 	dev_dbg(master->dev.parent,
 		"xfer complete: %u bytes transferred\n",
@@ -565,6 +566,7 @@ atmel_spi_msg_done(struct spi_master *master, struct atmel_spi *as,
 
 	as->current_transfer = NULL;
 	as->next_transfer = NULL;
+	as->done_status = 0;
 
 	/* continue if needed */
 	if (list_empty(&as->queue) || as->stopping)
@@ -642,7 +644,8 @@ atmel_spi_interrupt(int irq, void *dev_id)
 		/* Clear any overrun happening while cleaning up */
 		spi_readl(as, SR);
 
-		atmel_spi_msg_done(master, as, msg, -EIO, 0);
+		as->done_status = -EIO;
+		atmel_spi_msg_done(master, as, msg, 0);
 	} else if (pending & (SPI_BIT(RXBUFF) | SPI_BIT(ENDRX))) {
 		ret = IRQ_HANDLED;
 
@@ -660,7 +663,7 @@ atmel_spi_interrupt(int irq, void *dev_id)
 
 			if (atmel_spi_xfer_is_last(msg, xfer)) {
 				/* report completed message */
-				atmel_spi_msg_done(master, as, msg, 0,
+				atmel_spi_msg_done(master, as, msg,
 						xfer->cs_change);
 			} else {
 				if (xfer->cs_change) {
-- 
1.7.2.5
