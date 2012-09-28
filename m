From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 28 Sep 2012 16:28:44 +0200
Subject: [RFC PATCH 13/16] pinctrl: samsung: Parse offsets of particular
 registers from DT
In-Reply-To: <1348842527-22460-1-git-send-email-t.figa@samsung.com>
References: <1348842527-22460-1-git-send-email-t.figa@samsung.com>
Message-ID: <1348842527-22460-14-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The order and availability of pin control registers vary with SoC.

This patch modifies the driver to parse register offsets from device
tree as a part of bank type definition.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/pinctrl/pinctrl-exynos.c  | 12 ++---
 drivers/pinctrl/pinctrl-samsung.c | 93 +++++++++++++++++++++------------------
 drivers/pinctrl/pinctrl-samsung.h | 38 +++++++++-------
 3 files changed, 78 insertions(+), 65 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-exynos.c b/drivers/pinctrl/pinctrl-exynos.c
index 001d2ec..7ad2884 100644
--- a/drivers/pinctrl/pinctrl-exynos.c
+++ b/drivers/pinctrl/pinctrl-exynos.c
@@ -113,9 +113,9 @@ static int exynos_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
 	con |= trig_type << shift;
 	writel(con, d->virt_base + reg_con);
 
-	reg_con = bank->pctl_offset;
-	shift = pin * bank->func_width;
-	mask = (1 << bank->func_width) - 1;
+	reg_con = bank->pctl_offset + bank->regs[REG_FUNC].offset;
+	shift = pin * bank->regs[REG_FUNC].width;
+	mask = (1 << bank->regs[REG_FUNC].width) - 1;
 
 	con = readl(d->virt_base + reg_con);
 	con &= ~(mask << shift);
@@ -290,9 +290,9 @@ static int exynos_wkup_irq_set_type(struct irq_data *irqd, unsigned int type)
 	con |= trig_type << shift;
 	writel(con, d->virt_base + reg_con);
 
-	reg_con = bank->pctl_offset;
-	shift = pin * bank->func_width;
-	mask = (1 << bank->func_width) - 1;
+	reg_con = bank->pctl_offset + bank->regs[REG_FUNC].offset;
+	shift = pin * bank->regs[REG_FUNC].width;
+	mask = (1 << bank->regs[REG_FUNC].width) - 1;
 
 	con = readl(d->virt_base + reg_con);
 	con &= ~(mask << shift);
diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
index 9b38609..b02cd46 100644
--- a/drivers/pinctrl/pinctrl-samsung.c
+++ b/drivers/pinctrl/pinctrl-samsung.c
@@ -273,10 +273,6 @@ static void pin_to_reg_bank(struct samsung_pinctrl_drv_data *drvdata,
 	*offset = pin - b->pin_base;
 	if (bank)
 		*bank = b;
-
-	/* some banks have two config registers in a single bank */
-	if (*offset * b->func_width > BITS_PER_LONG)
-		*reg += 4;
 }
 
 /* enable or disable a pinmux function */
@@ -299,8 +295,9 @@ static void samsung_pinmux_setup(struct pinctrl_dev *pctldev, unsigned selector,
 	for (cnt = 0; cnt < drvdata->pin_groups[group].num_pins; cnt++) {
 		pin_to_reg_bank(drvdata, pins[cnt] - drvdata->ctrl->base,
 				&reg, &pin_offset, &bank);
-		mask = (1 << bank->func_width) - 1;
-		shift = pin_offset * bank->func_width;
+		mask = (1 << bank->regs[REG_FUNC].width) - 1;
+		shift = pin_offset * bank->regs[REG_FUNC].width;
+		reg += bank->regs[REG_FUNC].offset;
 
 		data = readl(reg);
 		data &= ~(mask << shift);
@@ -342,10 +339,11 @@ static int samsung_pinmux_gpio_set_direction(struct pinctrl_dev *pctldev,
 	drvdata = pinctrl_dev_get_drvdata(pctldev);
 
 	pin_offset = offset - bank->pin_base;
-	reg = drvdata->virt_base + bank->pctl_offset;
+	reg = drvdata->virt_base + bank->pctl_offset
+						+ bank->regs[REG_FUNC].offset;
 
-	mask = (1 << bank->func_width) - 1;
-	shift = pin_offset * bank->func_width;
+	mask = (1 << bank->regs[REG_FUNC].width) - 1;
+	shift = pin_offset * bank->regs[REG_FUNC].width;
 
 	data = readl(reg);
 	data &= ~(mask << shift);
@@ -382,20 +380,20 @@ static int samsung_pinconf_rw(struct pinctrl_dev *pctldev, unsigned int pin,
 
 	switch (cfg_type) {
 	case PINCFG_TYPE_PUD:
-		width = bank->pud_width;
-		cfg_reg = PUD_REG;
+		width = bank->regs[REG_PUD].width;
+		cfg_reg = bank->regs[REG_PUD].offset;
 		break;
 	case PINCFG_TYPE_DRV:
-		width = bank->drv_width;
-		cfg_reg = DRV_REG;
+		width = bank->regs[REG_DRV].width;
+		cfg_reg = bank->regs[REG_DRV].offset;
 		break;
 	case PINCFG_TYPE_CON_PDN:
-		width = bank->conpdn_width;
-		cfg_reg = CONPDN_REG;
+		width = bank->regs[REG_CONPDN].width;
+		cfg_reg = bank->regs[REG_CONPDN].offset;
 		break;
 	case PINCFG_TYPE_PUD_PDN:
-		width = bank->pudpdn_width;
-		cfg_reg = PUDPDN_REG;
+		width = bank->regs[REG_PUDPDN].width;
+		cfg_reg = bank->regs[REG_PUDPDN].offset;
 		break;
 	default:
 		WARN_ON(1);
@@ -481,13 +479,14 @@ static void samsung_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
 	void __iomem *reg;
 	u32 data;
 
-	reg = bank->drvdata->virt_base + bank->pctl_offset;
+	reg = bank->drvdata->virt_base + bank->pctl_offset
+						+ bank->regs[REG_DAT].offset;
 
-	data = readl(reg + DAT_REG);
+	data = readl(reg);
 	data &= ~(1 << offset);
 	if (value)
 		data |= 1 << offset;
-	writel(data, reg + DAT_REG);
+	writel(data, reg);
 }
 
 /* gpiolib gpio_get callback function */
@@ -497,9 +496,10 @@ static int samsung_gpio_get(struct gpio_chip *gc, unsigned offset)
 	u32 data;
 	struct samsung_pin_bank *bank = gc_to_pin_bank(gc);
 
-	reg = bank->drvdata->virt_base + bank->pctl_offset;
+	reg = bank->drvdata->virt_base + bank->pctl_offset
+						+ bank->regs[REG_DAT].offset;
 
-	data = readl(reg + DAT_REG);
+	data = readl(reg);
 	data >>= offset;
 	data &= 1;
 	return data;
@@ -817,12 +817,24 @@ static int __init samsung_gpiolib_unregister(struct platform_device *pdev,
 
 static const struct of_device_id samsung_pinctrl_dt_match[];
 
+
+
 static int samsung_pinctrl_parse_dt_bank_type(struct samsung_pin_bank *bank,
 							struct device_node *np)
 {
+	static const char *reg_names[REG_NUM] = {
+		[REG_FUNC] = "func",
+		[REG_DAT] = "dat",
+		[REG_PUD] = "pud",
+		[REG_DRV] = "drv",
+		[REG_CONPDN] = "conpdn",
+		[REG_PUDPDN] = "pudpdn",
+	};
 	struct samsung_pin_bank *type = np->data;
-	int ret;
-	u32 val;
+	const __be32 *data;
+	int len = 0;
+	int index;
+	int i;
 
 	if (type) {
 		*bank = *type;
@@ -833,26 +845,21 @@ static int samsung_pinctrl_parse_dt_bank_type(struct samsung_pin_bank *bank,
 	if (!type)
 		return -ENOMEM;
 
-	ret = of_property_read_u32(np, "samsung,func-width", &val);
-	if (ret)
-		return ret;
-	type->func_width = val;
-
-	ret = of_property_read_u32(np, "samsung,pud-width", &val);
-	if (!ret)
-		type->pud_width = val;
-
-	ret = of_property_read_u32(np, "samsung,drv-width", &val);
-	if (!ret)
-		type->drv_width = val;
-
-	ret = of_property_read_u32(np, "samsung,conpdn-width", &val);
-	if (!ret)
-		type->conpdn_width = val;
+	data = of_get_property(np, "samsung,reg-params", &len);
+	if (!data)
+		return -EINVAL;
+	len /= sizeof(*data);
 
-	ret = of_property_read_u32(np, "samsung,pudpdn-width", &val);
-	if (!ret)
-		type->pudpdn_width = val;
+	for (i = 0; i < ARRAY_SIZE(reg_names); ++i) {
+		index = of_property_match_string(np, "samsung,reg-names",
+								reg_names[i]);
+		if (index < 0)
+			continue;
+		if (index >= len / 2)
+			return -EINVAL;
+		type->regs[i].offset = be32_to_cpu(data[2 * index]);
+		type->regs[i].width = be32_to_cpu(data[2 * index + 1]);
+	}
 
 	*bank = *type;
 	np->data = type;
diff --git a/drivers/pinctrl/pinctrl-samsung.h b/drivers/pinctrl/pinctrl-samsung.h
index 355f4e2..684f042 100644
--- a/drivers/pinctrl/pinctrl-samsung.h
+++ b/drivers/pinctrl/pinctrl-samsung.h
@@ -25,12 +25,16 @@
 
 #include <linux/gpio.h>
 
-/* register offsets within a pin bank */
-#define DAT_REG		0x4
-#define PUD_REG		0x8
-#define DRV_REG		0xC
-#define CONPDN_REG	0x10
-#define PUDPDN_REG	0x14
+enum pincfg_reg {
+	REG_FUNC = 0,
+	REG_DAT,
+	REG_PUD,
+	REG_DRV,
+	REG_CONPDN,
+	REG_PUDPDN,
+
+	REG_NUM
+};
 
 /* pinmux function number for pin as gpio output line */
 #define FUNC_OUTPUT	0x1
@@ -103,15 +107,21 @@ enum eint_type {
 struct samsung_pinctrl_drv_data;
 
 /**
+ * struct samsung_pin_reg: defines a configuration register.
+ * @offset: offset from bank base.
+ * @width: with of a bit field used for single pin.
+ */
+struct samsung_pin_reg {
+	u8 offset;
+	u8 width;
+};
+
+/**
  * struct samsung_pin_bank: represent a controller pin-bank.
  * @reg_offset: starting offset of the pin-bank registers.
  * @pin_base: starting pin number of the bank.
  * @nr_pins: number of pins included in this bank.
- * @func_width: width of the function selector bit field.
- * @pud_width: width of the pin pull up/down selector bit field.
- * @drv_width: width of the pin driver strength selector bit field.
- * @conpdn_width: width of the sleep mode function selector bin field.
- * @pudpdn_width: width of the sleep mode pull up/down selector bit field.
+ * @regs: low level parameters of available configuration registers.
  * @eint_type: type of the external interrupt supported by the bank.
  * @name: name to be prefixed for each pin in this pin bank.
  * @of_node: node of pin bank in device tree
@@ -124,11 +134,7 @@ struct samsung_pin_bank {
 	u32		pctl_offset;
 	u32		pin_base;
 	u8		nr_pins;
-	u8		func_width;
-	u8		pud_width;
-	u8		drv_width;
-	u8		conpdn_width;
-	u8		pudpdn_width;
+	struct samsung_pin_reg regs[REG_NUM];
 	enum eint_type	eint_type;
 	u32		eint_offset;
 	const char	*name;
-- 
1.7.12
