From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 20:09:52 +0000
Subject: [PATCH 3/5] USB: sa1111: reorganize ohci-sa1111.c
In-Reply-To: <20120203200406.GI14129@n2100.arm.linux.org.uk>
References: <20120203200406.GI14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtPSC-00048b-Un@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Combine usb_hcd_sa1111_probe() and ohci_hcd_sa1111_drv_probe(), doing
the same for the remove methods.

Move sa1111_start_hc and sa1111_stop_hc to be located next to these
the probe/release functions, as they're only called from them.

Get rid of the /*----*/ breaker lines.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/usb/host/ohci-sa1111.c |  227 ++++++++++++++++-----------------------
 1 files changed, 93 insertions(+), 134 deletions(-)

diff --git a/drivers/usb/host/ohci-sa1111.c b/drivers/usb/host/ohci-sa1111.c
index e797f18..83f3a40 100644
--- a/drivers/usb/host/ohci-sa1111.c
+++ b/drivers/usb/host/ohci-sa1111.c
@@ -41,7 +41,78 @@
 #define USB_STATUS_NHCIMFCLR      (1 << 10)
 #define USB_STATUS_USBPWRSENSE    (1 << 11)
 
-/*-------------------------------------------------------------------------*/
+#if 0
+static void dump_hci_status(struct usb_hcd *hcd, const char *label)
+{
+	unsigned long status = sa1111_readl(hcd->regs + USB_STATUS);
+
+	dbg("%s USB_STATUS = { %s%s%s%s%s}", label,
+	     ((status & USB_STATUS_IRQHCIRMTWKUP) ? "IRQHCIRMTWKUP " : ""),
+	     ((status & USB_STATUS_IRQHCIBUFFACC) ? "IRQHCIBUFFACC " : ""),
+	     ((status & USB_STATUS_NIRQHCIM) ? "" : "IRQHCIM "),
+	     ((status & USB_STATUS_NHCIMFCLR) ? "" : "HCIMFCLR "),
+	     ((status & USB_STATUS_USBPWRSENSE) ? "USBPWRSENSE " : ""));
+}
+#endif
+
+static int __devinit ohci_sa1111_start(struct usb_hcd *hcd)
+{
+	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
+	int ret;
+
+	ret = ohci_init(ohci);
+	if (ret < 0)
+		return ret;
+
+	ret = ohci_run(ohci);
+	if (ret < 0) {
+		err("can't start %s", hcd->self.bus_name);
+		ohci_stop(hcd);
+		return ret;
+	}
+	return 0;
+}
+
+static const struct hc_driver ohci_sa1111_hc_driver = {
+	.description =		hcd_name,
+	.product_desc =		"SA-1111 OHCI",
+	.hcd_priv_size =	sizeof(struct ohci_hcd),
+
+	/*
+	 * generic hardware linkage
+	 */
+	.irq =			ohci_irq,
+	.flags =		HCD_USB11 | HCD_MEMORY,
+
+	/*
+	 * basic lifecycle operations
+	 */
+	.start =		ohci_sa1111_start,
+	.stop =			ohci_stop,
+
+	/*
+	 * managing i/o requests and associated device resources
+	 */
+	.urb_enqueue =		ohci_urb_enqueue,
+	.urb_dequeue =		ohci_urb_dequeue,
+	.endpoint_disable =	ohci_endpoint_disable,
+
+	/*
+	 * scheduling support
+	 */
+	.get_frame_number =	ohci_get_frame,
+
+	/*
+	 * root hub support
+	 */
+	.hub_status_data =	ohci_hub_status_data,
+	.hub_control =		ohci_hub_control,
+#ifdef	CONFIG_PM
+	.bus_suspend =		ohci_bus_suspend,
+	.bus_resume =		ohci_bus_resume,
+#endif
+	.start_port_reset =	ohci_start_port_reset,
+};
 
 static int sa1111_start_hc(struct sa1111_dev *dev)
 {
@@ -95,46 +166,21 @@ static void sa1111_stop_hc(struct sa1111_dev *dev)
 	sa1111_disable_device(dev);
 }
 
-
-/*-------------------------------------------------------------------------*/
-
-#if 0
-static void dump_hci_status(struct usb_hcd *hcd, const char *label)
-{
-	unsigned long status = sa1111_readl(hcd->regs + USB_STATUS);
-
-	dbg("%s USB_STATUS = { %s%s%s%s%s}", label,
-	     ((status & USB_STATUS_IRQHCIRMTWKUP) ? "IRQHCIRMTWKUP " : ""),
-	     ((status & USB_STATUS_IRQHCIBUFFACC) ? "IRQHCIBUFFACC " : ""),
-	     ((status & USB_STATUS_NIRQHCIM) ? "" : "IRQHCIM "),
-	     ((status & USB_STATUS_NHCIMFCLR) ? "" : "HCIMFCLR "),
-	     ((status & USB_STATUS_USBPWRSENSE) ? "USBPWRSENSE " : ""));
-}
-#endif
-
-/*-------------------------------------------------------------------------*/
-
-/* configure so an HC device and id are always provided */
-/* always called with process context; sleeping is OK */
-
-
 /**
- * usb_hcd_sa1111_probe - initialize SA-1111-based HCDs
- * Context: !in_interrupt()
+ * ohci_hcd_sa1111_probe - initialize SA-1111-based HCDs
  *
  * Allocates basic resources for this USB host controller, and
- * then invokes the start() method for the HCD associated with it
- * through the hotplug entry's driver_data.
- *
- * Store this function in the HCD's struct pci_driver as probe().
+ * then invokes the start() method for the HCD associated with it.
  */
-static int usb_hcd_sa1111_probe(const struct hc_driver *driver,
-	struct sa1111_dev *dev)
+static int ohci_hcd_sa1111_probe(struct sa1111_dev *dev)
 {
 	struct usb_hcd *hcd;
-	int retval;
+	int ret;
+
+	if (usb_disabled())
+		return -ENODEV;
 
-	hcd = usb_create_hcd(driver, &dev->dev, "sa1111");
+	hcd = usb_create_hcd(&ohci_sa1111_hc_driver, &dev->dev, "sa1111");
 	if (!hcd)
 		return -ENOMEM;
 
@@ -143,7 +189,7 @@ static int usb_hcd_sa1111_probe(const struct hc_driver *driver,
 
 	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
 		dbg("request_mem_region failed");
-		retval = -EBUSY;
+		ret = -EBUSY;
 		goto err1;
 	}
 
@@ -155,120 +201,34 @@ static int usb_hcd_sa1111_probe(const struct hc_driver *driver,
 
 	ohci_hcd_init(hcd_to_ohci(hcd));
 
-	retval = usb_add_hcd(hcd, dev->irq[1], 0);
-	if (retval == 0)
-		return retval;
+	ret = usb_add_hcd(hcd, dev->irq[1], 0);
+	if (ret == 0)
+		return ret;
 
 	sa1111_stop_hc(dev);
  err2:
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
  err1:
 	usb_put_hcd(hcd);
-	return retval;
+	return ret;
 }
 
-
-/* may be called without controller electrically present */
-/* may be called with controller, bus, and devices active */
-
 /**
- * usb_hcd_sa1111_remove - shutdown processing for SA-1111-based HCDs
+ * ohci_hcd_sa1111_remove - shutdown processing for SA-1111-based HCDs
  * @dev: USB Host Controller being removed
- * Context: !in_interrupt()
  *
- * Reverses the effect of usb_hcd_sa1111_probe(), first invoking
- * the HCD's stop() method.  It is always called from a thread
- * context, normally "rmmod", "apmd", or something similar.
+ * Reverses the effect of ohci_hcd_sa1111_probe(), first invoking
+ * the HCD's stop() method.
  */
-static void usb_hcd_sa1111_remove(struct usb_hcd *hcd, struct sa1111_dev *dev)
+static int ohci_hcd_sa1111_remove(struct sa1111_dev *dev)
 {
+	struct usb_hcd *hcd = sa1111_get_drvdata(dev);
+
 	usb_remove_hcd(hcd);
 	sa1111_stop_hc(dev);
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 	usb_put_hcd(hcd);
-}
-
-/*-------------------------------------------------------------------------*/
 
-static int __devinit ohci_sa1111_start(struct usb_hcd *hcd)
-{
-	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
-	int ret;
-
-	ret = ohci_init(ohci);
-	if (ret < 0)
-		return ret;
-
-	ret = ohci_run(ohci);
-	if (ret < 0) {
-		err("can't start %s", hcd->self.bus_name);
-		ohci_stop(hcd);
-		return ret;
-	}
-	return 0;
-}
-
-/*-------------------------------------------------------------------------*/
-
-static const struct hc_driver ohci_sa1111_hc_driver = {
-	.description =		hcd_name,
-	.product_desc =		"SA-1111 OHCI",
-	.hcd_priv_size =	sizeof(struct ohci_hcd),
-
-	/*
-	 * generic hardware linkage
-	 */
-	.irq =			ohci_irq,
-	.flags =		HCD_USB11 | HCD_MEMORY,
-
-	/*
-	 * basic lifecycle operations
-	 */
-	.start =		ohci_sa1111_start,
-	.stop =			ohci_stop,
-
-	/*
-	 * managing i/o requests and associated device resources
-	 */
-	.urb_enqueue =		ohci_urb_enqueue,
-	.urb_dequeue =		ohci_urb_dequeue,
-	.endpoint_disable =	ohci_endpoint_disable,
-
-	/*
-	 * scheduling support
-	 */
-	.get_frame_number =	ohci_get_frame,
-
-	/*
-	 * root hub support
-	 */
-	.hub_status_data =	ohci_hub_status_data,
-	.hub_control =		ohci_hub_control,
-#ifdef	CONFIG_PM
-	.bus_suspend =		ohci_bus_suspend,
-	.bus_resume =		ohci_bus_resume,
-#endif
-	.start_port_reset =	ohci_start_port_reset,
-};
-
-/*-------------------------------------------------------------------------*/
-
-static int ohci_hcd_sa1111_drv_probe(struct sa1111_dev *dev)
-{
-	int ret;
-
-	if (usb_disabled())
-		return -ENODEV;
-
-	ret = usb_hcd_sa1111_probe(&ohci_sa1111_hc_driver, dev);
-	return ret;
-}
-
-static int ohci_hcd_sa1111_drv_remove(struct sa1111_dev *dev)
-{
-	struct usb_hcd *hcd = sa1111_get_drvdata(dev);
-
-	usb_hcd_sa1111_remove(hcd, dev);
 	return 0;
 }
 
@@ -278,7 +238,6 @@ static struct sa1111_driver ohci_hcd_sa1111_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.devid		= SA1111_DEVID_USB,
-	.probe		= ohci_hcd_sa1111_drv_probe,
-	.remove		= ohci_hcd_sa1111_drv_remove,
+	.probe		= ohci_hcd_sa1111_probe,
+	.remove		= ohci_hcd_sa1111_remove,
 };
-
-- 
1.7.4.4
