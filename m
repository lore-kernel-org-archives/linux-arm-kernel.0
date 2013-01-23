From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 23 Jan 2013 16:25:53 +0800
Subject: [PATCH 09/10] gpio: pxa: move gpio properties into child node
In-Reply-To: <1358929554-32265-1-git-send-email-haojian.zhuang@linaro.org>
References: <1358929554-32265-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1358929554-32265-10-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move gpio properties into child node. So pinctrl driver could binds to
each gpio chip with gpio range.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/gpio/gpio-pxa.c |   33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 21cf8fd..528f742 100644
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
@@ -404,9 +400,9 @@ static const struct irq_domain_ops pxa_irq_domain_ops = {
 
 static int pxa_gpio_probe_dt(struct platform_device *pdev)
 {
-	int ret, nr_banks;
+	int ret;
 	struct pxa_gpio_platform_data *pdata;
-	struct device_node *prev, *next, *np = pdev->dev.of_node;
+	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_id =
 				of_match_device(pxa_gpio_dt_ids, &pdev->dev);
 
@@ -432,25 +428,7 @@ static int pxa_gpio_probe_dt(struct platform_device *pdev)
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
@@ -460,6 +438,7 @@ static int pxa_init_gpio_chip(struct platform_device *pdev, int gpio_end,
 			      int (*set_wake)(unsigned int, unsigned int))
 {
 	int i, gpio, nbanks = gpio_to_bank(gpio_end) + 1;
+	struct device_node *next, *np = pdev->dev.of_node;
 	struct pxa_gpio_chip *chips;
 
 	chips = devm_kzalloc(&pdev->dev, nbanks * sizeof(*chips), GFP_KERNEL);
@@ -468,6 +447,7 @@ static int pxa_init_gpio_chip(struct platform_device *pdev, int gpio_end,
 		return -ENOMEM;
 	}
 
+	next = of_get_next_child(np, NULL);
 	for (i = 0, gpio = 0; i < nbanks; i++, gpio += 32) {
 		struct gpio_chip *gc = &chips[i].chip;
 
@@ -495,7 +475,10 @@ static int pxa_init_gpio_chip(struct platform_device *pdev, int gpio_end,
 		gc->set = pxa_gpio_set;
 		gc->to_irq = pxa_gpio_to_irq;
 #ifdef CONFIG_OF_GPIO
-		gc->of_node = pxa_gpio_of_node;
+		gc->of_node = next;
+		next = of_get_next_child(np, next);
+		of_node_put(gc->of_node);
+
 		gc->of_xlate = pxa_gpio_of_xlate;
 		gc->of_gpio_n_cells = 2;
 #endif
-- 
1.7.10.4
