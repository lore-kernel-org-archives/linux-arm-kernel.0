From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  5 Apr 2013 14:32:52 +0200
Subject: [PATCH] arm: mvebu: Fix the irq map function in SMP mode
In-Reply-To: <1365165172-11447-1-git-send-email-gregory.clement@free-electrons.com>
References: <1365165172-11447-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1365165172-11447-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix the regression introduced by the commit 3202bf0157ccb
"arm: mvebu: Improve the SMP support of the interrupt controller":
GPIO IRQ were no longer delivered to the CPUs.

To be delivered to a CPU an interrupt must be enabled at CPU level and
at interrupt source level. Before the offending patch, all the
interrupts were enabled at source level during map() function. Mask()
and unmask() was done by handling the per-CPU part. It was fine when
running in UP with only one CPU.

The offending patch added support for SMP, in this case mask() and
unmask() was done by handling the interrupt source level part. The
per-CPU level part was handled by the affinity API to select the CPU
which will receive the interrupt. (Due to some hardware limitation
only one CPU at a time can received a given interrupt).

For "normal" interrupt __setup_irq() was called when an irq was
registered. irq_set_affinity() is called from this function, which
enabled the interrupt on one of the CPUs. Whereas for GPIO IRQ which
were chained interrupts, the irq_set_affinity() was never called and
none of the CPUs was selected to receive the interrupt.

With this patch all the interrupt are enable on the current CPU during
map() function. Enabling the interrupts on a CPU doesn't depend
anymore on irq_set_affinity() and then the chained irq are not anymore
a special case. However the CPU which will receive the irq can still
be modify later using irq_set_affinity().

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Reported-by: Ryan Press <ryan@presslab.us>
Investigated-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Tested with Mirabox (A370) and Openblocks AX3 (AXP), rootfs mounted
over NFS, compiled with CONFIG_SMP=y/N.
---
 arch/arm/mach-mvebu/irq-armada-370-xp.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-mvebu/irq-armada-370-xp.c b/arch/arm/mach-mvebu/irq-armada-370-xp.c
index 6a9195e..d5970f5 100644
--- a/arch/arm/mach-mvebu/irq-armada-370-xp.c
+++ b/arch/arm/mach-mvebu/irq-armada-370-xp.c
@@ -61,7 +61,6 @@ static struct irq_domain *armada_370_xp_mpic_domain;
  */
 static void armada_370_xp_irq_mask(struct irq_data *d)
 {
-#ifdef CONFIG_SMP
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
 	if (hwirq != ARMADA_370_XP_TIMER0_PER_CPU_IRQ)
@@ -70,15 +69,10 @@ static void armada_370_xp_irq_mask(struct irq_data *d)
 	else
 		writel(hwirq, per_cpu_int_base +
 				ARMADA_370_XP_INT_SET_MASK_OFFS);
-#else
-	writel(irqd_to_hwirq(d),
-	       per_cpu_int_base + ARMADA_370_XP_INT_SET_MASK_OFFS);
-#endif
 }
 
 static void armada_370_xp_irq_unmask(struct irq_data *d)
 {
-#ifdef CONFIG_SMP
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
 	if (hwirq != ARMADA_370_XP_TIMER0_PER_CPU_IRQ)
@@ -87,10 +81,6 @@ static void armada_370_xp_irq_unmask(struct irq_data *d)
 	else
 		writel(hwirq, per_cpu_int_base +
 				ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
-#else
-	writel(irqd_to_hwirq(d),
-	       per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
-#endif
 }
 
 #ifdef CONFIG_SMP
@@ -146,7 +136,11 @@ static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
 				      unsigned int virq, irq_hw_number_t hw)
 {
 	armada_370_xp_irq_mask(irq_get_irq_data(virq));
-	writel(hw, main_int_base + ARMADA_370_XP_INT_SET_ENABLE_OFFS);
+	if (hw != ARMADA_370_XP_TIMER0_PER_CPU_IRQ)
+		writel(hw, per_cpu_int_base +
+			ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+	else
+		writel(hw, main_int_base + ARMADA_370_XP_INT_SET_ENABLE_OFFS);
 	irq_set_status_flags(virq, IRQ_LEVEL);
 
 	if (hw == ARMADA_370_XP_TIMER0_PER_CPU_IRQ) {
-- 
1.7.9.5
