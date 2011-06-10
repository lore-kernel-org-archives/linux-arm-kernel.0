From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 10 Jun 2011 10:49:12 +0200
Subject: [PATCH 1/2] gpio: expose gpio_to_chip()
Message-ID: <1307695752-28051-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This makes the gpio_to_chip() function available to drivers. The
usecase is when you want to add a few chip-specific operations
apart from the ones exposed in struct gpio_chip.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c     |    2 +-
 include/asm-generic/gpio.h |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a971e3d..dc315e9 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -114,7 +114,7 @@ static int gpio_ensure_requested(struct gpio_desc *desc, unsigned offset)
 }
 
 /* caller holds gpio_lock *OR* gpio is marked as requested */
-static inline struct gpio_chip *gpio_to_chip(unsigned gpio)
+struct gpio_chip *gpio_to_chip(unsigned gpio)
 {
 	return gpio_desc[gpio].chip;
 }
diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index fcdcb5d..dd8c815 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -132,6 +132,7 @@ struct gpio_chip {
 #endif
 };
 
+extern struct gpio_chip *gpio_to_chip(unsigned gpio);
 extern const char *gpiochip_is_requested(struct gpio_chip *chip,
 			unsigned offset);
 extern int __must_check gpiochip_reserve(int start, int ngpio);
-- 
1.7.3.2
