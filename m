From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Tue, 20 Jan 2015 22:23:29 +0100
Subject: [PATCHv4 2/3] USB: gadget: atmel_usba_udc: Enable Vbus signal IRQ in
 UDC start instead of UDC probe
In-Reply-To: <1421789010-21900-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1421789010-21900-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1421789010-21900-3-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vbus IRQ handler needs a started UDC driver to work because it uses
udc->driver, which is set by the UDC start handler. The previous way
chosen was to return from interrupt if udc->driver is NULL using a
spinlock.

This patch now request the Vbus signal IRQ in UDC start instead of UDC
probe and release the IRQ in UDC stop before udc->driver is set back to
NULL. This way we don't need the check about udc->driver in interruption
handler, therefore we don't need the spinlock as well anymore.

This was chosen against using set_irq_flags() to request a not auto
enabled IRQ (IRQF_NOAUTOEN flag) because set_irq_flags() can't change
just one flag, therefore it must be called with all flags, without
respecting what the AIC previously did. Naively copying IRQ flags
currently set by the AIC looked like error-prone if defaults flags
change at some point in the future.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 64 ++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index e207d75..546da63 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1729,10 +1729,6 @@ static irqreturn_t usba_vbus_irq(int irq, void *devid)
 
 	spin_lock(&udc->lock);
 
-	/* May happen if Vbus pin toggles during probe() */
-	if (!udc->driver)
-		goto out;
-
 	vbus = vbus_is_present(udc);
 	if (vbus != udc->vbus_prev) {
 		if (vbus) {
@@ -1753,7 +1749,6 @@ static irqreturn_t usba_vbus_irq(int irq, void *devid)
 		udc->vbus_prev = vbus;
 	}
 
-out:
 	spin_unlock(&udc->lock);
 
 	return IRQ_HANDLED;
@@ -1767,23 +1762,27 @@ static int atmel_usba_start(struct usb_gadget *gadget,
 	unsigned long flags;
 
 	spin_lock_irqsave(&udc->lock, flags);
-
 	udc->devstatus = 1 << USB_DEVICE_SELF_POWERED;
 	udc->driver = driver;
 	spin_unlock_irqrestore(&udc->lock, flags);
 
 	ret = clk_prepare_enable(udc->pclk);
 	if (ret)
-		return ret;
+		goto err_pclk;
 	ret = clk_prepare_enable(udc->hclk);
-	if (ret) {
-		clk_disable_unprepare(udc->pclk);
-		return ret;
-	}
+	if (ret)
+		goto err_hclk;
 
 	udc->vbus_prev = 0;
-	if (gpio_is_valid(udc->vbus_pin))
-		enable_irq(gpio_to_irq(udc->vbus_pin));
+	if (gpio_is_valid(udc->vbus_pin)) {
+		ret = request_irq(gpio_to_irq(udc->vbus_pin),
+				usba_vbus_irq, 0,
+				"atmel_usba_udc", udc);
+		if (ret) {
+			udc->vbus_pin = -ENODEV;
+			goto err;
+		}
+	}
 
 	/* If Vbus is present, enable the controller and wait for reset */
 	spin_lock_irqsave(&udc->lock, flags);
@@ -1797,6 +1796,17 @@ static int atmel_usba_start(struct usb_gadget *gadget,
 	spin_unlock_irqrestore(&udc->lock, flags);
 
 	return 0;
+
+err:
+	clk_disable_unprepare(udc->hclk);
+err_hclk:
+	clk_disable_unprepare(udc->pclk);
+err_pclk:
+	spin_lock_irqsave(&udc->lock, flags);
+	udc->devstatus &= ~(1 << USB_DEVICE_SELF_POWERED);
+	udc->driver = NULL;
+	spin_unlock_irqrestore(&udc->lock, flags);
+	return ret;
 }
 
 static int atmel_usba_stop(struct usb_gadget *gadget)
@@ -1805,7 +1815,7 @@ static int atmel_usba_stop(struct usb_gadget *gadget)
 	unsigned long flags;
 
 	if (gpio_is_valid(udc->vbus_pin))
-		disable_irq(gpio_to_irq(udc->vbus_pin));
+		free_irq(gpio_to_irq(udc->vbus_pin), udc);
 
 	spin_lock_irqsave(&udc->lock, flags);
 	udc->gadget.speed = USB_SPEED_UNKNOWN;
@@ -2047,24 +2057,14 @@ static int usba_udc_probe(struct platform_device *pdev)
 	}
 	udc->irq = irq;
 
-	if (gpio_is_valid(udc->vbus_pin)) {
-		if (!devm_gpio_request(&pdev->dev, udc->vbus_pin, "atmel_usba_udc")) {
-			ret = devm_request_irq(&pdev->dev,
-					gpio_to_irq(udc->vbus_pin),
-					usba_vbus_irq, 0,
-					"atmel_usba_udc", udc);
-			if (ret) {
-				udc->vbus_pin = -ENODEV;
-				dev_warn(&udc->pdev->dev,
-					 "failed to request vbus irq; "
-					 "assuming always on\n");
-			} else {
-				disable_irq(gpio_to_irq(udc->vbus_pin));
-			}
-		} else {
-			/* gpio_request fail so use -EINVAL for gpio_is_valid */
-			udc->vbus_pin = -EINVAL;
-		}
+	if (gpio_is_valid(udc->vbus_pin)
+			&& devm_gpio_request(&pdev->dev, udc->vbus_pin,
+					"atmel_usba_udc")) {
+		/* gpio_request fail so use -EINVAL for gpio_is_valid */
+		udc->vbus_pin = -EINVAL;
+		dev_warn(&udc->pdev->dev,
+			"failed to request vbus gpio; "
+			"assuming always on\n");
 	}
 
 	ret = usb_add_gadget_udc(&pdev->dev, &udc->gadget);
-- 
2.1.4
