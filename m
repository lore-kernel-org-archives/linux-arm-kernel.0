From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 12 Sep 2014 17:54:00 +0300
Subject: [PATCH] spi: davinci: request cs_gpio's from probe
Message-ID: <1410533640-21469-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now CS GPIOs are requested from struct spi_master.setup() callback
and that causes failures when Client SPI device is getting accessed
through SPIDEV driver. The failure happens, because .setup() callback
may be called many times from IOCTL handler and when it's called
second time gpio_request() will fail and return -EBUSY.

Hence, fix it by moving CS GPIOs requesting code in .probe().

Reported-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
Tested using spidev_test utility.

 drivers/spi/spi-davinci.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 48f1d26..d493507 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -397,24 +397,21 @@ static int davinci_spi_setup(struct spi_device *spi)
 	struct spi_master *master = spi->master;
 	struct device_node *np = spi->dev.of_node;
 	bool internal_cs = true;
-	unsigned long flags = GPIOF_DIR_OUT;
 
 	dspi = spi_master_get_devdata(spi->master);
 	pdata = &dspi->pdata;
 
-	flags |= (spi->mode & SPI_CS_HIGH) ? GPIOF_INIT_LOW : GPIOF_INIT_HIGH;
-
 	if (!(spi->mode & SPI_NO_CS)) {
 		if (np && (master->cs_gpios != NULL) && (spi->cs_gpio >= 0)) {
-			retval = gpio_request_one(spi->cs_gpio,
-						  flags, dev_name(&spi->dev));
+			retval = gpio_direction_output(
+				      spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
 			internal_cs = false;
 		} else if (pdata->chip_sel &&
 			   spi->chip_select < pdata->num_chipselect &&
 			   pdata->chip_sel[spi->chip_select] != SPI_INTERN_CS) {
 			spi->cs_gpio = pdata->chip_sel[spi->chip_select];
-			retval = gpio_request_one(spi->cs_gpio,
-						  flags, dev_name(&spi->dev));
+			retval = gpio_direction_output(
+				      spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
 			internal_cs = false;
 		}
 
@@ -441,8 +438,6 @@ static int davinci_spi_setup(struct spi_device *spi)
 
 static void davinci_spi_cleanup(struct spi_device *spi)
 {
-	if (spi->cs_gpio >= 0)
-		gpio_free(spi->cs_gpio);
 }
 
 static int davinci_spi_check_error(struct davinci_spi *dspi, int int_status)
@@ -967,6 +962,27 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	if (dspi->version == SPI_VERSION_2)
 		dspi->bitbang.flags |= SPI_READY;
 
+	if (pdev->dev.of_node) {
+		int i;
+
+		for (i = 0; i < pdata->num_chipselect; i++) {
+			int cs_gpio = of_get_named_gpio(pdev->dev.of_node,
+							"cs-gpios", i);
+
+			if (cs_gpio == -EPROBE_DEFER) {
+				ret = cs_gpio;
+				goto free_clk;
+			}
+
+			if (gpio_is_valid(cs_gpio)) {
+				ret = devm_gpio_request(&pdev->dev, cs_gpio,
+							dev_name(&pdev->dev));
+				if (ret)
+					goto free_clk;
+			}
+		}
+	}
+
 	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (r)
 		dma_rx_chan = r->start;
-- 
1.9.1
