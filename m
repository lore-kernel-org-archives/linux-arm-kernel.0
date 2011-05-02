From: avictor.za@gmail.com (Andrew Victor)
Date: Tue, 03 May 2011 00:00:08 +0200
Subject: AT91: Move non-portable processor-specific code out of USB Gadget
	drivers
Message-ID: <1304373608.1628.19.camel@redbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For supporting multiple AT91 processors in a single kernel image, the
address of system-peripherals cannot be determined at compile-time.
Therefore we need to remove calls to the at91_sys_read/at91_sys_write
macro's and any "#ifdef CONFIG_ARCH_AT91xxx" code.

In the USB Gadget subsystems there are 2 instances:
 * controlling the pullup for the AT91SAM9261.
 * controlling the bias for the AT91SAM9RL.

The following patch add a "pullup" method to the "struct at91_udc_data"
platform-data, and a "set_bias" method to the "struct
usba_platform_data".  The code for the two instances above is moved from
the drivers and into the processor-specific code.  The driver's access
the code via the methods provided in the platform_data.

Signed-off-by: Andrew Victor <linux@maxim.org.za>

 arch/arm/mach-at91/at91sam9261_devices.c |   12 ++++++++++
 arch/arm/mach-at91/at91sam9rl_devices.c  |   12 ++++++++++
 arch/arm/mach-at91/include/mach/board.h  |    1 
 drivers/usb/gadget/at91_udc.c            |   18 +++------------
 drivers/usb/gadget/atmel_usba_udc.c      |   37 +++++++++----------------------
 drivers/usb/gadget/atmel_usba_udc.h      |    1 
 include/linux/usb/atmel_usba_udc.h       |    1 
 7 files changed, 42 insertions(+), 40 deletions(-)


diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index dc8bfc3..5614347 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -80,6 +80,17 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data) {}
  * -------------------------------------------------------------------- */
 
 #ifdef CONFIG_USB_GADGET_AT91
+
+static void at91sam9261_udc_pullup(int on)
+{
+	u32 usbpucr = at91_sys_read(AT91_MATRIX_USBPUCR);
+
+	if (on)
+		at91_sys_write(AT91_MATRIX_USBPUCR, usbpucr | AT91_MATRIX_USBPUCR_PUON);
+	else
+		at91_sys_write(AT91_MATRIX_USBPUCR, usbpucr & ~AT91_MATRIX_USBPUCR_PUON);
+}
+
 static struct at91_udc_data udc_data;
 
 static struct resource udc_resources[] = {
@@ -116,6 +127,7 @@ void __init at91_add_device_udc(struct at91_udc_data *data)
 	}
 
 	/* Pullup pin is handled internally by USB device peripheral */
+	data->pullup = at91sam9261_udc_pullup;
 
 	udc_data = *data;
 	platform_device_register(&at91sam9261_udc_device);
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index ee013c1..2464ef4 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -22,6 +22,7 @@
 #include <mach/at91sam9rl_matrix.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at_hdmac.h>
+#include <mach/at91_pmc.h>
 
 #include "generic.h"
 
@@ -77,6 +78,16 @@ void __init at91_add_device_hdmac(void) {}
 
 #if defined(CONFIG_USB_GADGET_ATMEL_USBA) || defined(CONFIG_USB_GADGET_ATMEL_USBA_MODULE)
 
+static void at91sam9rl_udc_bias(int on)
+{
+	unsigned int uckr = __raw_readl(AT91SAM9RL_PMC + AT91_CKGR_UCKR);
+
+	if (on)
+		__raw_writel(uckr | AT91_PMC_BIASEN, AT91SAM9RL_PMC + AT91_CKGR_UCKR);
+	else
+		__raw_writel(uckr & ~(AT91_PMC_BIASEN), AT91SAM9RL_PMC + AT91_CKGR_UCKR);
+}
+
 static struct resource usba_udc_resources[] = {
 	[0] = {
 		.start	= AT91SAM9RL_UDPHS_FIFO,
@@ -154,6 +165,7 @@ void __init at91_add_device_usba(struct usba_platform_data *data)
 	}
 
 	/* Pullup pin is handled internally by USB device peripheral */
+	usba_udc_data.pdata.set_bias = at91sam9rl_udc_bias;
 
 	/* Clocks */
 	at91_clock_associate("utmi_clk", &at91_usba_udc_device.dev, "hclk");
diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
index 2b499eb..918826e 100644
--- a/arch/arm/mach-at91/include/mach/board.h
+++ b/arch/arm/mach-at91/include/mach/board.h
@@ -48,6 +48,7 @@ struct at91_udc_data {
 	u8	vbus_polled;		/* Use polling, not interrupt */
 	u8	pullup_pin;		/* active == D+ pulled up */
 	u8	pullup_active_low;	/* true == pullup_pin is active low */
+	void	(*pullup)(int on);	/* external pullup control */
 };
 extern void __init at91_add_device_udc(struct at91_udc_data *data);
 
diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index 9b7cdb1..3e85969 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -915,13 +915,8 @@ static void pullup(struct at91_udc *udc, int is_on)
 
 			txvc |= AT91_UDP_TXVC_PUON;
 			at91_udp_write(udc, AT91_UDP_TXVC, txvc);
-		} else if (cpu_is_at91sam9261() || cpu_is_at91sam9g10()) {
-			u32	usbpucr;
-
-			usbpucr = at91_sys_read(AT91_MATRIX_USBPUCR);
-			usbpucr |= AT91_MATRIX_USBPUCR_PUON;
-			at91_sys_write(AT91_MATRIX_USBPUCR, usbpucr);
-		}
+		} else if (udc->board.pullup)
+			(udc->board.pullup)(is_on);
 	} else {
 		stop_activity(udc);
 		at91_udp_write(udc, AT91_UDP_IDR, AT91_UDP_RXRSM);
@@ -933,13 +928,8 @@ static void pullup(struct at91_udc *udc, int is_on)
 
 			txvc &= ~AT91_UDP_TXVC_PUON;
 			at91_udp_write(udc, AT91_UDP_TXVC, txvc);
-		} else if (cpu_is_at91sam9261() || cpu_is_at91sam9g10()) {
-			u32	usbpucr;
-
-			usbpucr = at91_sys_read(AT91_MATRIX_USBPUCR);
-			usbpucr &= ~AT91_MATRIX_USBPUCR_PUON;
-			at91_sys_write(AT91_MATRIX_USBPUCR, usbpucr);
-		}
+		} else if (udc->board.pullup)
+			(udc->board.pullup)(is_on);
 		clk_off(udc);
 	}
 }
diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index c137b99..377b090 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -326,28 +326,12 @@ static int vbus_is_present(struct usba_udc *udc)
 	return 1;
 }
 
-#if defined(CONFIG_ARCH_AT91SAM9RL)
-
-#include <mach/at91_pmc.h>
-
-static void toggle_bias(int is_on)
-{
-	unsigned int uckr = at91_sys_read(AT91SAM9RL_PMC + AT91_CKGR_UCKR);
-
-	if (is_on)
-		at91_sys_write(AT91SAM9RL_PMC + AT91_CKGR_UCKR, uckr | AT91_PMC_BIASEN);
-	else
-		at91_sys_write(AT91SAM9RL_PMC + AT91_CKGR_UCKR, uckr & ~(AT91_PMC_BIASEN));
-}
-
-#else
-
-static void toggle_bias(int is_on)
+static void toggle_bias(struct usba_udc *udc, int is_on)
 {
+	if (udc->set_bias)
+		(udc->set_bias)(is_on);
 }
 
-#endif /* CONFIG_ARCH_AT91SAM9RL */
-
 static void next_fifo_transaction(struct usba_ep *ep, struct usba_request *req)
 {
 	unsigned int transaction_len;
@@ -1648,7 +1632,7 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 	DBG(DBG_INT, "irq, status=%#08x\n", status);
 
 	if (status & USBA_DET_SUSPEND) {
-		toggle_bias(0);
+		toggle_bias(udc, 0);
 		usba_writel(udc, INT_CLR, USBA_DET_SUSPEND);
 		DBG(DBG_BUS, "Suspend detected\n");
 		if (udc->gadget.speed != USB_SPEED_UNKNOWN
@@ -1660,7 +1644,7 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 	}
 
 	if (status & USBA_WAKE_UP) {
-		toggle_bias(1);
+		toggle_bias(udc, 1);
 		usba_writel(udc, INT_CLR, USBA_WAKE_UP);
 		DBG(DBG_BUS, "Wake Up CPU detected\n");
 	}
@@ -1766,13 +1750,13 @@ static irqreturn_t usba_vbus_irq(int irq, void *devid)
 	vbus = vbus_is_present(udc);
 	if (vbus != udc->vbus_prev) {
 		if (vbus) {
-			toggle_bias(1);
+			toggle_bias(udc, 1);
 			usba_writel(udc, CTRL, USBA_ENABLE_MASK);
 			usba_writel(udc, INT_ENB, USBA_END_OF_RESET);
 		} else {
 			udc->gadget.speed = USB_SPEED_UNKNOWN;
 			reset_all_endpoints(udc);
-			toggle_bias(0);
+			toggle_bias(udc, 0);
 			usba_writel(udc, CTRL, USBA_DISABLE_MASK);
 			if (udc->driver->disconnect) {
 				spin_unlock(&udc->lock);
@@ -1829,7 +1813,7 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
 	/* If Vbus is present, enable the controller and wait for reset */
 	spin_lock_irqsave(&udc->lock, flags);
 	if (vbus_is_present(udc) && udc->vbus_prev == 0) {
-		toggle_bias(1);
+		toggle_bias(udc, 1);
 		usba_writel(udc, CTRL, USBA_ENABLE_MASK);
 		usba_writel(udc, INT_ENB, USBA_END_OF_RESET);
 	}
@@ -1863,7 +1847,7 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 	spin_unlock_irqrestore(&udc->lock, flags);
 
 	/* This will also disable the DP pullup */
-	toggle_bias(0);
+	toggle_bias(udc, 0);
 	usba_writel(udc, CTRL, USBA_DISABLE_MASK);
 
 	if (udc->driver->disconnect)
@@ -1933,12 +1917,13 @@ static int __init usba_udc_probe(struct platform_device *pdev)
 	device_initialize(&udc->gadget.dev);
 	udc->gadget.dev.parent = &pdev->dev;
 	udc->gadget.dev.dma_mask = pdev->dev.dma_mask;
+	udc->set_bias = pdata->set_bias;
 
 	platform_set_drvdata(pdev, udc);
 
 	/* Make sure we start from a clean slate */
 	clk_enable(pclk);
-	toggle_bias(0);
+	toggle_bias(udc, 0);
 	usba_writel(udc, CTRL, USBA_DISABLE_MASK);
 	clk_disable(pclk);
 
diff --git a/drivers/usb/gadget/atmel_usba_udc.h b/drivers/usb/gadget/atmel_usba_udc.h
index 88a2e07..a6ff9a7 100644
--- a/drivers/usb/gadget/atmel_usba_udc.h
+++ b/drivers/usb/gadget/atmel_usba_udc.h
@@ -324,6 +324,7 @@ struct usba_udc {
 	int irq;
 	int vbus_pin;
 	int vbus_pin_inverted;
+	void (*set_bias)(int on);
 	struct clk *pclk;
 	struct clk *hclk;
 
diff --git a/include/linux/usb/atmel_usba_udc.h b/include/linux/usb/atmel_usba_udc.h
index ba99af2..8336ae2 100644
--- a/include/linux/usb/atmel_usba_udc.h
+++ b/include/linux/usb/atmel_usba_udc.h
@@ -16,6 +16,7 @@ struct usba_ep_data {
 struct usba_platform_data {
 	int			vbus_pin;
 	int			vbus_pin_inverted;
+	void			(*set_bias)(int on);
 	int			num_ep;
 	struct usba_ep_data	ep[0];
 };
