From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 23 Sep 2014 14:35:00 +0800
Subject: [PATCH 3/3] irqchip: dw-apb-ictl: add PM support
In-Reply-To: <1411454100-6814-1-git-send-email-jszhang@marvell.com>
References: <1411454100-6814-1-git-send-email-jszhang@marvell.com>
Message-ID: <1411454100-6814-4-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds in support for S2R for dw-apb-ictl irqchip driver.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/irqchip/irq-dw-apb-ictl.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
index c136b67..53bb732 100644
--- a/drivers/irqchip/irq-dw-apb-ictl.c
+++ b/drivers/irqchip/irq-dw-apb-ictl.c
@@ -50,6 +50,21 @@ static void dw_apb_ictl_handler(unsigned int irq, struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+#ifdef CONFIG_PM
+static void dw_apb_ictl_resume(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
+
+	irq_gc_lock(gc);
+	writel_relaxed(~0, gc->reg_base + ct->regs.enable);
+	writel_relaxed(*ct->mask_cache, gc->reg_base + ct->regs.mask);
+	irq_gc_unlock(gc);
+}
+#else
+#define dw_apb_ictl_resume	NULL
+#endif /* CONFIG_PM */
+
 static int __init dw_apb_ictl_init(struct device_node *np,
 				   struct device_node *parent)
 {
@@ -127,13 +142,17 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 	gc->reg_base = iobase;
 
 	gc->chip_types[0].regs.mask = APB_INT_MASK_L;
+	gc->chip_types[0].regs.enable = APB_INT_ENABLE_L;
 	gc->chip_types[0].chip.irq_mask = irq_gc_mask_set_bit;
 	gc->chip_types[0].chip.irq_unmask = irq_gc_mask_clr_bit;
+	gc->chip_types[0].chip.irq_resume = dw_apb_ictl_resume;
 
 	if (nrirqs > 32) {
 		gc->chip_types[1].regs.mask = APB_INT_MASK_H;
+		gc->chip_types[1].regs.enable = APB_INT_ENABLE_H;
 		gc->chip_types[1].chip.irq_mask = irq_gc_mask_set_bit;
 		gc->chip_types[1].chip.irq_unmask = irq_gc_mask_clr_bit;
+		gc->chip_types[1].chip.irq_resume = dw_apb_ictl_resume;
 	}
 
 	irq_set_handler_data(irq, gc);
-- 
2.1.0
