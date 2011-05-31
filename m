From: chris@techworks.ie (Christian Gagneraud)
Date: Tue, 31 May 2011 17:04:21 +0100
Subject: [PATCH RFC 1/3] AT91: SPI: Add CS decode support
In-Reply-To: <1306857863-13424-1-git-send-email-chris@techworks.ie>
References: <1306857863-13424-1-git-send-email-chris@techworks.ie>
Message-ID: <1306857863-13424-2-git-send-email-chris@techworks.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With CS decode, up to 15 Chip Select signals can be generated with the
four lines using an external 4- to 16-bit decoder.

Signed-off-by: Christian Gagneraud <chris@techworks.ie>
---
 drivers/spi/atmel_spi.c |  137 +++++++++++++++++++++++++++++++---------------
 1 files changed, 92 insertions(+), 45 deletions(-)

diff --git a/drivers/spi/atmel_spi.c b/drivers/spi/atmel_spi.c
index 08711e9..df0dec9 100644
--- a/drivers/spi/atmel_spi.c
+++ b/drivers/spi/atmel_spi.c
@@ -50,12 +50,8 @@ struct atmel_spi {
 
 	void			*buffer;
 	dma_addr_t		buffer_dma;
-};
 
-/* Controller-specific per-slave state */
-struct atmel_spi_device {
-	unsigned int		npcs_pin;
-	u32			csr;
+	struct atmel_spi_data	*board_data;
 };
 
 #define BUFFER_SIZE		PAGE_SIZE
@@ -105,25 +101,34 @@ static bool atmel_spi_is_v2(void)
 
 static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 {
-	struct atmel_spi_device *asd = spi->controller_state;
+	u32 csr;
 	unsigned active = spi->mode & SPI_CS_HIGH;
 	u32 mr;
+	int i;
+	unsigned cs_decoding = as->board_data->flags & ATMEL_SPI_CS_DEC;
 
 	if (atmel_spi_is_v2()) {
+		csr = (u32)spi->controller_state;
 		/*
 		 * Always use CSR0. This ensures that the clock
 		 * switches to the correct idle polarity before we
 		 * toggle the CS.
 		 */
-		spi_writel(as, CSR0, asd->csr);
+		spi_writel(as, CSR0, csr);
 		spi_writel(as, MR, SPI_BF(PCS, 0x0e) | SPI_BIT(MODFDIS)
 				| SPI_BIT(MSTR));
 		mr = spi_readl(as, MR);
-		gpio_set_value(asd->npcs_pin, active);
+		if (cs_decoding) {
+			for (i = 0; i < as->board_data->num_cs_pin; i++) {
+				unsigned gpio = as->board_data->cs_pins[i].gpio;
+				unsigned val = 1  & (spi->chip_select>>i);
+				gpio_set_value(gpio, val);
+			}
+		} else
+			gpio_set_value(as->board_data->cs_pins[spi->chip_select].gpio,
+				       active);
 	} else {
 		u32 cpol = (spi->mode & SPI_CPOL) ? SPI_BIT(CPOL) : 0;
-		int i;
-		u32 csr;
 
 		/* Make sure clock polarity is correct */
 		for (i = 0; i < spi->master->num_chipselect; i++) {
@@ -136,36 +141,43 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 		mr = spi_readl(as, MR);
 		mr = SPI_BFINS(PCS, ~(1 << spi->chip_select), mr);
 		if (spi->chip_select != 0)
-			gpio_set_value(asd->npcs_pin, active);
+			gpio_set_value(as->board_data->cs_pins[spi->chip_select].gpio, active);
 		spi_writel(as, MR, mr);
 	}
 
 	dev_dbg(&spi->dev, "activate %u%s, mr %08x\n",
-			asd->npcs_pin, active ? " (high)" : "",
+			spi->chip_select, active ? " (high)" : "",
 			mr);
 }
 
 static void cs_deactivate(struct atmel_spi *as, struct spi_device *spi)
 {
-	struct atmel_spi_device *asd = spi->controller_state;
 	unsigned active = spi->mode & SPI_CS_HIGH;
 	u32 mr;
+	unsigned cs_decoding = as->board_data->flags & ATMEL_SPI_CS_DEC;
+	int i;
 
 	/* only deactivate *this* device; sometimes transfers to
 	 * another device may be active when this routine is called.
 	 */
 	mr = spi_readl(as, MR);
-	if (~SPI_BFEXT(PCS, mr) & (1 << spi->chip_select)) {
+	if ((!cs_decoding && (~SPI_BFEXT(PCS, mr) & (1 << spi->chip_select))) ||
+	    (cs_decoding && (~SPI_BFEXT(PCS, mr) & spi->chip_select))) {
 		mr = SPI_BFINS(PCS, 0xf, mr);
 		spi_writel(as, MR, mr);
 	}
 
 	dev_dbg(&spi->dev, "DEactivate %u%s, mr %08x\n",
-			asd->npcs_pin, active ? " (low)" : "",
+			spi->chip_select, active ? " (low)" : "",
 			mr);
 
-	if (atmel_spi_is_v2() || spi->chip_select != 0)
-		gpio_set_value(asd->npcs_pin, !active);
+	if (atmel_spi_is_v2() || spi->chip_select != 0) {
+		if (cs_decoding) {
+			for (i = 0; i < as->board_data->num_cs_pin; i++)
+				gpio_set_value(as->board_data->cs_pins[i].gpio, 1);
+		} else
+			gpio_set_value(as->board_data->cs_pins[spi->chip_select].gpio, !active);
+	}
 }
 
 static inline int atmel_spi_xfer_is_last(struct spi_message *msg,
@@ -538,14 +550,14 @@ atmel_spi_interrupt(int irq, void *dev_id)
 static int atmel_spi_setup(struct spi_device *spi)
 {
 	struct atmel_spi	*as;
-	struct atmel_spi_device	*asd;
 	u32			scbr, csr;
 	unsigned int		bits = spi->bits_per_word;
 	unsigned long		bus_hz;
-	unsigned int		npcs_pin;
 	int			ret;
+	unsigned		cs_decoding;
 
 	as = spi_master_get_devdata(spi->master);
+	cs_decoding = as->board_data->flags & ATMEL_SPI_CS_DEC;
 
 	if (as->stopping)
 		return -ESHUTDOWN;
@@ -571,6 +583,15 @@ static int atmel_spi_setup(struct spi_device *spi)
 		dev_dbg(&spi->dev, "setup: can't be active-high\n");
 		return -EINVAL;
 	}
+	if (cs_decoding && (spi->mode & SPI_CS_HIGH)) {
+		dev_dbg(&spi->dev, "setup: can't be active-high while using CS decoding\n");
+		return -EINVAL;
+	}
+	if (cs_decoding && !atmel_spi_is_v2()) {
+		dev_dbg(&spi->dev, "setup: CS decoding not supported on this controller\n");
+		return -EINVAL;
+	}
+
 
 	/* v1 chips start out at half the peripheral bus speed. */
 	bus_hz = clk_get_rate(as->clk);
@@ -614,22 +635,15 @@ static int atmel_spi_setup(struct spi_device *spi)
 	csr |= SPI_BF(DLYBCT, 0);
 
 	/* chipselect must have been muxed as GPIO (e.g. in board setup) */
-	npcs_pin = (unsigned int)spi->controller_data;
-	asd = spi->controller_state;
-	if (!asd) {
-		asd = kzalloc(sizeof(struct atmel_spi_device), GFP_KERNEL);
-		if (!asd)
-			return -ENOMEM;
-
-		ret = gpio_request(npcs_pin, dev_name(&spi->dev));
-		if (ret) {
-			kfree(asd);
-			return ret;
+	if (!spi->controller_state) {
+		/* Request the GPIO only if not using CS decoding */
+		if (!cs_decoding) {
+			u32 gpio = as->board_data->cs_pins[spi->chip_select].gpio;
+			ret = gpio_request(gpio, dev_name(&spi->dev));
+			if (ret)
+				return ret;
+			gpio_direction_output(gpio, !(spi->mode & SPI_CS_HIGH));
 		}
-
-		asd->npcs_pin = npcs_pin;
-		spi->controller_state = asd;
-		gpio_direction_output(npcs_pin, !(spi->mode & SPI_CS_HIGH));
 	} else {
 		unsigned long		flags;
 
@@ -640,7 +654,7 @@ static int atmel_spi_setup(struct spi_device *spi)
 		spin_unlock_irqrestore(&as->lock, flags);
 	}
 
-	asd->csr = csr;
+	spi->controller_state = (void *)csr;
 
 	dev_dbg(&spi->dev,
 		"setup: %lu Hz bpw %u mode 0x%x -> csr%d %08x\n",
@@ -659,7 +673,7 @@ static int atmel_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 	unsigned long		flags;
 	struct device		*controller = spi->master->dev.parent;
 	u8			bits;
-	struct atmel_spi_device	*asd;
+	u32			csr = (u32)spi->controller_state;
 
 	as = spi_master_get_devdata(spi->master);
 
@@ -679,8 +693,7 @@ static int atmel_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 		}
 
 		if (xfer->bits_per_word) {
-			asd = spi->controller_state;
-			bits = (asd->csr >> 4) & 0xf;
+			bits = (csr >> 4) & 0xf;
 			if (bits != xfer->bits_per_word - 8) {
 				dev_dbg(&spi->dev, "you can't yet change "
 					 "bits_per_word in transfers\n");
@@ -733,11 +746,9 @@ static int atmel_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 static void atmel_spi_cleanup(struct spi_device *spi)
 {
 	struct atmel_spi	*as = spi_master_get_devdata(spi->master);
-	struct atmel_spi_device	*asd = spi->controller_state;
-	unsigned		gpio = (unsigned) spi->controller_data;
 	unsigned long		flags;
 
-	if (!asd)
+	if (!spi->controller_state)
 		return;
 
 	spin_lock_irqsave(&as->lock, flags);
@@ -748,8 +759,6 @@ static void atmel_spi_cleanup(struct spi_device *spi)
 	spin_unlock_irqrestore(&as->lock, flags);
 
 	spi->controller_state = NULL;
-	gpio_free(gpio);
-	kfree(asd);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -762,6 +771,8 @@ static int __init atmel_spi_probe(struct platform_device *pdev)
 	int			ret;
 	struct spi_master	*master;
 	struct atmel_spi	*as;
+	struct atmel_spi_data	*board_data;
+	int			i;
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs)
@@ -784,8 +795,19 @@ static int __init atmel_spi_probe(struct platform_device *pdev)
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 
+	/* Get board specific data */
+	ret = -EINVAL;
+	board_data = platform_get_drvdata(pdev);
+	if (!board_data)
+		goto out_free;
+
 	master->bus_num = pdev->id;
-	master->num_chipselect = 4;
+	if (board_data->flags & ATMEL_SPI_CS_DEC) {
+		master->num_chipselect = (0x01 << board_data->num_cs_pin) - 1;
+		dev_dbg(&pdev->dev, "Chip select decoding enabled (%d:%d)\n",
+			board_data->num_cs_pin, 0x01 << board_data->num_cs_pin);
+	} else
+		master->num_chipselect = board_data->num_cs_pin;
 	master->setup = atmel_spi_setup;
 	master->transfer = atmel_spi_transfer;
 	master->cleanup = atmel_spi_cleanup;
@@ -793,6 +815,23 @@ static int __init atmel_spi_probe(struct platform_device *pdev)
 
 	as = spi_master_get_devdata(master);
 
+	/* Keep revelant board info in our structure */
+	as->board_data = board_data;
+
+	/* Request and init the CS pins here only when using CS
+	 * decoding. When not using CS decoding this is done on a per
+	 * SPI device basis (see atmel_spi_setup()).
+	*/
+	if (board_data->flags & ATMEL_SPI_CS_DEC) {
+		ret = gpio_request_array(board_data->cs_pins,
+					 board_data->num_cs_pin);
+		if (ret != 0)
+			goto out_free;
+		/* CS decoding is always active low */
+		for (i = 0; i < board_data->num_cs_pin; i++)
+			gpio_direction_output(board_data->cs_pins[i].gpio, 1);
+	}
+
 	/*
 	 * Scratch buffer is used for throwaway rx and tx data.
 	 * It's coherent to minimize dcache pollution.
@@ -800,7 +839,7 @@ static int __init atmel_spi_probe(struct platform_device *pdev)
 	as->buffer = dma_alloc_coherent(&pdev->dev, BUFFER_SIZE,
 					&as->buffer_dma, GFP_KERNEL);
 	if (!as->buffer)
-		goto out_free;
+		goto out_free_pins;
 
 	spin_lock_init(&as->lock);
 	INIT_LIST_HEAD(&as->queue);
@@ -823,6 +862,8 @@ static int __init atmel_spi_probe(struct platform_device *pdev)
 	spi_writel(as, MR, SPI_BIT(MSTR) | SPI_BIT(MODFDIS));
 	spi_writel(as, PTCR, SPI_BIT(RXTDIS) | SPI_BIT(TXTDIS));
 	spi_writel(as, CR, SPI_BIT(SPIEN));
+	if (as->board_data->flags & ATMEL_SPI_CS_DEC)
+		spi_writel(as, MR, SPI_BIT(PCSDEC));
 
 	/* go! */
 	dev_info(&pdev->dev, "Atmel SPI Controller at 0x%08lx (irq %d)\n",
@@ -844,6 +885,9 @@ out_unmap_regs:
 out_free_buffer:
 	dma_free_coherent(&pdev->dev, BUFFER_SIZE, as->buffer,
 			as->buffer_dma);
+out_free_pins:
+	if (board_data->flags & ATMEL_SPI_CS_DEC)
+		gpio_free_array(board_data->cs_pins, board_data->num_cs_pin);
 out_free:
 	clk_put(clk);
 	spi_master_put(master);
@@ -876,6 +920,9 @@ static int __exit atmel_spi_remove(struct platform_device *pdev)
 	dma_free_coherent(&pdev->dev, BUFFER_SIZE, as->buffer,
 			as->buffer_dma);
 
+	if (as->board_data->flags & ATMEL_SPI_CS_DEC)
+		gpio_free_array(as->board_data->cs_pins,
+				as->board_data->num_cs_pin);
 	clk_disable(as->clk);
 	clk_put(as->clk);
 	free_irq(as->irq, master);
-- 
1.7.4.1
