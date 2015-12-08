From: peda@lysator.liu.se (Peter Rosin)
Date: Tue,  8 Dec 2015 04:20:08 +0100
Subject: [RESEND RFC PATCH 2/2] pinctrl: at91: expose the isr bit
In-Reply-To: <1449544808-3163-1-git-send-email-peda@lysator.liu.se>
References: <1449544808-3163-1-git-send-email-peda@lysator.liu.se>
Message-ID: <1449544808-3163-3-git-send-email-peda@lysator.liu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Rosin <peda@axentia.se>

This is a bit horrible, as reading the isr register will interfere with
interrupts on other pins in the same pio. So, be careful...

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/pinctrl/pinctrl-at91.c |   50 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 2deb1309fcac..6ae615264e6a 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -16,6 +16,7 @@
 #include <linux/of_irq.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/pinctrl/machine.h>
@@ -40,6 +41,8 @@ struct at91_gpio_chip {
 	int			pioc_hwirq;	/* PIO bank interrupt identifier on AIC */
 	int			pioc_virq;	/* PIO bank Linux virtual interrupt */
 	int			pioc_idx;	/* PIO bank index */
+	spinlock_t		isr_lock;	/* PIO_ISR cache lock */
+	unsigned		isr_cache;	/* PIO_ISR cache */
 	void __iomem		*regbase;	/* PIO bank virtual address */
 	struct clk		*clock;		/* associated clock */
 	struct at91_pinctrl_mux_ops *ops;	/* ops */
@@ -737,7 +740,9 @@ static int at91_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
 			continue;
 
 		mask = pin_to_mask(pin->pin);
+		spin_lock(&gpio_chips[pin->bank]->isr_lock);
 		at91_mux_disable_interrupt(pio, mask);
+		spin_unlock(&gpio_chips[pin->bank]->isr_lock);
 		switch (pin->mux) {
 		case AT91_MUX_GPIO:
 			at91_mux_gpio_enable(pio, mask, 1);
@@ -1331,6 +1336,29 @@ static int at91_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return (pdsr & mask) != 0;
 }
 
+static int at91_gpio_get_isr(struct gpio_chip *chip, unsigned offset)
+{
+	struct at91_gpio_chip *at91_gpio = to_at91_gpio_chip(chip);
+	void __iomem *pio = at91_gpio->regbase;
+	unsigned mask = 1 << offset;
+	int res;
+
+	spin_lock(&at91_gpio->isr_lock);
+	if (readl_relaxed(pio + PIO_IMR)) {
+		/* do not clobber PIO_ISR if any interrupts are enabled */
+		res = -EBUSY;
+		goto out;
+	}
+
+	at91_gpio->isr_cache |= readl_relaxed(pio + PIO_ISR);
+	res = (at91_gpio->isr_cache & mask) != 0;
+	at91_gpio->isr_cache &= ~mask;
+
+ out:
+	spin_unlock(&at91_gpio->isr_lock);
+	return res;
+}
+
 static void at91_gpio_set(struct gpio_chip *chip, unsigned offset,
 				int val)
 {
@@ -1425,8 +1453,12 @@ static void gpio_irq_mask(struct irq_data *d)
 	void __iomem	*pio = at91_gpio->regbase;
 	unsigned	mask = 1 << d->hwirq;
 
-	if (pio)
-		writel_relaxed(mask, pio + PIO_IDR);
+	if (!pio)
+		return;
+
+	spin_lock(&at91_gpio->isr_lock);
+	writel_relaxed(mask, pio + PIO_IDR);
+	spin_unlock(&at91_gpio->isr_lock);
 }
 
 static void gpio_irq_unmask(struct irq_data *d)
@@ -1435,8 +1467,12 @@ static void gpio_irq_unmask(struct irq_data *d)
 	void __iomem	*pio = at91_gpio->regbase;
 	unsigned	mask = 1 << d->hwirq;
 
-	if (pio)
-		writel_relaxed(mask, pio + PIO_IER);
+	if (!pio)
+		return;
+
+	spin_lock(&at91_gpio->isr_lock);
+	writel_relaxed(mask, pio + PIO_IER);
+	spin_unlock(&at91_gpio->isr_lock);
 }
 
 static int gpio_irq_type(struct irq_data *d, unsigned type)
@@ -1562,8 +1598,10 @@ void at91_pinctrl_gpio_suspend(void)
 		pio = gpio_chips[i]->regbase;
 
 		backups[i] = readl_relaxed(pio + PIO_IMR);
+		spin_lock(&gpio_chips[i]->isr_lock);
 		writel_relaxed(backups[i], pio + PIO_IDR);
 		writel_relaxed(wakeups[i], pio + PIO_IER);
+		spin_unlock(&gpio_chips[i]->isr_lock);
 
 		if (!wakeups[i])
 			clk_disable_unprepare(gpio_chips[i]->clock);
@@ -1588,8 +1626,10 @@ void at91_pinctrl_gpio_resume(void)
 		if (!wakeups[i])
 			clk_prepare_enable(gpio_chips[i]->clock);
 
+		spin_lock(&gpio_chips[i]->isr_lock);
 		writel_relaxed(wakeups[i], pio + PIO_IDR);
 		writel_relaxed(backups[i], pio + PIO_IER);
+		spin_unlock(&gpio_chips[i]->isr_lock);
 	}
 }
 
@@ -1713,6 +1753,7 @@ static struct gpio_chip at91_gpio_template = {
 	.get_direction		= at91_gpio_get_direction,
 	.direction_input	= at91_gpio_direction_input,
 	.get			= at91_gpio_get,
+	.get_isr		= at91_gpio_get_isr,
 	.direction_output	= at91_gpio_direction_output,
 	.set			= at91_gpio_set,
 	.set_multiple		= at91_gpio_set_multiple,
@@ -1789,6 +1830,7 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	}
 
 	at91_chip->chip = at91_gpio_template;
+	spin_lock_init(&at91_chip->isr_lock);
 
 	chip = &at91_chip->chip;
 	chip->of_node = np;
-- 
1.7.10.4
