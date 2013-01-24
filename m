From: chao.xie@marvell.com (Chao Xie)
Date: Thu, 24 Jan 2013 01:38:25 -0500
Subject: [V5 PATCH 01/26] usb: gadget: mv_udc: use udc_start and udc_stop
 functions
In-Reply-To: <1359009530-28182-1-git-send-email-chao.xie@marvell.com>
References: <1359009530-28182-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1359009530-28182-2-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches converts the driver into the new style start/stop
interface. As a result the driver no longer uses the static
global the_conroller variable.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/usb/gadget/mv_udc_core.c |   79 +++++++++++++++++---------------------
 1 files changed, 35 insertions(+), 44 deletions(-)

diff --git a/drivers/usb/gadget/mv_udc_core.c b/drivers/usb/gadget/mv_udc_core.c
index 6e8b127..32a9972 100644
--- a/drivers/usb/gadget/mv_udc_core.c
+++ b/drivers/usb/gadget/mv_udc_core.c
@@ -61,9 +61,6 @@ static DECLARE_COMPLETION(release_done);
 static const char driver_name[] = "mv_udc";
 static const char driver_desc[] = DRIVER_DESC;
 
-/* controller device global variable */
-static struct mv_udc	*the_controller;
-
 static void nuke(struct mv_ep *ep, int status);
 static void stop_activity(struct mv_udc *udc, struct usb_gadget_driver *driver);
 
@@ -1268,9 +1265,8 @@ static int mv_udc_pullup(struct usb_gadget *gadget, int is_on)
 	return retval;
 }
 
-static int mv_udc_start(struct usb_gadget_driver *driver,
-		int (*bind)(struct usb_gadget *, struct usb_gadget_driver *));
-static int mv_udc_stop(struct usb_gadget_driver *driver);
+static int mv_udc_start(struct usb_gadget *, struct usb_gadget_driver *);
+static int mv_udc_stop(struct usb_gadget *, struct usb_gadget_driver *);
 /* device controller usb_gadget_ops structure */
 static const struct usb_gadget_ops mv_ops = {
 
@@ -1285,8 +1281,8 @@ static const struct usb_gadget_ops mv_ops = {
 
 	/* D+ pullup, software-controlled connect/disconnect to USB host */
 	.pullup		= mv_udc_pullup,
-	.start		= mv_udc_start,
-	.stop		= mv_udc_stop,
+	.udc_start	= mv_udc_start,
+	.udc_stop	= mv_udc_stop,
 };
 
 static int eps_init(struct mv_udc *udc)
@@ -1373,15 +1369,14 @@ static void stop_activity(struct mv_udc *udc, struct usb_gadget_driver *driver)
 	}
 }
 
-static int mv_udc_start(struct usb_gadget_driver *driver,
-		int (*bind)(struct usb_gadget *, struct usb_gadget_driver *))
+static int mv_udc_start(struct usb_gadget *gadget,
+		struct usb_gadget_driver *driver)
 {
-	struct mv_udc *udc = the_controller;
+	struct mv_udc *udc;
 	int retval = 0;
 	unsigned long flags;
 
-	if (!udc)
-		return -ENODEV;
+	udc = container_of(gadget, struct mv_udc, gadget);
 
 	if (udc->driver)
 		return -EBUSY;
@@ -1399,26 +1394,14 @@ static int mv_udc_start(struct usb_gadget_driver *driver,
 
 	spin_unlock_irqrestore(&udc->lock, flags);
 
-	retval = bind(&udc->gadget, driver);
-	if (retval) {
-		dev_err(&udc->dev->dev, "bind to driver %s --> %d\n",
-				driver->driver.name, retval);
-		udc->driver = NULL;
-		udc->gadget.dev.driver = NULL;
-		return retval;
-	}
-
 	if (!IS_ERR_OR_NULL(udc->transceiver)) {
 		retval = otg_set_peripheral(udc->transceiver->otg,
 					&udc->gadget);
 		if (retval) {
 			dev_err(&udc->dev->dev,
 				"unable to register peripheral to otg\n");
-			if (driver->unbind) {
-				driver->unbind(&udc->gadget);
-				udc->gadget.dev.driver = NULL;
-				udc->driver = NULL;
-			}
+			udc->driver = NULL;
+			udc->gadget.dev.driver = NULL;
 			return retval;
 		}
 	}
@@ -1433,13 +1416,13 @@ static int mv_udc_start(struct usb_gadget_driver *driver,
 	return 0;
 }
 
-static int mv_udc_stop(struct usb_gadget_driver *driver)
+static int mv_udc_stop(struct usb_gadget *gadget,
+		struct usb_gadget_driver *driver)
 {
-	struct mv_udc *udc = the_controller;
+	struct mv_udc *udc;
 	unsigned long flags;
 
-	if (!udc)
-		return -ENODEV;
+	udc = container_of(gadget, struct mv_udc, gadget);
 
 	spin_lock_irqsave(&udc->lock, flags);
 
@@ -1454,7 +1437,6 @@ static int mv_udc_stop(struct usb_gadget_driver *driver)
 	spin_unlock_irqrestore(&udc->lock, flags);
 
 	/* unbind gadget driver */
-	driver->unbind(&udc->gadget);
 	udc->gadget.dev.driver = NULL;
 	udc->driver = NULL;
 
@@ -1472,10 +1454,13 @@ static void mv_set_ptc(struct mv_udc *udc, u32 mode)
 
 static void prime_status_complete(struct usb_ep *ep, struct usb_request *_req)
 {
-	struct mv_udc *udc = the_controller;
+	struct mv_ep *mvep = container_of(ep, struct mv_ep, ep);
 	struct mv_req *req = container_of(_req, struct mv_req, req);
+	struct mv_udc *udc;
 	unsigned long flags;
 
+	udc = mvep->udc;
+
 	dev_info(&udc->dev->dev, "switch to test mode %d\n", req->test_mode);
 
 	spin_lock_irqsave(&udc->lock, flags);
@@ -2123,16 +2108,20 @@ static void mv_udc_vbus_work(struct work_struct *work)
 /* release device structure */
 static void gadget_release(struct device *_dev)
 {
-	struct mv_udc *udc = the_controller;
+	struct mv_udc *udc;
+
+	udc = dev_get_drvdata(_dev);
 
 	complete(udc->done);
 }
 
 static int mv_udc_remove(struct platform_device *dev)
 {
-	struct mv_udc *udc = the_controller;
+	struct mv_udc *udc;
 	int clk_i;
 
+	udc = platform_get_drvdata(dev);
+
 	usb_del_gadget_udc(&udc->gadget);
 
 	if (udc->qwork) {
@@ -2183,8 +2172,6 @@ static int mv_udc_remove(struct platform_device *dev)
 	wait_for_completion(udc->done);
 	kfree(udc);
 
-	the_controller = NULL;
-
 	return 0;
 }
 
@@ -2209,7 +2196,6 @@ static int mv_udc_probe(struct platform_device *dev)
 		return -ENOMEM;
 	}
 
-	the_controller = udc;
 	udc->done = &release_done;
 	udc->pdata = dev->dev.platform_data;
 	spin_lock_init(&udc->lock);
@@ -2400,6 +2386,7 @@ static int mv_udc_probe(struct platform_device *dev)
 	if (retval)
 		goto err_unregister;
 
+	platform_set_drvdata(dev, udc);
 	dev_info(&dev->dev, "successful probe UDC device %s clock gating.\n",
 		udc->clock_gating ? "with" : "without");
 
@@ -2431,15 +2418,16 @@ err_iounmap_capreg:
 err_put_clk:
 	for (clk_i--; clk_i >= 0; clk_i--)
 		clk_put(udc->clk[clk_i]);
-	the_controller = NULL;
 	kfree(udc);
 	return retval;
 }
 
 #ifdef CONFIG_PM
-static int mv_udc_suspend(struct device *_dev)
+static int mv_udc_suspend(struct device *dev)
 {
-	struct mv_udc *udc = the_controller;
+	struct mv_udc *udc;
+
+	udc = dev_get_drvdata(dev);
 
 	/* if OTG is enabled, the following will be done in OTG driver*/
 	if (!IS_ERR_OR_NULL(udc->transceiver))
@@ -2469,11 +2457,13 @@ static int mv_udc_suspend(struct device *_dev)
 	return 0;
 }
 
-static int mv_udc_resume(struct device *_dev)
+static int mv_udc_resume(struct device *dev)
 {
-	struct mv_udc *udc = the_controller;
+	struct mv_udc *udc;
 	int retval;
 
+	udc = dev_get_drvdata(dev);
+
 	/* if OTG is enabled, the following will be done in OTG driver*/
 	if (!IS_ERR_OR_NULL(udc->transceiver))
 		return 0;
@@ -2501,9 +2491,10 @@ static const struct dev_pm_ops mv_udc_pm_ops = {
 
 static void mv_udc_shutdown(struct platform_device *dev)
 {
-	struct mv_udc *udc = the_controller;
+	struct mv_udc *udc;
 	u32 mode;
 
+	udc = platform_get_drvdata(dev);
 	/* reset controller mode to IDLE */
 	mv_udc_enable(udc);
 	mode = readl(&udc->op_regs->usbmode);
-- 
1.7.4.1
