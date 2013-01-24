From: balbi@ti.com (Felipe Balbi)
Date: Thu, 24 Jan 2013 17:45:42 +0200
Subject: [RFC/PATCH 04/32] usb: gadget: omap_udc: let udc-core manage
 gadget->dev
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Message-ID: <1359042370-4358-5-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By simply setting a flag, we drop some boilerplate
code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/omap_udc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index d0c87b1..234e82b 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -2631,10 +2631,9 @@ omap_udc_setup(struct platform_device *odev, struct usb_phy *xceiv)
 	udc->gadget.max_speed = USB_SPEED_FULL;
 	udc->gadget.name = driver_name;
 
-	device_initialize(&udc->gadget.dev);
-	dev_set_name(&udc->gadget.dev, "gadget");
 	udc->gadget.dev.release = omap_udc_release;
 	udc->gadget.dev.parent = &odev->dev;
+	udc->gadget.register_my_device = true;
 	if (use_dma)
 		udc->gadget.dev.dma_mask = odev->dev.dma_mask;
 
@@ -2911,14 +2910,12 @@ bad_on_1710:
 	}
 
 	create_proc_file();
-	status = device_add(&udc->gadget.dev);
+	status = usb_add_gadget_udc(&pdev->dev, &udc->gadget);
 	if (status)
 		goto cleanup4;
 
-	status = usb_add_gadget_udc(&pdev->dev, &udc->gadget);
-	if (!status)
-		return status;
-	/* If fail, fall through */
+	return 0;
+
 cleanup4:
 	remove_proc_file();
 
@@ -2989,7 +2986,6 @@ static int omap_udc_remove(struct platform_device *pdev)
 	release_mem_region(pdev->resource[0].start,
 			pdev->resource[0].end - pdev->resource[0].start + 1);
 
-	device_unregister(&udc->gadget.dev);
 	wait_for_completion(&done);
 
 	return 0;
-- 
1.8.1.rc1.5.g7e0651a
