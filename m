From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 21 Jan 2013 18:53:57 +0100
Subject: [PATCH 1/6] arm: mvebu: Add support for local interrupt
In-Reply-To: <1358790842-2986-1-git-send-email-gregory.clement@free-electrons.com>
References: <1358790842-2986-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1358790842-2986-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MPIC allows the use of private interrupt for each CPUs. The 28th first
interrupts are per-cpu. This patch adds support to use them.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/irq-armada-370-xp.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mvebu/irq-armada-370-xp.c b/arch/arm/mach-mvebu/irq-armada-370-xp.c
index f99a4a2..c007fdc 100644
--- a/arch/arm/mach-mvebu/irq-armada-370-xp.c
+++ b/arch/arm/mach-mvebu/irq-armada-370-xp.c
@@ -145,11 +145,19 @@ static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
 {
 	armada_370_xp_irq_mask(irq_get_irq_data(virq));
 	writel(hw, main_int_base + ARMADA_370_XP_INT_SET_ENABLE_OFFS);
-
-	irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
-				 handle_level_irq);
 	irq_set_status_flags(virq, IRQ_LEVEL);
-	set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);
+
+	if (hw < ARMADA_370_XP_MAX_PER_CPU_IRQS) {
+
+		irq_set_percpu_devid(virq);
+		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
+					handle_percpu_devid_irq);
+
+	} else {
+		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
+					handle_level_irq);
+	}
+		set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);
 
 	return 0;
 }
@@ -245,7 +253,7 @@ asmlinkage void __exception_irq_entry armada_370_xp_handle_irq(struct pt_regs
 		if (irqnr > 1022)
 			break;
 
-		if (irqnr >= 8) {
+		if (irqnr > 0) {
 			irqnr =	irq_find_mapping(armada_370_xp_mpic_domain,
 					irqnr);
 			handle_IRQ(irqnr, regs);
-- 
1.7.9.5
