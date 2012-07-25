From: zonque@gmail.com (Daniel Mack)
Date: Wed, 25 Jul 2012 17:35:38 +0200
Subject: [PATCH 1/2] GPIO: gpio-pxa: simplify pxa_gpio_to_irq() and
 pxa_irq_to_chip()
Message-ID: <1343230539-7196-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simplify the code in gpio-pxa.c and make them based on irq_base.
When not probed from devicetree, initialize irq_base from
PXA_GPIO_TO_IRQ() or MMP_GPIO_TO_IRQ(), respectively, so the non-DT case
still works.

Only tested on PXA3xx.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/gpio/gpio-pxa.c |   70 +++++++++++------------------------------------
 1 file changed, 16 insertions(+), 54 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 58a6a63..6d0cb9d 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -59,6 +59,7 @@
 #define BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
 
 int pxa_last_gpio;
+static int irq_base;
 
 #ifdef CONFIG_OF
 static struct irq_domain *domain;
@@ -166,63 +167,14 @@ static inline int __gpio_is_occupied(unsigned gpio)
 	return ret;
 }
 
-#ifdef CONFIG_ARCH_PXA
-static inline int __pxa_gpio_to_irq(int gpio)
-{
-	if (gpio_is_pxa_type(gpio_type))
-		return PXA_GPIO_TO_IRQ(gpio);
-	return -1;
-}
-
-static inline int __pxa_irq_to_gpio(int irq)
-{
-	if (gpio_is_pxa_type(gpio_type))
-		return irq - PXA_GPIO_TO_IRQ(0);
-	return -1;
-}
-#else
-static inline int __pxa_gpio_to_irq(int gpio) { return -1; }
-static inline int __pxa_irq_to_gpio(int irq) { return -1; }
-#endif
-
-#ifdef CONFIG_ARCH_MMP
-static inline int __mmp_gpio_to_irq(int gpio)
-{
-	if (gpio_is_mmp_type(gpio_type))
-		return MMP_GPIO_TO_IRQ(gpio);
-	return -1;
-}
-
-static inline int __mmp_irq_to_gpio(int irq)
-{
-	if (gpio_is_mmp_type(gpio_type))
-		return irq - MMP_GPIO_TO_IRQ(0);
-	return -1;
-}
-#else
-static inline int __mmp_gpio_to_irq(int gpio) { return -1; }
-static inline int __mmp_irq_to_gpio(int irq) { return -1; }
-#endif
-
 static int pxa_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 {
-	int gpio, ret;
-
-	gpio = chip->base + offset;
-	ret = __pxa_gpio_to_irq(gpio);
-	if (ret >= 0)
-		return ret;
-	return __mmp_gpio_to_irq(gpio);
+	return chip->base + offset + irq_base;
 }
 
 int pxa_irq_to_gpio(int irq)
 {
-	int ret;
-
-	ret = __pxa_irq_to_gpio(irq);
-	if (ret >= 0)
-		return ret;
-	return __mmp_irq_to_gpio(irq);
+	return irq - irq_base;
 }
 
 static int pxa_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
@@ -510,7 +462,7 @@ const struct irq_domain_ops pxa_irq_domain_ops = {
 #ifdef CONFIG_OF
 static int __devinit pxa_gpio_probe_dt(struct platform_device *pdev)
 {
-	int ret, nr_banks, nr_gpios, irq_base;
+	int ret, nr_banks, nr_gpios;
 	struct device_node *prev, *next, *np = pdev->dev.of_node;
 	const struct of_device_id *of_id =
 				of_match_device(pxa_gpio_dt_ids, &pdev->dev);
@@ -564,10 +516,20 @@ static int __devinit pxa_gpio_probe(struct platform_device *pdev)
 	int irq0 = 0, irq1 = 0, irq_mux, gpio_offset = 0;
 
 	ret = pxa_gpio_probe_dt(pdev);
-	if (ret < 0)
+	if (ret < 0) {
 		pxa_last_gpio = pxa_gpio_nums();
-	else
+#ifdef CONFIG_ARCH_PXA
+		if (gpio_is_pxa_type(gpio_type))
+			irq_base = PXA_GPIO_TO_IRQ(0);
+#endif
+#ifdef CONFIG_ARCH_MMP
+		if (gpio_is_mmp_type(gpio_type))
+			irq_base = MMP_GPIO_TO_IRQ(0);
+#endif
+	} else {
 		use_of = 1;
+	}
+
 	if (!pxa_last_gpio)
 		return -EINVAL;
 
-- 
1.7.10.4
