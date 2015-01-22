From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Thu, 22 Jan 2015 17:56:43 +0100
Subject: [PATCHv6 3/5] USB: gadget: atmel_usba_udc: Start clocks on rising
 edge of the Vbus signal, stop clocks on falling edge of the Vbus signal
In-Reply-To: <1421945805-31129-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1421945805-31129-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1421945805-31129-4-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If USB PLL is not necessary for other USB drivers (e.g. OHCI and EHCI)
we will reduce power consumption by switching off the USB PLL if no USB
Host is currently connected to this USB Device.

We are using Vbus GPIO signal to detect Host presence. If Vbus signal is
not available then the device stays continuously clocked.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 144 +++++++++++++++++++++-----------
 drivers/usb/gadget/udc/atmel_usba_udc.h |   4 +
 2 files changed, 100 insertions(+), 48 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index f9f305f..d554106 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1735,7 +1735,72 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t usba_vbus_irq(int irq, void *devid)
+static int start_clock(struct usba_udc *udc)
+{
+	int ret;
+
+	if (udc->clocked)
+		return 0;
+
+	ret = clk_prepare_enable(udc->pclk);
+	if (ret)
+		return ret;
+	ret = clk_prepare_enable(udc->hclk);
+	if (ret) {
+		clk_disable_unprepare(udc->pclk);
+		return ret;
+	}
+
+	udc->clocked = true;
+	return 0;
+}
+
+static void stop_clock(struct usba_udc *udc)
+{
+	if (!udc->clocked)
+		return;
+
+	clk_disable_unprepare(udc->hclk);
+	clk_disable_unprepare(udc->pclk);
+
+	udc->clocked = false;
+}
+
+static int usba_start(struct usba_udc *udc)
+{
+	unsigned long flags;
+	int ret;
+
+	ret = start_clock(udc);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&udc->lock, flags);
+	toggle_bias(udc, 1);
+	usba_writel(udc, CTRL, USBA_ENABLE_MASK);
+	usba_int_enb_set(udc, USBA_END_OF_RESET);
+	spin_unlock_irqrestore(&udc->lock, flags);
+
+	return 0;
+}
+
+static void usba_stop(struct usba_udc *udc)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&udc->lock, flags);
+	udc->gadget.speed = USB_SPEED_UNKNOWN;
+	reset_all_endpoints(udc);
+
+	/* This will also disable the DP pullup */
+	toggle_bias(udc, 0);
+	usba_writel(udc, CTRL, USBA_DISABLE_MASK);
+	spin_unlock_irqrestore(&udc->lock, flags);
+
+	stop_clock(udc);
+}
+
+static irqreturn_t usba_vbus_irq_thread(int irq, void *devid)
 {
 	struct usba_udc *udc = devid;
 	int vbus;
@@ -1743,30 +1808,22 @@ static irqreturn_t usba_vbus_irq(int irq, void *devid)
 	/* debounce */
 	udelay(10);
 
-	spin_lock(&udc->lock);
+	mutex_lock(&udc->vbus_mutex);
 
 	vbus = vbus_is_present(udc);
 	if (vbus != udc->vbus_prev) {
 		if (vbus) {
-			toggle_bias(udc, 1);
-			usba_writel(udc, CTRL, USBA_ENABLE_MASK);
-			usba_int_enb_set(udc, USBA_END_OF_RESET);
+			usba_start(udc);
 		} else {
-			udc->gadget.speed = USB_SPEED_UNKNOWN;
-			reset_all_endpoints(udc);
-			toggle_bias(udc, 0);
-			usba_writel(udc, CTRL, USBA_DISABLE_MASK);
-			if (udc->driver->disconnect) {
-				spin_unlock(&udc->lock);
+			usba_stop(udc);
+
+			if (udc->driver->disconnect)
 				udc->driver->disconnect(&udc->gadget);
-				spin_lock(&udc->lock);
-			}
 		}
 		udc->vbus_prev = vbus;
 	}
 
-	spin_unlock(&udc->lock);
-
+	mutex_unlock(&udc->vbus_mutex);
 	return IRQ_HANDLED;
 }
 
@@ -1778,57 +1835,47 @@ static int atmel_usba_start(struct usb_gadget *gadget,
 	unsigned long flags;
 
 	spin_lock_irqsave(&udc->lock, flags);
-
 	udc->devstatus = 1 << USB_DEVICE_SELF_POWERED;
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
+	mutex_lock(&udc->vbus_mutex);
 
-	udc->vbus_prev = 0;
 	if (gpio_is_valid(udc->vbus_pin))
 		enable_irq(gpio_to_irq(udc->vbus_pin));
 
 	/* If Vbus is present, enable the controller and wait for reset */
-	spin_lock_irqsave(&udc->lock, flags);
-	if (vbus_is_present(udc) && udc->vbus_prev == 0) {
-		toggle_bias(udc, 1);
-		usba_writel(udc, CTRL, USBA_ENABLE_MASK);
-		usba_int_enb_set(udc, USBA_END_OF_RESET);
-
-		udc->vbus_prev = 1;
+	udc->vbus_prev = vbus_is_present(udc);
+	if (udc->vbus_prev) {
+		ret = usba_start(udc);
+		if (ret)
+			goto err;
 	}
-	spin_unlock_irqrestore(&udc->lock, flags);
 
+	mutex_unlock(&udc->vbus_mutex);
 	return 0;
+
+err:
+	if (gpio_is_valid(udc->vbus_pin))
+		disable_irq(gpio_to_irq(udc->vbus_pin));
+
+	mutex_unlock(&udc->vbus_mutex);
+
+	spin_lock_irqsave(&udc->lock, flags);
+	udc->devstatus &= ~(1 << USB_DEVICE_SELF_POWERED);
+	udc->driver = NULL;
+	spin_unlock_irqrestore(&udc->lock, flags);
+	return ret;
 }
 
 static int atmel_usba_stop(struct usb_gadget *gadget)
 {
 	struct usba_udc *udc = container_of(gadget, struct usba_udc, gadget);
-	unsigned long flags;
 
 	if (gpio_is_valid(udc->vbus_pin))
 		disable_irq(gpio_to_irq(udc->vbus_pin));
 
-	spin_lock_irqsave(&udc->lock, flags);
-	udc->gadget.speed = USB_SPEED_UNKNOWN;
-	reset_all_endpoints(udc);
-	spin_unlock_irqrestore(&udc->lock, flags);
-
-	/* This will also disable the DP pullup */
-	toggle_bias(udc, 0);
-	usba_writel(udc, CTRL, USBA_DISABLE_MASK);
-
-	clk_disable_unprepare(udc->hclk);
-	clk_disable_unprepare(udc->pclk);
+	usba_stop(udc);
 
 	udc->driver = NULL;
 
@@ -2050,6 +2097,7 @@ static int usba_udc_probe(struct platform_device *pdev)
 		return PTR_ERR(hclk);
 
 	spin_lock_init(&udc->lock);
+	mutex_init(&udc->vbus_mutex);
 	udc->pdev = pdev;
 	udc->pclk = pclk;
 	udc->hclk = hclk;
@@ -2106,9 +2154,9 @@ static int usba_udc_probe(struct platform_device *pdev)
 		if (!devm_gpio_request(&pdev->dev, udc->vbus_pin, "atmel_usba_udc")) {
 			irq_set_status_flags(gpio_to_irq(udc->vbus_pin),
 					IRQ_NOAUTOEN);
-			ret = devm_request_irq(&pdev->dev,
-					gpio_to_irq(udc->vbus_pin),
-					usba_vbus_irq, 0,
+			ret = devm_request_threaded_irq(&pdev->dev,
+					gpio_to_irq(udc->vbus_pin), NULL,
+					usba_vbus_irq_thread, IRQF_ONESHOT,
 					"atmel_usba_udc", udc);
 			if (ret) {
 				udc->vbus_pin = -ENODEV;
diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.h b/drivers/usb/gadget/udc/atmel_usba_udc.h
index 497cd18..085749a 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.h
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.h
@@ -313,6 +313,9 @@ struct usba_udc {
 	/* Protect hw registers from concurrent modifications */
 	spinlock_t lock;
 
+	/* Mutex to prevent concurrent start or stop */
+	struct mutex vbus_mutex;
+
 	void __iomem *regs;
 	void __iomem *fifo;
 
@@ -328,6 +331,7 @@ struct usba_udc {
 	struct clk *hclk;
 	struct usba_ep *usba_ep;
 	bool bias_pulse_needed;
+	bool clocked;
 
 	u16 devstatus;
 
-- 
2.1.4
