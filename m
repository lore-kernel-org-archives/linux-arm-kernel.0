From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 08 Oct 2011 17:16:49 +0200
Subject: [PATCH 3/7] ARM: imx: export imx_ioremap
In-Reply-To: <109850802.HMOqKGRdrl@wuerfel>
References: <20111004092015.GM31404@pengutronix.de>
	<20111008101322.GH31404@pengutronix.de>
	<109850802.HMOqKGRdrl@wuerfel>
Message-ID: <2199742.hioYdt4QXg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arch_ioremap function on i.MX is now an indirect function pointer.
In order to use it from any loadable module, the pointer itself
has to be exported.

ERROR: "imx_ioremap" [drivers/video/tmiofb.ko] undefined!
ERROR: "imx_ioremap" [drivers/usb/host/sl811-hcd.ko] undefined!
ERROR: "imx_ioremap" [drivers/usb/host/r8a66597-hcd.ko] undefined!
ERROR: "imx_ioremap" [drivers/usb/host/oxu210hp-hcd.ko] undefined!
ERROR: "imx_ioremap" [drivers/usb/gadget/r8a66597-udc.ko] undefined!

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/plat-mxc/system.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/system.c b/arch/arm/plat-mxc/system.c
index 9dad8dc..45e1b5f 100644
--- a/arch/arm/plat-mxc/system.c
+++ b/arch/arm/plat-mxc/system.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/delay.h>
+#include <linux/module.h>
 
 #include <mach/hardware.h>
 #include <mach/common.h>
@@ -30,6 +31,7 @@
 
 void (*imx_idle)(void) = NULL;
 void __iomem *(*imx_ioremap)(unsigned long, size_t, unsigned int) = NULL;
+EXPORT_SYMBOL_GPL(imx_ioremap);
 
 static void __iomem *wdog_base;
 
-- 
1.7.5.4
