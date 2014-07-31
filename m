From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 31 Jul 2014 20:33:15 +0300
Subject: [PATCH 2/2] spi: davinci: add support to configure gpio cs through dt
In-Reply-To: <1406827995-30913-1-git-send-email-grygorii.strashko@ti.com>
References: <1406827995-30913-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1406827995-30913-3-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Murali Karicheri <m-karicheri2@ti.com>

Currently driver supports only configuration of GPIO CS through
platform data. This patch enhances the driver to configure GPIO
CS through DT. Also update the DT binding documentation to
reflect the availability of cs-gpios.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 .../devicetree/bindings/spi/spi-davinci.txt        |    9 ++-
 drivers/spi/spi-davinci.c                          |   59 +++++++++++++++++---
 2 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-davinci.txt b/Documentation/devicetree/bindings/spi/spi-davinci.txt
index 6d0ac8d..f80887b 100644
--- a/Documentation/devicetree/bindings/spi/spi-davinci.txt
+++ b/Documentation/devicetree/bindings/spi/spi-davinci.txt
@@ -8,7 +8,8 @@ Required properties:
 	- "ti,dm6441-spi" for SPI used similar to that on DM644x SoC family
 	- "ti,da830-spi" for SPI used similar to that on DA8xx SoC family
 - reg: Offset and length of SPI controller register space
-- num-cs: Number of chip selects
+- num-cs: Number of chip selects. This includes internal as well as
+	GPIO chip selects.
 - ti,davinci-spi-intr-line: interrupt line used to connect the SPI
 	IP to the interrupt controller within the SoC. Possible values
 	are 0 and 1. Manual says one of the two possible interrupt
@@ -17,6 +18,12 @@ Required properties:
 - interrupts: interrupt number mapped to CPU.
 - clocks: spi clk phandle
 
+Optional:
+- cs-gpios: gpio chip selects
+	For example to have 3 internal CS and 2 GPIO CS, user could define
+	cs-gpios = <0>, <0>, <0>, <&gpio1 30 0>, <&gpio1 31 0>;
+	where first three are internal CS and last two are GPIO CS.
+
 Example of a NOR flash slave device (n25q032) connected to DaVinci
 SPI controller device over the SPI bus.
 
diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 2477af4..6aa04d1 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -30,6 +30,7 @@
 #include <linux/edma.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 #include <linux/slab.h>
@@ -207,17 +208,28 @@ static inline void clear_io_bits(void __iomem *addr, u32 bits)
 static void davinci_spi_chipselect(struct spi_device *spi, int value)
 {
 	struct davinci_spi *dspi;
+	struct device_node *np = spi->dev.of_node;
 	struct davinci_spi_platform_data *pdata;
+	struct spi_master *master = spi->master;
 	u8 chip_sel = spi->chip_select;
 	u16 spidat1 = CS_DEFAULT;
 	bool gpio_chipsel = false;
+	int gpio;
 
 	dspi = spi_master_get_devdata(spi->master);
 	pdata = &dspi->pdata;
 
-	if (pdata->chip_sel && chip_sel < pdata->num_chipselect &&
-				pdata->chip_sel[chip_sel] != SPI_INTERN_CS)
+	if (np && master->cs_gpios != NULL && spi->cs_gpio >= 0) {
+		/* SPI core parse and update master->cs_gpio */
 		gpio_chipsel = true;
+		gpio = spi->cs_gpio;
+	} else if (pdata->chip_sel &&
+		   chip_sel < pdata->num_chipselect &&
+		   pdata->chip_sel[chip_sel] != SPI_INTERN_CS) {
+		/* platform data defines chip_sel */
+		gpio_chipsel = true;
+		gpio = pdata->chip_sel[chip_sel];
+	}
 
 	/*
 	 * Board specific chip select logic decides the polarity and cs
@@ -225,9 +237,9 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 	 */
 	if (gpio_chipsel) {
 		if (value == BITBANG_CS_ACTIVE)
-			gpio_set_value(pdata->chip_sel[chip_sel], 0);
+			gpio_set_value(gpio, 0);
 		else
-			gpio_set_value(pdata->chip_sel[chip_sel], 1);
+			gpio_set_value(gpio, 1);
 	} else {
 		if (value == BITBANG_CS_ACTIVE) {
 			spidat1 |= SPIDAT1_CSHOLD_MASK;
@@ -390,17 +402,36 @@ static int davinci_spi_setup(struct spi_device *spi)
 	int retval = 0;
 	struct davinci_spi *dspi;
 	struct davinci_spi_platform_data *pdata;
+	struct spi_master *master = spi->master;
+	struct device_node *np = spi->dev.of_node;
+	bool internal_cs = true;
 
 	dspi = spi_master_get_devdata(spi->master);
 	pdata = &dspi->pdata;
 
 	if (!(spi->mode & SPI_NO_CS)) {
-		if ((pdata->chip_sel == NULL) ||
-		    (pdata->chip_sel[spi->chip_select] == SPI_INTERN_CS))
-			set_io_bits(dspi->base + SPIPC0, 1 << spi->chip_select);
-
+		if (np && (master->cs_gpios != NULL) && (spi->cs_gpio >= 0)) {
+			retval =
+				gpio_request(spi->cs_gpio, dev_name(&spi->dev));
+			if (retval) {
+				dev_err(&spi->dev,
+					"GPIO %d request failed\n",
+					spi->cs_gpio);
+				return -ENODEV;
+			}
+			gpio_direction_output(spi->cs_gpio,
+					      !(spi->mode & SPI_CS_HIGH));
+			internal_cs = false;
+		} else if (pdata->chip_sel &&
+			   spi->chip_select < pdata->num_chipselect &&
+			   pdata->chip_sel[spi->chip_select] != SPI_INTERN_CS) {
+			internal_cs = false;
+		}
 	}
 
+	if (internal_cs)
+		set_io_bits(dspi->base + SPIPC0, 1 << spi->chip_select);
+
 	if (spi->mode & SPI_READY)
 		set_io_bits(dspi->base + SPIPC0, SPIPC0_SPIENA_MASK);
 
@@ -412,6 +443,15 @@ static int davinci_spi_setup(struct spi_device *spi)
 	return retval;
 }
 
+static void davinci_spi_cleanup(struct spi_device *spi)
+{
+	struct spi_master *master = spi->master;
+	struct device_node *np = spi->dev.of_node;
+
+	if (np && (master->cs_gpios != NULL) && (spi->cs_gpio >= 0))
+		gpio_free(spi->cs_gpio);
+}
+
 static int davinci_spi_check_error(struct davinci_spi *dspi, int int_status)
 {
 	struct device *sdev = dspi->bitbang.master->dev.parent;
@@ -810,6 +850,8 @@ static int spi_davinci_get_pdata(struct platform_device *pdev,
 
 	/*
 	 * default num_cs is 1 and all chipsel are internal to the chip
+	 * indicated by chip_sel being NULL or cs_gpios being NULL or
+	 * set to -ENOENT. num-cs includes internal as well as gpios.
 	 * indicated by chip_sel being NULL. GPIO based CS is not
 	 * supported yet in DT bindings.
 	 */
@@ -921,6 +963,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	master->num_chipselect = pdata->num_chipselect;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(2, 16);
 	master->setup = davinci_spi_setup;
+	master->cleanup = davinci_spi_cleanup;
 
 	dspi->bitbang.chipselect = davinci_spi_chipselect;
 	dspi->bitbang.setup_transfer = davinci_spi_setup_transfer;
-- 
1.7.9.5
