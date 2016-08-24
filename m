From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 24 Aug 2016 22:49:07 +0900
Subject: [PATCH v2 3/7] pinctrl: samsung: Add the support the multiple
 IORESOURCE_MEM for one pin-bank
In-Reply-To: <1472046551-703-1-git-send-email-cw00.choi@samsung.com>
References: <1472046551-703-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1472046551-703-4-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch supports the multiple IORESOURCE_MEM resources for one pin-bank.
In the pre-existing Exynos series, the registers of the gpio bank are included
in the one memory map. But, some gpio bank need to support the one more memory
map (IORESOURCE_MEM) because the registers of gpio bank are located in
the different memory map.

For example,
The both ALIVE and IMEM domain have the different memory base address.
The GFP[1-5] of exynos5433 are composed as following:
- ALIVE domain : WEINT_* registers
- IMEM domain  : CON/DAT/PUD/DRV/CONPDN/PUDPDN register

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: linux-gpio at vger.kernel.org
Suggested-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 .../bindings/pinctrl/samsung-pinctrl.txt           | 17 +++++++
 drivers/pinctrl/samsung/pinctrl-exynos.c           | 46 +++++++++++-------
 drivers/pinctrl/samsung/pinctrl-exynos.h           | 47 ++++++++++++++++--
 drivers/pinctrl/samsung/pinctrl-samsung.c          | 55 ++++++++++++++--------
 drivers/pinctrl/samsung/pinctrl-samsung.h          |  7 ++-
 5 files changed, 131 insertions(+), 41 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
index 6db16b90873a..37bc692445d4 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
@@ -94,6 +94,11 @@ Required Properties:
   pin configuration should use the bindings listed in the "pinctrl-bindings.txt"
   file.
 
+Optional Properties:
+- reg: Second base address of the pin controller hardware module and length of
+  the address space it occupies if the specific register of the pin controller
+  are located in the different base address.
+
 External GPIO and Wakeup Interrupts:
 
 The controller supports two types of external interrupts over gpio. The first
@@ -305,6 +310,18 @@ Example 2: A pin-controller node with external wakeup interrupt controller node.
 		};
 	};
 
+	- A pin-controller node with multiple base address.
+
+	pinctrl_0: pinctrl at 10580000 {
+		compatible = "samsung,exynos5433-pinctrl";
+		reg = <0x10580000 0x1a20>, <0x11090000 0x100>;
+
+		wakeup-interrupt-controller {
+			compatible = "samsung,exynos7-wakeup-eint";
+			interrupts = <0 16 0>;
+		};
+	};
+
 Example 3: A uart client node that supports 'default' and 'flow-control' states.
 
 	uart at 13800000 {
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 051b5bf701a8..12fa9d3f1113 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -65,12 +65,13 @@ static void exynos_irq_mask(struct irq_data *irqd)
 	unsigned long reg_mask = our_chip->eint_mask + bank->eint_offset;
 	unsigned long mask;
 	unsigned long flags;
+	unsigned int eint_res_idx = bank->eint_res_idx;
 
 	spin_lock_irqsave(&bank->slock, flags);
 
-	mask = readl(d->virt_base + reg_mask);
+	mask = readl(d->virt_base[eint_res_idx] + reg_mask);
 	mask |= 1 << irqd->hwirq;
-	writel(mask, d->virt_base + reg_mask);
+	writel(mask, d->virt_base[eint_res_idx] + reg_mask);
 
 	spin_unlock_irqrestore(&bank->slock, flags);
 }
@@ -82,8 +83,9 @@ static void exynos_irq_ack(struct irq_data *irqd)
 	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
 	struct samsung_pinctrl_drv_data *d = bank->drvdata;
 	unsigned long reg_pend = our_chip->eint_pend + bank->eint_offset;
+	unsigned int eint_res_idx = bank->eint_res_idx;
 
-	writel(1 << irqd->hwirq, d->virt_base + reg_pend);
+	writel(1 << irqd->hwirq, d->virt_base[eint_res_idx] + reg_pend);
 }
 
 static void exynos_irq_unmask(struct irq_data *irqd)
@@ -95,6 +97,7 @@ static void exynos_irq_unmask(struct irq_data *irqd)
 	unsigned long reg_mask = our_chip->eint_mask + bank->eint_offset;
 	unsigned long mask;
 	unsigned long flags;
+	unsigned int eint_res_idx = bank->eint_res_idx;
 
 	/*
 	 * Ack level interrupts right before unmask
@@ -109,9 +112,9 @@ static void exynos_irq_unmask(struct irq_data *irqd)
 
 	spin_lock_irqsave(&bank->slock, flags);
 
-	mask = readl(d->virt_base + reg_mask);
+	mask = readl(d->virt_base[eint_res_idx] + reg_mask);
 	mask &= ~(1 << irqd->hwirq);
-	writel(mask, d->virt_base + reg_mask);
+	writel(mask, d->virt_base[eint_res_idx] + reg_mask);
 
 	spin_unlock_irqrestore(&bank->slock, flags);
 }
@@ -125,6 +128,7 @@ static int exynos_irq_set_type(struct irq_data *irqd, unsigned int type)
 	unsigned int shift = EXYNOS_EINT_CON_LEN * irqd->hwirq;
 	unsigned int con, trig_type;
 	unsigned long reg_con = our_chip->eint_con + bank->eint_offset;
+	unsigned int eint_res_idx = bank->eint_res_idx;
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -152,10 +156,10 @@ static int exynos_irq_set_type(struct irq_data *irqd, unsigned int type)
 	else
 		irq_set_handler_locked(irqd, handle_level_irq);
 
-	con = readl(d->virt_base + reg_con);
+	con = readl(d->virt_base[eint_res_idx] + reg_con);
 	con &= ~(EXYNOS_EINT_CON_MASK << shift);
 	con |= trig_type << shift;
-	writel(con, d->virt_base + reg_con);
+	writel(con, d->virt_base[eint_res_idx] + reg_con);
 
 	return 0;
 }
@@ -169,6 +173,7 @@ static int exynos_irq_request_resources(struct irq_data *irqd)
 	struct samsung_pinctrl_drv_data *d = bank->drvdata;
 	unsigned int shift = EXYNOS_EINT_CON_LEN * irqd->hwirq;
 	unsigned long reg_con = our_chip->eint_con + bank->eint_offset;
+	unsigned int eint_res_idx = bank->eint_res_idx;
 	unsigned long flags;
 	unsigned int mask;
 	unsigned int con;
@@ -188,10 +193,10 @@ static int exynos_irq_request_resources(struct irq_data *irqd)
 
 	spin_lock_irqsave(&bank->slock, flags);
 
-	con = readl(d->virt_base + reg_con);
+	con = readl(d->virt_base[eint_res_idx] + reg_con);
 	con &= ~(mask << shift);
 	con |= EXYNOS_EINT_FUNC << shift;
-	writel(con, d->virt_base + reg_con);
+	writel(con, d->virt_base[eint_res_idx] + reg_con);
 
 	spin_unlock_irqrestore(&bank->slock, flags);
 
@@ -209,6 +214,7 @@ static void exynos_irq_release_resources(struct irq_data *irqd)
 	struct samsung_pinctrl_drv_data *d = bank->drvdata;
 	unsigned int shift = EXYNOS_EINT_CON_LEN * irqd->hwirq;
 	unsigned long reg_con = our_chip->eint_con + bank->eint_offset;
+	unsigned int eint_res_idx = bank->eint_res_idx;
 	unsigned long flags;
 	unsigned int mask;
 	unsigned int con;
@@ -221,10 +227,10 @@ static void exynos_irq_release_resources(struct irq_data *irqd)
 
 	spin_lock_irqsave(&bank->slock, flags);
 
-	con = readl(d->virt_base + reg_con);
+	con = readl(d->virt_base[eint_res_idx] + reg_con);
 	con &= ~(mask << shift);
 	con |= FUNC_INPUT << shift;
-	writel(con, d->virt_base + reg_con);
+	writel(con, d->virt_base[eint_res_idx] + reg_con);
 
 	spin_unlock_irqrestore(&bank->slock, flags);
 
@@ -272,9 +278,10 @@ static irqreturn_t exynos_eint_gpio_irq(int irq, void *data)
 {
 	struct samsung_pinctrl_drv_data *d = data;
 	struct samsung_pin_bank *bank = d->pin_banks;
+	unsigned int eint_res_idx = bank->eint_res_idx;
 	unsigned int svc, group, pin, virq;
 
-	svc = readl(d->virt_base + EXYNOS_SVC_OFFSET);
+	svc = readl(d->virt_base[eint_res_idx] + EXYNOS_SVC_OFFSET);
 	group = EXYNOS_SVC_GROUP(svc);
 	pin = svc & EXYNOS_SVC_NUM_MASK;
 
@@ -465,10 +472,11 @@ static void exynos_irq_demux_eint16_31(struct irq_desc *desc)
 
 	for (i = 0; i < eintd->nr_banks; ++i) {
 		struct samsung_pin_bank *b = eintd->banks[i];
-		pend = readl(d->virt_base + b->irq_chip->eint_pend
-				+ b->eint_offset);
-		mask = readl(d->virt_base + b->irq_chip->eint_mask
-				+ b->eint_offset);
+		unsigned int eint_res_idx = b->eint_res_idx;
+		pend = readl(d->virt_base[eint_res_idx]
+				+ b->irq_chip->eint_pend + b->eint_offset);
+		mask = readl(d->virt_base[eint_res_idx]
+				+ b->irq_chip->eint_mask + b->eint_offset);
 		exynos_irq_demux_eint(pend & ~mask, b->irq_domain);
 	}
 
@@ -585,7 +593,8 @@ static void exynos_pinctrl_suspend_bank(
 				struct samsung_pin_bank *bank)
 {
 	struct exynos_eint_gpio_save *save = bank->soc_priv;
-	void __iomem *regs = drvdata->virt_base;
+	unsigned int eint_res_idx = bank->eint_res_idx;
+	void __iomem *regs = drvdata->virt_base[eint_res_idx];
 
 	save->eint_con = readl(regs + EXYNOS_GPIO_ECON_OFFSET
 						+ bank->eint_offset);
@@ -614,7 +623,8 @@ static void exynos_pinctrl_resume_bank(
 				struct samsung_pin_bank *bank)
 {
 	struct exynos_eint_gpio_save *save = bank->soc_priv;
-	void __iomem *regs = drvdata->virt_base;
+	unsigned int eint_res_idx = bank->eint_res_idx;
+	void __iomem *regs = drvdata->virt_base[eint_res_idx];
 
 	pr_debug("%s:     con %#010x => %#010x\n", bank->name,
 			readl(regs + EXYNOS_GPIO_ECON_OFFSET
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
index 0f0f7cedb2dc..865a84c32fdc 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.h
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
@@ -56,7 +56,9 @@
 		.pctl_offset	= reg,			\
 		.nr_pins	= pins,			\
 		.eint_type	= EINT_TYPE_NONE,	\
-		.name		= id			\
+		.name		= id,			\
+		.pctl_res_idx	= 0,			\
+		.eint_res_idx	= 0			\
 	}
 
 #define EXYNOS_PIN_BANK_EINTG(pins, reg, id, offs)	\
@@ -66,7 +68,9 @@
 		.nr_pins	= pins,			\
 		.eint_type	= EINT_TYPE_GPIO,	\
 		.eint_offset	= offs,			\
-		.name		= id			\
+		.name		= id,			\
+		.pctl_res_idx	= 0,			\
+		.eint_res_idx	= 0			\
 	}
 
 #define EXYNOS_PIN_BANK_EINTW(pins, reg, id, offs)	\
@@ -76,7 +80,44 @@
 		.nr_pins	= pins,			\
 		.eint_type	= EINT_TYPE_WKUP,	\
 		.eint_offset	= offs,			\
-		.name		= id			\
+		.name		= id,			\
+		.pctl_res_idx	= 0,			\
+		.eint_res_idx	= 0			\
+	}
+
+#define EXYNOS_PIN_BANK_EINTN_EXT(pins, reg, id, pctl_idx, eint_idx)	\
+	{						\
+		.type		= &bank_type_off,	\
+		.pctl_offset	= reg,			\
+		.nr_pins	= pins,			\
+		.eint_type	= EINT_TYPE_NONE,	\
+		.name		= id,			\
+		.pctl_res_idx	= pctl_idx,		\
+		.eint_res_idx	= eint_dix		\
+	}
+
+#define EXYNOS_PIN_BANK_EINTG_EXT(pins, reg, id, offs, pctl_idx, eint_idx) \
+	{						\
+		.type		= &bank_type_off,	\
+		.pctl_offset	= reg,			\
+		.nr_pins	= pins,			\
+		.eint_type	= EINT_TYPE_GPIO,	\
+		.eint_offset	= offs,			\
+		.name		= id,			\
+		.pctl_res_idx	= pctl_idx,		\
+		.eint_res_idx	= eint_idx		\
+	}
+
+#define EXYNOS_PIN_BANK_EINTW_EXT(pins, reg, id, offs, pctl_idx, eint_idx) \
+	{						\
+		.type		= &bank_type_alive,	\
+		.pctl_offset	= reg,			\
+		.nr_pins	= pins,			\
+		.eint_type	= EINT_TYPE_WKUP,	\
+		.eint_offset	= offs,			\
+		.name		= id,			\
+		.pctl_res_idx	= pctl_idx,		\
+		.eint_res_idx	= eint_idx		\
 	}
 
 /**
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 513fe6b23248..f63f7608aef6 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -338,6 +338,7 @@ static void pin_to_reg_bank(struct samsung_pinctrl_drv_data *drvdata,
 			struct samsung_pin_bank **bank)
 {
 	struct samsung_pin_bank *b;
+	unsigned int pctl_res_idx;
 
 	b = drvdata->pin_banks;
 
@@ -345,7 +346,8 @@ static void pin_to_reg_bank(struct samsung_pinctrl_drv_data *drvdata,
 			((b->pin_base + b->nr_pins - 1) < pin))
 		b++;
 
-	*reg = drvdata->virt_base + b->pctl_offset;
+	pctl_res_idx = b->pctl_res_idx;
+	*reg = drvdata->virt_base[pctl_res_idx] + b->pctl_offset;
 	*offset = pin - b->pin_base;
 	if (bank)
 		*bank = b;
@@ -524,9 +526,10 @@ static void samsung_gpio_set_value(struct gpio_chip *gc,
 	struct samsung_pin_bank *bank = gpiochip_get_data(gc);
 	const struct samsung_pin_bank_type *type = bank->type;
 	void __iomem *reg;
+	unsigned int pctl_res_idx = bank->pctl_res_idx;
 	u32 data;
 
-	reg = bank->drvdata->virt_base + bank->pctl_offset;
+	reg = bank->drvdata->virt_base[pctl_res_idx] + bank->pctl_offset;
 
 	data = readl(reg + type->reg_offset[PINCFG_TYPE_DAT]);
 	data &= ~(1 << offset);
@@ -553,8 +556,9 @@ static int samsung_gpio_get(struct gpio_chip *gc, unsigned offset)
 	u32 data;
 	struct samsung_pin_bank *bank = gpiochip_get_data(gc);
 	const struct samsung_pin_bank_type *type = bank->type;
+	unsigned int pctl_res_idx = bank->pctl_res_idx;
 
-	reg = bank->drvdata->virt_base + bank->pctl_offset;
+	reg = bank->drvdata->virt_base[pctl_res_idx] + bank->pctl_offset;
 
 	data = readl(reg + type->reg_offset[PINCFG_TYPE_DAT]);
 	data >>= offset;
@@ -575,13 +579,15 @@ static int samsung_gpio_set_direction(struct gpio_chip *gc,
 	struct samsung_pin_bank *bank;
 	struct samsung_pinctrl_drv_data *drvdata;
 	void __iomem *reg;
+	unsigned int pctl_res_idx;
 	u32 data, mask, shift;
 
 	bank = gpiochip_get_data(gc);
 	type = bank->type;
 	drvdata = bank->drvdata;
+	pctl_res_idx = bank->pctl_res_idx;
 
-	reg = drvdata->virt_base + bank->pctl_offset +
+	reg = drvdata->virt_base[pctl_res_idx] + bank->pctl_offset +
 					type->reg_offset[PINCFG_TYPE_FUNC];
 
 	mask = (1 << type->fld_width[PINCFG_TYPE_FUNC]) - 1;
@@ -979,7 +985,8 @@ samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
 	const struct samsung_pin_bank_data *bdata;
 	const struct samsung_pin_ctrl *ctrl;
 	struct samsung_pin_bank *bank;
-	int i;
+	struct resource *res;
+	int i, j;
 
 	id = of_alias_get_id(node, "pinctrl");
 	if (id < 0) {
@@ -1008,6 +1015,8 @@ samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
 		bank->eint_mask = bdata->eint_mask;
 		bank->eint_offset = bdata->eint_offset;
 		bank->name = bdata->name;
+		bank->pctl_res_idx = bdata->pctl_res_idx;
+		bank->eint_res_idx = bdata->eint_res_idx;
 
 		spin_lock_init(&bank->slock);
 		bank->drvdata = d;
@@ -1015,6 +1024,22 @@ samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
 		d->nr_pins += bank->nr_pins;
 	}
 
+	d->virt_base = devm_kzalloc(&pdev->dev, sizeof(void __iomem) *
+				(ctrl->nr_ext_resources + 1), GFP_KERNEL);
+	if (!d->virt_base)
+		return NULL;
+
+	for (j = 0 ; j < ctrl->nr_ext_resources + 1; j++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, j);
+		d->virt_base[j] = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(d->virt_base[j]))
+			return NULL;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (res)
+		d->irq = res->start;
+
 	for_each_child_of_node(node, np) {
 		if (!of_find_property(np, "gpio-controller", NULL))
 			continue;
@@ -1038,7 +1063,6 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
 	struct samsung_pinctrl_drv_data *drvdata;
 	const struct samsung_pin_ctrl *ctrl;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	int ret;
 
 	if (!dev->of_node) {
@@ -1060,15 +1084,6 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
 	}
 	drvdata->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	drvdata->virt_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(drvdata->virt_base))
-		return PTR_ERR(drvdata->virt_base);
-
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (res)
-		drvdata->irq = res->start;
-
 	ret = samsung_gpiolib_register(pdev, drvdata);
 	if (ret)
 		return ret;
@@ -1102,12 +1117,13 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
 static void samsung_pinctrl_suspend_dev(
 	struct samsung_pinctrl_drv_data *drvdata)
 {
-	void __iomem *virt_base = drvdata->virt_base;
 	int i;
 
 	for (i = 0; i < drvdata->nr_banks; i++) {
 		struct samsung_pin_bank *bank = &drvdata->pin_banks[i];
-		void __iomem *reg = virt_base + bank->pctl_offset;
+		unsigned int pctl_res_idx = bank->pctl_res_idx;
+		void __iomem *reg =
+			drvdata->virt_base[pctl_res_idx] + bank->pctl_offset;
 		const u8 *offs = bank->type->reg_offset;
 		const u8 *widths = bank->type->fld_width;
 		enum pincfg_type type;
@@ -1148,7 +1164,6 @@ static void samsung_pinctrl_suspend_dev(
  */
 static void samsung_pinctrl_resume_dev(struct samsung_pinctrl_drv_data *drvdata)
 {
-	void __iomem *virt_base = drvdata->virt_base;
 	int i;
 
 	if (drvdata->resume)
@@ -1156,7 +1171,9 @@ static void samsung_pinctrl_resume_dev(struct samsung_pinctrl_drv_data *drvdata)
 
 	for (i = 0; i < drvdata->nr_banks; i++) {
 		struct samsung_pin_bank *bank = &drvdata->pin_banks[i];
-		void __iomem *reg = virt_base + bank->pctl_offset;
+		unsigned int pctl_res_idx = bank->pctl_res_idx;
+		void __iomem *reg =
+			drvdata->virt_base[pctl_res_idx] + bank->pctl_offset;
 		const u8 *offs = bank->type->reg_offset;
 		const u8 *widths = bank->type->fld_width;
 		enum pincfg_type type;
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index cd31bfaf62cb..d2e4921cc2e5 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -132,6 +132,8 @@ struct samsung_pin_bank_data {
 	u32		eint_mask;
 	u32		eint_offset;
 	const char	*name;
+	unsigned int	pctl_res_idx;
+	unsigned int	eint_res_idx;
 };
 
 /**
@@ -164,6 +166,8 @@ struct samsung_pin_bank {
 	u32		eint_mask;
 	u32		eint_offset;
 	const char	*name;
+	unsigned int	pctl_res_idx;
+	unsigned int	eint_res_idx;
 
 	u32		pin_base;
 	void		*soc_priv;
@@ -190,6 +194,7 @@ struct samsung_pin_bank {
 struct samsung_pin_ctrl {
 	const struct samsung_pin_bank_data *pin_banks;
 	u32		nr_banks;
+	u32		nr_ext_resources;
 
 	int		(*eint_gpio_init)(struct samsung_pinctrl_drv_data *);
 	int		(*eint_wkup_init)(struct samsung_pinctrl_drv_data *);
@@ -215,7 +220,7 @@ struct samsung_pin_ctrl {
  */
 struct samsung_pinctrl_drv_data {
 	struct list_head		node;
-	void __iomem			*virt_base;
+	void __iomem			**virt_base;
 	struct device			*dev;
 	int				irq;
 
-- 
1.9.1
