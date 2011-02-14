From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon, 14 Feb 2011 15:33:19 +0300
Subject: [PATCH 4/5] pxa25x_udc: stop handling gpio-vbus internally
In-Reply-To: <1297686800-27599-1-git-send-email-dbaryshkov@gmail.com>
References: <1297686800-27599-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1297686800-27599-5-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stop handling gpio-vbus internally. All boards that depended on this
functionality have been converted to use gpio-vbus tranceiver. All
new boards can use it right from the start. Drop unused code.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/usb/gadget/pxa25x_udc.c |   76 ++++-----------------------------------
 1 files changed, 7 insertions(+), 69 deletions(-)

diff --git a/drivers/usb/gadget/pxa25x_udc.c b/drivers/usb/gadget/pxa25x_udc.c
index b37f92c..444b60a 100644
--- a/drivers/usb/gadget/pxa25x_udc.c
+++ b/drivers/usb/gadget/pxa25x_udc.c
@@ -139,24 +139,6 @@ static const char ep0name [] = "ep0";
 static void pxa25x_ep_fifo_flush (struct usb_ep *ep);
 static void nuke (struct pxa25x_ep *, int status);
 
-/* one GPIO should be used to detect VBUS from the host */
-static int is_vbus_present(void)
-{
-	struct pxa2xx_udc_mach_info		*mach = the_controller->mach;
-
-	if (gpio_is_valid(mach->gpio_vbus)) {
-		int value = gpio_get_value(mach->gpio_vbus);
-
-		if (mach->gpio_vbus_inverted)
-			return !value;
-		else
-			return !!value;
-	}
-	if (mach->udc_is_connected)
-		return mach->udc_is_connected();
-	return 1;
-}
-
 /* one GPIO should control a D+ pullup, so host sees this device (or not) */
 static void pullup_off(void)
 {
@@ -1055,7 +1037,7 @@ udc_seq_show(struct seq_file *m, void *_d)
 		"%s version: %s\nGadget driver: %s\nHost %s\n\n",
 		driver_name, DRIVER_VERSION SIZE_STR "(pio)",
 		dev->driver ? dev->driver->driver.name : "(none)",
-		is_vbus_present() ? "full speed" : "disconnected");
+		dev->gadget.speed == USB_SPEED_FULL ? "full speed" : "disconnected");
 
 	/* registers for device and ep0 */
 	seq_printf(m,
@@ -1094,7 +1076,7 @@ udc_seq_show(struct seq_file *m, void *_d)
 			(tmp & UDCCFR_ACM) ? " acm" : "");
 	}
 
-	if (!is_vbus_present() || !dev->driver)
+	if (dev->gadget.speed != USB_SPEED_FULL || !dev->driver)
 		goto done;
 
 	seq_printf(m, "ep0 IN %lu/%lu, OUT %lu/%lu\nirqs %lu\n\n",
@@ -1435,14 +1417,6 @@ lubbock_vbus_irq(int irq, void *_dev)
 
 #endif
 
-static irqreturn_t udc_vbus_irq(int irq, void *_dev)
-{
-	struct pxa25x_udc	*dev = _dev;
-
-	pxa25x_udc_vbus_session(&dev->gadget, is_vbus_present());
-	return IRQ_HANDLED;
-}
-
 
 /*-------------------------------------------------------------------------*/
 
@@ -1766,12 +1740,9 @@ pxa25x_udc_irq(int irq, void *_dev)
 		if (unlikely(udccr & UDCCR_SUSIR)) {
 			udc_ack_int_UDCCR(UDCCR_SUSIR);
 			handled = 1;
-			DBG(DBG_VERBOSE, "USB suspend%s\n", is_vbus_present()
-				? "" : "+disconnect");
+			DBG(DBG_VERBOSE, "USB suspend\n");
 
-			if (!is_vbus_present())
-				stop_activity(dev, dev->driver);
-			else if (dev->gadget.speed != USB_SPEED_UNKNOWN
+			if (dev->gadget.speed != USB_SPEED_UNKNOWN
 					&& dev->driver
 					&& dev->driver->suspend)
 				dev->driver->suspend(&dev->gadget);
@@ -1786,8 +1757,7 @@ pxa25x_udc_irq(int irq, void *_dev)
 
 			if (dev->gadget.speed != USB_SPEED_UNKNOWN
 					&& dev->driver
-					&& dev->driver->resume
-					&& is_vbus_present())
+					&& dev->driver->resume)
 				dev->driver->resume(&dev->gadget);
 		}
 
@@ -2137,7 +2107,7 @@ static struct pxa25x_udc memory = {
 static int __init pxa25x_udc_probe(struct platform_device *pdev)
 {
 	struct pxa25x_udc *dev = &memory;
-	int retval, vbus_irq, irq;
+	int retval, irq;
 	u32 chiprev;
 
 	/* insist on Intel/ARM/XScale */
@@ -2199,19 +2169,6 @@ static int __init pxa25x_udc_probe(struct platform_device *pdev)
 
 	dev->transceiver = otg_get_transceiver();
 
-	if (gpio_is_valid(dev->mach->gpio_vbus)) {
-		if ((retval = gpio_request(dev->mach->gpio_vbus,
-				"pxa25x_udc GPIO VBUS"))) {
-			dev_dbg(&pdev->dev,
-				"can't get vbus gpio %d, err: %d\n",
-				dev->mach->gpio_vbus, retval);
-			goto err_gpio_vbus;
-		}
-		gpio_direction_input(dev->mach->gpio_vbus);
-		vbus_irq = gpio_to_irq(dev->mach->gpio_vbus);
-	} else
-		vbus_irq = 0;
-
 	if (gpio_is_valid(dev->mach->gpio_pullup)) {
 		if ((retval = gpio_request(dev->mach->gpio_pullup,
 				"pca25x_udc GPIO PULLUP"))) {
@@ -2237,7 +2194,7 @@ static int __init pxa25x_udc_probe(struct platform_device *pdev)
 	udc_disable(dev);
 	udc_reinit(dev);
 
-	dev->vbus = !!is_vbus_present();
+	dev->vbus = 0;
 
 	/* irq setup after old hardware state is cleaned up */
 	retval = request_irq(irq, pxa25x_udc_irq,
@@ -2273,22 +2230,10 @@ lubbock_fail0:
 		}
 	} else
 #endif
-	if (vbus_irq) {
-		retval = request_irq(vbus_irq, udc_vbus_irq,
-				IRQF_DISABLED | IRQF_SAMPLE_RANDOM |
-				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				driver_name, dev);
-		if (retval != 0) {
-			pr_err("%s: can't get irq %i, err %d\n",
-				driver_name, vbus_irq, retval);
-			goto err_vbus_irq;
-		}
-	}
 	create_debug_files(dev);
 
 	return 0;
 
- err_vbus_irq:
 #ifdef	CONFIG_ARCH_LUBBOCK
 	free_irq(LUBBOCK_USB_DISC_IRQ, dev);
  err_irq_lub:
@@ -2298,9 +2243,6 @@ lubbock_fail0:
 	if (gpio_is_valid(dev->mach->gpio_pullup))
 		gpio_free(dev->mach->gpio_pullup);
  err_gpio_pullup:
-	if (gpio_is_valid(dev->mach->gpio_vbus))
-		gpio_free(dev->mach->gpio_vbus);
- err_gpio_vbus:
 	if (dev->transceiver) {
 		otg_put_transceiver(dev->transceiver);
 		dev->transceiver = NULL;
@@ -2337,10 +2279,6 @@ static int __exit pxa25x_udc_remove(struct platform_device *pdev)
 		free_irq(LUBBOCK_USB_IRQ, dev);
 	}
 #endif
-	if (gpio_is_valid(dev->mach->gpio_vbus)) {
-		free_irq(gpio_to_irq(dev->mach->gpio_vbus), dev);
-		gpio_free(dev->mach->gpio_vbus);
-	}
 	if (gpio_is_valid(dev->mach->gpio_pullup))
 		gpio_free(dev->mach->gpio_pullup);
 
-- 
1.7.2.3
