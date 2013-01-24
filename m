From: balbi@ti.com (Felipe Balbi)
Date: Thu, 24 Jan 2013 17:45:49 +0200
Subject: [RFC/PATCH 11/32] usb: gadget: fsl_udc_core: let udc-core manage
 gadget->dev
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Message-ID: <1359042370-4358-12-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By simply setting a flag, we can drop some
boilerplate code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/fsl_udc_core.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index 49642d4..b78b734 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -2526,9 +2526,7 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 	udc_controller->gadget.dev.release = fsl_udc_release;
 	udc_controller->gadget.dev.parent = &pdev->dev;
 	udc_controller->gadget.dev.of_node = pdev->dev.of_node;
-	ret = device_register(&udc_controller->gadget.dev);
-	if (ret < 0)
-		goto err_free_irq;
+	udc_controller->gadget.register_my_device = true;
 
 	if (!IS_ERR_OR_NULL(udc_controller->transceiver))
 		udc_controller->gadget.is_otg = 1;
@@ -2561,7 +2559,7 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 			DTD_ALIGNMENT, UDC_DMA_BOUNDARY);
 	if (udc_controller->td_pool == NULL) {
 		ret = -ENOMEM;
-		goto err_unregister;
+		goto err_free_irq;
 	}
 
 	ret = usb_add_gadget_udc(&pdev->dev, &udc_controller->gadget);
@@ -2573,8 +2571,6 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 
 err_del_udc:
 	dma_pool_destroy(udc_controller->td_pool);
-err_unregister:
-	device_unregister(&udc_controller->gadget.dev);
 err_free_irq:
 	free_irq(udc_controller->irq, udc_controller);
 err_iounmap:
@@ -2624,7 +2620,6 @@ static int __exit fsl_udc_remove(struct platform_device *pdev)
 	if (pdata->operating_mode == FSL_USB2_DR_DEVICE)
 		release_mem_region(res->start, resource_size(res));
 
-	device_unregister(&udc_controller->gadget.dev);
 	/* free udc --wait for the release() finished */
 	wait_for_completion(&done);
 
-- 
1.8.1.rc1.5.g7e0651a
