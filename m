From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 14:27:06 +0100
Subject: [PATCH] spi: pl08x: do not select S3C64XX_PL080
In-Reply-To: <1957186.KORYFIrP42@wuerfel>
References: <1957186.KORYFIrP42@wuerfel>
Message-ID: <2608153.sC21ihDxEF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pl08x driver originally selected S3C64XX_PL080 to avoid having
the legacy Samsung DMA interfaces. Those are now gone, so the
select is no longer needed, but it now causes problems when
CONFIG_DMA_ENGINE is disabled:

arch/arm/plat-samsung/built-in.o: In function `s3c64xx_spi0_set_platdata':
:(.init.text+0x518): undefined reference to `pl08x_filter_id'

This simply removes the 'select' to avoid this problem.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9b81b39de54e..7727660e9702 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -470,7 +470,6 @@ config SPI_S3C24XX_FIQ
 config SPI_S3C64XX
 	tristate "Samsung S3C64XX series type SPI"
 	depends on (PLAT_SAMSUNG || ARCH_EXYNOS)
-	select S3C64XX_PL080 if ARCH_S3C64XX
 	help
 	  SPI driver for Samsung S3C64XX and newer SoCs.
 
