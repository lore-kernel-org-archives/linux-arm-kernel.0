From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 19 Apr 2012 21:36:31 +0100
Subject: [PATCH 02/15] drivers/gpio: gpio-nomadik: Add support for irqdomains
In-Reply-To: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1334867804-31942-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add irq domain support to the gpio-nomadik GPIO driver. This
enables its users to support dynamic IRQ assignment, which is
requried by Device Tree.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/cpu.c   |   12 +++++
 drivers/gpio/gpio-nomadik.c |  106 +++++++++++++++++++++++-------------------
 2 files changed, 70 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index d11f389..01345d0 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -30,6 +30,18 @@
 
 void __iomem *_PRCMU_BASE;
 
+/* 
+ * FIXME: Should we set up the GPIO domain here?
+ *
+ * The problem is that we cannot put the interrupt resources into the platform
+ * device until the irqdomain has been added. Right now, we set the GIC interrupt
+ * domain from init_irq(), then load the gpio driver from
+ * core_initcall(nmk_gpio_init) and add the platform devices from
+ * arch_initcall(customize_machine).
+ *
+ * This feels fragile because it depends on the gpio device getting probed
+ * _before_ any device uses the gpio interrupts.
+*/
 static const struct of_device_id ux500_dt_irq_match[] = {
 	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
 	{},
diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index 2c2b53c..935f8d9 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -22,6 +22,7 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/slab.h>
 
 #include <asm/mach/irq.h>
@@ -43,6 +44,7 @@
 
 struct nmk_gpio_chip {
 	struct gpio_chip chip;
+	struct irq_domain *domain;
 	void __iomem *addr;
 	struct clk *clk;
 	unsigned int bank;
@@ -334,7 +336,7 @@ static int __nmk_config_pins(pin_cfg_t *cfgs, int num, bool sleep)
 		struct nmk_gpio_chip *nmk_chip;
 		int pin = PIN_NUM(cfgs[i]);
 
-		nmk_chip = irq_get_chip_data(NOMADIK_GPIO_TO_IRQ(pin));
+		nmk_chip = nmk_gpio_chips[pin / NMK_GPIO_PER_CHIP];
 		if (!nmk_chip) {
 			ret = -EINVAL;
 			break;
@@ -342,7 +344,7 @@ static int __nmk_config_pins(pin_cfg_t *cfgs, int num, bool sleep)
 
 		clk_enable(nmk_chip->clk);
 		spin_lock(&nmk_chip->lock);
-		__nmk_config_pin(nmk_chip, pin - nmk_chip->chip.base,
+		__nmk_config_pin(nmk_chip, pin % NMK_GPIO_PER_CHIP,
 				 cfgs[i], sleep, glitch ? slpm : NULL);
 		spin_unlock(&nmk_chip->lock);
 		clk_disable(nmk_chip->clk);
@@ -426,7 +428,7 @@ int nmk_gpio_set_slpm(int gpio, enum nmk_gpio_slpm mode)
 	struct nmk_gpio_chip *nmk_chip;
 	unsigned long flags;
 
-	nmk_chip = irq_get_chip_data(NOMADIK_GPIO_TO_IRQ(gpio));
+	nmk_chip = nmk_gpio_chips[gpio / NMK_GPIO_PER_CHIP];
 	if (!nmk_chip)
 		return -EINVAL;
 
@@ -434,7 +436,7 @@ int nmk_gpio_set_slpm(int gpio, enum nmk_gpio_slpm mode)
 	spin_lock_irqsave(&nmk_gpio_slpm_lock, flags);
 	spin_lock(&nmk_chip->lock);
 
-	__nmk_gpio_set_slpm(nmk_chip, gpio - nmk_chip->chip.base, mode);
+	__nmk_gpio_set_slpm(nmk_chip, gpio % NMK_GPIO_PER_CHIP, mode);
 
 	spin_unlock(&nmk_chip->lock);
 	spin_unlock_irqrestore(&nmk_gpio_slpm_lock, flags);
@@ -461,13 +463,13 @@ int nmk_gpio_set_pull(int gpio, enum nmk_gpio_pull pull)
 	struct nmk_gpio_chip *nmk_chip;
 	unsigned long flags;
 
-	nmk_chip = irq_get_chip_data(NOMADIK_GPIO_TO_IRQ(gpio));
+	nmk_chip = nmk_gpio_chips[gpio / NMK_GPIO_PER_CHIP];
 	if (!nmk_chip)
 		return -EINVAL;
 
 	clk_enable(nmk_chip->clk);
 	spin_lock_irqsave(&nmk_chip->lock, flags);
-	__nmk_gpio_set_pull(nmk_chip, gpio - nmk_chip->chip.base, pull);
+	__nmk_gpio_set_pull(nmk_chip, gpio % NMK_GPIO_PER_CHIP, pull);
 	spin_unlock_irqrestore(&nmk_chip->lock, flags);
 	clk_disable(nmk_chip->clk);
 
@@ -489,13 +491,13 @@ int nmk_gpio_set_mode(int gpio, int gpio_mode)
 	struct nmk_gpio_chip *nmk_chip;
 	unsigned long flags;
 
-	nmk_chip = irq_get_chip_data(NOMADIK_GPIO_TO_IRQ(gpio));
+	nmk_chip = nmk_gpio_chips[gpio / NMK_GPIO_PER_CHIP];
 	if (!nmk_chip)
 		return -EINVAL;
 
 	clk_enable(nmk_chip->clk);
 	spin_lock_irqsave(&nmk_chip->lock, flags);
-	__nmk_gpio_set_mode(nmk_chip, gpio - nmk_chip->chip.base, gpio_mode);
+	__nmk_gpio_set_mode(nmk_chip, gpio % NMK_GPIO_PER_CHIP, gpio_mode);
 	spin_unlock_irqrestore(&nmk_chip->lock, flags);
 	clk_disable(nmk_chip->clk);
 
@@ -508,11 +510,11 @@ int nmk_gpio_get_mode(int gpio)
 	struct nmk_gpio_chip *nmk_chip;
 	u32 afunc, bfunc, bit;
 
-	nmk_chip = irq_get_chip_data(NOMADIK_GPIO_TO_IRQ(gpio));
+	nmk_chip = nmk_gpio_chips[gpio / NMK_GPIO_PER_CHIP];
 	if (!nmk_chip)
 		return -EINVAL;
 
-	bit = 1 << (gpio - nmk_chip->chip.base);
+	bit = 1 << (gpio % NMK_GPIO_PER_CHIP);
 
 	clk_enable(nmk_chip->clk);
 
@@ -529,21 +531,19 @@ EXPORT_SYMBOL(nmk_gpio_get_mode);
 /* IRQ functions */
 static inline int nmk_gpio_get_bitmask(int gpio)
 {
-	return 1 << (gpio % 32);
+	return 1 << (gpio % NMK_GPIO_PER_CHIP);
 }
 
 static void nmk_gpio_irq_ack(struct irq_data *d)
 {
-	int gpio;
 	struct nmk_gpio_chip *nmk_chip;
 
-	gpio = NOMADIK_IRQ_TO_GPIO(d->irq);
 	nmk_chip = irq_data_get_irq_chip_data(d);
 	if (!nmk_chip)
 		return;
 
 	clk_enable(nmk_chip->clk);
-	writel(nmk_gpio_get_bitmask(gpio), nmk_chip->addr + NMK_GPIO_IC);
+	writel(nmk_gpio_get_bitmask(d->hwirq), nmk_chip->addr + NMK_GPIO_IC);
 	clk_disable(nmk_chip->clk);
 }
 
@@ -584,7 +584,7 @@ static void __nmk_gpio_set_wake(struct nmk_gpio_chip *nmk_chip,
 				int gpio, bool on)
 {
 	if (nmk_chip->sleepmode) {
-		__nmk_gpio_set_slpm(nmk_chip, gpio - nmk_chip->chip.base,
+		__nmk_gpio_set_slpm(nmk_chip, gpio % NMK_GPIO_PER_CHIP,
 				    on ? NMK_GPIO_SLPM_WAKEUP_ENABLE
 				    : NMK_GPIO_SLPM_WAKEUP_DISABLE);
 	}
@@ -594,14 +594,12 @@ static void __nmk_gpio_set_wake(struct nmk_gpio_chip *nmk_chip,
 
 static int nmk_gpio_irq_maskunmask(struct irq_data *d, bool enable)
 {
-	int gpio;
 	struct nmk_gpio_chip *nmk_chip;
 	unsigned long flags;
 	u32 bitmask;
 
-	gpio = NOMADIK_IRQ_TO_GPIO(d->irq);
 	nmk_chip = irq_data_get_irq_chip_data(d);
-	bitmask = nmk_gpio_get_bitmask(gpio);
+	bitmask = nmk_gpio_get_bitmask(d->hwirq);
 	if (!nmk_chip)
 		return -EINVAL;
 
@@ -609,10 +607,10 @@ static int nmk_gpio_irq_maskunmask(struct irq_data *d, bool enable)
 	spin_lock_irqsave(&nmk_gpio_slpm_lock, flags);
 	spin_lock(&nmk_chip->lock);
 
-	__nmk_gpio_irq_modify(nmk_chip, gpio, NORMAL, enable);
+	__nmk_gpio_irq_modify(nmk_chip, d->hwirq, NORMAL, enable);
 
 	if (!(nmk_chip->real_wake & bitmask))
-		__nmk_gpio_set_wake(nmk_chip, gpio, enable);
+		__nmk_gpio_set_wake(nmk_chip, d->hwirq, enable);
 
 	spin_unlock(&nmk_chip->lock);
 	spin_unlock_irqrestore(&nmk_gpio_slpm_lock, flags);
@@ -636,20 +634,18 @@ static int nmk_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 	struct nmk_gpio_chip *nmk_chip;
 	unsigned long flags;
 	u32 bitmask;
-	int gpio;
 
-	gpio = NOMADIK_IRQ_TO_GPIO(d->irq);
 	nmk_chip = irq_data_get_irq_chip_data(d);
 	if (!nmk_chip)
 		return -EINVAL;
-	bitmask = nmk_gpio_get_bitmask(gpio);
+	bitmask = nmk_gpio_get_bitmask(d->hwirq);
 
 	clk_enable(nmk_chip->clk);
 	spin_lock_irqsave(&nmk_gpio_slpm_lock, flags);
 	spin_lock(&nmk_chip->lock);
 
 	if (irqd_irq_disabled(d))
-		__nmk_gpio_set_wake(nmk_chip, gpio, on);
+		__nmk_gpio_set_wake(nmk_chip, d->hwirq, on);
 
 	if (on)
 		nmk_chip->real_wake |= bitmask;
@@ -667,17 +663,14 @@ static int nmk_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	bool enabled = !irqd_irq_disabled(d);
 	bool wake = irqd_is_wakeup_set(d);
-	int gpio;
 	struct nmk_gpio_chip *nmk_chip;
 	unsigned long flags;
 	u32 bitmask;
 
-	gpio = NOMADIK_IRQ_TO_GPIO(d->irq);
 	nmk_chip = irq_data_get_irq_chip_data(d);
-	bitmask = nmk_gpio_get_bitmask(gpio);
+	bitmask = nmk_gpio_get_bitmask(d->hwirq);
 	if (!nmk_chip)
 		return -EINVAL;
-
 	if (type & IRQ_TYPE_LEVEL_HIGH)
 		return -EINVAL;
 	if (type & IRQ_TYPE_LEVEL_LOW)
@@ -687,10 +680,10 @@ static int nmk_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	spin_lock_irqsave(&nmk_chip->lock, flags);
 
 	if (enabled)
-		__nmk_gpio_irq_modify(nmk_chip, gpio, NORMAL, false);
+		__nmk_gpio_irq_modify(nmk_chip, d->hwirq, NORMAL, false);
 
 	if (enabled || wake)
-		__nmk_gpio_irq_modify(nmk_chip, gpio, WAKE, false);
+		__nmk_gpio_irq_modify(nmk_chip, d->hwirq, WAKE, false);
 
 	nmk_chip->edge_rising &= ~bitmask;
 	if (type & IRQ_TYPE_EDGE_RISING)
@@ -701,10 +694,10 @@ static int nmk_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 		nmk_chip->edge_falling |= bitmask;
 
 	if (enabled)
-		__nmk_gpio_irq_modify(nmk_chip, gpio, NORMAL, true);
+		__nmk_gpio_irq_modify(nmk_chip, d->hwirq, NORMAL, true);
 
 	if (enabled || wake)
-		__nmk_gpio_irq_modify(nmk_chip, gpio, WAKE, true);
+		__nmk_gpio_irq_modify(nmk_chip, d->hwirq, WAKE, true);
 
 	spin_unlock_irqrestore(&nmk_chip->lock, flags);
 	clk_disable(nmk_chip->clk);
@@ -750,7 +743,7 @@ static void __nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc,
 	chained_irq_enter(host_chip, desc);
 
 	nmk_chip = irq_get_handler_data(irq);
-	first_irq = NOMADIK_GPIO_TO_IRQ(nmk_chip->chip.base);
+	first_irq = nmk_chip->domain->revmap_data.legacy.first_irq;
 	while (status) {
 		int bit = __ffs(status);
 
@@ -784,18 +777,6 @@ static void nmk_gpio_secondary_irq_handler(unsigned int irq,
 
 static int nmk_gpio_init_irq(struct nmk_gpio_chip *nmk_chip)
 {
-	unsigned int first_irq;
-	int i;
-
-	first_irq = NOMADIK_GPIO_TO_IRQ(nmk_chip->chip.base);
-	for (i = first_irq; i < first_irq + nmk_chip->chip.ngpio; i++) {
-		irq_set_chip_and_handler(i, &nmk_gpio_irq_chip,
-					 handle_edge_irq);
-		set_irq_flags(i, IRQF_VALID);
-		irq_set_chip_data(i, nmk_chip);
-		irq_set_irq_type(i, IRQ_TYPE_EDGE_FALLING);
-	}
-
 	irq_set_chained_handler(nmk_chip->parent_irq, nmk_gpio_irq_handler);
 	irq_set_handler_data(nmk_chip->parent_irq, nmk_chip);
 
@@ -872,7 +853,7 @@ static int nmk_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 	struct nmk_gpio_chip *nmk_chip =
 		container_of(chip, struct nmk_gpio_chip, chip);
 
-	return NOMADIK_GPIO_TO_IRQ(nmk_chip->chip.base) + offset;
+	return irq_find_mapping(nmk_chip->domain, offset);
 }
 
 #ifdef CONFIG_DEBUG_FS
@@ -1068,6 +1049,27 @@ void nmk_gpio_read_pull(int gpio_bank, u32 *pull_up)
 	}
 }
 
+int nmk_gpio_irq_map(struct irq_domain *d, unsigned int irq,
+			  irq_hw_number_t hwirq)
+{
+	struct nmk_gpio_chip *nmk_chip = d->host_data;
+
+	if (!nmk_chip)
+		return -EINVAL;
+
+	irq_set_chip_and_handler(irq, &nmk_gpio_irq_chip, handle_edge_irq);
+	set_irq_flags(irq, IRQF_VALID);
+	irq_set_chip_data(irq, nmk_chip);
+	irq_set_irq_type(irq, IRQ_TYPE_EDGE_FALLING);
+
+	return 0;
+}
+
+const struct irq_domain_ops nmk_gpio_irq_simple_ops = {
+	.map = nmk_gpio_irq_map,
+	.xlate = irq_domain_xlate_twocell,
+};
+
 static int __devinit nmk_gpio_probe(struct platform_device *dev)
 {
 	struct nmk_gpio_platform_data *pdata = dev->dev.platform_data;
@@ -1096,7 +1098,7 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
 		if (of_property_read_u32(np, "gpio-bank", &dev->id)) {
 			dev_err(&dev->dev, "gpio-bank property not found\n");
 			ret = -EINVAL;
-			goto out_dt;
+			goto out;
 		}
 
 		pdata->first_gpio = dev->id * NMK_GPIO_PER_CHIP;
@@ -1173,6 +1175,15 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
 
 	platform_set_drvdata(dev, nmk_chip);
 
+	nmk_chip->domain = irq_domain_add_legacy(np, NMK_GPIO_PER_CHIP,
+						NOMADIK_GPIO_TO_IRQ(pdata->first_gpio),
+						0, &nmk_gpio_irq_simple_ops, nmk_chip);
+	if (!nmk_chip->domain) {
+		pr_err("%s: Failed to create irqdomain\n", np->full_name);
+		ret = -ENOSYS;
+		goto out_free;
+	}
+
 	nmk_gpio_init_irq(nmk_chip);
 
 	dev_info(&dev->dev, "at address %p\n", nmk_chip->addr);
@@ -1189,7 +1200,6 @@ out_release:
 out:
 	dev_err(&dev->dev, "Failure %i for GPIO %i-%i\n", ret,
 		  pdata->first_gpio, pdata->first_gpio+31);
-out_dt:
 	if (np)
 		kfree(pdata);
 
-- 
1.7.9.1
