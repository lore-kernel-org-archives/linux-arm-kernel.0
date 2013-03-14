From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 14 Mar 2013 13:50:39 +0800
Subject: [PATCH 11/14] usb: pxa27x_udc: using common vbus_active
In-Reply-To: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
References: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1363240242-25775-12-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using common vbus_active to indicate vbus status

CC: Eric Miao <eric.y.miao@gmail.com>
Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/gadget/pxa27x_udc.c |    8 ++++----
 drivers/usb/gadget/pxa27x_udc.h |    1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/pxa27x_udc.c b/drivers/usb/gadget/pxa27x_udc.c
index f7d2579..de997c5 100644
--- a/drivers/usb/gadget/pxa27x_udc.c
+++ b/drivers/usb/gadget/pxa27x_udc.c
@@ -1574,7 +1574,7 @@ static int should_enable_udc(struct pxa_udc *udc)
 	int put_on;
 
 	put_on = ((udc->pullup_on) && (udc->driver));
-	put_on &= ((udc->vbus_sensed) || (IS_ERR_OR_NULL(udc->transceiver)));
+	put_on &= ((udc->gadget.vbus_active) || (IS_ERR_OR_NULL(udc->transceiver)));
 	return put_on;
 }
 
@@ -1595,7 +1595,7 @@ static int should_disable_udc(struct pxa_udc *udc)
 	int put_off;
 
 	put_off = ((!udc->pullup_on) || (!udc->driver));
-	put_off |= ((!udc->vbus_sensed) && (!IS_ERR_OR_NULL(udc->transceiver)));
+	put_off |= ((!udc->gadget.vbus_active) && (!IS_ERR_OR_NULL(udc->transceiver)));
 	return put_off;
 }
 
@@ -1640,7 +1640,7 @@ static int pxa_udc_vbus_session(struct usb_gadget *_gadget, int is_active)
 {
 	struct pxa_udc *udc = to_gadget_udc(_gadget);
 
-	udc->vbus_sensed = is_active;
+	_gadget->vbus_active = is_active;
 	if (should_enable_udc(udc))
 		udc_enable(udc);
 	if (should_disable_udc(udc))
@@ -2465,7 +2465,7 @@ static int __init pxa_udc_probe(struct platform_device *pdev)
 	device_initialize(&udc->gadget.dev);
 	udc->gadget.dev.parent = &pdev->dev;
 	udc->gadget.dev.dma_mask = NULL;
-	udc->vbus_sensed = 0;
+	udc->gadget.vbus_active = 0;
 
 	the_controller = udc;
 	platform_set_drvdata(pdev, udc);
diff --git a/drivers/usb/gadget/pxa27x_udc.h b/drivers/usb/gadget/pxa27x_udc.h
index 28f2b53..184bf45 100644
--- a/drivers/usb/gadget/pxa27x_udc.h
+++ b/drivers/usb/gadget/pxa27x_udc.h
@@ -458,7 +458,6 @@ struct pxa_udc {
 	unsigned				enabled:1;
 	unsigned				pullup_on:1;
 	unsigned				pullup_resume:1;
-	unsigned				vbus_sensed:1;
 	unsigned				config:2;
 	unsigned				last_interface:3;
 	unsigned				last_alternate:3;
-- 
1.7.0.4
