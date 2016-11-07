From: ahaslam@baylibre.com (Axel Haslam)
Date: Mon,  7 Nov 2016 21:39:40 +0100
Subject: [PATCH v3 02/10] USB: ohci: da8xx: Prepare to remove platform
 callbacks
In-Reply-To: <20161107203948.28324-1-ahaslam@baylibre.com>
References: <20161107203948.28324-1-ahaslam@baylibre.com>
Message-ID: <20161107203948.28324-3-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wrap the platform data callbacks into separate functions.
This will help migrate to using a regulator by providing a well defined
place to implement the regulator functions while the platform calls
are still in place and users have not been converted.

The platform callbacks will be removed on a following patch.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/usb/host/ohci-da8xx.c | 125 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 102 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 0442c64..9ed43c7 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -80,6 +80,72 @@ static void ohci_da8xx_disable(struct usb_hcd *hcd)
 	clk_disable_unprepare(da8xx_ohci->usb11_clk);
 }
 
+static int ohci_da8xx_set_power(struct usb_hcd *hcd, int on)
+{
+	struct device *dev		= hcd->self.controller;
+	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
+
+	if (hub && hub->set_power)
+		return hub->set_power(1, on);
+
+	return 0;
+}
+
+static int ohci_da8xx_get_power(struct usb_hcd *hcd)
+{
+	struct device *dev		= hcd->self.controller;
+	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
+
+	if (hub && hub->get_power)
+		return hub->get_power(1);
+
+	return 1;
+}
+
+static int ohci_da8xx_get_oci(struct usb_hcd *hcd)
+{
+	struct device *dev		= hcd->self.controller;
+	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
+
+	if (hub && hub->get_oci)
+		return hub->get_oci(1);
+
+	return 0;
+}
+
+static int ohci_da8xx_has_set_power(struct usb_hcd *hcd)
+{
+	struct device *dev		= hcd->self.controller;
+	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
+
+	if (hub && hub->set_power)
+		return 1;
+
+	return 0;
+}
+
+static int ohci_da8xx_has_oci(struct usb_hcd *hcd)
+{
+	struct device *dev		= hcd->self.controller;
+	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
+
+	if (hub && hub->get_oci)
+		return 1;
+
+	return 0;
+}
+
+static int ohci_da8xx_has_potpgt(struct usb_hcd *hcd)
+{
+	struct device *dev		= hcd->self.controller;
+	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
+
+	if (hub && hub->potpgt)
+		return 1;
+
+	return 0;
+}
+
 /*
  * Handle the port over-current indicator change.
  */
@@ -93,6 +159,26 @@ static void ohci_da8xx_ocic_handler(struct da8xx_ohci_root_hub *hub,
 		hub->set_power(port, 0);
 }
 
+static int ohci_da8xx_register_notify(struct usb_hcd *hcd)
+{
+	struct device *dev		= hcd->self.controller;
+	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
+
+	if (hub && hub->ocic_notify)
+		return hub->ocic_notify(ohci_da8xx_ocic_handler);
+
+	return 0;
+}
+
+static void ohci_da8xx_unregister_notify(struct usb_hcd *hcd)
+{
+	struct device *dev		= hcd->self.controller;
+	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
+
+	if (hub && hub->ocic_notify)
+		hub->ocic_notify(NULL);
+}
+
 static int ohci_da8xx_reset(struct usb_hcd *hcd)
 {
 	struct device *dev		= hcd->self.controller;
@@ -126,16 +212,18 @@ static int ohci_da8xx_reset(struct usb_hcd *hcd)
 	 * the correct hub descriptor...
 	 */
 	rh_a = ohci_readl(ohci, &ohci->regs->roothub.a);
-	if (hub->set_power) {
+	if (ohci_da8xx_has_set_power(hcd)) {
 		rh_a &= ~RH_A_NPS;
 		rh_a |=  RH_A_PSM;
 	}
-	if (hub->get_oci) {
+	if (ohci_da8xx_has_oci(hcd)) {
 		rh_a &= ~RH_A_NOCP;
 		rh_a |=  RH_A_OCPM;
 	}
-	rh_a &= ~RH_A_POTPGT;
-	rh_a |= hub->potpgt << 24;
+	if (ohci_da8xx_has_potpgt(hcd)) {
+		rh_a &= ~RH_A_POTPGT;
+		rh_a |= hub->potpgt << 24;
+	}
 	ohci_writel(ohci, rh_a, &ohci->regs->roothub.a);
 
 	return result;
@@ -168,7 +256,6 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				  u16 wIndex, char *buf, u16 wLength)
 {
 	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
 	int temp;
 
 	switch (typeReq) {
@@ -182,11 +269,11 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		temp = roothub_portstatus(hcd_to_ohci(hcd), wIndex - 1);
 
 		/* The port power status (PPS) bit defaults to 1 */
-		if (hub->get_power && hub->get_power(wIndex) == 0)
+		if (!ohci_da8xx_get_power(hcd))
 			temp &= ~RH_PS_PPS;
 
 		/* The port over-current indicator (POCI) bit is always 0 */
-		if (hub->get_oci && hub->get_oci(wIndex) > 0)
+		if (ohci_da8xx_get_oci(hcd))
 			temp |=  RH_PS_POCI;
 
 		/* The over-current indicator change (OCIC) bit is 0 too */
@@ -211,10 +298,7 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			dev_dbg(dev, "%sPortFeature(%u): %s\n",
 				temp ? "Set" : "Clear", wIndex, "POWER");
 
-			if (!hub->set_power)
-				return -EPIPE;
-
-			return hub->set_power(wIndex, temp) ? -EPIPE : 0;
+			return ohci_da8xx_set_power(hcd, temp) ? -EPIPE : 0;
 		case USB_PORT_FEAT_C_OVER_CURRENT:
 			dev_dbg(dev, "%sPortFeature(%u): %s\n",
 				temp ? "Set" : "Clear", wIndex,
@@ -236,15 +320,10 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 
 static int ohci_da8xx_probe(struct platform_device *pdev)
 {
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(&pdev->dev);
 	struct da8xx_ohci_hcd *da8xx_ohci;
 	struct usb_hcd	*hcd;
 	struct resource *mem;
 	int error, irq;
-
-	if (hub == NULL)
-		return -ENODEV;
-
 	hcd = usb_create_hcd(&ohci_da8xx_hc_driver, &pdev->dev,
 				dev_name(&pdev->dev));
 	if (!hcd)
@@ -290,12 +369,13 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 
 	device_wakeup_enable(hcd->self.controller);
 
-	if (hub->ocic_notify) {
-		error = hub->ocic_notify(ohci_da8xx_ocic_handler);
-		if (!error)
-			return 0;
-	}
+	error = ohci_da8xx_register_notify(hcd);
+	if (error)
+		goto err_remove_hcd;
+
+	return 0;
 
+err_remove_hcd:
 	usb_remove_hcd(hcd);
 err:
 	usb_put_hcd(hcd);
@@ -305,9 +385,8 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 static int ohci_da8xx_remove(struct platform_device *pdev)
 {
 	struct usb_hcd	*hcd = platform_get_drvdata(pdev);
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(&pdev->dev);
 
-	hub->ocic_notify(NULL);
+	ohci_da8xx_unregister_notify(hcd);
 	usb_remove_hcd(hcd);
 	usb_put_hcd(hcd);
 
-- 
2.10.1
