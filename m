From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 21 Nov 2012 08:50:43 +0100
Subject: [PATCH] gpiolib: rename pin range arguments
Message-ID: <1353484243-6115-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

To be crystal clear on what the arguments mean in this
funtion dealing with both GPIO and PIN ranges with confusing
naming, we now have gpio_offset and pin_offset and we are
on the clear that these are offsets into the specific GPIO
and pin controller respectively. The GPIO chip itself will
of course keep track of the base offset into the global
GPIO number space.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c     | 19 ++++++++++---------
 include/asm-generic/gpio.h |  4 ++--
 include/linux/gpio.h       |  2 +-
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 317ff04..26e27c1 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1191,13 +1191,13 @@ EXPORT_SYMBOL_GPL(gpiochip_find);
  * gpiochip_add_pin_range() - add a range for GPIO <-> pin mapping
  * @chip: the gpiochip to add the range for
  * @pinctrl_name: the dev_name() of the pin controller to map to
- * @offset: the start offset in the current gpio_chip number space
- * @pin_base: the start offset in the pin controller number space
+ * @gpio_offset: the start offset in the current gpio_chip number space
+ * @pin_offset: the start offset in the pin controller number space
  * @npins: the number of pins from the offset of each pin space (GPIO and
  *	pin controller) to accumulate in this range
  */
 int gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
-			   unsigned int offset, unsigned int pin_base,
+			   unsigned int gpio_offset, unsigned int pin_offset,
 			   unsigned int npins)
 {
 	struct gpio_pin_range *pin_range;
@@ -1210,11 +1210,11 @@ int gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
 	}
 
 	/* Use local offset as range ID */
-	pin_range->range.id = offset;
+	pin_range->range.id = gpio_offset;
 	pin_range->range.gc = chip;
 	pin_range->range.name = chip->label;
-	pin_range->range.base = chip->base + offset;
-	pin_range->range.pin_base = pin_base;
+	pin_range->range.base = chip->base + gpio_offset;
+	pin_range->range.pin_base = pin_offset;
 	pin_range->range.npins = npins;
 	pin_range->pctldev = pinctrl_find_and_add_gpio_range(pinctl_name,
 			&pin_range->range);
@@ -1224,9 +1224,10 @@ int gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
 		kfree(pin_range);
 		return PTR_ERR(pin_range->pctldev);
 	}
-	pr_debug("%s: GPIO chip: created GPIO range %d->%d ==> PIN %d->%d\n",
-		 chip->label, offset, offset + npins - 1,
-		 pin_base, pin_base + npins - 1);
+	pr_debug("GPIO chip %s: created GPIO range %d->%d ==> %s PIN %d->%d\n",
+		 chip->label, gpio_offset, gpio_offset + npins - 1,
+		 pinctl_name,
+		 pin_offset, pin_offset + npins - 1);
 
 	list_add_tail(&pin_range->node, &chip->pin_ranges);
 
diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index ec58fdb..9fd3093 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -283,7 +283,7 @@ struct gpio_pin_range {
 };
 
 int gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
-			   unsigned int offset, unsigned int pin_base,
+			   unsigned int gpio_offset, unsigned int pin_offset,
 			   unsigned int npins);
 void gpiochip_remove_pin_ranges(struct gpio_chip *chip);
 
@@ -291,7 +291,7 @@ void gpiochip_remove_pin_ranges(struct gpio_chip *chip);
 
 static inline int
 gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
-		       unsigned int offset, unsigned int pin_base,
+		       unsigned int gpio_offset, unsigned int pin_offset,
 		       unsigned int npins)
 {
 	return 0;
diff --git a/include/linux/gpio.h b/include/linux/gpio.h
index 99861c6..bfe6656 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -233,7 +233,7 @@ static inline int irq_to_gpio(unsigned irq)
 
 static inline int
 gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
-		       unsigned int offset, unsigned int pin_base,
+		       unsigned int gpio_offset, unsigned int pin_offset,
 		       unsigned int npins)
 {
 	WARN_ON(1);
-- 
1.7.11.3
