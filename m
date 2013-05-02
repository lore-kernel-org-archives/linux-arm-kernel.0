From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 May 2013 17:16:19 +0200
Subject: [PATCH, RFC 15/22] USB: EHCI: remove bogus #error
In-Reply-To: <1367507786-505303-1-git-send-email-arnd@arndb.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
Message-ID: <1367507786-505303-16-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EHCI host controller driver can be built standalone now,
without enabling any of the available bus glue drivers, so
there is not really a reason to error out here:

drivers/usb/host/ehci-hcd.c:1303:2: error:
 #error "missing bus glue for ehci-hcd"  #error "missing bus glue for ehci-hcd"

The alternative would be to change the Kconfig code to build
the ehci-hcd module only if any of the symbols below are
in fact enabled.

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/host/ehci-hcd.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 312fc10..246e124 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1286,23 +1286,6 @@ MODULE_LICENSE ("GPL");
 #define	PLATFORM_DRIVER		ehci_hcd_sead3_driver
 #endif
 
-#if !IS_ENABLED(CONFIG_USB_EHCI_PCI) && \
-	!IS_ENABLED(CONFIG_USB_EHCI_HCD_PLATFORM) && \
-	!IS_ENABLED(CONFIG_USB_CHIPIDEA_HOST) && \
-	!IS_ENABLED(CONFIG_USB_EHCI_MXC) && \
-	!IS_ENABLED(CONFIG_USB_EHCI_HCD_OMAP) && \
-	!IS_ENABLED(CONFIG_USB_EHCI_HCD_ORION) && \
-	!IS_ENABLED(CONFIG_USB_EHCI_HCD_SPEAR) && \
-	!IS_ENABLED(CONFIG_USB_EHCI_S5P) && \
-	!IS_ENABLED(CONFIG_USB_EHCI_HCD_AT91) && \
-	!IS_ENABLED(CONFIG_USB_EHCI_MSM) && \
-	!defined(PLATFORM_DRIVER) && \
-	!defined(PS3_SYSTEM_BUS_DRIVER) && \
-	!defined(OF_PLATFORM_DRIVER) && \
-	!defined(XILINX_OF_PLATFORM_DRIVER)
-#error "missing bus glue for ehci-hcd"
-#endif
-
 static int __init ehci_hcd_init(void)
 {
 	int retval = 0;
-- 
1.8.1.2
