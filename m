From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 16:52:15 +0100
Subject: [PATCH] iio: health/afe4403: select REGMAP_SPI
Message-ID: <1455637959-3169264-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added afe4403 driver uses the regmap facility to abstract
the I2C and SPI access. However, it fails to ensure that regmap_spi
is actually present:

drivers/iio/built-in.o: In function `afe4403_probe':
:(.text+0x9bf8): undefined reference to `__devm_regmap_init_spi'

This adds a Kconfig select statement like the afe4404 I2C driver
has.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: eec96d1e2d31 ("iio: health: Add driver for the TI AFE4403 heart monitor")
---
 drivers/iio/health/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/health/Kconfig b/drivers/iio/health/Kconfig
index f0c19779ac27..c5f004a8e447 100644
--- a/drivers/iio/health/Kconfig
+++ b/drivers/iio/health/Kconfig
@@ -10,6 +10,7 @@ menu "Heart Rate Monitors"
 config AFE4403
 	tristate "TI AFE4403 Heart Rate Monitor"
 	depends on SPI_MASTER
+	select REGMAP_SPI
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-- 
2.7.0
