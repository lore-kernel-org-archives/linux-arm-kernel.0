From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Nov 2015 22:01:37 +0100
Subject: [PATCH] USB: USB_OTG does not depend on PM
Message-ID: <7521777.8ZmnT3AlIC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB_OTG initially depended on USB_SUSPEND, which was later turned into
PM_RUNTIME and finally into PM. I don't know at what point the dependency
became unnecessary but it appears to work fine without CONFIG_PM now.

However, we get lots of warnings in randconfig kernels like:

warning: (USB_OTG_FSM && FSL_USB2_OTG && USB_MV_OTG) selects USB_OTG which has unmet direct dependencies (USB_SUPPORT && USB && PM)

whenever CONFIG_PM is disabled and something else selects USB_OTG.
Let's just drop the dependency to avoid the warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I keep seeing this one in my ARM randconfig test

diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
index a99c89e78126..9c5cdf30ca74 100644
--- a/drivers/usb/core/Kconfig
+++ b/drivers/usb/core/Kconfig
@@ -43,7 +43,6 @@ config USB_DYNAMIC_MINORS
 
 config USB_OTG
 	bool "OTG support"
-	depends on PM
 	default n
 	help
 	  The most notable feature of USB OTG is support for a
