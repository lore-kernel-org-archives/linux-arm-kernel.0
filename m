From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Nov 2016 16:39:06 +0100
Subject: [PATCH 2/2] staging: vc04_services: clarify firmware dependency
In-Reply-To: <20161116154139.3703209-1-arnd@arndb.de>
References: <20161116154139.3703209-1-arnd@arndb.de>
Message-ID: <20161116154139.3703209-2-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The raspberrypi-firmware driver may be built as a loadable module,
which causes a link-time failure if the vc04_services driver is
built-in during compile-testing:

drivers/staging/vc04_services/vchiq.o: In function `vchiq_probe':
vchiq_connected.c:(.text.vchiq_probe+0x2c): undefined reference to `rpi_firmware_get'
drivers/staging/vc04_services/vchiq.o: In function `vchiq_platform_init':
vchiq_connected.c:(.text.vchiq_platform_init+0x1f0): undefined reference to `rpi_firmware_property'

This extends the dependency list to ensure the firmware is either
reachable, or completely disabled in case of compile-testing.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/vc04_services/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04_services/Kconfig
index 660dcedc2820..061ffd261086 100644
--- a/drivers/staging/vc04_services/Kconfig
+++ b/drivers/staging/vc04_services/Kconfig
@@ -1,6 +1,6 @@
 config BCM2835_VCHIQ
 	tristate "Videocore VCHIQ"
-	depends on RASPBERRYPI_FIRMWARE || COMPILE_TEST
+	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
 	default y
 	help
 		Kernel to VideoCore communication interface for the
-- 
2.9.0
