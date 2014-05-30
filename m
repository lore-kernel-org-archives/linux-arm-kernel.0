From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 30 May 2014 22:18:18 +0200
Subject: [PATCH 5/5] irqchip: irq-armada-370-xp: mask all interrupts during
 initialization
In-Reply-To: <1401481098-23326-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1401481098-23326-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1401481098-23326-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until now, the irq-armada-370-xp irqchip driver was not masking all
interrupts at initialization. While in most cases this is not a
problem because the bootloader has probably masked all interrupts, it
becomes a problem when you use kexec: you're in kernel A, with many
interrupts enabled, and then kexec into kernel B, without going
through the bootloader. So during the boot process, if an interrupt
occurs while the corresponding driver has not been loaded, you would
get spurious interrupts.

This commit fixes that by ensuring all interrupts are properly masked
when the irqchip driver is initialized. Note that interrupt masking
takes place at two level: at the global level (main_int_base) and at
the per-CPU level (per_cpu_int_base).

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 71f7784..6fdceeb 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -339,6 +339,15 @@ static void armada_mpic_send_doorbell(const struct cpumask *mask,
 
 static void armada_xp_mpic_smp_cpu_init(void)
 {
+	u32 control;
+	int nr_irqs, i;
+
+	control = readl(main_int_base + ARMADA_370_XP_INT_CONTROL);
+	nr_irqs = (control >> 2) & 0x3ff;
+
+	for (i = 0; i < nr_irqs; i++)
+		writel(i, per_cpu_int_base + ARMADA_370_XP_INT_SET_MASK_OFFS);
+
 	/* Clear pending IPIs */
 	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
 
@@ -479,7 +488,7 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 					     struct device_node *parent)
 {
 	struct resource main_int_res, per_cpu_int_res;
-	int parent_irq;
+	int parent_irq, nr_irqs, i;
 	u32 control;
 
 	BUG_ON(of_address_to_resource(node, 0, &main_int_res));
@@ -501,9 +510,13 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 	BUG_ON(!per_cpu_int_base);
 
 	control = readl(main_int_base + ARMADA_370_XP_INT_CONTROL);
+	nr_irqs = (control >> 2) & 0x3ff;
+
+	for (i = 0; i < nr_irqs; i++)
+		writel(i, main_int_base + ARMADA_370_XP_INT_CLEAR_ENABLE_OFFS);
 
 	armada_370_xp_mpic_domain =
-		irq_domain_add_linear(node, (control >> 2) & 0x3ff,
+		irq_domain_add_linear(node, nr_irqs,
 				&armada_370_xp_mpic_irq_ops, NULL);
 
 	BUG_ON(!armada_370_xp_mpic_domain);
-- 
1.9.3
