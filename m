From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sun, 30 Nov 2014 01:02:05 +0300
Subject: [PATCH v2 3/3] usb: gadget: drop lubbock-specific code from pxa25x_udc
In-Reply-To: <1417298525-5587-1-git-send-email-dbaryshkov@gmail.com>
References: <1417298525-5587-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1417298525-5587-4-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now, as there is a special phy for lubbock platforms, drop all
lubbock-specific code from pxa25x udc driver. It should use phy instead.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/usb/gadget/udc/pxa25x_udc.c | 61 -------------------------------------
 drivers/usb/gadget/udc/pxa25x_udc.h |  5 ---
 2 files changed, 66 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index 42f7eeb..e3d0715 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -56,10 +56,6 @@
 #include <mach/hardware.h>
 #endif
 
-#ifdef CONFIG_ARCH_LUBBOCK
-#include <mach/lubbock.h>
-#endif
-
 /*
  * This driver handles the USB Device Controller (UDC) in Intel's PXA 25x
  * series processors.  The UDC for the IXP 4xx series is very similar.
@@ -1334,43 +1330,6 @@ static int pxa25x_udc_stop(struct usb_gadget*g,
 
 /*-------------------------------------------------------------------------*/
 
-#ifdef CONFIG_ARCH_LUBBOCK
-
-/* Lubbock has separate connect and disconnect irqs.  More typical designs
- * use one GPIO as the VBUS IRQ, and another to control the D+ pullup.
- */
-
-static irqreturn_t
-lubbock_vbus_irq(int irq, void *_dev)
-{
-	struct pxa25x_udc	*dev = _dev;
-	int			vbus;
-
-	dev->stats.irqs++;
-	switch (irq) {
-	case LUBBOCK_USB_IRQ:
-		vbus = 1;
-		disable_irq(LUBBOCK_USB_IRQ);
-		enable_irq(LUBBOCK_USB_DISC_IRQ);
-		break;
-	case LUBBOCK_USB_DISC_IRQ:
-		vbus = 0;
-		disable_irq(LUBBOCK_USB_DISC_IRQ);
-		enable_irq(LUBBOCK_USB_IRQ);
-		break;
-	default:
-		return IRQ_NONE;
-	}
-
-	pxa25x_udc_vbus_session(&dev->gadget, vbus);
-	return IRQ_HANDLED;
-}
-
-#endif
-
-
-/*-------------------------------------------------------------------------*/
-
 static inline void clear_ep_state (struct pxa25x_udc *dev)
 {
 	unsigned i;
@@ -2154,26 +2113,6 @@ static int pxa25x_udc_probe(struct platform_device *pdev)
 	}
 	dev->got_irq = 1;
 
-#ifdef CONFIG_ARCH_LUBBOCK
-	if (machine_is_lubbock()) {
-		retval = devm_request_irq(&pdev->dev, LUBBOCK_USB_DISC_IRQ,
-					  lubbock_vbus_irq, 0, driver_name,
-					  dev);
-		if (retval != 0) {
-			pr_err("%s: can't get irq %i, err %d\n",
-				driver_name, LUBBOCK_USB_DISC_IRQ, retval);
-			goto err;
-		}
-		retval = devm_request_irq(&pdev->dev, LUBBOCK_USB_IRQ,
-					  lubbock_vbus_irq, 0, driver_name,
-					  dev);
-		if (retval != 0) {
-			pr_err("%s: can't get irq %i, err %d\n",
-				driver_name, LUBBOCK_USB_IRQ, retval);
-			goto err;
-		}
-	} else
-#endif
 	create_debug_files(dev);
 
 	retval = usb_add_gadget_udc(&pdev->dev, &dev->gadget);
diff --git a/drivers/usb/gadget/udc/pxa25x_udc.h b/drivers/usb/gadget/udc/pxa25x_udc.h
index 3fe5931..59c6bbc 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.h
+++ b/drivers/usb/gadget/udc/pxa25x_udc.h
@@ -130,11 +130,6 @@ struct pxa25x_udc {
 
 /*-------------------------------------------------------------------------*/
 
-#ifdef CONFIG_ARCH_LUBBOCK
-#include <mach/lubbock.h>
-/* lubbock can also report usb connect/disconnect irqs */
-#endif
-
 static struct pxa25x_udc *the_controller;
 
 /*-------------------------------------------------------------------------*/
-- 
2.1.3
