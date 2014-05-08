From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  8 May 2014 15:52:15 +0200
Subject: [PATCH 2/8] usb: musb: tusb-dma can't be built-in if tusb is not
In-Reply-To: <1399557141-1346645-1-git-send-email-arnd@arndb.de>
References: <1399557141-1346645-1-git-send-email-arnd@arndb.de>
Message-ID: <1399557141-1346645-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A configuration with CONFIG_USB_MUSB_HDRC=y, CONFIG_USB_TUSB_OMAP_DMA=y
and CONFIG_USB_MUSB_TUSB6010=m causes a link failure because of the
dependency on the tusb_get_revision symbol:

(.text+0x154ce8): undefined reference to `tusb_get_revision'

This patch ensures that either MUSB_HDRC and MUSB_TUSB6010 are
both modules or both built-in, which are the valid configurations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap at vger.kernel.org
---
 drivers/usb/musb/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 8b78979..618b152 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -144,7 +144,7 @@ config USB_TI_CPPI41_DMA
 
 config USB_TUSB_OMAP_DMA
 	bool 'TUSB 6010'
-	depends on USB_MUSB_TUSB6010
+	depends on USB_MUSB_TUSB6010 = USB_MUSB_HDRC # both built-in or both modules
 	depends on ARCH_OMAP
 	help
 	  Enable DMA transfers on TUSB 6010 when OMAP DMA is available.
-- 
1.8.3.2
