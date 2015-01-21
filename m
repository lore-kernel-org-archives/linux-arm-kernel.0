From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Wed, 21 Jan 2015 13:28:16 +0800
Subject: [PATCH v5 4/5] ARM: mediatek: Add EINT support to MTK pinctrl driver.
In-Reply-To: <1421818097-9281-1-git-send-email-hongzhou.yang@mediatek.com>
References: <1421818097-9281-1-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <1421818097-9281-5-git-send-email-hongzhou.yang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maoguang Meng <maoguang.meng@mediatek.com>

MTK SoC support external interrupt(EINT) from most SoC pins.
Add EINT support to pinctrl driver.

Signed-off-by: Maoguang Meng <maoguang.meng@mediatek.com>
Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt8135.c     |  23 ++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 379 +++++++++++++++++++++++++-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |  35 ++-
 3 files changed, 435 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8135.c b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
index 13694b8..b6ee2b2 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8135.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
@@ -314,6 +314,29 @@ static const struct mtk_pinctrl_devdata mt8135_pinctrl_data = {
 	.port_shf = 4,
 	.port_mask = 0xf,
 	.port_align = 4,
+	.chip_type = MTK_CHIP_TYPE_BASE,
+	.eint_offsets = {
+		.name = "mt8135_eint",
+		.stat      = 0x000,
+		.ack       = 0x040,
+		.mask      = 0x080,
+		.mask_set  = 0x0c0,
+		.mask_clr  = 0x100,
+		.sens      = 0x140,
+		.sens_set  = 0x180,
+		.sens_clr  = 0x1c0,
+		.pol       = 0x300,
+		.pol_set   = 0x340,
+		.pol_clr   = 0x380,
+		.dom_en    = 0x400,
+		.dbnc_ctrl = 0x500,
+		.dbnc_set  = 0x600,
+		.dbnc_clr  = 0x700,
+		.port_mask = 7,
+		.ports     = 6,
+	},
+	.ap_num = 192,
+	.db_cnt = 16,
 };
 
 static int mt8135_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 5d680c8..7e113e1 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -31,6 +31,7 @@
 #include <linux/bitops.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
+#include <linux/delay.h>
 #include <dt-bindings/pinctrl/mt65xx.h>
 
 #include "../core.h"
@@ -560,6 +561,21 @@ static int mtk_pmx_set_mode(struct pinctrl_dev *pctldev,
 			reg_addr, mask, val);
 }
 
+static const struct mtk_desc_pin *
+mtk_find_pin_by_eint_num(struct mtk_pinctrl *pctl, unsigned int eint_num)
+{
+	int i;
+	const struct mtk_desc_pin *pin;
+
+	for (i = 0; i < pctl->devdata->npins; i++) {
+		pin = pctl->devdata->pins + i;
+		if (pin->eint.eintnum == eint_num)
+			return pin;
+	}
+
+	return NULL;
+}
+
 static int mtk_pmx_set_mux(struct pinctrl_dev *pctldev,
 			    unsigned function,
 			    unsigned group)
@@ -647,6 +663,199 @@ static int mtk_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return !!(read_val & bit);
 }
 
+static int mtk_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	const struct mtk_desc_pin *pin;
+	struct mtk_pinctrl *pctl = dev_get_drvdata(chip->dev);
+	int irq;
+
+	pin = pctl->devdata->pins + offset;
+	if (pin->eint.eintnum == NO_EINT_SUPPORT)
+		return -EINVAL;
+
+	irq = irq_find_mapping(pctl->domain, pin->eint.eintnum);
+	if (!irq)
+		return -EINVAL;
+
+	return irq;
+}
+
+static int mtk_pinctrl_irq_request_resources(struct irq_data *d)
+{
+	struct mtk_pinctrl *pctl = irq_data_get_irq_chip_data(d);
+	const struct mtk_desc_pin *pin;
+	int ret;
+
+	pin = mtk_find_pin_by_eint_num(pctl, d->hwirq);
+
+	if (!pin) {
+		dev_err(pctl->dev, "Can not find pin\n");
+		return -EINVAL;
+	}
+
+	ret = gpiochip_lock_as_irq(pctl->chip, pin->pin.number);
+	if (ret) {
+		dev_err(pctl->dev, "unable to lock HW IRQ %lu for IRQ\n",
+			irqd_to_hwirq(d));
+		return ret;
+	}
+
+	/* set mux to INT mode */
+	mtk_pmx_set_mode(pctl->pctl_dev, pin->pin.number, pin->eint.eintmux);
+
+	return 0;
+}
+
+static void mtk_pinctrl_irq_release_resources(struct irq_data *d)
+{
+	struct mtk_pinctrl *pctl = irq_data_get_irq_chip_data(d);
+	const struct mtk_desc_pin *pin;
+
+	pin = mtk_find_pin_by_eint_num(pctl, d->hwirq);
+
+	if (!pin) {
+		dev_err(pctl->dev, "Can not find pin\n");
+		return;
+	}
+
+	gpiochip_unlock_as_irq(pctl->chip, pin->pin.number);
+}
+
+static void __iomem *mtk_eint_get_offset(struct mtk_pinctrl *pctl,
+	unsigned int eint_num, unsigned int offset)
+{
+	unsigned int eint_base = 0;
+	void __iomem *reg;
+
+	if (eint_num >= pctl->devdata->ap_num)
+		eint_base = pctl->devdata->ap_num;
+
+	reg = pctl->eint_reg_base + offset + ((eint_num - eint_base) / 32) * 4;
+
+	return reg;
+}
+
+/*
+ * mtk_can_en_debounce: Check the EINT number is able to enable debounce or not
+ * @eint_num: the EINT number to setmtk_pinctrl
+ */
+static unsigned int mtk_eint_can_en_debounce(struct mtk_pinctrl *pctl,
+	unsigned int eint_num)
+{
+	unsigned int sens;
+	unsigned int bit = BIT(eint_num % 32);
+	const struct mtk_eint_offsets *eint_offsets =
+		&pctl->devdata->eint_offsets;
+
+	void __iomem *reg = mtk_eint_get_offset(pctl, eint_num,
+			eint_offsets->sens);
+
+	if (readl(reg) & bit)
+		sens = MT_LEVEL_SENSITIVE;
+	else
+		sens = MT_EDGE_SENSITIVE;
+
+	if ((eint_num < pctl->devdata->db_cnt) && (sens != MT_EDGE_SENSITIVE))
+		return 1;
+	else
+		return 0;
+}
+
+/*
+ * mtk_eint_get_mask: To get the eint mask
+ * @eint_num: the EINT number to get
+ */
+static unsigned int mtk_eint_get_mask(struct mtk_pinctrl *pctl,
+	unsigned int eint_num)
+{
+	unsigned int bit = BIT(eint_num % 32);
+	const struct mtk_eint_offsets *eint_offsets =
+		&pctl->devdata->eint_offsets;
+
+	void __iomem *reg = mtk_eint_get_offset(pctl, eint_num,
+			eint_offsets->mask);
+
+	return !!(readl(reg) & bit);
+}
+
+static void mtk_eint_mask(struct irq_data *d)
+{
+	struct mtk_pinctrl *pctl = irq_data_get_irq_chip_data(d);
+	const struct mtk_eint_offsets *eint_offsets =
+			&pctl->devdata->eint_offsets;
+	u32 mask = BIT(d->hwirq & 0x1f);
+	void __iomem *reg = mtk_eint_get_offset(pctl, d->hwirq,
+			eint_offsets->mask_set);
+
+	writel(mask, reg);
+}
+
+static void mtk_eint_unmask(struct irq_data *d)
+{
+	struct mtk_pinctrl *pctl = irq_data_get_irq_chip_data(d);
+	const struct mtk_eint_offsets *eint_offsets =
+		&pctl->devdata->eint_offsets;
+	u32 mask = BIT(d->hwirq & 0x1f);
+	void __iomem *reg = mtk_eint_get_offset(pctl, d->hwirq,
+			eint_offsets->mask_clr);
+
+	writel(mask, reg);
+}
+
+static int mtk_gpio_set_debounce(struct gpio_chip *chip, unsigned offset,
+	unsigned debounce)
+{
+	struct mtk_pinctrl *pctl = dev_get_drvdata(chip->dev);
+	int eint_num, virq, eint_offset;
+	unsigned int set_offset, bit, clr_bit, clr_offset, rst, i, unmask, dbnc;
+	static const unsigned int dbnc_arr[] = {0 , 1, 16, 32, 64, 128, 256};
+	const struct mtk_desc_pin *pin;
+	struct irq_data *d;
+
+	pin = pctl->devdata->pins + offset;
+	if (pin->eint.eintnum == NO_EINT_SUPPORT)
+		return -EINVAL;
+
+	eint_num = pin->eint.eintnum;
+	virq = irq_find_mapping(pctl->domain, eint_num);
+	eint_offset = (eint_num % 4) * 8;
+	d = irq_get_irq_data(virq);
+
+	set_offset = (eint_num / 4) * 4 + pctl->devdata->eint_offsets.dbnc_set;
+	clr_offset = (eint_num / 4) * 4 + pctl->devdata->eint_offsets.dbnc_clr;
+	if (!mtk_eint_can_en_debounce(pctl, eint_num))
+		return -ENOSYS;
+
+	dbnc = ARRAY_SIZE(dbnc_arr);
+	for (i = 0; i < ARRAY_SIZE(dbnc_arr); i++) {
+		if (debounce <= dbnc_arr[i]) {
+			dbnc = i;
+			break;
+		}
+	}
+
+	if (!mtk_eint_get_mask(pctl, eint_num)) {
+		mtk_eint_mask(d);
+		unmask = 1;
+	}
+
+	clr_bit = 0xff << eint_offset;
+	writel(clr_bit, pctl->eint_reg_base + clr_offset);
+
+	bit = ((dbnc << EINT_DBNC_SET_DBNC_BITS) | EINT_DBNC_SET_EN) <<
+		eint_offset;
+	rst = EINT_DBNC_RST_BIT << eint_offset;
+	writel(rst | bit, pctl->eint_reg_base + set_offset);
+
+	/* Delay a while (more than 2T) to wait for hw debounce counter reset
+	work correctly */
+	udelay(1);
+	if (unmask == 1)
+		mtk_eint_unmask(d);
+
+	return 0;
+}
+
 static struct gpio_chip mtk_gpio_chip = {
 	.owner			= THIS_MODULE,
 	.request		= mtk_gpio_request,
@@ -655,9 +864,134 @@ static struct gpio_chip mtk_gpio_chip = {
 	.direction_output	= mtk_gpio_direction_output,
 	.get			= mtk_gpio_get,
 	.set			= mtk_gpio_set,
+	.to_irq			= mtk_gpio_to_irq,
+	.set_debounce		= mtk_gpio_set_debounce,
 	.of_gpio_n_cells	= 2,
 };
 
+static int mtk_eint_set_type(struct irq_data *d,
+				      unsigned int type)
+{
+	struct mtk_pinctrl *pctl = irq_data_get_irq_chip_data(d);
+	const struct mtk_eint_offsets *eint_offsets =
+		&pctl->devdata->eint_offsets;
+	u32 mask = BIT(d->hwirq & 0x1f);
+	void __iomem *reg;
+
+	if (((type & IRQ_TYPE_EDGE_BOTH) && (type & IRQ_TYPE_LEVEL_MASK)) ||
+		((type & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH) ||
+		((type & IRQ_TYPE_LEVEL_MASK) == IRQ_TYPE_LEVEL_MASK)) {
+		dev_err(pctl->dev, "Can't configure IRQ%d (EINT%lu) for type 0x%X\n",
+			d->irq, d->hwirq, type);
+		return -EINVAL;
+	}
+
+	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING)) {
+		reg = mtk_eint_get_offset(pctl, d->hwirq,
+			eint_offsets->pol_clr);
+		writel(mask, reg);
+	} else {
+		reg = mtk_eint_get_offset(pctl, d->hwirq,
+			eint_offsets->pol_set);
+		writel(mask, reg);
+	}
+
+	if (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING)) {
+		reg = mtk_eint_get_offset(pctl, d->hwirq,
+			eint_offsets->sens_clr);
+		writel(mask, reg);
+	} else {
+		reg = mtk_eint_get_offset(pctl, d->hwirq,
+			eint_offsets->sens_set);
+		writel(mask, reg);
+	}
+
+	return 0;
+}
+
+static void mtk_eint_ack(struct irq_data *d)
+{
+	struct mtk_pinctrl *pctl = irq_data_get_irq_chip_data(d);
+	const struct mtk_eint_offsets *eint_offsets =
+		&pctl->devdata->eint_offsets;
+	u32 mask = BIT(d->hwirq & 0x1f);
+	void __iomem *reg = mtk_eint_get_offset(pctl, d->hwirq,
+			eint_offsets->ack);
+
+	writel(mask, reg);
+}
+
+static struct irq_chip mtk_pinctrl_irq_chip = {
+	.name = "mt-eint",
+	.irq_mask = mtk_eint_mask,
+	.irq_unmask = mtk_eint_unmask,
+	.irq_ack = mtk_eint_ack,
+	.irq_set_type = mtk_eint_set_type,
+	.irq_request_resources = mtk_pinctrl_irq_request_resources,
+	.irq_release_resources = mtk_pinctrl_irq_release_resources,
+};
+
+static unsigned int mtk_eint_init(struct mtk_pinctrl *pctl)
+{
+	const struct mtk_eint_offsets *eint_offsets =
+		&pctl->devdata->eint_offsets;
+	void __iomem *reg = pctl->eint_reg_base + eint_offsets->dom_en;
+	unsigned int i;
+
+	for (i = 0; i < pctl->devdata->ap_num; i += 32) {
+		writel(0xffffffff, reg);
+		reg += 4;
+	}
+	return 0;
+}
+
+static inline void
+mtk_eint_debounce_process(struct mtk_pinctrl *pctl, int index)
+{
+	unsigned int rst, ctrl_offset;
+	unsigned int bit, dbnc;
+	const struct mtk_eint_offsets *eint_offsets =
+		&pctl->devdata->eint_offsets;
+
+	ctrl_offset = (index / 4) * 4 + eint_offsets->dbnc_ctrl;
+	dbnc = readl(pctl->eint_reg_base + ctrl_offset);
+	bit = EINT_DBNC_SET_EN << ((index % 4) * 8);
+	if ((bit & dbnc) > 0) {
+		ctrl_offset = (index / 4) * 4 + eint_offsets->dbnc_set;
+		rst = EINT_DBNC_RST_BIT << ((index % 4) * 8);
+		writel(rst, pctl->eint_reg_base + ctrl_offset);
+	}
+}
+
+static void mtk_eint_irq_handler(unsigned irq, struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_get_chip(irq);
+	struct mtk_pinctrl *pctl = irq_get_handler_data(irq);
+	unsigned int status, eint_num;
+	int offset, index, virq;
+	const struct mtk_eint_offsets *eint_offsets =
+		&pctl->devdata->eint_offsets;
+	void __iomem *reg =  mtk_eint_get_offset(pctl, 0, eint_offsets->stat);
+
+	chained_irq_enter(chip, desc);
+	for (eint_num = 0; eint_num < pctl->devdata->ap_num; eint_num += 32) {
+		status = readl(reg);
+		reg += 4;
+		while (status) {
+			offset = __ffs(status);
+			index = eint_num + offset;
+			virq = irq_find_mapping(pctl->domain, index);
+			status &= ~BIT(offset);
+
+			generic_handle_irq(virq);
+
+			if (index < pctl->devdata->db_cnt)
+				mtk_eint_debounce_process(pctl , index);
+		}
+	}
+	chained_irq_exit(chip, desc);
+}
+
 static int mtk_pctrl_build_state(struct platform_device *pdev)
 {
 	struct mtk_pinctrl *pctl = platform_get_drvdata(pdev);
@@ -705,7 +1039,8 @@ int mtk_pctrl_init(struct platform_device *pdev,
 	struct mtk_pinctrl *pctl;
 	struct device_node *np = pdev->dev.of_node, *node;
 	struct property *prop;
-	int i, ret;
+	struct resource *res;
+	int i, ret, irq;
 
 	pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
 	if (!pctl)
@@ -786,6 +1121,48 @@ int mtk_pctrl_init(struct platform_device *pdev,
 		goto chip_error;
 	}
 
+	/* Get EINT register base from dts. */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Unable to get Pinctrl resource\n");
+		ret = -EINVAL;
+		goto chip_error;
+	}
+
+	pctl->eint_reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pctl->eint_reg_base)) {
+		ret = -EINVAL;
+		goto chip_error;
+	}
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (!irq) {
+		dev_err(&pdev->dev, "couldn't parse and map irq\n");
+		ret = -EINVAL;
+		goto chip_error;
+	}
+
+	pctl->domain = irq_domain_add_linear(np,
+		pctl->devdata->ap_num, &irq_domain_simple_ops, NULL);
+	if (!pctl->domain) {
+		dev_err(&pdev->dev, "Couldn't register IRQ domain\n");
+		ret = -ENOMEM;
+		goto chip_error;
+	}
+
+	mtk_eint_init(pctl);
+	for (i = 0; i < pctl->devdata->ap_num; i++) {
+		int virq = irq_create_mapping(pctl->domain, i);
+
+		irq_set_chip_and_handler(virq, &mtk_pinctrl_irq_chip,
+			handle_level_irq);
+		irq_set_chip_data(virq, pctl);
+		set_irq_flags(virq, IRQF_VALID);
+	};
+
+	irq_set_chained_handler(irq, mtk_eint_irq_handler);
+	irq_set_handler_data(irq, pctl);
+	set_irq_flags(irq, IRQF_VALID);
 	return 0;
 
 chip_error:
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
index 95a9d57..8d7d32b 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
@@ -16,10 +16,16 @@
 #define __PINCTRL_MTK_COMMON_H
 
 #include <linux/pinctrl/pinctrl.h>
-#include <linux/spinlock.h>
 #include <linux/regmap.h>
 
 #define NO_EINT_SUPPORT    255
+#define MTK_CHIP_TYPE_BASE     0
+#define MTK_CHIP_TYPE_PMIC     1
+#define MT_EDGE_SENSITIVE           0
+#define MT_LEVEL_SENSITIVE          1
+#define EINT_DBNC_SET_DBNC_BITS     4
+#define EINT_DBNC_RST_BIT           (0x1 << 1)
+#define EINT_DBNC_SET_EN            (0x1 << 0)
 
 struct mtk_desc_function {
 	const char *name;
@@ -115,6 +121,27 @@ struct mtk_pin_drv_grp {
 		.grp = _grp,	\
 	}
 
+struct mtk_eint_offsets {
+	const char *name;
+	unsigned int  stat;
+	unsigned int  ack;
+	unsigned int  mask;
+	unsigned int  mask_set;
+	unsigned int  mask_clr;
+	unsigned int  sens;
+	unsigned int  sens_set;
+	unsigned int  sens_clr;
+	unsigned int  pol;
+	unsigned int  pol_set;
+	unsigned int  pol_clr;
+	unsigned int  dom_en;
+	unsigned int  dbnc_ctrl;
+	unsigned int  dbnc_set;
+	unsigned int  dbnc_clr;
+	u8  port_mask;
+	u8  ports;
+};
+
 /**
  * struct mtk_pinctrl_devdata - Provide HW GPIO related data.
  * @pins: An array describing all pins the pin controller affects.
@@ -165,6 +192,10 @@ struct mtk_pinctrl_devdata {
 	unsigned char  port_shf;
 	unsigned char  port_mask;
 	unsigned char  port_align;
+	unsigned char	chip_type;
+	struct mtk_eint_offsets eint_offsets;
+	unsigned int	ap_num;
+	unsigned int	db_cnt;
 };
 
 struct mtk_pinctrl {
@@ -177,6 +208,8 @@ struct mtk_pinctrl {
 	const char          **grp_names;
 	struct pinctrl_dev      *pctl_dev;
 	const struct mtk_pinctrl_devdata  *devdata;
+	void __iomem		*eint_reg_base;
+	struct irq_domain	*domain;
 };
 
 int mtk_pctrl_init(struct platform_device *pdev,
-- 
1.8.1.1.dirty
