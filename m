From: x0095078@ti.com (Armando Uribe)
Date: Wed,  2 Mar 2011 16:14:18 -0600
Subject: [PATCHv2] omap:mailbox: resolve hang issue
Message-ID: <1299104058-28565-1-git-send-email-x0095078@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hari Kanigeri <h-kanigeri2@ti.com>

omap4 interrupt disable bits is different. On rx kfifo full, the mbox rx
interrupts wasn't getting disabled, and this is causing the rcm stress tests
to hang.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Armando Uribe <x0095078@ti.com>
Signed-off-by: Fernando Guzman Lugo <fernando.lugo@ti.com>
---
 arch/arm/mach-omap2/mailbox.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 394413d..011ca50 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -193,10 +193,12 @@ static void omap2_mbox_disable_irq(struct omap_mbox *mbox,
 		omap_mbox_type_t irq)
 {
 	struct omap_mbox2_priv *p = mbox->priv;
-	u32 l, bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
-	l = mbox_read_reg(p->irqdisable);
-	l &= ~bit;
-	mbox_write_reg(l, p->irqdisable);
+	u32 bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
+
+	if (!cpu_is_omap44xx())
+		bit = mbox_read_reg(p->irqdisable) & ~bit;
+
+	mbox_write_reg(bit, p->irqdisable);
 }
 
 static void omap2_mbox_ack_irq(struct omap_mbox *mbox,
-- 
1.7.0.4
