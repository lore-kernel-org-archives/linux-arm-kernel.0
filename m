From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  5 Jun 2015 20:53:39 +0200
Subject: [PATCH 5/7] musb: sunxi: Remove special MUSB_SUN4I flag for clearing
 ep0 addr on disconnect
In-Reply-To: <1433530421-12197-1-git-send-email-hdegoede@redhat.com>
References: <1433530421-12197-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1433530421-12197-6-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can cleanly handle this inside the sunxi glue, instead of adding special
casing to the core, but setting ep0 addr to 0 on a reset interrupt.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/usb/musb/musb_core.h    | 1 -
 drivers/usb/musb/musb_gadget.c  | 6 ------
 drivers/usb/musb/musb_virthub.c | 6 ------
 drivers/usb/musb/sunxi.c        | 8 +++++++-
 4 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 30a3123..b1cb2c3 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -169,7 +169,6 @@ struct musb_io;
  */
 struct musb_platform_ops {
 
-#define MUSB_SUN4I		BIT(7)
 #define MUSB_DMA_UX500		BIT(6)
 #define MUSB_DMA_CPPI41		BIT(5)
 #define MUSB_DMA_CPPI		BIT(4)
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index ec2e908..4c481cd 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -2003,12 +2003,6 @@ void musb_g_disconnect(struct musb *musb)
 		spin_lock(&musb->lock);
 	}
 
-	/* On sunxi ep0 FADDR must be 0 when (re)entering peripheral mode */
-	if (musb->io.quirks & MUSB_SUN4I) {
-		musb_ep_select(musb->mregs, 0);
-		musb_writeb(musb->mregs, MUSB_FADDR, 0);
-	}
-
 	switch (musb->xceiv->otg->state) {
 	default:
 		dev_dbg(musb->controller, "Unhandled disconnect %s, setting a_idle\n",
diff --git a/drivers/usb/musb/musb_virthub.c b/drivers/usb/musb/musb_virthub.c
index fe98623..30842bc 100644
--- a/drivers/usb/musb/musb_virthub.c
+++ b/drivers/usb/musb/musb_virthub.c
@@ -226,12 +226,6 @@ void musb_root_disconnect(struct musb *musb)
 	usb_hcd_poll_rh_status(musb->hcd);
 	musb->is_active = 0;
 
-	/* On sunxi ep0 FADDR must be 0 when (re)entering peripheral mode */
-	if (musb->io.quirks & MUSB_SUN4I) {
-		musb_ep_select(musb->mregs, 0);
-		musb_writeb(musb->mregs, MUSB_FADDR, 0);
-	}
-
 	switch (musb->xceiv->otg->state) {
 	case OTG_STATE_A_SUSPEND:
 		if (otg->host->b_hnp_enable) {
diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
index 5db882f..8fc39af 100644
--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -183,6 +183,12 @@ static irqreturn_t sunxi_musb_interrupt(int irq, void *__hci)
 		musb->int_usb |= MUSB_INTR_DISCONNECT;
 	}
 
+	if ((musb->int_usb & MUSB_INTR_RESET) && !is_host_active(musb)) {
+		/* ep0 FADDR must be 0 when (re)entering peripheral mode */
+		musb_ep_select(musb->mregs, 0);
+		musb_writeb(musb->mregs, MUSB_FADDR, 0);
+	}
+
 	musb->int_tx = readw(musb->mregs + SUNXI_MUSB_INTRTX);
 	if (musb->int_tx)
 		writew(musb->int_tx, musb->mregs + SUNXI_MUSB_INTRTX);
@@ -519,7 +525,7 @@ static void sunxi_musb_writew(void __iomem *addr, unsigned offset, u16 data)
 }
 
 static const struct musb_platform_ops sunxi_musb_ops = {
-	.quirks		= MUSB_INDEXED_EP | MUSB_SUN4I,
+	.quirks		= MUSB_INDEXED_EP,
 	.init		= sunxi_musb_init,
 	.exit		= sunxi_musb_exit,
 	.enable		= sunxi_musb_enable,
-- 
2.4.2
