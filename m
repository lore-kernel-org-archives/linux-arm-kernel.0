From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 21 Aug 2014 18:25:06 +0300
Subject: [PATCH 2/2] spi: davinci: support adding delay between transmission
In-Reply-To: <1408634706-5762-1-git-send-email-grygorii.strashko@ti.com>
References: <1408634706-5762-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1408634706-5762-3-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch completes migration of Davinci SPI driver to DT
and adds ability to configure additional properties for
SPI slave devices which were possible to configure only
from platform code through struct davinci_spi_config before
this patch.

New optional SPI slave properties:
- ti,davinci-spi-wdelay : delay between transmissions.
- ti,davinci-spi-odd-parity : odd partity enabled
   OR
  ti,davinci-spi-even-parity : even parity enabled
- ti,davinci-spi-io-type: io type
- ti,davinci-spi-disable-timer: disable CS timer (SPIFMTn)
- ti,davinci-spi-c2t-delay: c2t delay
- ti,davinci-spi-t2c-delay: t2c delay
- ti,davinci-spi-t2e-delay: t2e delay
- ti,davinci-spi-c2e-delay: c2e delay

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 .../devicetree/bindings/spi/spi-davinci.txt        |   18 +++++
 drivers/spi/spi-davinci.c                          |   80 ++++++++++++++++++--
 2 files changed, 91 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-davinci.txt b/Documentation/devicetree/bindings/spi/spi-davinci.txt
index f80887b..bfcd42d 100644
--- a/Documentation/devicetree/bindings/spi/spi-davinci.txt
+++ b/Documentation/devicetree/bindings/spi/spi-davinci.txt
@@ -24,6 +24,22 @@ Optional:
 	cs-gpios = <0>, <0>, <0>, <&gpio1 30 0>, <&gpio1 31 0>;
 	where first three are internal CS and last two are GPIO CS.
 
+Optional properties for slave devices:
+SPI slave nodes can contain the following properties.
+Not all SPI Peripherals from Texas Instruments support this.
+Please check SPI peripheral documentation for a device before using these.
+
+- ti,davinci-spi-wdelay : delay between transmissions.
+- ti,davinci-spi-odd-parity : odd partity enabled
+   OR
+  ti,davinci-spi-even-parity : even parity enabled
+- ti,davinci-spi-io-type: io type (check platform_data/spi-davinci.h)
+- ti,davinci-spi-disable-timer: disable CS timer (SPIFMTn)
+- ti,davinci-spi-c2t-delay: c2t delay
+- ti,davinci-spi-t2c-delay: t2c delay
+- ti,davinci-spi-t2e-delay: t2e delay
+- ti,davinci-spi-c2e-delay: c2e delay
+
 Example of a NOR flash slave device (n25q032) connected to DaVinci
 SPI controller device over the SPI bus.
 
@@ -43,6 +59,8 @@ spi0:spi at 20BF0000 {
 		compatible = "st,m25p32";
 		spi-max-frequency = <25000000>;
 		reg = <0>;
+		ti,davinci-spi-c2t-delay = <8>;
+		ti,davinci-spi-t2c-delay = <8>;
 
 		partition at 0 {
 			label = "u-boot-spl";
diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 48f1d26..0e276ad 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -65,6 +65,7 @@
 
 /* SPIDAT1 (upper 16 bit defines) */
 #define SPIDAT1_CSHOLD_MASK	BIT(12)
+#define SPIDAT1_WDEL		BIT(10)
 
 /* SPIGCR1 */
 #define SPIGCR1_CLKMOD_MASK	BIT(1)
@@ -209,6 +210,7 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 {
 	struct davinci_spi *dspi;
 	struct davinci_spi_platform_data *pdata;
+	struct davinci_spi_config *spicfg = spi->controller_data;
 	u8 chip_sel = spi->chip_select;
 	u16 spidat1 = CS_DEFAULT;
 	bool gpio_chipsel = false;
@@ -223,6 +225,10 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 		gpio = spi->cs_gpio;
 	}
 
+	/* program delay transfers if tx_delay is non zero */
+	if (spicfg->wdelay)
+		spidat1 |= SPIDAT1_WDEL;
+
 	/*
 	 * Board specific chip select logic decides the polarity and cs
 	 * line for the controller
@@ -237,9 +243,9 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 			spidat1 |= SPIDAT1_CSHOLD_MASK;
 			spidat1 &= ~(0x1 << chip_sel);
 		}
-
-		iowrite16(spidat1, dspi->base + SPIDAT1 + 2);
 	}
+
+	iowrite16(spidat1, dspi->base + SPIDAT1 + 2);
 }
 
 /**
@@ -285,7 +291,7 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 	int prescale;
 
 	dspi = spi_master_get_devdata(spi->master);
-	spicfg = (struct davinci_spi_config *)spi->controller_data;
+	spicfg = spi->controller_data;
 	if (!spicfg)
 		spicfg = &davinci_spi_default_cfg;
 
@@ -333,6 +339,14 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 		spifmt |= SPIFMT_PHASE_MASK;
 
 	/*
+	* Assume wdelay is used only on SPI peripherals that has this field
+	* in SPIFMTn register and when it's configured from board file or DT.
+	*/
+	if (spicfg->wdelay)
+		spifmt |= ((spicfg->wdelay << SPIFMT_WDELAY_SHIFT)
+				& SPIFMT_WDELAY_MASK);
+
+	/*
 	 * Version 1 hardware supports two basic SPI modes:
 	 *  - Standard SPI mode uses 4 pins, with chipselect
 	 *  - 3 pin SPI is a 4 pin variant without CS (SPI_NO_CS)
@@ -349,9 +363,6 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 
 		u32 delay = 0;
 
-		spifmt |= ((spicfg->wdelay << SPIFMT_WDELAY_SHIFT)
-							& SPIFMT_WDELAY_MASK);
-
 		if (spicfg->odd_parity)
 			spifmt |= SPIFMT_ODD_PARITY_MASK;
 
@@ -383,6 +394,55 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 	return 0;
 }
 
+static int davinci_spi_of_setup(struct spi_device *spi)
+{
+	struct davinci_spi_config *spicfg = spi->controller_data;
+	struct device_node *np = spi->dev.of_node;
+	u32 prop;
+	int len;
+
+	if (spicfg == NULL && np) {
+		spicfg = kzalloc(sizeof(*spicfg), GFP_KERNEL);
+		if (!spicfg)
+			return -ENOMEM;
+		*spicfg = davinci_spi_default_cfg;
+		/* override with dt configured values */
+		if (!of_property_read_u32(np,
+					  "ti,davinci-spi-wdelay", &prop))
+			spicfg->wdelay = (u8)prop;
+		if (of_find_property(np,
+				     "ti,davinci-spi-odd-parity", &len)) {
+			spicfg->parity_enable = 1;
+			spicfg->odd_parity = 1;
+		} else if (of_find_property(np, "ti,davinci-spi-even-parity",
+					    &len)) {
+			spicfg->parity_enable = 1;
+			spicfg->odd_parity = 0;
+		}
+		if (!of_property_read_u32(np, "ti,davinci-spi-io-type",
+					  &prop))
+			spicfg->io_type = (u8)prop;
+		if (of_find_property(np,
+				     "ti,davinci-spi-disable-timer", &len))
+			spicfg->timer_disable = 1;
+		if (!of_property_read_u32(np,
+					  "ti,davinci-spi-c2t-delay", &prop))
+			spicfg->c2tdelay = (u8)prop;
+		if (!of_property_read_u32(np,
+					  "ti,davinci-spi-t2c-delay", &prop))
+			spicfg->t2cdelay = (u8)prop;
+		if (!of_property_read_u32(np,
+					  "ti,davinci-spi-t2e-delay", &prop))
+			spicfg->t2edelay = (u8)prop;
+		if (!of_property_read_u32(np,
+					  "ti,davinci-spi-c2e-delay", &prop))
+			spicfg->c2edelay = (u8)prop;
+		spi->controller_data = spicfg;
+	}
+
+	return 0;
+}
+
 /**
  * davinci_spi_setup - This functions will set default transfer method
  * @spi: spi device on which data transfer to be done
@@ -436,11 +496,17 @@ static int davinci_spi_setup(struct spi_device *spi)
 	else
 		clear_io_bits(dspi->base + SPIGCR1, SPIGCR1_LOOPBACK_MASK);
 
-	return retval;
+	return davinci_spi_of_setup(spi);
 }
 
 static void davinci_spi_cleanup(struct spi_device *spi)
 {
+	struct davinci_spi_config *spicfg = spi->controller_data;
+
+	spi->controller_data = NULL;
+	if (spi->dev.of_node)
+		kfree(spicfg);
+
 	if (spi->cs_gpio >= 0)
 		gpio_free(spi->cs_gpio);
 }
-- 
1.7.9.5
