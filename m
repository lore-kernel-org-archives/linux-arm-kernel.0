From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 20 Mar 2013 16:09:35 +0100
Subject: [PATCH for 3.9-rc] arm: mvebu: Use local interrupt only for the timer
 0
Message-ID: <1363792175-3136-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 3a6f08a37 "arm: mvebu: Add support for local interrupt",
managed the 28th first interrupts as local interrupt to match the
hardware specification. Among these interrupts there are the Gigabits
Ethernet ones used by the mvneta driver. Unfortunately the state of
the percpu_irq API prevents the driver to use it.

Indeed the interrupts have to be freed when the .stop() function is
called. As the free_percpu_irq() function don't disable the interrupt
line, we have to do it on each CPU before calling this. The function
disable_percpu_irq() only disable the percpu on the current CPU and
there is no function which allows to disable a percpu irq on a given
CPU. Waiting for the extension of the percpu_irq API, this fix allows
to use again the mvneta driver.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/irq-armada-370-xp.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mvebu/irq-armada-370-xp.c b/arch/arm/mach-mvebu/irq-armada-370-xp.c
index 274ff58..6a9195e 100644
--- a/arch/arm/mach-mvebu/irq-armada-370-xp.c
+++ b/arch/arm/mach-mvebu/irq-armada-370-xp.c
@@ -44,6 +44,8 @@
 
 #define ARMADA_370_XP_MAX_PER_CPU_IRQS		(28)
 
+#define ARMADA_370_XP_TIMER0_PER_CPU_IRQ	(5)
+
 #define ACTIVE_DOORBELLS			(8)
 
 static DEFINE_RAW_SPINLOCK(irq_controller_lock);
@@ -62,7 +64,7 @@ static void armada_370_xp_irq_mask(struct irq_data *d)
 #ifdef CONFIG_SMP
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
-	if (hwirq > ARMADA_370_XP_MAX_PER_CPU_IRQS)
+	if (hwirq != ARMADA_370_XP_TIMER0_PER_CPU_IRQ)
 		writel(hwirq, main_int_base +
 				ARMADA_370_XP_INT_CLEAR_ENABLE_OFFS);
 	else
@@ -79,7 +81,7 @@ static void armada_370_xp_irq_unmask(struct irq_data *d)
 #ifdef CONFIG_SMP
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
-	if (hwirq > ARMADA_370_XP_MAX_PER_CPU_IRQS)
+	if (hwirq != ARMADA_370_XP_TIMER0_PER_CPU_IRQ)
 		writel(hwirq, main_int_base +
 				ARMADA_370_XP_INT_SET_ENABLE_OFFS);
 	else
@@ -147,7 +149,7 @@ static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
 	writel(hw, main_int_base + ARMADA_370_XP_INT_SET_ENABLE_OFFS);
 	irq_set_status_flags(virq, IRQ_LEVEL);
 
-	if (hw < ARMADA_370_XP_MAX_PER_CPU_IRQS) {
+	if (hw == ARMADA_370_XP_TIMER0_PER_CPU_IRQ) {
 		irq_set_percpu_devid(virq);
 		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
 					handle_percpu_devid_irq);
-- 
1.7.9.5
