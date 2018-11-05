From: bugalski.piotr@gmail.com (Piotr Bugalski)
Date: Mon,  5 Nov 2018 11:36:24 +0100
Subject: [PATCH v3 5/6] spi: Add QuadSPI driver for Atmel SAMA5D2
In-Reply-To: <20181105103625.9644-1-bugalski.piotr@gmail.com>
References: <20181105103625.9644-1-bugalski.piotr@gmail.com>
Message-ID: <20181105103625.9644-6-bugalski.piotr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kernel contains QSPI driver strongly tied to MTD and nor-flash memory.
New spi-mem interface allows usage also other memory types, especially
much larger NAND with SPI interface. This driver works as SPI controller
and is not related to MTD, however can work with NAND-flash or other
peripherals using spi-mem interface.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Piotr Bugalski <bugalski.piotr@gmail.com>
---
 drivers/mtd/spi-nor/Kconfig                  | 9 ---------
 drivers/mtd/spi-nor/Makefile                 | 1 -
 drivers/spi/Kconfig                          | 9 +++++++++
 drivers/spi/Makefile                         | 1 +
 drivers/{mtd/spi-nor => spi}/atmel-quadspi.c | 0
 5 files changed, 10 insertions(+), 10 deletions(-)
 rename drivers/{mtd/spi-nor => spi}/atmel-quadspi.c (100%)

diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
index 6cc9c929ff57..44fe8018733c 100644
--- a/drivers/mtd/spi-nor/Kconfig
+++ b/drivers/mtd/spi-nor/Kconfig
@@ -39,15 +39,6 @@ config SPI_ASPEED_SMC
 	  and support for the SPI flash memory controller (SPI) for
 	  the host firmware. The implementation only supports SPI NOR.
 
-config SPI_ATMEL_QUADSPI
-	tristate "Atmel Quad SPI Controller"
-	depends on ARCH_AT91 || (ARM && COMPILE_TEST)
-	depends on OF && HAS_IOMEM
-	help
-	  This enables support for the Quad SPI controller in master mode.
-	  This driver does not support generic SPI. The implementation only
-	  supports SPI NOR.
-
 config SPI_CADENCE_QUADSPI
 	tristate "Cadence Quad SPI controller"
 	depends on OF && (ARM || ARM64 || COMPILE_TEST)
diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index f4c61d282abd..a552efd22958 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
 obj-$(CONFIG_SPI_ASPEED_SMC)	+= aspeed-smc.o
-obj-$(CONFIG_SPI_ATMEL_QUADSPI)	+= atmel-quadspi.o
 obj-$(CONFIG_SPI_CADENCE_QUADSPI)	+= cadence-quadspi.o
 obj-$(CONFIG_SPI_FSL_QUADSPI)	+= fsl-quadspi.o
 obj-$(CONFIG_SPI_HISI_SFC)	+= hisi-sfc.o
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 7d3a5c94727e..ca68ac63c6c3 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -91,6 +91,15 @@ config SPI_AT91_USART
 	  This selects a driver for the AT91 USART Controller as SPI Master,
 	  present on AT91 and SAMA5 SoC series.
 
+config SPI_ATMEL_QUADSPI
+	tristate "Atmel Quad SPI Controller"
+	depends on ARCH_AT91 || (ARM && COMPILE_TEST)
+	depends on OF && HAS_IOMEM
+	help
+	  This enables support for the Quad SPI controller in master mode.
+	  This driver does not support generic SPI. The implementation only
+	  supports spi-mem interface.
+
 config SPI_AU1550
 	tristate "Au1550/Au1200/Au1300 SPI Controller"
 	depends on MIPS_ALCHEMY
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 3575205c5c27..258917db3f56 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
 obj-$(CONFIG_SPI_ALTERA)		+= spi-altera.o
 obj-$(CONFIG_SPI_ARMADA_3700)		+= spi-armada-3700.o
 obj-$(CONFIG_SPI_ATMEL)			+= spi-atmel.o
+obj-$(CONFIG_SPI_ATMEL_QUADSPI)		+= atmel-quadspi.o
 obj-$(CONFIG_SPI_AT91_USART)		+= spi-at91-usart.o
 obj-$(CONFIG_SPI_ATH79)			+= spi-ath79.o
 obj-$(CONFIG_SPI_AU1550)		+= spi-au1550.o
diff --git a/drivers/mtd/spi-nor/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
similarity index 100%
rename from drivers/mtd/spi-nor/atmel-quadspi.c
rename to drivers/spi/atmel-quadspi.c
-- 
2.11.0
