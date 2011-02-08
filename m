From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 8 Feb 2011 10:20:47 +0100
Subject: [PATCH 2/9] plat-nomadik: add custom dbg_show for GPIO
In-Reply-To: <1297156854-32295-1-git-send-email-linus.walleij@stericsson.com>
References: <1297156854-32295-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1297156854-32295-3-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabin Vincent <rabin.vincent@stericsson.com>

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c |   92 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 92 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 30bb92a..5b5fd1e 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -604,6 +604,97 @@ static int nmk_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 	return NOMADIK_GPIO_TO_IRQ(nmk_chip->chip.base) + offset;
 }
 
+#ifdef CONFIG_DEBUG_FS
+
+#include <linux/seq_file.h>
+
+static void nmk_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
+{
+	int mode;
+	unsigned		i;
+	unsigned		gpio = chip->base;
+	int			is_out;
+	struct nmk_gpio_chip *nmk_chip =
+		container_of(chip, struct nmk_gpio_chip, chip);
+	const char *modes[] = {
+		[NMK_GPIO_ALT_GPIO]	= "gpio",
+		[NMK_GPIO_ALT_A]	= "altA",
+		[NMK_GPIO_ALT_B]	= "altB",
+		[NMK_GPIO_ALT_C]	= "altC",
+	};
+
+	for (i = 0; i < chip->ngpio; i++, gpio++) {
+		const char *label = gpiochip_is_requested(chip, i);
+		bool pull;
+		u32 bit = 1 << i;
+
+		if (!label)
+			continue;
+
+		is_out = readl(nmk_chip->addr + NMK_GPIO_DIR) & bit;
+		pull = !(readl(nmk_chip->addr + NMK_GPIO_PDIS) & bit);
+		mode = nmk_gpio_get_mode(gpio);
+		seq_printf(s, " gpio-%-3d (%-20.20s) %s %s %s %s",
+			gpio, label,
+			is_out ? "out" : "in ",
+			chip->get
+				? (chip->get(chip, i) ? "hi" : "lo")
+				: "?  ",
+			(mode < 0) ? "unknown" : modes[mode],
+			pull ? "pull" : "none");
+
+		if (!is_out) {
+			int		irq = gpio_to_irq(gpio);
+			struct irq_desc	*desc = irq_to_desc(irq);
+
+			/* This races with request_irq(), set_irq_type(),
+			 * and set_irq_wake() ... but those are "rare".
+			 *
+			 * More significantly, trigger type flags aren't
+			 * currently maintained by genirq.
+			 */
+			if (irq >= 0 && desc->action) {
+				char *trigger;
+
+				switch (desc->status & IRQ_TYPE_SENSE_MASK) {
+				case IRQ_TYPE_NONE:
+					trigger = "(default)";
+					break;
+				case IRQ_TYPE_EDGE_FALLING:
+					trigger = "edge-falling";
+					break;
+				case IRQ_TYPE_EDGE_RISING:
+					trigger = "edge-rising";
+					break;
+				case IRQ_TYPE_EDGE_BOTH:
+					trigger = "edge-both";
+					break;
+				case IRQ_TYPE_LEVEL_HIGH:
+					trigger = "level-high";
+					break;
+				case IRQ_TYPE_LEVEL_LOW:
+					trigger = "level-low";
+					break;
+				default:
+					trigger = "?trigger?";
+					break;
+				}
+
+				seq_printf(s, " irq-%d %s%s",
+					irq, trigger,
+					(desc->status & IRQ_WAKEUP)
+						? " wakeup" : "");
+			}
+		}
+
+		seq_printf(s, "\n");
+	}
+}
+
+#else
+#define nmk_gpio_dbg_show	NULL
+#endif
+
 /* This structure is replicated for each GPIO block allocated at probe time */
 static struct gpio_chip nmk_gpio_template = {
 	.direction_input	= nmk_gpio_make_input,
@@ -611,6 +702,7 @@ static struct gpio_chip nmk_gpio_template = {
 	.direction_output	= nmk_gpio_make_output,
 	.set			= nmk_gpio_set_output,
 	.to_irq			= nmk_gpio_to_irq,
+	.dbg_show		= nmk_gpio_dbg_show,
 	.can_sleep		= 0,
 };
 
-- 
1.7.3.2
