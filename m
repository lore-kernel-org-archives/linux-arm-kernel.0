From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 9 Sep 2014 19:07:31 +0300
Subject: [PATCH v2] spi: davinci: add support for adding delay between word's
 transmission
Message-ID: <1410278851-10783-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Murali Karicheri <m-karicheri2@ti.com>

This patch adds ability to configure delay between transmission of
words over SPI bus if it's required by SPI slave devices.

New optional SPI slave properties:
- ti,spi-word-delay : delay between transmission of words
	(SPIFMTn.WDELAY, SPIDAT1.WDEL)

- ti,spi-c2t-delay: Chip-select-active-to-transmit-start delay
	(SPIDELAY.C2TDELAY)

- ti,spi-t2c-delay: Transmit-end-to-chip-select-inactive delay
	(SPIDELAY.T2CDELAY)

- ti,spi-disable-cstimer: disable CS timer (SPIFMTn.DISCSTIMERS).

If WDELAY, C2TDELAY, T2CDELAY are configured then delay
between transmission of words will be added as following:

   wdelay = T2CDELAY + WDELAY + C2TDELAY.

If "ti,spi-disable-cstimer" is configured:

   wdelay = WDELAY.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---

Changes in v2:
- reduced number of new parameters
- bindings updated

Link on v1:
http://www.spinics.net/lists/linux-spi/msg01609.html

 .../devicetree/bindings/spi/spi-davinci.txt        | 50 +++++++++++++++++
 drivers/spi/spi-davinci.c                          | 62 +++++++++++++++++++---
 2 files changed, 105 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-davinci.txt b/Documentation/devicetree/bindings/spi/spi-davinci.txt
index f80887b..1c336d4 100644
--- a/Documentation/devicetree/bindings/spi/spi-davinci.txt
+++ b/Documentation/devicetree/bindings/spi/spi-davinci.txt
@@ -24,6 +24,54 @@ Optional:
 	cs-gpios = <0>, <0>, <0>, <&gpio1 30 0>, <&gpio1 31 0>;
 	where first three are internal CS and last two are GPIO CS.
 
+Optional properties for slave devices:
+SPI slave nodes can contain the following properties.
+Not all SPI Peripherals from Texas Instruments support this.
+Please check SPI peripheral documentation for a device before using these.
+
+- ti,spi-word-delay : delay between transmission of words
+	(SPIFMTn.WDELAY, SPIDAT1.WDEL) must be specified in number of SPI module
+	clock periods.
+
+	delay = WDELAY * SPI_module_clock_period + 2 * SPI_module_clock_period
+
+- ti,spi-c2t-delay: Chip-select-active-to-transmit-start delay
+	(SPIDELAY.C2TDELAY) must be specified in number of SPI module
+	clock periods. if 0 - delay is not applied.
+
+	delay = (C2TDELAY + 2) * SPI_module_clock_period
+
+- ti,spi-t2c-delay: Transmit-end-to-chip-select-inactive delay
+	(SPIDELAY.T2CDELAY) must be specified in number of SPI module
+	clock periods. if 0 - delay is not applied.
+
+	delay = (T2CDELAY + 1) * SPI_module_clock_period
+
+- ti,spi-disable-cstimer: disable CS timer (SPIFMTn.DISCSTIMERS). Boolean
+	property that the C2TDELAY and T2CDELAY timers should be disabled.
+
+Below is timing diagram which shows functional meaning of
+"ti,spi-word-delay", "ti,spi-c2t-delay" and "ti,spi-t2c-delay" parameters.
+
+             +-+ +-+ +-+ +-+ +-+                           +-+ +-+ +-+
+SPI_CLK      | | | | | | | | | |                           | | | | | |
+  +----------+ +-+ +-+ +-+ +-+ +---------------------------+ +-+ +-+ +-
+
+SPI_SOMI/SIMO+-----------------+                           +-----------
+  +----------+ word1           +---------------------------+word2
+             +-----------------+                           +-----------
+                                          WDELAY
+                                         <--------->
+                                        +           +
+SPI_CS                                  |           |
+  +----+                                +-----------+
+       |                                |           |
+       +-----+-----------------+--------+           +-----+------------
+       |     |                 |        |           |     |
+       +     +                 +        |           +     +
+        <--->                   <------>             <--->
+       C2TDELAY                 T2CDELAY            C2TDELAY
+
 Example of a NOR flash slave device (n25q032) connected to DaVinci
 SPI controller device over the SPI bus.
 
@@ -43,6 +91,8 @@ spi0:spi at 20BF0000 {
 		compatible = "st,m25p32";
 		spi-max-frequency = <25000000>;
 		reg = <0>;
+		ti,spi-c2t-delay = <8>;
+		ti,spi-t2c-delay = <8>;
 
 		partition at 0 {
 			label = "u-boot-spl";
diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 48f1d26..ccadc95 100644
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
 
@@ -383,6 +394,37 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
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
+					  "ti,spi-word-delay", &prop))
+			spicfg->wdelay = (u8)prop;
+		if (of_find_property(np,
+				     "ti,spi-disable-cstimer", &len))
+			spicfg->timer_disable = 1;
+		if (!of_property_read_u32(np,
+					  "ti,spi-c2t-delay", &prop))
+			spicfg->c2tdelay = (u8)prop;
+		if (!of_property_read_u32(np,
+					  "ti,spi-t2c-delay", &prop))
+			spicfg->t2cdelay = (u8)prop;
+		spi->controller_data = spicfg;
+	}
+
+	return 0;
+}
+
 /**
  * davinci_spi_setup - This functions will set default transfer method
  * @spi: spi device on which data transfer to be done
@@ -436,11 +478,17 @@ static int davinci_spi_setup(struct spi_device *spi)
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
1.9.1
