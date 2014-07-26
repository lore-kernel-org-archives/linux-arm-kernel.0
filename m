From: dushistov@mail.ru (Evgeniy Dushistov)
Date: Sat, 26 Jul 2014 19:56:59 +0400
Subject: [PATCH] fix for certain sequnce of request_irq can cause irq storm
Message-ID: <20140726155659.GA22977@fifteen>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The problem is that hardware handled by arm/plat-orion/gpio.c,
require ack for edge irq, and no ack for level irq.

The code handle this issue, by two "struct irq_chip_type" per
one "struct irq_chip_generic". For one "struct irq_chip_generic"
irq_ack pointer is setted, for another it is NULL.

But we have only one mask_cache per two "struct irq_chip_type".
So if we 
1)unmask interrupt A for "edge type" trigger,
2)unmask interrupt B for "level type" trigger,
3)unmask interrupt C for "edge type",

we, because of usage of generic irq_gc_mask_clr_bit/irq_gc_mask_set_bit,
have hardware configured to trigger interrupt B on "edge type",
because of shared mask_cache. But kernel think that B is "level type",
so when interrupt B occur via "edge" reason, we don't ack it,
and B triggered again and again.

Signed-off-by: Evgeniy A. Dushistov <dushistov@mail.ru>
---
 arch/arm/plat-orion/gpio.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
index b61a3bc..e048f61 100644
--- a/arch/arm/plat-orion/gpio.c
+++ b/arch/arm/plat-orion/gpio.c
@@ -497,6 +497,34 @@ static void orion_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 #define orion_gpio_dbg_show NULL
 #endif
 
+static void orion_gpio_unmask_irq(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
+	u32 reg_val;
+	u32 mask = d->mask;
+
+	irq_gc_lock(gc);
+	reg_val = irq_reg_readl(gc->reg_base + ct->regs.mask);
+	reg_val |= mask;
+	irq_reg_writel(reg_val, gc->reg_base + ct->regs.mask);
+	irq_gc_unlock(gc);
+}
+
+static void orion_gpio_mask_irq(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
+	u32 mask = d->mask;
+	u32 reg_val;
+
+	irq_gc_lock(gc);
+	reg_val = irq_reg_readl(gc->reg_base + ct->regs.mask);
+	reg_val &= ~mask;
+	irq_reg_writel(reg_val, gc->reg_base + ct->regs.mask);
+	irq_gc_unlock(gc);
+}
+
 void __init orion_gpio_init(struct device_node *np,
 			    int gpio_base, int ngpio,
 			    void __iomem *base, int mask_offset,
@@ -565,8 +593,8 @@ void __init orion_gpio_init(struct device_node *np,
 	ct = gc->chip_types;
 	ct->regs.mask = ochip->mask_offset + GPIO_LEVEL_MASK_OFF;
 	ct->type = IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW;
-	ct->chip.irq_mask = irq_gc_mask_clr_bit;
-	ct->chip.irq_unmask = irq_gc_mask_set_bit;
+	ct->chip.irq_mask = orion_gpio_mask_irq;
+	ct->chip.irq_unmask = orion_gpio_unmask_irq;
 	ct->chip.irq_set_type = gpio_irq_set_type;
 	ct->chip.name = ochip->chip.label;
 
@@ -575,8 +603,8 @@ void __init orion_gpio_init(struct device_node *np,
 	ct->regs.ack = GPIO_EDGE_CAUSE_OFF;
 	ct->type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
 	ct->chip.irq_ack = irq_gc_ack_clr_bit;
-	ct->chip.irq_mask = irq_gc_mask_clr_bit;
-	ct->chip.irq_unmask = irq_gc_mask_set_bit;
+	ct->chip.irq_mask = orion_gpio_mask_irq;
+	ct->chip.irq_unmask = orion_gpio_unmask_irq;
 	ct->chip.irq_set_type = gpio_irq_set_type;
 	ct->handler = handle_edge_irq;
 	ct->chip.name = ochip->chip.label;
-- 
1.8.5.5

-- 
/Evgeniy
