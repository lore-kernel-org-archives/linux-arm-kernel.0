From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 29 Nov 2011 17:45:10 +0900
Subject: [PATCH] ARM: samsung: Configure GPxxCON as irq in .irq_set_type
 callback
Message-ID: <20111129084510.GA20432@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Signed-off-by: Jiseong Oh <jiseong.oh@samsung.com>

Configure gpio direction (GPxxCON) as irq type as well as configuring
irq trigger type (EXT_INTxxCON) in s5p_gpioint_set_type(). This kind
of intended side effect is also implemented in s5p_irq_eint_set_type().
This will remove needs for explicit call of s3c_gpio_cfgpin() when using
a gpio as irq.
Without this patch, some mainline gpio based driver will not work. One of
the example is gpio_keys driver of which .probe callback looks like:

static int __devinit gpio_keys_setup_key(...)
{
...
	gpio_direction_input(button->gpio);
...
	irq = gpio_to_irq(button->gpio);
...
	request_any_context_irq(irq, gpio_keys_isr, irqflags, desc, bdata);
...
}

In above case, button gpio will remain as input type even after
irq_set_type is called from request_irq and button will not trigger
any irq.

Similar way is used at arch/arm/plat-orion/gpio.c

Signed-off-by: Jiseong Oh <jiseong.oh@samsung.com>
Signed-off-by: Sung-Taek Lim <stk.lim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/plat-s5p/irq-gpioint.c b/arch/arm/plat-s5p/irq-gpioint.c
index 1fdfaa4..1673efa 100644
--- a/arch/arm/plat-s5p/irq-gpioint.c
+++ b/arch/arm/plat-s5p/irq-gpioint.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 
 #include <mach/map.h>
+#include <mach/regs-gpio.h>
 #include <plat/gpio-core.h>
 #include <plat/gpio-cfg.h>
 
@@ -47,6 +48,7 @@ static int s5p_gpioint_set_type(struct irq_data *d, unsigned int type)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct irq_chip_type *ct = gc->chip_types;
+	struct samsung_gpio_chip *chip = gc->private;
 	unsigned int shift = (d->irq - gc->irq_base) << 2;
 
 	switch (type) {
@@ -74,6 +76,8 @@ static int s5p_gpioint_set_type(struct irq_data *d, unsigned int type)
 	gc->type_cache &= ~(0x7 << shift);
 	gc->type_cache |= type << shift;
 	writel(gc->type_cache, gc->reg_base + ct->regs.type);
+
+	s3c_gpio_cfgpin(chip->chip.base + (d->irq - chip->irq_base), EINT_MODE);
 	return 0;
 }
 
@@ -158,6 +162,8 @@ static __init int s5p_gpioint_add(struct samsung_gpio_chip *chip)
 				    handle_level_irq);
 	if (!gc)
 		return -ENOMEM;
+	gc->private = chip;
+
 	ct = gc->chip_types;
 	ct->chip.irq_ack = irq_gc_ack_set_bit;
 	ct->chip.irq_mask = irq_gc_mask_set_bit;
