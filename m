From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  5 Feb 2016 23:49:28 +0100
Subject: [PATCH] pinctrl: stm32: fix compile error and modernize
Message-ID: <1454712568-6301-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Fix the dev->parent assignment compile error
- Use gpiochip_get_data() to get the data pointer for the
  banks

Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I don't even know how to compile test this, I hope it works,
Maxime can you verify?
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index d25d4a064bad..9a08222ecb72 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -6,7 +6,7 @@
  * Heavily based on Mediatek's pinctrl driver
  */
 #include <linux/clk.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -46,9 +46,6 @@
 #define gpio_range_to_bank(chip) \
 		container_of(chip, struct stm32_gpio_bank, range)
 
-#define gpio_chip_to_bank(chip) \
-		container_of(chip, struct stm32_gpio_bank, gpio_chip)
-
 static const char * const stm32_gpio_functions[] = {
 	"gpio", "af0", "af1",
 	"af2", "af3", "af4",
@@ -144,7 +141,7 @@ static void stm32_gpio_free(struct gpio_chip *chip, unsigned offset)
 
 static int stm32_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
-	struct stm32_gpio_bank *bank = gpio_chip_to_bank(chip);
+	struct stm32_gpio_bank *bank = gpiochip_get_data(chip);
 	int ret;
 
 	clk_enable(bank->clk);
@@ -158,7 +155,7 @@ static int stm32_gpio_get(struct gpio_chip *chip, unsigned offset)
 
 static void stm32_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
-	struct stm32_gpio_bank *bank = gpio_chip_to_bank(chip);
+	struct stm32_gpio_bank *bank = gpiochip_get_data(chip);
 
 	__stm32_gpio_set(bank, offset, value);
 }
@@ -171,7 +168,7 @@ static int stm32_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 static int stm32_gpio_direction_output(struct gpio_chip *chip,
 	unsigned offset, int value)
 {
-	struct stm32_gpio_bank *bank = gpio_chip_to_bank(chip);
+	struct stm32_gpio_bank *bank = gpiochip_get_data(chip);
 
 	__stm32_gpio_set(bank, offset, value);
 	pinctrl_gpio_direction_output(chip->base + offset);
@@ -689,7 +686,7 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
 	bank->gpio_chip.base = bank_nr * STM32_GPIO_PINS_PER_BANK;
 	bank->gpio_chip.ngpio = npins;
 	bank->gpio_chip.of_node = np;
-	bank->gpio_chip.dev = dev;
+	bank->gpio_chip.parent = dev;
 	spin_lock_init(&bank->lock);
 
 	of_property_read_string(np, "st,bank-name", &range->name);
@@ -699,7 +696,7 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
 	range->pin_base = range->base = range->id * STM32_GPIO_PINS_PER_BANK;
 	range->npins = bank->gpio_chip.ngpio;
 	range->gc = &bank->gpio_chip;
-	err  = gpiochip_add(&bank->gpio_chip);
+	err = gpiochip_add_data(&bank->gpio_chip, bank);
 	if (err) {
 		dev_err(dev, "Failed to add gpiochip(%d)!\n", bank_nr);
 		return err;
-- 
2.4.3
