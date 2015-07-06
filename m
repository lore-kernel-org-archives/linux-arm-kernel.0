From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 06 Jul 2015 10:18:29 -0000
Subject: [patch] irqchip/sirfsoc: Fix generic chip allocation wreckage
Message-ID: <20150706101543.470696950@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

irq_alloc_domain_generic_chips() can only be called once for an
irqdomain. The sirfsoc init calls it twice and because the return
value is not checked it does not notice the wreckage.

The code works by chance because the first call already allocates two
chips and therefor the second call to sirfsoc_alloc_gc() operates on
the proper generic chip instance.

Use a single call and setup the two chips in the obvious correct way.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Barry Song <baohua@kernel.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Olof Johansson <olof@lixom.net>
---
 drivers/irqchip/irq-sirfsoc.c |   46 +++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

Index: tip/drivers/irqchip/irq-sirfsoc.c
===================================================================
--- tip.orig/drivers/irqchip/irq-sirfsoc.c
+++ tip/drivers/irqchip/irq-sirfsoc.c
@@ -17,34 +17,38 @@
 #include <asm/exception.h>
 #include "irqchip.h"
 
-#define SIRFSOC_INT_RISC_MASK0          0x0018
-#define SIRFSOC_INT_RISC_MASK1          0x001C
-#define SIRFSOC_INT_RISC_LEVEL0         0x0020
-#define SIRFSOC_INT_RISC_LEVEL1         0x0024
+#define SIRFSOC_INT_RISC_MASK0		0x0018
+#define SIRFSOC_INT_RISC_MASK1		0x001C
+#define SIRFSOC_INT_RISC_LEVEL0		0x0020
+#define SIRFSOC_INT_RISC_LEVEL1		0x0024
 #define SIRFSOC_INIT_IRQ_ID		0x0038
+#define SIRFSOC_INT_BASE_OFFSET		0x0004
 
 #define SIRFSOC_NUM_IRQS		64
+#define SIRFSOC_NUM_BANKS		(SIRFSOC_NUM_IRQS / 2)
 
 static struct irq_domain *sirfsoc_irqdomain;
 
-static __init void
-sirfsoc_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
+static __init void sirfsoc_alloc_gc(void __iomem *base)
 {
-	struct irq_chip_generic *gc;
-	struct irq_chip_type *ct;
-	int ret;
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 	unsigned int set = IRQ_LEVEL;
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+	int i;
 
-	ret = irq_alloc_domain_generic_chips(sirfsoc_irqdomain, num, 1, "irq_sirfsoc",
-		handle_level_irq, clr, set, IRQ_GC_INIT_MASK_CACHE);
-
-	gc = irq_get_domain_generic_chip(sirfsoc_irqdomain, irq_start);
-	gc->reg_base = base;
-	ct = gc->chip_types;
-	ct->chip.irq_mask = irq_gc_mask_clr_bit;
-	ct->chip.irq_unmask = irq_gc_mask_set_bit;
-	ct->regs.mask = SIRFSOC_INT_RISC_MASK0;
+	irq_alloc_domain_generic_chips(sirfsoc_irqdomain, 32, 1, "irq_sirfsoc",
+				       handle_level_irq, clr, set,
+				       IRQ_GC_INIT_MASK_CACHE);
+
+	for (i = 0; i < SIRFSOC_NUM_BANKS; i++) {
+		gc = irq_get_domain_generic_chip(sirfsoc_irqdomain, i * 32);
+		gc->reg_base = base + i * SIRFSOC_INT_BASE_OFFSET;
+		ct = gc->chip_types;
+		ct->chip.irq_mask = irq_gc_mask_clr_bit;
+		ct->chip.irq_unmask = irq_gc_mask_set_bit;
+		ct->regs.mask = SIRFSOC_INT_RISC_MASK0;
+	}
 }
 
 static void __exception_irq_entry sirfsoc_handle_irq(struct pt_regs *regs)
@@ -64,10 +68,8 @@ static int __init sirfsoc_irq_init(struc
 		panic("unable to map intc cpu registers\n");
 
 	sirfsoc_irqdomain = irq_domain_add_linear(np, SIRFSOC_NUM_IRQS,
-		&irq_generic_chip_ops, base);
-
-	sirfsoc_alloc_gc(base, 0, 32);
-	sirfsoc_alloc_gc(base + 4, 32, SIRFSOC_NUM_IRQS - 32);
+						  &irq_generic_chip_ops, base);
+	sirfsoc_alloc_gc(base);
 
 	writel_relaxed(0, base + SIRFSOC_INT_RISC_LEVEL0);
 	writel_relaxed(0, base + SIRFSOC_INT_RISC_LEVEL1);
