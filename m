From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Thu, 12 Feb 2015 18:54:05 +0100
Subject: [PATCHv7 2/4] USB: gadget: atmel_usba_udc: Request an auto disabled
 Vbus signal IRQ instead of an auto enabled IRQ request followed by IRQ
 disable
In-Reply-To: <1423763647-11687-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1423763647-11687-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1423763647-11687-3-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vbus IRQ handler needs a started UDC driver to work because it uses
udc->driver, which is set by the UDC start handler. The previous way
chosen was to return from interrupt if udc->driver is NULL using a
spinlock around the check.

We now request an auto disabled (IRQ_NOAUTOEN) Vbus signal IRQ instead
of an auto enabled IRQ followed by disable_irq(). This way we remove the
very small timeslot of enabled IRQ which existed previously between
request() and disable(). We don't need anymore to check if udc->driver
is NULL in IRQ handler.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index e63c6fc..bbbd5f1 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1749,10 +1749,6 @@ static irqreturn_t usba_vbus_irq(int irq, void *devid)
 
 	spin_lock(&udc->lock);
 
-	/* May happen if Vbus pin toggles during probe() */
-	if (!udc->driver)
-		goto out;
-
 	vbus = vbus_is_present(udc);
 	if (vbus != udc->vbus_prev) {
 		if (vbus) {
@@ -1773,7 +1769,6 @@ static irqreturn_t usba_vbus_irq(int irq, void *devid)
 		udc->vbus_prev = vbus;
 	}
 
-out:
 	spin_unlock(&udc->lock);
 
 	return IRQ_HANDLED;
@@ -2113,6 +2108,8 @@ static int usba_udc_probe(struct platform_device *pdev)
 
 	if (gpio_is_valid(udc->vbus_pin)) {
 		if (!devm_gpio_request(&pdev->dev, udc->vbus_pin, "atmel_usba_udc")) {
+			irq_set_status_flags(gpio_to_irq(udc->vbus_pin),
+					IRQ_NOAUTOEN);
 			ret = devm_request_irq(&pdev->dev,
 					gpio_to_irq(udc->vbus_pin),
 					usba_vbus_irq, 0,
@@ -2122,8 +2119,6 @@ static int usba_udc_probe(struct platform_device *pdev)
 				dev_warn(&udc->pdev->dev,
 					 "failed to request vbus irq; "
 					 "assuming always on\n");
-			} else {
-				disable_irq(gpio_to_irq(udc->vbus_pin));
 			}
 		} else {
 			/* gpio_request fail so use -EINVAL for gpio_is_valid */
-- 
2.1.4
