From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 29 Jun 2014 16:11:01 +0200
Subject: [PATCH v3 3/4] pinctrl: sunxi: Properly handle level triggered gpio
 interrupts
In-Reply-To: <1404051062-24079-1-git-send-email-hdegoede@redhat.com>
References: <1404051062-24079-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1404051062-24079-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For level triggered gpio interrupts we need to use handle_fasteoi_irq,
like we do with the irq-sunxi-nmi driver. This is necessary to give threaded
interrupt handlers a chance to actuall clear the source of the interrupt
(which may involve sleeping waiting for i2c / spi / mmc transfers), before
acknowledging the interrupt.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 39 ++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 8bdd65b..c1f0530 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -31,6 +31,9 @@
 #include "../core.h"
 #include "pinctrl-sunxi.h"
 
+static struct irq_chip sunxi_pinctrl_edge_irq_chip;
+static struct irq_chip sunxi_pinctrl_level_irq_chip;
+
 static struct sunxi_pinctrl_group *
 sunxi_pinctrl_find_group_by_name(struct sunxi_pinctrl *pctl, const char *group)
 {
@@ -547,10 +550,10 @@ static int sunxi_pinctrl_irq_request_resources(struct irq_data *d)
 	return 0;
 }
 
-static int sunxi_pinctrl_irq_set_type(struct irq_data *d,
-				      unsigned int type)
+static int sunxi_pinctrl_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct sunxi_pinctrl *pctl = irq_data_get_irq_chip_data(d);
+	struct irq_desc *desc = container_of(d, struct irq_desc, irq_data);
 	u32 reg = sunxi_irq_cfg_reg(d->hwirq);
 	u8 index = sunxi_irq_cfg_offset(d->hwirq);
 	unsigned long flags;
@@ -577,6 +580,14 @@ static int sunxi_pinctrl_irq_set_type(struct irq_data *d,
 		return -EINVAL;
 	}
 
+	if (type & IRQ_TYPE_LEVEL_MASK) {
+		d->chip = &sunxi_pinctrl_level_irq_chip;
+		desc->handle_irq = handle_fasteoi_irq;
+	} else {
+		d->chip = &sunxi_pinctrl_edge_irq_chip;
+		desc->handle_irq = handle_edge_irq;
+	}
+
 	spin_lock_irqsave(&pctl->lock, flags);
 
 	regval = readl(pctl->membase + reg);
@@ -632,7 +643,7 @@ static void sunxi_pinctrl_irq_unmask(struct irq_data *d)
 	spin_unlock_irqrestore(&pctl->lock, flags);
 }
 
-static struct irq_chip sunxi_pinctrl_irq_chip = {
+static struct irq_chip sunxi_pinctrl_edge_irq_chip = {
 	.irq_ack	= sunxi_pinctrl_irq_ack,
 	.irq_mask	= sunxi_pinctrl_irq_mask,
 	.irq_unmask	= sunxi_pinctrl_irq_unmask,
@@ -641,6 +652,16 @@ static struct irq_chip sunxi_pinctrl_irq_chip = {
 	.flags		= IRQCHIP_SKIP_SET_WAKE,
 };
 
+static struct irq_chip sunxi_pinctrl_level_irq_chip = {
+	.irq_eoi	= sunxi_pinctrl_irq_ack,
+	.irq_mask	= sunxi_pinctrl_irq_mask,
+	.irq_unmask	= sunxi_pinctrl_irq_unmask,
+	.irq_request_resources = sunxi_pinctrl_irq_request_resources,
+	.irq_set_type	= sunxi_pinctrl_irq_set_type,
+	.flags		= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_EOI_THREADED |
+			  IRQCHIP_EOI_IF_HANDLED,
+};
+
 static void sunxi_pinctrl_irq_handler(unsigned irq, struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_get_chip(irq);
@@ -657,9 +678,6 @@ static void sunxi_pinctrl_irq_handler(unsigned irq, struct irq_desc *desc)
 	reg = sunxi_irq_status_reg_from_bank(bank);
 	val = readl(pctl->membase + reg);
 
-	/* Clear all interrupts */
-	writel(val, pctl->membase + reg);
-
 	if (val) {
 		int irqoffset;
 
@@ -929,12 +947,17 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
 	for (i = 0; i < (pctl->desc->irq_banks * IRQ_PER_BANK); i++) {
 		int irqno = irq_create_mapping(pctl->domain, i);
 
-		irq_set_chip_and_handler(irqno, &sunxi_pinctrl_irq_chip,
-					 handle_simple_irq);
+		irq_set_chip_and_handler(irqno, &sunxi_pinctrl_edge_irq_chip,
+					 handle_edge_irq);
 		irq_set_chip_data(irqno, pctl);
 	};
 
 	for (i = 0; i < pctl->desc->irq_banks; i++) {
+		/* Mask and clear all IRQs before registering a handler */
+		writel(0, pctl->membase + sunxi_irq_ctrl_reg_from_bank(i));
+		writel(0xffffffff,
+			pctl->membase + sunxi_irq_status_reg_from_bank(i));
+
 		irq_set_chained_handler(pctl->irq[i],
 					sunxi_pinctrl_irq_handler);
 		irq_set_handler_data(pctl->irq[i], pctl);
-- 
2.0.0
