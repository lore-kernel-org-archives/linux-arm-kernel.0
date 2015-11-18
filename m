From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Nov 2015 17:18:40 +0100
Subject: [PATCH] usb: musb: USB_TI_CPPI41_DMA requires dmaengine support
Message-ID: <4370741.70D0kgBgnp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPPI-4.1 driver selects TI_CPPI41, which is a dmaengine
driver and that may not be available when CONFIG_DMADEVICES
is not set:

warning: (USB_TI_CPPI41_DMA) selects TI_CPPI41 which has unmet direct dependencies (DMADEVICES && ARCH_OMAP)

This adds an extra dependency to avoid generating warnings in randconfig
builds. Ideally we'd remove the 'select' statement, but that has the
potential to break defconfig files.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 411dd19c682d ("usb: musb: Kconfig: Select the DMA driver if DMA mode of MUSB is enabled")

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 1f2037bbeb0d..45c83baf675d 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -159,7 +159,7 @@ config USB_TI_CPPI_DMA
 
 config USB_TI_CPPI41_DMA
 	bool 'TI CPPI 4.1 (AM335x)'
-	depends on ARCH_OMAP
+	depends on ARCH_OMAP && DMADEVICES
 	select TI_CPPI41
 
 config USB_TUSB_OMAP_DMA
