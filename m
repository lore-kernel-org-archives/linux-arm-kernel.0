From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 7 Feb 2011 23:56:47 +0100 (CET)
Subject: [PATCH] arm: Use generic accessor in irq_set_flags()
Message-ID: <alpine.LFD.2.00.1102072349050.31804@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic irq code provides an accessor function to manipulate
status flags in the irq descriptor. Replace the open coded variant.

Neccecary to let the core code rearrange the internal representation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/kernel/irq.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

Index: linux-next/arch/arm/kernel/irq.c
===================================================================
--- linux-next.orig/arch/arm/kernel/irq.c
+++ linux-next/arch/arm/kernel/irq.c
@@ -144,24 +144,21 @@ asm_do_IRQ(unsigned int irq, struct pt_r
 
 void set_irq_flags(unsigned int irq, unsigned int iflags)
 {
-	struct irq_desc *desc;
-	unsigned long flags;
+	unsigned long clr = 0, set = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 
 	if (irq >= nr_irqs) {
 		printk(KERN_ERR "Trying to set irq flags for IRQ%d\n", irq);
 		return;
 	}
 
-	desc = irq_to_desc(irq);
-	raw_spin_lock_irqsave(&desc->lock, flags);
-	desc->status |= IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 	if (iflags & IRQF_VALID)
-		desc->status &= ~IRQ_NOREQUEST;
+		clr |= IRQ_NOREQUEST;
 	if (iflags & IRQF_PROBE)
-		desc->status &= ~IRQ_NOPROBE;
+		clr |= IRQ_NOPROBE;
 	if (!(iflags & IRQF_NOAUTOEN))
-		desc->status &= ~IRQ_NOAUTOEN;
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
+		clr |= IRQ_NOAUTOEN;
+	/* Order is clear bits in "clr" then set bits in "set" */
+	irq_modify_status(irq, clr, set & ~clr);
 }
 
 void __init init_IRQ(void)
