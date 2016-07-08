From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri,  8 Jul 2016 22:09:05 +0200
Subject: [PATCH 1/3] usb: gadget: pxa27x: add phy notifier event handler
Message-ID: <1468008547-10925-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the legacy behavior, and USB phy, upon detection a VBus signal, was
calling usb_gadget_vbus_(dis)connect().

This model doesn't work if the phy is generic and doesn't have an
adherence to the gadget API.

Instead of relying on the phy to call the gadget API, hook up the phy
notifier to report the VBus event, and upon it call the usb gadget API
ourselves.

This brings a new ordering problem, as before even if the usb_get_phy()
was failing because the UDC was probed before the phy, the phy would
call the gadget anyway, making the VBus connection event forwarded to
the gadget. Now we rely on the notifier, we have to ensure the
xxx_get_phy() does indeed work.

In order to cope with this, it is assumed that :
 - for legacy platform_data machine, as the ordering cannot be ensured,
   the phy must call usb_gadget_vbus_(dis)connect, such as
   phy-gpio-vbus-usb.c
 - for new devicetree platforms, we'll rely on the probe deferral, and
   the phy can be gadget API agnostic.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/usb/gadget/udc/pxa27x_udc.c | 51 +++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index 001a3b74a993..79643e25a5bb 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -33,6 +33,7 @@
 #include <linux/usb.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
+#include <linux/usb/phy.h>
 
 #include "pxa27x_udc.h"
 
@@ -1655,6 +1656,37 @@ static int pxa_udc_vbus_draw(struct usb_gadget *_gadget, unsigned mA)
 	return -EOPNOTSUPP;
 }
 
+/**
+ * pxa_udc_phy_event - Called by phy upon VBus event
+ * @nb: notifier block
+ * @action: phy action, is vbus connect or disconnect
+ * @data: the usb_gadget structure in pxa_udc
+ *
+ * Called by the USB Phy when a cable connect or disconnect is sensed.
+ *
+ * Returns 0
+ */
+static int pxa_udc_phy_event(struct notifier_block *nb, unsigned long action,
+			     void *data)
+{
+	struct usb_gadget *gadget = data;
+
+	switch (action) {
+	case USB_EVENT_VBUS:
+		usb_gadget_vbus_connect(gadget);
+		return NOTIFY_OK;
+	case USB_EVENT_NONE:
+		usb_gadget_vbus_disconnect(gadget);
+		return NOTIFY_OK;
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
+static struct notifier_block pxa27x_udc_phy = {
+	.notifier_call = pxa_udc_phy_event,
+};
+
 static int pxa27x_udc_start(struct usb_gadget *g,
 		struct usb_gadget_driver *driver);
 static int pxa27x_udc_stop(struct usb_gadget *g);
@@ -2435,7 +2467,14 @@ static int pxa_udc_probe(struct platform_device *pdev)
 		return udc->irq;
 
 	udc->dev = &pdev->dev;
-	udc->transceiver = usb_get_phy(USB_PHY_TYPE_USB2);
+	if (of_have_populated_dt()) {
+		udc->transceiver =
+			devm_usb_get_phy_by_phandle(udc->dev, "phys", 0);
+		if (IS_ERR(udc->transceiver))
+			return PTR_ERR(udc->transceiver);
+	} else {
+		udc->transceiver = usb_get_phy(USB_PHY_TYPE_USB2);
+	}
 
 	if (IS_ERR(udc->gpiod)) {
 		dev_err(&pdev->dev, "Couldn't find or request D+ gpio : %ld\n",
@@ -2468,14 +2507,20 @@ static int pxa_udc_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	if (!IS_ERR_OR_NULL(udc->transceiver))
+		usb_register_notifier(udc->transceiver, &pxa27x_udc_phy);
 	retval = usb_add_gadget_udc(&pdev->dev, &udc->gadget);
 	if (retval)
-		goto err;
+		goto err_add_gadget;
 
 	pxa_init_debugfs(udc);
 	if (should_enable_udc(udc))
 		udc_enable(udc);
 	return 0;
+
+err_add_gadget:
+	if (!IS_ERR_OR_NULL(udc->transceiver))
+		usb_unregister_notifier(udc->transceiver, &pxa27x_udc_phy);
 err:
 	clk_unprepare(udc->clk);
 	return retval;
@@ -2492,6 +2537,8 @@ static int pxa_udc_remove(struct platform_device *_dev)
 	usb_del_gadget_udc(&udc->gadget);
 	pxa_cleanup_debugfs(udc);
 
+	if (!IS_ERR_OR_NULL(udc->transceiver))
+		usb_unregister_notifier(udc->transceiver, &pxa27x_udc_phy);
 	usb_put_phy(udc->transceiver);
 
 	udc->transceiver = NULL;
-- 
2.1.4
