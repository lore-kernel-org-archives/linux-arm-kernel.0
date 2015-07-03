From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 3 Jul 2015 22:32:23 +0800
Subject: [PATCH 1/2] irqchip: dw-apb-ictl: add private data structure
In-Reply-To: <1435933944-2131-1-git-send-email-jszhang@marvell.com>
References: <1435933944-2131-1-git-send-email-jszhang@marvell.com>
Message-ID: <1435933944-2131-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds struct dw_apb_ictl_priv definition, now it only has one
member: the irq domain. Then make the generic irq chip gc->private to point
to the struct. This is to prepare for the next patch which will implement
irq_set_affinity.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/irqchip/irq-dw-apb-ictl.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
index 53bb732..8bef7f7 100644
--- a/drivers/irqchip/irq-dw-apb-ictl.c
+++ b/drivers/irqchip/irq-dw-apb-ictl.c
@@ -16,6 +16,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/slab.h>
 
 #include "irqchip.h"
 
@@ -26,11 +27,16 @@
 #define APB_INT_FINALSTATUS_L	0x30
 #define APB_INT_FINALSTATUS_H	0x34
 
+struct dw_apb_ictl_priv {
+	struct irq_domain *domain;
+};
+
 static void dw_apb_ictl_handler(unsigned int irq, struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_get_chip(irq);
 	struct irq_chip_generic *gc = irq_get_handler_data(irq);
-	struct irq_domain *d = gc->private;
+	struct dw_apb_ictl_priv *priv = gc->private;
+	struct irq_domain *d = priv->domain;
 	u32 stat;
 	int n;
 
@@ -71,27 +77,34 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 	struct resource r;
 	struct irq_domain *domain;
+	struct dw_apb_ictl_priv *priv;
 	struct irq_chip_generic *gc;
 	void __iomem *iobase;
 	int ret, nrirqs, irq;
 	u32 reg;
 
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
 	/* Map the parent interrupt for the chained handler */
 	irq = irq_of_parse_and_map(np, 0);
 	if (irq <= 0) {
 		pr_err("%s: unable to parse irq\n", np->full_name);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_free;
 	}
 
 	ret = of_address_to_resource(np, 0, &r);
 	if (ret) {
 		pr_err("%s: unable to get resource\n", np->full_name);
-		return ret;
+		goto err_free;
 	}
 
 	if (!request_mem_region(r.start, resource_size(&r), np->full_name)) {
 		pr_err("%s: unable to request mem region\n", np->full_name);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_free;
 	}
 
 	iobase = ioremap(r.start, resource_size(&r));
@@ -138,7 +151,8 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 	}
 
 	gc = irq_get_domain_generic_chip(domain, 0);
-	gc->private = domain;
+	priv->domain = domain;
+	gc->private = priv;
 	gc->reg_base = iobase;
 
 	gc->chip_types[0].regs.mask = APB_INT_MASK_L;
@@ -164,6 +178,8 @@ err_unmap:
 	iounmap(iobase);
 err_release:
 	release_mem_region(r.start, resource_size(&r));
+err_free:
+	kfree(priv);
 	return ret;
 }
 IRQCHIP_DECLARE(dw_apb_ictl,
-- 
2.1.4
