From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 20 Nov 2012 15:04:21 +0100
Subject: [PATCH 2/7] gpiolib: rename find_pinctrl_*
Message-ID: <1353420261-17994-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Rename the function find_pinctrl_and_add_gpio_range()
to pinctrl_find_and_add_gpio_range() so as to be consistent
with the rest of the functions.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c          | 2 +-
 drivers/pinctrl/core.c          | 4 ++--
 include/linux/pinctrl/pinctrl.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 6d13bea..a59d13d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1216,7 +1216,7 @@ int gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
 	pin_range->range.base = chip->base + offset;
 	pin_range->range.pin_base = pin_base;
 	pin_range->range.npins = npins;
-	pin_range->pctldev = find_pinctrl_and_add_gpio_range(pinctl_name,
+	pin_range->pctldev = pinctrl_find_and_add_gpio_range(pinctl_name,
 			&pin_range->range);
 	if (!pin_range->pctldev) {
 		pr_err("%s: GPIO chip: could not create pin range\n",
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 71db586..15f5ac8 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -345,7 +345,7 @@ void pinctrl_add_gpio_ranges(struct pinctrl_dev *pctldev,
 }
 EXPORT_SYMBOL_GPL(pinctrl_add_gpio_ranges);
 
-struct pinctrl_dev *find_pinctrl_and_add_gpio_range(const char *devname,
+struct pinctrl_dev *pinctrl_find_and_add_gpio_range(const char *devname,
 		struct pinctrl_gpio_range *range)
 {
 	struct pinctrl_dev *pctldev = get_pinctrl_dev_from_devname(devname);
@@ -356,7 +356,7 @@ struct pinctrl_dev *find_pinctrl_and_add_gpio_range(const char *devname,
 	pinctrl_add_gpio_range(pctldev, range);
 	return pctldev;
 }
-EXPORT_SYMBOL_GPL(find_pinctrl_and_add_gpio_range);
+EXPORT_SYMBOL_GPL(pinctrl_find_and_add_gpio_range);
 
 /**
  * pinctrl_remove_gpio_range() - remove a range of GPIOs fro a pin controller
diff --git a/include/linux/pinctrl/pinctrl.h b/include/linux/pinctrl/pinctrl.h
index 4a58428..7dee9ac 100644
--- a/include/linux/pinctrl/pinctrl.h
+++ b/include/linux/pinctrl/pinctrl.h
@@ -137,7 +137,7 @@ extern void pinctrl_add_gpio_ranges(struct pinctrl_dev *pctldev,
 extern void pinctrl_remove_gpio_range(struct pinctrl_dev *pctldev,
 				struct pinctrl_gpio_range *range);
 
-extern struct pinctrl_dev *find_pinctrl_and_add_gpio_range(const char *devname,
+extern struct pinctrl_dev *pinctrl_find_and_add_gpio_range(const char *devname,
 		struct pinctrl_gpio_range *range);
 
 #ifdef CONFIG_OF
-- 
1.7.11.3
