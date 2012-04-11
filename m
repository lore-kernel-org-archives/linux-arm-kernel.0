From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 11 Apr 2012 15:55:10 +0200
Subject: [PATCH 1/1] ARM: at91: sam9rl pass the toggle bias via pdata for
 ATMEL USBA UDC
Message-ID: <1334152510-11031-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The toggle bias is soc specific we need to pass it via plarform_data to be able
to have multiple soc in the same kernel.

This will also fix the modules support.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-usb at vger.kernel.org
---
Hi Greg,

	If it's ok with you we will apply it via at91 tree

Best Regards,
J.
 arch/arm/mach-at91/at91sam9rl_devices.c |   12 ++++++++++
 drivers/usb/gadget/atmel_usba_udc.c     |   35 +++++++++---------------------
 drivers/usb/gadget/atmel_usba_udc.h     |    2 +
 include/linux/usb/atmel_usba_udc.h      |    1 +
 4 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index fe4ae22..409cee6 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -72,6 +72,16 @@ void __init at91_add_device_hdmac(void) {}
 
 #if defined(CONFIG_USB_ATMEL_USBA) || defined(CONFIG_USB_ATMEL_USBA_MODULE)
 
+static void toggle_bias(int is_on)
+{
+	unsigned int uckr = at91_pmc_read(AT91_CKGR_UCKR);
+
+	if (is_on)
+		at91_pmc_write(AT91_CKGR_UCKR, uckr | AT91_PMC_BIASEN);
+	else
+		at91_pmc_write(AT91_CKGR_UCKR, uckr & ~(AT91_PMC_BIASEN));
+}
+
 static struct resource usba_udc_resources[] = {
 	[0] = {
 		.start	= AT91SAM9RL_UDPHS_FIFO,
@@ -148,6 +158,8 @@ void __init at91_add_device_usba(struct usba_platform_data *data)
 		usba_udc_data.pdata.vbus_pin = data->vbus_pin;
 	}
 
+	usba_udc_data.pdata.toggle_bias = toggle_bias;
+
 	/* Pullup pin is handled internally by USB device peripheral */
 
 	platform_device_register(&at91_usba_udc_device);
diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index 9f98508..54d3303 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -326,28 +326,10 @@ static int vbus_is_present(struct usba_udc *udc)
 	return 1;
 }
 
-#if defined(CONFIG_ARCH_AT91SAM9RL)
-
-#include <mach/at91_pmc.h>
-
 static void toggle_bias(int is_on)
 {
-	unsigned int uckr = at91_pmc_read(AT91_CKGR_UCKR);
-
-	if (is_on)
-		at91_pmc_write(AT91_CKGR_UCKR, uckr | AT91_PMC_BIASEN);
-	else
-		at91_pmc_write(AT91_CKGR_UCKR, uckr & ~(AT91_PMC_BIASEN));
 }
 
-#else
-
-static void toggle_bias(int is_on)
-{
-}
-
-#endif /* CONFIG_ARCH_AT91SAM9RL */
-
 static void next_fifo_transaction(struct usba_ep *ep, struct usba_request *req)
 {
 	unsigned int transaction_len;
@@ -1667,7 +1649,7 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 	}
 
 	if (status & USBA_WAKE_UP) {
-		toggle_bias(1);
+		udc->toggle_bias(1);
 		usba_writel(udc, INT_CLR, USBA_WAKE_UP);
 		DBG(DBG_BUS, "Wake Up CPU detected\n");
 	}
@@ -1772,13 +1754,13 @@ static irqreturn_t usba_vbus_irq(int irq, void *devid)
 	vbus = vbus_is_present(udc);
 	if (vbus != udc->vbus_prev) {
 		if (vbus) {
-			toggle_bias(1);
+			udc->toggle_bias(1);
 			usba_writel(udc, CTRL, USBA_ENABLE_MASK);
 			usba_writel(udc, INT_ENB, USBA_END_OF_RESET);
 		} else {
 			udc->gadget.speed = USB_SPEED_UNKNOWN;
 			reset_all_endpoints(udc);
-			toggle_bias(0);
+			udc->toggle_bias(0);
 			usba_writel(udc, CTRL, USBA_DISABLE_MASK);
 			if (udc->driver->disconnect) {
 				spin_unlock(&udc->lock);
@@ -1835,7 +1817,7 @@ static int atmel_usba_start(struct usb_gadget_driver *driver,
 	/* If Vbus is present, enable the controller and wait for reset */
 	spin_lock_irqsave(&udc->lock, flags);
 	if (vbus_is_present(udc) && udc->vbus_prev == 0) {
-		toggle_bias(1);
+		udc->toggle_bias(1);
 		usba_writel(udc, CTRL, USBA_ENABLE_MASK);
 		usba_writel(udc, INT_ENB, USBA_END_OF_RESET);
 	}
@@ -1868,7 +1850,7 @@ static int atmel_usba_stop(struct usb_gadget_driver *driver)
 	spin_unlock_irqrestore(&udc->lock, flags);
 
 	/* This will also disable the DP pullup */
-	toggle_bias(0);
+	udc->toggle_bias(0);
 	usba_writel(udc, CTRL, USBA_DISABLE_MASK);
 
 	if (udc->driver->disconnect)
@@ -1940,9 +1922,14 @@ static int __init usba_udc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, udc);
 
+	if (pdata->toggle_bias)
+		udc->toggle_bias = pdata->toggle_bias;
+	else
+		udc->toggle_bias = toggle_bias;
+
 	/* Make sure we start from a clean slate */
 	clk_enable(pclk);
-	toggle_bias(0);
+	udc->toggle_bias(0);
 	usba_writel(udc, CTRL, USBA_DISABLE_MASK);
 	clk_disable(pclk);
 
diff --git a/drivers/usb/gadget/atmel_usba_udc.h b/drivers/usb/gadget/atmel_usba_udc.h
index 88a2e07..edfb6d5 100644
--- a/drivers/usb/gadget/atmel_usba_udc.h
+++ b/drivers/usb/gadget/atmel_usba_udc.h
@@ -318,6 +318,8 @@ struct usba_udc {
 	void __iomem *regs;
 	void __iomem *fifo;
 
+	void (*toggle_bias)(int is_on);
+
 	struct usb_gadget gadget;
 	struct usb_gadget_driver *driver;
 	struct platform_device *pdev;
diff --git a/include/linux/usb/atmel_usba_udc.h b/include/linux/usb/atmel_usba_udc.h
index ba99af2..87326a5 100644
--- a/include/linux/usb/atmel_usba_udc.h
+++ b/include/linux/usb/atmel_usba_udc.h
@@ -18,6 +18,7 @@ struct usba_platform_data {
 	int			vbus_pin_inverted;
 	int			num_ep;
 	struct usba_ep_data	ep[0];
+	void 			(*toggle_bias)(int is_on);
 };
 
 #endif /* __LINUX_USB_USBA_H */
-- 
1.7.9.1
