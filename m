From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 14 Feb 2011 10:51:25 +0100
Subject: [PATCH] pl011: add optional RX DMA to PL011
Message-ID: <1297677085-13097-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds an optional RX DMA codepath for the devices that
support this by using the apropriate burst sizes instead of
pulling single bytes.

This has been tested on U300 and Ux500.

Tested-by: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Tested-by: Grzegorz Sygieda <grzegorz.sygieda@tieto.com>
Tested-by: Marcin Mielczarczyk <marcin.mielczarczyk@tieto.com>
Signed-off-by: Per Forlin <per.friden@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/serial/amba-pl011.c |  421 +++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 401 insertions(+), 20 deletions(-)

diff --git a/drivers/serial/amba-pl011.c b/drivers/serial/amba-pl011.c
index e76d7d0..e450d06 100644
--- a/drivers/serial/amba-pl011.c
+++ b/drivers/serial/amba-pl011.c
@@ -52,6 +52,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/scatterlist.h>
+#include <linux/completion.h>
 
 #include <asm/io.h>
 #include <asm/sizes.h>
@@ -103,6 +104,18 @@ struct pl011_dmatx_data {
 	bool			queued;
 };
 
+struct pl011_dmarx_data {
+	struct dma_chan		*chan;
+	struct completion	complete;
+	bool			use_buf_b;
+	struct scatterlist	sg_a;
+	struct scatterlist	sg_b;
+	char			*buf_a;
+	char			*buf_b;
+	dma_cookie_t		cookie;
+	bool			running;
+};
+
 /*
  * We wrap our port structure around the generic uart_port.
  */
@@ -120,8 +133,10 @@ struct uart_amba_port {
 	char			type[12];
 #ifdef CONFIG_DMA_ENGINE
 	/* DMA stuff */
-	bool			using_dma;
+	bool			using_tx_dma;
+	bool			using_rx_dma;
 	struct pl011_dmatx_data	dmatx;
+	struct pl011_dmarx_data dmarx;
 #endif
 };
 
@@ -153,7 +168,7 @@ static void pl011_dma_probe_initcall(struct uart_amba_port *uap)
 		return;
 	}
 
-	/* Try to acquire a generic DMA engine slave channel */
+	/* Try to acquire a generic DMA engine slave TX channel */
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
@@ -168,6 +183,28 @@ static void pl011_dma_probe_initcall(struct uart_amba_port *uap)
 
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
@@ -219,9 +256,10 @@ static void pl011_dma_remove(struct uart_amba_port *uap)
 	/* TODO: remove the initcall if it has not yet executed */
 	if (uap->dmatx.chan)
 		dma_release_channel(uap->dmatx.chan);
+	if (uap->dmarx.chan)
+		dma_release_channel(uap->dmarx.chan);
 }
 
-
 /* Forward declare this for the refill routine */
 static int pl011_dma_tx_refill(struct uart_amba_port *uap);
 
@@ -380,7 +418,7 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
  */
 static bool pl011_dma_tx_irq(struct uart_amba_port *uap)
 {
-	if (!uap->using_dma)
+	if (!uap->using_tx_dma)
 		return false;
 
 	/*
@@ -432,7 +470,7 @@ static inline bool pl011_dma_tx_start(struct uart_amba_port *uap)
 {
 	u16 dmacr;
 
-	if (!uap->using_dma)
+	if (!uap->using_tx_dma)
 		return false;
 
 	if (!uap->port.x_char) {
@@ -492,7 +530,7 @@ static void pl011_dma_flush_buffer(struct uart_port *port)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
 
-	if (!uap->using_dma)
+	if (!uap->using_tx_dma)
 		return;
 
 	/* Avoid deadlock with the DMA engine callback */
@@ -508,6 +546,236 @@ static void pl011_dma_flush_buffer(struct uart_port *port)
 	}
 }
 
+static void pl011_dma_rx_callback(void *data);
+
+static int pl011_dma_rx_trigger_dma(struct uart_amba_port *uap)
+{
+	struct dma_chan *rxchan = uap->dmarx.chan;
+	struct pl011_dmarx_data *dmarx = &uap->dmarx;
+	struct dma_async_tx_descriptor *desc;
+	struct scatterlist *scatter = dmarx->use_buf_b ?
+		&dmarx->sg_b : &dmarx->sg_a;
+
+	/* Start the RX DMA job */
+	desc = rxchan->device->device_prep_slave_sg(rxchan,
+						    scatter,
+						    1,
+						    DMA_FROM_DEVICE,
+						    DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
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
+	struct pl011_dmarx_data *dmarx = &uap->dmarx;
+	struct tty_struct *tty = uap->port.state->port.tty;
+	char *buf = use_buf_b ? dmarx->buf_b : dmarx->buf_a;
+	struct scatterlist *scatter = use_buf_b ?
+		&dmarx->sg_b : &dmarx->sg_a;
+	unsigned int status, ch, flag;
+	u32 count = pending;
+	u32 bufp = 0;
+	u32 fifotaken = 0; /* only used for vdbg() */
+
+	/* Sync in buffer */
+	dma_sync_sg_for_cpu(uap->port.dev,
+			    scatter,
+			    1,
+			    DMA_FROM_DEVICE);
+
+	status = readw(uap->port.membase + UART01x_FR);
+
+	/*
+	 * First take all chars in the DMA pipe, then look
+	 * in the FIFO. So loop while we have chars in the
+	 * DMA buffer or the FIFO. If we came here from a
+	 * DMA buffer full interrupt, there is already another
+	 * DMA job triggered to read the FIFO, so don't look
+	 * at it.
+	 */
+	while (count ||
+	       (readfifo && (status & UART01x_FR_RXFE) == 0)) {
+
+		flag = TTY_NORMAL;
+		uap->port.icount.rx++;
+
+		if (count) {
+			/* Take chars from the DMA buffer */
+			int inserted = tty_insert_flip_string(
+					uap->port.state->port.tty, buf, count);
+
+			/*
+			 * Check if insertion is successful to avoid
+			 * infinite loop. This can happen when TTY is full.
+			 */
+			if (unlikely(inserted == 0))
+				count = 0;
+			else {
+				count -= inserted;
+				bufp += inserted;
+			}
+			continue;
+		} else {
+			/* Take chars from the FIFO and update status */
+			ch = readw(uap->port.membase + UART01x_DR);
+			status = readw(uap->port.membase + UART01x_FR);
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
+		}
+
+		if (uart_handle_sysrq_char(&uap->port, ch & 255))
+			continue;
+
+		uart_insert_char(&uap->port, ch, UART011_DR_OE, ch, flag);
+	}
+
+	spin_unlock(&uap->port.lock);
+	dev_vdbg(uap->port.dev,
+		 "Took %d chars from DMA buffer and %d chars from the FIFO\n",
+		 bufp, fifotaken);
+	tty_flip_buffer_push(tty);
+	spin_lock(&uap->port.lock);
+}
+
+static void pl011_dma_rx_irq(struct uart_amba_port *uap)
+{
+	struct dma_chan *rxchan = uap->dmarx.chan;
+	struct pl011_dmarx_data *dmarx = &uap->dmarx;
+	struct scatterlist *scatter = dmarx->use_buf_b ?
+		&dmarx->sg_b : &dmarx->sg_a;
+	u32 pending;
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
+	pending = scatter->length - state.residue;
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
+	uap->dmarx.running = false;
+	dmarx->use_buf_b = !lastbuf;
+	ret = pl011_dma_rx_trigger_dma(uap);
+
+	spin_lock_irq(&uap->port.lock);
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
 
 static void pl011_dma_startup(struct uart_amba_port *uap)
 {
@@ -525,8 +793,51 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 
 	/* The DMA buffer is now the FIFO the TTY subsystem can use */
 	uap->port.fifosize = PL011_DMA_BUFFER_SIZE;
-	uap->using_dma = true;
+	uap->using_tx_dma = true;
+
+	if (!uap->dmarx.chan)
+		goto skip_rx;
+
+	/* Allocate DMA RX buffers */
+	uap->dmarx.buf_a = kmalloc(PL011_DMA_BUFFER_SIZE, GFP_KERNEL);
+	if (!uap->dmarx.buf_a) {
+		dev_err(uap->port.dev, "failed to allocate DMA RX buffer A\n");
+		goto skip_rx;
+	}
+
+	uap->dmarx.buf_b = kmalloc(PL011_DMA_BUFFER_SIZE, GFP_KERNEL);
+	if (!uap->dmarx.buf_b) {
+		dev_err(uap->port.dev, "failed to allocate DMA RX buffer B\n");
+		kfree(uap->dmarx.buf_a);
+		goto skip_rx;
+	}
+
+	/* Provide single SG list with one item to the buffers */
+	sg_init_one(&uap->dmarx.sg_a, uap->dmarx.buf_a,
+		    PL011_DMA_BUFFER_SIZE);
+	sg_init_one(&uap->dmarx.sg_b, uap->dmarx.buf_b,
+		    PL011_DMA_BUFFER_SIZE);
+
+	/* Map RX DMA buffers */
+	if (dma_map_sg(uap->dmarx.chan->device->dev,
+		       &uap->dmarx.sg_a,
+		       1, DMA_FROM_DEVICE) != 1) {
+		kfree(uap->dmarx.buf_a);
+		kfree(uap->dmarx.buf_b);
+		goto skip_rx;
+	}
+
+	if (dma_map_sg(uap->dmarx.chan->device->dev,
+		       &uap->dmarx.sg_b,
+		       1, DMA_FROM_DEVICE) != 1) {
+		kfree(uap->dmarx.buf_a);
+		kfree(uap->dmarx.buf_b);
+		goto skip_rx;
+	}
+
+	uap->using_rx_dma = true;
 
+skip_rx:
 	/* Turn on DMA error (RX/TX will be enabled on demand) */
 	uap->dmacr |= UART011_DMAONERR;
 	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
@@ -539,11 +850,17 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
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
@@ -555,19 +872,45 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
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
+
+		dma_unmap_sg(uap->dmarx.chan->device->dev,
+			     &uap->dmarx.sg_b,
+			     1, DMA_FROM_DEVICE);
+		kfree(uap->dmarx.buf_b);
+		dma_unmap_sg(uap->dmarx.chan->device->dev,
+			     &uap->dmarx.sg_a, 1,
+			     DMA_FROM_DEVICE);
+		kfree(uap->dmarx.buf_a);
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
@@ -600,6 +943,25 @@ static inline bool pl011_dma_tx_start(struct uart_amba_port *uap)
 	return false;
 }
 
+static inline void pl011_dma_rx_irq(struct uart_amba_port *uap)
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
 
@@ -688,6 +1050,16 @@ static void pl011_rx_chars(struct uart_amba_port *uap)
 	}
 	spin_unlock(&uap->port.lock);
 	tty_flip_buffer_push(tty);
+	/*
+	 * If we were temporarily out of DMA mode for a while,
+	 * attempt to switch back to DMA mode again.
+	 */
+	if (pl011_dma_rx_available(uap) && pl011_dma_rx_trigger_dma(uap)) {
+		dev_dbg(uap->port.dev, "could not trigger RX DMA job "
+			"fall back to interrupt mode again\n");
+		uap->im |= UART011_RXIM;
+		writew(uap->im, uap->port.membase + UART011_IMSC);
+	}
 	spin_lock(&uap->port.lock);
 }
 
@@ -767,8 +1139,12 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
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
@@ -945,10 +1321,15 @@ static int pl011_startup(struct uart_port *port)
 	pl011_dma_startup(uap);
 
 	/*
-	 * Finally, enable interrupts
+	 * Finally, enable interrupts, only timeouts when using DMA
+	 * if initial RX DMA job failed, start in interrupt mode
+	 * as well.
 	 */
 	spin_lock_irq(&uap->port.lock);
-	uap->im = UART011_RXIM | UART011_RTIM;
+	if (pl011_dma_rx_running(uap))
+		uap->im = UART011_RTIM;
+	else
+		uap->im = UART011_RXIM | UART011_RTIM;
 	writew(uap->im, uap->port.membase + UART011_IMSC);
 	spin_unlock_irq(&uap->port.lock);
 
-- 
1.7.3.2
