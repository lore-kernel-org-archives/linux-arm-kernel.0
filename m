From: hdegoede@redhat.com (Hans de Goede)
Date: Mon,  9 Mar 2015 21:40:16 +0100
Subject: [PATCH 03/15] musb: Make musb_write_rxfun* and musb_write_rxhub* work
 like their tx versions
In-Reply-To: <1425933628-9672-1-git-send-email-hdegoede@redhat.com>
References: <1425933628-9672-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1425933628-9672-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For some reason the musb_write_rxfun* and musb_write_rxhub* functions had
a different function prototype and some extra magic needed on the caller side
compared to their tx counterparts, this commit makes them work the same as
their tx counterparts.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/usb/musb/musb_core.c | 11 +++--------
 drivers/usb/musb/musb_core.h |  2 --
 drivers/usb/musb/musb_host.c | 12 ++++++------
 drivers/usb/musb/musb_regs.h | 31 ++++++++++++-------------------
 4 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index e6f4cbf..2c43b59 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1546,7 +1546,6 @@ static int musb_core_init(u16 musb_type, struct musb *musb)
 #endif
 
 		hw_ep->regs = musb->io.ep_offset(i, 0) + mbase;
-		hw_ep->target_regs = musb_read_target_reg_base(i, mbase);
 		hw_ep->rx_reinit = 1;
 		hw_ep->tx_reinit = 1;
 
@@ -2332,7 +2331,6 @@ static void musb_restore_context(struct musb *musb)
 {
 	int i;
 	void __iomem *musb_base = musb->mregs;
-	void __iomem *ep_target_regs;
 	void __iomem *epio;
 	u8 power;
 
@@ -2400,14 +2398,11 @@ static void musb_restore_context(struct musb *musb)
 		musb_write_txhubport(musb_base, i,
 				musb->context.index_regs[i].txhubport);
 
-		ep_target_regs =
-			musb_read_target_reg_base(i, musb_base);
-
-		musb_write_rxfunaddr(ep_target_regs,
+		musb_write_rxfunaddr(musb_base, i,
 				musb->context.index_regs[i].rxfunaddr);
-		musb_write_rxhubaddr(ep_target_regs,
+		musb_write_rxhubaddr(musb_base, i,
 				musb->context.index_regs[i].rxhubaddr);
-		musb_write_rxhubport(ep_target_regs,
+		musb_write_rxhubport(musb_base, i,
 				musb->context.index_regs[i].rxhubport);
 	}
 	musb_writeb(musb_base, MUSB_INDEX, musb->context.index);
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 5e65958..a31d709 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -240,8 +240,6 @@ struct musb_hw_ep {
 	void __iomem		*fifo_sync_va;
 #endif
 
-	void __iomem		*target_regs;
-
 	/* currently scheduled peripheral endpoint */
 	struct musb_qh		*in_qh;
 	struct musb_qh		*out_qh;
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 883a9ad..77006ee 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -555,8 +555,9 @@ musb_host_packet_rx(struct musb *musb, struct urb *urb, u8 epnum, u8 iso_err)
  * the busy/not-empty tests are basically paranoia.
  */
 static void
-musb_rx_reinit(struct musb *musb, struct musb_qh *qh, struct musb_hw_ep *ep)
+musb_rx_reinit(struct musb *musb, struct musb_qh *qh, u8 epnum)
 {
+	struct musb_hw_ep *ep = musb->endpoints + epnum;
 	u16	csr;
 
 	/* NOTE:  we know the "rx" fifo reinit never triggers for ep0.
@@ -594,10 +595,9 @@ musb_rx_reinit(struct musb *musb, struct musb_qh *qh, struct musb_hw_ep *ep)
 
 	/* target addr and (for multipoint) hub addr/port */
 	if (musb->is_multipoint) {
-		musb_write_rxfunaddr(ep->target_regs, qh->addr_reg);
-		musb_write_rxhubaddr(ep->target_regs, qh->h_addr_reg);
-		musb_write_rxhubport(ep->target_regs, qh->h_port_reg);
-
+		musb_write_rxfunaddr(musb->mregs, epnum, qh->addr_reg);
+		musb_write_rxhubaddr(musb->mregs, epnum, qh->h_addr_reg);
+		musb_write_rxhubport(musb->mregs, epnum, qh->h_port_reg);
 	} else
 		musb_writeb(musb->mregs, MUSB_FADDR, qh->addr_reg);
 
@@ -875,7 +875,7 @@ finish:
 		u16	csr;
 
 		if (hw_ep->rx_reinit) {
-			musb_rx_reinit(musb, qh, hw_ep);
+			musb_rx_reinit(musb, qh, epnum);
 
 			/* init new state: toggle and NYET, maybe DMA later */
 			if (usb_gettoggle(urb->dev, qh->epnum, 0))
diff --git a/drivers/usb/musb/musb_regs.h b/drivers/usb/musb/musb_regs.h
index 11f0be0..edfc730 100644
--- a/drivers/usb/musb/musb_regs.h
+++ b/drivers/usb/musb/musb_regs.h
@@ -364,27 +364,25 @@ static inline u16 musb_read_hwvers(void __iomem *mbase)
 	return musb_readw(mbase, MUSB_HWVERS);
 }
 
-static inline void __iomem *musb_read_target_reg_base(u8 i, void __iomem *mbase)
-{
-	return (MUSB_BUSCTL_OFFSET(i, 0) + mbase);
-}
-
-static inline void musb_write_rxfunaddr(void __iomem *ep_target_regs,
+static inline void musb_write_rxfunaddr(void __iomem *mbase, u8 epnum,
 		u8 qh_addr_reg)
 {
-	musb_writeb(ep_target_regs, MUSB_RXFUNCADDR, qh_addr_reg);
+	musb_writeb(mbase, MUSB_BUSCTL_OFFSET(epnum, MUSB_RXFUNCADDR),
+			qh_addr_reg);
 }
 
-static inline void musb_write_rxhubaddr(void __iomem *ep_target_regs,
+static inline void musb_write_rxhubaddr(void __iomem *mbase, u8 epnum,
 		u8 qh_h_addr_reg)
 {
-	musb_writeb(ep_target_regs, MUSB_RXHUBADDR, qh_h_addr_reg);
+	musb_writeb(mbase, MUSB_BUSCTL_OFFSET(epnum, MUSB_RXHUBADDR),
+			qh_h_addr_reg);
 }
 
-static inline void musb_write_rxhubport(void __iomem *ep_target_regs,
+static inline void musb_write_rxhubport(void __iomem *mbase, u8 epnum,
 		u8 qh_h_port_reg)
 {
-	musb_writeb(ep_target_regs, MUSB_RXHUBPORT, qh_h_port_reg);
+	musb_writeb(mbase, MUSB_BUSCTL_OFFSET(epnum, MUSB_RXHUBPORT),
+			qh_h_port_reg);
 }
 
 static inline void  musb_write_txfunaddr(void __iomem *mbase, u8 epnum,
@@ -556,22 +554,17 @@ static inline u16 musb_read_hwvers(void __iomem *mbase)
 	return MUSB_HWVERS_1900;
 }
 
-static inline void __iomem *musb_read_target_reg_base(u8 i, void __iomem *mbase)
-{
-	return NULL;
-}
-
-static inline void musb_write_rxfunaddr(void __iomem *ep_target_regs,
+static inline void musb_write_rxfunaddr(void __iomem *mbase, u8 epnum,
 		u8 qh_addr_req)
 {
 }
 
-static inline void musb_write_rxhubaddr(void __iomem *ep_target_regs,
+static inline void musb_write_rxhubaddr(void __iomem *mbase, u8 epnum,
 		u8 qh_h_addr_reg)
 {
 }
 
-static inline void musb_write_rxhubport(void __iomem *ep_target_regs,
+static inline void musb_write_rxhubport(void __iomem *mbase, u8 epnum,
 		u8 qh_h_port_reg)
 {
 }
-- 
2.3.1
