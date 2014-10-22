From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 22 Oct 2014 10:43:44 -0300
Subject: [PATCH 4/7] irqchip: armada-370-xp: Enable Performance Counter
 interrupts
In-Reply-To: <1413985427-20918-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1413985427-20918-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1413985427-20918-5-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to get the Performance Counter overflow events (i.e. hardware perf
events), we need to unmask the interrupts in the "Coherency Fabric Local Cause"
register, which is part of the percpu configuration of the interrupt controller.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 3871c688..387a6a6 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -37,6 +37,8 @@
 /* Interrupt Controller Registers Map */
 #define ARMADA_370_XP_INT_SET_MASK_OFFS		(0x48)
 #define ARMADA_370_XP_INT_CLEAR_MASK_OFFS	(0x4C)
+#define ARMADA_370_XP_INT_FABRIC_MASK_OFFS	(0x54)
+#define ARMADA_370_XP_INT_CAUSE_PERF(cpu)	(1 << cpu)
 
 #define ARMADA_370_XP_INT_CONTROL		(0x00)
 #define ARMADA_370_XP_INT_SET_ENABLE_OFFS	(0x30)
@@ -54,6 +56,7 @@
 #define ARMADA_370_XP_MAX_PER_CPU_IRQS		(28)
 
 #define ARMADA_370_XP_TIMER0_PER_CPU_IRQ	(5)
+#define ARMADA_370_XP_FABRIC_IRQ		(3)
 
 #define IPI_DOORBELL_START                      (0)
 #define IPI_DOORBELL_END                        (8)
@@ -77,6 +80,7 @@ static inline bool is_percpu_irq(irq_hw_number_t irq)
 {
 	switch (irq) {
 	case ARMADA_370_XP_TIMER0_PER_CPU_IRQ:
+	case ARMADA_370_XP_FABRIC_IRQ:
 		return true;
 	default:
 		return false;
@@ -297,12 +301,17 @@ static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
 
 static void armada_xp_mpic_smp_cpu_init(void)
 {
+	unsigned long cpuid = cpu_logical_map(smp_processor_id());
 	u32 control;
 	int nr_irqs, i;
 
 	control = readl(main_int_base + ARMADA_370_XP_INT_CONTROL);
 	nr_irqs = (control >> 2) & 0x3ff;
 
+	/* Enable Performance Counter Overflow interrupts */
+	writel(ARMADA_370_XP_INT_CAUSE_PERF(cpuid),
+	       per_cpu_int_base + ARMADA_370_XP_INT_FABRIC_MASK_OFFS);
+
 	for (i = 0; i < nr_irqs; i++)
 		writel(i, per_cpu_int_base + ARMADA_370_XP_INT_SET_MASK_OFFS);
 
-- 
2.1.0
