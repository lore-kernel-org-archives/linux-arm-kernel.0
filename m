From: alexanders83@web.de (Alexander Stein)
Date: Thu,  2 Apr 2015 11:55:49 +0200
Subject: [PATCH v3 1/1] pinctrl: at91: Add set_multiple GPIO chip feature
Message-ID: <1427968549-19837-1-git-send-email-alexanders83@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the callback for set_multiple.
As this controller has a separate set and clear register, we can't write
directly to PIO_ODSR as this would required a cached variable and would
race with at91_gpio_set.
So build masks for the PIO_SODR and PIO_CODR registers and write them
together.

Signed-off-by: Alexander Stein <alexanders83@web.de>
---
I Just realized that some implementations have less than 32 pins. Thus
BITS_MASK(chip->ngpio) as suggested by Jean-Christophe is actually required.
I missed that, sorry for the noise.

Changes in v3:
* As not all GPIO controllers have 32 pins take ngpio into account
  Mask the set- and clear-mask to the supported GPIO pins
Changes in v2:
* Greatly simplyfied the implementation: Generate the set- and clear-mask
  directly from 'mask' and 'bits'

 drivers/pinctrl/pinctrl-at91.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index a4814066ea08..f1b0bfb94fcb 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1330,6 +1330,21 @@ static void at91_gpio_set(struct gpio_chip *chip, unsigned offset,
 	writel_relaxed(mask, pio + (val ? PIO_SODR : PIO_CODR));
 }
 
+static void at91_gpio_set_multiple(struct gpio_chip *chip,
+				      unsigned long *mask, unsigned long *bits)
+{
+	struct at91_gpio_chip *at91_gpio = to_at91_gpio_chip(chip);
+	void __iomem *pio = at91_gpio->regbase;
+
+#define BITS_MASK(bits) (((bits) == 32) ? ~0U : (BIT(bits) - 1))
+	/* Mask additionally to ngpio as not all GPIO controllers have 32 pins */
+	uint32_t set_mask = (*mask & *bits) & BITS_MASK(chip->ngpio);
+	uint32_t clear_mask = (*mask & ~(*bits)) & BITS_MASK(chip->ngpio);
+
+	writel_relaxed(set_mask, pio + PIO_SODR);
+	writel_relaxed(clear_mask, pio + PIO_CODR);
+}
+
 static int at91_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
 				int val)
 {
@@ -1689,6 +1704,7 @@ static struct gpio_chip at91_gpio_template = {
 	.get			= at91_gpio_get,
 	.direction_output	= at91_gpio_direction_output,
 	.set			= at91_gpio_set,
+	.set_multiple		= at91_gpio_set_multiple,
 	.dbg_show		= at91_gpio_dbg_show,
 	.can_sleep		= false,
 	.ngpio			= MAX_NB_GPIO_PER_BANK,
-- 
2.3.4
