From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 18 Feb 2013 13:12:34 +0800
Subject: [PATCH v3 08/12] gpio: pxa: move gpio properties into child node
In-Reply-To: <1361164358-5845-1-git-send-email-haojian.zhuang@linaro.org>
References: <1361164358-5845-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1361164358-5845-9-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move gpio properties into child node. So pinctrl driver could binds to
each gpio chip with gpio range.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/gpio/gpio-pxa.c |   45 +++++++++++++++++----------------------------
 1 file changed, 17 insertions(+), 28 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 8130e3b..5c39db3 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -63,10 +63,6 @@
 
 int pxa_last_gpio;
 
-#ifdef CONFIG_OF
-static struct device_node *pxa_gpio_of_node;
-#endif
-
 struct pxa_gpio_chip {
 	struct gpio_chip chip;
 	void __iomem	*regbase;
@@ -404,9 +400,9 @@ static struct of_device_id pxa_gpio_dt_ids[] = {
 
 static int pxa_gpio_probe_dt(struct platform_device *pdev)
 {
-	int ret, nr_banks;
+	int ret;
 	struct pxa_gpio_platform_data *pdata;
-	struct device_node *prev, *next, *np = pdev->dev.of_node;
+	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_id =
 				of_match_device(pxa_gpio_dt_ids, &pdev->dev);
 
@@ -430,25 +426,7 @@ static int pxa_gpio_probe_dt(struct platform_device *pdev)
 	/* set the platform data */
 	pdev->dev.platform_data = pdata;
 
-	next = of_get_next_child(np, NULL);
-	prev = next;
-	if (!next) {
-		dev_err(&pdev->dev, "Failed to find child gpio node\n");
-		ret = -EINVAL;
-		goto err;
-	}
-	for (nr_banks = 1; ; nr_banks++) {
-		next = of_get_next_child(np, prev);
-		if (!next)
-			break;
-		prev = next;
-	}
-	of_node_put(prev);
-
 	return 0;
-err:
-	iounmap(gpio_reg_base);
-	return ret;
 }
 #else
 #define pxa_gpio_probe_dt(pdev)		(-1)
@@ -459,6 +437,7 @@ static int pxa_init_gpio_chip(struct platform_device *pdev, int gpio_end,
 {
 	int i, gpio, nbanks = gpio_to_bank(gpio_end) + 1;
 	struct pxa_gpio_chip *chips;
+	struct device_node *next = NULL, *np = NULL;
 
 	chips = devm_kzalloc(&pdev->dev, nbanks * sizeof(*chips), GFP_KERNEL);
 	if (chips == NULL) {
@@ -466,6 +445,11 @@ static int pxa_init_gpio_chip(struct platform_device *pdev, int gpio_end,
 		return -ENOMEM;
 	}
 
+	np = pdev->dev.of_node;
+#ifdef CONFIG_OF
+	if (np)
+		next = of_get_next_child(np, NULL);
+#endif
 	for (i = 0, gpio = 0; i < nbanks; i++, gpio += 32) {
 		struct gpio_chip *gc = &chips[i].chip;
 
@@ -492,13 +476,18 @@ static int pxa_init_gpio_chip(struct platform_device *pdev, int gpio_end,
 		gc->get = pxa_gpio_get;
 		gc->set = pxa_gpio_set;
 		gc->to_irq = pxa_gpio_to_irq;
-#ifdef CONFIG_OF_GPIO
-		gc->of_node = pxa_gpio_of_node;
-		gc->of_xlate = pxa_gpio_of_xlate;
-		gc->of_gpio_n_cells = 2;
+#ifdef CONFIG_OF
+		if (np) {
+			gc->of_node = next;
+			next = of_get_next_child(np, next);
+
+			gc->of_xlate = pxa_gpio_of_xlate;
+			gc->of_gpio_n_cells = 2;
+		}
 #endif
 		gpiochip_add(gc);
 	}
+	of_node_put(next);
 	pxa_gpio_chips = chips;
 	return 0;
 }
-- 
1.7.10.4
