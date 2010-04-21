From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Wed, 21 Apr 2010 13:46:51 +0300
Subject: [PATCH v4 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <0D753D10438DA54287A00B0270842697636D85BE26@AUSP01VMBX24.collaborationhost.net>
References: <cover.1271774845.git.mika.westerberg@iki.fi>
	<e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D85BCCC@AUSP01VMBX24.collaborationhost.net>
	<z2h56d259a01004201654y93f6c533j11b5accd7e2f46e7@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D85BDD8@AUSP01VMBX24.collaborationhost.net>
	<n2u56d259a01004201810j22c17bcfn9fee59e9c65c4d7f@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D85BE26@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20100421104651.GO19534@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 20, 2010 at 08:52:26PM -0500, H Hartley Sweeten wrote:
> On Tuesday, April 20, 2010 6:10 PM, Martin Guy wrote:
> > Not easily, but it seems a likely cause.
> > To prevent card deselection mid-message I think we would need to
> > handle multi-transfer messages by making the start of transfers 2..N
> > continuous with the end of transfers 1..N-1 instead of draining the
> > reply from each one before starting the next.
> > 
> > Am I on the right track?
> 
> Yes.  I'm just not sure how to implement this.

I made a hack that allows transfer handler to continue to the next transfer directly
if there is no special per transfer settings in the message. Could you try that out
and report whether SFRMOUT works better with it?

Note that this is just to make sure that we are on the right track.

Patch is against v4 of the driver.

Thanks,
MW

diff --git a/drivers/spi/ep93xx_spi.c b/drivers/spi/ep93xx_spi.c
index 310032d..11dcdd1 100644
--- a/drivers/spi/ep93xx_spi.c
+++ b/drivers/spi/ep93xx_spi.c
@@ -106,6 +106,8 @@ struct ep93xx_spi {
 	unsigned long			min_rate;
 	unsigned long			max_rate;
 	bool				running;
+	bool				can_continue;
+	struct spi_transfer 		*last_transfer;
 	struct workqueue_struct		*wq;
 	struct work_struct		msg_work;
 	struct completion		wait;
@@ -380,6 +382,7 @@ static int ep93xx_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 	struct ep93xx_spi *espi = spi_master_get_devdata(spi->master);
 	struct spi_transfer *t;
 	unsigned long flags;
+	bool can_continue = true;
 
 	if (!msg || !msg->complete)
 		return -EINVAL;
@@ -387,11 +390,21 @@ static int ep93xx_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 	/* first validate each transfer */
 	list_for_each_entry(t, &msg->transfers, transfer_list) {
 		if (t->bits_per_word) {
+			can_continue = false;
 			if (t->bits_per_word < 4 || t->bits_per_word > 16)
 				return -EINVAL;
 		}
-		if (t->speed_hz && t->speed_hz < espi->min_rate)
+		if (t->speed_hz) {
+			can_continue = false;
+			if (t->speed_hz < espi->min_rate)
 				return -EINVAL;
+		}
+		if (t->cs_change &&
+			!list_is_last(&t->transfer_list, &msg->transfers)) {
+			can_continue = false;
+		}
+		if (t->delay_usecs)
+			can_continue = false;
 	}
 
 	/*
@@ -400,7 +413,7 @@ static int ep93xx_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 	 * error in transfer and @msg->state is used to hold pointer to the
 	 * current transfer (or %NULL if no active current transfer).
 	 */
-	msg->state = NULL;
+	msg->state = (void *)can_continue;
 	msg->status = 0;
 	msg->actual_length = 0;
 
@@ -606,10 +619,33 @@ static void ep93xx_spi_process_message(struct ep93xx_spi *espi,
 	ep93xx_spi_chip_setup(espi, spi_get_ctldata(msg->spi));
 	ep93xx_spi_select_device(espi, msg->spi);
 
-	list_for_each_entry(t, &msg->transfers, transfer_list) {
-		ep93xx_spi_process_transfer(espi, msg, t);
-		if (msg->status)
-			break;
+	if (msg->state) {
+		espi->can_continue = true;
+		espi->last_transfer = list_entry(msg->transfers.prev, struct spi_transfer,
+						 transfer_list);
+	} else {
+		espi->can_continue = false;
+		espi->last_transfer = NULL;
+	}
+
+	/*
+	 * In case there is no transfer specific settings in this message we
+	 * can transfer the whole message with interrupts. Otherwise we need
+	 * to perform transfer specific stuff in thread context.
+	 */
+	if (espi->can_continue) {
+		msg->state = list_first_entry(&msg->transfers, struct spi_transfer,
+					      transfer_list);
+		espi->rx = 0;
+		espi->tx = 0;
+		ep93xx_spi_enable_interrupts(espi);
+		wait_for_completion(&espi->wait);
+	} else {
+		list_for_each_entry(t, &msg->transfers, transfer_list) {
+			ep93xx_spi_process_transfer(espi, msg, t);
+			if (msg->status)
+				break;
+		}
 	}
 
 	/*
@@ -792,6 +828,24 @@ static irqreturn_t ep93xx_spi_interrupt(int irq, void *dev_id)
 			 * interrupt then.
 			 */
 			return IRQ_HANDLED;
+		} else {
+			/*
+			 * If we can continue directly to the next transfer, do
+			 * that now.
+			 */
+			if (espi->can_continue) {
+				struct spi_message *msg = espi->current_msg;
+				struct spi_transfer *t = msg->state;
+
+				if (t != espi->last_transfer) {
+					msg->state = list_entry(t->transfer_list.next, struct spi_transfer,
+								transfer_list);
+					espi->rx = 0;
+					espi->tx = 0;
+					return IRQ_HANDLED;
+				}
+			}
+			/* otherwise we are ready */
 		}
 	}
 
