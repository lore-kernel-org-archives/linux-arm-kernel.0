From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 15 Apr 2014 14:43:46 +0800
Subject: [PATCH 1/4] pinctrl: sirf: wrap all gpio banks into one gpio_chip
In-Reply-To: <1397544229-20545-1-git-send-email-21cnbao@gmail.com>
References: <1397544229-20545-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1397544229-20545-2-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

all gpio banks are in one chip, that makes software clean in mapping
irq and gpio.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/sirf/pinctrl-sirf.c |  217 +++++++++++++++--------------------
 1 files changed, 91 insertions(+), 126 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-sirf.c b/drivers/pinctrl/sirf/pinctrl-sirf.c
index 2c3eb20..cb81b15 100644
--- a/drivers/pinctrl/sirf/pinctrl-sirf.c
+++ b/drivers/pinctrl/sirf/pinctrl-sirf.c
@@ -34,15 +34,19 @@
 #define DRIVER_NAME "pinmux-sirf"
 
 struct sirfsoc_gpio_bank {
-	struct of_mm_gpio_chip chip;
-	struct irq_domain *domain;
 	int id;
 	int parent_irq;
 	spinlock_t lock;
+};
+
+struct sirfsoc_gpio_chip {
+	struct of_mm_gpio_chip chip;
+	struct irq_domain *domain;
 	bool is_marco; /* for marco, some registers are different with prima2 */
+	struct sirfsoc_gpio_bank sgpio_bank[SIRFSOC_GPIO_NO_OF_BANKS];
 };
 
-static struct sirfsoc_gpio_bank sgpio_bank[SIRFSOC_GPIO_NO_OF_BANKS];
+static struct sirfsoc_gpio_chip sgpio_chip;
 static DEFINE_SPINLOCK(sgpio_lock);
 
 static struct sirfsoc_pin_group *sirfsoc_pin_groups;
@@ -258,32 +262,12 @@ static struct pinctrl_desc sirfsoc_pinmux_desc = {
 /*
  * Todo: bind irq_chip to every pinctrl_gpio_range
  */
-static struct pinctrl_gpio_range sirfsoc_gpio_ranges[] = {
-	{
-		.name = "sirfsoc-gpio*",
-		.id = 0,
-		.base = 0,
-		.pin_base = 0,
-		.npins = 32,
-	}, {
-		.name = "sirfsoc-gpio*",
-		.id = 1,
-		.base = 32,
-		.pin_base = 32,
-		.npins = 32,
-	}, {
-		.name = "sirfsoc-gpio*",
-		.id = 2,
-		.base = 64,
-		.pin_base = 64,
-		.npins = 32,
-	}, {
-		.name = "sirfsoc-gpio*",
-		.id = 3,
-		.base = 96,
-		.pin_base = 96,
-		.npins = 19,
-	},
+static struct pinctrl_gpio_range sirfsoc_gpio_ranges = {
+	.name = "sirfsoc-gpio*",
+	.id = 0,
+	.base = 0,
+	.pin_base = 0,
+	.npins = SIRFSOC_GPIO_BANK_SIZE * SIRFSOC_GPIO_NO_OF_BANKS,
 };
 
 static void __iomem *sirfsoc_rsc_of_iomap(void)
@@ -303,19 +287,19 @@ static void __iomem *sirfsoc_rsc_of_iomap(void)
 }
 
 static int sirfsoc_gpio_of_xlate(struct gpio_chip *gc,
-       const struct of_phandle_args *gpiospec,
-       u32 *flags)
+	const struct of_phandle_args *gpiospec,
+	u32 *flags)
 {
-       if (gpiospec->args[0] > SIRFSOC_GPIO_NO_OF_BANKS * SIRFSOC_GPIO_BANK_SIZE)
+	if (gpiospec->args[0] > SIRFSOC_GPIO_NO_OF_BANKS * SIRFSOC_GPIO_BANK_SIZE)
 		return -EINVAL;
 
-       if (gc != &sgpio_bank[gpiospec->args[0] / SIRFSOC_GPIO_BANK_SIZE].chip.gc)
+	if (gc != &sgpio_chip.chip.gc)
 		return -EINVAL;
 
-       if (flags)
+	if (flags)
 		*flags = gpiospec->args[1];
 
-       return gpiospec->args[0] % SIRFSOC_GPIO_BANK_SIZE;
+	return gpiospec->args[0];
 }
 
 static const struct of_device_id pinmux_ids[] = {
@@ -331,7 +315,6 @@ static int sirfsoc_pinmux_probe(struct platform_device *pdev)
 	struct sirfsoc_pmx *spmx;
 	struct device_node *np = pdev->dev.of_node;
 	const struct sirfsoc_pinctrl_data *pdata;
-	int i;
 
 	/* Create state holders etc for this driver */
 	spmx = devm_kzalloc(&pdev->dev, sizeof(*spmx), GFP_KERNEL);
@@ -375,10 +358,8 @@ static int sirfsoc_pinmux_probe(struct platform_device *pdev)
 		goto out_no_pmx;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(sirfsoc_gpio_ranges); i++) {
-		sirfsoc_gpio_ranges[i].gc = &sgpio_bank[i].chip.gc;
-		pinctrl_add_gpio_range(spmx->pmx, &sirfsoc_gpio_ranges[i]);
-	}
+	sirfsoc_gpio_ranges.gc = &sgpio_chip.chip.gc;
+	pinctrl_add_gpio_range(spmx->pmx, &sirfsoc_gpio_ranges);
 
 	dev_info(&pdev->dev, "initialized SIRFSOC pinmux driver\n");
 
@@ -464,33 +445,23 @@ static int __init sirfsoc_pinmux_init(void)
 }
 arch_initcall(sirfsoc_pinmux_init);
 
-static inline int sirfsoc_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+static inline struct sirfsoc_gpio_bank *sirfsoc_gpio_to_bank(unsigned int gpio)
 {
-	struct sirfsoc_gpio_bank *bank = container_of(to_of_mm_gpio_chip(chip),
-		struct sirfsoc_gpio_bank, chip);
-
-	return irq_create_mapping(bank->domain, offset + bank->id *
-		SIRFSOC_GPIO_BANK_SIZE);
+	return &sgpio_chip.sgpio_bank[gpio / SIRFSOC_GPIO_BANK_SIZE];
 }
 
-static inline int sirfsoc_gpio_to_offset(unsigned int gpio)
+static int sirfsoc_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 {
-	return gpio % SIRFSOC_GPIO_BANK_SIZE;
+	return irq_create_mapping(sgpio_chip.domain, offset);
 }
 
-static inline struct sirfsoc_gpio_bank *sirfsoc_gpio_to_bank(unsigned int gpio)
+static inline int sirfsoc_gpio_to_bankoff(unsigned int gpio)
 {
-	return &sgpio_bank[gpio / SIRFSOC_GPIO_BANK_SIZE];
-}
-
-static inline struct sirfsoc_gpio_bank *sirfsoc_gpiochip_to_bank(struct gpio_chip *chip)
-{
-	return container_of(to_of_mm_gpio_chip(chip), struct sirfsoc_gpio_bank, chip);
+	return gpio % SIRFSOC_GPIO_BANK_SIZE;
 }
-
 static void sirfsoc_gpio_irq_ack(struct irq_data *d)
 {
-	struct sirfsoc_gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	struct sirfsoc_gpio_bank *bank = sirfsoc_gpio_to_bank(d->hwirq);
 	int idx = d->hwirq % SIRFSOC_GPIO_BANK_SIZE;
 	u32 val, offset;
 	unsigned long flags;
@@ -499,9 +470,9 @@ static void sirfsoc_gpio_irq_ack(struct irq_data *d)
 
 	spin_lock_irqsave(&sgpio_lock, flags);
 
-	val = readl(bank->chip.regs + offset);
+	val = readl(sgpio_chip.chip.regs + offset);
 
-	writel(val, bank->chip.regs + offset);
+	writel(val, sgpio_chip.chip.regs + offset);
 
 	spin_unlock_irqrestore(&sgpio_lock, flags);
 }
@@ -515,24 +486,24 @@ static void __sirfsoc_gpio_irq_mask(struct sirfsoc_gpio_bank *bank, int idx)
 
 	spin_lock_irqsave(&sgpio_lock, flags);
 
-	val = readl(bank->chip.regs + offset);
+	val = readl(sgpio_chip.chip.regs + offset);
 	val &= ~SIRFSOC_GPIO_CTL_INTR_EN_MASK;
 	val &= ~SIRFSOC_GPIO_CTL_INTR_STS_MASK;
-	writel(val, bank->chip.regs + offset);
+	writel(val, sgpio_chip.chip.regs + offset);
 
 	spin_unlock_irqrestore(&sgpio_lock, flags);
 }
 
 static void sirfsoc_gpio_irq_mask(struct irq_data *d)
 {
-	struct sirfsoc_gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	struct sirfsoc_gpio_bank *bank = sirfsoc_gpio_to_bank(d->hwirq);
 
 	__sirfsoc_gpio_irq_mask(bank, d->hwirq % SIRFSOC_GPIO_BANK_SIZE);
 }
 
 static void sirfsoc_gpio_irq_unmask(struct irq_data *d)
 {
-	struct sirfsoc_gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	struct sirfsoc_gpio_bank *bank = sirfsoc_gpio_to_bank(d->hwirq);
 	int idx = d->hwirq % SIRFSOC_GPIO_BANK_SIZE;
 	u32 val, offset;
 	unsigned long flags;
@@ -541,17 +512,17 @@ static void sirfsoc_gpio_irq_unmask(struct irq_data *d)
 
 	spin_lock_irqsave(&sgpio_lock, flags);
 
-	val = readl(bank->chip.regs + offset);
+	val = readl(sgpio_chip.chip.regs + offset);
 	val &= ~SIRFSOC_GPIO_CTL_INTR_STS_MASK;
 	val |= SIRFSOC_GPIO_CTL_INTR_EN_MASK;
-	writel(val, bank->chip.regs + offset);
+	writel(val, sgpio_chip.chip.regs + offset);
 
 	spin_unlock_irqrestore(&sgpio_lock, flags);
 }
 
 static int sirfsoc_gpio_irq_type(struct irq_data *d, unsigned type)
 {
-	struct sirfsoc_gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	struct sirfsoc_gpio_bank *bank = sirfsoc_gpio_to_bank(d->hwirq);
 	int idx = d->hwirq % SIRFSOC_GPIO_BANK_SIZE;
 	u32 val, offset;
 	unsigned long flags;
@@ -560,7 +531,7 @@ static int sirfsoc_gpio_irq_type(struct irq_data *d, unsigned type)
 
 	spin_lock_irqsave(&sgpio_lock, flags);
 
-	val = readl(bank->chip.regs + offset);
+	val = readl(sgpio_chip.chip.regs + offset);
 	val &= ~(SIRFSOC_GPIO_CTL_INTR_STS_MASK | SIRFSOC_GPIO_CTL_OUT_EN_MASK);
 
 	switch (type) {
@@ -588,7 +559,7 @@ static int sirfsoc_gpio_irq_type(struct irq_data *d, unsigned type)
 		break;
 	}
 
-	writel(val, bank->chip.regs + offset);
+	writel(val, sgpio_chip.chip.regs + offset);
 
 	spin_unlock_irqrestore(&sgpio_lock, flags);
 
@@ -597,10 +568,8 @@ static int sirfsoc_gpio_irq_type(struct irq_data *d, unsigned type)
 
 static int sirfsoc_gpio_irq_reqres(struct irq_data *d)
 {
-	struct sirfsoc_gpio_bank *bank = irq_data_get_irq_chip_data(d);
-
-	if (gpio_lock_as_irq(&bank->chip.gc, d->hwirq % SIRFSOC_GPIO_BANK_SIZE)) {
-		dev_err(bank->chip.gc.dev,
+	if (gpio_lock_as_irq(&sgpio_chip.chip.gc, d->hwirq)) {
+		dev_err(sgpio_chip.chip.gc.dev,
 			"unable to lock HW IRQ %lu for IRQ\n",
 			d->hwirq);
 		return -EINVAL;
@@ -610,9 +579,7 @@ static int sirfsoc_gpio_irq_reqres(struct irq_data *d)
 
 static void sirfsoc_gpio_irq_relres(struct irq_data *d)
 {
-	struct sirfsoc_gpio_bank *bank = irq_data_get_irq_chip_data(d);
-
-	gpio_unlock_as_irq(&bank->chip.gc, d->hwirq % SIRFSOC_GPIO_BANK_SIZE);
+	gpio_unlock_as_irq(&sgpio_chip.chip.gc, d->hwirq);
 }
 
 static struct irq_chip sirfsoc_irq_chip = {
@@ -634,7 +601,7 @@ static void sirfsoc_gpio_handle_irq(unsigned int irq, struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 
-	status = readl(bank->chip.regs + SIRFSOC_GPIO_INT_STATUS(bank->id));
+	status = readl(sgpio_chip.chip.regs + SIRFSOC_GPIO_INT_STATUS(bank->id));
 	if (!status) {
 		printk(KERN_WARNING
 			"%s: gpio id %d status %#x no interrupt is flaged\n",
@@ -644,7 +611,7 @@ static void sirfsoc_gpio_handle_irq(unsigned int irq, struct irq_desc *desc)
 	}
 
 	while (status) {
-		ctrl = readl(bank->chip.regs + SIRFSOC_GPIO_CTRL(bank->id, idx));
+		ctrl = readl(sgpio_chip.chip.regs + SIRFSOC_GPIO_CTRL(bank->id, idx));
 
 		/*
 		 * Here we must check whether the corresponding GPIO's interrupt
@@ -653,7 +620,7 @@ static void sirfsoc_gpio_handle_irq(unsigned int irq, struct irq_desc *desc)
 		if ((status & 0x1) && (ctrl & SIRFSOC_GPIO_CTL_INTR_EN_MASK)) {
 			pr_debug("%s: gpio id %d idx %d happens\n",
 				__func__, bank->id, idx);
-			generic_handle_irq(irq_find_mapping(bank->domain, idx +
+			generic_handle_irq(irq_find_mapping(sgpio_chip.domain, idx +
 					bank->id * SIRFSOC_GPIO_BANK_SIZE));
 		}
 
@@ -668,14 +635,14 @@ static inline void sirfsoc_gpio_set_input(struct sirfsoc_gpio_bank *bank, unsign
 {
 	u32 val;
 
-	val = readl(bank->chip.regs + ctrl_offset);
+	val = readl(sgpio_chip.chip.regs + ctrl_offset);
 	val &= ~SIRFSOC_GPIO_CTL_OUT_EN_MASK;
-	writel(val, bank->chip.regs + ctrl_offset);
+	writel(val, sgpio_chip.chip.regs + ctrl_offset);
 }
 
 static int sirfsoc_gpio_request(struct gpio_chip *chip, unsigned offset)
 {
-	struct sirfsoc_gpio_bank *bank = sirfsoc_gpiochip_to_bank(chip);
+	struct sirfsoc_gpio_bank *bank = sirfsoc_gpio_to_bank(offset);
 	unsigned long flags;
 
 	if (pinctrl_request_gpio(chip->base + offset))
@@ -697,7 +664,7 @@ static int sirfsoc_gpio_request(struct gpio_chip *chip, unsigned offset)
 
 static void sirfsoc_gpio_free(struct gpio_chip *chip, unsigned offset)
 {
-	struct sirfsoc_gpio_bank *bank = sirfsoc_gpiochip_to_bank(chip);
+	struct sirfsoc_gpio_bank *bank = sirfsoc_gpio_to_bank(offset);
 	unsigned long flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
@@ -712,8 +679,8 @@ static void sirfsoc_gpio_free(struct gpio_chip *chip, unsigned offset)
 
 static int sirfsoc_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 {
-	struct sirfsoc_gpio_bank *bank = sirfsoc_gpiochip_to_bank(chip);
-	int idx = sirfsoc_gpio_to_offset(gpio);
+	struct sirfsoc_gpio_bank *bank = sirfsoc_gpio_to_bank(gpio);
+	int idx = sirfsoc_gpio_to_bankoff(gpio);
 	unsigned long flags;
 	unsigned offset;
 
@@ -736,7 +703,7 @@ static inline void sirfsoc_gpio_set_output(struct sirfsoc_gpio_bank *bank, unsig
 
 	spin_lock_irqsave(&bank->lock, flags);
 
-	out_ctrl = readl(bank->chip.regs + offset);
+	out_ctrl = readl(sgpio_chip.chip.regs + offset);
 	if (value)
 		out_ctrl |= SIRFSOC_GPIO_CTL_DATAOUT_MASK;
 	else
@@ -744,15 +711,15 @@ static inline void sirfsoc_gpio_set_output(struct sirfsoc_gpio_bank *bank, unsig
 
 	out_ctrl &= ~SIRFSOC_GPIO_CTL_INTR_EN_MASK;
 	out_ctrl |= SIRFSOC_GPIO_CTL_OUT_EN_MASK;
-	writel(out_ctrl, bank->chip.regs + offset);
+	writel(out_ctrl, sgpio_chip.chip.regs + offset);
 
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
 static int sirfsoc_gpio_direction_output(struct gpio_chip *chip, unsigned gpio, int value)
 {
-	struct sirfsoc_gpio_bank *bank = sirfsoc_gpiochip_to_bank(chip);
-	int idx = sirfsoc_gpio_to_offset(gpio);
+	struct sirfsoc_gpio_bank *bank = sirfsoc_gpio_to_bank(gpio);
+	int idx = sirfsoc_gpio_to_bankoff(gpio);
 	u32 offset;
 	unsigned long flags;
 
@@ -769,13 +736,13 @@ static int sirfsoc_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
 
 static int sirfsoc_gpio_get_value(struct gpio_chip *chip, unsigned offset)
 {
-	struct sirfsoc_gpio_bank *bank = sirfsoc_gpiochip_to_bank(chip);
+	struct sirfsoc_gpio_bank *bank = sirfsoc_gpio_to_bank(offset);
 	u32 val;
 	unsigned long flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
 
-	val = readl(bank->chip.regs + SIRFSOC_GPIO_CTRL(bank->id, offset));
+	val = readl(sgpio_chip.chip.regs + SIRFSOC_GPIO_CTRL(bank->id, offset));
 
 	spin_unlock_irqrestore(&bank->lock, flags);
 
@@ -785,18 +752,18 @@ static int sirfsoc_gpio_get_value(struct gpio_chip *chip, unsigned offset)
 static void sirfsoc_gpio_set_value(struct gpio_chip *chip, unsigned offset,
 	int value)
 {
-	struct sirfsoc_gpio_bank *bank = sirfsoc_gpiochip_to_bank(chip);
+	struct sirfsoc_gpio_bank *bank = sirfsoc_gpio_to_bank(offset);
 	u32 ctrl;
 	unsigned long flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
 
-	ctrl = readl(bank->chip.regs + SIRFSOC_GPIO_CTRL(bank->id, offset));
+	ctrl = readl(sgpio_chip.chip.regs + SIRFSOC_GPIO_CTRL(bank->id, offset));
 	if (value)
 		ctrl |= SIRFSOC_GPIO_CTL_DATAOUT_MASK;
 	else
 		ctrl &= ~SIRFSOC_GPIO_CTL_DATAOUT_MASK;
-	writel(ctrl, bank->chip.regs + SIRFSOC_GPIO_CTRL(bank->id, offset));
+	writel(ctrl, sgpio_chip.chip.regs + SIRFSOC_GPIO_CTRL(bank->id, offset));
 
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
@@ -811,7 +778,6 @@ static int sirfsoc_gpio_irq_map(struct irq_domain *d, unsigned int irq,
 
 	irq_set_chip(irq, &sirfsoc_irq_chip);
 	irq_set_handler(irq, handle_level_irq);
-	irq_set_chip_data(irq, bank + hwirq / SIRFSOC_GPIO_BANK_SIZE);
 	set_irq_flags(irq, IRQF_VALID);
 
 	return 0;
@@ -830,10 +796,10 @@ static void sirfsoc_gpio_set_pullup(const u32 *pullups)
 	for (i = 0; i < SIRFSOC_GPIO_NO_OF_BANKS; i++) {
 		for_each_set_bit(n, p + i, BITS_PER_LONG) {
 			u32 offset = SIRFSOC_GPIO_CTRL(i, n);
-			u32 val = readl(sgpio_bank[i].chip.regs + offset);
+			u32 val = readl(sgpio_chip.chip.regs + offset);
 			val |= SIRFSOC_GPIO_CTL_PULL_MASK;
 			val |= SIRFSOC_GPIO_CTL_PULL_HIGH;
-			writel(val, sgpio_bank[i].chip.regs + offset);
+			writel(val, sgpio_chip.chip.regs + offset);
 		}
 	}
 }
@@ -846,10 +812,10 @@ static void sirfsoc_gpio_set_pulldown(const u32 *pulldowns)
 	for (i = 0; i < SIRFSOC_GPIO_NO_OF_BANKS; i++) {
 		for_each_set_bit(n, p + i, BITS_PER_LONG) {
 			u32 offset = SIRFSOC_GPIO_CTRL(i, n);
-			u32 val = readl(sgpio_bank[i].chip.regs + offset);
+			u32 val = readl(sgpio_chip.chip.regs + offset);
 			val |= SIRFSOC_GPIO_CTL_PULL_MASK;
 			val &= ~SIRFSOC_GPIO_CTL_PULL_HIGH;
-			writel(val, sgpio_bank[i].chip.regs + offset);
+			writel(val, sgpio_chip.chip.regs + offset);
 		}
 	}
 }
@@ -877,48 +843,47 @@ static int sirfsoc_gpio_probe(struct device_node *np)
 		is_marco = 1;
 
 	domain = irq_domain_add_linear(np, SIRFSOC_GPIO_BANK_SIZE * SIRFSOC_GPIO_NO_OF_BANKS,
-		&sirfsoc_gpio_irq_simple_ops, sgpio_bank);
+		&sirfsoc_gpio_irq_simple_ops, &sgpio_chip);
 	if (!domain) {
 		pr_err("%s: Failed to create irqdomain\n", np->full_name);
 			err = -ENOSYS;
 		goto out;
 	}
 
+	sgpio_chip.chip.gc.request = sirfsoc_gpio_request;
+	sgpio_chip.chip.gc.free = sirfsoc_gpio_free;
+	sgpio_chip.chip.gc.direction_input = sirfsoc_gpio_direction_input;
+	sgpio_chip.chip.gc.get = sirfsoc_gpio_get_value;
+	sgpio_chip.chip.gc.direction_output = sirfsoc_gpio_direction_output;
+	sgpio_chip.chip.gc.set = sirfsoc_gpio_set_value;
+	sgpio_chip.chip.gc.to_irq = sirfsoc_gpio_to_irq;
+	sgpio_chip.chip.gc.base = 0;
+	sgpio_chip.chip.gc.ngpio = SIRFSOC_GPIO_BANK_SIZE * SIRFSOC_GPIO_NO_OF_BANKS;
+	sgpio_chip.chip.gc.label = kstrdup(np->full_name, GFP_KERNEL);
+	sgpio_chip.chip.gc.of_node = np;
+	sgpio_chip.chip.gc.of_xlate = sirfsoc_gpio_of_xlate;
+	sgpio_chip.chip.gc.of_gpio_n_cells = 2;
+	sgpio_chip.chip.gc.dev = &pdev->dev;
+	sgpio_chip.chip.regs = regs;
+	sgpio_chip.is_marco = is_marco;
+	sgpio_chip.domain = domain;
+
+	err = gpiochip_add(&sgpio_chip.chip.gc);
+	if (err) {
+		pr_err("%s: error in probe function with status %d\n",
+			np->full_name, err);
+		goto out;
+	}
+
 	for (i = 0; i < SIRFSOC_GPIO_NO_OF_BANKS; i++) {
-		bank = &sgpio_bank[i];
+		bank = &sgpio_chip.sgpio_bank[i];
 		spin_lock_init(&bank->lock);
-		bank->chip.gc.request = sirfsoc_gpio_request;
-		bank->chip.gc.free = sirfsoc_gpio_free;
-		bank->chip.gc.direction_input = sirfsoc_gpio_direction_input;
-		bank->chip.gc.get = sirfsoc_gpio_get_value;
-		bank->chip.gc.direction_output = sirfsoc_gpio_direction_output;
-		bank->chip.gc.set = sirfsoc_gpio_set_value;
-		bank->chip.gc.to_irq = sirfsoc_gpio_to_irq;
-		bank->chip.gc.base = i * SIRFSOC_GPIO_BANK_SIZE;
-		bank->chip.gc.ngpio = SIRFSOC_GPIO_BANK_SIZE;
-		bank->chip.gc.label = kstrdup(np->full_name, GFP_KERNEL);
-		bank->chip.gc.of_node = np;
-		bank->chip.gc.of_xlate = sirfsoc_gpio_of_xlate;
-		bank->chip.gc.of_gpio_n_cells = 2;
-		bank->chip.gc.dev = &pdev->dev;
-		bank->chip.regs = regs;
-		bank->id = i;
-		bank->is_marco = is_marco;
 		bank->parent_irq = platform_get_irq(pdev, i);
 		if (bank->parent_irq < 0) {
 			err = bank->parent_irq;
 			goto out;
 		}
 
-		err = gpiochip_add(&bank->chip.gc);
-		if (err) {
-			pr_err("%s: error in probe function with status %d\n",
-				np->full_name, err);
-			goto out;
-		}
-
-		bank->domain = domain;
-
 		irq_set_chained_handler(bank->parent_irq, sirfsoc_gpio_handle_irq);
 		irq_set_handler_data(bank->parent_irq, bank);
 	}
-- 
1.7.5.4
