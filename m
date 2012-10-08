From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 08 Oct 2012 10:39:04 +0200
Subject: [PATCH 04/16] pinctrl: samsung: Parse pin banks from DT
In-Reply-To: <1349685556-23718-1-git-send-email-t.figa@samsung.com>
References: <1349685556-23718-1-git-send-email-t.figa@samsung.com>
Message-ID: <1349685556-23718-5-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently SoC-specific properties such as list of pin banks, register
offsets and bitfield sizes are being taken from static data structures
residing in pinctrl-exynos.c.

This patch modifies the pinctrl-samsung driver to parse all SoC-specific
data from device tree, which will allow to remove the static data
structures and facilitate adding of further SoC variants to the
pinctrl-samsung driver.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/pinctrl/pinctrl-exynos.c  |   5 ++
 drivers/pinctrl/pinctrl-samsung.c | 169 +++++++++++++++++++++++++++++++++++++-
 drivers/pinctrl/pinctrl-samsung.h |  17 +++-
 3 files changed, 187 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-exynos.c b/drivers/pinctrl/pinctrl-exynos.c
index b4b58d4..e3fa263 100644
--- a/drivers/pinctrl/pinctrl-exynos.c
+++ b/drivers/pinctrl/pinctrl-exynos.c
@@ -599,3 +599,8 @@ struct samsung_pin_ctrl exynos4210_pin_ctrl[] = {
 		.label		= "exynos4210-gpio-ctrl2",
 	},
 };
+
+struct samsung_pin_ctrl_variant exynos4_pin_ctrl = {
+	.eint_gpio_init = exynos_eint_gpio_init,
+	.eint_wkup_init = exynos_eint_wkup_init,
+};
diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
index c660fa5..e828a0e 100644
--- a/drivers/pinctrl/pinctrl-samsung.c
+++ b/drivers/pinctrl/pinctrl-samsung.c
@@ -46,6 +46,8 @@ struct pin_config {
 	{ "samsung,pin-pud-pdn", PINCFG_TYPE_PUD_PDN },
 };
 
+static unsigned int pin_base = 0;
+
 /* check if the selector is a valid pin group selector */
 static int samsung_get_group_count(struct pinctrl_dev *pctldev)
 {
@@ -602,6 +604,8 @@ static int __init samsung_pinctrl_parse_dt(struct platform_device *pdev,
 		u32 function;
 		if (of_find_property(cfg_np, "interrupt-controller", NULL))
 			continue;
+		if (of_find_property(cfg_np, "gpio-controller", NULL))
+			continue;
 
 		ret = samsung_pinctrl_parse_dt_pins(pdev, cfg_np,
 					&drvdata->pctl,	&pin_list, &npins);
@@ -778,6 +782,86 @@ static int __init samsung_gpiolib_unregister(struct platform_device *pdev,
 
 static const struct of_device_id samsung_pinctrl_dt_match[];
 
+static int samsung_pinctrl_parse_dt_bank_type(struct samsung_pin_bank *bank,
+							struct device_node *np)
+{
+	struct samsung_pin_bank *type = np->data;
+	int ret;
+	u32 val;
+
+	if (type) {
+		*bank = *type;
+		return 0;
+	}
+
+	type = kzalloc(sizeof(*type), GFP_KERNEL);
+	if (!type)
+		return -ENOMEM;
+
+	ret = of_property_read_u32(np, "samsung,func-width", &val);
+	if (ret)
+		return ret;
+	type->func_width = val;
+
+	ret = of_property_read_u32(np, "samsung,pud-width", &val);
+	if (!ret)
+		type->pud_width = val;
+
+	ret = of_property_read_u32(np, "samsung,drv-width", &val);
+	if (!ret)
+		type->drv_width = val;
+
+	ret = of_property_read_u32(np, "samsung,conpdn-width", &val);
+	if (!ret)
+		type->conpdn_width = val;
+
+	ret = of_property_read_u32(np, "samsung,pudpdn-width", &val);
+	if (!ret)
+		type->pudpdn_width = val;
+
+	*bank = *type;
+	np->data = type;
+
+	return 0;
+}
+
+static int samsung_pinctrl_parse_dt_bank(struct samsung_pin_bank *bank,
+							struct device_node *np)
+{
+	int ret;
+	u32 val;
+	struct device_node *type_np;
+
+	type_np = of_parse_phandle(np, "samsung,bank-type", 0);
+	if (!type_np)
+		return -EINVAL;
+
+	ret = samsung_pinctrl_parse_dt_bank_type(bank, type_np);
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32(np, "samsung,pctl-offset", &val);
+	if (ret)
+		return ret;
+	bank->pctl_offset = val;
+
+	ret = of_property_read_u32(np, "samsung,pin-count", &val);
+	if (ret)
+		return ret;
+	bank->nr_pins = val;
+
+	bank->name = np->name;
+
+	if (!of_find_property(np, "interrupt-controller", NULL)) {
+		bank->eint_type = EINT_TYPE_NONE;
+		return 0;
+	}
+
+	bank->eint_type = EINT_TYPE_GPIO;
+
+	return 0;
+}
+
 /* retrieve the soc specific data */
 static struct samsung_pin_ctrl *samsung_pinctrl_get_soc_data(
 				struct platform_device *pdev)
@@ -785,6 +869,14 @@ static struct samsung_pin_ctrl *samsung_pinctrl_get_soc_data(
 	int id;
 	const struct of_device_id *match;
 	const struct device_node *node = pdev->dev.of_node;
+	struct device_node *bank_np;
+	struct samsung_pin_ctrl *ctrl;
+	struct samsung_pin_bank *banks, *b;
+	struct samsung_pin_ctrl_variant *variant;
+	unsigned int bank_cnt = 0;
+	unsigned int eint_cnt = 0;
+	u32 val;
+	int ret;
 
 	id = of_alias_get_id(pdev->dev.of_node, "pinctrl");
 	if (id < 0) {
@@ -792,7 +884,80 @@ static struct samsung_pin_ctrl *samsung_pinctrl_get_soc_data(
 		return NULL;
 	}
 	match = of_match_node(samsung_pinctrl_dt_match, node);
-	return (struct samsung_pin_ctrl *)match->data + id;
+	variant = match->data;
+
+	for_each_child_of_node(node, bank_np) {
+		if (!of_find_property(bank_np, "gpio-controller", NULL))
+			continue;
+		++bank_cnt;
+	}
+
+	if (!bank_cnt) {
+		dev_err(&pdev->dev, "no pin banks specified\n");
+		return NULL;
+	}
+
+	ctrl = devm_kzalloc(&pdev->dev, sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl) {
+		dev_err(&pdev->dev, "failed to allocate soc data\n");
+		return NULL;
+	}
+
+	banks = devm_kzalloc(&pdev->dev,
+			bank_cnt * sizeof(*ctrl->pin_banks), GFP_KERNEL);
+	if (!banks) {
+		dev_err(&pdev->dev, "failed to allocate pin banks\n");
+		return NULL;
+	}
+
+	b = banks;
+	for_each_child_of_node(node, bank_np) {
+		if (!of_find_property(bank_np, "gpio-controller", NULL))
+			continue;
+		if (samsung_pinctrl_parse_dt_bank(b, bank_np))
+			return NULL;
+		b->pin_base = ctrl->nr_pins;
+		ctrl->nr_pins += b->nr_pins;
+		if (b->eint_type == EINT_TYPE_GPIO) {
+			b->irq_base = eint_cnt;
+			eint_cnt += b->nr_pins;
+		}
+		++b;
+	}
+
+	if (eint_cnt) {
+		ret = of_property_read_u32(node, "samsung,geint-con", &val);
+		if (ret)
+			return NULL;
+		ctrl->geint_con = val;
+
+		ret = of_property_read_u32(node, "samsung,geint-mask", &val);
+		if (ret)
+			return NULL;
+		ctrl->geint_mask = val;
+
+		ret = of_property_read_u32(node, "samsung,geint-pend", &val);
+		if (ret)
+			return NULL;
+		ctrl->geint_pend = val;
+
+		ret = of_property_read_u32(node, "samsung,svc", &val);
+		if (ret)
+			return NULL;
+		ctrl->svc = val;
+
+		ctrl->eint_gpio_init = variant->eint_gpio_init;
+	}
+
+	ctrl->pin_banks = banks;
+	ctrl->nr_banks = bank_cnt;
+	ctrl->nr_gint = eint_cnt;
+	ctrl->label = node->name;
+	ctrl->eint_wkup_init = variant->eint_wkup_init;
+	ctrl->base = pin_base;
+	pin_base += ctrl->nr_pins;
+
+	return ctrl;
 }
 
 static int __devinit samsung_pinctrl_probe(struct platform_device *pdev)
@@ -860,7 +1025,7 @@ static int __devinit samsung_pinctrl_probe(struct platform_device *pdev)
 
 static const struct of_device_id samsung_pinctrl_dt_match[] = {
 	{ .compatible = "samsung,pinctrl-exynos4210",
-		.data = (void *)exynos4210_pin_ctrl },
+		.data = &exynos4_pin_ctrl },
 	{},
 };
 MODULE_DEVICE_TABLE(of, samsung_pinctrl_dt_match);
diff --git a/drivers/pinctrl/pinctrl-samsung.h b/drivers/pinctrl/pinctrl-samsung.h
index b895693..5d59ce6 100644
--- a/drivers/pinctrl/pinctrl-samsung.h
+++ b/drivers/pinctrl/pinctrl-samsung.h
@@ -123,7 +123,19 @@ struct samsung_pin_bank {
 	u8		pudpdn_width;
 	enum eint_type	eint_type;
 	u32		irq_base;
-	char		*name;
+	const char	*name;
+};
+
+/**
+ * struct samsung_pin_ctrl_variant: represents a pin controller variant.
+ * @eint_gpio_init: platform specific callback to setup the external gpio
+ *	interrupts for the controller.
+ * @eint_wkup_init: platform specific callback to setup the external wakeup
+ *	interrupts for the controller.
+ */
+struct samsung_pin_ctrl_variant {
+	int		(*eint_gpio_init)(struct samsung_pinctrl_drv_data *);
+	int		(*eint_wkup_init)(struct samsung_pinctrl_drv_data *);
 };
 
 /**
@@ -168,7 +180,7 @@ struct samsung_pin_ctrl {
 
 	int		(*eint_gpio_init)(struct samsung_pinctrl_drv_data *);
 	int		(*eint_wkup_init)(struct samsung_pinctrl_drv_data *);
-	char		*label;
+	const char	*label;
 };
 
 /**
@@ -235,5 +247,6 @@ struct samsung_pmx_func {
 
 /* list of all exported SoC specific data */
 extern struct samsung_pin_ctrl exynos4210_pin_ctrl[];
+extern struct samsung_pin_ctrl_variant exynos4_pin_ctrl;
 
 #endif /* __PINCTRL_SAMSUNG_H */
-- 
1.7.12
