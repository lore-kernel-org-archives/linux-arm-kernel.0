From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:59:37 +0000
Subject: [PATCH 15/20] ARM: sa1111: move USB interface register definitions
 to ohci-sa1111.c
In-Reply-To: <20120203195419.GH14129@n2100.arm.linux.org.uk>
References: <20120203195419.GH14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtPIH-00044d-EM@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the USB interface register definitions into the driver, rather
than keeping them in a common place.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/hardware/sa1111.h |   26 +-------------------------
 drivers/usb/host/ohci-sa1111.c         |   29 ++++++++++++++++++++++++-----
 2 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/arch/arm/include/asm/hardware/sa1111.h b/arch/arm/include/asm/hardware/sa1111.h
index 29e3e56..7c2bbc7 100644
--- a/arch/arm/include/asm/hardware/sa1111.h
+++ b/arch/arm/include/asm/hardware/sa1111.h
@@ -132,34 +132,10 @@
 #define SKPCR_DCLKEN	(1<<7)
 #define SKPCR_PWMCLKEN	(1<<8)
 
-/*
- * USB Host controller
- */
+/* USB Host controller */
 #define SA1111_USB		0x0400
 
 /*
- * Offsets from SA1111_USB_BASE
- */
-#define SA1111_USB_STATUS	0x0118
-#define SA1111_USB_RESET	0x011c
-#define SA1111_USB_IRQTEST	0x0120
-
-#define USB_RESET_FORCEIFRESET	(1 << 0)
-#define USB_RESET_FORCEHCRESET	(1 << 1)
-#define USB_RESET_CLKGENRESET	(1 << 2)
-#define USB_RESET_SIMSCALEDOWN	(1 << 3)
-#define USB_RESET_USBINTTEST	(1 << 4)
-#define USB_RESET_SLEEPSTBYEN	(1 << 5)
-#define USB_RESET_PWRSENSELOW	(1 << 6)
-#define USB_RESET_PWRCTRLLOW	(1 << 7)
-
-#define USB_STATUS_IRQHCIRMTWKUP  (1 <<  7)
-#define USB_STATUS_IRQHCIBUFFACC  (1 <<  8)
-#define USB_STATUS_NIRQHCIM       (1 <<  9)
-#define USB_STATUS_NHCIMFCLR      (1 << 10)
-#define USB_STATUS_USBPWRSENSE    (1 << 11)
-
-/*
  * Serial Audio Controller
  *
  * Registers
diff --git a/drivers/usb/host/ohci-sa1111.c b/drivers/usb/host/ohci-sa1111.c
index 4830008..585e53e 100644
--- a/drivers/usb/host/ohci-sa1111.c
+++ b/drivers/usb/host/ohci-sa1111.c
@@ -22,6 +22,25 @@
 #error "This file is SA-1111 bus glue.  CONFIG_SA1111 must be defined."
 #endif
 
+#define USB_STATUS	0x0118
+#define USB_RESET	0x011c
+#define USB_IRQTEST	0x0120
+
+#define USB_RESET_FORCEIFRESET	(1 << 0)
+#define USB_RESET_FORCEHCRESET	(1 << 1)
+#define USB_RESET_CLKGENRESET	(1 << 2)
+#define USB_RESET_SIMSCALEDOWN	(1 << 3)
+#define USB_RESET_USBINTTEST	(1 << 4)
+#define USB_RESET_SLEEPSTBYEN	(1 << 5)
+#define USB_RESET_PWRSENSELOW	(1 << 6)
+#define USB_RESET_PWRCTRLLOW	(1 << 7)
+
+#define USB_STATUS_IRQHCIRMTWKUP  (1 <<  7)
+#define USB_STATUS_IRQHCIBUFFACC  (1 <<  8)
+#define USB_STATUS_NIRQHCIM       (1 <<  9)
+#define USB_STATUS_NHCIMFCLR      (1 << 10)
+#define USB_STATUS_USBPWRSENSE    (1 << 11)
+
 extern int usb_disabled(void);
 
 /*-------------------------------------------------------------------------*/
@@ -45,7 +64,7 @@ static int sa1111_start_hc(struct sa1111_dev *dev)
 	 * host controller in reset.
 	 */
 	sa1111_writel(usb_rst | USB_RESET_FORCEIFRESET | USB_RESET_FORCEHCRESET,
-		      dev->mapbase + SA1111_USB_RESET);
+		      dev->mapbase + USB_RESET);
 
 	/*
 	 * Now, carefully enable the USB clock, and take
@@ -54,7 +73,7 @@ static int sa1111_start_hc(struct sa1111_dev *dev)
 	ret = sa1111_enable_device(dev);
 	if (ret == 0) {
 		udelay(11);
-		sa1111_writel(usb_rst, dev->mapbase + SA1111_USB_RESET);
+		sa1111_writel(usb_rst, dev->mapbase + USB_RESET);
 	}
 
 	return ret;
@@ -69,9 +88,9 @@ static void sa1111_stop_hc(struct sa1111_dev *dev)
 	/*
 	 * Put the USB host controller into reset.
 	 */
-	usb_rst = sa1111_readl(dev->mapbase + SA1111_USB_RESET);
+	usb_rst = sa1111_readl(dev->mapbase + USB_RESET);
 	sa1111_writel(usb_rst | USB_RESET_FORCEIFRESET | USB_RESET_FORCEHCRESET,
-		      dev->mapbase + SA1111_USB_RESET);
+		      dev->mapbase + USB_RESET);
 
 	/*
 	 * Stop the USB clock.
@@ -85,7 +104,7 @@ static void sa1111_stop_hc(struct sa1111_dev *dev)
 #if 0
 static void dump_hci_status(struct usb_hcd *hcd, const char *label)
 {
-	unsigned long status = sa1111_readl(hcd->regs + SA1111_USB_STATUS);
+	unsigned long status = sa1111_readl(hcd->regs + USB_STATUS);
 
 	dbg ("%s USB_STATUS = { %s%s%s%s%s}", label,
 	     ((status & USB_STATUS_IRQHCIRMTWKUP) ? "IRQHCIRMTWKUP " : ""),
-- 
1.7.4.4
