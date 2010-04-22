From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu, 22 Apr 2010 20:55:03 +0300
Subject: [PATCH v4 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <0D753D10438DA54287A00B0270842697636D8C8672@AUSP01VMBX24.collaborationhost.net>
References: <cover.1271774845.git.mika.westerberg@iki.fi>
	<e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D85BCCC@AUSP01VMBX24.collaborationhost.net>
	<z2h56d259a01004201654y93f6c533j11b5accd7e2f46e7@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D85BDD8@AUSP01VMBX24.collaborationhost.net>
	<n2u56d259a01004201810j22c17bcfn9fee59e9c65c4d7f@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D85BE26@AUSP01VMBX24.collaborationhost.net>
	<20100421104651.GO19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D8C8672@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20100422175503.GE26418@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 21, 2010 at 01:00:56PM -0500, H Hartley Sweeten wrote:
>  
> Same results are your v4 driver.  But, I think your on the right track.
> 
> I think the problem is in the ep93xx_spi_read_write routine.  That function
> returns 0 as long as there is still data left in the current transfer.  The
> only time it doesn't return 0, which will cause the can_continue, is when:
> 
> 	if (espi->rx == t->len) {
> 		msg->actual_length += t->len;
> 		return t->len;
> 	}
> 
> At this point the tx and rx fifos will both be empty, which causes the SSP
> peripheral to raise the SFRM signal.

Hi again,

I crafted up next hack. It includes also your priming the FIFO
finding (thanks for that). Following patch is against v4 version
of the driver.

It performs another read/write after given transfer is finished.
I'm hoping that it could make it before SFRMOUT is deasserted.

Could you test this in your setup?

Thanks,
MW

diff --git a/drivers/spi/ep93xx_spi.c b/drivers/spi/ep93xx_spi.c
index 310032d..7a5c89e 100644
--- a/drivers/spi/ep93xx_spi.c
+++ b/drivers/spi/ep93xx_spi.c
@@ -105,6 +105,7 @@ struct ep93xx_spi {
 	int				irq;
 	unsigned long			min_rate;
 	unsigned long			max_rate;
+	bool				continuous;
 	bool				running;
 	struct workqueue_struct		*wq;
 	struct work_struct		msg_work;
@@ -380,6 +381,7 @@ static int ep93xx_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 	struct ep93xx_spi *espi = spi_master_get_devdata(spi->master);
 	struct spi_transfer *t;
 	unsigned long flags;
+	bool continuous = true;
 
 	if (!msg || !msg->complete)
 		return -EINVAL;
@@ -389,9 +391,19 @@ static int ep93xx_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 		if (t->bits_per_word) {
 			if (t->bits_per_word < 4 || t->bits_per_word > 16)
 				return -EINVAL;
+			continuous = false;
 		}
-		if (t->speed_hz && t->speed_hz < espi->min_rate)
+		if (t->speed_hz) {
+			if (t->speed_hz < espi->min_rate)
 				return -EINVAL;
+			continuous = false;
+		}
+		if (t->cs_change) {
+			if (!list_is_last(&t->transfer_list, &msg->transfers))
+				continuous = false;
+		}
+		if (t->delay_usecs)
+			continuous = false;
 	}
 
 	/*
@@ -399,8 +411,11 @@ static int ep93xx_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 	 * suitable for us. We use @msg->status to signal whether there was
 	 * error in transfer and @msg->state is used to hold pointer to the
 	 * current transfer (or %NULL if no active current transfer).
+	 *
+	 * We hold continuation information in @msg->state while it is not
+	 * processed.
 	 */
-	msg->state = NULL;
+	msg->state = (void *)continuous;
 	msg->status = 0;
 	msg->actual_length = 0;
 
@@ -550,6 +565,91 @@ static void ep93xx_spi_process_transfer(struct ep93xx_spi *espi,
 		ep93xx_spi_chip_setup(espi, chip);
 }
 
+/**
+ * bits_per_word() - returns bits per word for current message
+ */
+static inline int bits_per_word(const struct ep93xx_spi *espi)
+{
+	struct spi_message *msg = espi->current_msg;
+	struct spi_transfer *t = msg->state;
+
+	return t->bits_per_word ? t->bits_per_word : msg->spi->bits_per_word;
+}
+
+static void ep93xx_do_write(struct ep93xx_spi *espi, struct spi_transfer *t)
+{
+	if (bits_per_word(espi) > 8) {
+		u16 tx_val = 0;
+
+		if (t->tx_buf)
+			tx_val = ((u16 *)t->tx_buf)[espi->tx];
+		ep93xx_spi_write_u16(espi, SSPDR, tx_val);
+		espi->tx += sizeof(tx_val);
+	} else {
+		u8 tx_val = 0;
+
+		if (t->tx_buf)
+			tx_val = ((u8 *)t->tx_buf)[espi->tx];
+		ep93xx_spi_write_u8(espi, SSPDR, tx_val);
+		espi->tx += sizeof(tx_val);
+	}
+}
+
+static void ep93xx_do_read(struct ep93xx_spi *espi, struct spi_transfer *t)
+{
+	if (bits_per_word(espi) > 8) {
+		u16 rx_val;
+
+		rx_val = ep93xx_spi_read_u16(espi, SSPDR);
+		if (t->rx_buf)
+			((u16 *)t->rx_buf)[espi->rx] = rx_val;
+		espi->rx += sizeof(rx_val);
+	} else {
+		u8 rx_val;
+
+		rx_val = ep93xx_spi_read_u8(espi, SSPDR);
+		if (t->rx_buf)
+			((u8 *)t->rx_buf)[espi->rx] = rx_val;
+		espi->rx += sizeof(rx_val);
+	}
+}
+
+/**
+ * ep93xx_spi_read_write() - perform next RX/TX transfer
+ * @espi: ep93xx SPI controller struct
+ *
+ * This function transfers next bytes (or half-words) to/from RX/TX FIFOs. If
+ * called several times, the whole transfer will be completed. Returns %0 when
+ * current transfer was not yet completed otherwise length of the transfer
+ * (>%0). When this function is finished, RX FIFO should be empty and TX FIFO
+ * should be full.
+ */
+static int ep93xx_spi_read_write(struct ep93xx_spi *espi)
+{
+	struct spi_message *msg = espi->current_msg;
+	struct spi_transfer *t = msg->state;
+
+	/* read as long as RX FIFO has frames in it */
+	while ((ep93xx_spi_read_u8(espi, SSPSR) & SSPSR_RNE)) {
+		ep93xx_do_read(espi, t);
+		espi->fifo_level--;
+	}
+
+	/* write as long as TX FIFO has room */
+	while (espi->fifo_level < SPI_FIFO_SIZE && espi->tx < t->len) {
+		ep93xx_do_write(espi, t);
+		espi->fifo_level++;
+	}
+
+	if (espi->rx == t->len) {
+		msg->actual_length += t->len;
+		return t->len;
+	}
+
+	return 0;
+}
+
+
 /*
  * ep93xx_spi_process_message() - process one SPI message
  * @espi: ep93xx SPI controller struct
@@ -569,6 +669,8 @@ static void ep93xx_spi_process_message(struct ep93xx_spi *espi,
 	struct spi_transfer *t;
 	int err;
 
+	espi->continuous = (bool)msg->state;
+
 	/*
 	 * Enable the SPI controller and its clock.
 	 */
@@ -606,12 +708,43 @@ static void ep93xx_spi_process_message(struct ep93xx_spi *espi,
 	ep93xx_spi_chip_setup(espi, spi_get_ctldata(msg->spi));
 	ep93xx_spi_select_device(espi, msg->spi);
 
-	list_for_each_entry(t, &msg->transfers, transfer_list) {
-		ep93xx_spi_process_transfer(espi, msg, t);
-		if (msg->status)
-			break;
+	if (espi->continuous) {
+		/*
+		 * We can transfer all the transfers continuously.
+		 */
+		espi->rx = 0;
+		espi->tx = 0;
+		msg->state = list_first_entry(&msg->transfers, struct spi_transfer,
+					transfer_list);
+
+		/* prime the first transfer */
+		if (ep93xx_spi_read_write(espi)) {
+			/*
+			 * Transfer was completed. Pick next one and continue
+			 * if necessary.
+			 */
+			t = msg->state;
+			if (list_is_last(&t->transfer_list, &msg->transfers))
+				goto done;
+
+			espi->rx = 0;
+			espi->tx = 0;
+			msg->state = list_entry(t->transfer_list.next,
+						struct spi_transfer,
+						transfer_list);
+		}
+
+		ep93xx_spi_enable_interrupts(espi);
+		wait_for_completion(&espi->wait);
+	} else {
+		list_for_each_entry(t, &msg->transfers, transfer_list) {
+			ep93xx_spi_process_transfer(espi, msg, t);
+			if (msg->status)
+				break;
+		}
 	}
 
+done:
 	/*
 	 * Now the whole message is transferred (or failed for some reason). We
 	 * deselect the device and disable the SPI controller.
@@ -667,90 +800,6 @@ static void ep93xx_spi_work(struct work_struct *work)
 }
 
 /**
- * bits_per_word() - returns bits per word for current message
- */
-static inline int bits_per_word(const struct ep93xx_spi *espi)
-{
-	struct spi_message *msg = espi->current_msg;
-	struct spi_transfer *t = msg->state;
-
-	return t->bits_per_word ? t->bits_per_word : msg->spi->bits_per_word;
-}
-
-static void ep93xx_do_write(struct ep93xx_spi *espi, struct spi_transfer *t)
-{
-	if (bits_per_word(espi) > 8) {
-		u16 tx_val = 0;
-
-		if (t->tx_buf)
-			tx_val = ((u16 *)t->tx_buf)[espi->tx];
-		ep93xx_spi_write_u16(espi, SSPDR, tx_val);
-		espi->tx += sizeof(tx_val);
-	} else {
-		u8 tx_val = 0;
-
-		if (t->tx_buf)
-			tx_val = ((u8 *)t->tx_buf)[espi->tx];
-		ep93xx_spi_write_u8(espi, SSPDR, tx_val);
-		espi->tx += sizeof(tx_val);
-	}
-}
-
-static void ep93xx_do_read(struct ep93xx_spi *espi, struct spi_transfer *t)
-{
-	if (bits_per_word(espi) > 8) {
-		u16 rx_val;
-
-		rx_val = ep93xx_spi_read_u16(espi, SSPDR);
-		if (t->rx_buf)
-			((u16 *)t->rx_buf)[espi->rx] = rx_val;
-		espi->rx += sizeof(rx_val);
-	} else {
-		u8 rx_val;
-
-		rx_val = ep93xx_spi_read_u8(espi, SSPDR);
-		if (t->rx_buf)
-			((u8 *)t->rx_buf)[espi->rx] = rx_val;
-		espi->rx += sizeof(rx_val);
-	}
-}
-
-/**
- * ep93xx_spi_read_write() - perform next RX/TX transfer
- * @espi: ep93xx SPI controller struct
- *
- * This function transfers next bytes (or half-words) to/from RX/TX FIFOs. If
- * called several times, the whole transfer will be completed. Returns %0 when
- * current transfer was not yet completed otherwise length of the transfer
- * (>%0). When this function is finished, RX FIFO should be empty and TX FIFO
- * should be full.
- */
-static int ep93xx_spi_read_write(struct ep93xx_spi *espi)
-{
-	struct spi_message *msg = espi->current_msg;
-	struct spi_transfer *t = msg->state;
-
-	/* read as long as RX FIFO has frames in it */
-	while ((ep93xx_spi_read_u8(espi, SSPSR) & SSPSR_RNE)) {
-		ep93xx_do_read(espi, t);
-		espi->fifo_level--;
-	}
-
-	/* write as long as TX FIFO has room */
-	while (espi->fifo_level < SPI_FIFO_SIZE && espi->tx < t->len) {
-		ep93xx_do_write(espi, t);
-		espi->fifo_level++;
-	}
-
-	if (espi->rx == t->len) {
-		msg->actual_length += t->len;
-		return t->len;
-	}
-
-	return 0;
-}
-
-/**
  * ep93xx_spi_interrupt() - SPI interrupt handler
  * @irq: IRQ number (not used)
  * @dev_id: pointer to EP93xx controller struct
@@ -792,6 +841,27 @@ static irqreturn_t ep93xx_spi_interrupt(int irq, void *dev_id)
 			 * interrupt then.
 			 */
 			return IRQ_HANDLED;
+		} else {
+			struct spi_message *msg = espi->current_msg;
+			struct spi_transfer *t = msg->state;
+
+			if (!espi->continuous)
+				goto done;
+
+			if (!list_is_last(&t->transfer_list, &msg->transfers)) {
+				/*
+				 * Pick next transfer and refill the FIFO.
+				 */
+				msg->state = list_entry(t->transfer_list.next,
+							struct spi_transfer,
+							transfer_list);
+				espi->rx = 0;
+				espi->tx = 0;
+
+				ep93xx_spi_read_write(espi);
+				return IRQ_HANDLED;
+			}
+			/* we are done here */
 		}
 	}
 
@@ -800,6 +870,7 @@ static irqreturn_t ep93xx_spi_interrupt(int irq, void *dev_id)
 	 * any case we disable interrupts and notify the worker to handle
 	 * any post-processing of the message.
 	 */
+done:
 	ep93xx_spi_disable_interrupts(espi);
 	complete(&espi->wait);
 	return IRQ_HANDLED;
