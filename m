From: gerg@linux-m68k.org (Greg Ungerer)
Date: Fri, 17 Mar 2017 15:03:03 +1000
Subject: [PATCH 2/2] spi: imx: fix use of native chip-selects with devicetree
In-Reply-To: <1489726983-17706-1-git-send-email-gerg@linux-m68k.org>
References: <1489726983-17706-1-git-send-email-gerg@linux-m68k.org>
Message-ID: <1489726983-17706-3-git-send-email-gerg@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commonly used mechanism of specifying the hardware or native
chip-select on an SPI device in devicetree (that is "cs-gpios = <0>")
does not result in the native chip-select being configured for use.
So external SPI devices that require use of the native chip-select
will not work.

You can successfully specify native chip-selects if using a platform
setup by specifying the cs-gpio as negative offset by 32. And that
works correctly. You cannot use the same method in devicetree.

The logic in the spi-imx.c driver during probe uses core spi function
of_spi_register_master() in spi.c to parse the "cs-gpios" devicetree tag.
For valid GPIO values that will be recorded for use, all other entries in
the cs_gpios list will be set to -ENOENT. So entries like "<0>" will be
set to -ENOENT in the cs_gpios list.

When the SPI device registers are setup the code will use the GPIO
listed in the cs_gpios list for the desired chip-select. If the cs_gpio
is less then 0 then it is intended to be for a native chip-select, and
its cs_gpio value is added to 32 to get the chipselect number to use.
Problem is that with devicetree this can only ever be -ENOENT (which
is -2), and that alone results in an invalid chip-select number. But also
doesn't allow selection of the native chip-select at all.

To fix, if the cs_gpio specified for this spi device is not a
valid GPIO then use the "chip_select" (that is the native chip-select
number) for hardware setup.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 drivers/spi/spi-imx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 9a7c62f..dbb482c 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -516,8 +516,8 @@ static int mx31_config(struct spi_device *spi, struct spi_imx_config *config)
 		reg |= MX31_CSPICTRL_POL;
 	if (spi->mode & SPI_CS_HIGH)
 		reg |= MX31_CSPICTRL_SSPOL;
-	if (spi->cs_gpio < 0)
-		reg |= (spi->cs_gpio + 32) <<
+	if (!gpio_is_valid(spi->cs_gpio))
+		reg |= (spi->chip_select) <<
 			(is_imx35_cspi(spi_imx) ? MX35_CSPICTRL_CS_SHIFT :
 						  MX31_CSPICTRL_CS_SHIFT);
 
@@ -608,8 +608,8 @@ static int mx21_config(struct spi_device *spi, struct spi_imx_config *config)
 		reg |= MX21_CSPICTRL_POL;
 	if (spi->mode & SPI_CS_HIGH)
 		reg |= MX21_CSPICTRL_SSPOL;
-	if (spi->cs_gpio < 0)
-		reg |= (spi->cs_gpio + 32) << MX21_CSPICTRL_CS_SHIFT;
+	if (!gpio_is_valid(spi->cs_gpio))
+		reg |= spi->chip_select << MX21_CSPICTRL_CS_SHIFT;
 
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 
-- 
1.9.1
