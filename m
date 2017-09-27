From: net147@gmail.com (Jonathan Liu)
Date: Wed, 27 Sep 2017 20:35:22 +1000
Subject: [PATCH] usb: musb: Check for host-mode using is_host_active() on
 reset interrupt
Message-ID: <20170927103522.30202-1-net147@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sunxi musb has a bug where sometimes it will generate a babble
error on device disconnect instead of a disconnect IRQ. When this
happens the musb controller switches from host mode to device mode
(it clears MUSB_DEVCTL_HM/MUSB_DEVCTL_SESSION and sets
MUSB_DEVCTL_BDEVICE) and gets stuck in this state.

The babble error is misdetected as a bus reset because MUSB_DEVCTL_HM
was cleared.

To fix this, use is_host_active() rather than (devctl & MUSB_DEVCTL_HM)
to detect babble error so that sunxi musb babble recovery can handle it
by restoring the mode. This information is provided by the driver logic
and does not rely on register contents.

Cc: stable at vger.kernel.org # v4.1+
Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 drivers/usb/musb/musb_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 029692053dd3..1bce7df3e110 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -906,7 +906,7 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 	 */
 	if (int_usb & MUSB_INTR_RESET) {
 		handled = IRQ_HANDLED;
-		if (devctl & MUSB_DEVCTL_HM) {
+		if (is_host_active(musb)) {
 			/*
 			 * When BABBLE happens what we can depends on which
 			 * platform MUSB is running, because some platforms
@@ -916,9 +916,7 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 			 * drop the session.
 			 */
 			dev_err(musb->controller, "Babble\n");
-
-			if (is_host_active(musb))
-				musb_recover_from_babble(musb);
+			musb_recover_from_babble(musb);
 		} else {
 			musb_dbg(musb, "BUS RESET as %s",
 				usb_otg_state_string(musb->xceiv->otg->state));
-- 
2.13.2
