From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue,  5 Jul 2011 17:08:41 +0400
Subject: [PATCH 15/15] pxa2[57]x_udc: drop gpio_pullup handling
In-Reply-To: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
References: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1309871321-11305-16-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now as all drivers were converted to using gpio-vbus, drop gpio-pullup
handling from pxa UDC drivers, thus simplifying them a bit.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/include/asm/mach/udc_pxa2xx.h |    8 -----
 arch/arm/mach-pxa/balloon3.c           |    1 -
 arch/arm/mach-pxa/colibri-pxa320.c     |    1 -
 arch/arm/mach-pxa/devices.c            |    2 +-
 arch/arm/mach-pxa/vpac270.c            |    1 -
 drivers/usb/gadget/pxa25x_udc.c        |   54 --------------------------------
 drivers/usb/gadget/pxa27x_udc.c        |   27 +---------------
 7 files changed, 3 insertions(+), 91 deletions(-)

diff --git a/arch/arm/include/asm/mach/udc_pxa2xx.h b/arch/arm/include/asm/mach/udc_pxa2xx.h
index f0719d3..4cab1d6 100644
--- a/arch/arm/include/asm/mach/udc_pxa2xx.h
+++ b/arch/arm/include/asm/mach/udc_pxa2xx.h
@@ -13,13 +13,5 @@ struct pxa2xx_udc_mach_info {
         void (*udc_command)(int cmd);
 #define	PXA2XX_UDC_CMD_CONNECT		0	/* let host see us */
 #define	PXA2XX_UDC_CMD_DISCONNECT	1	/* so host won't see us */
-
-	/* Boards following the design guidelines in the developer's manual,
-	 * with on-chip GPIOs not Lubbock's weird hardware, can have a sane
-	 * VBUS IRQ and omit the methods above.  Store the GPIO number
-	 * here.  Note that sometimes the signals go through inverters...
-	 */
-	bool	gpio_pullup_inverted;
-	int	gpio_pullup;			/* high == pullup activated */
 };
 
diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 4d0d8c3..a420c1e 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -318,7 +318,6 @@ static void balloon3_udc_command(int cmd)
 
 static struct pxa2xx_udc_mach_info balloon3_udc_info __initdata = {
 	.udc_command		= balloon3_udc_command,
-	.gpio_pullup		= -1,
 };
 
 static void __init balloon3_udc_init(void)
diff --git a/arch/arm/mach-pxa/colibri-pxa320.c b/arch/arm/mach-pxa/colibri-pxa320.c
index ff9ff5f..f799b0a 100644
--- a/arch/arm/mach-pxa/colibri-pxa320.c
+++ b/arch/arm/mach-pxa/colibri-pxa320.c
@@ -171,7 +171,6 @@ static void colibri_pxa320_udc_command(int cmd)
 
 static struct pxa2xx_udc_mach_info colibri_pxa320_udc_info __initdata = {
 	.udc_command		= colibri_pxa320_udc_command,
-	.gpio_pullup		= -1,
 };
 
 static void __init colibri_pxa320_init_udc(void)
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 2e04254..59a3578 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -89,7 +89,7 @@ void __init pxa_set_mci_info(struct pxamci_platform_data *info)
 
 
 static struct pxa2xx_udc_mach_info pxa_udc_info = {
-	.gpio_pullup = -1,
+	.udc_command = NULL,
 };
 
 void __init pxa_set_udc_info(struct pxa2xx_udc_mach_info *info)
diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index 67bd414..3641935 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -367,7 +367,6 @@ static void vpac270_udc_command(int cmd)
 
 static struct pxa2xx_udc_mach_info vpac270_udc_info __initdata = {
 	.udc_command		= vpac270_udc_command,
-	.gpio_pullup		= -1,
 };
 
 static void __init vpac270_udc_init(void)
diff --git a/drivers/usb/gadget/pxa25x_udc.c b/drivers/usb/gadget/pxa25x_udc.c
index aa34698..221fe19 100644
--- a/drivers/usb/gadget/pxa25x_udc.c
+++ b/drivers/usb/gadget/pxa25x_udc.c
@@ -50,7 +50,6 @@
 
 #include <asm/byteorder.h>
 #include <asm/dma.h>
-#include <asm/gpio.h>
 #include <asm/system.h>
 #include <asm/mach-types.h>
 #include <asm/unaligned.h>
@@ -136,25 +135,6 @@ static const char ep0name [] = "ep0";
 static void pxa25x_ep_fifo_flush (struct usb_ep *ep);
 static void nuke (struct pxa25x_ep *, int status);
 
-/* one GPIO should control a D+ pullup, so host sees this device (or not) */
-static void pullup_off(void)
-{
-	struct pxa2xx_udc_mach_info		*mach = the_controller->mach;
-	int off_level = mach->gpio_pullup_inverted;
-
-	if (gpio_is_valid(mach->gpio_pullup))
-		gpio_set_value(mach->gpio_pullup, off_level);
-}
-
-static void pullup_on(void)
-{
-	struct pxa2xx_udc_mach_info		*mach = the_controller->mach;
-	int on_level = !mach->gpio_pullup_inverted;
-
-	if (gpio_is_valid(mach->gpio_pullup))
-		gpio_set_value(mach->gpio_pullup, on_level);
-}
-
 static void pio_irq_enable(int bEndpointAddress)
 {
         bEndpointAddress &= 0xf;
@@ -979,10 +959,6 @@ static int pxa25x_udc_pullup(struct usb_gadget *_gadget, int is_active)
 
 	udc = container_of(_gadget, struct pxa25x_udc, gadget);
 
-	/* not all boards support pullup control */
-	if (!gpio_is_valid(udc->mach->gpio_pullup))
-		return -EOPNOTSUPP;
-
 	udc->pullup = (is_active != 0);
 	pullup(udc);
 	return 0;
@@ -1160,9 +1136,6 @@ static void udc_disable(struct pxa25x_udc *dev)
 	UICR0 = UICR1 = 0xff;
 	UFNRH = UFNRH_SIM;
 
-	/* if hardware supports it, disconnect from usb */
-	pullup_off();
-
 	udc_clear_mask_UDCCR(UDCCR_UDE);
 
 	ep0_idle (dev);
@@ -1243,9 +1216,6 @@ static void udc_enable (struct pxa25x_udc *dev)
 
 	/* enable ep0 irqs */
 	UICR0 &= ~UICR0_IM0;
-
-	/* if hardware supports it, pullup D+ and wait for reset */
-	pullup_on();
 }
 
 
@@ -2126,17 +2096,6 @@ static int __init pxa25x_udc_probe(struct platform_device *pdev)
 
 	dev->transceiver = otg_get_transceiver();
 
-	if (gpio_is_valid(dev->mach->gpio_pullup)) {
-		if ((retval = gpio_request(dev->mach->gpio_pullup,
-				"pca25x_udc GPIO PULLUP"))) {
-			dev_dbg(&pdev->dev,
-				"can't get pullup gpio %d, err: %d\n",
-				dev->mach->gpio_pullup, retval);
-			goto err_gpio_pullup;
-		}
-		gpio_direction_output(dev->mach->gpio_pullup, 0);
-	}
-
 	init_timer(&dev->timer);
 	dev->timer.function = udc_watchdog;
 	dev->timer.data = (unsigned long) dev;
@@ -2168,9 +2127,6 @@ static int __init pxa25x_udc_probe(struct platform_device *pdev)
 	return 0;
 
  err_irq1:
-	if (gpio_is_valid(dev->mach->gpio_pullup))
-		gpio_free(dev->mach->gpio_pullup);
- err_gpio_pullup:
 	if (dev->transceiver) {
 		otg_put_transceiver(dev->transceiver);
 		dev->transceiver = NULL;
@@ -2180,11 +2136,6 @@ static int __init pxa25x_udc_probe(struct platform_device *pdev)
 	return retval;
 }
 
-static void pxa25x_udc_shutdown(struct platform_device *_dev)
-{
-	pullup_off();
-}
-
 static int __exit pxa25x_udc_remove(struct platform_device *pdev)
 {
 	struct pxa25x_udc *dev = platform_get_drvdata(pdev);
@@ -2201,8 +2152,6 @@ static int __exit pxa25x_udc_remove(struct platform_device *pdev)
 		free_irq(platform_get_irq(pdev, 0), dev);
 		dev->got_irq = 0;
 	}
-	if (gpio_is_valid(dev->mach->gpio_pullup))
-		gpio_free(dev->mach->gpio_pullup);
 
 	clk_put(dev->clk);
 
@@ -2237,8 +2186,6 @@ static int pxa25x_udc_suspend(struct platform_device *dev, pm_message_t state)
 	struct pxa25x_udc	*udc = platform_get_drvdata(dev);
 	unsigned long flags;
 
-	if (!gpio_is_valid(udc->mach->gpio_pullup))
-		WARNING("USB host won't detect disconnect!\n");
 	udc->suspended = 1;
 
 	local_irq_save(flags);
@@ -2269,7 +2216,6 @@ static int pxa25x_udc_resume(struct platform_device *dev)
 /*-------------------------------------------------------------------------*/
 
 static struct platform_driver udc_driver = {
-	.shutdown	= pxa25x_udc_shutdown,
 	.remove		= __exit_p(pxa25x_udc_remove),
 	.suspend	= pxa25x_udc_suspend,
 	.resume		= pxa25x_udc_resume,
diff --git a/drivers/usb/gadget/pxa27x_udc.c b/drivers/usb/gadget/pxa27x_udc.c
index 5760769..cdebfa9 100644
--- a/drivers/usb/gadget/pxa27x_udc.c
+++ b/drivers/usb/gadget/pxa27x_udc.c
@@ -30,7 +30,6 @@
 #include <linux/proc_fs.h>
 #include <linux/clk.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/prefetch.h>
 
@@ -1519,15 +1518,9 @@ static struct usb_ep_ops pxa_ep_ops = {
 static void dplus_pullup(struct pxa_udc *udc, int on)
 {
 	if (on) {
-		if (gpio_is_valid(udc->mach->gpio_pullup))
-			gpio_set_value(udc->mach->gpio_pullup,
-				       !udc->mach->gpio_pullup_inverted);
 		if (udc->mach->udc_command)
 			udc->mach->udc_command(PXA2XX_UDC_CMD_CONNECT);
 	} else {
-		if (gpio_is_valid(udc->mach->gpio_pullup))
-			gpio_set_value(udc->mach->gpio_pullup,
-				       udc->mach->gpio_pullup_inverted);
 		if (udc->mach->udc_command)
 			udc->mach->udc_command(PXA2XX_UDC_CMD_DISCONNECT);
 	}
@@ -1620,7 +1613,7 @@ static int pxa_udc_pullup(struct usb_gadget *_gadget, int is_active)
 {
 	struct pxa_udc *udc = to_gadget_udc(_gadget);
 
-	if (!gpio_is_valid(udc->mach->gpio_pullup) && !udc->mach->udc_command)
+	if (!udc->mach->udc_command)
 		return -EOPNOTSUPP;
 
 	dplus_pullup(udc, is_active);
@@ -2459,7 +2452,7 @@ static int __init pxa_udc_probe(struct platform_device *pdev)
 {
 	struct resource *regs;
 	struct pxa_udc *udc = &memory;
-	int retval = 0, gpio;
+	int retval = 0;
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs)
@@ -2472,19 +2465,6 @@ static int __init pxa_udc_probe(struct platform_device *pdev)
 	udc->mach = pdev->dev.platform_data;
 	udc->transceiver = otg_get_transceiver();
 
-	gpio = udc->mach->gpio_pullup;
-	if (gpio_is_valid(gpio)) {
-		retval = gpio_request(gpio, "USB D+ pullup");
-		if (retval == 0)
-			gpio_direction_output(gpio,
-				       udc->mach->gpio_pullup_inverted);
-	}
-	if (retval) {
-		dev_err(&pdev->dev, "Couldn't request gpio %d : %d\n",
-			gpio, retval);
-		return retval;
-	}
-
 	udc->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(udc->clk)) {
 		retval = PTR_ERR(udc->clk);
@@ -2535,13 +2515,10 @@ err_clk:
 static int __exit pxa_udc_remove(struct platform_device *_dev)
 {
 	struct pxa_udc *udc = platform_get_drvdata(_dev);
-	int gpio = udc->mach->gpio_pullup;
 
 	usb_gadget_unregister_driver(udc->driver);
 	free_irq(udc->irq, udc);
 	pxa_cleanup_debugfs(udc);
-	if (gpio_is_valid(gpio))
-		gpio_free(gpio);
 
 	otg_put_transceiver(udc->transceiver);
 
-- 
1.7.5.4
