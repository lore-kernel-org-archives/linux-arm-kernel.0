From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Nov 2016 11:09:24 +0100
Subject: [PATCH 5/5] gpio: pl061: delete platform data handling
In-Reply-To: <1480068564-9447-1-git-send-email-linus.walleij@linaro.org>
References: <1480068564-9447-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1480068564-9447-5-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platform data is a remnant of board files and all boards using
the PL061 have been migrated to use device tree or ACPI instead.
The custom mechanism to set line by default as inputs/outputs has
been superceded by the GPIO-internal hogging mechanism.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-pl061.c | 41 +++--------------------------------------
 1 file changed, 3 insertions(+), 38 deletions(-)

diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index cbcc631181e0..0a6bfd2b06e5 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -38,19 +38,6 @@
 
 #define PL061_GPIO_NR	8
 
-struct pl061_platform_data {
-	/* number of the first GPIO */
-	unsigned	gpio_base;
-
-	/* number of the first IRQ.
-	 * If the IRQ functionality in not desired this must be set to 0.
-	 */
-	unsigned	irq_base;
-
-	u8		directions;	/* startup directions, 1: out, 0: in */
-	u8		values;		/* startup values */
-};
-
 #ifdef CONFIG_PM
 struct pl061_context_save_regs {
 	u8 gpio_data;
@@ -306,26 +293,13 @@ static struct irq_chip pl061_irqchip = {
 static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	struct device *dev = &adev->dev;
-	struct pl061_platform_data *pdata = dev_get_platdata(dev);
 	struct pl061 *pl061;
-	int ret, irq, i, irq_base;
+	int ret, irq;
 
 	pl061 = devm_kzalloc(dev, sizeof(*pl061), GFP_KERNEL);
 	if (pl061 == NULL)
 		return -ENOMEM;
 
-	if (pdata) {
-		pl061->gc.base = pdata->gpio_base;
-		irq_base = pdata->irq_base;
-		if (irq_base <= 0) {
-			dev_err(&adev->dev, "invalid IRQ base in pdata\n");
-			return -ENODEV;
-		}
-	} else {
-		pl061->gc.base = -1;
-		irq_base = 0;
-	}
-
 	pl061->base = devm_ioremap_resource(dev, &adev->res);
 	if (IS_ERR(pl061->base))
 		return PTR_ERR(pl061->base);
@@ -336,6 +310,7 @@ static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 		pl061->gc.free = gpiochip_generic_free;
 	}
 
+	pl061->gc.base = -1;
 	pl061->gc.get_direction = pl061_get_direction;
 	pl061->gc.direction_input = pl061_direction_input;
 	pl061->gc.direction_output = pl061_direction_output;
@@ -362,7 +337,7 @@ static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 	pl061->parent_irq = irq;
 
 	ret = gpiochip_irqchip_add(&pl061->gc, &pl061_irqchip,
-				   irq_base, handle_bad_irq,
+				   0, handle_bad_irq,
 				   IRQ_TYPE_NONE);
 	if (ret) {
 		dev_info(&adev->dev, "could not add irqchip\n");
@@ -371,16 +346,6 @@ static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 	gpiochip_set_chained_irqchip(&pl061->gc, &pl061_irqchip,
 				     irq, pl061_irq_handler);
 
-	for (i = 0; i < PL061_GPIO_NR; i++) {
-		if (pdata) {
-			if (pdata->directions & (BIT(i)))
-				pl061_direction_output(&pl061->gc, i,
-						pdata->values & (BIT(i)));
-			else
-				pl061_direction_input(&pl061->gc, i);
-		}
-	}
-
 	amba_set_drvdata(adev, pl061);
 	dev_info(&adev->dev, "PL061 GPIO chip @%pa registered\n",
 		 &adev->res.start);
-- 
2.7.4
