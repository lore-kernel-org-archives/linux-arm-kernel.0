From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 13 May 2013 21:07:21 +0400
Subject: [PATCH RESEND v2 1/3] GPIO: clps711x: Rewrite driver for using
 generic GPIO code
In-Reply-To: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
References: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
Message-ID: <1368464857-5038-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides rewritten driver for CLPS711X GPIO which uses
generic GPIO code.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/gpio/Kconfig         |   5 +-
 drivers/gpio/gpio-clps711x.c | 226 +++++++++++--------------------------------
 2 files changed, 63 insertions(+), 168 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 30d89ed..b0d967b 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -109,8 +109,11 @@ config GPIO_MAX730X
 comment "Memory mapped GPIO drivers:"
 
 config GPIO_CLPS711X
-	def_bool y
+	tristate "CLPS711X GPIO support"
 	depends on ARCH_CLPS711X
+	select GPIO_GENERIC
+	help
+	  Say yes here to support GPIO on CLPS711X SoCs.
 
 config GPIO_GENERIC_PLATFORM
 	tristate "Generic memory-mapped GPIO controller support (MMIO platform device)"
diff --git a/drivers/gpio/gpio-clps711x.c b/drivers/gpio/gpio-clps711x.c
index ce63b75..6ce8a8c 100644
--- a/drivers/gpio/gpio-clps711x.c
+++ b/drivers/gpio/gpio-clps711x.c
@@ -1,7 +1,7 @@
 /*
  *  CLPS711X GPIO driver
  *
- *  Copyright (C) 2012 Alexander Shiyan <shc_work@mail.ru>
+ *  Copyright (C) 2012,2013 Alexander Shiyan <shc_work@mail.ru>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -9,191 +9,83 @@
  * (at your option) any later version.
  */
 
-#include <linux/io.h>
-#include <linux/slab.h>
+#include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/module.h>
-#include <linux/spinlock.h>
+#include <linux/basic_mmio_gpio.h>
 #include <linux/platform_device.h>
 
-#include <mach/hardware.h>
-
-#define CLPS711X_GPIO_PORTS	5
-#define CLPS711X_GPIO_NAME	"gpio-clps711x"
-
-struct clps711x_gpio {
-	struct gpio_chip	chip[CLPS711X_GPIO_PORTS];
-	spinlock_t		lock;
-};
-
-static void __iomem *clps711x_ports[] = {
-	CLPS711X_VIRT_BASE + PADR,
-	CLPS711X_VIRT_BASE + PBDR,
-	CLPS711X_VIRT_BASE + PCDR,
-	CLPS711X_VIRT_BASE + PDDR,
-	CLPS711X_VIRT_BASE + PEDR,
-};
-
-static void __iomem *clps711x_pdirs[] = {
-	CLPS711X_VIRT_BASE + PADDR,
-	CLPS711X_VIRT_BASE + PBDDR,
-	CLPS711X_VIRT_BASE + PCDDR,
-	CLPS711X_VIRT_BASE + PDDDR,
-	CLPS711X_VIRT_BASE + PEDDR,
-};
-
-#define clps711x_port(x)	clps711x_ports[x->base / 8]
-#define clps711x_pdir(x)	clps711x_pdirs[x->base / 8]
-
-static int gpio_clps711x_get(struct gpio_chip *chip, unsigned offset)
+static int clps711x_gpio_probe(struct platform_device *pdev)
 {
-	return !!(readb(clps711x_port(chip)) & (1 << offset));
-}
+	void __iomem *dat, *dir;
+	struct bgpio_chip *bgc;
+	struct resource *res;
+	int err, id = pdev->id;
 
-static void gpio_clps711x_set(struct gpio_chip *chip, unsigned offset,
-			      int value)
-{
-	int tmp;
-	unsigned long flags;
-	struct clps711x_gpio *gpio = dev_get_drvdata(chip->dev);
+	if ((id < 0) || (id > 4))
+		return -ENODEV;
 
-	spin_lock_irqsave(&gpio->lock, flags);
-	tmp = readb(clps711x_port(chip)) & ~(1 << offset);
-	if (value)
-		tmp |= 1 << offset;
-	writeb(tmp, clps711x_port(chip));
-	spin_unlock_irqrestore(&gpio->lock, flags);
-}
-
-static int gpio_clps711x_dir_in(struct gpio_chip *chip, unsigned offset)
-{
-	int tmp;
-	unsigned long flags;
-	struct clps711x_gpio *gpio = dev_get_drvdata(chip->dev);
-
-	spin_lock_irqsave(&gpio->lock, flags);
-	tmp = readb(clps711x_pdir(chip)) & ~(1 << offset);
-	writeb(tmp, clps711x_pdir(chip));
-	spin_unlock_irqrestore(&gpio->lock, flags);
-
-	return 0;
-}
+	bgc = devm_kzalloc(&pdev->dev, sizeof(*bgc), GFP_KERNEL);
+	if (!bgc)
+		return -ENOMEM;
 
-static int gpio_clps711x_dir_out(struct gpio_chip *chip, unsigned offset,
-				 int value)
-{
-	int tmp;
-	unsigned long flags;
-	struct clps711x_gpio *gpio = dev_get_drvdata(chip->dev);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dat = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(dat))
+		return PTR_ERR(dat);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	dir = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	switch (id) {
+	case 3:
+		/* PORTD is inverted logic for direction register */
+		err = bgpio_init(bgc, &pdev->dev, 1, dat, NULL, NULL,
+				 NULL, dir, 0);
+		break;
+	default:
+		err = bgpio_init(bgc, &pdev->dev, 1, dat, NULL, NULL,
+				 dir, NULL, 0);
+		break;
+	}
 
-	spin_lock_irqsave(&gpio->lock, flags);
-	tmp = readb(clps711x_pdir(chip)) | (1 << offset);
-	writeb(tmp, clps711x_pdir(chip));
-	tmp = readb(clps711x_port(chip)) & ~(1 << offset);
-	if (value)
-		tmp |= 1 << offset;
-	writeb(tmp, clps711x_port(chip));
-	spin_unlock_irqrestore(&gpio->lock, flags);
+	if (err)
+		return err;
 
-	return 0;
-}
-
-static int gpio_clps711x_dir_in_inv(struct gpio_chip *chip, unsigned offset)
-{
-	int tmp;
-	unsigned long flags;
-	struct clps711x_gpio *gpio = dev_get_drvdata(chip->dev);
+	switch (id) {
+	case 4:
+		/* PORTE is 3 lines only */
+		bgc->gc.ngpio = 3;
+		break;
+	default:
+		break;
+	}
 
-	spin_lock_irqsave(&gpio->lock, flags);
-	tmp = readb(clps711x_pdir(chip)) | (1 << offset);
-	writeb(tmp, clps711x_pdir(chip));
-	spin_unlock_irqrestore(&gpio->lock, flags);
+	bgc->gc.base = id * 8;
+	platform_set_drvdata(pdev, bgc);
 
-	return 0;
+	return gpiochip_add(&bgc->gc);
 }
 
-static int gpio_clps711x_dir_out_inv(struct gpio_chip *chip, unsigned offset,
-				     int value)
+static int clps711x_gpio_remove(struct platform_device *pdev)
 {
-	int tmp;
-	unsigned long flags;
-	struct clps711x_gpio *gpio = dev_get_drvdata(chip->dev);
+	struct bgpio_chip *bgc = platform_get_drvdata(pdev);
 
-	spin_lock_irqsave(&gpio->lock, flags);
-	tmp = readb(clps711x_pdir(chip)) & ~(1 << offset);
-	writeb(tmp, clps711x_pdir(chip));
-	tmp = readb(clps711x_port(chip)) & ~(1 << offset);
-	if (value)
-		tmp |= 1 << offset;
-	writeb(tmp, clps711x_port(chip));
-	spin_unlock_irqrestore(&gpio->lock, flags);
-
-	return 0;
+	return bgpio_remove(bgc);
 }
 
-static struct {
-	char	*name;
-	int	nr;
-	int	inv_dir;
-} clps711x_gpio_ports[] __initconst = {
-	{ "PORTA", 8, 0, },
-	{ "PORTB", 8, 0, },
-	{ "PORTC", 8, 0, },
-	{ "PORTD", 8, 1, },
-	{ "PORTE", 3, 0, },
+static struct platform_driver clps711x_gpio_driver = {
+	.driver	= {
+		.name	= "clps711x-gpio",
+		.owner	= THIS_MODULE,
+	},
+	.probe	= clps711x_gpio_probe,
+	.remove	= clps711x_gpio_remove,
 };
+module_platform_driver(clps711x_gpio_driver);
 
-static int __init gpio_clps711x_init(void)
-{
-	int i;
-	struct platform_device *pdev;
-	struct clps711x_gpio *gpio;
-
-	pdev = platform_device_alloc(CLPS711X_GPIO_NAME, 0);
-	if (!pdev) {
-		pr_err("Cannot create platform device: %s\n",
-		       CLPS711X_GPIO_NAME);
-		return -ENOMEM;
-	}
-
-	platform_device_add(pdev);
-
-	gpio = devm_kzalloc(&pdev->dev, sizeof(struct clps711x_gpio),
-			    GFP_KERNEL);
-	if (!gpio) {
-		dev_err(&pdev->dev, "GPIO allocating memory error\n");
-		platform_device_unregister(pdev);
-		return -ENOMEM;
-	}
-
-	platform_set_drvdata(pdev, gpio);
-
-	spin_lock_init(&gpio->lock);
-
-	for (i = 0; i < CLPS711X_GPIO_PORTS; i++) {
-		gpio->chip[i].owner		= THIS_MODULE;
-		gpio->chip[i].dev		= &pdev->dev;
-		gpio->chip[i].label		= clps711x_gpio_ports[i].name;
-		gpio->chip[i].base		= i * 8;
-		gpio->chip[i].ngpio		= clps711x_gpio_ports[i].nr;
-		gpio->chip[i].get		= gpio_clps711x_get;
-		gpio->chip[i].set		= gpio_clps711x_set;
-		if (!clps711x_gpio_ports[i].inv_dir) {
-			gpio->chip[i].direction_input = gpio_clps711x_dir_in;
-			gpio->chip[i].direction_output = gpio_clps711x_dir_out;
-		} else {
-			gpio->chip[i].direction_input = gpio_clps711x_dir_in_inv;
-			gpio->chip[i].direction_output = gpio_clps711x_dir_out_inv;
-		}
-		WARN_ON(gpiochip_add(&gpio->chip[i]));
-	}
-
-	dev_info(&pdev->dev, "GPIO driver initialized\n");
-
-	return 0;
-}
-arch_initcall(gpio_clps711x_init);
-
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
 MODULE_DESCRIPTION("CLPS711X GPIO driver");
-- 
1.8.1.5
