From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 8 Mar 2011 16:37:16 +0100
Subject: [PATCH] plat-nomadik: make GPIO interrupts work with cpuidle ApSleep
Message-ID: <1299598636-24839-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabin Vincent <rabin.vincent@stericsson.com>

Enable wakeups by default for any GPIO interrupts and in the suspend/resume
path narrow this down to only the the real wakeup interrupts. This approach is
based on the assumption that cpuidle ApSleep will be entered more often than
system suspend.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
Reviewed-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
[Fixup for genirq changes to struct irq_data on 2.6.38]
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/plat-nomadik/gpio.c              |  114 ++++++++++++++++++++++++----
 arch/arm/plat-nomadik/include/plat/gpio.h |    3 +
 2 files changed, 100 insertions(+), 17 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 45b1cf9..7062042 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -50,6 +50,10 @@ struct nmk_gpio_chip {
 	/* Keep track of configured edges */
 	u32 edge_rising;
 	u32 edge_falling;
+	u32 real_wake;
+	u32 rwimsc;
+	u32 fwimsc;
+	u32 slpm;
 };
 
 static struct nmk_gpio_chip *
@@ -534,8 +538,20 @@ static void __nmk_gpio_irq_modify(struct nmk_gpio_chip *nmk_chip,
 	}
 }
 
-static int nmk_gpio_irq_modify(struct irq_data *d, enum nmk_gpio_irq_type which,
-			       bool enable)
+static void __nmk_gpio_set_wake(struct nmk_gpio_chip *nmk_chip,
+				int gpio, bool on)
+{
+#ifdef CONFIG_ARCH_U8500
+	if (cpu_is_u8500v2()) {
+		__nmk_gpio_set_slpm(nmk_chip, gpio - nmk_chip->chip.base,
+				    on ? NMK_GPIO_SLPM_WAKEUP_ENABLE
+				       : NMK_GPIO_SLPM_WAKEUP_DISABLE);
+	}
+#endif
+	__nmk_gpio_irq_modify(nmk_chip, gpio, WAKE, on);
+}
+
+static int nmk_gpio_irq_maskunmask(struct irq_data *d, bool enable)
 {
 	int gpio;
 	struct nmk_gpio_chip *nmk_chip;
@@ -548,45 +564,55 @@ static int nmk_gpio_irq_modify(struct irq_data *d, enum nmk_gpio_irq_type which,
 	if (!nmk_chip)
 		return -EINVAL;
 
-	spin_lock_irqsave(&nmk_chip->lock, flags);
-	__nmk_gpio_irq_modify(nmk_chip, gpio, which, enable);
-	spin_unlock_irqrestore(&nmk_chip->lock, flags);
+	spin_lock_irqsave(&nmk_gpio_slpm_lock, flags);
+	spin_lock(&nmk_chip->lock);
+
+	__nmk_gpio_irq_modify(nmk_chip, gpio, NORMAL, enable);
+
+	if (!(nmk_chip->real_wake & bitmask))
+		__nmk_gpio_set_wake(nmk_chip, gpio, enable);
+
+	spin_unlock(&nmk_chip->lock);
+	spin_unlock_irqrestore(&nmk_gpio_slpm_lock, flags);
 
 	return 0;
 }
 
 static void nmk_gpio_irq_mask(struct irq_data *d)
 {
-	nmk_gpio_irq_modify(d, NORMAL, false);
+	nmk_gpio_irq_maskunmask(d, false);
 }
 
 static void nmk_gpio_irq_unmask(struct irq_data *d)
 {
-	nmk_gpio_irq_modify(d, NORMAL, true);
+	nmk_gpio_irq_maskunmask(d, true);
 }
 
 static int nmk_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 {
+	struct irq_desc *desc = irq_to_desc(d->irq);
+	bool enabled = !(desc->status & IRQ_DISABLED);
 	struct nmk_gpio_chip *nmk_chip;
 	unsigned long flags;
+	u32 bitmask;
 	int gpio;
 
 	gpio = NOMADIK_IRQ_TO_GPIO(d->irq);
 	nmk_chip = irq_data_get_irq_chip_data(d);
 	if (!nmk_chip)
 		return -EINVAL;
+	bitmask = nmk_gpio_get_bitmask(gpio);
 
 	spin_lock_irqsave(&nmk_gpio_slpm_lock, flags);
 	spin_lock(&nmk_chip->lock);
 
-#ifdef CONFIG_ARCH_U8500
-	if (cpu_is_u8500v2()) {
-		__nmk_gpio_set_slpm(nmk_chip, gpio - nmk_chip->chip.base,
-				    on ? NMK_GPIO_SLPM_WAKEUP_ENABLE
-				       : NMK_GPIO_SLPM_WAKEUP_DISABLE);
-	}
-#endif
-	__nmk_gpio_irq_modify(nmk_chip, gpio, WAKE, on);
+	if (!enabled)
+		__nmk_gpio_set_wake(nmk_chip, gpio, on);
+
+	if (on)
+		nmk_chip->real_wake |= bitmask;
+	else
+		nmk_chip->real_wake &= ~bitmask;
 
 	spin_unlock(&nmk_chip->lock);
 	spin_unlock_irqrestore(&nmk_gpio_slpm_lock, flags);
@@ -620,7 +646,7 @@ static int nmk_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	if (enabled)
 		__nmk_gpio_irq_modify(nmk_chip, gpio, NORMAL, false);
 
-	if (wake)
+	if (enabled || wake)
 		__nmk_gpio_irq_modify(nmk_chip, gpio, WAKE, false);
 
 	nmk_chip->edge_rising &= ~bitmask;
@@ -634,7 +660,7 @@ static int nmk_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	if (enabled)
 		__nmk_gpio_irq_modify(nmk_chip, gpio, NORMAL, true);
 
-	if (wake)
+	if (enabled || wake)
 		__nmk_gpio_irq_modify(nmk_chip, gpio, WAKE, true);
 
 	spin_unlock_irqrestore(&nmk_chip->lock, flags);
@@ -870,6 +896,60 @@ static struct gpio_chip nmk_gpio_template = {
 	.can_sleep		= 0,
 };
 
+/*
+ * Called from the suspend/resume path to only keep the real wakeup interrupts
+ * (those that have had set_irq_wake() called on them) as wakeup interrupts,
+ * and not the rest of the interrupts which we needed to have as wakeups for
+ * cpuidle.
+ *
+ * PM ops are not used since this needs to be done at the end, after all the
+ * other drivers are done with their suspend callbacks.
+ */
+void nmk_gpio_wakeups_suspend(void)
+{
+	int i;
+
+	for (i = 0; i < NUM_BANKS; i++) {
+		struct nmk_gpio_chip *chip = nmk_gpio_chips[i];
+
+		if (!chip)
+			break;
+
+		chip->rwimsc = readl(chip->addr + NMK_GPIO_RWIMSC);
+		chip->fwimsc = readl(chip->addr + NMK_GPIO_FWIMSC);
+
+		writel(chip->rwimsc & chip->real_wake,
+		       chip->addr + NMK_GPIO_RWIMSC);
+		writel(chip->fwimsc & chip->real_wake,
+		       chip->addr + NMK_GPIO_FWIMSC);
+
+		if (cpu_is_u8500v2()) {
+			chip->slpm = readl(chip->addr + NMK_GPIO_SLPC);
+
+			/* 0 -> wakeup enable */
+			writel(~chip->real_wake, chip->addr + NMK_GPIO_SLPC);
+		}
+	}
+}
+
+void nmk_gpio_wakeups_resume(void)
+{
+	int i;
+
+	for (i = 0; i < NUM_BANKS; i++) {
+		struct nmk_gpio_chip *chip = nmk_gpio_chips[i];
+
+		if (!chip)
+			break;
+
+		writel(chip->rwimsc, chip->addr + NMK_GPIO_RWIMSC);
+		writel(chip->fwimsc, chip->addr + NMK_GPIO_FWIMSC);
+
+		if (cpu_is_u8500v2())
+			writel(chip->slpm, chip->addr + NMK_GPIO_SLPC);
+	}
+}
+
 static int __devinit nmk_gpio_probe(struct platform_device *dev)
 {
 	struct nmk_gpio_platform_data *pdata = dev->dev.platform_data;
diff --git a/arch/arm/plat-nomadik/include/plat/gpio.h b/arch/arm/plat-nomadik/include/plat/gpio.h
index e3a4837..1b9f6f0 100644
--- a/arch/arm/plat-nomadik/include/plat/gpio.h
+++ b/arch/arm/plat-nomadik/include/plat/gpio.h
@@ -75,6 +75,9 @@ extern int nmk_gpio_set_pull(int gpio, enum nmk_gpio_pull pull);
 extern int nmk_gpio_set_mode(int gpio, int gpio_mode);
 extern int nmk_gpio_get_mode(int gpio);
 
+extern void nmk_gpio_wakeups_suspend(void);
+extern void nmk_gpio_wakeups_resume(void);
+
 /*
  * Platform data to register a block: only the initial gpio/irq number.
  */
-- 
1.7.3.2
