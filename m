From: linus.walleij@stericsson.com (Linus Walleij)
Date: Sat, 19 Feb 2011 21:16:58 +0100
Subject: [PATCH 1/2] pl011: add optional RX DMA to PL011 v2
Message-ID: <1298146618-30958-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This adds an optional RX DMA codepath for the devices that
support this by using the apropriate burst sizes instead of
pulling single bytes.

Includes portions of code written by Russell King during
a PL08x hacking session.

This has been tested on U300 and Ux500.

Tested-by: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Tested-by: Grzegorz Sygieda <grzegorz.sygieda@tieto.com>
Tested-by: Marcin Mielczarczyk <marcin.mielczarczyk@tieto.com>
Signed-off-by: Per Forlin <per.friden@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/amba-pl011.c |  454 +++++++++++++++++++++++++++++++++++++--
 1 files changed, 434 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index e76d7d0..cb45136 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -96,6 +96,22 @@ static struct vendor_data vendor_st = {
 };
 
 /* Deals with DMA transactions */
+
+struct pl011_sgbuf {
+	struct scatterlist sg;
+	char *buf;
+};
+
+struct pl011_dmarx_data {
+	struct dma_chan		*chan;
+	struct completion	complete;
+	bool			use_buf_b;
+	struct pl011_sgbuf	sgbuf_a;
+	struct pl011_sgbuf	sgbuf_b;
+	dma_cookie_t		cookie;
+	bool			running;
+};
+
 struct pl011_dmatx_data {
 	struct dma_chan		*chan;
 	struct scatterlist	sg;
@@ -120,7 +136,9 @@ struct uart_amba_port {
 	char			type[12];
 #ifdef CONFIG_DMA_ENGINE
 	/* DMA stuff */
-	bool			using_dma;
+	bool			using_tx_dma;
+	bool			using_rx_dma;
+	struct pl011_dmarx_data dmarx;
 	struct pl011_dmatx_data	dmatx;
 #endif
 };
@@ -134,6 +152,31 @@ struct uart_amba_port {
 
 #define PL011_DMA_BUFFER_SIZE PAGE_SIZE
 
+static int pl011_sgbuf_init(struct dma_chan *chan, struct pl011_sgbuf *sg,
+	enum dma_data_direction dir)
+{
+	sg->buf = kmalloc(PL011_DMA_BUFFER_SIZE, GFP_KERNEL);
+	if (!sg->buf)
+		return -ENOMEM;
+
+	sg_init_one(&sg->sg, sg->buf, PL011_DMA_BUFFER_SIZE);
+
+	if (dma_map_sg(chan->device->dev, &sg->sg, 1, dir) != 1) {
+		kfree(sg->buf);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static void pl011_sgbuf_free(struct dma_chan *chan, struct pl011_sgbuf *sg,
+	enum dma_data_direction dir)
+{
+	if (sg->buf) {
+		dma_unmap_sg(chan->device->dev, &sg->sg, 1, dir);
+		kfree(sg->buf);
+	}
+}
+
 static void pl011_dma_probe_initcall(struct uart_amba_port *uap)
 {
 	/* DMA is the sole user of the platform data right now */
@@ -153,7 +196,7 @@ static void pl011_dma_probe_initcall(struct uart_amba_port *uap)
 		return;
 	}
 
-	/* Try to acquire a generic DMA engine slave channel */
+	/* Try to acquire a generic DMA engine slave TX channel */
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
@@ -168,6 +211,28 @@ static void pl011_dma_probe_initcall(struct uart_amba_port *uap)
 
 	dev_info(uap->port.dev, "DMA channel TX %s\n",
 		 dma_chan_name(uap->dmatx.chan));
+
+	/* Optionally make use of an RX channel as well */
+	if (plat->dma_rx_param) {
+		struct dma_slave_config rx_conf = {
+			.src_addr = uap->port.mapbase + UART01x_DR,
+			.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE,
+			.direction = DMA_FROM_DEVICE,
+			.src_maxburst = uap->fifosize >> 1,
+		};
+
+		chan = dma_request_channel(mask, plat->dma_filter, plat->dma_rx_param);
+		if (!chan) {
+			dev_err(uap->port.dev, "no RX DMA channel!\n");
+			return;
+		}
+
+		dmaengine_slave_config(chan, &rx_conf);
+		uap->dmarx.chan = chan;
+
+		dev_info(uap->port.dev, "DMA channel RX %s\n",
+			 dma_chan_name(uap->dmarx.chan));
+	}
 }
 
 #ifndef MODULE
@@ -219,9 +284,10 @@ static void pl011_dma_remove(struct uart_amba_port *uap)
 	/* TODO: remove the initcall if it has not yet executed */
 	if (uap->dmatx.chan)
 		dma_release_channel(uap->dmatx.chan);
+	if (uap->dmarx.chan)
+		dma_release_channel(uap->dmarx.chan);
 }
 
-
 /* Forward declare this for the refill routine */
 static int pl011_dma_tx_refill(struct uart_amba_port *uap);
 
@@ -380,7 +446,7 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
  */
 static bool pl011_dma_tx_irq(struct uart_amba_port *uap)
 {
-	if (!uap->using_dma)
+	if (!uap->using_tx_dma)
 		return false;
 
 	/*
@@ -432,7 +498,7 @@ static inline bool pl011_dma_tx_start(struct uart_amba_port *uap)
 {
 	u16 dmacr;
 
-	if (!uap->using_dma)
+	if (!uap->using_tx_dma)
 		return false;
 
 	if (!uap->port.x_char) {
@@ -492,7 +558,7 @@ static void pl011_dma_flush_buffer(struct uart_port *port)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
 
-	if (!uap->using_dma)
+	if (!uap->using_tx_dma)
 		return;
 
 	/* Avoid deadlock with the DMA engine callback */
@@ -508,9 +574,260 @@ static void pl011_dma_flush_buffer(struct uart_port *port)
 	}
 }
 
+static void pl011_dma_rx_callback(void *data);
+
+static int pl011_dma_rx_trigger_dma(struct uart_amba_port *uap)
+{
+	struct dma_chan *rxchan = uap->dmarx.chan;
+	struct dma_device *dma_dev;
+	struct pl011_dmarx_data *dmarx = &uap->dmarx;
+	struct dma_async_tx_descriptor *desc;
+	struct pl011_sgbuf *sgbuf;
+
+	if (!rxchan)
+		return -EIO;
+
+	/* Start the RX DMA job */
+	sgbuf = uap->dmarx.use_buf_b ?
+		&uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
+	dma_dev = rxchan->device;
+	desc = rxchan->device->device_prep_slave_sg(rxchan, &sgbuf->sg, 1,
+					DMA_FROM_DEVICE,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	/*
+	 * If the DMA engine is busy and cannot prepare a
+	 * channel, no big deal, the driver will fall back
+	 * to interrupt mode as a result of this error code.
+	 */
+	if (!desc) {
+		uap->dmarx.running = false;
+		dmaengine_terminate_all(rxchan);
+		return -EBUSY;
+	}
+
+	/* Some data to go along to the callback */
+	desc->callback = pl011_dma_rx_callback;
+	desc->callback_param = uap;
+	dmarx->cookie = dmaengine_submit(desc);
+	dma_async_issue_pending(rxchan);
+
+	uap->dmacr |= UART011_RXDMAE;
+	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
+	uap->dmarx.running = true;
+
+	uap->im &= ~UART011_RXIM;
+	writew(uap->im, uap->port.membase + UART011_IMSC);
+
+	return 0;
+}
+
+/*
+ * This is called when either the DMA job is complete, or
+ * the FIFO timeout interrupt occurred. This must be called
+ * with the port spinlock uap->port.lock held.
+ */
+static void pl011_dma_rx_chars(struct uart_amba_port *uap,
+			       u32 pending, bool use_buf_b,
+			       bool readfifo)
+{
+	struct tty_struct *tty = uap->port.state->port.tty;
+	struct pl011_sgbuf *sgbuf = use_buf_b ?
+		&uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
+	struct device *dev = uap->dmarx.chan->device->dev;
+	unsigned int status, ch, flag;
+	int dma_count = 0;
+	u32 fifotaken = 0; /* only used for vdbg() */
+
+	/* Pick everything from the DMA first */
+	if (pending) {
+		/* Sync in buffer */
+		dma_sync_sg_for_cpu(dev, &sgbuf->sg, 1, DMA_FROM_DEVICE);
+
+		/*
+		 * First take all chars in the DMA pipe, then look in the FIFO.
+		 * Note that tty_insert_flip_buf() tries to take as many chars
+		 * as it can.
+		 */
+		dma_count = tty_insert_flip_string(uap->port.state->port.tty,
+						   sgbuf->buf, pending);
+
+		/* Return buffer to device */
+		dma_sync_sg_for_device(dev, &sgbuf->sg, 1, DMA_FROM_DEVICE);
+
+		uap->port.icount.rx += dma_count;
+		if (dma_count < pending)
+			dev_warn(uap->port.dev,
+				 "couldn't insert all characters (TTY is full?)\n");
+	}
+
+	/*
+	 * Only continue with trying to read the FIFO if all DMA chars have
+	 * been taken first.
+	 */
+	if (dma_count == pending && readfifo) {
+		/* Clear any error flags */
+		writew(UART011_OEIS | UART011_BEIS | UART011_PEIS | UART011_FEIS,
+		       uap->port.membase + UART011_ICR);
+
+		/*
+		 * If we read all the DMA'd characters, and we had an
+		 * incomplete buffer, that could be due to an rx error,
+		 * or maybe we just timed out. Read any pending chars
+		 * and check the error status.
+		 */
+		while (1) {
+			status = readw(uap->port.membase + UART01x_FR);
+			if (status & UART01x_FR_RXFE)
+				break;
+
+			/* Take chars from the FIFO and update status */
+			ch = readw(uap->port.membase + UART01x_DR) |
+			       UART_DUMMY_DR_RX;
+			flag = TTY_NORMAL;
+			uap->port.icount.rx++;
+			fifotaken++;
+
+			/*
+			 * Error conditions will only occur in the FIFO,
+			 * these will trigger an immediate interrupt and
+			 * stop the DMA job, so we will always find the
+			 * error in the FIFO, never in the DMA buffer.
+			 */
+			if (unlikely(ch & UART_DR_ERROR)) {
+				if (ch & UART011_DR_BE) {
+					ch &= ~(UART011_DR_FE | UART011_DR_PE);
+					uap->port.icount.brk++;
+					if (uart_handle_break(&uap->port))
+						continue;
+				} else if (ch & UART011_DR_PE)
+					uap->port.icount.parity++;
+				else if (ch & UART011_DR_FE)
+					uap->port.icount.frame++;
+				if (ch & UART011_DR_OE)
+					uap->port.icount.overrun++;
+
+				ch &= uap->port.read_status_mask;
+
+				if (ch & UART011_DR_BE)
+					flag = TTY_BREAK;
+				else if (ch & UART011_DR_PE)
+					flag = TTY_PARITY;
+				else if (ch & UART011_DR_FE)
+					flag = TTY_FRAME;
+			}
+
+			if (uart_handle_sysrq_char(&uap->port, ch & 255))
+				continue;
+
+			uart_insert_char(&uap->port, ch, UART011_DR_OE, ch, flag);
+		}
+	}
+
+	spin_unlock(&uap->port.lock);
+	dev_vdbg(uap->port.dev,
+		 "Took %d chars from DMA buffer and %d chars from the FIFO\n",
+		 dma_count, fifotaken);
+	tty_flip_buffer_push(tty);
+	spin_lock(&uap->port.lock);
+}
+
+static void pl011_dma_rx_irq(struct uart_amba_port *uap)
+{
+	struct pl011_dmarx_data *dmarx = &uap->dmarx;
+	struct dma_chan *rxchan = dmarx->chan;
+	struct pl011_sgbuf *sgbuf = dmarx->use_buf_b ?
+		&dmarx->sgbuf_b : &dmarx->sgbuf_a;
+	size_t pending;
+	struct dma_tx_state state;
+	enum dma_status dmastat;
+
+	/*
+	 * Pause the transfer so we can trust the current counter,
+	 * do this before we pause the PL011 block, else we may
+	 * overflow the FIFO.
+	 */
+	if (dmaengine_pause(rxchan))
+		dev_err(uap->port.dev, "unable to pause DMA transfer\n");
+	dmastat = rxchan->device->device_tx_status(rxchan,
+						   dmarx->cookie, &state);
+	if (dmastat != DMA_PAUSED)
+		dev_err(uap->port.dev, "unable to pause DMA transfer\n");
+
+	/* Disable RX DMA - incoming data will wait in the FIFO */
+	uap->dmacr &= ~UART011_RXDMAE;
+	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
+	uap->dmarx.running = false;
+
+	pending = sgbuf->sg.length - state.residue;
+	BUG_ON(pending > PL011_DMA_BUFFER_SIZE);
+	/* Then we terminate the transfer - we now know our residue */
+	dmaengine_terminate_all(rxchan);
+
+	/*
+	 * This will take the chars we have so far and insert
+	 * into the framework.
+	 */
+	pl011_dma_rx_chars(uap, pending, dmarx->use_buf_b, true);
+
+	/* Switch buffer & re-trigger DMA job */
+	dmarx->use_buf_b = !dmarx->use_buf_b;
+	if (pl011_dma_rx_trigger_dma(uap)) {
+		dev_dbg(uap->port.dev, "could not retrigger RX DMA job "
+			"fall back to interrupt mode\n");
+		uap->im |= UART011_RXIM;
+		writew(uap->im, uap->port.membase + UART011_IMSC);
+	}
+}
+
+static void pl011_dma_rx_callback(void *data)
+{
+	struct uart_amba_port *uap = data;
+	struct pl011_dmarx_data *dmarx = &uap->dmarx;
+	bool lastbuf = dmarx->use_buf_b;
+	int ret;
+
+	/*
+	 * This completion interrupt occurs typically when the
+	 * RX buffer is totally stuffed but no timeout has yet
+	 * occurred. When that happens, we just want the RX
+	 * routine to flush out the secondary DMA buffer while
+	 * we immediately trigger the next DMA job.
+	 */
+	spin_lock_irq(&uap->port.lock);
+	uap->dmarx.running = false;
+	dmarx->use_buf_b = !lastbuf;
+	ret = pl011_dma_rx_trigger_dma(uap);
+
+	pl011_dma_rx_chars(uap, PL011_DMA_BUFFER_SIZE, lastbuf, false);
+	spin_unlock_irq(&uap->port.lock);
+	/*
+	 * Do this check after we picked the DMA chars so we don't
+	 * get some IRQ immediately from RX.
+	 */
+	if (ret) {
+		dev_dbg(uap->port.dev, "could not retrigger RX DMA job "
+			"fall back to interrupt mode\n");
+		uap->im |= UART011_RXIM;
+		writew(uap->im, uap->port.membase + UART011_IMSC);
+	}
+}
+
+/*
+ * Stop accepting received characters, when we're shutting down or
+ * suspending this port.
+ * Locking: called with port lock held and IRQs disabled.
+ */
+static inline void pl011_dma_rx_stop(struct uart_amba_port *uap)
+{
+	/* FIXME.  Just disable the DMA enable */
+	uap->dmacr &= ~UART011_RXDMAE;
+	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
+}
 
 static void pl011_dma_startup(struct uart_amba_port *uap)
 {
+	int ret;
+
 	if (!uap->dmatx.chan)
 		return;
 
@@ -525,8 +842,33 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 
 	/* The DMA buffer is now the FIFO the TTY subsystem can use */
 	uap->port.fifosize = PL011_DMA_BUFFER_SIZE;
-	uap->using_dma = true;
+	uap->using_tx_dma = true;
+
+	if (!uap->dmarx.chan)
+		goto skip_rx;
+
+	/* Allocate and map DMA RX buffers */
+	ret = pl011_sgbuf_init(uap->dmarx.chan, &uap->dmarx.sgbuf_a,
+			       DMA_FROM_DEVICE);
+	if (ret) {
+		dev_err(uap->port.dev, "failed to init DMA %s: %d\n",
+			"RX buffer A", ret);
+		goto skip_rx;
+	}
+
+	ret = pl011_sgbuf_init(uap->dmarx.chan, &uap->dmarx.sgbuf_b,
+			       DMA_FROM_DEVICE);
+	if (ret) {
+		dev_err(uap->port.dev, "failed to init DMA %s: %d\n",
+			"RX buffer B", ret);
+		pl011_sgbuf_free(uap->dmarx.chan, &uap->dmarx.sgbuf_a,
+				 DMA_FROM_DEVICE);
+		goto skip_rx;
+	}
+
+	uap->using_rx_dma = true;
 
+skip_rx:
 	/* Turn on DMA error (RX/TX will be enabled on demand) */
 	uap->dmacr |= UART011_DMAONERR;
 	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
@@ -539,11 +881,17 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 	if (uap->vendor->dma_threshold)
 		writew(ST_UART011_DMAWM_RX_16 | ST_UART011_DMAWM_TX_16,
 			       uap->port.membase + ST_UART011_DMAWM);
+
+	if (uap->using_rx_dma) {
+		if (pl011_dma_rx_trigger_dma(uap))
+			dev_dbg(uap->port.dev, "could not trigger initial "
+				"RX DMA job, fall back to interrupt mode\n");
+	}
 }
 
 static void pl011_dma_shutdown(struct uart_amba_port *uap)
 {
-	if (!uap->using_dma)
+	if (!(uap->using_tx_dma || uap->using_rx_dma))
 		return;
 
 	/* Disable RX and TX DMA */
@@ -555,19 +903,39 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
 	spin_unlock_irq(&uap->port.lock);
 
-	/* In theory, this should already be done by pl011_dma_flush_buffer */
-	dmaengine_terminate_all(uap->dmatx.chan);
-	if (uap->dmatx.queued) {
-		dma_unmap_sg(uap->dmatx.chan->device->dev, &uap->dmatx.sg, 1,
-			     DMA_TO_DEVICE);
-		uap->dmatx.queued = false;
+	if (uap->using_tx_dma) {
+		/* In theory, this should already be done by pl011_dma_flush_buffer */
+		dmaengine_terminate_all(uap->dmatx.chan);
+		if (uap->dmatx.queued) {
+			dma_unmap_sg(uap->dmatx.chan->device->dev, &uap->dmatx.sg, 1,
+				     DMA_TO_DEVICE);
+			uap->dmatx.queued = false;
+		}
+
+		kfree(uap->dmatx.buf);
+		uap->using_tx_dma = false;
+	}
+
+	if (uap->using_rx_dma) {
+		dmaengine_terminate_all(uap->dmarx.chan);
+		/* Clean up the RX DMA */
+		pl011_sgbuf_free(uap->dmarx.chan, &uap->dmarx.sgbuf_a, DMA_FROM_DEVICE);
+		pl011_sgbuf_free(uap->dmarx.chan, &uap->dmarx.sgbuf_b, DMA_FROM_DEVICE);
+		uap->using_rx_dma = false;
 	}
+}
 
-	kfree(uap->dmatx.buf);
+static inline bool pl011_dma_rx_available(struct uart_amba_port *uap)
+{
+	return uap->using_rx_dma;
+}
 
-	uap->using_dma = false;
+static inline bool pl011_dma_rx_running(struct uart_amba_port *uap)
+{
+	return uap->using_rx_dma && uap->dmarx.running;
 }
 
+
 #else
 /* Blank functions if the DMA engine is not available */
 static inline void pl011_dma_probe(struct uart_amba_port *uap)
@@ -600,6 +968,29 @@ static inline bool pl011_dma_tx_start(struct uart_amba_port *uap)
 	return false;
 }
 
+static inline void pl011_dma_rx_irq(struct uart_amba_port *uap)
+{
+}
+
+static inline void pl011_dma_rx_stop(struct uart_amba_port *uap)
+{
+}
+
+static inline int pl011_dma_rx_trigger_dma(struct uart_amba_port *uap)
+{
+	return -EIO;
+}
+
+static inline bool pl011_dma_rx_available(struct uart_amba_port *uap)
+{
+	return false;
+}
+
+static inline bool pl011_dma_rx_running(struct uart_amba_port *uap)
+{
+	return false;
+}
+
 #define pl011_dma_flush_buffer	NULL
 #endif
 
@@ -630,6 +1021,8 @@ static void pl011_stop_rx(struct uart_port *port)
 	uap->im &= ~(UART011_RXIM|UART011_RTIM|UART011_FEIM|
 		     UART011_PEIM|UART011_BEIM|UART011_OEIM);
 	writew(uap->im, uap->port.membase + UART011_IMSC);
+
+	pl011_dma_rx_stop(uap);
 }
 
 static void pl011_enable_ms(struct uart_port *port)
@@ -688,6 +1081,19 @@ static void pl011_rx_chars(struct uart_amba_port *uap)
 	}
 	spin_unlock(&uap->port.lock);
 	tty_flip_buffer_push(tty);
+	/*
+	 * If we were temporarily out of DMA mode for a while,
+	 * attempt to switch back to DMA mode again.
+	 */
+	if (pl011_dma_rx_available(uap)) {
+		if (pl011_dma_rx_trigger_dma(uap)) {
+			dev_dbg(uap->port.dev, "could not trigger RX DMA job "
+				"fall back to interrupt mode again\n");
+			uap->im |= UART011_RXIM;
+		} else
+			uap->im &= ~UART011_RXIM;
+		writew(uap->im, uap->port.membase + UART011_IMSC);
+	}
 	spin_lock(&uap->port.lock);
 }
 
@@ -767,8 +1173,12 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 					  UART011_RXIS),
 			       uap->port.membase + UART011_ICR);
 
-			if (status & (UART011_RTIS|UART011_RXIS))
-				pl011_rx_chars(uap);
+			if (status & (UART011_RTIS|UART011_RXIS)) {
+				if (pl011_dma_rx_running(uap))
+					pl011_dma_rx_irq(uap);
+				else
+					pl011_rx_chars(uap);
+			}
 			if (status & (UART011_DSRMIS|UART011_DCDMIS|
 				      UART011_CTSMIS|UART011_RIMIS))
 				pl011_modem_status(uap);
@@ -945,10 +1355,14 @@ static int pl011_startup(struct uart_port *port)
 	pl011_dma_startup(uap);
 
 	/*
-	 * Finally, enable interrupts
+	 * Finally, enable interrupts, only timeouts when using DMA
+	 * if initial RX DMA job failed, start in interrupt mode
+	 * as well.
 	 */
 	spin_lock_irq(&uap->port.lock);
-	uap->im = UART011_RXIM | UART011_RTIM;
+	uap->im = UART011_RTIM;
+	if (!pl011_dma_rx_running(uap))
+		uap->im |= UART011_RXIM;
 	writew(uap->im, uap->port.membase + UART011_IMSC);
 	spin_unlock_irq(&uap->port.lock);
 
-- 
1.7.3.2
