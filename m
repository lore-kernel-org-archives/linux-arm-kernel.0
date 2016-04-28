From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 28 Apr 2016 14:34:00 +0200
Subject: [PATCH 1/2] pinctrl: nomadik: use BIT() with offsets consequently
Message-ID: <1461846840-30265-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is confusing in referencing/dereferencing the global
GPIO number scope in some places and using local offsets in other
places. Remove some of the confusion by removing local "bit" and
"bitmask" definitions and just use BIT(offset) directly. Also
unexport a function only used in this file.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 128 ++++++++++++------------------
 1 file changed, 51 insertions(+), 77 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 352406108fa0..a121c0c06234 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/of_device.h>
 #include <linux/of_address.h>
+#include <linux/bitops.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
@@ -292,15 +293,14 @@ static DEFINE_SPINLOCK(nmk_gpio_slpm_lock);
 static void __nmk_gpio_set_mode(struct nmk_gpio_chip *nmk_chip,
 				unsigned offset, int gpio_mode)
 {
-	u32 bit = 1 << offset;
 	u32 afunc, bfunc;
 
-	afunc = readl(nmk_chip->addr + NMK_GPIO_AFSLA) & ~bit;
-	bfunc = readl(nmk_chip->addr + NMK_GPIO_AFSLB) & ~bit;
+	afunc = readl(nmk_chip->addr + NMK_GPIO_AFSLA) & ~BIT(offset);
+	bfunc = readl(nmk_chip->addr + NMK_GPIO_AFSLB) & ~BIT(offset);
 	if (gpio_mode & NMK_GPIO_ALT_A)
-		afunc |= bit;
+		afunc |= BIT(offset);
 	if (gpio_mode & NMK_GPIO_ALT_B)
-		bfunc |= bit;
+		bfunc |= BIT(offset);
 	writel(afunc, nmk_chip->addr + NMK_GPIO_AFSLA);
 	writel(bfunc, nmk_chip->addr + NMK_GPIO_AFSLB);
 }
@@ -308,55 +308,52 @@ static void __nmk_gpio_set_mode(struct nmk_gpio_chip *nmk_chip,
 static void __nmk_gpio_set_slpm(struct nmk_gpio_chip *nmk_chip,
 				unsigned offset, enum nmk_gpio_slpm mode)
 {
-	u32 bit = 1 << offset;
 	u32 slpm;
 
 	slpm = readl(nmk_chip->addr + NMK_GPIO_SLPC);
 	if (mode == NMK_GPIO_SLPM_NOCHANGE)
-		slpm |= bit;
+		slpm |= BIT(offset);
 	else
-		slpm &= ~bit;
+		slpm &= ~BIT(offset);
 	writel(slpm, nmk_chip->addr + NMK_GPIO_SLPC);
 }
 
 static void __nmk_gpio_set_pull(struct nmk_gpio_chip *nmk_chip,
 				unsigned offset, enum nmk_gpio_pull pull)
 {
-	u32 bit = 1 << offset;
 	u32 pdis;
 
 	pdis = readl(nmk_chip->addr + NMK_GPIO_PDIS);
 	if (pull == NMK_GPIO_PULL_NONE) {
-		pdis |= bit;
-		nmk_chip->pull_up &= ~bit;
+		pdis |= BIT(offset);
+		nmk_chip->pull_up &= ~BIT(offset);
 	} else {
-		pdis &= ~bit;
+		pdis &= ~BIT(offset);
 	}
 
 	writel(pdis, nmk_chip->addr + NMK_GPIO_PDIS);
 
 	if (pull == NMK_GPIO_PULL_UP) {
-		nmk_chip->pull_up |= bit;
-		writel(bit, nmk_chip->addr + NMK_GPIO_DATS);
+		nmk_chip->pull_up |= BIT(offset);
+		writel(BIT(offset), nmk_chip->addr + NMK_GPIO_DATS);
 	} else if (pull == NMK_GPIO_PULL_DOWN) {
-		nmk_chip->pull_up &= ~bit;
-		writel(bit, nmk_chip->addr + NMK_GPIO_DATC);
+		nmk_chip->pull_up &= ~BIT(offset);
+		writel(BIT(offset), nmk_chip->addr + NMK_GPIO_DATC);
 	}
 }
 
 static void __nmk_gpio_set_lowemi(struct nmk_gpio_chip *nmk_chip,
 				  unsigned offset, bool lowemi)
 {
-	u32 bit = BIT(offset);
-	bool enabled = nmk_chip->lowemi & bit;
+	bool enabled = nmk_chip->lowemi & BIT(offset);
 
 	if (lowemi == enabled)
 		return;
 
 	if (lowemi)
-		nmk_chip->lowemi |= bit;
+		nmk_chip->lowemi |= BIT(offset);
 	else
-		nmk_chip->lowemi &= ~bit;
+		nmk_chip->lowemi &= ~BIT(offset);
 
 	writel_relaxed(nmk_chip->lowemi,
 		       nmk_chip->addr + NMK_GPIO_LOWEMI);
@@ -365,22 +362,22 @@ static void __nmk_gpio_set_lowemi(struct nmk_gpio_chip *nmk_chip,
 static void __nmk_gpio_make_input(struct nmk_gpio_chip *nmk_chip,
 				  unsigned offset)
 {
-	writel(1 << offset, nmk_chip->addr + NMK_GPIO_DIRC);
+	writel(BIT(offset), nmk_chip->addr + NMK_GPIO_DIRC);
 }
 
 static void __nmk_gpio_set_output(struct nmk_gpio_chip *nmk_chip,
 				  unsigned offset, int val)
 {
 	if (val)
-		writel(1 << offset, nmk_chip->addr + NMK_GPIO_DATS);
+		writel(BIT(offset), nmk_chip->addr + NMK_GPIO_DATS);
 	else
-		writel(1 << offset, nmk_chip->addr + NMK_GPIO_DATC);
+		writel(BIT(offset), nmk_chip->addr + NMK_GPIO_DATC);
 }
 
 static void __nmk_gpio_make_output(struct nmk_gpio_chip *nmk_chip,
 				  unsigned offset, int val)
 {
-	writel(1 << offset, nmk_chip->addr + NMK_GPIO_DIRS);
+	writel(BIT(offset), nmk_chip->addr + NMK_GPIO_DIRS);
 	__nmk_gpio_set_output(nmk_chip, offset, val);
 }
 
@@ -614,34 +611,21 @@ static int __maybe_unused nmk_prcm_gpiocr_get_mode(struct pinctrl_dev *pctldev,
 	return NMK_GPIO_ALT_C;
 }
 
-int nmk_gpio_get_mode(int gpio)
+static int nmk_gpio_get_mode(struct nmk_gpio_chip *nmk_chip, int offset)
 {
-	struct nmk_gpio_chip *nmk_chip;
-	u32 afunc, bfunc, bit;
-
-	nmk_chip = nmk_gpio_chips[gpio / NMK_GPIO_PER_CHIP];
-	if (!nmk_chip)
-		return -EINVAL;
-
-	bit = 1 << (gpio % NMK_GPIO_PER_CHIP);
+	u32 afunc, bfunc;
 
 	clk_enable(nmk_chip->clk);
 
-	afunc = readl(nmk_chip->addr + NMK_GPIO_AFSLA) & bit;
-	bfunc = readl(nmk_chip->addr + NMK_GPIO_AFSLB) & bit;
+	afunc = readl(nmk_chip->addr + NMK_GPIO_AFSLA) & BIT(offset);
+	bfunc = readl(nmk_chip->addr + NMK_GPIO_AFSLB) & BIT(offset);
 
 	clk_disable(nmk_chip->clk);
 
 	return (afunc ? NMK_GPIO_ALT_A : 0) | (bfunc ? NMK_GPIO_ALT_B : 0);
 }
-EXPORT_SYMBOL(nmk_gpio_get_mode);
-
 
 /* IRQ functions */
-static inline int nmk_gpio_get_bitmask(int gpio)
-{
-	return 1 << (gpio % NMK_GPIO_PER_CHIP);
-}
 
 static void nmk_gpio_irq_ack(struct irq_data *d)
 {
@@ -649,7 +633,7 @@ static void nmk_gpio_irq_ack(struct irq_data *d)
 	struct nmk_gpio_chip *nmk_chip = gpiochip_get_data(chip);
 
 	clk_enable(nmk_chip->clk);
-	writel(nmk_gpio_get_bitmask(d->hwirq), nmk_chip->addr + NMK_GPIO_IC);
+	writel(BIT(d->hwirq), nmk_chip->addr + NMK_GPIO_IC);
 	clk_disable(nmk_chip->clk);
 }
 
@@ -659,10 +643,9 @@ enum nmk_gpio_irq_type {
 };
 
 static void __nmk_gpio_irq_modify(struct nmk_gpio_chip *nmk_chip,
-				  int gpio, enum nmk_gpio_irq_type which,
+				  int offset, enum nmk_gpio_irq_type which,
 				  bool enable)
 {
-	u32 bitmask = nmk_gpio_get_bitmask(gpio);
 	u32 *rimscval;
 	u32 *fimscval;
 	u32 rimscreg;
@@ -681,24 +664,24 @@ static void __nmk_gpio_irq_modify(struct nmk_gpio_chip *nmk_chip,
 	}
 
 	/* we must individually set/clear the two edges */
-	if (nmk_chip->edge_rising & bitmask) {
+	if (nmk_chip->edge_rising & BIT(offset)) {
 		if (enable)
-			*rimscval |= bitmask;
+			*rimscval |= BIT(offset);
 		else
-			*rimscval &= ~bitmask;
+			*rimscval &= ~BIT(offset);
 		writel(*rimscval, nmk_chip->addr + rimscreg);
 	}
-	if (nmk_chip->edge_falling & bitmask) {
+	if (nmk_chip->edge_falling & BIT(offset)) {
 		if (enable)
-			*fimscval |= bitmask;
+			*fimscval |= BIT(offset);
 		else
-			*fimscval &= ~bitmask;
+			*fimscval &= ~BIT(offset);
 		writel(*fimscval, nmk_chip->addr + fimscreg);
 	}
 }
 
 static void __nmk_gpio_set_wake(struct nmk_gpio_chip *nmk_chip,
-				int gpio, bool on)
+				int offset, bool on)
 {
 	/*
 	 * Ensure WAKEUP_ENABLE is on.  No need to disable it if wakeup is
@@ -706,21 +689,19 @@ static void __nmk_gpio_set_wake(struct nmk_gpio_chip *nmk_chip,
 	 * wakeup is anyhow controlled by the RIMSC and FIMSC registers.
 	 */
 	if (nmk_chip->sleepmode && on) {
-		__nmk_gpio_set_slpm(nmk_chip, gpio % NMK_GPIO_PER_CHIP,
+		__nmk_gpio_set_slpm(nmk_chip, offset,
 				    NMK_GPIO_SLPM_WAKEUP_ENABLE);
 	}
 
-	__nmk_gpio_irq_modify(nmk_chip, gpio, WAKE, on);
+	__nmk_gpio_irq_modify(nmk_chip, offset, WAKE, on);
 }
 
 static int nmk_gpio_irq_maskunmask(struct irq_data *d, bool enable)
 {
 	struct nmk_gpio_chip *nmk_chip;
 	unsigned long flags;
-	u32 bitmask;
 
 	nmk_chip = irq_data_get_irq_chip_data(d);
-	bitmask = nmk_gpio_get_bitmask(d->hwirq);
 	if (!nmk_chip)
 		return -EINVAL;
 
@@ -730,7 +711,7 @@ static int nmk_gpio_irq_maskunmask(struct irq_data *d, bool enable)
 
 	__nmk_gpio_irq_modify(nmk_chip, d->hwirq, NORMAL, enable);
 
-	if (!(nmk_chip->real_wake & bitmask))
+	if (!(nmk_chip->real_wake & BIT(d->hwirq)))
 		__nmk_gpio_set_wake(nmk_chip, d->hwirq, enable);
 
 	spin_unlock(&nmk_chip->lock);
@@ -754,12 +735,10 @@ static int nmk_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 {
 	struct nmk_gpio_chip *nmk_chip;
 	unsigned long flags;
-	u32 bitmask;
 
 	nmk_chip = irq_data_get_irq_chip_data(d);
 	if (!nmk_chip)
 		return -EINVAL;
-	bitmask = nmk_gpio_get_bitmask(d->hwirq);
 
 	clk_enable(nmk_chip->clk);
 	spin_lock_irqsave(&nmk_gpio_slpm_lock, flags);
@@ -769,9 +748,9 @@ static int nmk_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 		__nmk_gpio_set_wake(nmk_chip, d->hwirq, on);
 
 	if (on)
-		nmk_chip->real_wake |= bitmask;
+		nmk_chip->real_wake |= BIT(d->hwirq);
 	else
-		nmk_chip->real_wake &= ~bitmask;
+		nmk_chip->real_wake &= ~BIT(d->hwirq);
 
 	spin_unlock(&nmk_chip->lock);
 	spin_unlock_irqrestore(&nmk_gpio_slpm_lock, flags);
@@ -786,10 +765,8 @@ static int nmk_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	bool wake = irqd_is_wakeup_set(d);
 	struct nmk_gpio_chip *nmk_chip;
 	unsigned long flags;
-	u32 bitmask;
 
 	nmk_chip = irq_data_get_irq_chip_data(d);
-	bitmask = nmk_gpio_get_bitmask(d->hwirq);
 	if (!nmk_chip)
 		return -EINVAL;
 	if (type & IRQ_TYPE_LEVEL_HIGH)
@@ -806,13 +783,13 @@ static int nmk_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	if (enabled || wake)
 		__nmk_gpio_irq_modify(nmk_chip, d->hwirq, WAKE, false);
 
-	nmk_chip->edge_rising &= ~bitmask;
+	nmk_chip->edge_rising &= ~BIT(d->hwirq);
 	if (type & IRQ_TYPE_EDGE_RISING)
-		nmk_chip->edge_rising |= bitmask;
+		nmk_chip->edge_rising |= BIT(d->hwirq);
 
-	nmk_chip->edge_falling &= ~bitmask;
+	nmk_chip->edge_falling &= ~BIT(d->hwirq);
 	if (type & IRQ_TYPE_EDGE_FALLING)
-		nmk_chip->edge_falling |= bitmask;
+		nmk_chip->edge_falling |= BIT(d->hwirq);
 
 	if (enabled)
 		__nmk_gpio_irq_modify(nmk_chip, d->hwirq, NORMAL, true);
@@ -890,7 +867,7 @@ static int nmk_gpio_make_input(struct gpio_chip *chip, unsigned offset)
 
 	clk_enable(nmk_chip->clk);
 
-	writel(1 << offset, nmk_chip->addr + NMK_GPIO_DIRC);
+	writel(BIT(offset), nmk_chip->addr + NMK_GPIO_DIRC);
 
 	clk_disable(nmk_chip->clk);
 
@@ -900,12 +877,11 @@ static int nmk_gpio_make_input(struct gpio_chip *chip, unsigned offset)
 static int nmk_gpio_get_input(struct gpio_chip *chip, unsigned offset)
 {
 	struct nmk_gpio_chip *nmk_chip = gpiochip_get_data(chip);
-	u32 bit = 1 << offset;
 	int value;
 
 	clk_enable(nmk_chip->clk);
 
-	value = (readl(nmk_chip->addr + NMK_GPIO_DAT) & bit) != 0;
+	value = !!(readl(nmk_chip->addr + NMK_GPIO_DAT) & BIT(offset));
 
 	clk_disable(nmk_chip->clk);
 
@@ -952,7 +928,6 @@ static void nmk_gpio_dbg_show_one(struct seq_file *s,
 	bool is_out;
 	bool data_out;
 	bool pull;
-	u32 bit = 1 << offset;
 	const char *modes[] = {
 		[NMK_GPIO_ALT_GPIO]	= "gpio",
 		[NMK_GPIO_ALT_A]	= "altA",
@@ -970,10 +945,10 @@ static void nmk_gpio_dbg_show_one(struct seq_file *s,
 	};
 
 	clk_enable(nmk_chip->clk);
-	is_out = !!(readl(nmk_chip->addr + NMK_GPIO_DIR) & bit);
-	pull = !(readl(nmk_chip->addr + NMK_GPIO_PDIS) & bit);
-	data_out = !!(readl(nmk_chip->addr + NMK_GPIO_DAT) & bit);
-	mode = nmk_gpio_get_mode(gpio);
+	is_out = !!(readl(nmk_chip->addr + NMK_GPIO_DIR) & BIT(offset));
+	pull = !(readl(nmk_chip->addr + NMK_GPIO_PDIS) & BIT(offset));
+	data_out = !!(readl(nmk_chip->addr + NMK_GPIO_DAT) & BIT(offset));
+	mode = nmk_gpio_get_mode(nmk_chip, offset);
 	if ((mode == NMK_GPIO_ALT_C) && pctldev)
 		mode = nmk_prcm_gpiocr_get_mode(pctldev, gpio);
 
@@ -1007,11 +982,10 @@ static void nmk_gpio_dbg_show_one(struct seq_file *s,
 		 */
 		if (irq > 0 && desc && desc->action) {
 			char *trigger;
-			u32 bitmask = nmk_gpio_get_bitmask(gpio);
 
-			if (nmk_chip->edge_rising & bitmask)
+			if (nmk_chip->edge_rising & BIT(offset))
 				trigger = "edge-rising";
-			else if (nmk_chip->edge_falling & bitmask)
+			else if (nmk_chip->edge_falling & BIT(offset))
 				trigger = "edge-falling";
 			else
 				trigger = "edge-undefined";
-- 
2.4.11
