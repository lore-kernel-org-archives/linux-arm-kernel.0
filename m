From: hdegoede@redhat.com (Hans de Goede)
Date: Tue,  4 Aug 2015 23:25:53 +0200
Subject: [PATCH] musb: sunxi: Ignore VBus errors in host-only mode
Message-ID: <1438723553-4136-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For some unclear reason sometimes we get VBus errors in host-only mode,
even though we do not have any vbus-detection then. Ignore these.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/usb/musb/sunxi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
index f9f6304..34ce5df 100644
--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -194,6 +194,10 @@ static irqreturn_t sunxi_musb_interrupt(int irq, void *__hci)
 		musb_writeb(musb->mregs, MUSB_FADDR, 0);
 	}
 
+	/*  Ignore Vbus errors when in host only mode */
+	if (musb->port_mode == MUSB_PORT_MODE_HOST)
+		musb->int_usb &= ~MUSB_INTR_VBUSERROR;
+
 	musb->int_tx = readw(musb->mregs + SUNXI_MUSB_INTRTX);
 	if (musb->int_tx)
 		writew(musb->int_tx, musb->mregs + SUNXI_MUSB_INTRTX);
-- 
2.4.3
