From: stefan@agner.ch (Stefan Agner)
Date: Sat, 16 May 2015 11:44:17 +0200
Subject: [PATCH v7 05/13] irqchip: vf610-mscm: support NVIC parent
In-Reply-To: <1431769465-26867-1-git-send-email-stefan@agner.ch>
References: <1431769465-26867-1-git-send-email-stefan@agner.ch>
Message-ID: <1431769465-26867-6-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support the NVIC interrupt controller as node parent of the MSCM
interrupt router. On the dual-core variants of Vybird (VF6xx), the
NVIC interrupt controller is used by the Cortex-M4. To support
running Linux on this core too, MSCM needs NVIC parent support too.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/irqchip/irq-vf610-mscm-ir.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-vf610-mscm-ir.c b/drivers/irqchip/irq-vf610-mscm-ir.c
index 9521057..b932ecb 100644
--- a/drivers/irqchip/irq-vf610-mscm-ir.c
+++ b/drivers/irqchip/irq-vf610-mscm-ir.c
@@ -47,6 +47,7 @@ struct vf610_mscm_ir_chip_data {
 	void __iomem *mscm_ir_base;
 	u16 cpu_mask;
 	u16 saved_irsprc[MSCM_IRSPRC_NUM];
+	bool is_nvic;
 };
 
 static struct vf610_mscm_ir_chip_data *mscm_ir_data;
@@ -101,7 +102,7 @@ static void vf610_mscm_ir_enable(struct irq_data *data)
 	writew_relaxed(chip_data->cpu_mask,
 		       chip_data->mscm_ir_base + MSCM_IRSPRC(hwirq));
 
-	irq_chip_unmask_parent(data);
+	irq_chip_enable_parent(data);
 }
 
 static void vf610_mscm_ir_disable(struct irq_data *data)
@@ -111,7 +112,7 @@ static void vf610_mscm_ir_disable(struct irq_data *data)
 
 	writew_relaxed(0x0, chip_data->mscm_ir_base + MSCM_IRSPRC(hwirq));
 
-	irq_chip_mask_parent(data);
+	irq_chip_disable_parent(data);
 }
 
 static struct irq_chip vf610_mscm_ir_irq_chip = {
@@ -143,10 +144,17 @@ static int vf610_mscm_ir_domain_alloc(struct irq_domain *domain, unsigned int vi
 					      domain->host_data);
 
 	gic_data.np = domain->parent->of_node;
-	gic_data.args_count = 3;
-	gic_data.args[0] = GIC_SPI;
-	gic_data.args[1] = irq_data->args[0];
-	gic_data.args[2] = irq_data->args[1];
+
+	if (mscm_ir_data->is_nvic) {
+		gic_data.args_count = 1;
+		gic_data.args[0] = irq_data->args[0];
+	} else {
+		gic_data.args_count = 3;
+		gic_data.args[0] = GIC_SPI;
+		gic_data.args[1] = irq_data->args[0];
+		gic_data.args[2] = irq_data->args[1];
+	}
+
 	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &gic_data);
 }
 
@@ -199,6 +207,9 @@ static int __init vf610_mscm_ir_of_init(struct device_node *node,
 		goto out_unmap;
 	}
 
+	if (of_device_is_compatible(domain->parent->of_node, "arm,armv7m-nvic"))
+		mscm_ir_data->is_nvic = true;
+
 	cpu_pm_register_notifier(&mscm_ir_notifier_block);
 
 	return 0;
-- 
2.4.1
