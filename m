From: arnd@arndb.de (Arnd Bergmann)
Date: Sun,  2 Oct 2011 16:45:46 +0200
Subject: [PATCH 16/30] usb/musb: HDRC depends on TWL4030_CORE for OMAP3/4
In-Reply-To: <1317566760-25681-1-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Message-ID: <1317566760-25681-17-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The musb_hdrc driver tries to select TWL4030_USB or TWL6030_USB
on some platforms, but those symbols in turn depend on TWL4030_CORE.
Trying not to spread the 'select' further, this makes the driver
depend on the TWL4030_CORE for the platforms that do other selects.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/musb/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index d596fb2..b6732ee 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -7,6 +7,7 @@
 config USB_MUSB_HDRC
 	depends on USB && USB_GADGET
 	depends on (ARM || (BF54x && !BF544) || (BF52x && !BF522 && !BF523))
+	depends on TWL4030_CORE || !(MACH_OMAP_3430SDP || MACH_OMAP_4430SDP || MACH_OMAP4_PANDA)
 	select NOP_USB_XCEIV if (ARCH_DAVINCI || MACH_OMAP3EVM || BLACKFIN)
 	select TWL4030_USB if MACH_OMAP_3430SDP
 	select TWL6030_USB if MACH_OMAP_4430SDP || MACH_OMAP4_PANDA
-- 
1.7.5.4
