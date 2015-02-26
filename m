From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 26 Feb 2015 11:15:10 +0100
Subject: [PATCH RESEND] irqchip: armada: Fix chained per-cpu interrupts
Message-ID: <1424945710-21554-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the Cortex-A9-based Armada SoCs, the MPIC is not the primary interrupt
controller. Yet, it still has to handle some per-cpu interrupt.

To do so, it is chained with the GIC using a per-cpu interrupt. However, the
current code only call irq_set_chained_handler, which is called and enable that
interrupt only on the boot CPU, which means that the parent per-CPU interrupt
is never unmasked on the secondary CPUs, preventing the per-CPU interrupt to
actually work as expected.

This was not seen until now since the only MPIC PPI users were the Marvell
timers that were not working, but not used either since the system use the ARM
TWD by default, and the ethernet controllers, that are faking there interrupts
as SPI, and don't really expect to have interrupts on the secondary cores
anyway.

Add a CPU notifier that will enable the PPI on the secondary cores when they
are brought up.

Cc: <stable@vger.kernel.org> # 3.15+
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---

Resent to fix the stable email address, and add Ezequiel to the recipients

 drivers/irqchip/irq-armada-370-xp.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 463c235acbdc..137ee37a33ed 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -69,6 +69,7 @@ static void __iomem *per_cpu_int_base;
 static void __iomem *main_int_base;
 static struct irq_domain *armada_370_xp_mpic_domain;
 static u32 doorbell_mask_reg;
+static int parent_irq;
 #ifdef CONFIG_PCI_MSI
 static struct irq_domain *armada_370_xp_msi_domain;
 static DECLARE_BITMAP(msi_used, PCI_MSI_DOORBELL_NR);
@@ -356,6 +357,7 @@ static int armada_xp_mpic_secondary_init(struct notifier_block *nfb,
 {
 	if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
 		armada_xp_mpic_smp_cpu_init();
+
 	return NOTIFY_OK;
 }
 
@@ -364,6 +366,20 @@ static struct notifier_block armada_370_xp_mpic_cpu_notifier = {
 	.priority = 100,
 };
 
+static int armada_38x_mpic_secondary_init(struct notifier_block *nfb,
+					 unsigned long action, void *hcpu)
+{
+	if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
+		enable_percpu_irq(parent_irq, IRQ_TYPE_NONE);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block armada_38x_mpic_cpu_notifier = {
+	.notifier_call = armada_38x_mpic_secondary_init,
+	.priority = 100,
+};
+
 #endif /* CONFIG_SMP */
 
 static struct irq_domain_ops armada_370_xp_mpic_irq_ops = {
@@ -539,7 +555,7 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 					     struct device_node *parent)
 {
 	struct resource main_int_res, per_cpu_int_res;
-	int parent_irq, nr_irqs, i;
+	int nr_irqs, i;
 	u32 control;
 
 	BUG_ON(of_address_to_resource(node, 0, &main_int_res));
@@ -587,6 +603,9 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 		register_cpu_notifier(&armada_370_xp_mpic_cpu_notifier);
 #endif
 	} else {
+#ifdef CONFIG_SMP
+		register_cpu_notifier(&armada_38x_mpic_cpu_notifier);
+#endif
 		irq_set_chained_handler(parent_irq,
 					armada_370_xp_mpic_handle_cascade_irq);
 	}
-- 
2.3.0
