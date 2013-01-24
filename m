From: balbi@ti.com (Felipe Balbi)
Date: Thu, 24 Jan 2013 17:45:58 +0200
Subject: [RFC/PATCH 20/32] usb: gadget: net2272: let udc-core manage
 gadget->dev
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Message-ID: <1359042370-4358-21-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By simply setting a flag, we can drop some
boilerplate code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/net2272.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/net2272.c b/drivers/usb/gadget/net2272.c
index d226058..635248f 100644
--- a/drivers/usb/gadget/net2272.c
+++ b/drivers/usb/gadget/net2272.c
@@ -2209,7 +2209,6 @@ net2272_remove(struct net2272 *dev)
 	free_irq(dev->irq, dev);
 	iounmap(dev->base_addr);
 
-	device_unregister(&dev->gadget.dev);
 	device_remove_file(dev->dev, &dev_attr_registers);
 
 	dev_info(dev->dev, "unbind\n");
@@ -2236,11 +2235,11 @@ static struct net2272 *net2272_probe_init(struct device *dev, unsigned int irq)
 	ret->gadget.max_speed = USB_SPEED_HIGH;
 
 	/* the "gadget" abstracts/virtualizes the controller */
-	dev_set_name(&ret->gadget.dev, "gadget");
 	ret->gadget.dev.parent = dev;
 	ret->gadget.dev.dma_mask = dev->dma_mask;
 	ret->gadget.dev.release = net2272_gadget_release;
 	ret->gadget.name = driver_name;
+	ret->gadget.register_my_device = true;
 
 	return ret;
 }
@@ -2275,12 +2274,9 @@ net2272_probe_fin(struct net2272 *dev, unsigned int irqflags)
 		dma_mode_string());
 	dev_info(dev->dev, "version: %s\n", driver_vers);
 
-	ret = device_register(&dev->gadget.dev);
-	if (ret)
-		goto err_irq;
 	ret = device_create_file(dev->dev, &dev_attr_registers);
 	if (ret)
-		goto err_dev_reg;
+		goto err_irq;
 
 	ret = usb_add_gadget_udc(dev->dev, &dev->gadget);
 	if (ret)
@@ -2290,8 +2286,6 @@ net2272_probe_fin(struct net2272 *dev, unsigned int irqflags)
 
 err_add_udc:
 	device_remove_file(dev->dev, &dev_attr_registers);
- err_dev_reg:
-	device_unregister(&dev->gadget.dev);
  err_irq:
 	free_irq(dev->irq, dev);
  err:
-- 
1.8.1.rc1.5.g7e0651a
