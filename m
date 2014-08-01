From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 1 Aug 2014 19:40:33 +0300
Subject: [PATCH v2 2/2] spi: davinci: use spi_device.cs_gpio to store gpio cs
 per spi device
In-Reply-To: <1406911233-18999-1-git-send-email-grygorii.strashko@ti.com>
References: <1406911233-18999-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1406911233-18999-3-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rework Davinci SPI driver to store GPIO CS number in cs_gpio field
of SPI device structure (spi_device) for both DT and non-DT cases.
This will make Davinci SPI driver code simpler and allows to reuse
more SPI core functionality.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/spi/spi-davinci.c |   54 ++++++++++++++-------------------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index ac4414e0..276a388 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -208,9 +208,7 @@ static inline void clear_io_bits(void __iomem *addr, u32 bits)
 static void davinci_spi_chipselect(struct spi_device *spi, int value)
 {
 	struct davinci_spi *dspi;
-	struct device_node *np = spi->dev.of_node;
 	struct davinci_spi_platform_data *pdata;
-	struct spi_master *master = spi->master;
 	u8 chip_sel = spi->chip_select;
 	u16 spidat1 = CS_DEFAULT;
 	bool gpio_chipsel = false;
@@ -219,16 +217,10 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 	dspi = spi_master_get_devdata(spi->master);
 	pdata = &dspi->pdata;
 
-	if (np && master->cs_gpios != NULL && spi->cs_gpio >= 0) {
+	if (spi->cs_gpio >= 0) {
 		/* SPI core parse and update master->cs_gpio */
 		gpio_chipsel = true;
 		gpio = spi->cs_gpio;
-	} else if (pdata->chip_sel &&
-		   chip_sel < pdata->num_chipselect &&
-		   pdata->chip_sel[chip_sel] != SPI_INTERN_CS) {
-		/* platform data defines chip_sel */
-		gpio_chipsel = true;
-		gpio = pdata->chip_sel[chip_sel];
 	}
 
 	/*
@@ -237,9 +229,9 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 	 */
 	if (gpio_chipsel) {
 		if (value == BITBANG_CS_ACTIVE)
-			gpio_set_value(gpio, 0);
+			gpio_set_value(gpio, spi->mode & SPI_CS_HIGH);
 		else
-			gpio_set_value(gpio, 1);
+			gpio_set_value(gpio, !(spi->mode & SPI_CS_HIGH));
 	} else {
 		if (value == BITBANG_CS_ACTIVE) {
 			spidat1 |= SPIDAT1_CSHOLD_MASK;
@@ -405,35 +397,34 @@ static int davinci_spi_setup(struct spi_device *spi)
 	struct spi_master *master = spi->master;
 	struct device_node *np = spi->dev.of_node;
 	bool internal_cs = true;
+	unsigned long flags = GPIOF_DIR_OUT;
 
 	dspi = spi_master_get_devdata(spi->master);
 	pdata = &dspi->pdata;
 
+	flags |= (spi->mode & SPI_CS_HIGH) ? GPIOF_INIT_LOW : GPIOF_INIT_HIGH;
+
 	if (!(spi->mode & SPI_NO_CS)) {
 		if (np && (master->cs_gpios != NULL) && (spi->cs_gpio >= 0)) {
-			unsigned long flags;
-
-			flags = GPIOF_DIR_OUT;
-			if (spi->mode & SPI_CS_HIGH)
-				flags |= GPIOF_INIT_LOW;
-			else
-				flags |= GPIOF_INIT_HIGH;
 			retval = gpio_request_one(spi->cs_gpio,
 						  flags, dev_name(&spi->dev));
-			if (retval) {
-				dev_err(&spi->dev,
-					"GPIO %d request failed (%d)\n",
-					spi->cs_gpio, retval);
-				return retval;
-			}
 			internal_cs = false;
 		} else if (pdata->chip_sel &&
 			   spi->chip_select < pdata->num_chipselect &&
 			   pdata->chip_sel[spi->chip_select] != SPI_INTERN_CS) {
+			spi->cs_gpio = pdata->chip_sel[spi->chip_select];
+			retval = gpio_request_one(spi->cs_gpio,
+						  flags, dev_name(&spi->dev));
 			internal_cs = false;
 		}
 	}
 
+	if (retval) {
+		dev_err(&spi->dev, "GPIO %d setup failed (%d)\n",
+			spi->cs_gpio, retval);
+		return retval;
+	}
+
 	if (internal_cs)
 		set_io_bits(dspi->base + SPIPC0, 1 << spi->chip_select);
 
@@ -450,10 +441,7 @@ static int davinci_spi_setup(struct spi_device *spi)
 
 static void davinci_spi_cleanup(struct spi_device *spi)
 {
-	struct spi_master *master = spi->master;
-	struct device_node *np = spi->dev.of_node;
-
-	if (np && (master->cs_gpios != NULL) && (spi->cs_gpio >= 0))
+	if (spi->cs_gpio >= 0)
 		gpio_free(spi->cs_gpio);
 }
 
@@ -895,7 +883,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	struct resource *r;
 	resource_size_t dma_rx_chan = SPI_NO_RESOURCE;
 	resource_size_t	dma_tx_chan = SPI_NO_RESOURCE;
-	int i = 0, ret = 0;
+	int ret = 0;
 	u32 spipc0;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct davinci_spi));
@@ -1016,14 +1004,6 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	spipc0 = SPIPC0_DIFUN_MASK | SPIPC0_DOFUN_MASK | SPIPC0_CLKFUN_MASK;
 	iowrite32(spipc0, dspi->base + SPIPC0);
 
-	/* initialize chip selects */
-	if (pdata->chip_sel) {
-		for (i = 0; i < pdata->num_chipselect; i++) {
-			if (pdata->chip_sel[i] != SPI_INTERN_CS)
-				gpio_direction_output(pdata->chip_sel[i], 1);
-		}
-	}
-
 	if (pdata->intr_line)
 		iowrite32(SPI_INTLVL_1, dspi->base + SPILVL);
 	else
-- 
1.7.9.5
