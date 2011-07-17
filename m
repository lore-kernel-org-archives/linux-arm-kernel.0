From: toddpoynor@google.com (Todd Poynor)
Date: Sat, 16 Jul 2011 22:39:35 -0700
Subject: [PATCH v2] ARM: davinci: Check for NULL return from
	irq_alloc_generic_chip
Message-ID: <1310881175-26182-1-git-send-email-toddpoynor@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid NULL dereference of irq_alloc_generic_chip return in low
memory conditions.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
Found by inspection of the source; have not witnessed an actual crash.

 arch/arm/mach-davinci/irq.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index d8c1af0..952dc12 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -52,6 +52,12 @@ davinci_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
 	struct irq_chip_type *ct;
 
 	gc = irq_alloc_generic_chip("AINTC", 1, irq_start, base, handle_edge_irq);
+	if (!gc) {
+		pr_err("%s: irq_alloc_generic_chip for IRQ %u failed\n",
+		       __func__, irq_start);
+		return;
+	}
+
 	ct = gc->chip_types;
 	ct->chip.irq_ack = irq_gc_ack_set_bit;
 	ct->chip.irq_mask = irq_gc_mask_clr_bit;
-- 
1.7.3.1
