From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 26 Aug 2018 13:03:21 +0200
Subject: [PATCH 1/2] gpio: ftgpio: Support optional silicon clock
Message-ID: <20180826110321.17723-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO silicon is clocked with a PCLK (peripheral clock)
on all systems, however not all platforms model it and include
it in e.g. the device tree, so add clock handling but make it
optional so we bail out safely if it is e.g. always on.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-ftgpio010.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-ftgpio010.c b/drivers/gpio/gpio-ftgpio010.c
index 868bf8501560..c26feab143a3 100644
--- a/drivers/gpio/gpio-ftgpio010.c
+++ b/drivers/gpio/gpio-ftgpio010.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/bitops.h>
+#include <linux/clk.h>
 
 /* GPIO registers definition */
 #define GPIO_DATA_OUT		0x00
@@ -40,11 +41,14 @@
  * struct ftgpio_gpio - Gemini GPIO state container
  * @dev: containing device for this instance
  * @gc: gpiochip for this instance
+ * @base: remapped I/O-memory base
+ * @clk: silicon clock
  */
 struct ftgpio_gpio {
 	struct device *dev;
 	struct gpio_chip gc;
 	void __iomem *base;
+	struct clk *clk;
 };
 
 static void ftgpio_gpio_ack_irq(struct irq_data *d)
@@ -180,6 +184,13 @@ static int ftgpio_gpio_probe(struct platform_device *pdev)
 	if (irq <= 0)
 		return irq ? irq : -EINVAL;
 
+	g->clk = devm_clk_get(dev, NULL);
+	if (!IS_ERR(g->clk)) {
+		ret = clk_prepare_enable(g->clk);
+		if (ret)
+			return ret;
+	}
+
 	ret = bgpio_init(&g->gc, dev, 4,
 			 g->base + GPIO_DATA_IN,
 			 g->base + GPIO_DATA_SET,
@@ -189,7 +200,7 @@ static int ftgpio_gpio_probe(struct platform_device *pdev)
 			 0);
 	if (ret) {
 		dev_err(dev, "unable to init generic GPIO\n");
-		return ret;
+		goto dis_clk;
 	}
 	g->gc.label = "FTGPIO010";
 	g->gc.base = -1;
@@ -199,7 +210,7 @@ static int ftgpio_gpio_probe(struct platform_device *pdev)
 
 	ret = devm_gpiochip_add_data(dev, &g->gc, g);
 	if (ret)
-		return ret;
+		goto dis_clk;
 
 	/* Disable, unmask and clear all interrupts */
 	writel(0x0, g->base + GPIO_INT_EN);
@@ -211,14 +222,29 @@ static int ftgpio_gpio_probe(struct platform_device *pdev)
 				   IRQ_TYPE_NONE);
 	if (ret) {
 		dev_info(dev, "could not add irqchip\n");
-		return ret;
+		goto dis_clk;
 	}
 	gpiochip_set_chained_irqchip(&g->gc, &ftgpio_gpio_irqchip,
 				     irq, ftgpio_gpio_irq_handler);
 
+	platform_set_drvdata(pdev, g);
 	dev_info(dev, "FTGPIO010 @%p registered\n", g->base);
 
 	return 0;
+
+dis_clk:
+	if (!IS_ERR(g->clk))
+		clk_disable_unprepare(g->clk);
+	return ret;
+}
+
+static int ftgpio_gpio_remove(struct platform_device *pdev)
+{
+	struct ftgpio_gpio *g = platform_get_drvdata(pdev);
+
+	if (!IS_ERR(g->clk))
+		clk_disable_unprepare(g->clk);
+	return 0;
 }
 
 static const struct of_device_id ftgpio_gpio_of_match[] = {
@@ -239,6 +265,7 @@ static struct platform_driver ftgpio_gpio_driver = {
 		.name		= "ftgpio010-gpio",
 		.of_match_table = of_match_ptr(ftgpio_gpio_of_match),
 	},
-	.probe	= ftgpio_gpio_probe,
+	.probe = ftgpio_gpio_probe,
+	.remove = ftgpio_gpio_remove,
 };
 builtin_platform_driver(ftgpio_gpio_driver);
-- 
2.17.1
