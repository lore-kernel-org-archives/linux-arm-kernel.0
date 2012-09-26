From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 26 Sep 2012 14:50:57 +0800
Subject: [PATCH 2/6] spi: atmel: add dmaengine and dt support
In-Reply-To: <1348642261-27554-1-git-send-email-wenyou.yang@atmel.com>
References: <1348642261-27554-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1348642261-27554-3-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 .../devicetree/bindings/spi/spi_atmel.txt          |   29 +
 drivers/spi/spi-atmel.c                            |  739 ++++++++++++++++++--
 2 files changed, 696 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi_atmel.txt

diff --git a/Documentation/devicetree/bindings/spi/spi_atmel.txt b/Documentation/devicetree/bindings/spi/spi_atmel.txt
new file mode 100644
index 0000000..5a64825
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi_atmel.txt
@@ -0,0 +1,29 @@
+Atmel SPI device
+
+Required properties:
+- compatible : should be "atmel,at91rm9200-spi".
+- reg: Address and length of the register set for the device
+- interrupts: Should contain macb interrupt
+- cs-gpio: Should contain the GPIOs used for chipselect.
+- has_dma_support: The chip has dma engine support for spi: 1 - support, 0 - no support
+- has_pdc_support: The chip has pdc support for spi: 1 - support, 0 - no support
+- is_ver2: If is th spi IP version 2, 1 - yes, 0 - no
+- dma: handle to the dma controller that should be used
+
+spi0: spi at f0000000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "atmel,at91rm9200-spi";
+	reg = <0xf0000000 0x100>;
+	interrupts = <13 4>;
+	cs-gpios = <&pioA 14 0
+		    &pioA 7 0 /* conflicts with TXD2 */
+		    &pioA 1 0 /* conflicts with RXD0 */
+		    &pioB 3 0 /* conflicts with ERXDV */
+		   >;
+	has_dma_support = <1>;
+	has_pdc_support = <0>;
+	is_ver2 = <1>;
+	dma = <&dma0 0x10002212>;
+	status = "disabled";
+};
diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 16d6a83..9930438 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -15,15 +15,19 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 
 #include <asm/io.h>
 #include <mach/board.h>
 #include <asm/gpio.h>
 #include <mach/cpu.h>
+#include <mach/at_hdmac.h>
 
 /* SPI register offsets */
 #define SPI_CR					0x0000
@@ -179,6 +183,38 @@
 #define spi_writel(port,reg,value) \
 	__raw_writel((value), (port)->regs + SPI_##reg)
 
+/*
+ * Version 2 of the SPI controller has
+ *  - CR.LASTXFER
+ *  - SPI_MR.DIV32 may become FDIV or must-be-zero (here: always zero)
+ *  - SPI_SR.TXEMPTY, SPI_SR.NSSR (and corresponding irqs)
+ *  - SPI_CSRx.CSAAT
+ *  - SPI_CSRx.SBCR allows faster clocking
+ *
+ * We can determine the controller version by reading the VERSION
+ * register, but I haven't checked that it exists on all chips, and
+ * this is cheaper anyway.
+ */
+struct atmel_spi_data {
+	u8			has_dma_support;
+	u8			has_pdc_support;
+	u8			is_ver2;	/* 1-yes, 0-not */
+	struct at_dma_slave	dma_slave;
+};
+
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
 
 /*
  * The core SPI transfer engine just talks to a register bank to set up
@@ -187,7 +223,9 @@
  */
 struct atmel_spi {
 	spinlock_t		lock;
+	unsigned long		flags;
 
+	resource_size_t		phybase;
 	void __iomem		*regs;
 	int			irq;
 	struct clk		*clk;
@@ -196,13 +234,23 @@ struct atmel_spi {
 
 	u8			stopping;
 	struct list_head	queue;
+	struct tasklet_struct	tasklet;
 	struct spi_transfer	*current_transfer;
 	unsigned long		current_remaining_bytes;
 	struct spi_transfer	*next_transfer;
 	unsigned long		next_remaining_bytes;
+	int			done_status;
+	struct atmel_spi_data	data;
 
+	bool			use_dma;
+	bool			use_pdc;
+
+	/* scratch buffer */
 	void			*buffer;
 	dma_addr_t		buffer_dma;
+
+	/* dmaengine data */
+	struct atmel_spi_dma	dma;
 };
 
 /* Controller-specific per-slave state */
@@ -214,22 +262,7 @@ struct atmel_spi_device {
 #define BUFFER_SIZE		PAGE_SIZE
 #define INVALID_DMA_ADDRESS	0xffffffff
 
-/*
- * Version 2 of the SPI controller has
- *  - CR.LASTXFER
- *  - SPI_MR.DIV32 may become FDIV or must-be-zero (here: always zero)
- *  - SPI_SR.TXEMPTY, SPI_SR.NSSR (and corresponding irqs)
- *  - SPI_CSRx.CSAAT
- *  - SPI_CSRx.SBCR allows faster clocking
- *
- * We can determine the controller version by reading the VERSION
- * register, but I haven't checked that it exists on all chips, and
- * this is cheaper anyway.
- */
-static bool atmel_spi_is_v2(void)
-{
-	return !cpu_is_at91rm9200();
-}
+static struct dma_slave_config slave_config;
 
 /*
  * Earlier SPI controllers (e.g. on at91rm9200) have a design bug whereby
@@ -250,7 +283,7 @@ static bool atmel_spi_is_v2(void)
  * nCS0 on that chip, we (a) don't use the GPIO, (b) can't support CS_HIGH,
  * and (c) will trigger that first erratum in some cases.
  *
- * TODO: Test if the atmel_spi_is_v2() branch below works on
+ * TODO: Test if the as->data.is_ver2 == 0 branch below works on
  * AT91RM9200 if we use some other register than CSR0. However, don't
  * do this unconditionally since AP7000 has an errata where the BITS
  * field in CSR0 overrides all other CSRs.
@@ -262,7 +295,7 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 	unsigned active = spi->mode & SPI_CS_HIGH;
 	u32 mr;
 
-	if (atmel_spi_is_v2()) {
+	if (as->data.is_ver2 == 1) {
 		/*
 		 * Always use CSR0. This ensures that the clock
 		 * switches to the correct idle polarity before we
@@ -317,10 +350,29 @@ static void cs_deactivate(struct atmel_spi *as, struct spi_device *spi)
 			asd->npcs_pin, active ? " (low)" : "",
 			mr);
 
-	if (atmel_spi_is_v2() || spi->chip_select != 0)
+	if ((as->data.is_ver2 == 1) || spi->chip_select != 0)
 		gpio_set_value(asd->npcs_pin, !active);
 }
 
+static void atmel_spi_lock(struct atmel_spi *as)
+{
+		spin_lock_irqsave(&as->lock, as->flags);
+}
+
+static void atmel_spi_unlock(struct atmel_spi *as)
+{
+		spin_unlock_irqrestore(&as->lock, as->flags);
+}
+
+static inline bool atmel_spi_use_dma(struct atmel_spi *as,
+				struct spi_transfer *xfer)
+{
+	if ((as->use_dma) && (xfer->len >= DMA_MIN_BYTES))
+		return true;
+	else
+		return false;
+}
+
 static inline int atmel_spi_xfer_is_last(struct spi_message *msg,
 					struct spi_transfer *xfer)
 {
@@ -332,6 +384,255 @@ static inline int atmel_spi_xfer_can_be_chained(struct spi_transfer *xfer)
 	return xfer->delay_usecs == 0 && !xfer->cs_change;
 }
 
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
+		if (xfer->bits_per_word > 8)
+			spi_writel(as, TDR, *(u16 *)(xfer->tx_buf));
+		else
+			spi_writel(as, TDR, *(u8 *)(xfer->tx_buf));
+	else
+		spi_writel(as, TDR, 0);
+
+	dev_dbg(master->dev.parent,
+		"  start pio xfer %p: len %u tx %p rx %p bitpw %d\n",
+		xfer, xfer->len, xfer->tx_buf, xfer->rx_buf,
+		xfer->bits_per_word);
+
+	/* Enable relevant interrupts */
+	spi_writel(as, IER, SPI_BIT(RDRF) | SPI_BIT(OVRES));
+}
+
+static bool filter(struct dma_chan *chan, void *slave)
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
+static int atmel_spi_set_dma_xfer_width(struct atmel_spi *as, u8 bits_per_word)
+{
+	int err = 0;
+
+	if (bits_per_word > 8) {
+		slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	} else {
+		slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	}
+
+	slave_config.direction = DMA_TO_DEVICE;
+	if (dmaengine_slave_config(as->dma.chan_tx, &slave_config)) {
+		dev_err(&as->pdev->dev,
+			"failed to configure tx dma channel\n");
+		err = -EINVAL;
+	}
+
+	slave_config.direction = DMA_FROM_DEVICE;
+	if (dmaengine_slave_config(as->dma.chan_rx, &slave_config)) {
+		dev_err(&as->pdev->dev,
+			"failed to configure rx dma channel\n");
+		err = -EINVAL;
+	}
+	return err;
+}
+
+static int __devinit atmel_spi_configure_dma(struct atmel_spi *as)
+{
+	struct at_dma_slave *sdata = (struct at_dma_slave *)&as->data.dma_slave;
+	int err;
+
+	slave_config.dst_addr = (dma_addr_t)as->phybase + SPI_TDR;
+	slave_config.src_addr = (dma_addr_t)as->phybase + SPI_RDR;
+	slave_config.src_maxburst = 1;
+	slave_config.dst_maxburst = 1;
+	slave_config.device_fc = false;
+
+	if (sdata && sdata->dma_dev) {
+		dma_cap_mask_t mask;
+
+		/* Try to grab two DMA channels */
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+		as->dma.chan_tx = dma_request_channel(mask, filter, sdata);
+		if (as->dma.chan_tx)
+			as->dma.chan_rx = dma_request_channel(mask,
+							filter, sdata);
+	}
+
+	if (!as->dma.chan_rx || !as->dma.chan_tx) {
+		dev_err(&as->pdev->dev, "DMA channel not available, " \
+					"unable to use SPI\n");
+		err = -EBUSY;
+		goto error;
+	}
+
+	err = atmel_spi_set_dma_xfer_width(as, 8);
+	if (err)
+		goto error;
+
+	dev_info(&as->pdev->dev, "Using %s (tx) and " \
+				" %s (rx) for DMA transfers\n",
+				dma_chan_name(as->dma.chan_tx),
+				dma_chan_name(as->dma.chan_rx));
+
+	return 0;
+error:
+	if (as->dma.chan_rx)
+		dma_release_channel(as->dma.chan_rx);
+	if (as->dma.chan_tx)
+		dma_release_channel(as->dma.chan_tx);
+	return err;
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
+	if (atmel_spi_set_dma_xfer_width(as, xfer->bits_per_word))
+		goto err_dma;
+
+	/* Send both scatterlists */
+	rxdesc = rxchan->device->device_prep_slave_sg(rxchan,
+					&as->dma.sgrx,
+					1,
+					DMA_FROM_DEVICE,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK,
+					NULL);
+	if (!rxdesc)
+		goto err_dma;
+
+	txdesc = txchan->device->device_prep_slave_sg(txchan,
+					&as->dma.sgtx,
+					1,
+					DMA_TO_DEVICE,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK,
+					NULL);
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
 static void atmel_spi_next_xfer_data(struct spi_master *master,
 				struct spi_transfer *xfer,
 				dma_addr_t *tx_dma,
@@ -364,10 +665,10 @@ static void atmel_spi_next_xfer_data(struct spi_master *master,
 }
 
 /*
- * Submit next transfer for DMA.
+ * Submit next transfer for PDC.
  * lock is held, spi irq is blocked
  */
-static void atmel_spi_next_xfer(struct spi_master *master,
+static void atmel_spi_next_xfer_pdc(struct spi_master *master,
 				struct spi_message *msg)
 {
 	struct atmel_spi	*as = spi_master_get_devdata(master);
@@ -464,6 +765,44 @@ static void atmel_spi_next_xfer(struct spi_master *master,
 	spi_writel(as, PTCR, SPI_BIT(TXTEN) | SPI_BIT(RXTEN));
 }
 
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
+	if (as->use_pdc)
+		atmel_spi_next_xfer_pdc(master, msg);
+	else {
+		if (!as->current_transfer)
+			xfer = list_entry(msg->transfers.next,
+				struct spi_transfer, transfer_list);
+		else
+			xfer = list_entry(
+				as->current_transfer->transfer_list.next,
+				struct spi_transfer, transfer_list);
+
+		as->current_transfer = xfer;
+
+		/* quick (and *really* not optimal) workaround for DMA BUG */
+		if (atmel_spi_use_dma(as, xfer) && (xfer->len < BUFFER_SIZE)) {
+			if (!atmel_spi_next_xfer_dma(master, xfer))
+				return;
+			else
+				dev_err(&msg->spi->dev, "unable to use DMA, fallback to PIO\n");
+		}
+
+		/* use PIO if xfer is short or error appened using DMA */
+		atmel_spi_next_xfer_pio(master, xfer);
+	}
+}
+
 static void atmel_spi_next_message(struct spi_master *master)
 {
 	struct atmel_spi	*as = spi_master_get_devdata(master);
@@ -541,43 +880,218 @@ static void atmel_spi_dma_unmap_xfer(struct spi_master *master,
 				 xfer->len, DMA_FROM_DEVICE);
 }
 
+static void atmel_spi_disable_pdc_transfer(struct atmel_spi *as)
+{
+	spi_writel(as, PTCR, SPI_BIT(RXTDIS) | SPI_BIT(TXTDIS));
+}
+
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
 		msg->actual_length);
 
-	spin_unlock(&as->lock);
+	atmel_spi_unlock(as);
 	msg->complete(msg->context);
-	spin_lock(&as->lock);
+	atmel_spi_lock(as);
 
 	as->current_transfer = NULL;
 	as->next_transfer = NULL;
+	as->done_status = 0;
 
 	/* continue if needed */
-	if (list_empty(&as->queue) || as->stopping)
-		spi_writel(as, PTCR, SPI_BIT(RXTDIS) | SPI_BIT(TXTDIS));
-	else
+	if (list_empty(&as->queue) || as->stopping) {
+		if (as->use_pdc)
+			atmel_spi_disable_pdc_transfer(as);
+	} else
 		atmel_spi_next_message(master);
 }
 
-static irqreturn_t
-atmel_spi_interrupt(int irq, void *dev_id)
+/* Called from IRQ
+ * lock is held
+ *
+ * Must update "current_remaining_bytes" to keep track of data
+ * to transfer.
+ */
+static void
+atmel_spi_pump_pio_data(struct atmel_spi *as, struct spi_transfer *xfer)
 {
-	struct spi_master	*master = dev_id;
+	u8		*txp;
+	u8		*rxp;
+	u16		*txp16;
+	u16		*rxp16;
+	unsigned long	xfer_pos = xfer->len - as->current_remaining_bytes;
+
+	if (xfer->rx_buf) {
+		if (xfer->bits_per_word > 8) {
+			rxp16 = (u16 *)(((u8 *)xfer->rx_buf) + xfer_pos);
+			*rxp16 = spi_readl(as, RDR);
+		} else {
+			rxp = ((u8 *)xfer->rx_buf) + xfer_pos;
+			*rxp = spi_readl(as, RDR);
+		}
+	} else {
+		spi_readl(as, RDR);
+	}
+	if (xfer->bits_per_word > 8) {
+		as->current_remaining_bytes -= 2;
+		if (as->current_remaining_bytes < 0)
+			as->current_remaining_bytes = 0;
+	} else {
+		as->current_remaining_bytes--;
+	}
+
+	if (as->current_remaining_bytes) {
+		if (xfer->tx_buf) {
+			if (xfer->bits_per_word > 8) {
+				txp16 = (u16 *)(((u8 *)xfer->tx_buf)
+							+ xfer_pos + 2);
+				spi_writel(as, TDR, *txp16);
+			} else {
+				txp = ((u8 *)xfer->tx_buf) + xfer_pos + 1;
+				spi_writel(as, TDR, *txp);
+			}
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
 	struct atmel_spi	*as = spi_master_get_devdata(master);
 	struct spi_message	*msg;
 	struct spi_transfer	*xfer;
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
+		if (atmel_spi_use_dma(as, xfer))
+			atmel_spi_stop_dma(as);
+	} else {
+		/* only update length if no error */
+		msg->actual_length += xfer->len;
+	}
+
+	if (atmel_spi_use_dma(as, xfer)) {
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
+static int atmel_spi_interrupt_dma(struct atmel_spi *as,
+				struct spi_master *master)
+{
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
+
+static int atmel_spi_interrupt_pdc(struct atmel_spi *as,
+				struct spi_master *master)
+{
+	struct spi_message	*msg;
+	struct spi_transfer	*xfer;
 	u32			status, pending, imr;
 	int			ret = IRQ_NONE;
 
@@ -610,8 +1124,6 @@ atmel_spi_interrupt(int irq, void *dev_id)
 		 * First, stop the transfer and unmap the DMA buffers.
 		 */
 		spi_writel(as, PTCR, SPI_BIT(RXTDIS) | SPI_BIT(TXTDIS));
-		if (!msg->is_dma_mapped)
-			atmel_spi_dma_unmap_xfer(master, xfer);
 
 		/* REVISIT: udelay in irq is unfriendly */
 		if (xfer->delay_usecs)
@@ -640,7 +1152,8 @@ atmel_spi_interrupt(int irq, void *dev_id)
 		/* Clear any overrun happening while cleaning up */
 		spi_readl(as, SR);
 
-		atmel_spi_msg_done(master, as, msg, -EIO, 0);
+		as->done_status = -EIO;
+		atmel_spi_msg_done(master, as, msg, 0);
 	} else if (pending & (SPI_BIT(RXBUFF) | SPI_BIT(ENDRX))) {
 		ret = IRQ_HANDLED;
 
@@ -649,16 +1162,13 @@ atmel_spi_interrupt(int irq, void *dev_id)
 		if (as->current_remaining_bytes == 0) {
 			msg->actual_length += xfer->len;
 
-			if (!msg->is_dma_mapped)
-				atmel_spi_dma_unmap_xfer(master, xfer);
-
 			/* REVISIT: udelay in irq is unfriendly */
 			if (xfer->delay_usecs)
 				udelay(xfer->delay_usecs);
 
 			if (atmel_spi_xfer_is_last(msg, xfer)) {
 				/* report completed message */
-				atmel_spi_msg_done(master, as, msg, 0,
+				atmel_spi_msg_done(master, as, msg,
 						xfer->cs_change);
 			} else {
 				if (xfer->cs_change) {
@@ -688,6 +1198,27 @@ atmel_spi_interrupt(int irq, void *dev_id)
 	return ret;
 }
 
+/* Interrupt
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
+	int ret;
+
+	if (as->use_pdc)
+		ret = atmel_spi_interrupt_pdc(as, master);
+	else
+		ret = atmel_spi_interrupt_dma(as, master);
+
+	return ret;
+}
+
 static int atmel_spi_setup(struct spi_device *spi)
 {
 	struct atmel_spi	*as;
@@ -695,7 +1226,7 @@ static int atmel_spi_setup(struct spi_device *spi)
 	u32			scbr, csr;
 	unsigned int		bits = spi->bits_per_word;
 	unsigned long		bus_hz;
-	unsigned int		npcs_pin;
+	int			npcs_pin;
 	int			ret;
 
 	as = spi_master_get_devdata(spi->master);
@@ -718,16 +1249,16 @@ static int atmel_spi_setup(struct spi_device *spi)
 	}
 
 	/* see notes above re chipselect */
-	if (!atmel_spi_is_v2()
-			&& spi->chip_select == 0
-			&& (spi->mode & SPI_CS_HIGH)) {
+	if ((as->data.is_ver2 == 0)
+		&& spi->chip_select == 0
+		&& (spi->mode & SPI_CS_HIGH)) {
 		dev_dbg(&spi->dev, "setup: can't be active-high\n");
 		return -EINVAL;
 	}
 
 	/* v1 chips start out at half the peripheral bus speed. */
 	bus_hz = clk_get_rate(as->clk);
-	if (!atmel_spi_is_v2())
+	if (as->data.is_ver2 == 0)
 		bus_hz /= 2;
 
 	if (spi->max_speed_hz) {
@@ -767,7 +1298,9 @@ static int atmel_spi_setup(struct spi_device *spi)
 	csr |= SPI_BF(DLYBCT, 0);
 
 	/* chipselect must have been muxed as GPIO (e.g. in board setup) */
-	npcs_pin = (unsigned int)spi->controller_data;
+	if (!gpio_is_valid(spi->cs_gpio))
+		spi->cs_gpio = (int)spi->controller_data;
+	npcs_pin = spi->cs_gpio;
 	asd = spi->controller_state;
 	if (!asd) {
 		asd = kzalloc(sizeof(struct atmel_spi_device), GFP_KERNEL);
@@ -784,13 +1317,11 @@ static int atmel_spi_setup(struct spi_device *spi)
 		spi->controller_state = asd;
 		gpio_direction_output(npcs_pin, !(spi->mode & SPI_CS_HIGH));
 	} else {
-		unsigned long		flags;
-
-		spin_lock_irqsave(&as->lock, flags);
+		atmel_spi_lock(as);
 		if (as->stay == spi)
 			as->stay = NULL;
 		cs_deactivate(as, spi);
-		spin_unlock_irqrestore(&as->lock, flags);
+		atmel_spi_unlock(as);
 	}
 
 	asd->csr = csr;
@@ -799,7 +1330,7 @@ static int atmel_spi_setup(struct spi_device *spi)
 		"setup: %lu Hz bpw %u mode 0x%x -> csr%d %08x\n",
 		bus_hz / scbr, bits, spi->mode, spi->chip_select, csr);
 
-	if (!atmel_spi_is_v2())
+	if (as->data.is_ver2 == 0)
 		spi_writel(as, CSR0 + 4 * spi->chip_select, csr);
 
 	return 0;
@@ -809,7 +1340,6 @@ static int atmel_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 {
 	struct atmel_spi	*as;
 	struct spi_transfer	*xfer;
-	unsigned long		flags;
 	struct device		*controller = spi->master->dev.parent;
 	u8			bits;
 	struct atmel_spi_device	*asd;
@@ -840,6 +1370,12 @@ static int atmel_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 				return -ENOPROTOOPT;
 			}
 		}
+		if (xfer->bits_per_word > 8) {
+			if (xfer->len % 2) {
+				dev_dbg(&spi->dev, "buffer len should be 16 bits aligned\n");
+				return -EINVAL;
+			}
+		}
 
 		/* FIXME implement these protocol options!! */
 		if (xfer->speed_hz) {
@@ -849,13 +1385,9 @@ static int atmel_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 
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
+		if (!msg->is_dma_mapped && atmel_spi_use_dma(as, xfer)) {
 			if (atmel_spi_dma_map_xfer(as, xfer) < 0)
 				return -ENOMEM;
 		}
@@ -874,11 +1406,11 @@ static int atmel_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 	msg->status = -EINPROGRESS;
 	msg->actual_length = 0;
 
-	spin_lock_irqsave(&as->lock, flags);
+	atmel_spi_lock(as);
 	list_add_tail(&msg->queue, &as->queue);
 	if (!as->current_transfer)
 		atmel_spi_next_message(spi->master);
-	spin_unlock_irqrestore(&as->lock, flags);
+	atmel_spi_unlock(as);
 
 	return 0;
 }
@@ -887,25 +1419,55 @@ static void atmel_spi_cleanup(struct spi_device *spi)
 {
 	struct atmel_spi	*as = spi_master_get_devdata(spi->master);
 	struct atmel_spi_device	*asd = spi->controller_state;
-	unsigned		gpio = (unsigned) spi->controller_data;
-	unsigned long		flags;
+	unsigned		gpio = spi->cs_gpio;
 
 	if (!asd)
 		return;
 
-	spin_lock_irqsave(&as->lock, flags);
+	atmel_spi_lock(as);
 	if (as->stay == spi) {
 		as->stay = NULL;
 		cs_deactivate(as, spi);
 	}
-	spin_unlock_irqrestore(&as->lock, flags);
+	atmel_spi_unlock(as);
 
 	spi->controller_state = NULL;
 	gpio_free(gpio);
 	kfree(asd);
 }
 
-/*-------------------------------------------------------------------------*/
+static int of_get_atmel_spi_data(struct device_node *np, struct atmel_spi *as)
+{
+	const __be32	*val;
+
+	val = of_get_property(np, "has_dma_support", NULL);
+	if (!val) {
+		pr_err("%s: have no 'has_dma_support' property\n",
+						np->full_name);
+		return -EINVAL;
+	}
+
+	as->data.has_dma_support = be32_to_cpup(val);
+
+	val = of_get_property(np, "has_pdc_support", NULL);
+	if (!val) {
+		pr_err("%s: have no 'has_pdc_support' property\n",
+						np->full_name);
+		return -EINVAL;
+	}
+
+	as->data.has_pdc_support = be32_to_cpup(val);
+
+	val = of_get_property(np, "is_ver2", NULL);
+	if (!val) {
+		pr_err("%s: have no 'is_ver2' property\n", np->full_name);
+		return -EINVAL;
+	}
+
+	as->data.is_ver2 = be32_to_cpup(val);
+
+	return 0;
+}
 
 static int __devinit atmel_spi_probe(struct platform_device *pdev)
 {
@@ -938,7 +1500,8 @@ static int __devinit atmel_spi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 
 	master->bus_num = pdev->id;
-	master->num_chipselect = 4;
+	master->dev.of_node = pdev->dev.of_node;
+	master->num_chipselect = master->dev.of_node ? 0 : 4;
 	master->setup = atmel_spi_setup;
 	master->transfer = atmel_spi_transfer;
 	master->cleanup = atmel_spi_cleanup;
@@ -957,10 +1520,13 @@ static int __devinit atmel_spi_probe(struct platform_device *pdev)
 
 	spin_lock_init(&as->lock);
 	INIT_LIST_HEAD(&as->queue);
+	tasklet_init(&as->tasklet, atmel_spi_tasklet_func,
+					(unsigned long)master);
 	as->pdev = pdev;
 	as->regs = ioremap(regs->start, resource_size(regs));
 	if (!as->regs)
 		goto out_free_buffer;
+	as->phybase = regs->start;
 	as->irq = irq;
 	as->clk = clk;
 
@@ -969,12 +1535,22 @@ static int __devinit atmel_spi_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_unmap_regs;
 
+	ret = of_get_atmel_spi_data(pdev->dev.of_node, as);
+	if (ret)
+		goto out_unmap_regs;
+
+	if (as->data.has_dma_support) {
+		if (atmel_spi_configure_dma(as) == 0)
+			as->use_dma = true;
+	} else if (as->data.has_pdc_support)
+		as->use_pdc = true;
+
 	/* Initialize the hardware */
 	clk_enable(clk);
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
 	spi_writel(as, MR, SPI_BIT(MSTR) | SPI_BIT(MODFDIS));
-	spi_writel(as, PTCR, SPI_BIT(RXTDIS) | SPI_BIT(TXTDIS));
+
 	spi_writel(as, CR, SPI_BIT(SPIEN));
 
 	/* go! */
@@ -983,11 +1559,14 @@ static int __devinit atmel_spi_probe(struct platform_device *pdev)
 
 	ret = spi_register_master(master);
 	if (ret)
-		goto out_reset_hw;
+		goto out_free_dma;
 
 	return 0;
 
-out_reset_hw:
+out_free_dma:
+	if (as->use_dma)
+		atmel_spi_release_dma(as);
+
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
 	clk_disable(clk);
@@ -995,6 +1574,7 @@ out_reset_hw:
 out_unmap_regs:
 	iounmap(as->regs);
 out_free_buffer:
+	tasklet_kill(&as->tasklet);
 	dma_free_coherent(&pdev->dev, BUFFER_SIZE, as->buffer,
 			as->buffer_dma);
 out_free:
@@ -1008,10 +1588,16 @@ static int __devexit atmel_spi_remove(struct platform_device *pdev)
 	struct spi_master	*master = platform_get_drvdata(pdev);
 	struct atmel_spi	*as = spi_master_get_devdata(master);
 	struct spi_message	*msg;
+	struct spi_transfer	*xfer;
 
 	/* reset the hardware and block queue progress */
 	spin_lock_irq(&as->lock);
 	as->stopping = 1;
+	if (as->use_dma) {
+		atmel_spi_stop_dma(as);
+		atmel_spi_release_dma(as);
+	}
+
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
 	spi_readl(as, SR);
@@ -1019,13 +1605,15 @@ static int __devexit atmel_spi_remove(struct platform_device *pdev)
 
 	/* Terminate remaining queued transfers */
 	list_for_each_entry(msg, &as->queue, queue) {
-		/* REVISIT unmapping the dma is a NOP on ARM and AVR32
-		 * but we shouldn't depend on that...
-		 */
+		list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+			if (!msg->is_dma_mapped && atmel_spi_use_dma(as, xfer))
+				atmel_spi_dma_unmap_xfer(master, xfer);
+		}
 		msg->status = -ESHUTDOWN;
 		msg->complete(msg->context);
 	}
 
+	tasklet_kill(&as->tasklet);
 	dma_free_coherent(&pdev->dev, BUFFER_SIZE, as->buffer,
 			as->buffer_dma);
 
@@ -1040,7 +1628,6 @@ static int __devexit atmel_spi_remove(struct platform_device *pdev)
 }
 
 #ifdef	CONFIG_PM
-
 static int atmel_spi_suspend(struct platform_device *pdev, pm_message_t mesg)
 {
 	struct spi_master	*master = platform_get_drvdata(pdev);
@@ -1064,11 +1651,19 @@ static int atmel_spi_resume(struct platform_device *pdev)
 #define	atmel_spi_resume	NULL
 #endif
 
+#if defined(CONFIG_OF)
+static const struct of_device_id atmel_spi_dt_ids[] = {
+	{ .compatible = "atmel,at91rm9200-spi" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, atmel_spi_dt_ids);
+#endif
 
 static struct platform_driver atmel_spi_driver = {
 	.driver		= {
 		.name	= "atmel_spi",
 		.owner	= THIS_MODULE,
+		.of_match_table	= of_match_ptr(atmel_spi_dt_ids),
 	},
 	.suspend	= atmel_spi_suspend,
 	.resume		= atmel_spi_resume,
-- 
1.7.9.5
