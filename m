From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 14 Aug 2012 15:49:23 +0200
Subject: [PATCH 09/23] spi/atmel_spi: add dmaengine support
In-Reply-To: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
References: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1344952177-18385-10-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/Kconfig     |    9 +
 drivers/spi/spi-atmel.c |  483 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 482 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 5f84b55..169592a 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -74,6 +74,15 @@ config SPI_ATMEL
 	  This selects a driver for the Atmel SPI Controller, present on
 	  many AT32 (AVR32) and AT91 (ARM) chips.
 
+config SPI_ATMEL_DMA
+	bool "Atmel SPI DMA support"
+	depends on SPI_ATMEL && (ARCH_AT91SAM9G45 || ARCH_AT91SAM9X5) && DMA_ENGINE && EXPERIMENTAL
+	default y
+	help
+	  Say Y here if you want the Atmel SPI driver to use the DMA engine. Data transfers
+	  will be handled by the DMA controller: it will increase throughput and reduce
+	  CPU utilization.
+
 config SPI_BFIN5XX
 	tristate "SPI controller driver for ADI Blackfin5xx"
 	depends on BLACKFIN
diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index ad47b6d..9456fca 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/spi/spi.h>
@@ -25,6 +26,7 @@
 #include <mach/board.h>
 #include <asm/gpio.h>
 #include <mach/cpu.h>
+#include <mach/at_hdmac.h>
 
 /* SPI register offsets */
 #define SPI_CR					0x0000
@@ -181,6 +183,22 @@
 	__raw_writel((value), (port)->regs + SPI_##reg)
 
 
+#if defined(CONFIG_SPI_ATMEL_DMA)
+/* use PIO for small transfers, avoiding DMA setup/teardown overhead and
+ * cache operations; better heuristics consider wordsize and bitrate.
+ */
+#define DMA_MIN_BYTES	16
+
+struct atmel_spi_dma {
+	struct dma_chan			*chan_rx;
+	struct dma_chan			*chan_tx;
+	struct scatterlist		sgrx;
+	struct scatterlist		sgtx;
+	struct dma_async_tx_descriptor	*data_desc_rx;
+	struct dma_async_tx_descriptor	*data_desc_tx;
+};
+#endif
+
 /*
  * The core SPI transfer engine just talks to a register bank to set up
  * DMA transfers; transfer queue progress is driven by IRQs.  The clock
@@ -199,6 +217,7 @@ struct atmel_spi {
 
 	u8			stopping;
 	struct list_head	queue;
+	struct tasklet_struct	tasklet;
 	struct spi_transfer	*current_transfer;
 	unsigned long		current_remaining_bytes;
 	struct spi_transfer	*next_transfer;
@@ -208,6 +227,11 @@ struct atmel_spi {
 	/* scratch buffer */
 	void			*buffer;
 	dma_addr_t		buffer_dma;
+
+#if defined(CONFIG_SPI_ATMEL_DMA)
+	/* dmaengine data */
+	struct atmel_spi_dma	dma;
+#endif
 };
 
 /* Controller-specific per-slave state */
@@ -336,6 +360,17 @@ static void atmel_spi_unlock(struct atmel_spi *as)
 		spin_unlock_irqrestore(&as->lock, as->flags);
 }
 
+static inline bool atmel_spi_use_dma(struct spi_transfer *xfer)
+{
+#if defined(CONFIG_SPI_ATMEL_DMA)
+	if (xfer->len < DMA_MIN_BYTES)
+		return false;
+	return true;
+#else
+	return false;
+#endif
+}
+
 static inline int atmel_spi_xfer_is_last(struct spi_message *msg,
 					struct spi_transfer *xfer)
 {
@@ -347,6 +382,258 @@ static inline int atmel_spi_xfer_can_be_chained(struct spi_transfer *xfer)
 	return xfer->delay_usecs == 0 && !xfer->cs_change;
 }
 
+#if defined(CONFIG_SPI_ATMEL_DMA)
+static bool __init filter(struct dma_chan *chan, void *slave)
+{
+	struct	at_dma_slave		*sl = slave;
+
+	if (sl->dma_dev == chan->device->dev) {
+		chan->private = sl;
+		return true;
+	} else {
+		return false;
+	}
+}
+
+static int __init atmel_spi_configure_dma(struct spi_master *master)
+{
+	struct atmel_spi	*as = spi_master_get_devdata(master);
+	struct device		*controller = master->dev.parent;
+	struct at_dma_slave	*sdata;
+
+	sdata = controller->platform_data;
+
+	if (sdata && sdata->dma_dev) {
+		dma_cap_mask_t mask;
+
+		/* setup DMA addresses */
+		sdata->rx_reg = (dma_addr_t)as->phybase + SPI_RDR;
+		sdata->tx_reg = (dma_addr_t)as->phybase + SPI_TDR;
+
+		/* Try to grab two DMA channels */
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+		as->dma.chan_tx = dma_request_channel(mask, filter, sdata);
+		if (as->dma.chan_tx)
+			as->dma.chan_rx = dma_request_channel(mask, filter, sdata);
+	}
+	if (!as->dma.chan_rx || !as->dma.chan_tx) {
+		if (as->dma.chan_rx)
+			dma_release_channel(as->dma.chan_rx);
+		if (as->dma.chan_tx)
+			dma_release_channel(as->dma.chan_tx);
+		dev_err(&as->pdev->dev, "DMA channel not available, "
+					"unable to use SPI\n");
+		return -EBUSY;
+	}
+
+	dev_info(&as->pdev->dev, "Using %s (tx) and "
+				" %s (rx) for DMA transfers\n",
+				dma_chan_name(as->dma.chan_tx),
+				dma_chan_name(as->dma.chan_rx));
+
+	return 0;
+}
+
+static void atmel_spi_stop_dma(struct atmel_spi *as)
+{
+	if (as->dma.chan_rx)
+		as->dma.chan_rx->device->device_control(as->dma.chan_rx,
+							DMA_TERMINATE_ALL, 0);
+	if (as->dma.chan_tx)
+		as->dma.chan_tx->device->device_control(as->dma.chan_tx,
+							DMA_TERMINATE_ALL, 0);
+}
+
+static void atmel_spi_release_dma(struct atmel_spi *as)
+{
+	if (as->dma.chan_rx)
+		dma_release_channel(as->dma.chan_rx);
+	if (as->dma.chan_tx)
+		dma_release_channel(as->dma.chan_tx);
+}
+
+/* This function is called by the DMA driver from tasklet context */
+static void dma_callback(void *data)
+{
+	struct spi_master	*master = data;
+	struct atmel_spi	*as = spi_master_get_devdata(master);
+
+	/* trigger SPI tasklet */
+	tasklet_schedule(&as->tasklet);
+}
+
+/*
+ * Next transfer using PIO.
+ * lock is held, spi tasklet is blocked
+ */
+static void atmel_spi_next_xfer_pio(struct spi_master *master,
+				struct spi_transfer *xfer)
+{
+	struct atmel_spi	*as = spi_master_get_devdata(master);
+
+	dev_vdbg(master->dev.parent, "atmel_spi_next_xfer_pio\n");
+
+	as->current_remaining_bytes = xfer->len;
+
+	/* Make sure data is not remaining in RDR */
+	spi_readl(as, RDR);
+	while (spi_readl(as, SR) & SPI_BIT(RDRF)) {
+		spi_readl(as, RDR);
+		cpu_relax();
+	}
+
+	if (xfer->tx_buf)
+		spi_writel(as, TDR, *(u8 *)(xfer->tx_buf));
+	else
+		spi_writel(as, TDR, 0);
+
+	dev_dbg(master->dev.parent,
+		"  start pio xfer %p: len %u tx %p rx %p\n",
+		xfer, xfer->len, xfer->tx_buf, xfer->rx_buf);
+
+	/* Enable relevant interrupts */
+	spi_writel(as, IER, SPI_BIT(RDRF) | SPI_BIT(OVRES));
+}
+
+/*
+ * Submit next transfer for DMA.
+ * lock is held, spi tasklet is blocked
+ */
+static int atmel_spi_next_xfer_dma(struct spi_master *master,
+				struct spi_transfer *xfer)
+{
+	struct atmel_spi	*as = spi_master_get_devdata(master);
+	struct dma_chan		*rxchan = as->dma.chan_rx;
+	struct dma_chan		*txchan = as->dma.chan_tx;
+	struct dma_async_tx_descriptor *rxdesc;
+	struct dma_async_tx_descriptor *txdesc;
+	dma_cookie_t		cookie;
+
+	dev_vdbg(master->dev.parent, "atmel_spi_next_xfer_dma\n");
+
+	/* Check that the channels are available */
+	if (!rxchan || !txchan)
+		return -ENODEV;
+
+	/* release lock for DMA operations */
+	atmel_spi_unlock(as);
+
+	/* prepare the RX dma transfer */
+	sg_init_table(&as->dma.sgrx, 1);
+	sg_dma_len(&as->dma.sgrx) = xfer->len;
+	if (xfer->rx_buf)
+		as->dma.sgrx.dma_address = xfer->rx_dma;
+	else
+		as->dma.sgrx.dma_address = as->buffer_dma;
+
+	/* prepare the TX dma transfer */
+	sg_init_table(&as->dma.sgtx, 1);
+	sg_dma_len(&as->dma.sgtx) = xfer->len;
+	if (xfer->tx_buf) {
+		as->dma.sgtx.dma_address = xfer->tx_dma;
+	} else {
+		as->dma.sgtx.dma_address = as->buffer_dma;
+		memset(as->buffer, 0, xfer->len);
+	}
+
+	/* Send both scatterlists */
+	rxdesc = rxchan->device->device_prep_slave_sg(rxchan,
+					&as->dma.sgrx,
+					1,
+					DMA_FROM_DEVICE,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!rxdesc)
+		goto err_dma;
+
+	txdesc = txchan->device->device_prep_slave_sg(txchan,
+					&as->dma.sgtx,
+					1,
+					DMA_TO_DEVICE,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!txdesc)
+		goto err_dma;
+
+	dev_dbg(master->dev.parent,
+		"  start dma xfer %p: len %u tx %p/%08x rx %p/%08x\n",
+		xfer, xfer->len, xfer->tx_buf, xfer->tx_dma,
+		xfer->rx_buf, xfer->rx_dma);
+
+	/* Enable relevant interrupts */
+	spi_writel(as, IER, SPI_BIT(OVRES));
+
+	/* Put the callback on the RX transfer only, that should finish last */
+	rxdesc->callback = dma_callback;
+	rxdesc->callback_param = master;
+
+	/* Submit and fire RX and TX with TX last so we're ready to read! */
+	cookie = rxdesc->tx_submit(rxdesc);
+	if (dma_submit_error(cookie))
+		goto err_dma;
+	cookie = txdesc->tx_submit(txdesc);
+	if (dma_submit_error(cookie))
+		goto err_dma;
+	rxchan->device->device_issue_pending(rxchan);
+	txchan->device->device_issue_pending(txchan);
+
+	/* take back lock */
+	atmel_spi_lock(as);
+	return 0;
+
+err_dma:
+	spi_writel(as, IDR, SPI_BIT(OVRES));
+	atmel_spi_stop_dma(as);
+	atmel_spi_lock(as);
+	return -ENOMEM;
+}
+
+/*
+ * Choose way to submit next transfer and start it.
+ * lock is held, spi tasklet is blocked
+ */
+static void atmel_spi_next_xfer(struct spi_master *master,
+				struct spi_message *msg)
+{
+	struct atmel_spi	*as = spi_master_get_devdata(master);
+	struct spi_transfer	*xfer;
+
+	dev_vdbg(&msg->spi->dev, "atmel_spi_next_xfer\n");
+
+	if (!as->current_transfer)
+		xfer = list_entry(msg->transfers.next,
+				struct spi_transfer, transfer_list);
+	else
+		xfer = list_entry(as->current_transfer->transfer_list.next,
+				struct spi_transfer, transfer_list);
+
+	as->current_transfer = xfer;
+
+	if (atmel_spi_use_dma(xfer)) {
+		if (!atmel_spi_next_xfer_dma(master, xfer))
+			return;
+		else
+			dev_err(&msg->spi->dev, "unable to use DMA, fallback to PIO\n");
+	}
+
+	/* use PIO if xfer is short or error appened using DMA */
+	atmel_spi_next_xfer_pio(master, xfer);
+}
+
+static void atmel_spi_disable_dma_irq(struct atmel_spi *as) {}
+#else
+static void atmel_spi_disable_dma_irq(struct atmel_spi *as)
+{
+	spi_writel(as, PTCR, SPI_BIT(RXTDIS) | SPI_BIT(TXTDIS));
+}
+
+static int __init atmel_spi_configure_dma(struct spi_master *master)
+{
+	struct atmel_spi	*as = spi_master_get_devdata(master);
+
+	atmel_spi_disable_dma_irq(as);
+	return 0;
+}
+
 static void atmel_spi_next_xfer_data(struct spi_master *master,
 				struct spi_transfer *xfer,
 				dma_addr_t *tx_dma,
@@ -479,6 +766,10 @@ static void atmel_spi_next_xfer(struct spi_master *master,
 	spi_writel(as, PTCR, SPI_BIT(TXTEN) | SPI_BIT(RXTEN));
 }
 
+static void atmel_spi_stop_dma(struct atmel_spi *as) {}
+static void atmel_spi_release_dma(struct atmel_spi *as) {}
+#endif
+
 static void atmel_spi_next_message(struct spi_master *master)
 {
 	struct atmel_spi	*as = spi_master_get_devdata(master);
@@ -582,11 +873,175 @@ atmel_spi_msg_done(struct spi_master *master, struct atmel_spi *as,
 
 	/* continue if needed */
 	if (list_empty(&as->queue) || as->stopping)
-		spi_writel(as, PTCR, SPI_BIT(RXTDIS) | SPI_BIT(TXTDIS));
+		atmel_spi_disable_dma_irq(as);
 	else
 		atmel_spi_next_message(master);
 }
 
+#if defined(CONFIG_SPI_ATMEL_DMA)
+/* Called from IRQ
+ * lock is held
+ *
+ * Must update "current_remaining_bytes" to keep track of data
+ * to transfer.
+ */
+static void
+atmel_spi_pump_pio_data(struct atmel_spi *as, struct spi_transfer *xfer)
+{
+	u8		*txp;
+	u8		*rxp;
+	unsigned long	xfer_pos = xfer->len - as->current_remaining_bytes;
+
+	if (xfer->rx_buf) {
+		rxp = ((u8 *)xfer->rx_buf) + xfer_pos;
+		*rxp = spi_readl(as, RDR);
+	} else {
+		spi_readl(as, RDR);
+	}
+
+	as->current_remaining_bytes--;
+
+	if (as->current_remaining_bytes) {
+		if (xfer->tx_buf) {
+			txp = ((u8 *)xfer->tx_buf) + xfer_pos + 1;
+			spi_writel(as, TDR, *txp);
+		} else {
+			spi_writel(as, TDR, 0);
+		}
+	}
+}
+
+/* Tasklet
+ * Called from DMA callback + pio transfer and overrun IRQ.
+ */
+static void atmel_spi_tasklet_func(unsigned long data)
+{
+	struct spi_master	*master = (struct spi_master *)data;
+	struct atmel_spi	*as = spi_master_get_devdata(master);
+	struct spi_message	*msg;
+	struct spi_transfer	*xfer;
+
+	dev_vdbg(master->dev.parent, "atmel_spi_tasklet_func\n");
+
+	atmel_spi_lock(as);
+
+	xfer = as->current_transfer;
+
+	if (xfer == NULL)
+		/* already been there */
+		goto tasklet_out;
+
+	msg = list_entry(as->queue.next, struct spi_message, queue);
+
+	if (as->done_status < 0) {
+		/* error happened (overrun) */
+		if (atmel_spi_use_dma(xfer))
+			atmel_spi_stop_dma(as);
+	} else {
+		/* only update length if no error */
+		msg->actual_length += xfer->len;
+	}
+
+	if (atmel_spi_use_dma(xfer)) {
+		if (!msg->is_dma_mapped)
+			atmel_spi_dma_unmap_xfer(master, xfer);
+	}
+
+	if (xfer->delay_usecs)
+		udelay(xfer->delay_usecs);
+
+	if (atmel_spi_xfer_is_last(msg, xfer) || as->done_status < 0) {
+		/* report completed (or erroneous) message */
+		atmel_spi_msg_done(master, as, msg, xfer->cs_change);
+	} else {
+		if (xfer->cs_change) {
+			cs_deactivate(as, msg->spi);
+			udelay(1);
+			cs_activate(as, msg->spi);
+		}
+
+		/*
+		 * Not done yet. Submit the next transfer.
+		 *
+		 * FIXME handle protocol options for xfer
+		 */
+		atmel_spi_next_xfer(master, msg);
+	}
+
+tasklet_out:
+	atmel_spi_unlock(as);
+}
+
+
+/* Interrupt with DMA engine management
+ *
+ * No need for locking in this Interrupt handler: done_status is the
+ * only information modified. What we need is the update of this field
+ * before tasklet runs. This is ensured by using barrier.
+ */
+static irqreturn_t
+atmel_spi_interrupt(int irq, void *dev_id)
+{
+	struct spi_master	*master = dev_id;
+	struct atmel_spi	*as = spi_master_get_devdata(master);
+	u32			status, pending, imr;
+	struct spi_transfer	*xfer;
+	int			ret = IRQ_NONE;
+
+	imr = spi_readl(as, IMR);
+	status = spi_readl(as, SR);
+	pending = status & imr;
+
+	if (pending & SPI_BIT(OVRES)) {
+		ret = IRQ_HANDLED;
+		spi_writel(as, IDR, SPI_BIT(OVRES));
+		dev_warn(master->dev.parent, "overrun\n");
+
+		/*
+		 * When we get an overrun, we disregard the current
+		 * transfer. Data will not be copied back from any
+		 * bounce buffer and msg->actual_len will not be
+		 * updated with the last xfer.
+		 *
+		 * We will also not process any remaning transfers in
+		 * the message.
+		 *
+		 * All actions are done in tasklet with done_status indication
+		 */
+		as->done_status = -EIO;
+		smp_wmb();
+
+		/* Clear any overrun happening while cleaning up */
+		spi_readl(as, SR);
+
+		tasklet_schedule(&as->tasklet);
+
+	} else if (pending & SPI_BIT(RDRF)) {
+		atmel_spi_lock(as);
+
+		if (as->current_remaining_bytes) {
+			ret = IRQ_HANDLED;
+			xfer = as->current_transfer;
+			atmel_spi_pump_pio_data(as, xfer);
+			if (!as->current_remaining_bytes) {
+				/* no more data to xfer, kick tasklet */
+				spi_writel(as, IDR, pending);
+				tasklet_schedule(&as->tasklet);
+			}
+		}
+
+		atmel_spi_unlock(as);
+	} else {
+		WARN_ONCE(pending, "IRQ not handled, pending = %x\n", pending);
+		ret = IRQ_HANDLED;
+		spi_writel(as, IDR, pending);
+	}
+
+	return ret;
+}
+#else
+static void atmel_spi_tasklet_func(unsigned long data) {}
+
 static irqreturn_t
 atmel_spi_interrupt(int irq, void *dev_id)
 {
@@ -704,6 +1159,7 @@ atmel_spi_interrupt(int irq, void *dev_id)
 
 	return ret;
 }
+#endif
 
 static int atmel_spi_setup(struct spi_device *spi)
 {
@@ -865,13 +1321,9 @@ static int atmel_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 
 		/*
 		 * DMA map early, for performance (empties dcache ASAP) and
-		 * better fault reporting.  This is a DMA-only driver.
-		 *
-		 * NOTE that if dma_unmap_single() ever starts to do work on
-		 * platforms supported by this driver, we would need to clean
-		 * up mappings for previously-mapped transfers.
+		 * better fault reporting.
 		 */
-		if (!msg->is_dma_mapped) {
+		if (!msg->is_dma_mapped && atmel_spi_use_dma(xfer)) {
 			if (atmel_spi_dma_map_xfer(as, xfer) < 0)
 				return -ENOMEM;
 		}
@@ -973,6 +1425,7 @@ static int __devinit atmel_spi_probe(struct platform_device *pdev)
 
 	spin_lock_init(&as->lock);
 	INIT_LIST_HEAD(&as->queue);
+	tasklet_init(&as->tasklet, atmel_spi_tasklet_func, (unsigned long)master);
 	as->pdev = pdev;
 	as->regs = ioremap(regs->start, resource_size(regs));
 	if (!as->regs)
@@ -991,7 +1444,11 @@ static int __devinit atmel_spi_probe(struct platform_device *pdev)
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
 	spi_writel(as, MR, SPI_BIT(MSTR) | SPI_BIT(MODFDIS));
-	spi_writel(as, PTCR, SPI_BIT(RXTDIS) | SPI_BIT(TXTDIS));
+
+	ret = atmel_spi_configure_dma(master);
+	if (ret)
+		goto out_reset_hw;
+
 	spi_writel(as, CR, SPI_BIT(SPIEN));
 
 	/* go! */
@@ -1000,10 +1457,12 @@ static int __devinit atmel_spi_probe(struct platform_device *pdev)
 
 	ret = spi_register_master(master);
 	if (ret)
-		goto out_reset_hw;
+		goto out_free_dma;
 
 	return 0;
 
+out_free_dma:
+	atmel_spi_release_dma(as);
 out_reset_hw:
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
@@ -1012,6 +1471,7 @@ out_reset_hw:
 out_unmap_regs:
 	iounmap(as->regs);
 out_free_buffer:
+	tasklet_kill(&as->tasklet);
 	dma_free_coherent(&pdev->dev, BUFFER_SIZE, as->buffer,
 			as->buffer_dma);
 out_free:
@@ -1030,6 +1490,8 @@ static int __devexit atmel_spi_remove(struct platform_device *pdev)
 	/* reset the hardware and block queue progress */
 	spin_lock_irq(&as->lock);
 	as->stopping = 1;
+	atmel_spi_stop_dma(as);
+	atmel_spi_release_dma(as);
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
 	spi_readl(as, SR);
@@ -1038,13 +1500,14 @@ static int __devexit atmel_spi_remove(struct platform_device *pdev)
 	/* Terminate remaining queued transfers */
 	list_for_each_entry(msg, &as->queue, queue) {
 		list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-			if (!msg->is_dma_mapped)
+			if (!msg->is_dma_mapped && atmel_spi_use_dma(xfer))
 				atmel_spi_dma_unmap_xfer(master, xfer);
 		}
 		msg->status = -ESHUTDOWN;
 		msg->complete(msg->context);
 	}
 
+	tasklet_kill(&as->tasklet);
 	dma_free_coherent(&pdev->dev, BUFFER_SIZE, as->buffer,
 			as->buffer_dma);
 
-- 
1.7.2.5
