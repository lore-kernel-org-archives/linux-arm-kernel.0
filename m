From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 09 Jan 2016 22:16:42 +0100
Subject: [PATCH] gpio: generic: make bgpio_pdata always visible
Message-ID: <21095568.bdP2eOAsBs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Board files that define their own bgpio_pdata are broken when
CONFIG_GPIO_GENERIC is disabled and the bgpio_pdata structure
definition is hidden by the #ifdef:

arch/arm/mach-clps711x/board-autcpu12.c:148:15: error: variable 'autcpu12_mmgpio_pdata' has initializer but incomplete type
 static struct bgpio_pdata autcpu12_mmgpio_pdata __initdata = {
arch/arm/mach-clps711x/board-autcpu12.c:149:2: error: unknown field 'base' specified in initializer
  .base = AUTCPU12_MMGPIO_BASE,

Since the board files should generally not care what drivers are
enabled, this makes the structure definition visible again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 0f4630f3720e ("gpio: generic: factor into gpio_chip struct")

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index e2d05fd0e6e3..82fda487453f 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -220,14 +220,14 @@ static inline void *gpiochip_get_data(struct gpio_chip *chip)
 
 struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc);
 
-#if IS_ENABLED(CONFIG_GPIO_GENERIC)
-
 struct bgpio_pdata {
 	const char *label;
 	int base;
 	int ngpio;
 };
 
+#if IS_ENABLED(CONFIG_GPIO_GENERIC)
+
 int bgpio_init(struct gpio_chip *gc, struct device *dev,
 	       unsigned long sz, void __iomem *dat, void __iomem *set,
 	       void __iomem *clr, void __iomem *dirout, void __iomem *dirin,
