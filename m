From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 23 Sep 2016 16:40:57 +0300
Subject: [PATCH v3 2/3] musb: sunxi: Remove custom babble handling
In-Reply-To: <20160923134058.26828-1-hdegoede@redhat.com>
References: <20160923134058.26828-1-hdegoede@redhat.com>
Message-ID: <20160923134058.26828-2-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The musb core already handles babble interrupts, so the sunxi glue
having its own custom handling is redundant.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-This is a new patch in v2 of this patch series
Changes in v3:
-Improve commit msg
---
 drivers/usb/musb/sunxi.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
index 1408245..82eba92 100644
--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -186,16 +186,6 @@ static irqreturn_t sunxi_musb_interrupt(int irq, void *__hci)
 	if (musb->int_usb)
 		writeb(musb->int_usb, musb->mregs + SUNXI_MUSB_INTRUSB);
 
-	/*
-	 * sunxi musb often signals babble on low / full speed device
-	 * disconnect, without ever raising MUSB_INTR_DISCONNECT, since
-	 * normally babble never happens treat it as disconnect.
-	 */
-	if ((musb->int_usb & MUSB_INTR_BABBLE) && is_host_active(musb)) {
-		musb->int_usb &= ~MUSB_INTR_BABBLE;
-		musb->int_usb |= MUSB_INTR_DISCONNECT;
-	}
-
 	if ((musb->int_usb & MUSB_INTR_RESET) && !is_host_active(musb)) {
 		/* ep0 FADDR must be 0 when (re)entering peripheral mode */
 		musb_ep_select(musb->mregs, 0);
-- 
2.9.3
