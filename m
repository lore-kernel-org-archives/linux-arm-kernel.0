From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Aug 2018 22:41:02 +0200
Subject: [PATCH 02/11] gpio: ep93xx: Cut down variable names
In-Reply-To: <20180822204111.9581-1-linus.walleij@linaro.org>
References: <20180822204111.9581-1-linus.walleij@linaro.org>
Message-ID: <20180822204111.9581-3-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to clean up the driver I need to cut a few trees,
sorry, variable names, so I can see the forest, sorry driver
properly.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-ep93xx.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index 654525d6a9f1..3bfd0e46f7ed 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -37,7 +37,7 @@ void __iomem *ep93xx_gpio_base; /* FIXME: put this into irq_data */
 #define EP93XX_GPIO_LINE_MAX_IRQ 23
 
 struct ep93xx_gpio {
-	void __iomem		*mmio_base;
+	void __iomem		*base;
 	struct gpio_chip	gc[8];
 };
 
@@ -323,10 +323,10 @@ static int ep93xx_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 }
 
 static int ep93xx_gpio_add_bank(struct gpio_chip *gc, struct device *dev,
-	void __iomem *mmio_base, struct ep93xx_gpio_bank *bank)
+	void __iomem *base, struct ep93xx_gpio_bank *bank)
 {
-	void __iomem *data = mmio_base + bank->data;
-	void __iomem *dir =  mmio_base + bank->dir;
+	void __iomem *data = base + bank->data;
+	void __iomem *dir =  base + bank->dir;
 	int err;
 
 	err = bgpio_init(gc, dev, 1, data, NULL, NULL, dir, NULL, 0);
@@ -346,27 +346,27 @@ static int ep93xx_gpio_add_bank(struct gpio_chip *gc, struct device *dev,
 
 static int ep93xx_gpio_probe(struct platform_device *pdev)
 {
-	struct ep93xx_gpio *ep93xx_gpio;
+	struct ep93xx_gpio *epg;
 	struct resource *res;
 	int i;
 	struct device *dev = &pdev->dev;
 
-	ep93xx_gpio = devm_kzalloc(dev, sizeof(struct ep93xx_gpio), GFP_KERNEL);
-	if (!ep93xx_gpio)
+	epg = devm_kzalloc(dev, sizeof(*epg), GFP_KERNEL);
+	if (!epg)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ep93xx_gpio->mmio_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(ep93xx_gpio->mmio_base))
-		return PTR_ERR(ep93xx_gpio->mmio_base);
-	ep93xx_gpio_base = ep93xx_gpio->mmio_base;
+	epg->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(epg->base))
+		return PTR_ERR(epg->base);
+	ep93xx_gpio_base = epg->base;
 
 	for (i = 0; i < ARRAY_SIZE(ep93xx_gpio_banks); i++) {
-		struct gpio_chip *gc = &ep93xx_gpio->gc[i];
+		struct gpio_chip *gc = &epg->gc[i];
 		struct ep93xx_gpio_bank *bank = &ep93xx_gpio_banks[i];
 
 		if (ep93xx_gpio_add_bank(gc, &pdev->dev,
-					 ep93xx_gpio->mmio_base, bank))
+					 epg->base, bank))
 			dev_warn(&pdev->dev, "Unable to add gpio bank %s\n",
 				bank->label);
 	}
-- 
2.17.1
