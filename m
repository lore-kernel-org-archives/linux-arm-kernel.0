From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 18 Feb 2013 13:12:37 +0800
Subject: [PATCH v3 11/12] gpio: pxa: discard irq base in pxa_gpio_chip
In-Reply-To: <1361164358-5845-1-git-send-email-haojian.zhuang@linaro.org>
References: <1361164358-5845-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1361164358-5845-12-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Discard irq_base in struct pxa_gpio_chip. Use irq_domain instead.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/gpio/gpio-pxa.c |   91 +++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 47 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 35cdb23..d45cb57 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -66,8 +66,8 @@ int pxa_last_gpio;
 
 struct pxa_gpio_chip {
 	struct gpio_chip chip;
+	struct irq_domain *domain;
 	void __iomem	*regbase;
-	unsigned int	irq_base;
 	bool		inverted;
 	bool		gafr;
 	char label[10];
@@ -147,17 +147,7 @@ static int pxa_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
 	struct pxa_gpio_chip *chip = NULL;
 
 	chip = container_of(gc, struct pxa_gpio_chip, chip);
-	return chip->irq_base + offset;
-}
-
-int pxa_irq_to_gpio(struct irq_data *d)
-{
-	struct pxa_gpio_chip *chip;
-	int gpio;
-
-	chip = (struct pxa_gpio_chip *)d->domain->host_data;
-	gpio = d->irq - chip->irq_base + chip->chip.base;
-	return gpio;
+	return irq_create_mapping(chip->domain, offset);
 }
 
 static int pxa_gpio_request(struct gpio_chip *gc, unsigned offset)
@@ -270,18 +260,19 @@ static inline void update_edge_detect(struct pxa_gpio_chip *chip)
 
 static int pxa_gpio_irq_type(struct irq_data *d, unsigned int type)
 {
-	struct pxa_gpio_chip *chip;
-	int gpio = pxa_irq_to_gpio(d);
-	unsigned long gpdr, mask = GPIO_bit(gpio);
+	struct pxa_gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	int offset = irqd_to_hwirq(d);
+	int gpio;
+	unsigned long gpdr, mask;
 
-	chip = gpio_to_pxachip(gpio);
+	mask = 1 << offset;
+	gpio = chip->chip.base + offset;
 
 	if (type == IRQ_TYPE_PROBE) {
 		/* Don't mess with enabled GPIOs using preconfigured edges or
 		 * GPIOs set to alternate function or to output during probe
 		 */
-		if ((chip->irq_edge_rise | chip->irq_edge_fall)
-			& GPIO_bit(gpio))
+		if ((chip->irq_edge_rise | chip->irq_edge_fall) & mask)
 			return 0;
 
 		if (__gpio_is_occupied(chip, gpio))
@@ -318,16 +309,15 @@ static int pxa_gpio_irq_type(struct irq_data *d, unsigned int type)
 static void pxa_gpio_demux_handler(unsigned int irq, struct irq_desc *desc)
 {
 	struct pxa_gpio_chip *chip;
-	int loop, gpio, gpio_base, n;
-	unsigned long gedr;
 	struct irq_chip *ic = irq_desc_get_chip(desc);
+	int n, gpio, loop;
+	unsigned long gedr;
 
 	chained_irq_enter(ic, desc);
 
 	do {
 		loop = 0;
 		for_each_gpio_chip(gpio, chip) {
-			gpio_base = chip->chip.base;
 
 			gedr = readl_relaxed(chip->regbase + GEDR_OFFSET);
 			gedr = gedr & chip->irq_mask;
@@ -335,8 +325,8 @@ static void pxa_gpio_demux_handler(unsigned int irq, struct irq_desc *desc)
 
 			for_each_set_bit(n, &gedr, BITS_PER_LONG) {
 				loop = 1;
-
-				generic_handle_irq(gpio_to_irq(gpio_base + n));
+				generic_handle_irq(pxa_gpio_to_irq(&chip->chip,
+								   n));
 			}
 		}
 	} while (loop);
@@ -346,31 +336,35 @@ static void pxa_gpio_demux_handler(unsigned int irq, struct irq_desc *desc)
 
 static void pxa_ack_muxed_gpio(struct irq_data *d)
 {
-	int gpio = pxa_irq_to_gpio(d);
-	struct pxa_gpio_chip *chip = gpio_to_pxachip(gpio);
+	struct pxa_gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	int offset = irqd_to_hwirq(d);
 
-	writel_relaxed(GPIO_bit(gpio), chip->regbase + GEDR_OFFSET);
+	writel_relaxed(1 << offset, chip->regbase + GEDR_OFFSET);
 }
 
 static void pxa_mask_muxed_gpio(struct irq_data *d)
 {
-	int gpio = pxa_irq_to_gpio(d);
-	struct pxa_gpio_chip *chip = gpio_to_pxachip(gpio);
+	struct pxa_gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	int offset = irqd_to_hwirq(d);
+	int mask;
 	uint32_t grer, gfer;
 
-	chip->irq_mask &= ~GPIO_bit(gpio);
+	mask = 1 << offset;
+	chip->irq_mask &= ~mask;
 
-	grer = readl_relaxed(chip->regbase + GRER_OFFSET) & ~GPIO_bit(gpio);
-	gfer = readl_relaxed(chip->regbase + GFER_OFFSET) & ~GPIO_bit(gpio);
+	grer = readl_relaxed(chip->regbase + GRER_OFFSET) & ~mask;
+	gfer = readl_relaxed(chip->regbase + GFER_OFFSET) & ~mask;
 	writel_relaxed(grer, chip->regbase + GRER_OFFSET);
 	writel_relaxed(gfer, chip->regbase + GFER_OFFSET);
 }
 
 static int pxa_gpio_set_wake(struct irq_data *d, unsigned int on)
 {
-	int gpio = pxa_irq_to_gpio(d);
-	struct pxa_gpio_chip *chip = gpio_to_pxachip(gpio);
+	struct pxa_gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	int offset = irqd_to_hwirq(d);
+	int gpio;
 
+	gpio = chip->chip.base + offset;
 	if (chip->set_wake)
 		return chip->set_wake(gpio, on);
 	else
@@ -379,10 +373,10 @@ static int pxa_gpio_set_wake(struct irq_data *d, unsigned int on)
 
 static void pxa_unmask_muxed_gpio(struct irq_data *d)
 {
-	int gpio = pxa_irq_to_gpio(d);
-	struct pxa_gpio_chip *chip = gpio_to_pxachip(gpio);
+	struct pxa_gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	int offset = irqd_to_hwirq(d);
 
-	chip->irq_mask |= GPIO_bit(gpio);
+	chip->irq_mask |= 1 << offset;
 	update_edge_detect(chip);
 }
 
@@ -395,12 +389,16 @@ static struct irq_chip pxa_muxed_gpio_chip = {
 	.irq_set_wake	= pxa_gpio_set_wake,
 };
 
-static int pxa_irq_domain_map(struct irq_domain *d, unsigned int irq,
+static int pxa_irq_domain_map(struct irq_domain *d, unsigned int virq,
 			      irq_hw_number_t hw)
 {
-	irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
-				 handle_edge_irq);
-	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+	struct pxa_gpio_chip *chip = d->host_data;
+
+	irq_set_chip_and_handler_name(virq, &pxa_muxed_gpio_chip,
+				      handle_edge_irq, "gpio");
+	irq_set_chip_data(virq, chip);
+	irq_set_irq_type(virq, IRQ_TYPE_NONE);
+	set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);
 	return 0;
 }
 
@@ -483,13 +481,12 @@ static int pxa_init_gpio_chip(struct platform_device *pdev, int gpio_end,
 		if (pdata->irq_base)
 			irq_base = pdata->irq_base + gpio;
 		else
-			irq_base = -1;
-		chips[i].irq_base = irq_alloc_descs(irq_base, 0, gc->ngpio, 0);
-		if (chips[i].irq_base < 0)
-			return -EINVAL;
-		if (!irq_domain_add_legacy(pdev->dev.of_node, gc->ngpio,
-					   chips[i].irq_base, 0,
-					   &pxa_irq_domain_ops, &chips[i]))
+			irq_base = 0;
+		chips[i].domain = irq_domain_add_simple(pdev->dev.of_node,
+							gc->ngpio, irq_base,
+							&pxa_irq_domain_ops,
+							&chips[i]);
+		if (!chips[i].domain)
 			return -ENODEV;
 
 		gc->base  = gpio;
-- 
1.7.10.4
