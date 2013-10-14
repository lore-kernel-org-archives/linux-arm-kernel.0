From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 14 Oct 2013 15:29:00 +0200
Subject: [PATCH 1/3] usb: musb: Handle nullpointer
In-Reply-To: <1381757342-13324-1-git-send-email-mpa@pengutronix.de>
References: <1381757342-13324-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1381757342-13324-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the device is connected to a host without a gadget driver,
otg->gadget is NULL.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/usb/musb/musb_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 18e877f..baa4f6a 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -654,7 +654,8 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 				break;
 		case OTG_STATE_B_PERIPHERAL:
 			musb_g_suspend(musb);
-			musb->is_active = otg->gadget->b_hnp_enable;
+			musb->is_active = otg->gadget &&
+					otg->gadget->b_hnp_enable;
 			if (musb->is_active) {
 				musb->xceiv->state = OTG_STATE_B_WAIT_ACON;
 				dev_dbg(musb->controller, "HNP: Setting timer for b_ase0_brst\n");
-- 
1.8.4.rc3
