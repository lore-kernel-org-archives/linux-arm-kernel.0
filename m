From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 25 Feb 2013 11:49:31 +0800
Subject: [PATCH v5 02/12] gpio: pxa: clean code with same variable name
In-Reply-To: <1361764181-26647-1-git-send-email-haojian.zhuang@linaro.org>
References: <1361764181-26647-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1361764181-26647-3-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clean code to avoid similar variable. Now use gc for gpio_chip,
and use c/chip for pxa_gpio_chip. It's used to avoid confusion.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/gpio/gpio-pxa.c |  113 +++++++++++++++++++++++------------------------
 1 file changed, 55 insertions(+), 58 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 59841b1..ad54392 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -69,20 +69,20 @@ static struct device_node *pxa_gpio_of_node;
 #endif
 
 struct pxa_gpio_chip {
-	struct gpio_chip chip;
-	void __iomem	*regbase;
-	char label[10];
+	struct gpio_chip	gc;
+	void __iomem		*regbase;
+	char			label[10];
 
-	unsigned long	irq_mask;
-	unsigned long	irq_edge_rise;
-	unsigned long	irq_edge_fall;
-	int (*set_wake)(unsigned int gpio, unsigned int on);
+	unsigned long		irq_mask;
+	unsigned long		irq_edge_rise;
+	unsigned long		irq_edge_fall;
+	int			(*set_wake)(unsigned int gpio, unsigned int on);
 
 #ifdef CONFIG_PM
-	unsigned long	saved_gplr;
-	unsigned long	saved_gpdr;
-	unsigned long	saved_grer;
-	unsigned long	saved_gfer;
+	unsigned long		saved_gplr;
+	unsigned long		saved_gpdr;
+	unsigned long		saved_grer;
+	unsigned long		saved_gfer;
 #endif
 };
 
@@ -103,9 +103,9 @@ static void __iomem *gpio_reg_base;
 #define for_each_gpio_chip(i, c)			\
 	for (i = 0, c = &pxa_gpio_chips[0]; i <= pxa_last_gpio; i += 32, c++)
 
-static inline void __iomem *gpio_chip_base(struct gpio_chip *c)
+static inline void __iomem *gpio_chip_base(struct gpio_chip *gc)
 {
-	return container_of(c, struct pxa_gpio_chip, chip)->regbase;
+	return container_of(gc, struct pxa_gpio_chip, gc)->regbase;
 }
 
 static inline struct pxa_gpio_chip *gpio_to_pxachip(unsigned gpio)
@@ -141,13 +141,13 @@ static inline int __gpio_is_inverted(int gpio)
  */
 static inline int __gpio_is_occupied(unsigned gpio)
 {
-	struct pxa_gpio_chip *pxachip;
+	struct pxa_gpio_chip *chip;
 	void __iomem *base;
 	unsigned long gafr = 0, gpdr = 0;
 	int ret, af = 0, dir = 0;
 
-	pxachip = gpio_to_pxachip(gpio);
-	base = gpio_chip_base(&pxachip->chip);
+	chip = gpio_to_pxachip(gpio);
+	base = gpio_chip_base(&chip->gc);
 	gpdr = readl_relaxed(base + GPDR_OFFSET);
 
 	switch (gpio_type) {
@@ -170,9 +170,9 @@ static inline int __gpio_is_occupied(unsigned gpio)
 	return ret;
 }
 
-static int pxa_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+static int pxa_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
 {
-	return chip->base + offset + irq_base;
+	return gc->base + offset + irq_base;
 }
 
 int pxa_irq_to_gpio(int irq)
@@ -180,16 +180,16 @@ int pxa_irq_to_gpio(int irq)
 	return irq - irq_base;
 }
 
-static int pxa_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+static int pxa_gpio_direction_input(struct gpio_chip *gc, unsigned offset)
 {
-	void __iomem *base = gpio_chip_base(chip);
+	void __iomem *base = gpio_chip_base(gc);
 	uint32_t value, mask = 1 << offset;
 	unsigned long flags;
 
 	spin_lock_irqsave(&gpio_lock, flags);
 
 	value = readl_relaxed(base + GPDR_OFFSET);
-	if (__gpio_is_inverted(chip->base + offset))
+	if (__gpio_is_inverted(gc->base + offset))
 		value |= mask;
 	else
 		value &= ~mask;
@@ -199,10 +199,10 @@ static int pxa_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 	return 0;
 }
 
-static int pxa_gpio_direction_output(struct gpio_chip *chip,
+static int pxa_gpio_direction_output(struct gpio_chip *gc,
 				     unsigned offset, int value)
 {
-	void __iomem *base = gpio_chip_base(chip);
+	void __iomem *base = gpio_chip_base(gc);
 	uint32_t tmp, mask = 1 << offset;
 	unsigned long flags;
 
@@ -211,7 +211,7 @@ static int pxa_gpio_direction_output(struct gpio_chip *chip,
 	spin_lock_irqsave(&gpio_lock, flags);
 
 	tmp = readl_relaxed(base + GPDR_OFFSET);
-	if (__gpio_is_inverted(chip->base + offset))
+	if (__gpio_is_inverted(gc->base + offset))
 		tmp &= ~mask;
 	else
 		tmp |= mask;
@@ -221,15 +221,15 @@ static int pxa_gpio_direction_output(struct gpio_chip *chip,
 	return 0;
 }
 
-static int pxa_gpio_get(struct gpio_chip *chip, unsigned offset)
+static int pxa_gpio_get(struct gpio_chip *gc, unsigned offset)
 {
-	return readl_relaxed(gpio_chip_base(chip) + GPLR_OFFSET) & (1 << offset);
+	return readl_relaxed(gpio_chip_base(gc) + GPLR_OFFSET) & (1 << offset);
 }
 
-static void pxa_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+static void pxa_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
 {
-	writel_relaxed(1 << offset, gpio_chip_base(chip) +
-				(value ? GPSR_OFFSET : GPCR_OFFSET));
+	writel_relaxed(1 << offset, gpio_chip_base(gc) +
+		       (value ? GPSR_OFFSET : GPCR_OFFSET));
 }
 
 #ifdef CONFIG_OF_GPIO
@@ -240,7 +240,7 @@ static int pxa_gpio_of_xlate(struct gpio_chip *gc,
 	if (gpiospec->args[0] > pxa_last_gpio)
 		return -EINVAL;
 
-	if (gc != &pxa_gpio_chips[gpiospec->args[0] / 32].chip)
+	if (gc != &pxa_gpio_chips[gpiospec->args[0] / 32].gc)
 		return -EINVAL;
 
 	if (flags)
@@ -250,42 +250,43 @@ static int pxa_gpio_of_xlate(struct gpio_chip *gc,
 }
 #endif
 
-static int pxa_init_gpio_chip(int gpio_end,
-					int (*set_wake)(unsigned int, unsigned int))
+static int pxa_init_gpio_chip(struct platform_device *pdev, int gpio_end)
 {
 	int i, gpio, nbanks = gpio_to_bank(gpio_end) + 1;
 	struct pxa_gpio_chip *chips;
+	struct pxa_gpio_platform_data *pdata = dev_get_platdata(&pdev->dev);
 
-	chips = kzalloc(nbanks * sizeof(struct pxa_gpio_chip), GFP_KERNEL);
-	if (chips == NULL) {
-		pr_err("%s: failed to allocate GPIO chips\n", __func__);
+	chips = devm_kzalloc(&pdev->dev, nbanks * sizeof(*chips), GFP_KERNEL);
+	if (!chips) {
+		dev_err(&pdev->dev, "failed to allocate GPIO chips\n");
 		return -ENOMEM;
 	}
 
 	for (i = 0, gpio = 0; i < nbanks; i++, gpio += 32) {
-		struct gpio_chip *c = &chips[i].chip;
+		struct gpio_chip *gc = &chips[i].gc;
 
 		sprintf(chips[i].label, "gpio-%d", i);
 		chips[i].regbase = gpio_reg_base + BANK_OFF(i);
-		chips[i].set_wake = set_wake;
+		if (pdata->gpio_set_wake)
+			chips[i].set_wake = pdata->gpio_set_wake;
 
-		c->base  = gpio;
-		c->label = chips[i].label;
+		gc->base  = gpio;
+		gc->label = chips[i].label;
 
-		c->direction_input  = pxa_gpio_direction_input;
-		c->direction_output = pxa_gpio_direction_output;
-		c->get = pxa_gpio_get;
-		c->set = pxa_gpio_set;
-		c->to_irq = pxa_gpio_to_irq;
+		gc->direction_input  = pxa_gpio_direction_input;
+		gc->direction_output = pxa_gpio_direction_output;
+		gc->get = pxa_gpio_get;
+		gc->set = pxa_gpio_set;
+		gc->to_irq = pxa_gpio_to_irq;
 #ifdef CONFIG_OF_GPIO
-		c->of_node = pxa_gpio_of_node;
-		c->of_xlate = pxa_gpio_of_xlate;
-		c->of_gpio_n_cells = 2;
+		gc->of_node = pxa_gpio_of_node;
+		gc->of_xlate = pxa_gpio_of_xlate;
+		gc->of_gpio_n_cells = 2;
 #endif
 
 		/* number of GPIOs on last bank may be less than 32 */
-		c->ngpio = (gpio + 31 > gpio_end) ? (gpio_end - gpio + 1) : 32;
-		gpiochip_add(c);
+		gc->ngpio = (gpio + 31 > gpio_end) ? (gpio_end - gpio + 1) : 32;
+		gpiochip_add(gc);
 	}
 	pxa_gpio_chips = chips;
 	return 0;
@@ -364,7 +365,7 @@ static void pxa_gpio_demux_handler(unsigned int irq, struct irq_desc *desc)
 	do {
 		loop = 0;
 		for_each_gpio_chip(gpio, c) {
-			gpio_base = c->chip.base;
+			gpio_base = c->gc.base;
 
 			gedr = readl_relaxed(c->regbase + GEDR_OFFSET);
 			gedr = gedr & c->irq_mask;
@@ -492,7 +493,7 @@ const struct irq_domain_ops pxa_irq_domain_ops = {
 
 static int pxa_gpio_probe_dt(struct platform_device *pdev)
 {
-	int ret, nr_banks, nr_gpios;
+	int nr_banks, nr_gpios;
 	struct pxa_gpio_platform_data *pdata;
 	struct device_node *prev, *next, *np = pdev->dev.of_node;
 	const struct of_device_id *of_id =
@@ -514,8 +515,7 @@ static int pxa_gpio_probe_dt(struct platform_device *pdev)
 	prev = next;
 	if (!next) {
 		dev_err(&pdev->dev, "Failed to find child gpio node\n");
-		ret = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 	for (nr_banks = 1; ; nr_banks++) {
 		next = of_get_next_child(np, prev);
@@ -530,15 +530,12 @@ static int pxa_gpio_probe_dt(struct platform_device *pdev)
 	irq_base = irq_alloc_descs(-1, 0, nr_gpios, 0);
 	if (irq_base < 0) {
 		dev_err(&pdev->dev, "Failed to allocate IRQ numbers\n");
-		goto err;
+		return -EINVAL;
 	}
 	domain = irq_domain_add_legacy(np, nr_gpios, irq_base, 0,
 				       &pxa_irq_domain_ops, NULL);
 	pxa_gpio_of_node = np;
 	return 0;
-err:
-	iounmap(gpio_reg_base);
-	return ret;
 }
 #else
 #define pxa_gpio_probe_dt(pdev)		(-1)
@@ -603,7 +600,7 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 
 	/* Initialize GPIO chips */
 	info = dev_get_platdata(&pdev->dev);
-	pxa_init_gpio_chip(pxa_last_gpio, info ? info->gpio_set_wake : NULL);
+	pxa_init_gpio_chip(pdev, pxa_last_gpio);
 
 	/* clear all GPIO edge detects */
 	for_each_gpio_chip(gpio, c) {
-- 
1.7.10.4
