From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Tue, 20 Jan 2015 22:23:30 +0100
Subject: [PATCHv4 3/3] USB: gadget: atmel_usba_udc: Start clocks on rising
 edge of the Vbus signal, stop clocks on falling edge of the Vbus signal
In-Reply-To: <1421789010-21900-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1421789010-21900-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1421789010-21900-4-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If USB PLL is not necessary for other USB drivers (e.g. OHCI and EHCI)
it will reduce power consumption by switching off the USB PLL if no USB
Host is currently connected to this USB Device.

We are using Vbus GPIO signal to detect Host presence. If Vbus signal is
not available then the device stays continuously clocked.

Note this driver does not support suspend/resume yet, it may stay
clocked if USB Host is still connected when suspending. For what I need,
forbidding suspend from userland if we are still attached to an USB host
is fine, but we might as well add suspend/resume to this driver in the
future.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 86 ++++++++++++++++++++++++---------
 drivers/usb/gadget/udc/atmel_usba_udc.h |  4 ++
 2 files changed, 66 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 546da63..e05b16c 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -315,6 +315,37 @@ static inline void usba_cleanup_debugfs(struct usba_udc *udc)
 }
 #endif
 
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
 static int vbus_is_present(struct usba_udc *udc)
 {
 	if (gpio_is_valid(udc->vbus_pin))
@@ -1719,37 +1750,48 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t usba_vbus_irq(int irq, void *devid)
+static irqreturn_t usba_vbus_irq_thread(int irq, void *devid)
 {
 	struct usba_udc *udc = devid;
 	int vbus;
+	int ret;
+	unsigned long flags;
 
 	/* debounce */
 	udelay(10);
 
-	spin_lock(&udc->lock);
+	mutex_lock(&udc->vbus_mutex);
 
 	vbus = vbus_is_present(udc);
 	if (vbus != udc->vbus_prev) {
 		if (vbus) {
+			ret = start_clock(udc);
+			if (ret)
+				goto out;
+
+			spin_lock_irqsave(&udc->lock, flags);
 			toggle_bias(1);
 			usba_writel(udc, CTRL, USBA_ENABLE_MASK);
 			usba_writel(udc, INT_ENB, USBA_END_OF_RESET);
+			spin_unlock_irqrestore(&udc->lock, flags);
 		} else {
+			spin_lock_irqsave(&udc->lock, flags);
 			udc->gadget.speed = USB_SPEED_UNKNOWN;
 			reset_all_endpoints(udc);
 			toggle_bias(0);
 			usba_writel(udc, CTRL, USBA_DISABLE_MASK);
-			if (udc->driver->disconnect) {
-				spin_unlock(&udc->lock);
+			spin_unlock_irqrestore(&udc->lock, flags);
+
+			stop_clock(udc);
+
+			if (udc->driver->disconnect)
 				udc->driver->disconnect(&udc->gadget);
-				spin_lock(&udc->lock);
-			}
 		}
 		udc->vbus_prev = vbus;
 	}
 
-	spin_unlock(&udc->lock);
+out:
+	mutex_unlock(&udc->vbus_mutex);
 
 	return IRQ_HANDLED;
 }
@@ -1766,17 +1808,12 @@ static int atmel_usba_start(struct usb_gadget *gadget,
 	udc->driver = driver;
 	spin_unlock_irqrestore(&udc->lock, flags);
 
-	ret = clk_prepare_enable(udc->pclk);
-	if (ret)
-		goto err_pclk;
-	ret = clk_prepare_enable(udc->hclk);
-	if (ret)
-		goto err_hclk;
+	mutex_lock(&udc->vbus_mutex);
 
 	udc->vbus_prev = 0;
 	if (gpio_is_valid(udc->vbus_pin)) {
-		ret = request_irq(gpio_to_irq(udc->vbus_pin),
-				usba_vbus_irq, 0,
+		ret = request_threaded_irq(gpio_to_irq(udc->vbus_pin), NULL,
+				usba_vbus_irq_thread, IRQF_ONESHOT,
 				"atmel_usba_udc", udc);
 		if (ret) {
 			udc->vbus_pin = -ENODEV;
@@ -1785,23 +1822,24 @@ static int atmel_usba_start(struct usb_gadget *gadget,
 	}
 
 	/* If Vbus is present, enable the controller and wait for reset */
-	spin_lock_irqsave(&udc->lock, flags);
 	if (vbus_is_present(udc) && udc->vbus_prev == 0) {
+		ret = start_clock(udc);
+		if (ret)
+			goto err;
+
+		spin_lock_irqsave(&udc->lock, flags);
 		toggle_bias(1);
 		usba_writel(udc, CTRL, USBA_ENABLE_MASK);
 		usba_writel(udc, INT_ENB, USBA_END_OF_RESET);
+		spin_unlock_irqrestore(&udc->lock, flags);
 
 		udc->vbus_prev = 1;
 	}
-	spin_unlock_irqrestore(&udc->lock, flags);
 
+	mutex_unlock(&udc->vbus_mutex);
 	return 0;
-
 err:
-	clk_disable_unprepare(udc->hclk);
-err_hclk:
-	clk_disable_unprepare(udc->pclk);
-err_pclk:
+	mutex_unlock(&udc->vbus_mutex);
 	spin_lock_irqsave(&udc->lock, flags);
 	udc->devstatus &= ~(1 << USB_DEVICE_SELF_POWERED);
 	udc->driver = NULL;
@@ -1826,8 +1864,7 @@ static int atmel_usba_stop(struct usb_gadget *gadget)
 	toggle_bias(0);
 	usba_writel(udc, CTRL, USBA_DISABLE_MASK);
 
-	clk_disable_unprepare(udc->hclk);
-	clk_disable_unprepare(udc->pclk);
+	stop_clock(udc);
 
 	udc->driver = NULL;
 
@@ -2007,6 +2044,7 @@ static int usba_udc_probe(struct platform_device *pdev)
 		return PTR_ERR(hclk);
 
 	spin_lock_init(&udc->lock);
+	mutex_init(&udc->vbus_mutex);
 	udc->pdev = pdev;
 	udc->pclk = pclk;
 	udc->hclk = hclk;
diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.h b/drivers/usb/gadget/udc/atmel_usba_udc.h
index a70706e..3ceed76 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.h
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.h
@@ -308,6 +308,9 @@ struct usba_udc {
 	/* Protect hw registers from concurrent modifications */
 	spinlock_t lock;
 
+	/* Mutex to prevent concurrent start or stop */
+	struct mutex vbus_mutex;
+
 	void __iomem *regs;
 	void __iomem *fifo;
 
@@ -321,6 +324,7 @@ struct usba_udc {
 	struct clk *pclk;
 	struct clk *hclk;
 	struct usba_ep *usba_ep;
+	bool clocked;
 
 	u16 devstatus;
 
-- 
2.1.4
