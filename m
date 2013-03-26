From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 26 Mar 2013 16:33:21 -0600
Subject: [PATCH RFC] MSI style interrupt controller for the Host2CPU doorbell
 on kirkwood
Message-ID: <20130326223321.GC8650@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is not for merging, it only shows how the doorbell register on
kirkwood can be hooked up to the irqchip core.

I've used an awful hack to set the MSI address/data properly so this
driver can work, but with that hack it is tested in HW on kirkwood.

Perhaps this will be useful to you Thomas.

Regards,
Jason

diff --git a/arch/arm/mach-kirkwood/doorbell-irq.c b/arch/arm/mach-kirkwood/doorbell-irq.c
new file mode 100644
index 0000000..4956317
--- /dev/null
+++ b/arch/arm/mach-kirkwood/doorbell-irq.c
@@ -0,0 +1,158 @@
+/*
+ * Copyright 2012 (C), Jason Gunthorpe <jgg@obsidianresearch.com>
+ *
+ * arch/arm/mach-kirkwood/doorbell-irq.c
+ *
+ * Support for the Host2CPU doorbell register on kirkwood
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+
+struct db_priv
+{
+	struct irq_chip_generic *gc;
+	void __iomem *base;
+	struct irq_domain *domain;
+	int irq_base;
+	int main_irq;
+};
+
+static void db_irq_handler(unsigned irq, struct irq_desc *desc)
+{
+	struct db_priv *priv = irq_get_handler_data(irq);
+	u32 cause;
+	int irq_base = priv->irq_base;
+	int i;
+
+	cause = readl(priv->base) & readl(priv->base + 4);
+
+	for (i = 0; i < 32; i++)
+		if ((cause & (1 << i)))
+			generic_handle_irq(i + irq_base);
+}
+
+/* The doorbell cause register is write 0 to clear, write 1 for no change. */
+static void irq_gc_eoi_inv(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_regs *regs = &container_of(d->chip, struct irq_chip_type, chip)->regs;
+
+	u32 mask = 1 << (d->irq - gc->irq_base);
+
+	irq_gc_lock(gc);
+	irq_reg_writel(~mask, gc->reg_base + regs->eoi);
+	irq_gc_unlock(gc);
+}
+
+static int __devinit db_init_one(struct platform_device *pdev)
+{
+	struct db_priv *priv;
+	struct resource *r;
+	struct irq_chip_type *ct;
+	int irq_base;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (priv == 0)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, priv);
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r)
+		return -EIO;
+
+	priv->main_irq = platform_get_irq(pdev, 0);
+	if (priv->main_irq < 0)
+		return priv->main_irq;
+
+	priv->base = devm_request_and_ioremap(&pdev->dev, r);
+	if (!priv->base)
+		return -ENOMEM;
+
+	irq_base = irq_alloc_descs(-1, 0, 32, NUMA_NO_NODE);
+	if (irq_base < 0)
+		return irq_base;
+	priv->irq_base = irq_base;
+
+	/* Clear clear all pending interrupts, clear the mask */
+	writel(0, priv->base);
+	writel(0, priv->base + 4);
+
+	priv->gc = irq_alloc_generic_chip("kirkwood_doorbell_irq", 1,
+				    irq_base, priv->base,
+				    handle_fasteoi_irq);
+	if (!priv->gc)
+		goto err_desc;
+	ct = priv->gc->chip_types;
+	ct->regs.mask = 4;
+	ct->regs.eoi = 0;
+	ct->chip.irq_eoi = irq_gc_eoi_inv;
+	ct->chip.irq_mask = irq_gc_mask_clr_bit;
+	ct->chip.irq_unmask = irq_gc_mask_set_bit;
+	irq_setup_generic_chip(priv->gc, IRQ_MSK(32), IRQ_GC_INIT_MASK_CACHE,
+			       IRQ_NOREQUEST, IRQ_LEVEL | IRQ_NOPROBE);
+
+	if (pdev->dev.of_node) {
+		priv->domain = irq_domain_add_legacy(pdev->dev.of_node, 32, irq_base, 0,
+						     &irq_domain_simple_ops, NULL);
+		if (priv->domain == 0)
+			goto err_irq;
+	}
+
+	irq_set_handler_data(priv->main_irq, priv);
+	irq_set_chained_handler(priv->main_irq, db_irq_handler);
+
+	return 0;
+
+err_irq:
+	irq_remove_generic_chip(priv->gc, IRQ_MSK(32), IRQ_NOPROBE | IRQ_LEVEL, 0);
+	kfree(priv->gc);
+err_desc:
+	irq_free_descs(priv->gc->irq_base, 32);
+	return -ENOMEM;
+}
+
+static int __devexit db_remove_one(struct platform_device *pdev)
+{
+	struct db_priv *priv = platform_get_drvdata(pdev);
+	if (!priv)
+		return 0;
+
+	if (priv->domain)
+		irq_domain_remove(priv->domain);
+	if (priv->gc) {
+		irq_set_chained_handler(priv->main_irq, NULL);
+		irq_remove_generic_chip(priv->gc, IRQ_MSK(32), IRQ_NOPROBE | IRQ_LEVEL, 0);
+		irq_free_descs(priv->gc->irq_base, 32);
+		kfree(priv->gc);
+	}
+	return 0;
+}
+
+static const struct of_device_id platform_match[] __devinitdata = {
+        {.compatible = "marvell,kirkwood,doorbell"},
+        {},
+};
+MODULE_DEVICE_TABLE(of, platform_match);
+static struct platform_driver db_driver = {
+	.probe = db_init_one,
+	.remove = __devexit_p(db_remove_one),
+	.driver = {
+		.name = "doorbell-irq",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(platform_match),
+	},
+};
+
+module_platform_driver(db_driver);
+
+MODULE_AUTHOR ("Jason Gunthorpe <jgunthorpe@obsidianresearch.com>");
+MODULE_DESCRIPTION ("Marvell Kirkwood Doorbell IRQ controller");
+MODULE_LICENSE ("GPL");
-- 
1.7.5.4
