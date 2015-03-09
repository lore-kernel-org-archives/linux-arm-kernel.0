From: hdegoede@redhat.com (Hans de Goede)
Date: Mon,  9 Mar 2015 21:40:17 +0100
Subject: [PATCH 04/15] musb: Make busctl_offset an io-op rather then a define
In-Reply-To: <1425933628-9672-1-git-send-email-hdegoede@redhat.com>
References: <1425933628-9672-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1425933628-9672-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner (sunxi) implementation of the musb has its busctl registers
indexed by the MUSB_INDEX register rather then in a flat address space.

This commit turns MUSB_BUSCTL_OFFSET from a macro into an io-op which can
be overridden from the platform ops.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/usb/musb/musb_core.c | 34 +++++++++++++++---------
 drivers/usb/musb/musb_core.h |  5 +++-
 drivers/usb/musb/musb_host.c | 12 ++++-----
 drivers/usb/musb/musb_io.h   |  2 ++
 drivers/usb/musb/musb_regs.h | 63 ++++++++++++++++++++++++--------------------
 5 files changed, 68 insertions(+), 48 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 2c43b59..b71d310 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -250,6 +250,11 @@ static u32 musb_indexed_ep_offset(u8 epnum, u16 offset)
 	return 0x10 + offset;
 }
 
+static u32 musb_default_busctl_offset(u8 epnum, u16 offset)
+{
+	return 0x80 + (0x08 * epnum) + offset;
+}
+
 static u8 musb_default_readb(const void __iomem *addr, unsigned offset)
 {
 	return __raw_readb(addr + offset);
@@ -2039,6 +2044,11 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	else
 		musb->io.fifo_offset = musb_default_fifo_offset;
 
+	if (musb->ops->busctl_offset)
+		musb->io.busctl_offset = musb->ops->busctl_offset;
+	else
+		musb->io.busctl_offset = musb_default_busctl_offset;
+
 	if (musb->ops->readb)
 		musb_readb = musb->ops->readb;
 	if (musb->ops->writeb)
@@ -2312,18 +2322,18 @@ static void musb_save_context(struct musb *musb)
 			musb_readb(epio, MUSB_RXINTERVAL);
 
 		musb->context.index_regs[i].txfunaddr =
-			musb_read_txfunaddr(musb_base, i);
+			musb_read_txfunaddr(musb, i);
 		musb->context.index_regs[i].txhubaddr =
-			musb_read_txhubaddr(musb_base, i);
+			musb_read_txhubaddr(musb, i);
 		musb->context.index_regs[i].txhubport =
-			musb_read_txhubport(musb_base, i);
+			musb_read_txhubport(musb, i);
 
 		musb->context.index_regs[i].rxfunaddr =
-			musb_read_rxfunaddr(musb_base, i);
+			musb_read_rxfunaddr(musb, i);
 		musb->context.index_regs[i].rxhubaddr =
-			musb_read_rxhubaddr(musb_base, i);
+			musb_read_rxhubaddr(musb, i);
 		musb->context.index_regs[i].rxhubport =
-			musb_read_rxhubport(musb_base, i);
+			musb_read_rxhubport(musb, i);
 	}
 }
 
@@ -2391,18 +2401,18 @@ static void musb_restore_context(struct musb *musb)
 		musb_writeb(epio, MUSB_RXINTERVAL,
 
 				musb->context.index_regs[i].rxinterval);
-		musb_write_txfunaddr(musb_base, i,
+		musb_write_txfunaddr(musb, i,
 				musb->context.index_regs[i].txfunaddr);
-		musb_write_txhubaddr(musb_base, i,
+		musb_write_txhubaddr(musb, i,
 				musb->context.index_regs[i].txhubaddr);
-		musb_write_txhubport(musb_base, i,
+		musb_write_txhubport(musb, i,
 				musb->context.index_regs[i].txhubport);
 
-		musb_write_rxfunaddr(musb_base, i,
+		musb_write_rxfunaddr(musb, i,
 				musb->context.index_regs[i].rxfunaddr);
-		musb_write_rxhubaddr(musb_base, i,
+		musb_write_rxhubaddr(musb, i,
 				musb->context.index_regs[i].rxhubaddr);
-		musb_write_rxhubport(musb_base, i,
+		musb_write_rxhubport(musb, i,
 				musb->context.index_regs[i].rxhubport);
 	}
 	musb_writeb(musb_base, MUSB_INDEX, musb->context.index);
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index a31d709..ba8dd78 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -67,7 +67,6 @@ struct musb_ep;
 #include "musb_dma.h"
 
 #include "musb_io.h"
-#include "musb_regs.h"
 
 #include "musb_gadget.h"
 #include <linux/usb/hcd.h>
@@ -186,6 +185,7 @@ struct musb_platform_ops {
 	void	(*ep_select)(void __iomem *mbase, u8 epnum);
 	u16	fifo_mode;
 	u32	(*fifo_offset)(u8 epnum);
+	u32	(*busctl_offset)(u8 epnum, u16 offset);
 	u8	(*readb)(const void __iomem *addr, unsigned offset);
 	void	(*writeb)(void __iomem *addr, unsigned offset, u8 data);
 	u16	(*readw)(const void __iomem *addr, unsigned offset);
@@ -435,6 +435,9 @@ struct musb {
 #endif
 };
 
+/* This must be included after struct musb is defined */
+#include "musb_regs.h"
+
 static inline struct musb *gadget_to_musb(struct usb_gadget *g)
 {
 	return container_of(g, struct musb, g);
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 77006ee..e2fabef 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -595,9 +595,9 @@ musb_rx_reinit(struct musb *musb, struct musb_qh *qh, u8 epnum)
 
 	/* target addr and (for multipoint) hub addr/port */
 	if (musb->is_multipoint) {
-		musb_write_rxfunaddr(musb->mregs, epnum, qh->addr_reg);
-		musb_write_rxhubaddr(musb->mregs, epnum, qh->h_addr_reg);
-		musb_write_rxhubport(musb->mregs, epnum, qh->h_port_reg);
+		musb_write_rxfunaddr(musb, epnum, qh->addr_reg);
+		musb_write_rxhubaddr(musb, epnum, qh->h_addr_reg);
+		musb_write_rxhubport(musb, epnum, qh->h_port_reg);
 	} else
 		musb_writeb(musb->mregs, MUSB_FADDR, qh->addr_reg);
 
@@ -801,9 +801,9 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 
 		/* target addr and (for multipoint) hub addr/port */
 		if (musb->is_multipoint) {
-			musb_write_txfunaddr(mbase, epnum, qh->addr_reg);
-			musb_write_txhubaddr(mbase, epnum, qh->h_addr_reg);
-			musb_write_txhubport(mbase, epnum, qh->h_port_reg);
+			musb_write_txfunaddr(musb, epnum, qh->addr_reg);
+			musb_write_txhubaddr(musb, epnum, qh->h_addr_reg);
+			musb_write_txhubport(musb, epnum, qh->h_port_reg);
 /* FIXME if !epnum, do the same for RX ... */
 		} else
 			musb_writeb(mbase, MUSB_FADDR, qh->addr_reg);
diff --git a/drivers/usb/musb/musb_io.h b/drivers/usb/musb/musb_io.h
index 8a57a6f..17a80ae 100644
--- a/drivers/usb/musb/musb_io.h
+++ b/drivers/usb/musb/musb_io.h
@@ -47,6 +47,7 @@
  * @fifo_offset: platform specific function to get fifo offset
  * @read_fifo:	platform specific function to read fifo
  * @write_fifo:	platform specific function to write fifo
+ * @busctl_offset: platform specific function to get busctl offset
  */
 struct musb_io {
 	u32	quirks;
@@ -55,6 +56,7 @@ struct musb_io {
 	u32	(*fifo_offset)(u8 epnum);
 	void	(*read_fifo)(struct musb_hw_ep *hw_ep, u16 len, u8 *buf);
 	void	(*write_fifo)(struct musb_hw_ep *hw_ep, u16 len, const u8 *buf);
+	u32	(*busctl_offset)(u8 epnum, u16 offset);
 };
 
 /* Do not add new entries here, add them the struct musb_io instead */
diff --git a/drivers/usb/musb/musb_regs.h b/drivers/usb/musb/musb_regs.h
index edfc730..cff5bcf 100644
--- a/drivers/usb/musb/musb_regs.h
+++ b/drivers/usb/musb/musb_regs.h
@@ -300,9 +300,6 @@
 #define MUSB_RXHUBADDR		0x06
 #define MUSB_RXHUBPORT		0x07
 
-#define MUSB_BUSCTL_OFFSET(_epnum, _offset) \
-	(0x80 + (8*(_epnum)) + (_offset))
-
 static inline void musb_write_txfifosz(void __iomem *mbase, u8 c_size)
 {
 	musb_writeb(mbase, MUSB_TXFIFOSZ, c_size);
@@ -364,76 +361,84 @@ static inline u16 musb_read_hwvers(void __iomem *mbase)
 	return musb_readw(mbase, MUSB_HWVERS);
 }
 
-static inline void musb_write_rxfunaddr(void __iomem *mbase, u8 epnum,
+static inline void musb_write_rxfunaddr(struct musb *musb, u8 epnum,
 		u8 qh_addr_reg)
 {
-	musb_writeb(mbase, MUSB_BUSCTL_OFFSET(epnum, MUSB_RXFUNCADDR),
-			qh_addr_reg);
+	musb_writeb(musb->mregs,
+		    musb->io.busctl_offset(epnum, MUSB_RXFUNCADDR),
+		    qh_addr_reg);
 }
 
-static inline void musb_write_rxhubaddr(void __iomem *mbase, u8 epnum,
+static inline void musb_write_rxhubaddr(struct musb *musb, u8 epnum,
 		u8 qh_h_addr_reg)
 {
-	musb_writeb(mbase, MUSB_BUSCTL_OFFSET(epnum, MUSB_RXHUBADDR),
+	musb_writeb(musb->mregs, musb->io.busctl_offset(epnum, MUSB_RXHUBADDR),
 			qh_h_addr_reg);
 }
 
-static inline void musb_write_rxhubport(void __iomem *mbase, u8 epnum,
+static inline void musb_write_rxhubport(struct musb *musb, u8 epnum,
 		u8 qh_h_port_reg)
 {
-	musb_writeb(mbase, MUSB_BUSCTL_OFFSET(epnum, MUSB_RXHUBPORT),
+	musb_writeb(musb->mregs, musb->io.busctl_offset(epnum, MUSB_RXHUBPORT),
 			qh_h_port_reg);
 }
 
-static inline void  musb_write_txfunaddr(void __iomem *mbase, u8 epnum,
+static inline void musb_write_txfunaddr(struct musb *musb, u8 epnum,
 		u8 qh_addr_reg)
 {
-	musb_writeb(mbase, MUSB_BUSCTL_OFFSET(epnum, MUSB_TXFUNCADDR),
-			qh_addr_reg);
+	musb_writeb(musb->mregs,
+		    musb->io.busctl_offset(epnum, MUSB_TXFUNCADDR),
+		    qh_addr_reg);
 }
 
-static inline void  musb_write_txhubaddr(void __iomem *mbase, u8 epnum,
+static inline void musb_write_txhubaddr(struct musb *musb, u8 epnum,
 		u8 qh_addr_reg)
 {
-	musb_writeb(mbase, MUSB_BUSCTL_OFFSET(epnum, MUSB_TXHUBADDR),
+	musb_writeb(musb->mregs, musb->io.busctl_offset(epnum, MUSB_TXHUBADDR),
 			qh_addr_reg);
 }
 
-static inline void  musb_write_txhubport(void __iomem *mbase, u8 epnum,
+static inline void musb_write_txhubport(struct musb *musb, u8 epnum,
 		u8 qh_h_port_reg)
 {
-	musb_writeb(mbase, MUSB_BUSCTL_OFFSET(epnum, MUSB_TXHUBPORT),
+	musb_writeb(musb->mregs, musb->io.busctl_offset(epnum, MUSB_TXHUBPORT),
 			qh_h_port_reg);
 }
 
-static inline u8 musb_read_rxfunaddr(void __iomem *mbase, u8 epnum)
+static inline u8 musb_read_rxfunaddr(struct musb *musb, u8 epnum)
 {
-	return musb_readb(mbase, MUSB_BUSCTL_OFFSET(epnum, MUSB_RXFUNCADDR));
+	return musb_readb(musb->mregs,
+			  musb->io.busctl_offset(epnum, MUSB_RXFUNCADDR));
 }
 
-static inline u8 musb_read_rxhubaddr(void __iomem *mbase, u8 epnum)
+static inline u8 musb_read_rxhubaddr(struct musb *musb, u8 epnum)
 {
-	return musb_readb(mbase, MUSB_BUSCTL_OFFSET(epnum, MUSB_RXHUBADDR));
+	return musb_readb(musb->mregs,
+			  musb->io.busctl_offset(epnum, MUSB_RXHUBADDR));
 }
 
-static inline u8 musb_read_rxhubport(void __iomem *mbase, u8 epnum)
+static inline u8 musb_read_rxhubport(struct musb *musb, u8 epnum)
 {
-	return musb_readb(mbase, MUSB_BUSCTL_OFFSET(epnum, MUSB_RXHUBPORT));
+	return musb_readb(musb->mregs,
+			  musb->io.busctl_offset(epnum, MUSB_RXHUBPORT));
 }
 
-static inline u8  musb_read_txfunaddr(void __iomem *mbase, u8 epnum)
+static inline u8 musb_read_txfunaddr(struct musb *musb, u8 epnum)
 {
-	return musb_readb(mbase, MUSB_BUSCTL_OFFSET(epnum, MUSB_TXFUNCADDR));
+	return musb_readb(musb->mregs,
+			  musb->io.busctl_offset(epnum, MUSB_TXFUNCADDR));
 }
 
-static inline u8  musb_read_txhubaddr(void __iomem *mbase, u8 epnum)
+static inline u8 musb_read_txhubaddr(struct musb *musb, u8 epnum)
 {
-	return musb_readb(mbase, MUSB_BUSCTL_OFFSET(epnum, MUSB_TXHUBADDR));
+	return musb_readb(musb->mregs,
+			  musb->io.busctl_offset(epnum, MUSB_TXHUBADDR));
 }
 
-static inline u8  musb_read_txhubport(void __iomem *mbase, u8 epnum)
+static inline u8 musb_read_txhubport(struct musb *musb, u8 epnum)
 {
-	return musb_readb(mbase, MUSB_BUSCTL_OFFSET(epnum, MUSB_TXHUBPORT));
+	return musb_readb(musb->mregs,
+			  musb->io.busctl_offset(epnum, MUSB_TXHUBPORT));
 }
 
 #else /* CONFIG_BLACKFIN */
-- 
2.3.1
