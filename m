From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 14 Mar 2013 13:50:31 +0800
Subject: [PATCH 03/14] usb: at91_udc: using common vbus_active
In-Reply-To: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
References: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1363240242-25775-4-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using common vbus_active to indicate vbus status

CC: Felipe Balbi <balbi@ti.com>
Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/gadget/at91_udc.c |   16 ++++++++--------
 drivers/usb/gadget/at91_udc.h |    1 -
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index 45dd292..9508d40 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -173,9 +173,9 @@ static int proc_udc_show(struct seq_file *s, void *unused)
 	seq_printf(s, "%s: version %s\n", driver_name, DRIVER_VERSION);
 
 	seq_printf(s, "vbus %s, pullup %s, %s powered%s, gadget %s\n\n",
-		udc->vbus ? "present" : "off",
+		udc->gadget.vbus_active ? "present" : "off",
 		udc->enabled
-			? (udc->vbus ? "active" : "enabled")
+			? (udc->gadget.vbus_active ? "active" : "enabled")
 			: "disabled",
 		udc->selfpowered ? "self" : "VBUS",
 		udc->suspended ? ", suspended" : "",
@@ -209,7 +209,7 @@ static int proc_udc_show(struct seq_file *s, void *unused)
 	proc_irq_show(s, "imr   ", at91_udp_read(udc, AT91_UDP_IMR));
 	proc_irq_show(s, "isr   ", at91_udp_read(udc, AT91_UDP_ISR));
 
-	if (udc->enabled && udc->vbus) {
+	if (udc->enabled && udc->gadget.vbus_active) {
 		proc_ep_show(s, &udc->ep[0]);
 		list_for_each_entry (ep, &udc->gadget.ep_list, ep.ep_list) {
 			if (ep->ep.desc)
@@ -892,7 +892,7 @@ static void pullup(struct at91_udc *udc, int is_on)
 {
 	int	active = !udc->board.pullup_active_low;
 
-	if (!udc->enabled || !udc->vbus)
+	if (!udc->enabled || !udc->gadget.vbus_active)
 		is_on = 0;
 	DBG("%sactive\n", is_on ? "" : "in");
 
@@ -944,7 +944,7 @@ static int at91_vbus_session(struct usb_gadget *gadget, int is_active)
 
 	/* VDBG("vbus %s\n", is_active ? "on" : "off"); */
 	spin_lock_irqsave(&udc->lock, flags);
-	udc->vbus = (is_active != 0);
+	gadget->vbus_active = (is_active != 0);
 	if (udc->driver)
 		pullup(udc, is_active);
 	else
@@ -1586,7 +1586,7 @@ static struct at91_udc controller = {
 static void at91_vbus_update(struct at91_udc *udc, unsigned value)
 {
 	value ^= udc->board.vbus_active_low;
-	if (value != udc->vbus)
+	if (value != udc->gadget.vbus_active)
 		at91_vbus_session(&udc->gadget, value);
 }
 
@@ -1817,7 +1817,7 @@ static int at91udc_probe(struct platform_device *pdev)
 		 * Get the initial state of VBUS - we cannot expect
 		 * a pending interrupt.
 		 */
-		udc->vbus = gpio_get_value_cansleep(udc->board.vbus_pin) ^
+		udc->gadget.vbus_active = gpio_get_value_cansleep(udc->board.vbus_pin) ^
 			udc->board.vbus_active_low;
 
 		if (udc->board.vbus_polled) {
@@ -1837,7 +1837,7 @@ static int at91udc_probe(struct platform_device *pdev)
 		}
 	} else {
 		DBG("no VBUS detection, assuming always-on\n");
-		udc->vbus = 1;
+		udc->gadget.vbus_active = 1;
 	}
 	retval = usb_add_gadget_udc(dev, &udc->gadget);
 	if (retval)
diff --git a/drivers/usb/gadget/at91_udc.h b/drivers/usb/gadget/at91_udc.h
index e647d1c..6f8c7a4 100644
--- a/drivers/usb/gadget/at91_udc.h
+++ b/drivers/usb/gadget/at91_udc.h
@@ -115,7 +115,6 @@ struct at91_udc {
 	struct usb_gadget		gadget;
 	struct at91_ep			ep[NUM_ENDPOINTS];
 	struct usb_gadget_driver	*driver;
-	unsigned			vbus:1;
 	unsigned			enabled:1;
 	unsigned			clocked:1;
 	unsigned			suspended:1;
-- 
1.7.0.4
