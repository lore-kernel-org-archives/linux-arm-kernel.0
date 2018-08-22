From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Aug 2018 22:41:05 +0200
Subject: [PATCH 05/11] gpio: ep93xx: Rename has_debounce to has_irq
In-Reply-To: <20180822204111.9581-1-linus.walleij@linaro.org>
References: <20180822204111.9581-1-linus.walleij@linaro.org>
Message-ID: <20180822204111.9581-6-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is closer to what the variable (per bank) actually
means. We have the .gpio_to_irq() hook registered only
when this is true.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-ep93xx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index 379f2573f794..a81d1e796912 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -297,25 +297,25 @@ struct ep93xx_gpio_bank {
 	int		data;
 	int		dir;
 	int		base;
-	bool		has_debounce;
+	bool		has_irq;
 };
 
-#define EP93XX_GPIO_BANK(_label, _data, _dir, _base, _debounce)	\
+#define EP93XX_GPIO_BANK(_label, _data, _dir, _base, _has_irq)	\
 	{							\
 		.label		= _label,			\
 		.data		= _data,			\
 		.dir		= _dir,				\
 		.base		= _base,			\
-		.has_debounce	= _debounce,			\
+		.has_irq	= _has_irq,			\
 	}
 
 static struct ep93xx_gpio_bank ep93xx_gpio_banks[] = {
-	EP93XX_GPIO_BANK("A", 0x00, 0x10, 0, true),
-	EP93XX_GPIO_BANK("B", 0x04, 0x14, 8, true),
+	EP93XX_GPIO_BANK("A", 0x00, 0x10, 0, true), /* Bank A has 8 IRQs */
+	EP93XX_GPIO_BANK("B", 0x04, 0x14, 8, true), /* Bank B has 8 IRQs */
 	EP93XX_GPIO_BANK("C", 0x08, 0x18, 40, false),
 	EP93XX_GPIO_BANK("D", 0x0c, 0x1c, 24, false),
 	EP93XX_GPIO_BANK("E", 0x20, 0x24, 32, false),
-	EP93XX_GPIO_BANK("F", 0x30, 0x34, 16, true),
+	EP93XX_GPIO_BANK("F", 0x30, 0x34, 16, true), /* Bank F has 8 IRQs */
 	EP93XX_GPIO_BANK("G", 0x38, 0x3c, 48, false),
 	EP93XX_GPIO_BANK("H", 0x40, 0x44, 56, false),
 };
@@ -370,7 +370,7 @@ static int ep93xx_gpio_add_bank(struct gpio_chip *gc, struct device *dev,
 	gc->label = bank->label;
 	gc->base = bank->base;
 
-	if (bank->has_debounce) {
+	if (bank->has_irq) {
 		gc->set_config = ep93xx_gpio_set_config;
 		gc->to_irq = ep93xx_gpio_to_irq;
 	}
-- 
2.17.1
