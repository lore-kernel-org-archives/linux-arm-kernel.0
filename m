From: balbi@ti.com (Felipe Balbi)
Date: Thu, 24 Jan 2013 17:45:57 +0200
Subject: [RFC/PATCH 19/32] usb: gadget: mv_udc_core: let udc-core manage
 gadget->dev
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Message-ID: <1359042370-4358-20-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By simply setting a flag, we can drop some
boilerplate code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/mv_udc_core.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/mv_udc_core.c b/drivers/usb/gadget/mv_udc_core.c
index 67d72f9..60741af 100644
--- a/drivers/usb/gadget/mv_udc_core.c
+++ b/drivers/usb/gadget/mv_udc_core.c
@@ -2138,8 +2138,6 @@ static int mv_udc_remove(struct platform_device *pdev)
 
 	mv_udc_disable(udc);
 
-	device_unregister(&udc->gadget.dev);
-
 	/* free dev, wait for the release() finished */
 	wait_for_completion(udc->done);
 
@@ -2311,15 +2309,11 @@ static int mv_udc_probe(struct platform_device *pdev)
 	udc->gadget.max_speed = USB_SPEED_HIGH;	/* support dual speed */
 
 	/* the "gadget" abstracts/virtualizes the controller */
-	dev_set_name(&udc->gadget.dev, "gadget");
 	udc->gadget.dev.parent = &pdev->dev;
 	udc->gadget.dev.dma_mask = pdev->dev.dma_mask;
 	udc->gadget.dev.release = gadget_release;
 	udc->gadget.name = driver_name;		/* gadget name */
-
-	retval = device_register(&udc->gadget.dev);
-	if (retval)
-		goto err_destroy_dma;
+	udc->gadget.register_my_device = true;
 
 	eps_init(udc);
 
@@ -2342,7 +2336,7 @@ static int mv_udc_probe(struct platform_device *pdev)
 		if (!udc->qwork) {
 			dev_err(&pdev->dev, "cannot create workqueue\n");
 			retval = -ENOMEM;
-			goto err_unregister;
+			goto err_destroy_dma;
 		}
 
 		INIT_WORK(&udc->vbus_work, mv_udc_vbus_work);
@@ -2370,8 +2364,6 @@ static int mv_udc_probe(struct platform_device *pdev)
 
 err_create_workqueue:
 	destroy_workqueue(udc->qwork);
-err_unregister:
-	device_unregister(&udc->gadget.dev);
 err_destroy_dma:
 	dma_pool_destroy(udc->dtd_pool);
 err_free_dma:
-- 
1.8.1.rc1.5.g7e0651a
