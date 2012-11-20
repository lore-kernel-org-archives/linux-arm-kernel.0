From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 20 Nov 2012 15:04:42 +0100
Subject: [PATCH 4/7] gpiolib: return any error code from range creation
Message-ID: <1353420282-18066-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

If we try to create a range for a certain GPIO chip and the
target pin controller is not yet available it may return
a probe deferral error code, so handle this all the way
our by checking the error code.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a59d13d..317ff04 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1218,10 +1218,11 @@ int gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
 	pin_range->range.npins = npins;
 	pin_range->pctldev = pinctrl_find_and_add_gpio_range(pinctl_name,
 			&pin_range->range);
-	if (!pin_range->pctldev) {
+	if (IS_ERR(pin_range->pctldev)) {
 		pr_err("%s: GPIO chip: could not create pin range\n",
 		       chip->label);
 		kfree(pin_range);
+		return PTR_ERR(pin_range->pctldev);
 	}
 	pr_debug("%s: GPIO chip: created GPIO range %d->%d ==> PIN %d->%d\n",
 		 chip->label, offset, offset + npins - 1,
-- 
1.7.11.3
