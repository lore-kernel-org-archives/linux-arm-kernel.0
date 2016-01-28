From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Jan 2016 17:20:54 +0100
Subject: [PATCH 4/7] usb: fsl: drop USB_FSL_MPH_DR_OF Kconfig symbol
In-Reply-To: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
Message-ID: <1453998087-3489894-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB_FSL_MPH_DR_OF symbol is used to ensure the code that interprets
the DR device node is built whenever one of the two drivers (EHCI or
UDC) for the platform is enabled. However, if CONFIG_USB is disabled
and we only support gadget mode, this causes a Kconfig warning:

warning: (USB_FSL_USB2) selects USB_FSL_MPH_DR_OF which has unmet direct dependencies (USB_SUPPORT && USB)

We can avoid this warning by simply no longer using the symbol,
and making sure we enter the drivers/usb/host/ directory when
the UDC driver is enabled that needs the file, and then we use
Makefile syntax to ensure the file is built-in if needed.

There is currently a dependency on CONFIG_OF, but this is redundant,
as we already know that this is set unconditionally for the platforms
that use this driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/Makefile           | 2 +-
 drivers/usb/gadget/udc/Kconfig | 1 -
 drivers/usb/host/Kconfig       | 4 ----
 drivers/usb/host/Makefile      | 3 ++-
 4 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index d5c57f1e98fd..dca78565eb55 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -26,7 +26,7 @@ obj-$(CONFIG_USB_U132_HCD)	+= host/
 obj-$(CONFIG_USB_R8A66597_HCD)	+= host/
 obj-$(CONFIG_USB_HWA_HCD)	+= host/
 obj-$(CONFIG_USB_IMX21_HCD)	+= host/
-obj-$(CONFIG_USB_FSL_MPH_DR_OF)	+= host/
+obj-$(CONFIG_USB_FSL_USB2)	+= host/
 obj-$(CONFIG_USB_FOTG210_HCD)	+= host/
 obj-$(CONFIG_USB_MAX3421_HCD)	+= host/
 
diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index 753c29bd11ad..d38cd69b470e 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -74,7 +74,6 @@ config USB_BCM63XX_UDC
 config USB_FSL_USB2
 	tristate "Freescale Highspeed USB DR Peripheral Controller"
 	depends on FSL_SOC || ARCH_MXC
-	select USB_FSL_MPH_DR_OF if OF
 	help
 	   Some of Freescale PowerPC and i.MX processors have a High Speed
 	   Dual-Role(DR) USB controller, which supports device mode.
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 1f117c360ebb..2f73cc5fab71 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -121,9 +121,6 @@ config USB_EHCI_TT_NEWSCHED
 
 	  If unsure, say Y.
 
-config USB_FSL_MPH_DR_OF
-	tristate
-
 if USB_EHCI_HCD
 
 config USB_EHCI_PCI
@@ -156,7 +153,6 @@ config USB_EHCI_FSL
 	tristate "Support for Freescale PPC on-chip EHCI USB controller"
 	depends on FSL_SOC
 	select USB_EHCI_ROOT_HUB_TT
-	select USB_FSL_MPH_DR_OF if OF
 	---help---
 	  Variation of ARC USB block used in some Freescale chips.
 
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 65a06b4382bf..a9ddd3c9ec94 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -74,7 +74,8 @@ obj-$(CONFIG_USB_U132_HCD)	+= u132-hcd.o
 obj-$(CONFIG_USB_R8A66597_HCD)	+= r8a66597-hcd.o
 obj-$(CONFIG_USB_HWA_HCD)	+= hwa-hc.o
 obj-$(CONFIG_USB_IMX21_HCD)	+= imx21-hcd.o
-obj-$(CONFIG_USB_FSL_MPH_DR_OF)	+= fsl-mph-dr-of.o
+obj-$(CONFIG_USB_FSL_USB2)	+= fsl-mph-dr-of.o
+obj-$(CONFIG_USB_EHCI_FSL)	+= fsl-mph-dr-of.o
 obj-$(CONFIG_USB_EHCI_FSL)	+= ehci-fsl.o
 obj-$(CONFIG_USB_HCD_BCMA)	+= bcma-hcd.o
 obj-$(CONFIG_USB_HCD_SSB)	+= ssb-hcd.o
-- 
2.7.0
