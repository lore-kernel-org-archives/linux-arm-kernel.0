From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 25 Feb 2013 11:49:39 +0800
Subject: [PATCH v5 10/12] gpio: pxa: move gpio properties into child node
In-Reply-To: <1361764181-26647-1-git-send-email-haojian.zhuang@linaro.org>
References: <1361764181-26647-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1361764181-26647-11-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move gpio properties into child node. So pinctrl driver could binds to
each gpio chip with gpio range.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
Tested-by: Igor Grinberg <grinberg@compulab.co.il>
---
 drivers/gpio/gpio-pxa.c |   41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index f5f78ea..91f4881 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -65,7 +65,6 @@ static int irq_base;
 
 #ifdef CONFIG_OF
 static struct irq_domain *domain;
-static struct device_node *pxa_gpio_of_node;
 #endif
 
 struct pxa_gpio_chip {
@@ -233,8 +232,9 @@ static int pxa_gpio_of_xlate(struct gpio_chip *gc,
 static int pxa_init_gpio_chip(struct platform_device *pdev, int gpio_end)
 {
 	int i, gpio, nbanks = gpio_to_bank(gpio_end) + 1;
-	struct pxa_gpio_chip *chips;
 	struct pxa_gpio_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct pxa_gpio_chip *chips;
+	struct device_node *next = NULL, *np = NULL;
 
 	chips = devm_kzalloc(&pdev->dev, nbanks * sizeof(*chips), GFP_KERNEL);
 	if (!chips) {
@@ -242,6 +242,11 @@ static int pxa_init_gpio_chip(struct platform_device *pdev, int gpio_end)
 		return -ENOMEM;
 	}
 
+	np = pdev->dev.of_node;
+#ifdef CONFIG_OF
+	if (np)
+		next = of_get_next_child(np, NULL);
+#endif
 	for (i = 0, gpio = 0; i < nbanks; i++, gpio += 32) {
 		struct gpio_chip *gc = &chips[i].gc;
 
@@ -258,16 +263,21 @@ static int pxa_init_gpio_chip(struct platform_device *pdev, int gpio_end)
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
 
 		/* number of GPIOs on last bank may be less than 32 */
 		gc->ngpio = (gpio + 31 > gpio_end) ? (gpio_end - gpio + 1) : 32;
 		gpiochip_add(gc);
 	}
+	of_node_put(next);
 	pxa_gpio_chips = chips;
 	return 0;
 }
@@ -436,9 +446,9 @@ const struct irq_domain_ops pxa_irq_domain_ops = {
 
 static int pxa_gpio_probe_dt(struct platform_device *pdev)
 {
-	int ret, nr_banks;
+	int ret;
 	struct pxa_gpio_platform_data *pdata;
-	struct device_node *prev, *next, *np = pdev->dev.of_node;
+	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_id =
 				of_match_device(pxa_gpio_dt_ids, &pdev->dev);
 
@@ -458,20 +468,6 @@ static int pxa_gpio_probe_dt(struct platform_device *pdev)
 		return -ENOTSUPP;
 	}
 
-	next = of_get_next_child(np, NULL);
-	prev = next;
-	if (!next) {
-		dev_err(&pdev->dev, "Failed to find child gpio node\n");
-		return -EINVAL;
-	}
-	for (nr_banks = 1; ; nr_banks++) {
-		next = of_get_next_child(np, prev);
-		if (!next)
-			break;
-		prev = next;
-	}
-	of_node_put(prev);
-
 	irq_base = irq_alloc_descs(-1, 0, pdata->nr_gpios, 0);
 	if (irq_base < 0) {
 		dev_err(&pdev->dev, "Failed to allocate IRQ numbers\n");
@@ -482,7 +478,6 @@ static int pxa_gpio_probe_dt(struct platform_device *pdev)
 	pdev->dev.platform_data = pdata;
 	domain = irq_domain_add_legacy(np, pdata->nr_gpios, irq_base, 0,
 				       &pxa_irq_domain_ops, NULL);
-	pxa_gpio_of_node = np;
 	return 0;
 }
 #else
-- 
1.7.10.4
