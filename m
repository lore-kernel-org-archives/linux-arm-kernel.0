From: balbi@ti.com (Felipe Balbi)
Date: Thu, 24 Jan 2013 17:45:50 +0200
Subject: [RFC/PATCH 12/32] usb: gadget: fusb300_udc: let udc-core manage
 gadget->dev
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Message-ID: <1359042370-4358-13-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By simply setting a flag, we can drop some
boilerplate code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/fusb300_udc.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/usb/gadget/fusb300_udc.c b/drivers/usb/gadget/fusb300_udc.c
index 8c2372f..798a25b 100644
--- a/drivers/usb/gadget/fusb300_udc.c
+++ b/drivers/usb/gadget/fusb300_udc.c
@@ -1422,15 +1422,12 @@ static int __init fusb300_probe(struct platform_device *pdev)
 
 	fusb300->gadget.ops = &fusb300_gadget_ops;
 
-	device_initialize(&fusb300->gadget.dev);
-
-	dev_set_name(&fusb300->gadget.dev, "gadget");
-
 	fusb300->gadget.max_speed = USB_SPEED_HIGH;
 	fusb300->gadget.dev.parent = &pdev->dev;
 	fusb300->gadget.dev.dma_mask = pdev->dev.dma_mask;
 	fusb300->gadget.dev.release = pdev->dev.release;
 	fusb300->gadget.name = udc_name;
+	fusb300->gadget.register_my_device = true;
 	fusb300->reg = reg;
 
 	ret = request_irq(ires->start, fusb300_irq, IRQF_SHARED,
@@ -1478,19 +1475,10 @@ static int __init fusb300_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_add_udc;
 
-	ret = device_add(&fusb300->gadget.dev);
-	if (ret) {
-		pr_err("device_add error (%d)\n", ret);
-		goto err_add_device;
-	}
-
 	dev_info(&pdev->dev, "version %s\n", DRIVER_VERSION);
 
 	return 0;
 
-err_add_device:
-	usb_del_gadget_udc(&fusb300->gadget);
-
 err_add_udc:
 	fusb300_free_request(&fusb300->ep[0]->ep, fusb300->ep0_req);
 
-- 
1.8.1.rc1.5.g7e0651a
