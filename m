From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 8 Feb 2011 10:20:53 +0100
Subject: [PATCH 8/9] plat-nomadik: implement safe switch sequence for Alt-C
In-Reply-To: <1297156854-32295-1-git-send-email-linus.walleij@stericsson.com>
References: <1297156854-32295-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1297156854-32295-9-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabin Vincent <rabin.vincent@stericsson.com>

Setting pinmux alternative C for a GPIO pin is actually not
so easy since it ivolves setting value "1" in two registers,
and since the combined result will take effect for intermediate
values (01 or 10) this will cause glitches while you wrote one
register but have not yet written the other.

This patch implements a series of kludges including an optional
machine-specific callback to avoid glitches when changing pin
mux mode to alternative C.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c              |  211 +++++++++++++++++++++++------
 arch/arm/plat-nomadik/include/plat/gpio.h |    1 +
 2 files changed, 172 insertions(+), 40 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index bf299cf..9f1b720 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -47,6 +47,8 @@ static const u32 backup_regs[] = {
 	NMK_GPIO_FWIMSC,
 };
 
+#define NMK_GPIO_PER_CHIP	32
+
 struct nmk_gpio_chip {
 	struct gpio_chip chip;
 	void __iomem *addr;
@@ -55,6 +57,7 @@ struct nmk_gpio_chip {
 	unsigned int parent_irq;
 	int secondary_parent_irq;
 	u32 (*get_secondary_status)(unsigned int bank);
+	void (*set_ioforce)(bool enable);
 	spinlock_t lock;
 	/* Keep track of configured edges */
 	u32 edge_rising;
@@ -64,6 +67,13 @@ struct nmk_gpio_chip {
 	u32 pull;
 };
 
+static struct nmk_gpio_chip *
+nmk_gpio_chips[DIV_ROUND_UP(ARCH_NR_GPIOS, NMK_GPIO_PER_CHIP)];
+
+static DEFINE_SPINLOCK(nmk_gpio_slpm_lock);
+
+#define NUM_BANKS ARRAY_SIZE(nmk_gpio_chips)
+
 static void __nmk_gpio_set_mode(struct nmk_gpio_chip *nmk_chip,
 				unsigned offset, int gpio_mode)
 {
@@ -138,8 +148,38 @@ static void __nmk_gpio_make_output(struct nmk_gpio_chip *nmk_chip,
 	__nmk_gpio_set_output(nmk_chip, offset, val);
 }
 
+static void __nmk_gpio_set_mode_safe(struct nmk_gpio_chip *nmk_chip,
+				     unsigned offset, int gpio_mode,
+				     bool glitch)
+{
+	u32 rwimsc;
+	u32 fwimsc;
+
+	if (glitch && nmk_chip->set_ioforce) {
+		u32 bit = BIT(offset);
+
+		rwimsc = readl(nmk_chip->addr + NMK_GPIO_RWIMSC);
+		fwimsc = readl(nmk_chip->addr + NMK_GPIO_FWIMSC);
+
+		/* Prevent spurious wakeups */
+		writel(rwimsc & ~bit, nmk_chip->addr + NMK_GPIO_RWIMSC);
+		writel(fwimsc & ~bit, nmk_chip->addr + NMK_GPIO_FWIMSC);
+
+		nmk_chip->set_ioforce(true);
+	}
+
+	__nmk_gpio_set_mode(nmk_chip, offset, gpio_mode);
+
+	if (glitch && nmk_chip->set_ioforce) {
+		nmk_chip->set_ioforce(false);
+
+		writel(rwimsc, nmk_chip->addr + NMK_GPIO_RWIMSC);
+		writel(fwimsc, nmk_chip->addr + NMK_GPIO_FWIMSC);
+	}
+}
+
 static void __nmk_config_pin(struct nmk_gpio_chip *nmk_chip, unsigned offset,
-			     pin_cfg_t cfg, bool sleep)
+			     pin_cfg_t cfg, bool sleep, unsigned int *slpmregs)
 {
 	static const char *afnames[] = {
 		[NMK_GPIO_ALT_GPIO]	= "GPIO",
@@ -164,6 +204,7 @@ static void __nmk_config_pin(struct nmk_gpio_chip *nmk_chip, unsigned offset,
 	int slpm = PIN_SLPM(cfg);
 	int output = PIN_DIR(cfg);
 	int val = PIN_VAL(cfg);
+	bool glitch = af == NMK_GPIO_ALT_C;
 
 	dev_dbg(nmk_chip->chip.dev, "pin %d [%#lx]: af %s, pull %s, slpm %s (%s%s)\n",
 		pin, cfg, afnames[af], pullnames[pull], slpmnames[slpm],
@@ -202,8 +243,116 @@ static void __nmk_config_pin(struct nmk_gpio_chip *nmk_chip, unsigned offset,
 		__nmk_gpio_set_pull(nmk_chip, offset, pull);
 	}
 
-	__nmk_gpio_set_slpm(nmk_chip, offset, slpm);
-	__nmk_gpio_set_mode(nmk_chip, offset, af);
+	/*
+	 * If we've backed up the SLPM registers (glitch workaround), modify
+	 * the backups since they will be restored.
+	 */
+	if (slpmregs) {
+		if (slpm == NMK_GPIO_SLPM_NOCHANGE)
+			slpmregs[nmk_chip->bank] |= BIT(offset);
+		else
+			slpmregs[nmk_chip->bank] &= ~BIT(offset);
+	} else
+		__nmk_gpio_set_slpm(nmk_chip, offset, slpm);
+
+	__nmk_gpio_set_mode_safe(nmk_chip, offset, af, glitch);
+}
+
+/*
+ * Safe sequence used to switch IOs between GPIO and Alternate-C mode:
+ *  - Save SLPM registers
+ *  - Set SLPM=0 for the IOs you want to switch and others to 1
+ *  - Configure the GPIO registers for the IOs that are being switched
+ *  - Set IOFORCE=1
+ *  - Modify the AFLSA/B registers for the IOs that are being switched
+ *  - Set IOFORCE=0
+ *  - Restore SLPM registers
+ *  - Any spurious wake up event during switch sequence to be ignored and
+ *    cleared
+ */
+static void nmk_gpio_glitch_slpm_init(unsigned int *slpm)
+{
+	int i;
+
+	for (i = 0; i < NUM_BANKS; i++) {
+		struct nmk_gpio_chip *chip = nmk_gpio_chips[i];
+		unsigned int temp = slpm[i];
+
+		if (!chip)
+			break;
+
+		slpm[i] = readl(chip->addr + NMK_GPIO_SLPC);
+		writel(temp, chip->addr + NMK_GPIO_SLPC);
+	}
+}
+
+static void nmk_gpio_glitch_slpm_restore(unsigned int *slpm)
+{
+	int i;
+
+	for (i = 0; i < NUM_BANKS; i++) {
+		struct nmk_gpio_chip *chip = nmk_gpio_chips[i];
+
+		if (!chip)
+			break;
+
+		writel(slpm[i], chip->addr + NMK_GPIO_SLPC);
+	}
+}
+
+static int __nmk_config_pins(pin_cfg_t *cfgs, int num, bool sleep)
+{
+	static unsigned int slpm[NUM_BANKS];
+	unsigned long flags;
+	bool glitch = false;
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < num; i++) {
+		if (PIN_ALT(cfgs[i]) == NMK_GPIO_ALT_C) {
+			glitch = true;
+			break;
+		}
+	}
+
+	spin_lock_irqsave(&nmk_gpio_slpm_lock, flags);
+
+	if (glitch) {
+		memset(slpm, 0xff, sizeof(slpm));
+
+		for (i = 0; i < num; i++) {
+			int pin = PIN_NUM(cfgs[i]);
+			int offset = pin % NMK_GPIO_PER_CHIP;
+
+			if (PIN_ALT(cfgs[i]) == NMK_GPIO_ALT_C)
+				slpm[pin / NMK_GPIO_PER_CHIP] &= ~BIT(offset);
+		}
+
+		nmk_gpio_glitch_slpm_init(slpm);
+	}
+
+	for (i = 0; i < num; i++) {
+		struct nmk_gpio_chip *nmk_chip;
+		int pin = PIN_NUM(cfgs[i]);
+
+		nmk_chip = get_irq_chip_data(NOMADIK_GPIO_TO_IRQ(pin));
+		if (!nmk_chip) {
+			ret = -EINVAL;
+			break;
+		}
+
+		spin_lock(&nmk_chip->lock);
+		__nmk_config_pin(nmk_chip, pin - nmk_chip->chip.base,
+				 cfgs[i], sleep, glitch ? slpm : NULL);
+		spin_unlock(&nmk_chip->lock);
+	}
+
+	if (glitch)
+		nmk_gpio_glitch_slpm_restore(slpm);
+
+	spin_unlock_irqrestore(&nmk_gpio_slpm_lock, flags);
+
+	return ret;
 }
 
 /**
@@ -222,19 +371,7 @@ static void __nmk_config_pin(struct nmk_gpio_chip *nmk_chip, unsigned offset,
  */
 int nmk_config_pin(pin_cfg_t cfg, bool sleep)
 {
-	struct nmk_gpio_chip *nmk_chip;
-	int gpio = PIN_NUM(cfg);
-	unsigned long flags;
-
-	nmk_chip = get_irq_chip_data(NOMADIK_GPIO_TO_IRQ(gpio));
-	if (!nmk_chip)
-		return -EINVAL;
-
-	spin_lock_irqsave(&nmk_chip->lock, flags);
-	__nmk_config_pin(nmk_chip, gpio - nmk_chip->chip.base, cfg, sleep);
-	spin_unlock_irqrestore(&nmk_chip->lock, flags);
-
-	return 0;
+	return __nmk_config_pins(&cfg, 1, sleep);
 }
 EXPORT_SYMBOL(nmk_config_pin);
 
@@ -248,31 +385,13 @@ EXPORT_SYMBOL(nmk_config_pin);
  */
 int nmk_config_pins(pin_cfg_t *cfgs, int num)
 {
-	int ret = 0;
-	int i;
-
-	for (i = 0; i < num; i++) {
-		ret = nmk_config_pin(cfgs[i], false);
-		if (ret)
-			break;
-	}
-
-	return ret;
+	return __nmk_config_pins(cfgs, num, false);
 }
 EXPORT_SYMBOL(nmk_config_pins);
 
 int nmk_config_pins_sleep(pin_cfg_t *cfgs, int num)
 {
-	int ret = 0;
-	int i;
-
-	for (i = 0; i < num; i++) {
-		ret = nmk_config_pin(cfgs[i], true);
-		if (ret)
-			break;
-	}
-
-	return ret;
+	return __nmk_config_pins(cfgs, num, true);
 }
 EXPORT_SYMBOL(nmk_config_pins_sleep);
 
@@ -299,9 +418,13 @@ int nmk_gpio_set_slpm(int gpio, enum nmk_gpio_slpm mode)
 	if (!nmk_chip)
 		return -EINVAL;
 
-	spin_lock_irqsave(&nmk_chip->lock, flags);
+	spin_lock_irqsave(&nmk_gpio_slpm_lock, flags);
+	spin_lock(&nmk_chip->lock);
+
 	__nmk_gpio_set_slpm(nmk_chip, gpio - nmk_chip->chip.base, mode);
-	spin_unlock_irqrestore(&nmk_chip->lock, flags);
+
+	spin_unlock(&nmk_chip->lock);
+	spin_unlock_irqrestore(&nmk_gpio_slpm_lock, flags);
 
 	return 0;
 }
@@ -474,7 +597,9 @@ static int nmk_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 	if (!nmk_chip)
 		return -EINVAL;
 
-	spin_lock_irqsave(&nmk_chip->lock, flags);
+	spin_lock_irqsave(&nmk_gpio_slpm_lock, flags);
+	spin_lock(&nmk_chip->lock);
+
 #ifdef CONFIG_ARCH_U8500
 	if (cpu_is_u8500v2()) {
 		__nmk_gpio_set_slpm(nmk_chip, gpio,
@@ -483,7 +608,9 @@ static int nmk_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 	}
 #endif
 	__nmk_gpio_irq_modify(nmk_chip, gpio, WAKE, on);
-	spin_unlock_irqrestore(&nmk_chip->lock, flags);
+
+	spin_unlock(&nmk_chip->lock);
+	spin_unlock_irqrestore(&nmk_gpio_slpm_lock, flags);
 
 	return 0;
 }
@@ -826,6 +953,7 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
 	nmk_chip->parent_irq = irq;
 	nmk_chip->secondary_parent_irq = secondary_irq;
 	nmk_chip->get_secondary_status = pdata->get_secondary_status;
+	nmk_chip->set_ioforce = pdata->set_ioforce;
 	spin_lock_init(&nmk_chip->lock);
 
 	chip = &nmk_chip->chip;
@@ -839,6 +967,9 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
 	if (ret)
 		goto out_free;
 
+	BUG_ON(nmk_chip->bank >= ARRAY_SIZE(nmk_gpio_chips));
+
+	nmk_gpio_chips[nmk_chip->bank] = nmk_chip;
 	platform_set_drvdata(dev, nmk_chip);
 
 	nmk_gpio_init_irq(nmk_chip);
diff --git a/arch/arm/plat-nomadik/include/plat/gpio.h b/arch/arm/plat-nomadik/include/plat/gpio.h
index d108a32..e3a4837 100644
--- a/arch/arm/plat-nomadik/include/plat/gpio.h
+++ b/arch/arm/plat-nomadik/include/plat/gpio.h
@@ -84,6 +84,7 @@ struct nmk_gpio_platform_data {
 	int first_irq;
 	int num_gpio;
 	u32 (*get_secondary_status)(unsigned int bank);
+	void (*set_ioforce)(bool enable);
 };
 
 #endif /* __ASM_PLAT_GPIO_H */
-- 
1.7.3.2
