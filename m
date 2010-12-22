From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Dec 2010 23:10:09 +0000
Subject: [PATCH 5/6] ARM: PL011: Add support for transmit DMA
Message-ID: <E1PVXov-0007IM-Ea@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DMA engine support for transmit to the PL011 driver.  Based on a
patch from Linus Walliej, with the following changes:

- remove RX DMA support.  As PL011 doesn't give us receive timeout
  interrupts, we only get notified of received data when the RX DMA
  has completed.  This rather sucks for interactive use of the TTY.

- remove abuse of completions.  Completions are supposed to be for
  events, not to tell what condition buffers are in.  Replace it with
  a simple 'queued' bool.

- fix locking - it is only save to access the circular buffer with the
  port lock held.

- only map the DMA buffer when required - if we're ever behind an
  IOMMU, this helps keep IOMMU usage down, and also ensures that we're
  legal when we change the scatterlist entry length.

- fix XON/XOFF sending - we must send XON/XOFF characters out as soon
  as possible - waiting for up to 4095 characters in the DMA buffer
  to be sent first is not acceptable.

- fix XON/XOFF receive handling - we need to stop DMA when instructed
  to by the TTY layer, and restart it again when instructed to.  There
  is a subtle problem here: we must not completely empty the circular
  buffer with DMA, otherwise we will not be notified of XON.

- change the 'enable_dma' flag into a 'using DMA' flag, and track
  whether we can use TX DMA by whether the channel pointer is non-NULL.
  This gives us more control over whether we use DMA in the driver.

- we don't need to have the TX DMA buffer continually allocated for
  each port - instead, allocate it when the port starts up, and free
  it when it's shut down.  Update the 'using DMA' flag if we get
  the buffer, and adjust the TTY FIFO size appropriately.

- if we're going to use PIO to send characters, use the existing IRQ
  based functionality rather than reimplementing it.  This also ensures
  we call uart_write_wakeup() at the appropriate time, otherwise we'll
  stall.

- use DMA engine helper functions for type safety.

- fix init when built as a module - we can't have to initcall functions,
  so we must settle on one.  This means we can eliminate the deferred
  DMA initialization.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/serial/amba-pl011.c |  509 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/amba/serial.h |    6 +
 2 files changed, 513 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/amba-pl011.c b/drivers/serial/amba-pl011.c
index ab0ab45..37b4cb8 100644
--- a/drivers/serial/amba-pl011.c
+++ b/drivers/serial/amba-pl011.c
@@ -7,6 +7,7 @@
  *
  *  Copyright 1999 ARM Limited
  *  Copyright (C) 2000 Deep Blue Solutions Ltd.
+ *  Copyright (C) 2010 ST-Ericsson SA
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -48,6 +49,9 @@
 #include <linux/amba/serial.h>
 #include <linux/clk.h>
 #include <linux/slab.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/scatterlist.h>
 
 #include <asm/io.h>
 #include <asm/sizes.h>
@@ -88,6 +92,14 @@ static struct vendor_data vendor_st = {
 	.oversampling		= true,
 };
 
+/* Deals with DMA transactions */
+struct pl011_dmatx_data {
+	struct dma_chan		*chan;
+	struct scatterlist	sg;
+	char			*buf;
+	bool			queued;
+};
+
 /*
  * We wrap our port structure around the generic uart_port.
  */
@@ -95,28 +107,508 @@ struct uart_amba_port {
 	struct uart_port	port;
 	struct clk		*clk;
 	const struct vendor_data *vendor;
+	unsigned int		dmacr;		/* dma control reg */
 	unsigned int		im;		/* interrupt mask */
 	unsigned int		old_status;
 	unsigned int		fifosize;	/* vendor-specific */
 	unsigned int		lcrh_tx;	/* vendor-specific */
 	unsigned int		lcrh_rx;	/* vendor-specific */
 	bool			autorts;
+#ifdef CONFIG_DMA_ENGINE
+	/* DMA stuff */
+	bool			using_dma;
+	struct pl011_dmatx_data	dmatx;
+#endif
 };
 
+/*
+ * All the DMA operation mode stuff goes inside this ifdef.
+ * This assumes that you have a generic DMA device interface,
+ * no custom DMA interfaces are supported.
+ */
+#ifdef CONFIG_DMA_ENGINE
+
+#define PL011_DMA_BUFFER_SIZE PAGE_SIZE
+
+static void pl011_dma_probe_initcall(struct uart_amba_port *uap)
+{
+	/* DMA is the sole user of the platform data right now */
+	struct amba_pl011_data *plat = uap->port.dev->platform_data;
+	struct dma_slave_config tx_conf = {
+		.dst_addr = uap->port.mapbase + UART01x_DR,
+		.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE,
+		.direction = DMA_TO_DEVICE,
+		.dst_maxburst = uap->fifosize >> 1,
+	};
+	struct dma_chan *chan;
+	dma_cap_mask_t mask;
+
+	/* We need platform data */
+	if (!plat || !plat->dma_filter) {
+		dev_info(uap->port.dev, "no DMA platform data\n");
+		return;
+	}
+
+	/* Try to acquire a generic DMA engine slave channel */
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	chan = dma_request_channel(mask, plat->dma_filter, plat->dma_tx_param);
+	if (!chan) {
+		dev_err(uap->port.dev, "no TX DMA channel!\n");
+		return;
+	}
+
+	dmaengine_slave_config(chan, &tx_conf);
+	uap->dmatx.chan = chan;
+
+	dev_info(uap->port.dev, "DMA channel TX %s\n",
+		 dma_chan_name(uap->dmatx.chan));
+}
+
+#ifndef MODULE
+/*
+ * Stack up the UARTs and let the above initcall be done at device
+ * initcall time, because the serial driver is called as an arch
+ * initcall, and at this time the DMA subsystem is not yet registered.
+ * At this point the driver will switch over to using DMA where desired.
+ */
+struct dma_uap {
+	struct list_head node;
+	struct uart_amba_port *uap;
+};
+
+static LIST_HEAD(pl011_dma_uarts);
+
+static int __init pl011_dma_initcall(void)
+{
+	struct list_head *node, *tmp;
+
+	list_for_each_safe(node, tmp, &pl011_dma_uarts) {
+		struct dma_uap *dmau = list_entry(node, struct dma_uap, node);
+		pl011_dma_probe_initcall(dmau->uap);
+		list_del(node);
+		kfree(dmau);
+	}
+	return 0;
+}
+
+device_initcall(pl011_dma_initcall);
+
+static void pl011_dma_probe(struct uart_amba_port *uap)
+{
+	struct dma_uap *dmau = kzalloc(sizeof(struct dma_uap), GFP_KERNEL);
+	if (dmau) {
+		dmau->uap = uap;
+		list_add_tail(&dmau->node, &pl011_dma_uarts);
+	}
+}
+#else
+static void pl011_dma_probe(struct uart_amba_port *uap)
+{
+	pl011_dma_probe_initcall(uap);
+}
+#endif
+
+static void pl011_dma_remove(struct uart_amba_port *uap)
+{
+	/* TODO: remove the initcall if it has not yet executed */
+	if (uap->dmatx.chan)
+		dma_release_channel(uap->dmatx.chan);
+}
+
+
+/* Forward declare this for the refill routine */
+static int pl011_dma_tx_refill(struct uart_amba_port *uap);
+
+/*
+ * The current DMA TX buffer has been sent.
+ * Try to queue up another DMA buffer.
+ */
+static void pl011_dma_tx_callback(void *data)
+{
+	struct uart_amba_port *uap = data;
+	struct pl011_dmatx_data *dmatx = &uap->dmatx;
+	unsigned long flags;
+	u16 dmacr;
+
+	/* FIXME: if only the pl08x did this for us... */
+	dma_unmap_sg(dmatx->chan->device->dev, &dmatx->sg, 1, DMA_TO_DEVICE);
+
+	spin_lock_irqsave(&uap->port.lock, flags);
+	dmacr = uap->dmacr;
+	uap->dmacr = dmacr & ~UART011_TXDMAE;
+	writew_relaxed(uap->dmacr, uap->port.membase + UART011_DMACR);
+
+	/*
+	 * If TX DMA was disabled, it means that we've stopped the DMA for
+	 * some reason (eg, XOFF received, or we want to send an X-char.)
+	 *
+	 * Note: we need to be careful here of a potential race between DMA
+	 * and the rest of the driver - if the driver disables TX DMA while
+	 * a TX buffer completing, we must update the tx queued status to
+	 * get further refills (hence we check dmacr).
+	 */
+	if (!(dmacr & UART011_TXDMAE) || uart_tx_stopped(&uap->port) ||
+	    uart_circ_empty(&uap->port.state->xmit)) {
+		uap->dmatx.queued = false;
+		spin_unlock_irqrestore(&uap->port.lock, flags);
+		return;
+	}
+
+	if (pl011_dma_tx_refill(uap) <= 0) {
+		/*
+		 * We didn't queue a DMA buffer for some reason, but we
+		 * have data pending to be sent.  Re-enable the TX IRQ
+		 */
+		uap->im |= UART011_TXIM;
+		writew_relaxed(uap->im, uap->port.membase + UART011_IMSC);
+	}
+	spin_unlock_irqrestore(&uap->port.lock, flags);
+}
+
+/*
+ * Try to refill the TX DMA buffer.
+ * Locking: called with port lock held and IRQs disabled.
+ * Returns:
+ *   1 if we queued up a TX DMA buffer.
+ *   0 if we didn't want to handle this by DMA
+ *  <0 on error
+ */
+static int pl011_dma_tx_refill(struct uart_amba_port *uap)
+{
+	struct pl011_dmatx_data *dmatx = &uap->dmatx;
+	struct dma_chan *chan = dmatx->chan;
+	struct dma_device *dma_dev = chan->device;
+	struct dma_async_tx_descriptor *desc;
+	struct circ_buf *xmit = &uap->port.state->xmit;
+	unsigned int count;
+	dma_addr_t cookie;
+
+	/*
+	 * Try to avoid the overhead involved in using DMA if the
+	 * transaction fits in the first half of the FIFO, by using
+	 * the standard interrupt handling.  This ensures that we
+	 * issue a uart_write_wakeup() at the appropriate time.
+	 */
+	count = uart_circ_chars_pending(xmit);
+	if (count < (uap->fifosize >> 1)) {
+		uap->dmatx.queued = false;
+		return 0;
+	}
+
+	/*
+	 * Bodge: don't send the last character by DMA, as this
+	 * will prevent XON from notifying us to restart DMA.
+	 */
+	count -= 1;
+
+	/* Else proceed to copy the TX chars to the DMA buffer and fire DMA */
+	if (count > PL011_DMA_BUFFER_SIZE)
+		count = PL011_DMA_BUFFER_SIZE;
+
+	if (xmit->tail < xmit->head)
+		memcpy(&dmatx->buf[0], &xmit->buf[xmit->tail], count);
+	else {
+		size_t first = UART_XMIT_SIZE - xmit->tail;
+		size_t second = xmit->head;
+
+		memcpy(&dmatx->buf[0], &xmit->buf[xmit->tail], first);
+		if (second)
+			memcpy(&dmatx->buf[first], &xmit->buf[0], second);
+	}
+
+	dmatx->sg.length = count;
+
+	if (dma_map_sg(dma_dev->dev, &dmatx->sg, 1, DMA_TO_DEVICE) != 1) {
+		uap->dmatx.queued = false;
+		dev_dbg(uap->port.dev, "unable to map TX DMA\n");
+		return -EBUSY;
+	}
+
+	desc = dma_dev->device_prep_slave_sg(chan, &dmatx->sg, 1, DMA_TO_DEVICE,
+					     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc) {
+		dmaengine_terminate_all(chan);
+		uap->dmatx.queued = false;
+		/*
+		 * If DMA cannot be used right now, we complete this
+		 * transaction and let the TTY layer retry. If the
+		 * firs following xfer fails to set up for DMA, it
+		 * will fall through to interrupt mode.
+		 */
+		dev_dbg(uap->port.dev, "TX DMA busy\n");
+		return -EBUSY;
+	}
+
+	/* Some data to go along to the callback */
+	desc->callback = pl011_dma_tx_callback;
+	desc->callback_param = uap;
+
+	/* Here is where overloaded DMA controllers can fail */
+	cookie = dmaengine_submit(desc);
+	if (dma_submit_error(cookie)) {
+		/* "Complete" DMA (errorpath) */
+		dmaengine_terminate_all(chan);
+		uap->dmatx.queued = false;
+		return cookie;
+	}
+
+	/*
+	 * Now we know that DMA will fire, so advance the ring buffer
+	 * with the stuff we just dispatched
+	 */
+	xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
+	uap->port.icount.tx += count;
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(&uap->port);
+
+	/* Fire the DMA transaction */
+	dma_dev->device_issue_pending(chan);
+
+	uap->dmacr |= UART011_TXDMAE;
+	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
+	uap->dmatx.queued = true;
+	return 1;
+}
+
+/*
+ * We received a transmit interrupt without a pending X-char but with
+ * pending characters.
+ * Locking: called with port lock held and IRQs disabled.
+ * Returns:
+ *   false if we want to use PIO to transmit
+ *   true if we queued a DMA buffer
+ */
+static bool pl011_dma_tx_irq(struct uart_amba_port *uap)
+{
+	if (!uap->using_dma)
+		return false;
+
+	/*
+	 * If we already have a TX buffer queued, but received a
+	 * TX interrupt, it will be because we've just sent an X-char.
+	 * Ensure the TX DMA is enabled and the TX IRQ is disabled.
+	 */
+	if (uap->dmatx.queued) {
+		uap->dmacr |= UART011_TXDMAE;
+		writew_relaxed(uap->dmacr, uap->port.membase + UART011_DMACR);
+		uap->im &= ~UART011_TXIM;
+		writew_relaxed(uap->im, uap->port.membase + UART011_IMSC);
+		return true;
+	}
+
+	/*
+	 * We don't have a TX buffer queued, so try to queue one.
+	 * If we succesfully queued a buffer, mask the TX IRQ.
+	 */
+	if (pl011_dma_tx_refill(uap) > 0) {
+		uap->im &= ~UART011_TXIM;
+		writew_relaxed(uap->im, uap->port.membase + UART011_IMSC);
+		return true;
+	}
+	return false;
+}
+
+/*
+ * Stop the DMA transmit (eg, due to received XOFF).
+ * Locking: called with port lock held and IRQs disabled.
+ */
+static inline void pl011_dma_tx_stop(struct uart_amba_port *uap)
+{
+	if (uap->dmatx.queued) {
+		uap->dmacr &= ~UART011_TXDMAE;
+		writew_relaxed(uap->dmacr, uap->port.membase + UART011_DMACR);
+	}
+}
+
+/*
+ * Try to start a DMA transmit, or in the case of an XON/OFF
+ * character queued for send, try to get that character out ASAP.
+ * Locking: called with port lock held and IRQs disabled.
+ * Returns:
+ *   false if we want the TX IRQ to be enabled
+ *   true if we have a buffer queued
+ */
+static inline bool pl011_dma_tx_start(struct uart_amba_port *uap)
+{
+	u16 dmacr;
+
+	if (!uap->using_dma)
+		return false;
+
+	if (!uap->port.x_char) {
+		/* no X-char, try to push chars out in DMA mode */
+		bool ret = true;
+
+		if (!uap->dmatx.queued) {
+			if (pl011_dma_tx_refill(uap) > 0) {
+				uap->im &= ~UART011_TXIM;
+				ret = true;
+			} else {
+				uap->im |= UART011_TXIM;
+				ret = false;
+			}
+			writew_relaxed(uap->im,
+				       uap->port.membase + UART011_IMSC);
+		} else if (!(uap->dmacr & UART011_TXDMAE)) {
+			uap->dmacr |= UART011_TXDMAE;
+			writew_relaxed(uap->dmacr,
+				       uap->port.membase + UART011_DMACR);
+		}
+		return ret;
+	}
+
+	/*
+	 * We have an X-char to send.  Disable DMA to prevent it loading
+	 * the TX fifo, and then see if we can stuff it into the FIFO.
+	 */
+	dmacr = uap->dmacr;
+	uap->dmacr &= ~UART011_TXDMAE;
+	writew_relaxed(uap->dmacr, uap->port.membase + UART011_DMACR);
+
+	if (readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF) {
+		/*
+		 * No space in the FIFO, so enable the transmit interrupt
+		 * so we know when there is space.  Note that once we've
+		 * loaded the character, we should just re-enable DMA.
+		 */
+		return false;
+	}
+
+	writew_relaxed(uap->port.x_char, uap->port.membase + UART01x_DR);
+	uap->port.icount.tx++;
+	uap->port.x_char = 0;
+
+	/* Success - restore the DMA state */
+	uap->dmacr = dmacr;
+	writew_relaxed(dmacr, uap->port.membase + UART011_DMACR);
+
+	return true;
+}
+
+static void pl011_dma_flush_buffer(struct uart_port *port)
+{
+	struct uart_amba_port *uap = (struct uart_amba_port *)port;
+
+	if (uap->using_dma) {
+		dmaengine_terminate_all(uap->dmatx.chan);
+		if (uap->dmatx.queued) {
+			/* FIXME: if only the pl08x did this for us... */
+			dma_unmap_sg(uap->dmatx.chan->device->dev,
+				     &uap->dmatx.sg, 1, DMA_TO_DEVICE);
+			uap->dmatx.queued = false;
+		}
+	}
+}
+
+
+static void pl011_dma_startup(struct uart_amba_port *uap)
+{
+	if (!uap->dmatx.chan)
+		return;
+
+	uap->dmatx.buf = kmalloc(PL011_DMA_BUFFER_SIZE, GFP_KERNEL);
+	if (!uap->dmatx.buf) {
+		dev_err(uap->port.dev, "no memory for DMA TX buffer\n");
+		uap->port.fifosize = uap->fifosize;
+		return;
+	}
+
+	sg_init_one(&uap->dmatx.sg, uap->dmatx.buf, PL011_DMA_BUFFER_SIZE);
+
+	/* The DMA buffer is now the FIFO the TTY subsystem can use */
+	uap->port.fifosize = PL011_DMA_BUFFER_SIZE;
+	uap->using_dma = true;
+
+	/* Turn on DMA error (RX/TX will be enabled on demand) */
+	uap->dmacr |= UART011_DMAONERR;
+	writew_relaxed(uap->dmacr, uap->port.membase + UART011_DMACR);
+}
+
+static void pl011_dma_shutdown(struct uart_amba_port *uap)
+{
+	if (!uap->using_dma)
+		return;
+
+	/* Disable RX and TX DMA */
+	while (readw(uap->port.membase + UART01x_FR) & UART01x_FR_BUSY)
+		barrier();
+
+	spin_lock_irq(&uap->port.lock);
+	uap->dmacr &= ~(UART011_DMAONERR | UART011_RXDMAE | UART011_TXDMAE);
+	writew_relaxed(uap->dmacr, uap->port.membase + UART011_DMACR);
+
+	/* Terminate any TX DMA job */
+	dmaengine_terminate_all(uap->dmatx.chan);
+	spin_unlock_irq(&uap->port.lock);
+
+	/* Clean up the TX DMA */
+	if (uap->dmatx.queued) {
+		/* FIXME: if only the pl08x did this for us... */
+		dma_unmap_sg(uap->dmatx.chan->device->dev,
+			     &uap->dmatx.sg, 1, DMA_TO_DEVICE);
+		uap->dmatx.queued = false;
+	}
+
+	kfree(uap->dmatx.buf);
+
+	uap->using_dma = false;
+}
+
+#else
+/* Blank functions if the DMA engine is not available */
+static inline void pl011_dma_probe(struct uart_amba_port *uap)
+{
+}
+
+static inline void pl011_dma_remove(struct uart_amba_port *uap)
+{
+}
+
+static inline void pl011_dma_startup(struct uart_amba_port *uap)
+{
+}
+
+static inline void pl011_dma_shutdown(struct uart_amba_port *uap)
+{
+}
+
+static inline bool pl011_dma_tx_irq(struct uart_amba_port *uap)
+{
+	return false;
+}
+
+static inline void pl011_dma_tx_stop(struct uart_amba_port *uap)
+{
+}
+
+static inline bool pl011_dma_tx_start(struct uart_amba_port *uap)
+{
+	return false;
+}
+
+#define pl011_dma_flush_buffer	NULL
+#endif
+
+
 static void pl011_stop_tx(struct uart_port *port)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
 
 	uap->im &= ~UART011_TXIM;
 	writew(uap->im, uap->port.membase + UART011_IMSC);
+	pl011_dma_tx_stop(uap);
 }
 
 static void pl011_start_tx(struct uart_port *port)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
 
-	uap->im |= UART011_TXIM;
-	writew(uap->im, uap->port.membase + UART011_IMSC);
+	if (!pl011_dma_tx_start(uap)) {
+		uap->im |= UART011_TXIM;
+		writew(uap->im, uap->port.membase + UART011_IMSC);
+	}
 }
 
 static void pl011_stop_rx(struct uart_port *port)
@@ -203,6 +695,10 @@ static void pl011_tx_chars(struct uart_amba_port *uap)
 		return;
 	}
 
+	/* If we are using DMA mode, try to send some characters. */
+	if (pl011_dma_tx_irq(uap))
+		return;
+
 	count = uap->fifosize >> 1;
 	do {
 		writew(xmit->buf[xmit->tail], uap->port.membase + UART01x_DR);
@@ -433,6 +929,9 @@ static int pl011_startup(struct uart_port *port)
 	 */
 	uap->old_status = readw(uap->port.membase + UART01x_FR) & UART01x_FR_MODEM_ANY;
 
+	/* Startup DMA */
+	pl011_dma_startup(uap);
+
 	/*
 	 * Finally, enable interrupts
 	 */
@@ -472,6 +971,8 @@ static void pl011_shutdown(struct uart_port *port)
 	writew(0xffff, uap->port.membase + UART011_ICR);
 	spin_unlock_irq(&uap->port.lock);
 
+	pl011_dma_shutdown(uap);
+
 	/*
 	 * Free the interrupt
 	 */
@@ -689,6 +1190,7 @@ static struct uart_ops amba_pl011_pops = {
 	.break_ctl	= pl011_break_ctl,
 	.startup	= pl011_startup,
 	.shutdown	= pl011_shutdown,
+	.flush_buffer	= pl011_dma_flush_buffer,
 	.set_termios	= pl011_set_termios,
 	.type		= pl011_type,
 	.release_port	= pl010_release_port,
@@ -881,6 +1383,7 @@ static int pl011_probe(struct amba_device *dev, struct amba_id *id)
 	uap->port.ops = &amba_pl011_pops;
 	uap->port.flags = UPF_BOOT_AUTOCONF;
 	uap->port.line = i;
+	pl011_dma_probe(uap);
 
 	amba_ports[i] = uap;
 
@@ -889,6 +1392,7 @@ static int pl011_probe(struct amba_device *dev, struct amba_id *id)
 	if (ret) {
 		amba_set_drvdata(dev, NULL);
 		amba_ports[i] = NULL;
+		pl011_dma_remove(uap);
 		clk_put(uap->clk);
  unmap:
 		iounmap(base);
@@ -912,6 +1416,7 @@ static int pl011_remove(struct amba_device *dev)
 		if (amba_ports[i] == uap)
 			amba_ports[i] = NULL;
 
+	pl011_dma_remove(uap);
 	iounmap(uap->port.membase);
 	clk_put(uap->clk);
 	kfree(uap);
diff --git a/include/linux/amba/serial.h b/include/linux/amba/serial.h
index 6021588..a307ded 100644
--- a/include/linux/amba/serial.h
+++ b/include/linux/amba/serial.h
@@ -180,6 +180,12 @@ struct amba_device; /* in uncompress this is included but amba/bus.h is not */
 struct amba_pl010_data {
 	void (*set_mctrl)(struct amba_device *dev, void __iomem *base, unsigned int mctrl);
 };
+struct dma_chan;
+struct amba_pl011_data {
+	bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
+	void *dma_rx_param;
+	void *dma_tx_param;
+};
 #endif
 
 #endif
-- 
1.6.2.5
