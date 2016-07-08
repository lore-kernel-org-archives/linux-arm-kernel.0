From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri,  8 Jul 2016 22:09:07 +0200
Subject: [PATCH 3/3] usb: phy: generic: remove the vbus dependency
In-Reply-To: <1468008547-10925-1-git-send-email-robert.jarzmik@free.fr>
References: <1468008547-10925-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1468008547-10925-3-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the last known user, ie. pxa27x_udc relying on calls to
usb_gadget_xxx() was amended to use the phy notifier, remove a bit the
USB stack adherence.

Actually the driver still uses the gadget API for structures definition,
but the implementation of USB gadget specific function usb_gadget_*() is
not necessary anymore.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/usb/phy/phy-generic.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index 41b8aff9b925..c14e767a3fbf 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -118,8 +118,6 @@ static irqreturn_t nop_gpio_vbus_thread(int irq, void *data)
 		status = USB_EVENT_VBUS;
 		otg->state = OTG_STATE_B_PERIPHERAL;
 		nop->phy.last_event = status;
-		if (otg->gadget)
-			usb_gadget_vbus_connect(otg->gadget);
 
 		/* drawing a "unit load" is *always* OK, except for OTG */
 		nop_set_vbus_draw(nop, 100);
@@ -129,8 +127,6 @@ static irqreturn_t nop_gpio_vbus_thread(int irq, void *data)
 	} else {
 		nop_set_vbus_draw(nop, 0);
 
-		if (otg->gadget)
-			usb_gadget_vbus_disconnect(otg->gadget);
 		status = USB_EVENT_NONE;
 		otg->state = OTG_STATE_B_IDLE;
 		nop->phy.last_event = status;
@@ -187,7 +183,8 @@ static int nop_set_peripheral(struct usb_otg *otg, struct usb_gadget *gadget)
 
 	otg->gadget = gadget;
 	if (otg->state == OTG_STATE_B_PERIPHERAL)
-		usb_gadget_vbus_connect(gadget);
+		atomic_notifier_call_chain(&otg->usb_phy->notifier,
+					   USB_EVENT_VBUS, otg->gadget);
 	else
 		otg->state = OTG_STATE_B_IDLE;
 	return 0;
-- 
2.1.4
