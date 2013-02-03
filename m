From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun,  3 Feb 2013 18:15:43 +0800
Subject: [PATCH v2 02/10] gpio: pxa: avoid to use global irq base
In-Reply-To: <1359886551-20950-1-git-send-email-haojian.zhuang@linaro.org>
References: <1359886551-20950-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1359886551-20950-3-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid to use global irq_base in gpio-pxa driver. Define irq_base in each
pxa_gpio_chip instead. Then we can avoid to use macro PXA_GPIO_TO_IRQ() &
MMP_GPIO_TO_IRQ().

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mach-pxa/pxa25x.c |    2 +-
 arch/arm/mach-pxa/pxa27x.c |    2 +-
 drivers/gpio/Kconfig       |    1 +
 drivers/gpio/gpio-pxa.c    |  156 ++++++++++++++++++++++----------------------
 include/linux/gpio-pxa.h   |    4 +-
 5 files changed, 85 insertions(+), 80 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 3f5171e..f4c293a 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -289,7 +289,7 @@ static inline void pxa25x_init_pm(void) {}
 
 static int pxa25x_set_wake(struct irq_data *d, unsigned int on)
 {
-	int gpio = pxa_irq_to_gpio(d->irq);
+	int gpio = pxa_irq_to_gpio(d);
 	uint32_t mask = 0;
 
 	if (gpio >= 0 && gpio < 85)
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 69985b06..67f5fd2 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -364,7 +364,7 @@ static inline void pxa27x_init_pm(void) {}
  */
 static int pxa27x_set_wake(struct irq_data *d, unsigned int on)
 {
-	int gpio = pxa_irq_to_gpio(d->irq);
+	int gpio = pxa_irq_to_gpio(d);
 	uint32_t mask;
 
 	if (gpio >= 0 && gpio < 128)
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 176fb3d..b8c0da8 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -201,6 +201,7 @@ config GPIO_PL061
 config GPIO_PXA
 	bool "PXA GPIO support"
 	depends on ARCH_PXA || ARCH_MMP
+	select IRQ_DOMAIN
 	help
 	  Say yes here to support the PXA GPIO device
 
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index a4c6687..2310665 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -13,6 +13,7 @@
  */
 #include <linux/module.h>
 #include <linux/clk.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/gpio-pxa.h>
@@ -61,16 +62,15 @@
 #define BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
 
 int pxa_last_gpio;
-static int irq_base;
 
 #ifdef CONFIG_OF
-static struct irq_domain *domain;
 static struct device_node *pxa_gpio_of_node;
 #endif
 
 struct pxa_gpio_chip {
 	struct gpio_chip chip;
 	void __iomem	*regbase;
+	unsigned int	irq_base;
 	char label[10];
 
 	unsigned long	irq_mask;
@@ -170,14 +170,22 @@ static inline int __gpio_is_occupied(unsigned gpio)
 	return ret;
 }
 
-static int pxa_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+static int pxa_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
 {
-	return chip->base + offset + irq_base;
+	struct pxa_gpio_chip *chip = NULL;
+
+	chip = container_of(gc, struct pxa_gpio_chip, chip);
+	return chip->irq_base + offset;
 }
 
-int pxa_irq_to_gpio(int irq)
+int pxa_irq_to_gpio(struct irq_data *d)
 {
-	return irq - irq_base;
+	struct pxa_gpio_chip *chip;
+	int gpio;
+
+	chip = (struct pxa_gpio_chip *)d->domain->host_data;
+	gpio = d->irq - chip->irq_base + chip->chip.base;
+	return gpio;
 }
 
 static int pxa_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
@@ -250,47 +258,6 @@ static int pxa_gpio_of_xlate(struct gpio_chip *gc,
 }
 #endif
 
-static int pxa_init_gpio_chip(int gpio_end,
-					int (*set_wake)(unsigned int, unsigned int))
-{
-	int i, gpio, nbanks = gpio_to_bank(gpio_end) + 1;
-	struct pxa_gpio_chip *chips;
-
-	chips = kzalloc(nbanks * sizeof(struct pxa_gpio_chip), GFP_KERNEL);
-	if (chips == NULL) {
-		pr_err("%s: failed to allocate GPIO chips\n", __func__);
-		return -ENOMEM;
-	}
-
-	for (i = 0, gpio = 0; i < nbanks; i++, gpio += 32) {
-		struct gpio_chip *c = &chips[i].chip;
-
-		sprintf(chips[i].label, "gpio-%d", i);
-		chips[i].regbase = gpio_reg_base + BANK_OFF(i);
-		chips[i].set_wake = set_wake;
-
-		c->base  = gpio;
-		c->label = chips[i].label;
-
-		c->direction_input  = pxa_gpio_direction_input;
-		c->direction_output = pxa_gpio_direction_output;
-		c->get = pxa_gpio_get;
-		c->set = pxa_gpio_set;
-		c->to_irq = pxa_gpio_to_irq;
-#ifdef CONFIG_OF_GPIO
-		c->of_node = pxa_gpio_of_node;
-		c->of_xlate = pxa_gpio_of_xlate;
-		c->of_gpio_n_cells = 2;
-#endif
-
-		/* number of GPIOs on last bank may be less than 32 */
-		c->ngpio = (gpio + 31 > gpio_end) ? (gpio_end - gpio + 1) : 32;
-		gpiochip_add(c);
-	}
-	pxa_gpio_chips = chips;
-	return 0;
-}
-
 /* Update only those GRERx and GFERx edge detection register bits if those
  * bits are set in c->irq_mask
  */
@@ -309,7 +276,7 @@ static inline void update_edge_detect(struct pxa_gpio_chip *c)
 static int pxa_gpio_irq_type(struct irq_data *d, unsigned int type)
 {
 	struct pxa_gpio_chip *c;
-	int gpio = pxa_irq_to_gpio(d->irq);
+	int gpio = pxa_irq_to_gpio(d);
 	unsigned long gpdr, mask = GPIO_bit(gpio);
 
 	c = gpio_to_pxachip(gpio);
@@ -383,7 +350,7 @@ static void pxa_gpio_demux_handler(unsigned int irq, struct irq_desc *desc)
 
 static void pxa_ack_muxed_gpio(struct irq_data *d)
 {
-	int gpio = pxa_irq_to_gpio(d->irq);
+	int gpio = pxa_irq_to_gpio(d);
 	struct pxa_gpio_chip *c = gpio_to_pxachip(gpio);
 
 	writel_relaxed(GPIO_bit(gpio), c->regbase + GEDR_OFFSET);
@@ -391,7 +358,7 @@ static void pxa_ack_muxed_gpio(struct irq_data *d)
 
 static void pxa_mask_muxed_gpio(struct irq_data *d)
 {
-	int gpio = pxa_irq_to_gpio(d->irq);
+	int gpio = pxa_irq_to_gpio(d);
 	struct pxa_gpio_chip *c = gpio_to_pxachip(gpio);
 	uint32_t grer, gfer;
 
@@ -405,7 +372,7 @@ static void pxa_mask_muxed_gpio(struct irq_data *d)
 
 static int pxa_gpio_set_wake(struct irq_data *d, unsigned int on)
 {
-	int gpio = pxa_irq_to_gpio(d->irq);
+	int gpio = pxa_irq_to_gpio(d);
 	struct pxa_gpio_chip *c = gpio_to_pxachip(gpio);
 
 	if (c->set_wake)
@@ -416,7 +383,7 @@ static int pxa_gpio_set_wake(struct irq_data *d, unsigned int on)
 
 static void pxa_unmask_muxed_gpio(struct irq_data *d)
 {
-	int gpio = pxa_irq_to_gpio(d->irq);
+	int gpio = pxa_irq_to_gpio(d);
 	struct pxa_gpio_chip *c = gpio_to_pxachip(gpio);
 
 	c->irq_mask |= GPIO_bit(gpio);
@@ -469,13 +436,6 @@ static int pxa_gpio_nums(void)
 	return count;
 }
 
-#ifdef CONFIG_OF
-static struct of_device_id pxa_gpio_dt_ids[] = {
-	{ .compatible = "mrvl,pxa-gpio" },
-	{ .compatible = "mrvl,mmp-gpio", .data = (void *)MMP_GPIO },
-	{}
-};
-
 static int pxa_irq_domain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hw)
 {
@@ -485,11 +445,18 @@ static int pxa_irq_domain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
-const struct irq_domain_ops pxa_irq_domain_ops = {
+static const struct irq_domain_ops pxa_irq_domain_ops = {
 	.map	= pxa_irq_domain_map,
 	.xlate	= irq_domain_xlate_twocell,
 };
 
+#ifdef CONFIG_OF
+static struct of_device_id pxa_gpio_dt_ids[] = {
+	{ .compatible = "mrvl,pxa-gpio" },
+	{ .compatible = "mrvl,mmp-gpio", .data = (void *)MMP_GPIO },
+	{}
+};
+
 static int pxa_gpio_probe_dt(struct platform_device *pdev)
 {
 	int ret, nr_banks, nr_gpios;
@@ -528,14 +495,6 @@ static int pxa_gpio_probe_dt(struct platform_device *pdev)
 	nr_gpios = nr_banks << 5;
 	pxa_last_gpio = nr_gpios - 1;
 
-	irq_base = irq_alloc_descs(-1, 0, nr_gpios, 0);
-	if (irq_base < 0) {
-		dev_err(&pdev->dev, "Failed to allocate IRQ numbers\n");
-		goto err;
-	}
-	domain = irq_domain_add_legacy(np, nr_gpios, irq_base, 0,
-				       &pxa_irq_domain_ops, NULL);
-	pxa_gpio_of_node = np;
 	return 0;
 err:
 	iounmap(gpio_reg_base);
@@ -545,6 +504,56 @@ err:
 #define pxa_gpio_probe_dt(pdev)		(-1)
 #endif
 
+static int pxa_init_gpio_chip(struct platform_device *pdev, int gpio_end,
+			      int (*set_wake)(unsigned int, unsigned int))
+{
+	int i, gpio, nbanks = gpio_to_bank(gpio_end) + 1;
+	struct pxa_gpio_chip *chips;
+
+	chips = devm_kzalloc(&pdev->dev, nbanks * sizeof(*chips), GFP_KERNEL);
+	if (chips == NULL) {
+		pr_err("%s: failed to allocate GPIO chips\n", __func__);
+		return -ENOMEM;
+	}
+
+	for (i = 0, gpio = 0; i < nbanks; i++, gpio += 32) {
+		struct gpio_chip *c = &chips[i].chip;
+
+		sprintf(chips[i].label, "gpio-%d", i);
+		chips[i].regbase = gpio_reg_base + BANK_OFF(i);
+		chips[i].set_wake = set_wake;
+
+		c->base  = gpio;
+		c->label = chips[i].label;
+
+		c->direction_input  = pxa_gpio_direction_input;
+		c->direction_output = pxa_gpio_direction_output;
+		c->get = pxa_gpio_get;
+		c->set = pxa_gpio_set;
+		c->to_irq = pxa_gpio_to_irq;
+#ifdef CONFIG_OF_GPIO
+		c->of_node = pxa_gpio_of_node;
+		c->of_xlate = pxa_gpio_of_xlate;
+		c->of_gpio_n_cells = 2;
+#endif
+
+		/* number of GPIOs on last bank may be less than 32 */
+		c->ngpio = (gpio + 31 > gpio_end) ? (gpio_end - gpio + 1) : 32;
+
+		chips[i].irq_base = irq_alloc_descs(-1, 0, c->ngpio, 0);
+		if (chips[i].irq_base < 0)
+			return -EINVAL;
+		if (!irq_domain_add_legacy(pdev->dev.of_node, c->ngpio,
+					   chips[i].irq_base, 0,
+					   &pxa_irq_domain_ops, &chips[i]))
+			return -ENODEV;
+
+		gpiochip_add(c);
+	}
+	pxa_gpio_chips = chips;
+	return 0;
+}
+
 static int pxa_gpio_probe(struct platform_device *pdev)
 {
 	struct pxa_gpio_chip *c;
@@ -557,14 +566,6 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 	ret = pxa_gpio_probe_dt(pdev);
 	if (ret < 0) {
 		pxa_last_gpio = pxa_gpio_nums();
-#ifdef CONFIG_ARCH_PXA
-		if (gpio_is_pxa_type(gpio_type))
-			irq_base = PXA_GPIO_TO_IRQ(0);
-#endif
-#ifdef CONFIG_ARCH_MMP
-		if (gpio_is_mmp_type(gpio_type))
-			irq_base = MMP_GPIO_TO_IRQ(0);
-#endif
 	} else {
 		use_of = 1;
 	}
@@ -604,7 +605,8 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 
 	/* Initialize GPIO chips */
 	info = dev_get_platdata(&pdev->dev);
-	pxa_init_gpio_chip(pxa_last_gpio, info ? info->gpio_set_wake : NULL);
+	pxa_init_gpio_chip(pdev, pxa_last_gpio,
+			   info ? info->gpio_set_wake : NULL);
 
 	/* clear all GPIO edge detects */
 	for_each_gpio_chip(gpio, c) {
diff --git a/include/linux/gpio-pxa.h b/include/linux/gpio-pxa.h
index bc5cae5..49120b8 100644
--- a/include/linux/gpio-pxa.h
+++ b/include/linux/gpio-pxa.h
@@ -1,6 +1,8 @@
 #ifndef __GPIO_PXA_H
 #define __GPIO_PXA_H
 
+#include <linux/irq.h>
+
 #define GPIO_bit(x)	(1 << ((x) & 0x1f))
 
 #define gpio_to_bank(gpio)	((gpio) >> 5)
@@ -11,7 +13,7 @@
  */
 extern int pxa_last_gpio;
 
-extern int pxa_irq_to_gpio(int irq);
+extern int pxa_irq_to_gpio(struct irq_data *d);
 
 struct pxa_gpio_platform_data {
 	bool ed_mask;	/* true means that ed_mask reg is available */
-- 
1.7.10.4
