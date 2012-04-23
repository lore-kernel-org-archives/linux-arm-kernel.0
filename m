From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 23 Apr 2012 11:14:27 +0200
Subject: [PATCH 3/9] gpio/nomadik: fix spurious interrupts with SKE
Message-ID: <1335172467-27577-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabin Vincent <rabin.vincent@stericsson.com>

If the pin is switching to altfunc, and there was an interrupt
installed on it which has been lazy disabled, actually mask the
interrupt to prevent spurious interrupts that would occur while
the pin is under control of the peripheral. Only SKE does this.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
Reviewed-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-nomadik.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index 45a0e0a..681daee 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -174,6 +174,36 @@ static void __nmk_gpio_set_mode_safe(struct nmk_gpio_chip *nmk_chip,
 	}
 }
 
+static void
+nmk_gpio_disable_lazy_irq(struct nmk_gpio_chip *nmk_chip, unsigned offset)
+{
+	u32 falling = nmk_chip->fimsc & BIT(offset);
+	u32 rising = nmk_chip->rimsc & BIT(offset);
+	int gpio = nmk_chip->chip.base + offset;
+	int irq = NOMADIK_GPIO_TO_IRQ(gpio);
+	struct irq_data *d = irq_get_irq_data(irq);
+
+	if (!rising && !falling)
+		return;
+
+	if (!d || !irqd_irq_disabled(d))
+		return;
+
+	if (rising) {
+		nmk_chip->rimsc &= ~BIT(offset);
+		writel_relaxed(nmk_chip->rimsc,
+			       nmk_chip->addr + NMK_GPIO_RIMSC);
+	}
+
+	if (falling) {
+		nmk_chip->fimsc &= ~BIT(offset);
+		writel_relaxed(nmk_chip->fimsc,
+			       nmk_chip->addr + NMK_GPIO_FIMSC);
+	}
+
+	dev_dbg(nmk_chip->chip.dev, "%d: clearing interrupt mask\n", gpio);
+}
+
 static void __nmk_config_pin(struct nmk_gpio_chip *nmk_chip, unsigned offset,
 			     pin_cfg_t cfg, bool sleep, unsigned int *slpmregs)
 {
@@ -240,6 +270,15 @@ static void __nmk_config_pin(struct nmk_gpio_chip *nmk_chip, unsigned offset,
 	}
 
 	/*
+	 * If the pin is switching to altfunc, and there was an interrupt
+	 * installed on it which has been lazy disabled, actually mask the
+	 * interrupt to prevent spurious interrupts that would occur while the
+	 * pin is under control of the peripheral.  Only SKE does this.
+	 */
+	if (af != NMK_GPIO_ALT_GPIO)
+		nmk_gpio_disable_lazy_irq(nmk_chip, offset);
+
+	/*
 	 * If we've backed up the SLPM registers (glitch workaround), modify
 	 * the backups since they will be restored.
 	 */
-- 
1.7.9.2
