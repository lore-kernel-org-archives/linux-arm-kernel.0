From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Nov 2015 14:52:50 +0100
Subject: [PATCH] usb: phy: allow modular build of DT helper
Message-ID: <5036893.cOhfcTcQFz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This one is a curious Kbuild glitch: The drivers/usb/phy/of.o file
is currently always built-in if CONFIG_OF is set, independent of
whether USB is modular or not.

For the case of CONFIG_USB=m && CONFIG_USB_GADGET=m && CONFIG_USB_PHY=n,
however the file is not built at all, because drivers/Makefile only
looks in drivers/usb/ for modules and not for built-in code. This
results in a link error with in the chipidea module:

ERROR: of_usb_get_phy_mode [drivers/usb/chipidea/ci_hdrc.ko] undefined!

To work around this behavior, this changes the usb-phy Makefile to
create a module named usb-phy-of.ko for this one file whenever
both CONFIG_USB and CONFIG_USB_GADGET are set to 'm'. This seems
to be the correct behavior as it also avoids unnecessary built-in
code when everything else related to USB is a module, and it nicely
avoids the link error.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
index 19c0dccbb116..4367fbc1870b 100644
--- a/drivers/usb/phy/Makefile
+++ b/drivers/usb/phy/Makefile
@@ -2,7 +2,11 @@
 # Makefile for physical layer USB drivers
 #
 obj-$(CONFIG_USB_PHY)			+= phy.o
-obj-$(CONFIG_OF)			+= of.o
+
+ifdef CONFIG_OF
+usb-phy-of-objs				:= of.o
+obj-$(CONFIG_USB_COMMON)		+= usb-phy-of.o
+endif
 
 # transceiver drivers, keep the list sorted
 
