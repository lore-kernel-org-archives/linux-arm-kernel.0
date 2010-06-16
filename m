From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 17 Jun 2010 09:20:23 +1200
Subject: [PATCH 2/3] at91_udc: Add vbus polarity and polling mode
In-Reply-To: <1276723224-23252-1-git-send-email-ryan@bluewatersys.com>
References: <1276723224-23252-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1276723224-23252-3-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow the vbus signal to optionally use polling. This is required if
the vbus signal is connected to an non-interrupting io expander for
example. Also add an option to have vbus be an active low signal. Both
options are set in the platform data for the device.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/include/mach/board.h |    2 +
 drivers/usb/gadget/at91_udc.c           |   45 ++++++++++++++++++++++++-------
 drivers/usb/gadget/at91_udc.h           |    1 +
 3 files changed, 38 insertions(+), 10 deletions(-)

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
index eaa79c8..9649d76 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -76,6 +76,7 @@
 static const char driver_name [] = "at91_udc";
 static const char ep0name[] = "ep0";
 
+#define VBUS_POLL_TIMEOUT	msecs_to_jiffies(1000)
 
 #define at91_udp_read(dev, reg) \
 	__raw_readl((dev)->udp_baseaddr + (reg))
@@ -1556,20 +1557,37 @@ static struct at91_udc controller = {
 	/* ep6 and ep7 are also reserved (custom silicon might use them) */
 };
 
+static void at91_vbus_update(struct at91_udc *udc)
+{
+	unsigned value;
+
+	value = gpio_get_value(udc->board.vbus_pin);
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
+	at91_vbus_update(udc);
 
 	return IRQ_HANDLED;
 }
 
+static void at91_vbus_timer(unsigned long data)
+{
+	struct at91_udc *udc = (struct at91_udc *)data;
+
+	at91_vbus_update(udc);
+	if (!timer_pending(&udc->vbus_timer))
+	    mod_timer(&udc->vbus_timer, jiffies + VBUS_POLL_TIMEOUT);
+}
+
 int usb_gadget_register_driver (struct usb_gadget_driver *driver)
 {
 	struct at91_udc	*udc = &controller;
@@ -1764,12 +1782,19 @@ static int __init at91udc_probe(struct platform_device *pdev)
 		 * a pending interrupt.
 		 */
 		udc->vbus = gpio_get_value(udc->board.vbus_pin);
-		if (request_irq(udc->board.vbus_pin, at91_vbus_irq,
-				IRQF_DISABLED, driver_name, udc)) {
-			DBG("request vbus irq %d failed\n",
-					udc->board.vbus_pin);
-			retval = -EBUSY;
-			goto fail3;
+		if (udc->board.vbus_polled) {
+			setup_timer(&udc->vbus_timer, at91_vbus_timer,
+				    (unsigned long)udc);
+			mod_timer(&udc->vbus_timer,
+				  jiffies + VBUS_POLL_TIMEOUT);
+		} else {
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
diff --git a/drivers/usb/gadget/at91_udc.h b/drivers/usb/gadget/at91_udc.h
index c65d622..2ebd665 100644
--- a/drivers/usb/gadget/at91_udc.h
+++ b/drivers/usb/gadget/at91_udc.h
@@ -144,6 +144,7 @@ struct at91_udc {
 	struct proc_dir_entry		*pde;
 	void __iomem			*udp_baseaddr;
 	int				udp_irq;
+	struct timer_list		vbus_timer;
 };
 
 static inline struct at91_udc *to_udc(struct usb_gadget *g)
-- 
1.5.5.1
