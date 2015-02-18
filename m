From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Feb 2015 16:29:10 +0100
Subject: [PATCH] spi: sirf: add reset controller dependency
Message-ID: <4553005.HBquOfbqXe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sirf spi driver only builds correctly if the reset controller
framework is available, otherwise we get an error:

drivers/spi/spi-sirf.c: In function 'spi_sirfsoc_probe':
drivers/spi/spi-sirf.c:651:2: error: implicit declaration of function 'device_reset' [-Werror=implicit-function-declaration]

The adds a dependency in Kconfig to prevent it from being selected
if the resets are not available.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes:  8509c55fcb51 ("spi: sirf: reset SPI controller in init stage")

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ab8dfbef6f1b..b3ae90e4c03c 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -507,6 +507,7 @@ config SPI_SH_HSPI
 config SPI_SIRF
 	tristate "CSR SiRFprimaII SPI controller"
 	depends on SIRF_DMA
+	depends on RESET_CONTROLLER
 	select SPI_BITBANG
 	help
 	  SPI driver for CSR SiRFprimaII SoCs
