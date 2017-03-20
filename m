From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Mar 2017 10:35:28 +0100
Subject: [PATCH] staging: vc04_services: make BCM_VIDEOCORE tristate
Message-ID: <20170320093544.1213296-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding the 'bool' symbol brought back a randconfig build bug that
I had fixed before:

drivers/staging/built-in.o: In function `vchiq_probe':
(.text+0x1da30): undefined reference to `rpi_firmware_get'
drivers/staging/built-in.o: In function `vchiq_platform_init':
(.text+0x27494): undefined reference to `rpi_firmware_property'

The problem is that when RASPBERRYPI_FIRMWARE is a loadable module,
but BCM2835_VCHIQ can again be built-in. Making BCM_VIDEOCORE
itself tristate will make Kconfig honor the dependency correctly.

Fixes: 6bbfe4a76158 ("staging: vc04_services: Create new BCM_VIDEOCORE setting for VideoCore services.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/vc04_services/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04_services/Kconfig
index f905df2275cf..9e2763663ab8 100644
--- a/drivers/staging/vc04_services/Kconfig
+++ b/drivers/staging/vc04_services/Kconfig
@@ -1,5 +1,5 @@
 menuconfig BCM_VIDEOCORE
-	bool "Broadcom VideoCore support"
+	tristate "Broadcom VideoCore support"
 	depends on HAS_DMA
 	depends on OF
 	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
-- 
2.9.0
