From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 28 Apr 2016 14:34:09 +0200
Subject: [PATCH 2/2] pinctrl: nomadik: implement .get_direction()
Message-ID: <1461846849-30311-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes the Nomadik gpiochip support the .get_direction()
callback.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index a121c0c06234..76a08b96cc67 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -861,6 +861,20 @@ static void nmk_gpio_latent_irq_handler(struct irq_desc *desc)
 
 /* I/O Functions */
 
+static int nmk_gpio_get_dir(struct gpio_chip *chip, unsigned offset)
+{
+	struct nmk_gpio_chip *nmk_chip = gpiochip_get_data(chip);
+	int dir;
+
+	clk_enable(nmk_chip->clk);
+
+	dir = !!(readl(nmk_chip->addr + NMK_GPIO_DIR) & BIT(offset));
+
+	clk_disable(nmk_chip->clk);
+
+	return dir;
+}
+
 static int nmk_gpio_make_input(struct gpio_chip *chip, unsigned offset)
 {
 	struct nmk_gpio_chip *nmk_chip = gpiochip_get_data(chip);
@@ -1220,6 +1234,7 @@ static int nmk_gpio_probe(struct platform_device *dev)
 	chip = &nmk_chip->chip;
 	chip->request = gpiochip_generic_request;
 	chip->free = gpiochip_generic_free;
+	chip->get_direction = nmk_gpio_get_dir;
 	chip->direction_input = nmk_gpio_make_input;
 	chip->get = nmk_gpio_get_input;
 	chip->direction_output = nmk_gpio_make_output;
-- 
2.4.11
