From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 08 Oct 2012 10:39:12 +0200
Subject: [PATCH 12/16] pinctrl: samsung: Use per-bank IRQ domain for wake-up
 interrupts
In-Reply-To: <1349685556-23718-1-git-send-email-t.figa@samsung.com>
References: <1349685556-23718-1-git-send-email-t.figa@samsung.com>
Message-ID: <1349685556-23718-13-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch reworks wake-up interrupt handling in pinctrl-exynos driver,
so each pin bank, which provides wake-up interrupts, has its own IRQ
domain.

Information about whether given pin bank provides wake-up interrupts,
how many and whether they are separate or muxed are parsed from device
tree.

It gives following advantages:
  - interrupts can be specified in device tree in a more readable way,
    e.g. :
    	device {
		/* ... */
		interrupt-parent = <&gpx2>;
		interrupts = <4 0>;
		/* ... */
	};
  - the amount and layout of interrupts is not hardcoded in the driver
    anymore
  - bank and pin of each wake-up interrupt can be easily identified, to
    allow operations, such as setting the pin to EINT function, from
    irq_set_type() callback

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/pinctrl/pinctrl-exynos.c  | 159 +++++++++++++++++++++++---------------
 drivers/pinctrl/pinctrl-exynos.h  |  17 +++-
 drivers/pinctrl/pinctrl-samsung.c |   9 ++-
 drivers/pinctrl/pinctrl-samsung.h |   6 +-
 4 files changed, 119 insertions(+), 72 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-exynos.c b/drivers/pinctrl/pinctrl-exynos.c
index 53ed5d9..fa6a5be 100644
--- a/drivers/pinctrl/pinctrl-exynos.c
+++ b/drivers/pinctrl/pinctrl-exynos.c
@@ -218,46 +218,43 @@ static int exynos_eint_gpio_init(struct samsung_pinctrl_drv_data *d)
 
 static void exynos_wkup_irq_unmask(struct irq_data *irqd)
 {
-	struct samsung_pinctrl_drv_data *d = irq_data_get_irq_chip_data(irqd);
-	unsigned int bank = irqd->hwirq / EXYNOS_EINT_MAX_PER_BANK;
-	unsigned int pin = irqd->hwirq & (EXYNOS_EINT_MAX_PER_BANK - 1);
-	unsigned long reg_mask = d->ctrl->weint_mask + (bank << 2);
+	struct samsung_pin_bank *b = irq_data_get_irq_chip_data(irqd);
+	struct samsung_pinctrl_drv_data *d = b->drvdata;
+	unsigned long reg_mask = d->ctrl->weint_mask + b->eint_offset;
 	unsigned long mask;
 
 	mask = readl(d->virt_base + reg_mask);
-	mask &= ~(1 << pin);
+	mask &= ~(1 << irqd->hwirq);
 	writel(mask, d->virt_base + reg_mask);
 }
 
 static void exynos_wkup_irq_mask(struct irq_data *irqd)
 {
-	struct samsung_pinctrl_drv_data *d = irq_data_get_irq_chip_data(irqd);
-	unsigned int bank = irqd->hwirq / EXYNOS_EINT_MAX_PER_BANK;
-	unsigned int pin = irqd->hwirq & (EXYNOS_EINT_MAX_PER_BANK - 1);
-	unsigned long reg_mask = d->ctrl->weint_mask + (bank << 2);
+	struct samsung_pin_bank *b = irq_data_get_irq_chip_data(irqd);
+	struct samsung_pinctrl_drv_data *d = b->drvdata;
+	unsigned long reg_mask = d->ctrl->weint_mask + b->eint_offset;
 	unsigned long mask;
 
 	mask = readl(d->virt_base + reg_mask);
-	mask |= 1 << pin;
+	mask |= 1 << irqd->hwirq;
 	writel(mask, d->virt_base + reg_mask);
 }
 
 static void exynos_wkup_irq_ack(struct irq_data *irqd)
 {
-	struct samsung_pinctrl_drv_data *d = irq_data_get_irq_chip_data(irqd);
-	unsigned int bank = irqd->hwirq / EXYNOS_EINT_MAX_PER_BANK;
-	unsigned int pin = irqd->hwirq & (EXYNOS_EINT_MAX_PER_BANK - 1);
-	unsigned long pend = d->ctrl->weint_pend + (bank << 2);
+	struct samsung_pin_bank *b = irq_data_get_irq_chip_data(irqd);
+	struct samsung_pinctrl_drv_data *d = b->drvdata;
+	unsigned long pend = d->ctrl->weint_pend + b->eint_offset;
 
-	writel(1 << pin, d->virt_base + pend);
+	writel(1 << irqd->hwirq, d->virt_base + pend);
 }
 
 static int exynos_wkup_irq_set_type(struct irq_data *irqd, unsigned int type)
 {
-	struct samsung_pinctrl_drv_data *d = irq_data_get_irq_chip_data(irqd);
-	unsigned int bank = irqd->hwirq / EXYNOS_EINT_MAX_PER_BANK;
-	unsigned int pin = irqd->hwirq & (EXYNOS_EINT_MAX_PER_BANK - 1);
-	unsigned long reg_con = d->ctrl->weint_con + (bank << 2);
+	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
+	struct samsung_pinctrl_drv_data *d = bank->drvdata;
+	unsigned int pin = irqd->hwirq;
+	unsigned long reg_con = d->ctrl->weint_con + bank->eint_offset;
 	unsigned long shift = EXYNOS_EINT_CON_LEN * pin;
 	unsigned long con, trig_type;
 
@@ -309,6 +306,7 @@ static struct irq_chip exynos_wkup_irq_chip = {
 static void exynos_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
 {
 	struct exynos_weint_data *eintd = irq_get_handler_data(irq);
+	struct samsung_pin_bank *bank = eintd->bank;
 	struct irq_chip *chip = irq_get_chip(irq);
 	int eint_irq;
 
@@ -318,20 +316,20 @@ static void exynos_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
 	if (chip->irq_ack)
 		chip->irq_ack(&desc->irq_data);
 
-	eint_irq = irq_linear_revmap(eintd->domain, eintd->irq);
+	eint_irq = irq_linear_revmap(bank->irq_domain, eintd->irq);
 	generic_handle_irq(eint_irq);
 	chip->irq_unmask(&desc->irq_data);
 	chained_irq_exit(chip, desc);
 }
 
-static inline void exynos_irq_demux_eint(int irq_base, unsigned long pend,
-					struct irq_domain *domain)
+static inline void exynos_irq_demux_eint(unsigned long pend,
+						struct irq_domain *domain)
 {
 	unsigned int irq;
 
 	while (pend) {
 		irq = fls(pend) - 1;
-		generic_handle_irq(irq_find_mapping(domain, irq_base + irq));
+		generic_handle_irq(irq_find_mapping(domain, irq));
 		pend &= ~(1 << irq);
 	}
 }
@@ -340,18 +338,22 @@ static inline void exynos_irq_demux_eint(int irq_base, unsigned long pend,
 static void exynos_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_get_chip(irq);
-	struct exynos_weint_data *eintd = irq_get_handler_data(irq);
-	struct samsung_pinctrl_drv_data *d = eintd->domain->host_data;
+	struct exynos_muxed_weint_data *eintd = irq_get_handler_data(irq);
+	struct samsung_pinctrl_drv_data *d = eintd->banks[0]->drvdata;
+	struct samsung_pin_ctrl *ctrl = d->ctrl;
 	unsigned long pend;
 	unsigned long mask;
+	int i;
 
 	chained_irq_enter(chip, desc);
-	pend = readl(d->virt_base + d->ctrl->weint_pend + 0x8);
-	mask = readl(d->virt_base + d->ctrl->weint_mask + 0x8);
-	exynos_irq_demux_eint(16, pend & ~mask, eintd->domain);
-	pend = readl(d->virt_base + d->ctrl->weint_pend + 0xC);
-	mask = readl(d->virt_base + d->ctrl->weint_mask + 0xC);
-	exynos_irq_demux_eint(24, pend & ~mask, eintd->domain);
+
+	for (i = 0; i < eintd->nr_banks; ++i) {
+		struct samsung_pin_bank *b = eintd->banks[i];
+		pend = readl(d->virt_base + ctrl->weint_pend + b->eint_offset);
+		mask = readl(d->virt_base + ctrl->weint_mask + b->eint_offset);
+		exynos_irq_demux_eint(pend & ~mask, b->irq_domain);
+	}
+
 	chained_irq_exit(chip, desc);
 }
 
@@ -381,7 +383,11 @@ static int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 	struct device *dev = d->dev;
 	struct device_node *wkup_np = NULL;
 	struct device_node *np;
+	struct samsung_pin_bank *bank;
 	struct exynos_weint_data *weint_data;
+	struct exynos_muxed_weint_data *muxed_data;
+	unsigned int muxed_banks = 0;
+	unsigned int i;
 	int idx, irq;
 	u32 val;
 	int ret;
@@ -395,11 +401,6 @@ static int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 	if (!wkup_np)
 		return -ENODEV;
 
-	ret = of_property_read_u32(wkup_np, "samsung,weint-count", &val);
-	if (ret)
-		return -EINVAL;
-	d->ctrl->nr_wint = val;
-
 	ret = of_property_read_u32(wkup_np, "samsung,weint-con", &val);
 	if (ret)
 		return -EINVAL;
@@ -415,40 +416,74 @@ static int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 		return -EINVAL;
 	d->ctrl->weint_pend = val;
 
-	d->wkup_irqd = irq_domain_add_linear(wkup_np, d->ctrl->nr_wint,
-				&exynos_wkup_irqd_ops, d);
-	if (!d->wkup_irqd) {
-		dev_err(dev, "wakeup irq domain allocation failed\n");
-		return -ENXIO;
-	}
+	bank = d->ctrl->pin_banks;
+	for (i = 0; i < d->ctrl->nr_banks; ++i, ++bank) {
+		if (bank->eint_type != EINT_TYPE_WKUP)
+			continue;
 
-	weint_data = devm_kzalloc(dev, sizeof(*weint_data) * 17, GFP_KERNEL);
-	if (!weint_data) {
-		dev_err(dev, "could not allocate memory for weint_data\n");
-		return -ENOMEM;
-	}
+		bank->irq_domain = irq_domain_add_linear(bank->of_node,
+				bank->nr_pins, &exynos_wkup_irqd_ops, bank);
+		if (!bank->irq_domain) {
+			dev_err(dev, "wkup irq domain add failed\n");
+			return -ENXIO;
+		}
 
-	irq = irq_of_parse_and_map(wkup_np, 16);
-	if (irq) {
-		weint_data[16].domain = d->wkup_irqd;
-		irq_set_chained_handler(irq, exynos_irq_demux_eint16_31);
-		irq_set_handler_data(irq, &weint_data[16]);
-	} else {
-		dev_err(dev, "irq number for EINT16-32 not found\n");
-	}
+		if (!of_find_property(bank->of_node, "interrupts", NULL)) {
+			bank->eint_type = EINT_TYPE_WKUP_MUX;
+			++muxed_banks;
+			continue;
+		}
 
-	for (idx = 0; idx < 16; idx++) {
-		weint_data[idx].domain = d->wkup_irqd;
-		weint_data[idx].irq = idx;
+		weint_data = devm_kzalloc(dev, bank->nr_pins
+					* sizeof(*weint_data), GFP_KERNEL);
+		if (!weint_data) {
+			dev_err(dev, "could not allocate memory for weint_data\n");
+			return -ENOMEM;
+		}
 
-		irq = irq_of_parse_and_map(wkup_np, idx);
-		if (irq) {
+		for (idx = 0; idx < bank->nr_pins; ++idx) {
+			irq = irq_of_parse_and_map(bank->of_node, idx);
+			if (!irq) {
+				dev_err(dev, "irq number for eint-%s-%d not found\n",
+							bank->name, idx);
+				continue;
+			}
+			weint_data[idx].irq = idx;
+			weint_data[idx].bank = bank;
 			irq_set_handler_data(irq, &weint_data[idx]);
 			irq_set_chained_handler(irq, exynos_irq_eint0_15);
-		} else {
-			dev_err(dev, "irq number for eint-%x not found\n", idx);
 		}
 	}
+
+	if (!muxed_banks)
+		return 0;
+
+	irq = irq_of_parse_and_map(wkup_np, 0);
+	if (!irq) {
+		dev_err(dev, "irq number for muxed EINTs not found\n");
+		return 0;
+	}
+
+	muxed_data = devm_kzalloc(dev, sizeof(*muxed_data)
+		+ muxed_banks*sizeof(struct samsung_pin_bank *), GFP_KERNEL);
+	if (!muxed_data) {
+		dev_err(dev, "could not allocate memory for muxed_data\n");
+		return -ENOMEM;
+	}
+
+	irq_set_chained_handler(irq, exynos_irq_demux_eint16_31);
+	irq_set_handler_data(irq, muxed_data);
+
+	bank = d->ctrl->pin_banks;
+	idx = 0;
+	for (i = 0; i < d->ctrl->nr_banks; ++i, ++bank) {
+		if (bank->eint_type != EINT_TYPE_WKUP_MUX)
+			continue;
+
+		muxed_data->banks[idx++] = bank;
+	}
+	muxed_data->nr_banks = muxed_banks;
+
 	return 0;
 }
 
diff --git a/drivers/pinctrl/pinctrl-exynos.h b/drivers/pinctrl/pinctrl-exynos.h
index 30aca2b..a94d6fc 100644
--- a/drivers/pinctrl/pinctrl-exynos.h
+++ b/drivers/pinctrl/pinctrl-exynos.h
@@ -40,10 +40,21 @@
 /**
  * struct exynos_weint_data: irq specific data for all the wakeup interrupts
  * generated by the external wakeup interrupt controller.
- * @domain: irq domain representing the external wakeup interrupts
  * @irq: interrupt number within the domain.
+ * @bank: bank responsible for this interrupt
  */
 struct exynos_weint_data {
-	struct irq_domain	*domain;
-	u32			irq;
+	unsigned int irq;
+	struct samsung_pin_bank *bank;
+};
+
+/**
+ * struct exynos_muxed_weint_data: irq specific data for muxed wakeup interrupts
+ * generated by the external wakeup interrupt controller.
+ * @nr_banks: count of banks being part of the mux
+ * @banks: array of banks being part of the mux
+ */
+struct exynos_muxed_weint_data {
+	unsigned int nr_banks;
+	struct samsung_pin_bank *banks[];
 };
diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
index 4ffd14c..215a7e5 100644
--- a/drivers/pinctrl/pinctrl-samsung.c
+++ b/drivers/pinctrl/pinctrl-samsung.c
@@ -615,10 +615,10 @@ static int __init samsung_pinctrl_parse_dt(struct platform_device *pdev,
 	 */
 	for_each_child_of_node(dev_np, cfg_np) {
 		u32 function;
-		if (of_find_property(cfg_np, "interrupt-controller", NULL))
-			continue;
 		if (of_find_property(cfg_np, "gpio-controller", NULL))
 			continue;
+		if (of_find_property(cfg_np, "compatible", NULL))
+			continue;
 
 		ret = samsung_pinctrl_parse_dt_pins(pdev, cfg_np,
 					&drvdata->pctl,	&pin_list, &npins);
@@ -894,7 +894,10 @@ static int samsung_pinctrl_parse_dt_bank(struct samsung_pin_bank *bank,
 		return 0;
 	}
 
-	bank->eint_type = EINT_TYPE_GPIO;
+	if (of_find_property(np, "samsung,wkup-eint", NULL))
+		bank->eint_type = EINT_TYPE_WKUP;
+	else
+		bank->eint_type = EINT_TYPE_GPIO;
 
 	ret = of_property_read_u32(np, "samsung,eint-offset", &val);
 	if (ret)
diff --git a/drivers/pinctrl/pinctrl-samsung.h b/drivers/pinctrl/pinctrl-samsung.h
index f27b1e0..355f4e2 100644
--- a/drivers/pinctrl/pinctrl-samsung.h
+++ b/drivers/pinctrl/pinctrl-samsung.h
@@ -66,6 +66,7 @@ enum pincfg_type {
  * @EINT_TYPE_NONE: bank does not support external interrupts
  * @EINT_TYPE_GPIO: bank supportes external gpio interrupts
  * @EINT_TYPE_WKUP: bank supportes external wakeup interrupts
+ * @EINT_TYPE_WKUP_MUX: bank supports multiplexed external wakeup interrupts
  *
  * Samsung GPIO controller groups all the available pins into banks. The pins
  * in a pin bank can support external gpio interrupts or external wakeup
@@ -78,6 +79,7 @@ enum eint_type {
 	EINT_TYPE_NONE,
 	EINT_TYPE_GPIO,
 	EINT_TYPE_WKUP,
+	EINT_TYPE_WKUP_MUX,
 };
 
 /* maximum length of a pin in pin descriptor (example: "gpa0-0") */
@@ -157,7 +159,6 @@ struct samsung_pin_ctrl_variant {
  * @nr_banks: number of pin banks.
  * @base: starting system wide pin number.
  * @nr_pins: number of pins supported by the controller.
- * @nr_wint: number of external wakeup interrupts supported.
  * @geint_con: offset of the ext-gpio controller registers.
  * @geint_mask: offset of the ext-gpio interrupt mask registers.
  * @geint_pend: offset of the ext-gpio interrupt pending registers.
@@ -177,7 +178,6 @@ struct samsung_pin_ctrl {
 
 	u32		base;
 	u32		nr_pins;
-	u32		nr_wint;
 
 	u32		geint_con;
 	u32		geint_mask;
@@ -220,8 +220,6 @@ struct samsung_pinctrl_drv_data {
 	unsigned int			nr_groups;
 	const struct samsung_pmx_func	*pmx_functions;
 	unsigned int			nr_functions;
-
-	struct irq_domain		*wkup_irqd;
 };
 
 /**
-- 
1.7.12
