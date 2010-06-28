From: ryan@bluewatersys.com (Ryan Mallon)
Date: Mon, 28 Jun 2010 16:39:14 +1200
Subject: [PATCH 2/3] at91_udc: Add vbus polarity and polling mode
In-Reply-To: <1277699955-9931-1-git-send-email-ryan@bluewatersys.com>
References: <1277699955-9931-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1277699955-9931-3-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow the vbus signal to optionally use polling. This is required if
the vbus signal is connected to an non-interrupting io expander for
example. If vbus is in polling mode, then it is assumed that the vbus
gpio may sleep. Also add an option to have vbus be an active low
signal. Both options are set in the platform data for the device.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/include/mach/board.h |    2 +
 drivers/usb/gadget/at91_udc.c           |   66 +++++++++++++++++++++++++------
 drivers/usb/gadget/at91_udc.h           |    2 +
 3 files changed, 57 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
index df2ed84..58528aa 100644
--- a/arch/arm/mach-at91/include/mach/board.h
+++ b/arch/arm/mach-at91/include/mach/board.h
@@ -44,6 +44,8 @@
  /* USB Device */
 struct at91_udc_data {
 	u8	vbus_pin;		/* high == host powering us */
+	u8	vbus_active_low;	/* vbus polarity */
+	u8	vbus_polled;		/* Use polling, not interrupt */
 	u8	pullup_pin;		/* active == D+ pulled up */
 	u8	pullup_active_low;	/* true == pullup_pin is active low */
 };
diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index eaa79c8..469a64c 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -76,6 +76,7 @@
 static const char driver_name [] = "at91_udc";
 static const char ep0name[] = "ep0";
 
+#define VBUS_POLL_TIMEOUT	msecs_to_jiffies(1000)
 
 #define at91_udp_read(dev, reg) \
 	__raw_readl((dev)->udp_baseaddr + (reg))
@@ -1556,20 +1557,49 @@ static struct at91_udc controller = {
 	/* ep6 and ep7 are also reserved (custom silicon might use them) */
 };
 
+static void at91_vbus_update(struct at91_udc *udc, unsigned value)
+{
+	if (udc->board.vbus_active_low)
+		value ^= 1;
+	if (value != udc->vbus)
+		at91_vbus_session(&udc->gadget, value);
+}
+
 static irqreturn_t at91_vbus_irq(int irq, void *_udc)
 {
 	struct at91_udc	*udc = _udc;
-	unsigned	value;
 
 	/* vbus needs at least brief debouncing */
 	udelay(10);
-	value = gpio_get_value(udc->board.vbus_pin);
-	if (value != udc->vbus)
-		at91_vbus_session(&udc->gadget, value);
+	at91_vbus_update(udc, gpio_get_value(udc->board.vbus_pin));
 
 	return IRQ_HANDLED;
 }
 
+static void at91_vbus_timer_work(struct work_struct *work)
+{
+	struct at91_udc *udc = container_of(work, struct at91_udc, 
+					    vbus_timer_work);
+
+	at91_vbus_update(udc, gpio_get_value_cansleep(udc->board.vbus_pin));
+
+	if (!timer_pending(&udc->vbus_timer))
+		mod_timer(&udc->vbus_timer, jiffies + VBUS_POLL_TIMEOUT);
+}
+
+static void at91_vbus_timer(unsigned long data)
+{
+	struct at91_udc *udc = (struct at91_udc *)data;
+
+	/*
+	 * If we are polling vbus it is likely that the gpio is on an
+	 * bus such as i2c or spi which may sleep, so schedule some work
+	 * to read the vbus gpio
+	 */
+	if (!work_pending(&udc->vbus_timer_work))
+		schedule_work(&udc->vbus_timer_work);
+}
+
 int usb_gadget_register_driver (struct usb_gadget_driver *driver)
 {
 	struct at91_udc	*udc = &controller;
@@ -1763,13 +1793,22 @@ static int __init at91udc_probe(struct platform_device *pdev)
 		 * Get the initial state of VBUS - we cannot expect
 		 * a pending interrupt.
 		 */
-		udc->vbus = gpio_get_value(udc->board.vbus_pin);
-		if (request_irq(udc->board.vbus_pin, at91_vbus_irq,
-				IRQF_DISABLED, driver_name, udc)) {
-			DBG("request vbus irq %d failed\n",
-					udc->board.vbus_pin);
-			retval = -EBUSY;
-			goto fail3;
+		if (udc->board.vbus_polled) {
+			udc->vbus = gpio_get_value_cansleep(udc->board.vbus_pin);
+			INIT_WORK(&udc->vbus_timer_work, at91_vbus_timer_work);
+			setup_timer(&udc->vbus_timer, at91_vbus_timer,
+				    (unsigned long)udc);		
+			mod_timer(&udc->vbus_timer,
+				  jiffies + VBUS_POLL_TIMEOUT);
+		} else {
+			udc->vbus = gpio_get_value(udc->board.vbus_pin);
+			if (request_irq(udc->board.vbus_pin, at91_vbus_irq,
+					IRQF_DISABLED, driver_name, udc)) {
+				DBG("request vbus irq %d failed\n",
+				    udc->board.vbus_pin);
+				retval = -EBUSY;
+				goto fail3;
+			}
 		}
 	} else {
 		DBG("no VBUS detection, assuming always-on\n");
@@ -1855,7 +1894,7 @@ static int at91udc_suspend(struct platform_device *pdev, pm_message_t mesg)
 		enable_irq_wake(udc->udp_irq);
 
 	udc->active_suspend = wake;
-	if (udc->board.vbus_pin > 0 && wake)
+	if (udc->board.vbus_pin > 0 && !udc->board.vbus_polled && wake)
 		enable_irq_wake(udc->board.vbus_pin);
 	return 0;
 }
@@ -1864,7 +1903,8 @@ static int at91udc_resume(struct platform_device *pdev)
 {
 	struct at91_udc *udc = platform_get_drvdata(pdev);
 
-	if (udc->board.vbus_pin > 0 && udc->active_suspend)
+	if (udc->board.vbus_pin > 0 && !udc->board.vbus_polled && 
+	    udc->active_suspend)
 		disable_irq_wake(udc->board.vbus_pin);
 
 	/* maybe reconnect to host; if so, clocks on */
diff --git a/drivers/usb/gadget/at91_udc.h b/drivers/usb/gadget/at91_udc.h
index c65d622..a1f4f54 100644
--- a/drivers/usb/gadget/at91_udc.h
+++ b/drivers/usb/gadget/at91_udc.h
@@ -144,6 +144,8 @@ struct at91_udc {
 	struct proc_dir_entry		*pde;
 	void __iomem			*udp_baseaddr;
 	int				udp_irq;
+	struct timer_list		vbus_timer;
+	struct work_struct		vbus_timer_work;
 };
 
 static inline struct at91_udc *to_udc(struct usb_gadget *g)
-- 
1.5.5.1
