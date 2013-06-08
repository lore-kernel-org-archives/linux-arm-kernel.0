From: s-anna@ti.com (Suman Anna)
Date: Fri, 7 Jun 2013 20:57:56 -0500
Subject: [PATCH 4/7] omap: mailbox: correct the argument type for irq ops
Message-ID: <1370656676-41320-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The argument type used in the actual individual omap_mbox_ops
for irqs should be omap_mbox_irq_t instead of omap_mbox_type_t.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap1/mailbox.c |  6 +++---
 arch/arm/mach-omap2/mailbox.c | 15 ++++-----------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index a343d5f..7246a52 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -86,21 +86,21 @@ static int omap1_mbox_fifo_full(struct omap_mbox *mbox)
 
 /* irq */
 static void
-omap1_mbox_enable_irq(struct omap_mbox *mbox, omap_mbox_type_t irq)
+omap1_mbox_enable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
 	if (irq == IRQ_RX)
 		enable_irq(mbox->irq);
 }
 
 static void
-omap1_mbox_disable_irq(struct omap_mbox *mbox, omap_mbox_type_t irq)
+omap1_mbox_disable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
 	if (irq == IRQ_RX)
 		disable_irq(mbox->irq);
 }
 
 static int
-omap1_mbox_is_irq(struct omap_mbox *mbox, omap_mbox_type_t irq)
+omap1_mbox_is_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
 	if (irq == IRQ_TX)
 		return 0;
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 9fe0bf2..b01aae6 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -61,9 +61,6 @@ struct omap_mbox2_priv {
 	unsigned long irqdisable;
 };
 
-static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
-				  omap_mbox_type_t irq);
-
 static inline unsigned int mbox_read_reg(size_t ofs)
 {
 	return __raw_readl(mbox_base + ofs);
@@ -124,8 +121,7 @@ static int omap2_mbox_fifo_full(struct omap_mbox *mbox)
 }
 
 /* Mailbox IRQ handle functions */
-static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
-		omap_mbox_type_t irq)
+static void omap2_mbox_enable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
 	struct omap_mbox2_priv *p = mbox->priv;
 	u32 l, bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
@@ -135,8 +131,7 @@ static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
 	mbox_write_reg(l, p->irqenable);
 }
 
-static void omap2_mbox_disable_irq(struct omap_mbox *mbox,
-		omap_mbox_type_t irq)
+static void omap2_mbox_disable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
 	struct omap_mbox2_priv *p = mbox->priv;
 	u32 bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
@@ -147,8 +142,7 @@ static void omap2_mbox_disable_irq(struct omap_mbox *mbox,
 	mbox_write_reg(bit, p->irqdisable);
 }
 
-static void omap2_mbox_ack_irq(struct omap_mbox *mbox,
-		omap_mbox_type_t irq)
+static void omap2_mbox_ack_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
 	struct omap_mbox2_priv *p = mbox->priv;
 	u32 bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
@@ -159,8 +153,7 @@ static void omap2_mbox_ack_irq(struct omap_mbox *mbox,
 	mbox_read_reg(p->irqstatus);
 }
 
-static int omap2_mbox_is_irq(struct omap_mbox *mbox,
-		omap_mbox_type_t irq)
+static int omap2_mbox_is_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
 	struct omap_mbox2_priv *p = mbox->priv;
 	u32 bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
-- 
1.8.2
