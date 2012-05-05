From: notasas@gmail.com (Grazvydas Ignotas)
Date: Sun,  6 May 2012 02:56:52 +0300
Subject: [PATCH] ARM: OMAP2+: remove incorrect irq_chip ack field
Message-ID: <1336262212-4455-1-git-send-email-notasas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each irq_chip for the main interrupt controller has offsets set for irq
masking registers, which added to respective base results in a pointer
to appropriate hardware register. However this is not correct for
INTC_CONTROL as there is only one INTC_CONTROL register. This does not
cause problems because generic ack code is never called, but remove
this assignment to avoid confusion.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/irq.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 65f0d25..c11e8a8 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -149,7 +149,6 @@ omap_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
 	ct->chip.irq_mask = irq_gc_mask_disable_reg;
 	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
 
-	ct->regs.ack = INTC_CONTROL;
 	ct->regs.enable = INTC_MIR_CLEAR0;
 	ct->regs.disable = INTC_MIR_SET0;
 	irq_setup_generic_chip(gc, IRQ_MSK(num), IRQ_GC_INIT_MASK_CACHE,
-- 
1.7.0.4
