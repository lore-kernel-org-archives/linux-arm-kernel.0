From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Apr 2013 17:54:32 +0200
Subject: [PATCH] usb: phy: phy core cannot yet be a module
In-Reply-To: <1366732475-479886-1-git-send-email-arnd@arndb.de>
References: <1366732475-479886-1-git-send-email-arnd@arndb.de>
Message-ID: <1366732475-479886-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A lot of platform code calls into the usb phy core at the moment, which
does not work if it is built as a loadable module. This will hopefully
change when those platforms are all converted to DT based probing,
but for now, the easiest solution is to change it from "tristate"
to "bool".

This solves at least these ARM allmodconfig build errors:

arch/arm/mach-imx/built-in.o: In function `imx_otg_ulpi_create':
arch/arm/mach-imx/ulpi.c:117: undefined reference to `otg_ulpi_create'
arch/arm/mach-omap2/built-in.o: In function `usbhs_init_phys':
arch/arm/mach-omap2/usb-host.c:652: undefined reference to `usb_bind_phy'
arch/arm/mach-omap2/built-in.o: In function `omap_2430sdp_init':
arch/arm/mach-omap2/board-2430sdp.c:236: undefined reference to `usb_bind_phy'
arch/arm/mach-omap2/built-in.o: In function `omap3_beagle_init':
arch/arm/mach-omap2/board-omap3beagle.c:554: undefined reference to `usb_bind_phy'
arch/arm/mach-omap2/built-in.o: In function `devkit8000_init':
arch/arm/mach-omap2/board-devkit8000.c:596: undefined reference to `usb_bind_phy'
arch/arm/mach-omap2/built-in.o: In function `omap_ldp_init':
arch/arm/mach-omap2/board-ldp.c:379: undefined reference to `usb_bind_phy'
drivers/built-in.o: In function `ab8500_charger_probe':
drivers/power/ab8500_charger.c:3629: undefined reference to `usb_get_phy'
drivers/power/ab8500_charger.c:3706: undefined reference to `usb_put_phy'
drivers/built-in.o: In function `ab8500_charger_remove':
drivers/power/ab8500_charger.c:3411: undefined reference to `usb_put_phy'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/phy/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 21153d1..371d0e7 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -2,7 +2,7 @@
 # Physical Layer USB driver configuration
 #
 menuconfig USB_PHY
-	tristate "USB Physical Layer drivers"
+	bool "USB Physical Layer drivers"
 	help
 	  USB controllers (those which are host, device or DRD) need a
 	  device to handle the physical layer signalling, commonly called
-- 
1.8.1.2
