From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 20:09:12 +0000
Subject: [PATCH 1/5] USB: sa1111: sparse and checkpatch cleanups
In-Reply-To: <20120203200406.GI14129@n2100.arm.linux.org.uk>
References: <20120203200406.GI14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtPRY-00048Q-MI@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clean up the ohci-sa1111 driver formatting to be more compliant with
current standards, and add 'static' to various function definitions
to avoid sparse complaints about undeclared functions.  Remove the
unnecessary local declaration of 'usb_disabled', which can be found
instead in linux/usb.h.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/usb/host/ohci-sa1111.c |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/host/ohci-sa1111.c b/drivers/usb/host/ohci-sa1111.c
index 585e53e..50ebeb3 100644
--- a/drivers/usb/host/ohci-sa1111.c
+++ b/drivers/usb/host/ohci-sa1111.c
@@ -41,8 +41,6 @@
 #define USB_STATUS_NHCIMFCLR      (1 << 10)
 #define USB_STATUS_USBPWRSENSE    (1 << 11)
 
-extern int usb_disabled(void);
-
 /*-------------------------------------------------------------------------*/
 
 static int sa1111_start_hc(struct sa1111_dev *dev)
@@ -82,6 +80,7 @@ static int sa1111_start_hc(struct sa1111_dev *dev)
 static void sa1111_stop_hc(struct sa1111_dev *dev)
 {
 	unsigned int usb_rst;
+
 	printk(KERN_DEBUG "%s: stopping SA-1111 OHCI USB Controller\n",
 	       __FILE__);
 
@@ -106,7 +105,7 @@ static void dump_hci_status(struct usb_hcd *hcd, const char *label)
 {
 	unsigned long status = sa1111_readl(hcd->regs + USB_STATUS);
 
-	dbg ("%s USB_STATUS = { %s%s%s%s%s}", label,
+	dbg("%s USB_STATUS = { %s%s%s%s%s}", label,
 	     ((status & USB_STATUS_IRQHCIRMTWKUP) ? "IRQHCIRMTWKUP " : ""),
 	     ((status & USB_STATUS_IRQHCIBUFFACC) ? "IRQHCIBUFFACC " : ""),
 	     ((status & USB_STATUS_NIRQHCIM) ? "" : "IRQHCIM "),
@@ -131,15 +130,16 @@ static void dump_hci_status(struct usb_hcd *hcd, const char *label)
  *
  * Store this function in the HCD's struct pci_driver as probe().
  */
-int usb_hcd_sa1111_probe (const struct hc_driver *driver,
-			  struct sa1111_dev *dev)
+static int usb_hcd_sa1111_probe(const struct hc_driver *driver,
+	struct sa1111_dev *dev)
 {
 	struct usb_hcd *hcd;
 	int retval;
 
-	hcd = usb_create_hcd (driver, &dev->dev, "sa1111");
+	hcd = usb_create_hcd(driver, &dev->dev, "sa1111");
 	if (!hcd)
 		return -ENOMEM;
+
 	hcd->rsrc_start = dev->res.start;
 	hcd->rsrc_len = resource_size(&dev->res);
 
@@ -148,6 +148,7 @@ int usb_hcd_sa1111_probe (const struct hc_driver *driver,
 		retval = -EBUSY;
 		goto err1;
 	}
+
 	hcd->regs = dev->mapbase;
 
 	ret = sa1111_start_hc(dev);
@@ -180,9 +181,8 @@ int usb_hcd_sa1111_probe (const struct hc_driver *driver,
  * Reverses the effect of usb_hcd_sa1111_probe(), first invoking
  * the HCD's stop() method.  It is always called from a thread
  * context, normally "rmmod", "apmd", or something similar.
- *
  */
-void usb_hcd_sa1111_remove (struct usb_hcd *hcd, struct sa1111_dev *dev)
+static void usb_hcd_sa1111_remove(struct usb_hcd *hcd, struct sa1111_dev *dev)
 {
 	usb_remove_hcd(hcd);
 	sa1111_stop_hc(dev);
@@ -192,18 +192,19 @@ void usb_hcd_sa1111_remove (struct usb_hcd *hcd, struct sa1111_dev *dev)
 
 /*-------------------------------------------------------------------------*/
 
-static int __devinit
-ohci_sa1111_start (struct usb_hcd *hcd)
+static int __devinit ohci_sa1111_start(struct usb_hcd *hcd)
 {
-	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
-	int		ret;
+	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
+	int ret;
 
-	if ((ret = ohci_init(ohci)) < 0)
+	ret = ohci_init(ohci);
+	if (ret < 0)
 		return ret;
 
-	if ((ret = ohci_run (ohci)) < 0) {
-		err ("can't start %s", hcd->self.bus_name);
-		ohci_stop (hcd);
+	ret = ohci_run(ohci);
+	if (ret < 0) {
+		err("can't start %s", hcd->self.bus_name);
+		ohci_stop(hcd);
 		return ret;
 	}
 	return 0;
-- 
1.7.4.4
