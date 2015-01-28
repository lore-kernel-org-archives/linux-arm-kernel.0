From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 22:50:04 +0100
Subject: [PATCH] usb: musb: add generic usb phy dependencies
Message-ID: <4595774.yLOm5IvvqR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Multiple musb glue drivers depend on the generic usb phy support,
but fail to list it as a dependency in Kconfig. This results
in build erros like:

drivers/built-in.o: In function `am35x_remove':
:(.text+0xadacc): undefined reference to `usb_phy_generic_unregister'
drivers/built-in.o: In function `am35x_probe':
:(.text+0xae1c8): undefined reference to `usb_phy_generic_register'
:(.text+0xae244): undefined reference to `usb_phy_generic_unregister'
drivers/built-in.o: In function `jz4740_remove':
:(.text+0xaf648): undefined reference to `usb_phy_generic_unregister'
drivers/built-in.o: In function `jz4740_musb_init':
:(.text+0xaf694): undefined reference to `usb_phy_generic_register'

This adds the ones that are missing.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index b005010240e5..26c835f1b726 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -63,11 +63,13 @@ comment "Platform Glue Layer"
 config USB_MUSB_DAVINCI
 	tristate "DaVinci"
 	depends on ARCH_DAVINCI_DMx
+	depends on NOP_USB_XCEIV
 	depends on BROKEN
 
 config USB_MUSB_DA8XX
 	tristate "DA8xx/OMAP-L1x"
 	depends on ARCH_DAVINCI_DA8XX
+	depends on NOP_USB_XCEIV
 	depends on BROKEN
 
 config USB_MUSB_TUSB6010
@@ -83,6 +85,7 @@ config USB_MUSB_OMAP2PLUS
 config USB_MUSB_AM35X
 	tristate "AM35x"
 	depends on ARCH_OMAP
+	depends on NOP_USB_XCEIV
 
 config USB_MUSB_DSPS
 	tristate "TI DSPS platforms"
@@ -93,6 +96,7 @@ config USB_MUSB_DSPS
 config USB_MUSB_BLACKFIN
 	tristate "Blackfin"
 	depends on (BF54x && !BF544) || (BF52x && ! BF522 && !BF523)
+	depends on NOP_USB_XCEIV
 
 config USB_MUSB_UX500
 	tristate "Ux500 platforms"
@@ -100,6 +104,7 @@ config USB_MUSB_UX500
 
 config USB_MUSB_JZ4740
 	tristate "JZ4740"
+	depends on NOP_USB_XCEIV
 	depends on MACH_JZ4740 || COMPILE_TEST
 	depends on USB_MUSB_GADGET
 	depends on USB_OTG_BLACKLIST_HUB
