From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Fri, 29 May 2015 16:56:43 +0200
Subject: [PATCH 2/2] spi: atmel: add support to FIFOs
In-Reply-To: <cover.1432910696.git.cyrille.pitchen@atmel.com>
References: <cover.1432910696.git.cyrille.pitchen@atmel.com>
Message-ID: <84333c96f376684e1f49f8eda54b499a92ade98d.1432910696.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To enable the FIFO feature a "atmel,fifo-size" attribute with a strictly
positive value must be added into the node of the device-tree describing the
spi controller.

When FIFOs are enabled, the RX one is forced to operate in SINGLE data mode
because this driver configures the spi controller as a master. In master mode
only, the Received Data Register has an additionnal Peripheral Chip Select
field, which prevents us from reading more than a single data at each register
access.

Besides, the TX FIFO operates in MULTIPLE data mode. However, even when a 8bit
data size is used, only two data by access could be written into the Transmit
Data Register. Indeed the first data has to be written into the lowest 16 bits
whereas the second data has to be written into the highest 16 bits of the TDR.
When DMA transfers are used to send data, we don't rework the transmit buffer
to cope with this hardware limitation: the additional copies required to
prepare a new input buffer suited to both the DMA controller and the spi
controller would waste all the benefit of the DMA transfer. Instead, the DMA
controller is configured to write only one data at time into the TDR.

In pio mode, two data are written in the TDR in a single access.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/spi/spi-atmel.c | 239 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 229 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index aa7d202..47d04c3 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -41,6 +41,8 @@
 #define SPI_CSR1				0x0034
 #define SPI_CSR2				0x0038
 #define SPI_CSR3				0x003c
+#define SPI_FMR					0x0040
+#define SPI_FLR					0x0044
 #define SPI_VERSION				0x00fc
 #define SPI_RPR					0x0100
 #define SPI_RCR					0x0104
@@ -62,6 +64,14 @@
 #define SPI_SWRST_SIZE				1
 #define SPI_LASTXFER_OFFSET			24
 #define SPI_LASTXFER_SIZE			1
+#define SPI_TXFCLR_OFFSET			16
+#define SPI_TXFCLR_SIZE				1
+#define SPI_RXFCLR_OFFSET			17
+#define SPI_RXFCLR_SIZE				1
+#define SPI_FIFOEN_OFFSET			30
+#define SPI_FIFOEN_SIZE				1
+#define SPI_FIFODIS_OFFSET			31
+#define SPI_FIFODIS_SIZE			1
 
 /* Bitfields in MR */
 #define SPI_MSTR_OFFSET				0
@@ -114,6 +124,22 @@
 #define SPI_TXEMPTY_SIZE			1
 #define SPI_SPIENS_OFFSET			16
 #define SPI_SPIENS_SIZE				1
+#define SPI_TXFEF_OFFSET			24
+#define SPI_TXFEF_SIZE				1
+#define SPI_TXFFF_OFFSET			25
+#define SPI_TXFFF_SIZE				1
+#define SPI_TXFTHF_OFFSET			26
+#define SPI_TXFTHF_SIZE				1
+#define SPI_RXFEF_OFFSET			27
+#define SPI_RXFEF_SIZE				1
+#define SPI_RXFFF_OFFSET			28
+#define SPI_RXFFF_SIZE				1
+#define SPI_RXFTHF_OFFSET			29
+#define SPI_RXFTHF_SIZE				1
+#define SPI_TXFPTEF_OFFSET			30
+#define SPI_TXFPTEF_SIZE			1
+#define SPI_RXFPTEF_OFFSET			31
+#define SPI_RXFPTEF_SIZE			1
 
 /* Bitfields in CSR0 */
 #define SPI_CPOL_OFFSET				0
@@ -157,6 +183,22 @@
 #define SPI_TXTDIS_OFFSET			9
 #define SPI_TXTDIS_SIZE				1
 
+/* Bitfields in FMR */
+#define SPI_TXRDYM_OFFSET			0
+#define SPI_TXRDYM_SIZE				2
+#define SPI_RXRDYM_OFFSET			4
+#define SPI_RXRDYM_SIZE				2
+#define SPI_TXFTHRES_OFFSET			16
+#define SPI_TXFTHRES_SIZE			6
+#define SPI_RXFTHRES_OFFSET			24
+#define SPI_RXFTHRES_SIZE			6
+
+/* Bitfields in FLR */
+#define SPI_TXFL_OFFSET				0
+#define SPI_TXFL_SIZE				6
+#define SPI_RXFL_OFFSET				16
+#define SPI_RXFL_SIZE				6
+
 /* Constants for BITS */
 #define SPI_BITS_8_BPT				0
 #define SPI_BITS_9_BPT				1
@@ -167,6 +209,9 @@
 #define SPI_BITS_14_BPT				6
 #define SPI_BITS_15_BPT				7
 #define SPI_BITS_16_BPT				8
+#define SPI_ONE_DATA				0
+#define SPI_TWO_DATA				1
+#define SPI_FOUR_DATA				2
 
 /* Bit manipulation macros */
 #define SPI_BIT(name) \
@@ -185,11 +230,31 @@
 	__raw_readl((port)->regs + SPI_##reg)
 #define spi_writel(port, reg, value) \
 	__raw_writel((value), (port)->regs + SPI_##reg)
+
+#define spi_readw(port, reg) \
+	__raw_readw((port)->regs + SPI_##reg)
+#define spi_writew(port, reg, value) \
+	__raw_writew((value), (port)->regs + SPI_##reg)
+
+#define spi_readb(port, reg) \
+	__raw_readb((port)->regs + SPI_##reg)
+#define spi_writeb(port, reg, value) \
+	__raw_writeb((value), (port)->regs + SPI_##reg)
 #else
 #define spi_readl(port, reg) \
 	readl_relaxed((port)->regs + SPI_##reg)
 #define spi_writel(port, reg, value) \
 	writel_relaxed((value), (port)->regs + SPI_##reg)
+
+#define spi_readw(port, reg) \
+	readw_relaxed((port)->regs + SPI_##reg)
+#define spi_writew(port, reg, value) \
+	writew_relaxed((value), (port)->regs + SPI_##reg)
+
+#define spi_readb(port, reg) \
+	readb_relaxed((port)->regs + SPI_##reg)
+#define spi_writeb(port, reg, value) \
+	writeb_relaxed((value), (port)->regs + SPI_##reg)
 #endif
 /* use PIO for small transfers, avoiding DMA setup/teardown overhead and
  * cache operations; better heuristics consider wordsize and bitrate.
@@ -252,6 +317,8 @@ struct atmel_spi {
 
 	bool			keep_cs;
 	bool			cs_active;
+
+	u32			fifo_size;
 };
 
 /* Controller-specific per-slave state */
@@ -410,6 +477,20 @@ static int atmel_spi_dma_slave_config(struct atmel_spi *as,
 	slave_config->dst_maxburst = 1;
 	slave_config->device_fc = false;
 
+	/*
+	 * This driver uses fixed peripheral select mode (PS bit set to '0' in
+	 * the Mode Register).
+	 * So according to the datasheet, when FIFOs are available (and
+	 * enabled), the Transmit FIFO operates in Multiple Data Mode.
+	 * In this mode, up to 2 data, not 4, can be written into the Transmit
+	 * Data Register in a single access.
+	 * However, the first data has to be written into the lowest 16 bits and
+	 * the second data into the highest 16 bits of the Transmit
+	 * Data Register. For 8bit data (the most frequent case), it would
+	 * require to rework tx_buf so each data would actualy fit 16 bits.
+	 * So we'd rather write only one data at the time. Then the transmit
+	 * path works the same whether FIFOs are available (and enabled) or not.
+	 */
 	slave_config->direction = DMA_MEM_TO_DEV;
 	if (dmaengine_slave_config(as->dma.chan_tx, slave_config)) {
 		dev_err(&as->pdev->dev,
@@ -417,6 +498,14 @@ static int atmel_spi_dma_slave_config(struct atmel_spi *as,
 		err = -EINVAL;
 	}
 
+	/*
+	 * This driver configures the spi controller for master mode (MSTR bit
+	 * set to '1' in the Mode Register).
+	 * So according to the datasheet, when FIFOs are available (and
+	 * enabled), the Receive FIFO operates in Single Data Mode.
+	 * So the receive path works the same whether FIFOs are available (and
+	 * enabled) or not.
+	 */
 	slave_config->direction = DMA_DEV_TO_MEM;
 	if (dmaengine_slave_config(as->dma.chan_rx, slave_config)) {
 		dev_err(&as->pdev->dev,
@@ -506,10 +595,10 @@ static void dma_callback(void *data)
 }
 
 /*
- * Next transfer using PIO.
+ * Next transfer using PIO without FIFO.
  */
-static void atmel_spi_next_xfer_pio(struct spi_master *master,
-				struct spi_transfer *xfer)
+static void atmel_spi_next_xfer_single(struct spi_master *master,
+				       struct spi_transfer *xfer)
 {
 	struct atmel_spi	*as = spi_master_get_devdata(master);
 	unsigned long xfer_pos = xfer->len - as->current_remaining_bytes;
@@ -542,6 +631,90 @@ static void atmel_spi_next_xfer_pio(struct spi_master *master,
 }
 
 /*
+ * Next transfer using PIO with FIFO.
+ */
+static void atmel_spi_next_xfer_fifo(struct spi_master *master,
+				     struct spi_transfer *xfer)
+{
+	struct atmel_spi *as = spi_master_get_devdata(master);
+	u32 size = min_t(u32, as->current_remaining_bytes, as->fifo_size);
+	u32 offset = xfer->len - as->current_remaining_bytes;
+	const u16 *words = (const u16 *)((u8 *)xfer->tx_buf + offset);
+	const u8  *bytes = (const u8  *)((u8 *)xfer->tx_buf + offset);
+	u16 td0, td1;
+	u32 fifomr;
+
+	dev_vdbg(master->dev.parent, "atmel_spi_next_xfer_fifo\n");
+
+	/* Flush RX and TX FIFOs */
+	spi_writel(as, CR, SPI_BIT(RXFCLR) | SPI_BIT(TXFCLR));
+	while (spi_readl(as, FLR))
+		cpu_relax();
+
+	/* Set RX FIFO Threshold to transfer size */
+	fifomr = spi_readl(as, FMR);
+	spi_writel(as, FMR, SPI_BFINS(RXFTHRES, size, fifomr));
+
+	/* Fill TX FIFO */
+	while (size >= 2) {
+		if (xfer->tx_buf) {
+			if (xfer->bits_per_word > 8) {
+				td0 = *words++;
+				td1 = *words++;
+			} else {
+				td0 = *bytes++;
+				td1 = *bytes++;
+			}
+		} else {
+			td0 = 0;
+			td1 = 0;
+		}
+
+		spi_writel(as, TDR, (td1 << 16) | td0);
+		size -= 2;
+	}
+
+	if (size) {
+		if (xfer->tx_buf) {
+			if (xfer->bits_per_word > 8)
+				td0 = *words++;
+			else
+				td0 = *bytes++;
+		} else {
+			td0 = 0;
+		}
+
+		spi_writew(as, TDR, td0);
+		size--;
+	}
+
+	dev_dbg(master->dev.parent,
+		"  start fifo xfer %p: len %u tx %p rx %p bitpw %d\n",
+		xfer, xfer->len, xfer->tx_buf, xfer->rx_buf,
+		xfer->bits_per_word);
+
+	/*
+	 * Enable RX FIFO Threshold Flag interrupt to be notified about
+	 * transfer completion.
+	 */
+	spi_writel(as, IER, SPI_BIT(RXFTHF) | SPI_BIT(OVRES));
+}
+
+/*
+ * Next transfer using PIO.
+ */
+static void atmel_spi_next_xfer_pio(struct spi_master *master,
+				    struct spi_transfer *xfer)
+{
+	struct atmel_spi *as = spi_master_get_devdata(master);
+
+	if (as->fifo_size)
+		atmel_spi_next_xfer_fifo(master, xfer);
+	else
+		atmel_spi_next_xfer_single(master, xfer);
+}
+
+/*
  * Submit next transfer for DMA.
  */
 static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
@@ -843,13 +1016,8 @@ static void atmel_spi_disable_pdc_transfer(struct atmel_spi *as)
 	spi_writel(as, PTCR, SPI_BIT(RXTDIS) | SPI_BIT(TXTDIS));
 }
 
-/* Called from IRQ
- *
- * Must update "current_remaining_bytes" to keep track of data
- * to transfer.
- */
 static void
-atmel_spi_pump_pio_data(struct atmel_spi *as, struct spi_transfer *xfer)
+atmel_spi_pump_single_data(struct atmel_spi *as, struct spi_transfer *xfer)
 {
 	u8		*rxp;
 	u16		*rxp16;
@@ -876,6 +1044,47 @@ atmel_spi_pump_pio_data(struct atmel_spi *as, struct spi_transfer *xfer)
 	}
 }
 
+static void
+atmel_spi_pump_fifo_data(struct atmel_spi *as, struct spi_transfer *xfer)
+{
+	u32 fifolr = spi_readl(as, FLR);
+	u32 size = SPI_BFEXT(RXFL, fifolr);
+	u32 offset = xfer->len - as->current_remaining_bytes;
+	u16 *words = (u16 *)((u8 *)xfer->rx_buf + offset);
+	u8  *bytes = (u8  *)((u8 *)xfer->rx_buf + offset);
+	u16 rd; /* RD field is the lowest 16 bits of RDR */
+
+	if (xfer->bits_per_word > 8)
+		as->current_remaining_bytes -= 2 * size;
+	else
+		as->current_remaining_bytes -= size;
+
+	while (size) {
+		rd = spi_readl(as, RDR);
+		if (xfer->rx_buf) {
+			if (xfer->bits_per_word > 8)
+				*words++ = rd;
+			else
+				*bytes++ = rd;
+		}
+		size--;
+	}
+}
+
+/* Called from IRQ
+ *
+ * Must update "current_remaining_bytes" to keep track of data
+ * to transfer.
+ */
+static void
+atmel_spi_pump_pio_data(struct atmel_spi *as, struct spi_transfer *xfer)
+{
+	if (as->fifo_size)
+		atmel_spi_pump_fifo_data(as, xfer);
+	else
+		atmel_spi_pump_single_data(as, xfer);
+}
+
 /* Interrupt
  *
  * No need for locking in this Interrupt handler: done_status is the
@@ -916,7 +1125,7 @@ atmel_spi_pio_interrupt(int irq, void *dev_id)
 
 		complete(&as->xfer_completion);
 
-	} else if (pending & SPI_BIT(RDRF)) {
+	} else if (pending & (SPI_BIT(RDRF) | SPI_BIT(RXFTHF))) {
 		atmel_spi_lock(as);
 
 		if (as->current_remaining_bytes) {
@@ -1134,6 +1343,9 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 			break;
 	}
 
+	if (as->fifo_size)
+		spi_writel(as, FMR, 0);
+
 	if (as->done_status) {
 		if (as->use_pdc) {
 			dev_warn(master->dev.parent,
@@ -1399,6 +1611,13 @@ static int atmel_spi_probe(struct platform_device *pdev)
 		spi_writel(as, PTCR, SPI_BIT(RXTDIS) | SPI_BIT(TXTDIS));
 	spi_writel(as, CR, SPI_BIT(SPIEN));
 
+	as->fifo_size = 0;
+	if (!of_property_read_u32(pdev->dev.of_node, "atmel,fifo-size",
+				  &as->fifo_size)) {
+		dev_info(&pdev->dev, "Using FIFO (%u data)\n", as->fifo_size);
+		spi_writel(as, CR, SPI_BIT(FIFOEN));
+	}
+
 	/* go! */
 	dev_info(&pdev->dev, "Atmel SPI Controller at 0x%08lx (irq %d)\n",
 			(unsigned long)regs->start, irq);
-- 
1.8.2.2
