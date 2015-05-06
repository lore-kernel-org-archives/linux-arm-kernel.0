From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  6 May 2015 14:48:04 +0200
Subject: [PATCH] pinctrl: nomadik: assign chips dynamically
Message-ID: <1430916484-7756-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Assign GPIO chip and irqchip to the GPIO container dynamically,
so we can set a unique name for each GPIO irqchip and see what
chip the hwirq offset actually relates to.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 61 +++++++++++++++----------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index a6a22054c0ba..c37093c8659c 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -246,6 +246,7 @@ enum nmk_gpio_slpm {
 
 struct nmk_gpio_chip {
 	struct gpio_chip chip;
+	struct irq_chip irqchip;
 	void __iomem *addr;
 	struct clk *clk;
 	unsigned int bank;
@@ -842,18 +843,6 @@ static void nmk_gpio_irq_shutdown(struct irq_data *d)
 	clk_disable(nmk_chip->clk);
 }
 
-static struct irq_chip nmk_gpio_irq_chip = {
-	.name		= "Nomadik-GPIO",
-	.irq_ack	= nmk_gpio_irq_ack,
-	.irq_mask	= nmk_gpio_irq_mask,
-	.irq_unmask	= nmk_gpio_irq_unmask,
-	.irq_set_type	= nmk_gpio_irq_set_type,
-	.irq_set_wake	= nmk_gpio_irq_set_wake,
-	.irq_startup	= nmk_gpio_irq_startup,
-	.irq_shutdown	= nmk_gpio_irq_shutdown,
-	.flags		= IRQCHIP_MASK_ON_SUSPEND,
-};
-
 static void __nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc,
 				   u32 status)
 {
@@ -1077,18 +1066,6 @@ static inline void nmk_gpio_dbg_show_one(struct seq_file *s,
 #define nmk_gpio_dbg_show	NULL
 #endif
 
-/* This structure is replicated for each GPIO block allocated at probe time */
-static struct gpio_chip nmk_gpio_template = {
-	.request		= nmk_gpio_request,
-	.free			= nmk_gpio_free,
-	.direction_input	= nmk_gpio_make_input,
-	.get			= nmk_gpio_get_input,
-	.direction_output	= nmk_gpio_make_output,
-	.set			= nmk_gpio_set_output,
-	.dbg_show		= nmk_gpio_dbg_show,
-	.can_sleep		= false,
-};
-
 void nmk_gpio_clocks_enable(void)
 {
 	int i;
@@ -1190,6 +1167,7 @@ static int nmk_gpio_probe(struct platform_device *dev)
 	struct device_node *np = dev->dev.of_node;
 	struct nmk_gpio_chip *nmk_chip;
 	struct gpio_chip *chip;
+	struct irq_chip *irqchip;
 	struct resource *res;
 	struct clk *clk;
 	int latent_irq;
@@ -1236,19 +1214,40 @@ static int nmk_gpio_probe(struct platform_device *dev)
 	nmk_chip->bank = dev->id;
 	nmk_chip->clk = clk;
 	nmk_chip->addr = base;
-	nmk_chip->chip = nmk_gpio_template;
 	nmk_chip->parent_irq = irq;
 	nmk_chip->latent_parent_irq = latent_irq;
 	nmk_chip->sleepmode = supports_sleepmode;
 	spin_lock_init(&nmk_chip->lock);
 
 	chip = &nmk_chip->chip;
+	chip->request = nmk_gpio_request;
+	chip->free = nmk_gpio_free;
+	chip->direction_input = nmk_gpio_make_input;
+	chip->get = nmk_gpio_get_input;
+	chip->direction_output = nmk_gpio_make_output;
+	chip->set = nmk_gpio_set_output;
+	chip->dbg_show = nmk_gpio_dbg_show;
+	chip->can_sleep = false;
 	chip->base = dev->id * NMK_GPIO_PER_CHIP;
 	chip->ngpio = NMK_GPIO_PER_CHIP;
 	chip->label = dev_name(&dev->dev);
 	chip->dev = &dev->dev;
 	chip->owner = THIS_MODULE;
 
+	irqchip = &nmk_chip->irqchip;
+	irqchip->irq_ack = nmk_gpio_irq_ack;
+	irqchip->irq_mask = nmk_gpio_irq_mask;
+	irqchip->irq_unmask = nmk_gpio_irq_unmask;
+	irqchip->irq_set_type = nmk_gpio_irq_set_type;
+	irqchip->irq_set_wake = nmk_gpio_irq_set_wake;
+	irqchip->irq_startup = nmk_gpio_irq_startup;
+	irqchip->irq_shutdown = nmk_gpio_irq_shutdown;
+	irqchip->flags = IRQCHIP_MASK_ON_SUSPEND;
+	irqchip->name = kasprintf(GFP_KERNEL, "nmk%u-%u-%u",
+				  dev->id,
+				  chip->base,
+				  chip->base + chip->ngpio - 1);
+
 	clk_enable(nmk_chip->clk);
 	nmk_chip->lowemi = readl_relaxed(nmk_chip->addr + NMK_GPIO_LOWEMI);
 	clk_disable(nmk_chip->clk);
@@ -1269,8 +1268,8 @@ static int nmk_gpio_probe(struct platform_device *dev)
 	 * handler will perform the actual work of handling the parent
 	 * interrupt.
 	 */
-	ret = gpiochip_irqchip_add(&nmk_chip->chip,
-				   &nmk_gpio_irq_chip,
+	ret = gpiochip_irqchip_add(chip,
+				   irqchip,
 				   0,
 				   handle_edge_irq,
 				   IRQ_TYPE_EDGE_FALLING);
@@ -1280,13 +1279,13 @@ static int nmk_gpio_probe(struct platform_device *dev)
 		return -ENODEV;
 	}
 	/* Then register the chain on the parent IRQ */
-	gpiochip_set_chained_irqchip(&nmk_chip->chip,
-				     &nmk_gpio_irq_chip,
+	gpiochip_set_chained_irqchip(chip,
+				     irqchip,
 				     nmk_chip->parent_irq,
 				     nmk_gpio_irq_handler);
 	if (nmk_chip->latent_parent_irq > 0)
-		gpiochip_set_chained_irqchip(&nmk_chip->chip,
-					     &nmk_gpio_irq_chip,
+		gpiochip_set_chained_irqchip(chip,
+					     irqchip,
 					     nmk_chip->latent_parent_irq,
 					     nmk_gpio_latent_irq_handler);
 
-- 
1.9.3
