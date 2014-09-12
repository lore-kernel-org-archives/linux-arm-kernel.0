From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 12 Sep 2014 18:48:12 +0300
Subject: [PATCH v3] spi: davinci: add support for adding delay between word's
 transmissions
Message-ID: <1410536892-22775-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Murali Karicheri <m-karicheri2@ti.com>

This patch adds ability to configure delay between transmission of
words over SPI bus if it's required by SPI slave devices.

New optional SPI slave's property:
- ti,spi-word-delay : delay between transmission of words
	(SPIFMTn.WDELAY, SPIDAT1.WDEL)

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
Changes in v3:
- removed C2TDELAY, T2CDELAY parameters

v2:
http://www.spinics.net/lists/devicetree/msg48514.html
v1:
http://www.spinics.net/lists/linux-spi/msg01609.html

 .../devicetree/bindings/spi/spi-davinci.txt        | 30 +++++++++++++
 drivers/spi/spi-davinci.c                          | 50 +++++++++++++++++++---
 2 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-davinci.txt b/Documentation/devicetree/bindings/spi/spi-davinci.txt
index f80887b..12ecfe9 100644
--- a/Documentation/devicetree/bindings/spi/spi-davinci.txt
+++ b/Documentation/devicetree/bindings/spi/spi-davinci.txt
@@ -1,5 +1,10 @@
 Davinci SPI controller device bindings
 
+Links on DM:
+Keystone 2 - http://www.ti.com/lit/ug/sprugp2a/sprugp2a.pdf
+dm644x - http://www.ti.com/lit/ug/sprue32a/sprue32a.pdf
+OMAP-L138/da830 - http://www.ti.com/lit/ug/spruh77a/spruh77a.pdf
+
 Required properties:
 - #address-cells: number of cells required to define a chip select
 	address on the SPI bus. Should be set to 1.
@@ -24,6 +29,30 @@ Optional:
 	cs-gpios = <0>, <0>, <0>, <&gpio1 30 0>, <&gpio1 31 0>;
 	where first three are internal CS and last two are GPIO CS.
 
+Optional properties for slave devices:
+SPI slave nodes can contain the following properties.
+Not all SPI Peripherals from Texas Instruments support this.
+Please check SPI peripheral documentation for a device before using these.
+
+- ti,spi-wdelay : delay between transmission of words
+	(SPIFMTn.WDELAY, SPIDAT1.WDEL) must be specified in number of SPI module
+	clock periods.
+
+	delay = WDELAY * SPI_module_clock_period + 2 * SPI_module_clock_period
+
+Below is timing diagram which shows functional meaning of
+"ti,spi-wdelay" parameter.
+
+             +-+ +-+ +-+ +-+ +-+                           +-+ +-+ +-+
+SPI_CLK      | | | | | | | | | |                           | | | | | |
+  +----------+ +-+ +-+ +-+ +-+ +---------------------------+ +-+ +-+ +-
+
+SPI_SOMI/SIMO+-----------------+                           +-----------
+  +----------+ word1           +---------------------------+word2
+             +-----------------+                           +-----------
+                                          WDELAY
+                                <-------------------------->
+
 Example of a NOR flash slave device (n25q032) connected to DaVinci
 SPI controller device over the SPI bus.
 
@@ -43,6 +72,7 @@ spi0:spi at 20BF0000 {
 		compatible = "st,m25p32";
 		spi-max-frequency = <25000000>;
 		reg = <0>;
+		ti,spi-wdelay = <8>;
 
 		partition at 0 {
 			label = "u-boot-spl";
diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index d493507..ada3891 100644
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
 
@@ -383,6 +394,26 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 	return 0;
 }
 
+static int davinci_spi_of_setup(struct spi_device *spi)
+{
+	struct davinci_spi_config *spicfg = spi->controller_data;
+	struct device_node *np = spi->dev.of_node;
+	u32 prop;
+
+	if (spicfg == NULL && np) {
+		spicfg = kzalloc(sizeof(*spicfg), GFP_KERNEL);
+		if (!spicfg)
+			return -ENOMEM;
+		*spicfg = davinci_spi_default_cfg;
+		/* override with dt configured values */
+		if (!of_property_read_u32(np, "ti,spi-wdelay", &prop))
+			spicfg->wdelay = (u8)prop;
+		spi->controller_data = spicfg;
+	}
+
+	return 0;
+}
+
 /**
  * davinci_spi_setup - This functions will set default transfer method
  * @spi: spi device on which data transfer to be done
@@ -433,11 +464,16 @@ static int davinci_spi_setup(struct spi_device *spi)
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
 }
 
 static int davinci_spi_check_error(struct davinci_spi *dspi, int int_status)
-- 
1.9.1
