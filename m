From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Feb 2011 10:17:30 +0000
Subject: [PATCH] pl011: add optional RX DMA to PL011
In-Reply-To: <1297677085-13097-1-git-send-email-linus.walleij@linaro.org>
References: <1297677085-13097-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20110214101730.GB19375@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 14, 2011 at 10:51:25AM +0100, Linus Walleij wrote:
> This adds an optional RX DMA codepath for the devices that
> support this by using the apropriate burst sizes instead of
> pulling single bytes.

This is where I got to with this - it needs updating with the various
dma engine improvements.

 drivers/serial/amba-pl011.c |  387 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 383 insertions(+), 4 deletions(-)

diff --git a/drivers/serial/amba-pl011.c b/drivers/serial/amba-pl011.c
index 4ca37de..3b9c1e6 100644
--- a/drivers/serial/amba-pl011.c
+++ b/drivers/serial/amba-pl011.c
@@ -95,7 +95,21 @@ static struct vendor_data vendor_st = {
 	.dma_threshold		= true,
 };
 
+struct pl011_sgbuf {
+	struct scatterlist sg;
+	char *buf;
+};
+
 /* Deals with DMA transactions */
+struct pl011_dmarx_data {
+	struct dma_chan 	*chan;
+	struct completion complete;
+	bool use_buffer_b;
+	struct pl011_sgbuf sgbuf_a;
+	struct pl011_sgbuf sgbuf_b;
+	dma_cookie_t cookie;
+};
+
 struct pl011_dmatx_data {
 	struct dma_chan		*chan;
 	struct scatterlist	sg;
@@ -118,9 +132,11 @@ struct uart_amba_port {
 	unsigned int		lcrh_rx;	/* vendor-specific */
 	bool			autorts;
 	char			type[12];
+	bool			rx_dma_running;
 #ifdef CONFIG_DMA_ENGINE
 	/* DMA stuff */
 	bool			using_dma;
+	struct pl011_dmarx_data	dmarx;
 	struct pl011_dmatx_data	dmatx;
 #endif
 };
@@ -134,10 +150,41 @@ struct uart_amba_port {
 
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
 	struct amba_pl011_data *plat = uap->port.dev->platform_data;
+	struct dma_slave_config rx_conf = {
+		.src_addr = uap->port.mapbase + UART01x_DR,
+		.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE,
+		.direction = DMA_FROM_DEVICE,
+		.src_maxburst = uap->fifosize >> 1,
+	};
 	struct dma_slave_config tx_conf = {
 		.dst_addr = uap->port.mapbase + UART01x_DR,
 		.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE,
@@ -166,6 +213,15 @@ static void pl011_dma_probe_initcall(struct uart_amba_port *uap)
 	dmaengine_slave_config(chan, &tx_conf);
 	uap->dmatx.chan = chan;
 
+	chan = dma_request_channel(mask, plat->dma_filter, plat->dma_rx_param);
+	if (!chan) {
+		dev_err(uap->port.dev, "no RX DMA channel!\n");
+		/* FIX */
+		return;
+	}
+	dmaengine_slave_config(chan, &rx_conf);
+	uap->dmarx.chan = chan;		  
+	
 	dev_info(uap->port.dev, "DMA channel TX %s\n",
 		 dma_chan_name(uap->dmatx.chan));
 }
@@ -219,6 +275,8 @@ static void pl011_dma_remove(struct uart_amba_port *uap)
 	/* TODO: remove the initcall if it has not yet executed */
 	if (uap->dmatx.chan)
 		dma_release_channel(uap->dmatx.chan);
+	if (uap->dmarx.chan)
+		dma_release_channel(uap->dmarx.chan);
 }
 
 
@@ -509,8 +567,258 @@ static void pl011_dma_flush_buffer(struct uart_port *port)
 }
 
 
+static void pl011_dma_rx_callback(void *data);
+
+static int pl011_dma_rx_trigger_dma(struct uart_amba_port *uap)
+{
+	struct dma_chan *rxchan = uap->dmarx.chan;
+	struct dma_device *dma_dev;
+	struct dma_async_tx_descriptor *desc;
+	struct pl011_sgbuf *sgbuf;
+
+	if (!rxchan)
+		return -EIO;
+
+	/* Start the RX DMA job */
+	sgbuf = uap->dmarx.use_buffer_b ?
+		&uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
+	dma_dev = rxchan->device;
+	desc = dma_dev->device_prep_slave_sg(rxchan, &sgbuf->sg, 1,
+					     DMA_FROM_DEVICE,
+					     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	/*
+	 * If the DMA engine is busy and cannot prepare a
+	 * channel, no big deal, the driver will fall back
+	 * to interrupt mode as a result of this error code.
+	 */
+	if (!desc) {
+		uap->rx_dma_running = false;
+		dmaengine_terminate_all(rxchan);
+		return -EBUSY;
+	}
+
+	/* Some data to go along to the callback */
+	desc->callback = pl011_dma_rx_callback;
+	desc->callback_param = uap;
+	/* This is another point where an overloaded engine can fail */
+	uap->dmarx.cookie = dmaengine_submit(desc);
+	if (dma_submit_error(uap->dmarx.cookie)) {
+		uap->rx_dma_running = false;
+		dmaengine_terminate_all(rxchan);
+		return -EBUSY;
+	}
+
+	dma_dev->device_issue_pending(rxchan);
+
+	uap->dmacr |= UART011_RXDMAE;
+	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
+	uap->rx_dma_running = true;
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
+			       size_t pending, bool use_buffer_b,
+			       bool readfifo)
+{
+	struct tty_struct *tty = uap->port.state->port.tty;
+	struct pl011_sgbuf *sgbuf = use_buffer_b ?
+			&uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
+	struct device *dev = uap->dmarx.chan->device->dev;
+	unsigned int status, ch, flag;
+	int dma_count;
+	int fifotaken = 0; /* only used for vdbg() */
+
+	/* Sync in buffer */
+	dma_sync_sg_for_cpu(dev, &sgbuf->sg, 1, DMA_FROM_DEVICE);
+
+	/*
+	 * First take all chars in the DMA pipe, then look in the FIFO. Note
+	 * that tty_insert_flip_buf() tries to take as many chars as it can.
+	 */
+	dma_count = tty_insert_flip_string(uap->port.state->port.tty,
+					   sgbuf->buf, pending);
+
+	/* Return buffer to device */
+	dma_sync_sg_for_device(dev, &sgbuf->sg, 1, DMA_FROM_DEVICE);
+
+	uap->port.icount.rx += dma_count;
+	if (dma_count < pending) {
+		/*
+		 * Couldn't insert all characters (eg, TTY is full).
+		 */
+	}
+
+	if (dma_count == pending && readfifo) {
+		writew(UART011_OEIS | UART011_BEIS | UART011_PEIS | UART011_FEIS,
+		       uap->port.membase + UART011_ICR);
+
+		/*
+		 * If we read all the DMA'd characters, and we had an
+		 * incomplete buffer, that could be due to an rx error,
+		 * or maybe we just timed out.	Read any pending chars
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
+			if (!uart_handle_sysrq_char(&uap->port, ch & 255))
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
+	struct dma_chan *rxchan = uap->dmarx.chan;
+	struct pl011_sgbuf *sgbuf = uap->dmarx.use_buffer_b ?
+		&uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
+	size_t pending;
+	int ret;
+	struct dma_tx_state state;
+	enum dma_status dmastat;
+
+	/* Use PrimeCell DMA extensions to stop the transfer */
+	ret = dmaengine_pause(rxchan);
+	if (ret)
+		dev_err(uap->port.dev, "unable to pause DMA transfer\n");
+	dmastat = rxchan->device->device_tx_status(rxchan,
+						   uap->dmarx.cookie, &state);
+
+	/* Disable RX DMA temporarily */
+	uap->dmacr &= ~UART011_RXDMAE;
+	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
+	uap->rx_dma_running = false;
+
+	if (dmastat != DMA_PAUSED)
+		dev_err(uap->port.dev, "unable to pause DMA transfer\n");
+	pending = sgbuf->sg.length - state.residue;
+
+	BUG_ON(pending > PL011_DMA_BUFFER_SIZE);
+
+	ret = dmaengine_terminate_all(rxchan);
+	if (ret)
+		dev_err(uap->port.dev, "unable to terminate DMA transfer\n");
+
+	/*
+	 * This will take the chars we have so far and insert
+	 * into the framework.
+	 */
+	pl011_dma_rx_chars(uap, pending, uap->dmarx.use_buffer_b, true);
+
+	/* Switch buffer & re-trigger DMA job */
+	uap->dmarx.use_buffer_b = !uap->dmarx.use_buffer_b;
+	ret = pl011_dma_rx_trigger_dma(uap);
+	if (ret) {
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
+	bool lastbuf;
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
+	uap->rx_dma_running = false;
+	lastbuf = uap->dmarx.use_buffer_b;
+	uap->dmarx.use_buffer_b = !lastbuf;
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
+
+
 static void pl011_dma_startup(struct uart_amba_port *uap)
 {
+	int ret;
+
 	if (!uap->dmatx.chan)
 		return;
 
@@ -523,6 +831,29 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 
 	sg_init_one(&uap->dmatx.sg, uap->dmatx.buf, PL011_DMA_BUFFER_SIZE);
 
+	/* Allocate and map DMA RX and TX buffers */
+	ret = pl011_sgbuf_init(uap->dmarx.chan, &uap->dmarx.sgbuf_a,
+			       DMA_FROM_DEVICE);
+	if (ret) {
+		dev_err(uap->port.dev, "failed to init DMA %s: %d\n",
+			"RX buffer A", ret);
+		kfree(uap->dmatx.buf);
+		uap->port.fifosize = uap->fifosize;
+		return;
+	}
+
+	ret = pl011_sgbuf_init(uap->dmarx.chan, &uap->dmarx.sgbuf_b,
+			       DMA_FROM_DEVICE);
+	if (ret) {
+		dev_err(uap->port.dev, "failed to init DMA %s: %d\n",
+			"RX buffer B", ret);
+		pl011_sgbuf_free(uap->dmarx.chan, &uap->dmarx.sgbuf_a,
+				 DMA_FROM_DEVICE);
+		kfree(uap->dmatx.buf);
+		uap->port.fifosize = uap->fifosize;
+		return;
+	}
+
 	/* The DMA buffer is now the FIFO the TTY subsystem can use */
 	uap->port.fifosize = PL011_DMA_BUFFER_SIZE;
 	uap->using_dma = true;
@@ -539,6 +870,11 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 	if (uap->vendor->dma_threshold)
 		writew(ST_UART011_DMAWM_RX_16 | ST_UART011_DMAWM_TX_16,
 			       uap->port.membase + ST_UART011_DMAWM);
+
+	ret = pl011_dma_rx_trigger_dma(uap);
+	if (ret)
+		dev_dbg(uap->port.dev, "could not trigger initial "
+			"RX DMA job, fall back to interrupt mode\n");
 }
 
 static void pl011_dma_shutdown(struct uart_amba_port *uap)
@@ -555,6 +891,8 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
 	spin_unlock_irq(&uap->port.lock);
 
+	dmaengine_terminate_all(uap->dmarx.chan);
+
 	/* In theory, this should already be done by pl011_dma_flush_buffer */
 	dmaengine_terminate_all(uap->dmatx.chan);
 	if (uap->dmatx.queued) {
@@ -565,6 +903,10 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 
 	kfree(uap->dmatx.buf);
 
+	/* Clean up the RX DMA */
+	pl011_sgbuf_free(uap->dmarx.chan, &uap->dmarx.sgbuf_a, DMA_FROM_DEVICE);
+	pl011_sgbuf_free(uap->dmarx.chan, &uap->dmarx.sgbuf_b, DMA_FROM_DEVICE);
+
 	uap->using_dma = false;
 }
 
@@ -586,6 +928,19 @@ static inline void pl011_dma_shutdown(struct uart_amba_port *uap)
 {
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
 static inline bool pl011_dma_tx_irq(struct uart_amba_port *uap)
 {
 	return false;
@@ -630,6 +985,8 @@ static void pl011_stop_rx(struct uart_port *port)
 	uap->im &= ~(UART011_RXIM|UART011_RTIM|UART011_FEIM|
 		     UART011_PEIM|UART011_BEIM|UART011_OEIM);
 	writew(uap->im, uap->port.membase + UART011_IMSC);
+
+	pl011_dma_rx_stop(uap);
 }
 
 static void pl011_enable_ms(struct uart_port *port)
@@ -644,6 +1001,7 @@ static void pl011_rx_chars(struct uart_amba_port *uap)
 {
 	struct tty_struct *tty = uap->port.state->port.tty;
 	unsigned int status, ch, flag, max_count = 256;
+	int ret;
 
 	status = readw(uap->port.membase + UART01x_FR);
 	while ((status & UART01x_FR_RXFE) == 0 && max_count--) {
@@ -689,6 +1047,20 @@ static void pl011_rx_chars(struct uart_amba_port *uap)
 	spin_unlock(&uap->port.lock);
 	tty_flip_buffer_push(tty);
 	spin_lock(&uap->port.lock);
+	/*
+	 * If we were temporarily out of DMA mode for a while,
+	 * attempt to switch back to DMA mode again.
+	 */
+	if (uap->using_dma) {
+		ret = pl011_dma_rx_trigger_dma(uap);
+		if (ret) {
+			dev_dbg(uap->port.dev, "could not trigger RX DMA job "
+				"fall back to interrupt mode again\n");
+		} else {
+			uap->im &= ~UART011_RXIM;
+			writew(uap->im, uap->port.membase + UART011_IMSC);
+		}
+	}
 }
 
 static void pl011_tx_chars(struct uart_amba_port *uap)
@@ -767,8 +1139,12 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 					  UART011_RXIS),
 			       uap->port.membase + UART011_ICR);
 
-			if (status & (UART011_RTIS|UART011_RXIS))
-				pl011_rx_chars(uap);
+			if (status & (UART011_RTIS|UART011_RXIS)) {
+				if (uap->rx_dma_running)
+					pl011_dma_rx_irq(uap);
+				else
+					pl011_rx_chars(uap);
+			}
 			if (status & (UART011_DSRMIS|UART011_DCDMIS|
 				      UART011_CTSMIS|UART011_RIMIS))
 				pl011_modem_status(uap);
@@ -945,10 +1321,13 @@ static int pl011_startup(struct uart_port *port)
 	pl011_dma_startup(uap);
 
 	/*
-	 * Finally, enable interrupts
+	 * Finally, enable interrupts, only timeouts when using DMA if
+	 * initial RX DMA job failed, start in interrupt mode as well.
 	 */
 	spin_lock_irq(&uap->port.lock);
-	uap->im = UART011_RXIM | UART011_RTIM;
+	uap->im = UART011_RTIM;
+	if (!uap->rx_dma_running)
+		uap->im |= UART011_RXIM;
 	writew(uap->im, uap->port.membase + UART011_IMSC);
 	spin_unlock_irq(&uap->port.lock);
 
