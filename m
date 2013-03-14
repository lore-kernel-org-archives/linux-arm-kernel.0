From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 14 Mar 2013 13:50:36 +0800
Subject: [PATCH 08/14] usb: omap_udc: using common vbus_active
In-Reply-To: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
References: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1363240242-25775-9-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using common vbus_active to indicate vbus status

CC: Felipe Balbi <balbi@ti.com>
Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/gadget/omap_udc.c |    4 ++--
 drivers/usb/gadget/omap_udc.h |    1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index 06be85c..2d0cf7f 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -1186,7 +1186,7 @@ omap_set_selfpowered(struct usb_gadget *gadget, int is_selfpowered)
 
 static int can_pullup(struct omap_udc *udc)
 {
-	return udc->driver && udc->softconnect && udc->vbus_active;
+	return udc->driver && udc->softconnect && udc->gadget.vbus_active;
 }
 
 static void pullup_enable(struct omap_udc *udc)
@@ -1253,7 +1253,7 @@ static int omap_vbus_session(struct usb_gadget *gadget, int is_active)
 	udc = container_of(gadget, struct omap_udc, gadget);
 	spin_lock_irqsave(&udc->lock, flags);
 	VDBG("VBUS %s\n", is_active ? "on" : "off");
-	udc->vbus_active = (is_active != 0);
+	gadget->vbus_active = (is_active != 0);
 	if (cpu_is_omap15xx()) {
 		/* "software" detect, ignored if !VBUS_MODE_1510 */
 		l = omap_readl(FUNC_MUX_CTRL_0);
diff --git a/drivers/usb/gadget/omap_udc.h b/drivers/usb/gadget/omap_udc.h
index cfadeb5..62cdb9d 100644
--- a/drivers/usb/gadget/omap_udc.h
+++ b/drivers/usb/gadget/omap_udc.h
@@ -166,7 +166,6 @@ struct omap_udc {
 	struct usb_phy			*transceiver;
 	struct list_head		iso;
 	unsigned			softconnect:1;
-	unsigned			vbus_active:1;
 	unsigned			ep0_pending:1;
 	unsigned			ep0_in:1;
 	unsigned			ep0_set_config:1;
-- 
1.7.0.4
