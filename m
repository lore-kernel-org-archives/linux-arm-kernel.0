From: balbi@ti.com (Felipe Balbi)
Date: Thu, 24 Jan 2013 17:45:48 +0200
Subject: [RFC/PATCH 10/32] usb: gadget: fsl_qe_udc: let udc-core manage
 gadget->dev
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Message-ID: <1359042370-4358-11-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By simply setting a flag, we can drop some
boilerplate code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/fsl_qe_udc.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
index ec50f18..08c8432 100644
--- a/drivers/usb/gadget/fsl_qe_udc.c
+++ b/drivers/usb/gadget/fsl_qe_udc.c
@@ -2523,13 +2523,9 @@ static int qe_udc_probe(struct platform_device *ofdev)
 
 	/* name: Identifies the controller hardware type. */
 	udc->gadget.name = driver_name;
-
-	device_initialize(&udc->gadget.dev);
-
-	dev_set_name(&udc->gadget.dev, "gadget");
-
 	udc->gadget.dev.release = qe_udc_release;
 	udc->gadget.dev.parent = &ofdev->dev;
+	udc->gadget.register_my_device = true;
 
 	/* initialize qe_ep struct */
 	for (i = 0; i < USB_MAX_ENDPOINTS ; i++) {
@@ -2592,13 +2588,9 @@ static int qe_udc_probe(struct platform_device *ofdev)
 		goto err5;
 	}
 
-	ret = device_add(&udc->gadget.dev);
-	if (ret)
-		goto err6;
-
 	ret = usb_add_gadget_udc(&ofdev->dev, &udc->gadget);
 	if (ret)
-		goto err7;
+		goto err6;
 
 	dev_set_drvdata(&ofdev->dev, udc);
 	dev_info(udc->dev,
@@ -2606,8 +2598,6 @@ static int qe_udc_probe(struct platform_device *ofdev)
 			(udc->soc_type == PORT_QE) ? "QE" : "CPM");
 	return 0;
 
-err7:
-	device_unregister(&udc->gadget.dev);
 err6:
 	free_irq(udc->usb_irq, udc);
 err5:
@@ -2702,7 +2692,6 @@ static int qe_udc_remove(struct platform_device *ofdev)
 
 	iounmap(udc->usb_regs);
 
-	device_unregister(&udc->gadget.dev);
 	/* wait for release() of gadget.dev to free udc */
 	wait_for_completion(&done);
 
-- 
1.8.1.rc1.5.g7e0651a
