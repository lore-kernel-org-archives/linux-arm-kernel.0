From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 26 Feb 2015 11:13:06 +0100
Subject: [PATCH 1/8] irqchip: armada-370-xp: Simplify interrupt map,
 mask and unmask
In-Reply-To: <1424945593-20320-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1424945593-20320-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1424945593-20320-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

The map, mask and unmask is unnecessarily complicated, with a different
implementation for shared and per CPU interrupts. The current code does
the following:

At probe time, all interrupts are disabled and masked on all CPUs.

Shared interrupts:

 * When the interrupt is mapped(), it gets disabled and unmasked on the
   calling CPU.

 * When the interrupt is unmasked(), masked(), it gets enabled and
   disabled.

Per CPU interrupts:

 * When the interrupt is mapped, it gets masked on the calling CPU and
   enabled.

 * When the interrupt is unmasked(), masked(), it gets unmasked and masked,
   on the calling CPU.

This commit simplifies this code, with a much simpler implementation, common
to shared and per CPU interrupts.

 * When the interrupt is mapped, it's enabled.

 * When the interrupt is unmasked(), masked(), it gets unmasked and masked,
   on the calling CPU.

Tested on a Armada XP SoC with SMP and UP configurations, with chained and
regular interrupts.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 137ee37a33ed..1caa8b579fdd 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -77,33 +77,18 @@ static DEFINE_MUTEX(msi_used_lock);
 static phys_addr_t msi_doorbell_addr;
 #endif
 
-/*
- * In SMP mode:
- * For shared global interrupts, mask/unmask global enable bit
- * For CPU interrupts, mask/unmask the calling CPU's bit
- */
 static void armada_370_xp_irq_mask(struct irq_data *d)
 {
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
-	if (hwirq != ARMADA_370_XP_TIMER0_PER_CPU_IRQ)
-		writel(hwirq, main_int_base +
-				ARMADA_370_XP_INT_CLEAR_ENABLE_OFFS);
-	else
-		writel(hwirq, per_cpu_int_base +
-				ARMADA_370_XP_INT_SET_MASK_OFFS);
+	writel(hwirq, per_cpu_int_base + ARMADA_370_XP_INT_SET_MASK_OFFS);
 }
 
 static void armada_370_xp_irq_unmask(struct irq_data *d)
 {
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
-	if (hwirq != ARMADA_370_XP_TIMER0_PER_CPU_IRQ)
-		writel(hwirq, main_int_base +
-				ARMADA_370_XP_INT_SET_ENABLE_OFFS);
-	else
-		writel(hwirq, per_cpu_int_base +
-				ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+	writel(hwirq, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
 }
 
 #ifdef CONFIG_PCI_MSI
@@ -286,12 +271,8 @@ static struct irq_chip armada_370_xp_irq_chip = {
 static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
 				      unsigned int virq, irq_hw_number_t hw)
 {
-	armada_370_xp_irq_mask(irq_get_irq_data(virq));
-	if (hw != ARMADA_370_XP_TIMER0_PER_CPU_IRQ)
-		writel(hw, per_cpu_int_base +
-			ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
-	else
-		writel(hw, main_int_base + ARMADA_370_XP_INT_SET_ENABLE_OFFS);
+	writel(hw, main_int_base + ARMADA_370_XP_INT_SET_ENABLE_OFFS);
+
 	irq_set_status_flags(virq, IRQ_LEVEL);
 
 	if (hw == ARMADA_370_XP_TIMER0_PER_CPU_IRQ) {
-- 
2.3.0
