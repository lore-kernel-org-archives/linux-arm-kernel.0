From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Feb 2015 22:07:07 +0100
Subject: [PATCH v2] usb: renesas: fix extcon dependency
Message-ID: <12432955.vUbSfWRFHl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The renesas usbhs driver calls extcon_get_edev_by_phandle(), which
is defined in drivers/extcon/extcon-class.c, and that can be a
loadable module. If the extcon-class support is disabled, usbhs
will work correctly for all devices that do not need extcon.

However, if extcon-class is a loadable module, and usbhs is
built-in, the kernel fails to link. In order to solve that,
we need a Kconfig dependency that allows extcon to be disabled
but does not allow usbhs built-in if extcon is a module.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/usb/renesas_usbhs/Kconfig b/drivers/usb/renesas_usbhs/Kconfig
index de83b9d0cd5c..ebc99ee076ce 100644
--- a/drivers/usb/renesas_usbhs/Kconfig
+++ b/drivers/usb/renesas_usbhs/Kconfig
@@ -6,6 +6,7 @@ config USB_RENESAS_USBHS
 	tristate 'Renesas USBHS controller'
 	depends on USB_GADGET
 	depends on ARCH_SHMOBILE || SUPERH || COMPILE_TEST
+	depends on EXTCON || !EXTCON # if EXTCON=m, USBHS cannot be built-in
 	default n
 	help
 	  Renesas USBHS is a discrete USB host and peripheral controller chip
