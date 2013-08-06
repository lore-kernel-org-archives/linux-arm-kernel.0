From: 21cnbao@gmail.com (Barry Song)
Date: Tue,  6 Aug 2013 13:37:13 +0800
Subject: [PATCH 1/2] irqchip: sirf: move from legacy mode to linear irqdomain
Message-ID: <1375767434-19842-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the series of patches for irqdomain core in 3.11 has broken sirf
irq which uses legacy mapping. all users fail in the new kernel
while setupping irq.

this patch moves to linear irqdomain and drop old legacy irqdomain
codes since we don't need it any more, and at the same time, it
also fixes the broken interrupts of sirfsoc in 3.11.

on the other hand, we actually only have 64 interrupt sources for
prima2 and atlas6, but there are 128 interrupt souces for marco
which uses GIC. in the legacy codes, sirf gpio also uses legacy
irqdomain, so to make gpio interrupt mapping not depend on the
prima2/atlas6/marco an use unified marco,we enlarge prima2/atlas6
interrupt number to 128. here we don't need this workaround any
more as sirf gpio also moved to linear mode before. so we move
SIRFSOC_NUM_IRQS back to 64 too.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/irqchip/irq-sirfsoc.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-sirfsoc.c b/drivers/irqchip/irq-sirfsoc.c
index 69ea44e..4851afa 100644
--- a/drivers/irqchip/irq-sirfsoc.c
+++ b/drivers/irqchip/irq-sirfsoc.c
@@ -23,7 +23,7 @@
 #define SIRFSOC_INT_RISC_LEVEL1         0x0024
 #define SIRFSOC_INIT_IRQ_ID		0x0038
 
-#define SIRFSOC_NUM_IRQS		128
+#define SIRFSOC_NUM_IRQS		64
 
 static struct irq_domain *sirfsoc_irqdomain;
 
@@ -32,15 +32,18 @@ sirfsoc_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
 {
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
+	int ret;
+	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 
-	gc = irq_alloc_generic_chip("SIRFINTC", 1, irq_start, base, handle_level_irq);
-	ct = gc->chip_types;
+	ret = irq_alloc_domain_generic_chips(sirfsoc_irqdomain, num, 1, "irq_sirfsoc",
+		handle_level_irq, clr, 0, IRQ_GC_INIT_MASK_CACHE);
 
+	gc = irq_get_domain_generic_chip(sirfsoc_irqdomain, irq_start);
+	gc->reg_base = base;
+	ct = gc->chip_types;
 	ct->chip.irq_mask = irq_gc_mask_clr_bit;
 	ct->chip.irq_unmask = irq_gc_mask_set_bit;
 	ct->regs.mask = SIRFSOC_INT_RISC_MASK0;
-
-	irq_setup_generic_chip(gc, IRQ_MSK(num), IRQ_GC_INIT_MASK_CACHE, IRQ_NOREQUEST, 0);
 }
 
 static asmlinkage void __exception_irq_entry sirfsoc_handle_irq(struct pt_regs *regs)
@@ -60,9 +63,8 @@ static int __init sirfsoc_irq_init(struct device_node *np, struct device_node *p
 	if (!base)
 		panic("unable to map intc cpu registers\n");
 
-	/* using legacy because irqchip_generic does not work with linear */
-	sirfsoc_irqdomain = irq_domain_add_legacy(np, SIRFSOC_NUM_IRQS, 0, 0,
-				 &irq_domain_simple_ops, base);
+	sirfsoc_irqdomain = irq_domain_add_linear(np, SIRFSOC_NUM_IRQS,
+		&irq_generic_chip_ops, base);
 
 	sirfsoc_alloc_gc(base, 0, 32);
 	sirfsoc_alloc_gc(base + 4, 32, SIRFSOC_NUM_IRQS - 32);
-- 
1.8.2.3
