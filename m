From: opendmb@gmail.com (Doug Berger)
Date: Fri, 29 Sep 2017 20:40:53 -0700
Subject: [PATCH 3/7] gpio: brcmstb: switch to handle_level_irq flow
In-Reply-To: <20170930034057.15166-1-opendmb@gmail.com>
References: <20170930034057.15166-1-opendmb@gmail.com>
Message-ID: <20170930034057.15166-4-opendmb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reading and writing the gpio bank status register each time a pending
interrupt bit is serviced could cause new pending bits to be cleared
without servicing the associated interrupts.

By using the handle_level_irq flow instead of the handle_simple_irq
flow we get proper handling of interrupt masking as well as acking
of interrupts.  The irq_ack method is added to support this.

Fixes: 19a7b6940b78 ("gpio: brcmstb: Add interrupt and wakeup source support")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/gpio/gpio-brcmstb.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index 8945861876f9..c186141927bb 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -114,6 +114,16 @@ static void brcmstb_gpio_irq_unmask(struct irq_data *d)
 	brcmstb_gpio_set_imask(bank, d->hwirq, true);
 }
 
+static void brcmstb_gpio_irq_ack(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct brcmstb_gpio_bank *bank = gpiochip_get_data(gc);
+	struct brcmstb_gpio_priv *priv = bank->parent_priv;
+	u32 mask = BIT(d->hwirq);
+
+	gc->write_reg(priv->reg_base + GIO_STAT(bank->id), mask);
+}
+
 static int brcmstb_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
@@ -217,21 +227,16 @@ static void brcmstb_gpio_irq_bank_handler(struct brcmstb_gpio_bank *bank)
 {
 	struct brcmstb_gpio_priv *priv = bank->parent_priv;
 	struct irq_domain *irq_domain = bank->gc.irqdomain;
-	void __iomem *reg_base = priv->reg_base;
 	unsigned long status;
 
 	while ((status = brcmstb_gpio_get_active_irqs(bank))) {
 		int bit;
 
 		for_each_set_bit(bit, &status, 32) {
-			u32 stat = bank->gc.read_reg(reg_base +
-						      GIO_STAT(bank->id));
 			if (bit >= bank->width)
 				dev_warn(&priv->pdev->dev,
 					 "IRQ for invalid GPIO (bank=%d, offset=%d)\n",
 					 bank->id, bit);
-			bank->gc.write_reg(reg_base + GIO_STAT(bank->id),
-					    stat | BIT(bit));
 			generic_handle_irq(irq_find_mapping(irq_domain, bit));
 		}
 	}
@@ -354,6 +359,7 @@ static int brcmstb_gpio_irq_setup(struct platform_device *pdev,
 	bank->irq_chip.name = dev_name(dev);
 	bank->irq_chip.irq_mask = brcmstb_gpio_irq_mask;
 	bank->irq_chip.irq_unmask = brcmstb_gpio_irq_unmask;
+	bank->irq_chip.irq_ack = brcmstb_gpio_irq_ack;
 	bank->irq_chip.irq_set_type = brcmstb_gpio_irq_set_type;
 
 	/* Ensures that all non-wakeup IRQs are disabled at suspend */
@@ -394,7 +400,7 @@ static int brcmstb_gpio_irq_setup(struct platform_device *pdev,
 		bank->irq_chip.irq_set_wake = brcmstb_gpio_irq_set_wake;
 
 	err = gpiochip_irqchip_add(&bank->gc, &bank->irq_chip, 0,
-				   handle_simple_irq, IRQ_TYPE_NONE);
+				   handle_level_irq, IRQ_TYPE_NONE);
 	if (err)
 		return err;
 	gpiochip_set_chained_irqchip(&bank->gc, &bank->irq_chip,
-- 
2.14.1
