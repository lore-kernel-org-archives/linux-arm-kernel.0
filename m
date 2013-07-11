From: zonque@gmail.com (Daniel Mack)
Date: Thu, 11 Jul 2013 17:17:53 +0200
Subject: [PATCH 1/5] gpio: pxa: remove dead code
In-Reply-To: <1373555877-29887-1-git-send-email-zonque@gmail.com>
References: <1373555877-29887-1-git-send-email-zonque@gmail.com>
Message-ID: <1373555877-29887-2-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f87311743 ("ARM: mmp: add more compatible names in gpio driver")
changed the driver logic to determine the number of available GPIOs from
the compatible string, and hence obsoleted the (undocumented) child
nodes that were previously necessary. However, it left some remainder
which can be safely removed now.

Also, this patch makes pxa_gpio_probe_dt() return the correct value in
case irq_alloc_descs() fails.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/gpio-pxa.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index df2199d..cc13d1b 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -524,8 +524,8 @@ const struct irq_domain_ops pxa_irq_domain_ops = {
 
 static int pxa_gpio_probe_dt(struct platform_device *pdev)
 {
-	int ret, nr_gpios;
-	struct device_node *prev, *next, *np = pdev->dev.of_node;
+	int ret = 0, nr_gpios;
+	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_id =
 				of_match_device(pxa_gpio_dt_ids, &pdev->dev);
 	const struct pxa_gpio_id *gpio_id;
@@ -537,20 +537,13 @@ static int pxa_gpio_probe_dt(struct platform_device *pdev)
 	gpio_id = of_id->data;
 	gpio_type = gpio_id->type;
 
-	next = of_get_next_child(np, NULL);
-	prev = next;
-	if (!next) {
-		dev_err(&pdev->dev, "Failed to find child gpio node\n");
-		ret = -EINVAL;
-		goto err;
-	}
-	of_node_put(prev);
 	nr_gpios = gpio_id->gpio_nums;
 	pxa_last_gpio = nr_gpios - 1;
 
 	irq_base = irq_alloc_descs(-1, 0, nr_gpios, 0);
 	if (irq_base < 0) {
 		dev_err(&pdev->dev, "Failed to allocate IRQ numbers\n");
+		ret = irq_base;
 		goto err;
 	}
 	domain = irq_domain_add_legacy(np, nr_gpios, irq_base, 0,
-- 
1.8.1.4
