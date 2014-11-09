From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Sun,  9 Nov 2014 23:10:25 +0800
Subject: [RFC Part4 v1 03/17] x86,
 PCI/MSI: Simplify the way to deal with remapped MSI interrupts
In-Reply-To: <1415545839-28263-1-git-send-email-jiang.liu@linux.intel.com>
References: <1415545839-28263-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <1415545839-28263-4-git-send-email-jiang.liu@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simplify the way to deal with remapped MSI interrupts, so we could
kill irq_chip.irq_print_chip later.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/kernel/apic/msi.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index adc76eba59bd..12919b3c6cf4 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -95,7 +95,6 @@ static struct irq_chip msi_chip = {
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_set_affinity	= msi_set_affinity,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.irq_print_chip		= irq_remapping_print_chip,
 	.irq_compose_msi_msg	= msi_compose_msg,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
@@ -153,9 +152,19 @@ void arch_init_msi_domain(struct irq_domain *parent)
 }
 
 #ifdef CONFIG_IRQ_REMAP
+static struct irq_chip msi_ir_chip = {
+	.name			= "IR-PCI-MSI",
+	.irq_unmask		= unmask_msi_irq,
+	.irq_mask		= mask_msi_irq,
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_set_affinity	= msi_set_affinity,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
+};
+
 struct irq_domain *arch_create_msi_irq_domain(struct irq_domain *parent)
 {
-	return msi_create_irq_domain(NULL, &msi_chip, parent);
+	return msi_create_irq_domain(NULL, &msi_ir_chip, parent);
 }
 #endif
 
@@ -316,7 +325,6 @@ static struct irq_chip hpet_msi_type = {
 	.irq_ack = irq_chip_ack_parent,
 	.irq_set_affinity = hpet_msi_set_affinity,
 	.irq_retrigger = irq_chip_retrigger_hierarchy,
-	.irq_print_chip = irq_remapping_print_chip,
 	.irq_compose_msi_msg = msi_compose_msg,
 	.flags = IRQCHIP_SKIP_SET_WAKE,
 };
@@ -397,6 +405,8 @@ struct irq_domain *hpet_create_irq_domain(int hpet_id)
 		domain->parent = irq_remapping_get_ir_irq_domain(&info);
 		if (!domain->parent)
 			domain->parent = x86_vector_domain;
+		else
+			hpet_msi_type.name = "IR-HPET-MSI";
 	}
 
 	return domain;
-- 
1.7.10.4
