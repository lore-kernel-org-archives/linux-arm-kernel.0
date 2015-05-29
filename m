From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Fri, 29 May 2015 16:56:42 +0200
Subject: [PATCH 1/2] spi: atmel: add support for the internal chip-select of
 the spi controller
In-Reply-To: <cover.1432910696.git.cyrille.pitchen@atmel.com>
References: <cover.1432910696.git.cyrille.pitchen@atmel.com>
Message-ID: <bb520f28c50707bdbbdc6b082451162d69987b6b.1432910696.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch relies on the CSAAT (Chip Select Active After Transfer) feature
introduced by the version 2 of the spi controller. This new mode allows to use
properly the internal chip-select output pin of the spi controller instead of
using external gpios. Consequently, the "cs-gpios" device-tree property becomes
optional.

When the new CSAAT bit is set into the Chip Select Register, the internal
chip-select output pin remains asserted till both the following conditions
become true:
- the LASTXFER bit is set into the Control Register (or the Transmit Data Register)
- the Transmit Data Register and its shift register are empty.

WARNING: if the LASTXFER bit is set into the Control Register then new data are
written into the Transmit Data Register fast enough to keep its shifter not
empty, the chip-select output pin remains asserted. Only when the shifter
becomes empty, the chip-select output pin is unasserted.

When the CSAAT bit is clear in the Chip Select Register, the LASTXFER bit is
ignored in both the Control Register and the Transmit Data Register.
The internal chip-select output pin remains active as long as the Transmit Data
Register or its shift register are not empty.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/spi/spi-atmel.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index a2f40b1..aa7d202 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -246,6 +246,7 @@ struct atmel_spi {
 
 	bool			use_dma;
 	bool			use_pdc;
+	bool			use_cs_gpios;
 	/* dmaengine data */
 	struct atmel_spi_dma	dma;
 
@@ -321,7 +322,8 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 		}
 
 		mr = spi_readl(as, MR);
-		gpio_set_value(asd->npcs_pin, active);
+		if (as->use_cs_gpios)
+			gpio_set_value(asd->npcs_pin, active);
 	} else {
 		u32 cpol = (spi->mode & SPI_CPOL) ? SPI_BIT(CPOL) : 0;
 		int i;
@@ -337,7 +339,7 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 
 		mr = spi_readl(as, MR);
 		mr = SPI_BFINS(PCS, ~(1 << spi->chip_select), mr);
-		if (spi->chip_select != 0)
+		if (as->use_cs_gpios && spi->chip_select != 0)
 			gpio_set_value(asd->npcs_pin, active);
 		spi_writel(as, MR, mr);
 	}
@@ -366,7 +368,9 @@ static void cs_deactivate(struct atmel_spi *as, struct spi_device *spi)
 			asd->npcs_pin, active ? " (low)" : "",
 			mr);
 
-	if (atmel_spi_is_v2(as) || spi->chip_select != 0)
+	if (!as->use_cs_gpios)
+		spi_writel(as, CR, SPI_BIT(LASTXFER));
+	else if (atmel_spi_is_v2(as) || spi->chip_select != 0)
 		gpio_set_value(asd->npcs_pin, !active);
 }
 
@@ -996,6 +1000,8 @@ static int atmel_spi_setup(struct spi_device *spi)
 		csr |= SPI_BIT(CPOL);
 	if (!(spi->mode & SPI_CPHA))
 		csr |= SPI_BIT(NCPHA);
+	if (!as->use_cs_gpios)
+		csr |= SPI_BIT(CSAAT);
 
 	/* DLYBS is mostly irrelevant since we manage chipselect using GPIOs.
 	 *
@@ -1009,7 +1015,9 @@ static int atmel_spi_setup(struct spi_device *spi)
 	/* chipselect must have been muxed as GPIO (e.g. in board setup) */
 	npcs_pin = (unsigned long)spi->controller_data;
 
-	if (gpio_is_valid(spi->cs_gpio))
+	if (!as->use_cs_gpios)
+		npcs_pin = spi->chip_select;
+	else if (gpio_is_valid(spi->cs_gpio))
 		npcs_pin = spi->cs_gpio;
 
 	asd = spi->controller_state;
@@ -1018,15 +1026,19 @@ static int atmel_spi_setup(struct spi_device *spi)
 		if (!asd)
 			return -ENOMEM;
 
-		ret = gpio_request(npcs_pin, dev_name(&spi->dev));
-		if (ret) {
-			kfree(asd);
-			return ret;
+		if (as->use_cs_gpios) {
+			ret = gpio_request(npcs_pin, dev_name(&spi->dev));
+			if (ret) {
+				kfree(asd);
+				return ret;
+			}
+
+			gpio_direction_output(npcs_pin,
+					      !(spi->mode & SPI_CS_HIGH));
 		}
 
 		asd->npcs_pin = npcs_pin;
 		spi->controller_state = asd;
-		gpio_direction_output(npcs_pin, !(spi->mode & SPI_CS_HIGH));
 	}
 
 	asd->csr = csr;
@@ -1338,6 +1350,13 @@ static int atmel_spi_probe(struct platform_device *pdev)
 
 	atmel_get_caps(as);
 
+	as->use_cs_gpios = true;
+	if (atmel_spi_is_v2(as) &&
+	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL)) {
+		as->use_cs_gpios = false;
+		master->num_chipselect = 4;
+	}
+
 	as->use_dma = false;
 	as->use_pdc = false;
 	if (as->caps.has_dma_support) {
-- 
1.8.2.2
