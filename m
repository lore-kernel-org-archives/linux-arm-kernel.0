From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Mar 2013 16:44:07 +0100
Subject: [RFC] USB: EHCI: hot-fix OMAP and Orion multiplatform config
Message-ID: <1363362247-9542-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A number of ARM platforms were changed in linux-3.9 so they can be enabled
at a single kernel configuration. Unfortunately, the necessary changes for
the EHCI driver were not ready in time and the first attempt to split out
the EHCI bus glues into separate modules had to get reverted before the
merge window.

This means we are still stuck with a situation where enabling any
combination of more than one of the OMAP, MVEBU/Orion and VT8500/WM8x50
platforms at the same time leaves us with an EHCI driver that does
not work properly and spits out this build warning:

ehci-hcd.c:1277:0: warning: "PLATFORM_DRIVER" redefined [enabled by default]
ehci-hcd.c:1257:0: note: this is the location of the previous definition
ehci-hcd.c:1297:0: warning: "PLATFORM_DRIVER" redefined [enabled by default]
ehci-hcd.c:1277:0: note: this is the location of the previous definition
In file included from ehci-hcd.c:1256:0:
ehci-omap.c:311:31: warning: 'ehci_hcd_omap_driver' defined but not used [-Wunused-variable]
In file included from ehci-hcd.c:1276:0:
ehci-orion.c:334:31: warning: 'ehci_orion_driver' defined but not used [-Wunused-variable]
ehci-hcd.c:1277:0: warning: "PLATFORM_DRIVER" redefined [enabled by default]
ehci-hcd.c:1257:0: note: this is the location of the previous definition
ehci-hcd.c:1297:0: warning: "PLATFORM_DRIVER" redefined [enabled by default]
ehci-hcd.c:1277:0: note: this is the location of the previous definition

This is the simplest patch I could come up with that will restore some
sanity in multiplatform configuration and allow us to build an ARM
allyesconfig kernel. Disallowing the broken configuration in Kconfig
would actually end up in a larger patch and more regression potential
than this one.

We had a similar situation in 3.8 with a conflict between Orion and MXC,
and Alan Stern objected to the simple hack back then and instead provided
a better full conversion of the MXC backend in patch dba63b2f7. A proper
patch for OMAP was submitted in January but also did not make it into 3.9,
see https://patchwork.kernel.org/patch/2055131.

I expect that for 3.10 we will be able to do this correctly and
turn all ARM bus glues into separate modules, ripping out the
code that this patch changes.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roger Quadros <rogerq@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>
CC: Jason Cooper <jason@lakedaemon.net>
---
 drivers/usb/host/ehci-hcd.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index dd1d41d..c750d71 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1254,7 +1254,7 @@ MODULE_LICENSE ("GPL");
 
 #ifdef CONFIG_USB_EHCI_HCD_OMAP
 #include "ehci-omap.c"
-#define        PLATFORM_DRIVER         ehci_hcd_omap_driver
+#define	OMAP_PLATFORM_DRIVER	ehci_hcd_omap_driver
 #endif
 
 #ifdef CONFIG_PPC_PS3
@@ -1274,7 +1274,7 @@ MODULE_LICENSE ("GPL");
 
 #ifdef CONFIG_PLAT_ORION
 #include "ehci-orion.c"
-#define	PLATFORM_DRIVER		ehci_orion_driver
+#define	ORION_PLATFORM_DRIVER	ehci_orion_driver
 #endif
 
 #ifdef CONFIG_USB_W90X900_EHCI
@@ -1409,10 +1409,20 @@ static int __init ehci_hcd_init(void)
 	if (retval < 0)
 		goto clean4;
 #endif
+
+#ifdef OMAP_PLATFORM_DRIVER
+	retval = platform_driver_register(&OMAP_PLATFORM_DRIVER);
+	if (retval < 0)
+		goto clean5;
+#endif
 	return retval;
 
+#ifdef OMAP_PLATFORM_DRIVER
+	/* platform_driver_unregister(&OMAP_PLATFORM_DRIVER); */
+clean5:
+#endif
 #ifdef XILINX_OF_PLATFORM_DRIVER
-	/* platform_driver_unregister(&XILINX_OF_PLATFORM_DRIVER); */
+	platform_driver_unregister(&XILINX_OF_PLATFORM_DRIVER);
 clean4:
 #endif
 #ifdef OF_PLATFORM_DRIVER
@@ -1423,6 +1433,10 @@ clean3:
 	ps3_ehci_driver_unregister(&PS3_SYSTEM_BUS_DRIVER);
 clean2:
 #endif
+#ifdef ORION_PLATFORM_DRIVER
+	platform_driver_unregister(&ORION_PLATFORM_DRIVER);
+clean1:
+#endif
 #ifdef PLATFORM_DRIVER
 	platform_driver_unregister(&PLATFORM_DRIVER);
 clean0:
@@ -1439,12 +1453,18 @@ module_init(ehci_hcd_init);
 
 static void __exit ehci_hcd_cleanup(void)
 {
+#ifdef OMAP_PLATFORM_DRIVER
+	platform_driver_unregister(&OMAP_PLATFORM_DRIVER);
+#endif
 #ifdef XILINX_OF_PLATFORM_DRIVER
 	platform_driver_unregister(&XILINX_OF_PLATFORM_DRIVER);
 #endif
 #ifdef OF_PLATFORM_DRIVER
 	platform_driver_unregister(&OF_PLATFORM_DRIVER);
 #endif
+#ifdef ORION_PLATFORM_DRIVER
+	platform_driver_unregister(&ORION_PLATFORM_DRIVER);
+#endif
 #ifdef PLATFORM_DRIVER
 	platform_driver_unregister(&PLATFORM_DRIVER);
 #endif
-- 
1.8.1.2
