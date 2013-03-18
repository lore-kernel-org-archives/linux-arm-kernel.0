From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Mon, 18 Mar 2013 15:00:53 +0100
Subject: [PATCH v3 7/9] genirq: handle separate mask registers
In-Reply-To: <1363615255-18200-1-git-send-email-gerlando.falauto@keymile.com>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com><1363615255-18200-1-git-send-email-gerlando.falauto@keymile.com>
Message-ID: <1363615255-18200-8-git-send-email-gerlando.falauto@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are cases where all irq_chip_type instances have separate mask registers,
making a shared mask register cache unsuitable for the purpose.
So introduce a new flag IRQ_GC_SEPARATE_MASK_REGISTERS to explicitly enable
this separate treatment.
When this flag is not set, pointers for all irq_chip_type instances point
to the the shared mask register as it has been done so far.

Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>
---
 include/linux/irq.h       |    1 +
 kernel/irq/generic-chip.c |   15 +++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 5aca310..9feb06f 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -700,6 +700,7 @@ struct irq_chip_generic {
 enum irq_gc_flags {
 	IRQ_GC_INIT_MASK_CACHE		= 1 << 0,
 	IRQ_GC_INIT_NESTED_LOCK		= 1 << 1,
+	IRQ_GC_SEPARATE_MASK_REGISTERS  = 1 << 2,
 };
 
 /* Generic chip callback functions */
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index b5cb991..ae5ce41 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -241,19 +241,26 @@ void irq_setup_generic_chip(struct irq_chip_generic *gc, u32 msk,
 {
 	struct irq_chip_type *ct = gc->chip_types;
 	unsigned int i;
+	bool mskperct = flags & IRQ_GC_SEPARATE_MASK_REGISTERS;
+	bool mskinit = flags & IRQ_GC_INIT_MASK_CACHE;
 
 	raw_spin_lock(&gc_lock);
 	list_add_tail(&gc->list, &gc_list);
 	raw_spin_unlock(&gc_lock);
 
 	/* Init mask cache ? */
-	if (flags & IRQ_GC_INIT_MASK_CACHE)
+	if (mskinit && !mskperct)
 		gc->shared_mask_cache =
 			irq_reg_readl(gc->reg_base + ct->regs.mask);
 
-	/* Initialize mask cache pointer */
-	for (i = 0; i < gc->num_ct; i++)
-		ct[i].pmask_cache = &gc->shared_mask_cache;
+	/* Initialize mask cache pointers */
+	for (i = 0; i < gc->num_ct; i++) {
+		ct[i].pmask_cache = mskperct ?
+			&ct[i].mask_cache : &gc->shared_mask_cache;
+		if (mskinit && mskperct)
+			ct[i].mask_cache =
+				irq_reg_readl(gc->reg_base + ct[i].regs.mask);
+	}
 
 	for (i = gc->irq_base; msk; msk >>= 1, i++) {
 		if (!(msk & 0x01))
-- 
1.7.10.1
