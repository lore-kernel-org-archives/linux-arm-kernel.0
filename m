From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 03 Nov 2016 15:39:05 +0900
Subject: [PATCH v3 1/5] pinctrl: samsung: Add the support the multiple
 IORESOURCE_MEM for one pin-bank
In-Reply-To: <1478155149-28527-1-git-send-email-cw00.choi@samsung.com>
References: <1478155149-28527-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1478155149-28527-2-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch supports the multiple IORESOURCE_MEM resources for one pin-bank.
In the pre-existing Exynos series, the registers of the gpio bank are included
in the one memory map. But, some gpio bank need to support the one more memory
map (IORESOURCE_MEM) because the registers of gpio bank are separated into
the different memory map.

For example,
The both ALIVE and IMEM domain have the different memory base address.
The GFP[1-5] of exynos5433 are composed as following:
- ALIVE domain : WEINT_* registers
- IMEM domain  : CON/DAT/PUD/DRV/CONPDN/PUDPDN register

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-gpio at vger.kernel.org
Suggested-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 .../bindings/pinctrl/samsung-pinctrl.txt           | 19 ++++++++++
 drivers/pinctrl/samsung/pinctrl-exynos.c           | 39 +++++++++------------
 drivers/pinctrl/samsung/pinctrl-exynos.h           | 11 ++++++
 drivers/pinctrl/samsung/pinctrl-samsung.c          | 40 ++++++++++++++--------
 drivers/pinctrl/samsung/pinctrl-samsung.h          | 10 ++++--
 5 files changed, 80 insertions(+), 39 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
index d49e22d2a8b5..1baf19eecabf 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
@@ -19,11 +19,30 @@ Required Properties:
   - "samsung,exynos5260-pinctrl": for Exynos5260 compatible pin-controller.
   - "samsung,exynos5410-pinctrl": for Exynos5410 compatible pin-controller.
   - "samsung,exynos5420-pinctrl": for Exynos5420 compatible pin-controller.
+  - "samsung,exynos5433-pinctrl": for Exynos5433 compatible pin-controller.
   - "samsung,exynos7-pinctrl": for Exynos7 compatible pin-controller.
 
 - reg: Base address of the pin controller hardware module and length of
   the address space it occupies.
 
+  - reg: Second base address of the pin controller if the specific registers
+  of the pin controller are separated into the different base address.
+
+	Eg: GPF[1-5] of Exynos5433 are separated into the two base address.
+	- First base address is for GPAx and GPF[1-5] external interrupt
+	  registers.
+	- Second base address is for GPF[1-5] pinctrl registers.
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
 - Pin banks as child nodes: Pin banks of the controller are represented by child
   nodes of the controller node. Bank name is taken from name of the node. Each
   bank node must contain following properties:
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index d32fa2b5ff82..d657b52dfdb5 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -61,16 +61,15 @@ static void exynos_irq_mask(struct irq_data *irqd)
 	struct irq_chip *chip = irq_data_get_irq_chip(irqd);
 	struct exynos_irq_chip *our_chip = to_exynos_irq_chip(chip);
 	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
-	struct samsung_pinctrl_drv_data *d = bank->drvdata;
 	unsigned long reg_mask = our_chip->eint_mask + bank->eint_offset;
 	unsigned long mask;
 	unsigned long flags;
 
 	spin_lock_irqsave(&bank->slock, flags);
 
-	mask = readl(d->virt_base + reg_mask);
+	mask = readl(bank->eint_base + reg_mask);
 	mask |= 1 << irqd->hwirq;
-	writel(mask, d->virt_base + reg_mask);
+	writel(mask, bank->eint_base + reg_mask);
 
 	spin_unlock_irqrestore(&bank->slock, flags);
 }
@@ -80,10 +79,9 @@ static void exynos_irq_ack(struct irq_data *irqd)
 	struct irq_chip *chip = irq_data_get_irq_chip(irqd);
 	struct exynos_irq_chip *our_chip = to_exynos_irq_chip(chip);
 	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
-	struct samsung_pinctrl_drv_data *d = bank->drvdata;
 	unsigned long reg_pend = our_chip->eint_pend + bank->eint_offset;
 
-	writel(1 << irqd->hwirq, d->virt_base + reg_pend);
+	writel(1 << irqd->hwirq, bank->eint_base + reg_pend);
 }
 
 static void exynos_irq_unmask(struct irq_data *irqd)
@@ -91,7 +89,6 @@ static void exynos_irq_unmask(struct irq_data *irqd)
 	struct irq_chip *chip = irq_data_get_irq_chip(irqd);
 	struct exynos_irq_chip *our_chip = to_exynos_irq_chip(chip);
 	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
-	struct samsung_pinctrl_drv_data *d = bank->drvdata;
 	unsigned long reg_mask = our_chip->eint_mask + bank->eint_offset;
 	unsigned long mask;
 	unsigned long flags;
@@ -109,9 +106,9 @@ static void exynos_irq_unmask(struct irq_data *irqd)
 
 	spin_lock_irqsave(&bank->slock, flags);
 
-	mask = readl(d->virt_base + reg_mask);
+	mask = readl(bank->eint_base + reg_mask);
 	mask &= ~(1 << irqd->hwirq);
-	writel(mask, d->virt_base + reg_mask);
+	writel(mask, bank->eint_base + reg_mask);
 
 	spin_unlock_irqrestore(&bank->slock, flags);
 }
@@ -121,7 +118,6 @@ static int exynos_irq_set_type(struct irq_data *irqd, unsigned int type)
 	struct irq_chip *chip = irq_data_get_irq_chip(irqd);
 	struct exynos_irq_chip *our_chip = to_exynos_irq_chip(chip);
 	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
-	struct samsung_pinctrl_drv_data *d = bank->drvdata;
 	unsigned int shift = EXYNOS_EINT_CON_LEN * irqd->hwirq;
 	unsigned int con, trig_type;
 	unsigned long reg_con = our_chip->eint_con + bank->eint_offset;
@@ -152,10 +148,10 @@ static int exynos_irq_set_type(struct irq_data *irqd, unsigned int type)
 	else
 		irq_set_handler_locked(irqd, handle_level_irq);
 
-	con = readl(d->virt_base + reg_con);
+	con = readl(bank->eint_base + reg_con);
 	con &= ~(EXYNOS_EINT_CON_MASK << shift);
 	con |= trig_type << shift;
-	writel(con, d->virt_base + reg_con);
+	writel(con, bank->eint_base + reg_con);
 
 	return 0;
 }
@@ -166,7 +162,6 @@ static int exynos_irq_request_resources(struct irq_data *irqd)
 	struct exynos_irq_chip *our_chip = to_exynos_irq_chip(chip);
 	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
 	const struct samsung_pin_bank_type *bank_type = bank->type;
-	struct samsung_pinctrl_drv_data *d = bank->drvdata;
 	unsigned int shift = EXYNOS_EINT_CON_LEN * irqd->hwirq;
 	unsigned long reg_con = our_chip->eint_con + bank->eint_offset;
 	unsigned long flags;
@@ -188,10 +183,10 @@ static int exynos_irq_request_resources(struct irq_data *irqd)
 
 	spin_lock_irqsave(&bank->slock, flags);
 
-	con = readl(d->virt_base + reg_con);
+	con = readl(bank->eint_base + reg_con);
 	con &= ~(mask << shift);
 	con |= EXYNOS_EINT_FUNC << shift;
-	writel(con, d->virt_base + reg_con);
+	writel(con, bank->eint_base + reg_con);
 
 	spin_unlock_irqrestore(&bank->slock, flags);
 
@@ -206,7 +201,6 @@ static void exynos_irq_release_resources(struct irq_data *irqd)
 	struct exynos_irq_chip *our_chip = to_exynos_irq_chip(chip);
 	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
 	const struct samsung_pin_bank_type *bank_type = bank->type;
-	struct samsung_pinctrl_drv_data *d = bank->drvdata;
 	unsigned int shift = EXYNOS_EINT_CON_LEN * irqd->hwirq;
 	unsigned long reg_con = our_chip->eint_con + bank->eint_offset;
 	unsigned long flags;
@@ -221,10 +215,10 @@ static void exynos_irq_release_resources(struct irq_data *irqd)
 
 	spin_lock_irqsave(&bank->slock, flags);
 
-	con = readl(d->virt_base + reg_con);
+	con = readl(bank->eint_base + reg_con);
 	con &= ~(mask << shift);
 	con |= FUNC_INPUT << shift;
-	writel(con, d->virt_base + reg_con);
+	writel(con, bank->eint_base + reg_con);
 
 	spin_unlock_irqrestore(&bank->slock, flags);
 
@@ -274,7 +268,7 @@ static irqreturn_t exynos_eint_gpio_irq(int irq, void *data)
 	struct samsung_pin_bank *bank = d->pin_banks;
 	unsigned int svc, group, pin, virq;
 
-	svc = readl(d->virt_base + EXYNOS_SVC_OFFSET);
+	svc = readl(bank->eint_base + EXYNOS_SVC_OFFSET);
 	group = EXYNOS_SVC_GROUP(svc);
 	pin = svc & EXYNOS_SVC_NUM_MASK;
 
@@ -452,7 +446,6 @@ static void exynos_irq_demux_eint16_31(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct exynos_muxed_weint_data *eintd = irq_desc_get_handler_data(desc);
-	struct samsung_pinctrl_drv_data *d = eintd->banks[0]->drvdata;
 	unsigned long pend;
 	unsigned long mask;
 	int i;
@@ -461,9 +454,9 @@ static void exynos_irq_demux_eint16_31(struct irq_desc *desc)
 
 	for (i = 0; i < eintd->nr_banks; ++i) {
 		struct samsung_pin_bank *b = eintd->banks[i];
-		pend = readl(d->virt_base + b->irq_chip->eint_pend
+		pend = readl(b->eint_base + b->irq_chip->eint_pend
 				+ b->eint_offset);
-		mask = readl(d->virt_base + b->irq_chip->eint_mask
+		mask = readl(b->eint_base + b->irq_chip->eint_mask
 				+ b->eint_offset);
 		exynos_irq_demux_eint(pend & ~mask, b->irq_domain);
 	}
@@ -581,7 +574,7 @@ static void exynos_pinctrl_suspend_bank(
 				struct samsung_pin_bank *bank)
 {
 	struct exynos_eint_gpio_save *save = bank->soc_priv;
-	void __iomem *regs = drvdata->virt_base;
+	void __iomem *regs = bank->eint_base;
 
 	save->eint_con = readl(regs + EXYNOS_GPIO_ECON_OFFSET
 						+ bank->eint_offset);
@@ -610,7 +603,7 @@ static void exynos_pinctrl_resume_bank(
 				struct samsung_pin_bank *bank)
 {
 	struct exynos_eint_gpio_save *save = bank->soc_priv;
-	void __iomem *regs = drvdata->virt_base;
+	void __iomem *regs = bank->eint_base;
 
 	pr_debug("%s:     con %#010x => %#010x\n", bank->name,
 			readl(regs + EXYNOS_GPIO_ECON_OFFSET
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
index 0f0f7cedb2dc..5821525a2c84 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.h
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
@@ -79,6 +79,17 @@
 		.name		= id			\
 	}
 
+#define EXYNOS_PIN_BANK_EINTW_EXT(pins, reg, id, offs, pctl_idx) \
+	{						\
+		.type           = &bank_type_alive,	\
+		.pctl_offset    = reg,                  \
+		.nr_pins        = pins,                 \
+		.eint_type      = EINT_TYPE_WKUP,       \
+		.eint_offset    = offs,                 \
+		.name           = id,                   \
+		.pctl_res_idx   = pctl_idx,             \
+	}						\
+
 /**
  * struct exynos_weint_data: irq specific data for all the wakeup interrupts
  * generated by the external wakeup interrupt controller.
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 620727fabe64..41e62391c33c 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -33,6 +33,9 @@
 #include "../core.h"
 #include "pinctrl-samsung.h"
 
+/* maximum number of the memory resources */
+#define	SAMSUNG_PINCTRL_NUM_RESOURCES	2
+
 /* list of all possible config options supported */
 static struct pin_config {
 	const char *property;
@@ -345,7 +348,7 @@ static void pin_to_reg_bank(struct samsung_pinctrl_drv_data *drvdata,
 			((b->pin_base + b->nr_pins - 1) < pin))
 		b++;
 
-	*reg = drvdata->virt_base + b->pctl_offset;
+	*reg = b->pctl_base + b->pctl_offset;
 	*offset = pin - b->pin_base;
 	if (bank)
 		*bank = b;
@@ -526,7 +529,7 @@ static void samsung_gpio_set_value(struct gpio_chip *gc,
 	void __iomem *reg;
 	u32 data;
 
-	reg = bank->drvdata->virt_base + bank->pctl_offset;
+	reg = bank->pctl_base + bank->pctl_offset;
 
 	data = readl(reg + type->reg_offset[PINCFG_TYPE_DAT]);
 	data &= ~(1 << offset);
@@ -554,7 +557,7 @@ static int samsung_gpio_get(struct gpio_chip *gc, unsigned offset)
 	struct samsung_pin_bank *bank = gpiochip_get_data(gc);
 	const struct samsung_pin_bank_type *type = bank->type;
 
-	reg = bank->drvdata->virt_base + bank->pctl_offset;
+	reg = bank->pctl_base + bank->pctl_offset;
 
 	data = readl(reg + type->reg_offset[PINCFG_TYPE_DAT]);
 	data >>= offset;
@@ -581,8 +584,8 @@ static int samsung_gpio_set_direction(struct gpio_chip *gc,
 	type = bank->type;
 	drvdata = bank->drvdata;
 
-	reg = drvdata->virt_base + bank->pctl_offset +
-					type->reg_offset[PINCFG_TYPE_FUNC];
+	reg = bank->pctl_base + bank->pctl_offset
+			+ type->reg_offset[PINCFG_TYPE_FUNC];
 
 	mask = (1 << type->fld_width[PINCFG_TYPE_FUNC]) - 1;
 	shift = offset * type->fld_width[PINCFG_TYPE_FUNC];
@@ -979,6 +982,8 @@ static int samsung_gpiolib_unregister(struct platform_device *pdev,
 	const struct samsung_pin_bank_data *bdata;
 	const struct samsung_pin_ctrl *ctrl;
 	struct samsung_pin_bank *bank;
+	struct resource *res;
+	void __iomem *virt_base[SAMSUNG_PINCTRL_NUM_RESOURCES];
 	int i;
 
 	id = of_alias_get_id(node, "pinctrl");
@@ -997,6 +1002,17 @@ static int samsung_gpiolib_unregister(struct platform_device *pdev,
 	if (!d->pin_banks)
 		return ERR_PTR(-ENOMEM);
 
+	if (ctrl->nr_ext_resources + 1 > SAMSUNG_PINCTRL_NUM_RESOURCES)
+		return ERR_PTR(-EINVAL);
+
+	for (i = 0; i < ctrl->nr_ext_resources + 1; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		virt_base[i] = devm_ioremap(&pdev->dev, res->start,
+						resource_size(res));
+		if (IS_ERR(virt_base[i]))
+			return ERR_PTR(-EIO);
+	}
+
 	bank = d->pin_banks;
 	bdata = ctrl->pin_banks;
 	for (i = 0; i < ctrl->nr_banks; ++i, ++bdata, ++bank) {
@@ -1013,6 +1029,9 @@ static int samsung_gpiolib_unregister(struct platform_device *pdev,
 		bank->drvdata = d;
 		bank->pin_base = d->nr_pins;
 		d->nr_pins += bank->nr_pins;
+
+		bank->eint_base = virt_base[0];
+		bank->pctl_base = virt_base[bdata->pctl_res_idx];
 	}
 
 	for_each_child_of_node(node, np) {
@@ -1052,11 +1071,6 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
 	}
 	drvdata->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	drvdata->virt_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(drvdata->virt_base))
-		return PTR_ERR(drvdata->virt_base);
-
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (res)
 		drvdata->irq = res->start;
@@ -1094,12 +1108,11 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
 static void samsung_pinctrl_suspend_dev(
 	struct samsung_pinctrl_drv_data *drvdata)
 {
-	void __iomem *virt_base = drvdata->virt_base;
 	int i;
 
 	for (i = 0; i < drvdata->nr_banks; i++) {
 		struct samsung_pin_bank *bank = &drvdata->pin_banks[i];
-		void __iomem *reg = virt_base + bank->pctl_offset;
+		void __iomem *reg = bank->pctl_base + bank->pctl_offset;
 		const u8 *offs = bank->type->reg_offset;
 		const u8 *widths = bank->type->fld_width;
 		enum pincfg_type type;
@@ -1140,7 +1153,6 @@ static void samsung_pinctrl_suspend_dev(
  */
 static void samsung_pinctrl_resume_dev(struct samsung_pinctrl_drv_data *drvdata)
 {
-	void __iomem *virt_base = drvdata->virt_base;
 	int i;
 
 	if (drvdata->resume)
@@ -1148,7 +1160,7 @@ static void samsung_pinctrl_resume_dev(struct samsung_pinctrl_drv_data *drvdata)
 
 	for (i = 0; i < drvdata->nr_banks; i++) {
 		struct samsung_pin_bank *bank = &drvdata->pin_banks[i];
-		void __iomem *reg = virt_base + bank->pctl_offset;
+		void __iomem *reg = bank->pctl_base + bank->pctl_offset;
 		const u8 *offs = bank->type->reg_offset;
 		const u8 *widths = bank->type->fld_width;
 		enum pincfg_type type;
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index cd31bfaf62cb..043cb6c11180 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -116,6 +116,7 @@ struct samsung_pin_bank_type {
  * struct samsung_pin_bank_data: represent a controller pin-bank (init data).
  * @type: type of the bank (register offsets and bitfield widths)
  * @pctl_offset: starting offset of the pin-bank registers.
+ * @pctl_res_idx: index of base address for pin-bank registers.
  * @nr_pins: number of pins included in this bank.
  * @eint_func: function to set in CON register to configure pin as EINT.
  * @eint_type: type of the external interrupt supported by the bank.
@@ -126,6 +127,7 @@ struct samsung_pin_bank_type {
 struct samsung_pin_bank_data {
 	const struct samsung_pin_bank_type *type;
 	u32		pctl_offset;
+	u8		pctl_res_idx;
 	u8		nr_pins;
 	u8		eint_func;
 	enum eint_type	eint_type;
@@ -137,8 +139,10 @@ struct samsung_pin_bank_data {
 /**
  * struct samsung_pin_bank: represent a controller pin-bank.
  * @type: type of the bank (register offsets and bitfield widths)
+ * @pctl_base: base address of the pin-bank registers
  * @pctl_offset: starting offset of the pin-bank registers.
  * @nr_pins: number of pins included in this bank.
+ * @eint_base: base address of the pin-bank EINT registers.
  * @eint_func: function to set in CON register to configure pin as EINT.
  * @eint_type: type of the external interrupt supported by the bank.
  * @eint_mask: bit mask of pins which support EINT function.
@@ -157,8 +161,10 @@ struct samsung_pin_bank_data {
  */
 struct samsung_pin_bank {
 	const struct samsung_pin_bank_type *type;
+	void __iomem	*pctl_base;
 	u32		pctl_offset;
 	u8		nr_pins;
+	void __iomem	*eint_base;
 	u8		eint_func;
 	enum eint_type	eint_type;
 	u32		eint_mask;
@@ -182,6 +188,7 @@ struct samsung_pin_bank {
  * struct samsung_pin_ctrl: represent a pin controller.
  * @pin_banks: list of pin banks included in this controller.
  * @nr_banks: number of pin banks.
+ * @nr_ext_resources: number of the extra base address for pin banks.
  * @eint_gpio_init: platform specific callback to setup the external gpio
  *	interrupts for the controller.
  * @eint_wkup_init: platform specific callback to setup the external wakeup
@@ -190,6 +197,7 @@ struct samsung_pin_bank {
 struct samsung_pin_ctrl {
 	const struct samsung_pin_bank_data *pin_banks;
 	u32		nr_banks;
+	int		nr_ext_resources;
 
 	int		(*eint_gpio_init)(struct samsung_pinctrl_drv_data *);
 	int		(*eint_wkup_init)(struct samsung_pinctrl_drv_data *);
@@ -200,7 +208,6 @@ struct samsung_pin_ctrl {
 /**
  * struct samsung_pinctrl_drv_data: wrapper for holding driver data together.
  * @node: global list node
- * @virt_base: register base address of the controller.
  * @dev: device instance representing the controller.
  * @irq: interrpt number used by the controller to notify gpio interrupts.
  * @ctrl: pin controller instance managed by the driver.
@@ -215,7 +222,6 @@ struct samsung_pin_ctrl {
  */
 struct samsung_pinctrl_drv_data {
 	struct list_head		node;
-	void __iomem			*virt_base;
 	struct device			*dev;
 	int				irq;
 
-- 
1.9.1
