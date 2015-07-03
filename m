From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 3 Jul 2015 22:32:24 +0800
Subject: [PATCH 2/2] irqchip: dw-apb-ictl: add irq_set_affinity support
In-Reply-To: <1435933944-2131-1-git-send-email-jszhang@marvell.com>
References: <1435933944-2131-1-git-send-email-jszhang@marvell.com>
Message-ID: <1435933944-2131-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Marvell Berlin SoCs, the cpu's local timer is shutdown when the cpu
goes to a deep idle state, then the timer framework will be notified to
use a broadcast timer instead. The broadcast timer uses dw-apb-ictl as
interrupt chip, this patch adds irq_set_affinity support so that the
going to deep idle state cpu can set the interrupt affinity of the
broadcast interrupt to avoid unnecessary wakeups and IPIs.

I believe this patch will also benefit other dw-apb-ictl users.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/irqchip/irq-dw-apb-ictl.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
index 8bef7f7..efc0aec 100644
--- a/drivers/irqchip/irq-dw-apb-ictl.c
+++ b/drivers/irqchip/irq-dw-apb-ictl.c
@@ -29,6 +29,7 @@
 
 struct dw_apb_ictl_priv {
 	struct irq_domain *domain;
+	unsigned int parent_irq;
 };
 
 static void dw_apb_ictl_handler(unsigned int irq, struct irq_desc *desc)
@@ -56,6 +57,21 @@ static void dw_apb_ictl_handler(unsigned int irq, struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static int dw_apb_ictl_set_affinity(struct irq_data *d,
+				    const struct cpumask *mask_val,
+				    bool force)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct dw_apb_ictl_priv *priv = gc->private;
+	struct irq_chip *chip = irq_get_chip(priv->parent_irq);
+	struct irq_data *data = irq_get_irq_data(priv->parent_irq);
+
+	if (chip && chip->irq_set_affinity)
+		return chip->irq_set_affinity(data, mask_val, force);
+	else
+		return -EINVAL;
+}
+
 #ifdef CONFIG_PM
 static void dw_apb_ictl_resume(struct irq_data *d)
 {
@@ -95,6 +111,8 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 		goto err_free;
 	}
 
+	priv->parent_irq = irq;
+
 	ret = of_address_to_resource(np, 0, &r);
 	if (ret) {
 		pr_err("%s: unable to get resource\n", np->full_name);
@@ -160,6 +178,7 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 	gc->chip_types[0].chip.irq_mask = irq_gc_mask_set_bit;
 	gc->chip_types[0].chip.irq_unmask = irq_gc_mask_clr_bit;
 	gc->chip_types[0].chip.irq_resume = dw_apb_ictl_resume;
+	gc->chip_types[0].chip.irq_set_affinity = dw_apb_ictl_set_affinity;
 
 	if (nrirqs > 32) {
 		gc->chip_types[1].regs.mask = APB_INT_MASK_H;
@@ -167,6 +186,8 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 		gc->chip_types[1].chip.irq_mask = irq_gc_mask_set_bit;
 		gc->chip_types[1].chip.irq_unmask = irq_gc_mask_clr_bit;
 		gc->chip_types[1].chip.irq_resume = dw_apb_ictl_resume;
+		gc->chip_types[1].chip.irq_set_affinity =
+						dw_apb_ictl_set_affinity;
 	}
 
 	irq_set_handler_data(irq, gc);
-- 
2.1.4
