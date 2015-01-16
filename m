From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Fri, 16 Jan 2015 23:21:10 +0100
Subject: [PATCH] USB: gadget: atmel_usba_udc: Enable/disable USB PLL on Vbus
 change
Message-ID: <1421446870-26653-1-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare_enable on rising edge, disable_unprepare on falling edge. Reduce
power consumption if USB PLL is not already necessary for OHCI or EHCI.
If USB host is not connected we can sleep with USB PLL stopped.

This driver does not support suspend/resume yet, not suspending if we
are still attached to an USB host is fine for what I need, this patch
allow suspending with USB PLL stopped when USB device is not currently
used.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 37 +++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index ce88237..8ea0a63 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1723,6 +1723,7 @@ static irqreturn_t usba_vbus_irq(int irq, void *devid)
 {
 	struct usba_udc *udc = devid;
 	int vbus;
+	int ret;
 
 	/* debounce */
 	udelay(10);
@@ -1736,6 +1737,15 @@ static irqreturn_t usba_vbus_irq(int irq, void *devid)
 	vbus = vbus_is_present(udc);
 	if (vbus != udc->vbus_prev) {
 		if (vbus) {
+			ret = clk_prepare_enable(udc->pclk);
+			if (ret)
+				goto out;
+			ret = clk_prepare_enable(udc->hclk);
+			if (ret) {
+				clk_disable_unprepare(udc->pclk);
+				goto out;
+			}
+
 			toggle_bias(1);
 			usba_writel(udc, CTRL, USBA_ENABLE_MASK);
 			usba_writel(udc, INT_ENB, USBA_END_OF_RESET);
@@ -1744,6 +1754,10 @@ static irqreturn_t usba_vbus_irq(int irq, void *devid)
 			reset_all_endpoints(udc);
 			toggle_bias(0);
 			usba_writel(udc, CTRL, USBA_DISABLE_MASK);
+
+			clk_disable_unprepare(udc->hclk);
+			clk_disable_unprepare(udc->pclk);
+
 			if (udc->driver->disconnect) {
 				spin_unlock(&udc->lock);
 				udc->driver->disconnect(&udc->gadget);
@@ -1772,15 +1786,6 @@ static int atmel_usba_start(struct usb_gadget *gadget,
 	udc->driver = driver;
 	spin_unlock_irqrestore(&udc->lock, flags);
 
-	ret = clk_prepare_enable(udc->pclk);
-	if (ret)
-		return ret;
-	ret = clk_prepare_enable(udc->hclk);
-	if (ret) {
-		clk_disable_unprepare(udc->pclk);
-		return ret;
-	}
-
 	udc->vbus_prev = 0;
 	if (gpio_is_valid(udc->vbus_pin))
 		enable_irq(gpio_to_irq(udc->vbus_pin));
@@ -1788,13 +1793,27 @@ static int atmel_usba_start(struct usb_gadget *gadget,
 	/* If Vbus is present, enable the controller and wait for reset */
 	spin_lock_irqsave(&udc->lock, flags);
 	if (vbus_is_present(udc) && udc->vbus_prev == 0) {
+		ret = clk_prepare_enable(udc->pclk);
+		if (ret)
+			goto out;
+		ret = clk_prepare_enable(udc->hclk);
+		if (ret) {
+			clk_disable_unprepare(udc->pclk);
+			goto out;
+		}
+
 		toggle_bias(1);
 		usba_writel(udc, CTRL, USBA_ENABLE_MASK);
 		usba_writel(udc, INT_ENB, USBA_END_OF_RESET);
+
+		udc->vbus_prev = 1;
 	}
 	spin_unlock_irqrestore(&udc->lock, flags);
 
 	return 0;
+out:
+	spin_unlock_irqrestore(&udc->lock, flags);
+	return ret;
 }
 
 static int atmel_usba_stop(struct usb_gadget *gadget)
-- 
2.1.4
