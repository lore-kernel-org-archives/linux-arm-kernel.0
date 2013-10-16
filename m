From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 16 Oct 2013 14:51:09 +0200
Subject: [PATCH v3 1/4] usb: musb: gadget, stay IDLE without gadget driver
In-Reply-To: <1381927872-8181-1-git-send-email-mpa@pengutronix.de>
References: <1381927872-8181-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1381927872-8181-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If there is no gadget driver musb should stay in B_IDLE state.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/usb/musb/musb_core.c   |  3 ---
 drivers/usb/musb/musb_gadget.c | 14 ++++++++++++--
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 18e877f..7d40dec 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -831,12 +831,9 @@ b_host:
 			case OTG_STATE_B_WAIT_ACON:
 				dev_dbg(musb->controller, "HNP: RESET (%s), to b_peripheral\n",
 					usb_otg_state_string(musb->xceiv->state));
-				musb->xceiv->state = OTG_STATE_B_PERIPHERAL;
 				musb_g_reset(musb);
 				break;
 			case OTG_STATE_B_IDLE:
-				musb->xceiv->state = OTG_STATE_B_PERIPHERAL;
-				/* FALLTHROUGH */
 			case OTG_STATE_B_PERIPHERAL:
 				musb_g_reset(musb);
 				break;
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index b19ed21..fddda5d 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -2113,10 +2113,20 @@ __acquires(musb->lock)
 	 * or else after HNP, as A-Device
 	 */
 	if (devctl & MUSB_DEVCTL_BDEVICE) {
-		musb->xceiv->state = OTG_STATE_B_PERIPHERAL;
+		if (!musb->gadget_driver) {
+			musb->is_active = 0;
+			musb->xceiv->state = OTG_STATE_B_IDLE;
+		} else {
+			musb->xceiv->state = OTG_STATE_B_PERIPHERAL;
+		}
 		musb->g.is_a_peripheral = 0;
 	} else {
-		musb->xceiv->state = OTG_STATE_A_PERIPHERAL;
+		if (!musb->gadget_driver) {
+			musb->is_active = 0;
+			musb->xceiv->state = OTG_STATE_A_IDLE;
+		} else {
+			musb->xceiv->state = OTG_STATE_A_PERIPHERAL;
+		}
 		musb->g.is_a_peripheral = 1;
 	}
 
-- 
1.8.4.rc3
