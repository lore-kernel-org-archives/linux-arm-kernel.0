From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Tue, 9 Jun 2015 18:22:19 +0200
Subject: [PATCH v6 6/6] i2c: at91: add support to FIFOs
In-Reply-To: <cover.1433866582.git.cyrille.pitchen@atmel.com>
References: <cover.1433866582.git.cyrille.pitchen@atmel.com>
Message-ID: <bf30618219df1fbca1c07e1aac17efbb5024f3cb.1433866582.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When FIFOs are available and enabled, the driver now configures the Atmel
eXtended DMA Controller to perform word accesses instead of byte accesses
when possible.
The actual access width depends on the size of the buffer to transmit.

To enable FIFO support the "atmel,fifo-size" property must be set properly
in the I2C controller node of the device tree.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/i2c/busses/i2c-at91.c | 147 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 130 insertions(+), 17 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 6e88b30..0d2dc7d 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -54,6 +54,8 @@
 #define	AT91_TWI_THRCLR		BIT(24) /* Transmit Holding Register Clear */
 #define	AT91_TWI_RHRCLR		BIT(25) /* Receive Holding Register Clear */
 #define	AT91_TWI_LOCKCLR	BIT(26) /* Lock Clear */
+#define	AT91_TWI_FIFOEN		BIT(28) /* FIFO Enable */
+#define	AT91_TWI_FIFODIS	BIT(29) /* FIFO Disable */
 
 #define	AT91_TWI_MMR		0x0004	/* Master Mode Register */
 #define	AT91_TWI_IADRSZ_1	0x0100	/* Internal Device Address Size */
@@ -85,6 +87,22 @@
 #define	AT91_TWI_ACR_DATAL(len)	((len) & 0xff)
 #define	AT91_TWI_ACR_DIR	BIT(8)
 
+#define	AT91_TWI_FMR		0x0050	/* FIFO Mode Register */
+#define	AT91_TWI_FMR_TXRDYM(mode)	(((mode) & 0x3) << 0)
+#define	AT91_TWI_FMR_TXRDYM_MASK	(0x3 << 0)
+#define	AT91_TWI_FMR_RXRDYM(mode)	(((mode) & 0x3) << 4)
+#define	AT91_TWI_FMR_RXRDYM_MASK	(0x3 << 4)
+#define	AT91_TWI_ONE_DATA	0x0
+#define	AT91_TWI_TWO_DATA	0x1
+#define	AT91_TWI_FOUR_DATA	0x2
+
+#define	AT91_TWI_FLR		0x0054	/* FIFO Level Register */
+
+#define	AT91_TWI_FSR		0x0060	/* FIFO Status Register */
+#define	AT91_TWI_FIER		0x0064	/* FIFO Interrupt Enable Register */
+#define	AT91_TWI_FIDR		0x0068	/* FIFO Interrupt Disable Register */
+#define	AT91_TWI_FIMR		0x006c	/* FIFO Interrupt Mask Register */
+
 #define	AT91_TWI_VER		0x00fc	/* Version Register */
 
 struct at91_twi_pdata {
@@ -98,7 +116,7 @@ struct at91_twi_pdata {
 struct at91_twi_dma {
 	struct dma_chan *chan_rx;
 	struct dma_chan *chan_tx;
-	struct scatterlist sg;
+	struct scatterlist sg[2];
 	struct dma_async_tx_descriptor *data_desc;
 	enum dma_data_direction direction;
 	bool buf_mapped;
@@ -121,6 +139,7 @@ struct at91_twi_dev {
 	struct at91_twi_pdata *pdata;
 	bool use_dma;
 	bool recv_len_abort;
+	u32 fifo_size;
 	struct at91_twi_dma dma;
 };
 
@@ -154,6 +173,9 @@ static void at91_init_twi_bus(struct at91_twi_dev *dev)
 {
 	at91_disable_twi_interrupts(dev);
 	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_SWRST);
+	/* FIFO should be enabled immediately after the software reset */
+	if (dev->fifo_size)
+		at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_FIFOEN);
 	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_MSEN);
 	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_SVDIS);
 	at91_twi_write(dev, AT91_TWI_CWGR, dev->twi_cwgr_reg);
@@ -200,7 +222,7 @@ static void at91_twi_dma_cleanup(struct at91_twi_dev *dev)
 		dma->xfer_in_progress = false;
 	}
 	if (dma->buf_mapped) {
-		dma_unmap_single(dev->dev, sg_dma_address(&dma->sg),
+		dma_unmap_single(dev->dev, sg_dma_address(&dma->sg[0]),
 				 dev->buf_len, dma->direction);
 		dma->buf_mapped = false;
 	}
@@ -213,7 +235,8 @@ static void at91_twi_write_next_byte(struct at91_twi_dev *dev)
 	if (dev->buf_len <= 0)
 		return;
 
-	at91_twi_write(dev, AT91_TWI_THR, *dev->buf);
+	/* 8bit write works with and without FIFO */
+	writeb_relaxed(*dev->buf, dev->base + AT91_TWI_THR);
 
 	/* send stop when last byte has been written */
 	if (--dev->buf_len == 0)
@@ -229,7 +252,7 @@ static void at91_twi_write_data_dma_callback(void *data)
 {
 	struct at91_twi_dev *dev = (struct at91_twi_dev *)data;
 
-	dma_unmap_single(dev->dev, sg_dma_address(&dev->dma.sg),
+	dma_unmap_single(dev->dev, sg_dma_address(&dev->dma.sg[0]),
 			 dev->buf_len, DMA_TO_DEVICE);
 
 	/*
@@ -250,6 +273,7 @@ static void at91_twi_write_data_dma(struct at91_twi_dev *dev)
 	struct dma_async_tx_descriptor *txdesc;
 	struct at91_twi_dma *dma = &dev->dma;
 	struct dma_chan *chan_tx = dma->chan_tx;
+	unsigned int sg_len = 1;
 
 	if (dev->buf_len <= 0)
 		return;
@@ -265,10 +289,43 @@ static void at91_twi_write_data_dma(struct at91_twi_dev *dev)
 	}
 	dma->buf_mapped = true;
 	at91_twi_irq_restore(dev);
-	sg_dma_len(&dma->sg) = dev->buf_len;
-	sg_dma_address(&dma->sg) = dma_addr;
 
-	txdesc = dmaengine_prep_slave_sg(chan_tx, &dma->sg, 1, DMA_MEM_TO_DEV,
+	if (dev->fifo_size) {
+		size_t part1_len, part2_len;
+		struct scatterlist *sg;
+		unsigned fifo_mr;
+
+		sg_len = 0;
+
+		part1_len = dev->buf_len & ~0x3;
+		if (part1_len) {
+			sg = &dma->sg[sg_len++];
+			sg_dma_len(sg) = part1_len;
+			sg_dma_address(sg) = dma_addr;
+		}
+
+		part2_len = dev->buf_len & 0x3;
+		if (part2_len) {
+			sg = &dma->sg[sg_len++];
+			sg_dma_len(sg) = part2_len;
+			sg_dma_address(sg) = dma_addr + part1_len;
+		}
+
+		/*
+		 * DMA controller is triggered when at least 4 data can be
+		 * written into the TX FIFO
+		 */
+		fifo_mr = at91_twi_read(dev, AT91_TWI_FMR);
+		fifo_mr &= ~AT91_TWI_FMR_TXRDYM_MASK;
+		fifo_mr |= AT91_TWI_FMR_TXRDYM(AT91_TWI_FOUR_DATA);
+		at91_twi_write(dev, AT91_TWI_FMR, fifo_mr);
+	} else {
+		sg_dma_len(&dma->sg[0]) = dev->buf_len;
+		sg_dma_address(&dma->sg[0]) = dma_addr;
+	}
+
+	txdesc = dmaengine_prep_slave_sg(chan_tx, dma->sg, sg_len,
+					 DMA_MEM_TO_DEV,
 					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!txdesc) {
 		dev_err(dev->dev, "dma prep slave sg failed\n");
@@ -293,7 +350,8 @@ static void at91_twi_read_next_byte(struct at91_twi_dev *dev)
 	if (dev->buf_len <= 0)
 		return;
 
-	*dev->buf = at91_twi_read(dev, AT91_TWI_RHR) & 0xff;
+	/* 8bit read works with and without FIFO */
+	*dev->buf = readb_relaxed(dev->base + AT91_TWI_RHR);
 	--dev->buf_len;
 
 	/* return if aborting, we only needed to read RHR to clear RXRDY*/
@@ -330,7 +388,7 @@ static void at91_twi_read_data_dma_callback(void *data)
 	struct at91_twi_dev *dev = (struct at91_twi_dev *)data;
 	unsigned ier = AT91_TWI_TXCOMP;
 
-	dma_unmap_single(dev->dev, sg_dma_address(&dev->dma.sg),
+	dma_unmap_single(dev->dev, sg_dma_address(&dev->dma.sg[0]),
 			 dev->buf_len, DMA_FROM_DEVICE);
 
 	if (!dev->pdata->has_alt_cmd) {
@@ -362,10 +420,24 @@ static void at91_twi_read_data_dma(struct at91_twi_dev *dev)
 	}
 	dma->buf_mapped = true;
 	at91_twi_irq_restore(dev);
-	dma->sg.dma_address = dma_addr;
-	sg_dma_len(&dma->sg) = buf_len;
 
-	rxdesc = dmaengine_prep_slave_sg(chan_rx, &dma->sg, 1, DMA_DEV_TO_MEM,
+	if (dev->fifo_size && IS_ALIGNED(buf_len, 4)) {
+		unsigned fifo_mr;
+
+		/*
+		 * DMA controller is triggered when at least 4 data can be
+		 * read from the RX FIFO
+		 */
+		fifo_mr = at91_twi_read(dev, AT91_TWI_FMR);
+		fifo_mr &= ~AT91_TWI_FMR_RXRDYM_MASK;
+		fifo_mr |= AT91_TWI_FMR_RXRDYM(AT91_TWI_FOUR_DATA);
+		at91_twi_write(dev, AT91_TWI_FMR, fifo_mr);
+	}
+
+	sg_dma_len(&dma->sg[0]) = buf_len;
+	sg_dma_address(&dma->sg[0]) = dma_addr;
+
+	rxdesc = dmaengine_prep_slave_sg(chan_rx, dma->sg, 1, DMA_DEV_TO_MEM,
 					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!rxdesc) {
 		dev_err(dev->dev, "dma prep slave sg failed\n");
@@ -465,6 +537,21 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
 	reinit_completion(&dev->cmd_complete);
 	dev->transfer_status = 0;
 
+	if (dev->fifo_size) {
+		unsigned fifo_mr = at91_twi_read(dev, AT91_TWI_FMR);
+
+		/* Reset FIFO mode register */
+		fifo_mr &= ~(AT91_TWI_FMR_TXRDYM_MASK |
+			     AT91_TWI_FMR_RXRDYM_MASK);
+		fifo_mr |= AT91_TWI_FMR_TXRDYM(AT91_TWI_ONE_DATA);
+		fifo_mr |= AT91_TWI_FMR_RXRDYM(AT91_TWI_ONE_DATA);
+		at91_twi_write(dev, AT91_TWI_FMR, fifo_mr);
+
+		/* Flush FIFOs */
+		at91_twi_write(dev, AT91_TWI_CR,
+			       AT91_TWI_THRCLR | AT91_TWI_RHRCLR);
+	}
+
 	if (!dev->buf_len) {
 		at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_QUICK);
 		at91_twi_write(dev, AT91_TWI_IER, AT91_TWI_TXCOMP);
@@ -536,7 +623,8 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
 		ret = -EIO;
 		goto error;
 	}
-	if (has_alt_cmd && (dev->transfer_status & AT91_TWI_LOCK)) {
+	if ((has_alt_cmd || dev->fifo_size) &&
+	    (dev->transfer_status & AT91_TWI_LOCK)) {
 		dev_err(dev->dev, "tx locked\n");
 		ret = -EIO;
 		goto error;
@@ -555,7 +643,8 @@ error:
 	/* first stop DMA transfer if still in progress */
 	at91_twi_dma_cleanup(dev);
 	/* then flush THR/FIFO and unlock TX if locked */
-	if (has_alt_cmd && (dev->transfer_status & AT91_TWI_LOCK)) {
+	if ((has_alt_cmd || dev->fifo_size) &&
+	    (dev->transfer_status & AT91_TWI_LOCK)) {
 		dev_dbg(dev->dev, "unlock tx\n");
 		at91_twi_write(dev, AT91_TWI_CR,
 			       AT91_TWI_THRCLR | AT91_TWI_LOCKCLR);
@@ -750,13 +839,32 @@ static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
 	int ret = 0;
 	struct dma_slave_config slave_config;
 	struct at91_twi_dma *dma = &dev->dma;
+	enum dma_slave_buswidth addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+
+	/*
+	 * The actual width of the access will be chosen in
+	 * dmaengine_prep_slave_sg():
+	 * for each buffer in the scatter-gather list, if its size is aligned
+	 * to addr_width then addr_width accesses will be performed to transfer
+	 * the buffer. On the other hand, if the buffer size is not aligned to
+	 * addr_width then the buffer is transferred using single byte accesses.
+	 * Please refer to the Atmel eXtended DMA controller driver.
+	 * When FIFOs are used, the TXRDYM threshold can always be set to
+	 * trigger the XDMAC when at least 4 data can be written into the TX
+	 * FIFO, even if single byte accesses are performed.
+	 * However the RXRDYM threshold must be set to fit the access width,
+	 * deduced from buffer length, so the XDMAC is triggered properly to
+	 * read data from the RX FIFO.
+	 */
+	if (dev->fifo_size)
+		addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
 	memset(&slave_config, 0, sizeof(slave_config));
 	slave_config.src_addr = (dma_addr_t)phy_addr + AT91_TWI_RHR;
-	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	slave_config.src_addr_width = addr_width;
 	slave_config.src_maxburst = 1;
 	slave_config.dst_addr = (dma_addr_t)phy_addr + AT91_TWI_THR;
-	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	slave_config.dst_addr_width = addr_width;
 	slave_config.dst_maxburst = 1;
 	slave_config.device_fc = false;
 
@@ -788,7 +896,7 @@ static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
 		goto error;
 	}
 
-	sg_init_table(&dma->sg, 1);
+	sg_init_table(dma->sg, 2);
 	dma->buf_mapped = false;
 	dma->xfer_in_progress = false;
 	dev->use_dma = true;
@@ -874,6 +982,11 @@ static int at91_twi_probe(struct platform_device *pdev)
 			return rc;
 	}
 
+	if (!of_property_read_u32(pdev->dev.of_node, "atmel,fifo-size",
+				  &dev->fifo_size)) {
+		dev_info(dev->dev, "Using FIFO (%u data)\n", dev->fifo_size);
+	}
+
 	rc = of_property_read_u32(dev->dev->of_node, "clock-frequency",
 			&bus_clk_rate);
 	if (rc)
-- 
1.8.2.2
