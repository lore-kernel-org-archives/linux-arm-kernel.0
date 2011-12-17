From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sat, 17 Dec 2011 20:29:14 +0100
Subject: [PATCH 6/7] s3c-hsudc: use udc_start and udc_stop functions
In-Reply-To: <201112172023.05519.heiko@sntech.de>
References: <201112172023.05519.heiko@sntech.de>
Message-ID: <201112172029.14823.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

udc_start and udc_stop reduce code duplication in comparison to
start and stop generalising calls done by all drivers
(i.e. bind and unbind) and moving these calls to common code.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/usb/gadget/s3c-hsudc.c |   44 ++++++++++++---------------------------
 1 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsudc.c b/drivers/usb/gadget/s3c-hsudc.c
index fa2ae7a..a47bfa0 100644
--- a/drivers/usb/gadget/s3c-hsudc.c
+++ b/drivers/usb/gadget/s3c-hsudc.c
@@ -282,8 +282,7 @@ static void s3c_hsudc_nuke_ep(struct s3c_hsudc_ep *hsep, int status)
  * All the endpoints are stopped and any pending transfer requests if any on
  * the endpoint are terminated.
  */
-static void s3c_hsudc_stop_activity(struct s3c_hsudc *hsudc,
-			  struct usb_gadget_driver *driver)
+static void s3c_hsudc_stop_activity(struct s3c_hsudc *hsudc)
 {
 	struct s3c_hsudc_ep *hsep;
 	int epnum;
@@ -295,10 +294,6 @@ static void s3c_hsudc_stop_activity(struct s3c_hsudc *hsudc,
 		hsep->stopped = 1;
 		s3c_hsudc_nuke_ep(hsep, -ESHUTDOWN);
 	}
-
-	spin_unlock(&hsudc->lock);
-	driver->disconnect(&hsudc->gadget);
-	spin_lock(&hsudc->lock);
 }
 
 /**
@@ -1135,16 +1130,15 @@ static irqreturn_t s3c_hsudc_irq(int irq, void *_dev)
 	return IRQ_HANDLED;
 }
 
-static int s3c_hsudc_start(struct usb_gadget_driver *driver,
-		int (*bind)(struct usb_gadget *))
+static int s3c_hsudc_start(struct usb_gadget *g,
+		struct usb_gadget_driver *driver)
 {
 	struct s3c_hsudc *hsudc = the_controller;
 	int ret;
 
 	if (!driver
 		|| driver->max_speed < USB_SPEED_FULL
-		|| !bind
-		|| !driver->unbind || !driver->disconnect || !driver->setup)
+		|| !driver->setup)
 		return -EINVAL;
 
 	if (!hsudc)
@@ -1155,17 +1149,6 @@ static int s3c_hsudc_start(struct usb_gadget_driver *driver,
 
 	hsudc->driver = driver;
 	hsudc->gadget.dev.driver = &driver->driver;
-	hsudc->gadget.speed = USB_SPEED_UNKNOWN;
-
-	ret = bind(&hsudc->gadget);
-	if (ret) {
-		dev_err(hsudc->dev, "%s: bind failed\n", hsudc->gadget.name);
-		device_del(&hsudc->gadget.dev);
-
-		hsudc->driver = NULL;
-		hsudc->gadget.dev.driver = NULL;
-		return ret;
-	}
 
 	/* connect to bus through transceiver */
 	if (hsudc->transceiver) {
@@ -1173,8 +1156,6 @@ static int s3c_hsudc_start(struct usb_gadget_driver *driver,
 		if (ret) {
 			dev_err(hsudc->dev, "%s: can't bind to transceiver\n",
 					hsudc->gadget.name);
-			driver->unbind(&hsudc->gadget);
-
 			hsudc->driver = NULL;
 			hsudc->gadget.dev.driver = NULL;
 			return ret;
@@ -1192,7 +1173,8 @@ static int s3c_hsudc_start(struct usb_gadget_driver *driver,
 	return 0;
 }
 
-static int s3c_hsudc_stop(struct usb_gadget_driver *driver)
+static int s3c_hsudc_stop(struct usb_gadget *g,
+		struct usb_gadget_driver *driver)
 {
 	struct s3c_hsudc *hsudc = the_controller;
 	unsigned long flags;
@@ -1200,21 +1182,22 @@ static int s3c_hsudc_stop(struct usb_gadget_driver *driver)
 	if (!hsudc)
 		return -ENODEV;
 
-	if (!driver || driver != hsudc->driver || !driver->unbind)
+	if (!driver || driver != hsudc->driver)
 		return -EINVAL;
 
 	spin_lock_irqsave(&hsudc->lock, flags);
-	hsudc->driver = 0;
+	hsudc->driver = NULL;
+	hsudc->gadget.dev.driver = NULL;
+	hsudc->gadget.speed = USB_SPEED_UNKNOWN;
 	s3c_hsudc_uninit_phy();
 	if (hsudc->pd->gpio_uninit)
 		hsudc->pd->gpio_uninit();
-	s3c_hsudc_stop_activity(hsudc, driver);
+	s3c_hsudc_stop_activity(hsudc);
 	spin_unlock_irqrestore(&hsudc->lock, flags);
 
 	if (hsudc->transceiver)
 		(void) otg_set_peripheral(hsudc->transceiver, NULL);
 
-	driver->unbind(&hsudc->gadget);
 	disable_irq(hsudc->irq);
 
 	dev_info(hsudc->dev, "unregistered gadget driver '%s'\n",
@@ -1247,8 +1230,8 @@ static int s3c_hsudc_vbus_draw(struct usb_gadget *gadget, unsigned mA)
 
 static struct usb_gadget_ops s3c_hsudc_gadget_ops = {
 	.get_frame	= s3c_hsudc_gadget_getframe,
-	.start		= s3c_hsudc_start,
-	.stop		= s3c_hsudc_stop,
+	.udc_start	= s3c_hsudc_start,
+	.udc_stop	= s3c_hsudc_stop,
 	.vbus_draw	= s3c_hsudc_vbus_draw,
 };
 
@@ -1318,6 +1301,7 @@ static int __devinit s3c_hsudc_probe(struct platform_device *pdev)
 
 	hsudc->gadget.is_otg = 0;
 	hsudc->gadget.is_a_peripheral = 0;
+	hsudc->gadget.speed = USB_SPEED_UNKNOWN;
 
 	s3c_hsudc_setup_ep(hsudc);
 
-- 
1.7.2.3
