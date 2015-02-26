From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 26 Feb 2015 11:13:09 +0100
Subject: [PATCH 4/8] irqchip: armada-370-xp: Enable the PMU interrupts
In-Reply-To: <1424945593-20320-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1424945593-20320-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1424945593-20320-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to let the Performance Monitoring Unit interrupts flowing in the MPIC,
we need to unmask these interrupts in the Coherency Fabric Local Interrupt Mask
Register.

Since this register is a CPU-local register, unmasking this interrupt needs to
be done on the boot CPU when the driver initializes, but also on the secondary
CPU when they are brought up.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 204c88386b1a..81d06d644926 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -38,6 +38,8 @@
 /* Interrupt Controller Registers Map */
 #define ARMADA_370_XP_INT_SET_MASK_OFFS		(0x48)
 #define ARMADA_370_XP_INT_CLEAR_MASK_OFFS	(0x4C)
+#define ARMADA_370_XP_INT_FABRIC_MASK_OFFS	(0x54)
+#define ARMADA_370_XP_INT_CAUSE_PERF(cpu)	(1 << cpu)
 
 #define ARMADA_370_XP_INT_CONTROL		(0x00)
 #define ARMADA_370_XP_INT_SET_ENABLE_OFFS	(0x30)
@@ -56,6 +58,7 @@
 #define ARMADA_370_XP_MAX_PER_CPU_IRQS		(28)
 
 #define ARMADA_370_XP_TIMER0_PER_CPU_IRQ	(5)
+#define ARMADA_370_XP_FABRIC_IRQ		(3)
 
 #define IPI_DOORBELL_START                      (0)
 #define IPI_DOORBELL_END                        (8)
@@ -81,6 +84,7 @@ static inline bool is_percpu_irq(irq_hw_number_t irq)
 {
 	switch (irq) {
 	case ARMADA_370_XP_TIMER0_PER_CPU_IRQ:
+	case ARMADA_370_XP_FABRIC_IRQ:
 		return true;
 	default:
 		return false;
@@ -321,6 +325,15 @@ static void armada_xp_mpic_smp_cpu_init(void)
 	writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
 }
 
+static void armada_xp_mpic_perf_init(void)
+{
+	unsigned long cpuid = cpu_logical_map(smp_processor_id());
+
+	/* Enable Performance Counter Overflow interrupts */
+	writel(ARMADA_370_XP_INT_CAUSE_PERF(cpuid),
+	       per_cpu_int_base + ARMADA_370_XP_INT_FABRIC_MASK_OFFS);
+}
+
 #ifdef CONFIG_SMP
 static void armada_mpic_send_doorbell(const struct cpumask *mask,
 				      unsigned int irq)
@@ -346,8 +359,10 @@ static void armada_mpic_send_doorbell(const struct cpumask *mask,
 static int armada_xp_mpic_secondary_init(struct notifier_block *nfb,
 					 unsigned long action, void *hcpu)
 {
-	if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
+	if (action == CPU_STARTING || action == CPU_STARTING_FROZEN) {
+		armada_xp_mpic_perf_init();
 		armada_xp_mpic_smp_cpu_init();
+	}
 
 	return NOTIFY_OK;
 }
@@ -360,8 +375,10 @@ static struct notifier_block armada_370_xp_mpic_cpu_notifier = {
 static int armada_38x_mpic_secondary_init(struct notifier_block *nfb,
 					 unsigned long action, void *hcpu)
 {
-	if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
+	if (action == CPU_STARTING || action == CPU_STARTING_FROZEN) {
+		armada_xp_mpic_perf_init();
 		enable_percpu_irq(parent_irq, IRQ_TYPE_NONE);
+	}
 
 	return NOTIFY_OK;
 }
@@ -370,7 +387,6 @@ static struct notifier_block armada_38x_mpic_cpu_notifier = {
 	.notifier_call = armada_38x_mpic_secondary_init,
 	.priority = 100,
 };
-
 #endif /* CONFIG_SMP */
 
 static struct irq_domain_ops armada_370_xp_mpic_irq_ops = {
@@ -580,6 +596,7 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 	BUG_ON(!armada_370_xp_mpic_domain);
 
 	/* Setup for the boot CPU */
+	armada_xp_mpic_perf_init();
 	armada_xp_mpic_smp_cpu_init();
 
 	armada_370_xp_msi_init(node, main_int_res.start);
-- 
2.3.0
