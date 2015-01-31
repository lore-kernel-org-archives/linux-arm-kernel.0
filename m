From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 31 Jan 2015 23:33:01 +0100
Subject: [PATCH] ARM: pxa: fix pxa interrupts handling in DT
Message-ID: <1422743581-31548-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit "ARM: pxa: arbitrarily set first interrupt number" changed
the first pxa interrupt to 16.

As a consequence, device-tree builds got broken, because :
 - pxa_mask_irq() and pxa_unmask_irq() are using IRQ_BIT()
 - IRQ_BIT(x) calculates the interrupts as : x - PXA_IRQ(0)

Before the commit, the first interrupt shift, PXA_IRQ(0) was 0,
therefore IRQ_BIT(x) was x. After the change, it is necessary that the
same shift of 16 is applied between the virtual interrupt number and the
hardware irq number.

This situation comes from the common irq_chip shared between legacy
platform builds and device-tree builds.

Fix the broken interrupts in DT case by adding this shift in the DT case
too.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/irq.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index 0eecd83..59a9351 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -214,10 +214,10 @@ static int pxa_irq_map(struct irq_domain *h, unsigned int virq,
 	if (cpu_has_ipr)
 		__raw_writel(hw | IPR_VALID, pxa_irq_base + IPR(hw));
 
-	irq_set_chip_and_handler(hw, &pxa_internal_irq_chip,
+	irq_set_chip_and_handler(virq, &pxa_internal_irq_chip,
 				 handle_level_irq);
-	irq_set_chip_data(hw, base);
-	set_irq_flags(hw, IRQF_VALID);
+	irq_set_chip_data(virq, base);
+	set_irq_flags(virq, IRQF_VALID);
 
 	return 0;
 }
@@ -267,7 +267,8 @@ void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int))
 		return;
 	}
 
-	pxa_irq_domain = irq_domain_add_legacy(node, pxa_internal_irq_nr, 0, 0,
+	pxa_irq_domain = irq_domain_add_legacy(node, pxa_internal_irq_nr,
+					       PXA_IRQ(0), 0,
 					       &pxa_irq_ops, NULL);
 	if (!pxa_irq_domain)
 		panic("Unable to add PXA IRQ domain\n");
-- 
2.1.0
