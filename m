From: balbi@ti.com (Felipe Balbi)
Date: Thu, 24 Jan 2013 17:45:51 +0200
Subject: [RFC/PATCH 13/32] usb: gadget: goku_udc: let udc-core manage
 gadget->dev
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Message-ID: <1359042370-4358-14-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By simply setting a flag, we can drop some
boilerplate code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/goku_udc.c | 10 +---------
 drivers/usb/gadget/goku_udc.h |  3 +--
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/goku_udc.c b/drivers/usb/gadget/goku_udc.c
index 85742d4..b4ea2cf 100644
--- a/drivers/usb/gadget/goku_udc.c
+++ b/drivers/usb/gadget/goku_udc.c
@@ -1716,8 +1716,6 @@ static void goku_remove(struct pci_dev *pdev)
 				pci_resource_len (pdev, 0));
 	if (dev->enabled)
 		pci_disable_device(pdev);
-	if (dev->registered)
-		device_unregister(&dev->gadget.dev);
 
 	pci_set_drvdata(pdev, NULL);
 	dev->regs = NULL;
@@ -1756,11 +1754,11 @@ static int goku_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev->gadget.max_speed = USB_SPEED_FULL;
 
 	/* the "gadget" abstracts/virtualizes the controller */
-	dev_set_name(&dev->gadget.dev, "gadget");
 	dev->gadget.dev.parent = &pdev->dev;
 	dev->gadget.dev.dma_mask = pdev->dev.dma_mask;
 	dev->gadget.dev.release = gadget_release;
 	dev->gadget.name = driver_name;
+	dev->gadget.register_my_device = true;
 
 	/* now all the pci goodies ... */
 	retval = pci_enable_device(pdev);
@@ -1810,12 +1808,6 @@ static int goku_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	create_proc_read_entry(proc_node_name, 0, NULL, udc_proc_read, dev);
 #endif
 
-	retval = device_register(&dev->gadget.dev);
-	if (retval) {
-		put_device(&dev->gadget.dev);
-		goto err;
-	}
-	dev->registered = 1;
 	retval = usb_add_gadget_udc(&pdev->dev, &dev->gadget);
 	if (retval)
 		goto err;
diff --git a/drivers/usb/gadget/goku_udc.h b/drivers/usb/gadget/goku_udc.h
index b4470d2..86d2ada 100644
--- a/drivers/usb/gadget/goku_udc.h
+++ b/drivers/usb/gadget/goku_udc.h
@@ -250,8 +250,7 @@ struct goku_udc {
 					got_region:1,
 					req_config:1,
 					configured:1,
-					enabled:1,
-					registered:1;
+					enabled:1;
 
 	/* pci state used to access those endpoints */
 	struct pci_dev			*pdev;
-- 
1.8.1.rc1.5.g7e0651a
