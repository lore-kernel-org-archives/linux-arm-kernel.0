From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  8 Jan 2017 22:31:15 +0100
Subject: [PATCH 1/3] pinctrl: sunxi: Add pinctrl variants
In-Reply-To: <cover.53580d3fc31eec98682d3d81f17be89610d397ee.1483911013.git-series.maxime.ripard@free-electrons.com>
References: <cover.53580d3fc31eec98682d3d81f17be89610d397ee.1483911013.git-series.maxime.ripard@free-electrons.com>
Message-ID: <e664022c7ea8177305c5c62676bd64f949caf7ab.1483911013.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some SoCs are either supposed to be pin compatible (A10 and A20 for
example), or are just repackaged versions of the same die (A10s, A13, GR8).

In those case, having a full blown pinctrl driver just introduces
duplication in both data size and maintainance effort.

Add a variant option to both pins and functions to be able to limit the
pins and functions described only to a subset of the SoC we support with a
given driver.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 77 ++++++++++++++++++++--------
 drivers/pinctrl/sunxi/pinctrl-sunxi.h | 26 ++++++++-
 2 files changed, 81 insertions(+), 22 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 0eb51e33cb1b..a69f7588e078 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -1041,21 +1041,35 @@ static int sunxi_pinctrl_build_state(struct platform_device *pdev)
 	struct sunxi_pinctrl *pctl = platform_get_drvdata(pdev);
 	int i;
 
-	pctl->ngroups = pctl->desc->npins;
+	/*
+	 * Allocate groups
+	 *
+	 * We assume that the number of groups is the number of pins
+	 * given in the data array.
 
-	/* Allocate groups */
+	 * This will not always be true, since some pins might not be
+	 * available in the current variant, but fortunately for us,
+	 * this means that the number of pins is the maximum group
+	 * number we will ever see.
+	 */
 	pctl->groups = devm_kzalloc(&pdev->dev,
-				    pctl->ngroups * sizeof(*pctl->groups),
+				    pctl->desc->npins * sizeof(*pctl->groups),
 				    GFP_KERNEL);
 	if (!pctl->groups)
 		return -ENOMEM;
 
 	for (i = 0; i < pctl->desc->npins; i++) {
 		const struct sunxi_desc_pin *pin = pctl->desc->pins + i;
-		struct sunxi_pinctrl_group *group = pctl->groups + i;
+		struct sunxi_pinctrl_group *group = pctl->groups + pctl->ngroups;
+
+		if (pin->variant && !(pctl->variant & pin->variant))
+			continue;
 
 		group->name = pin->pin.name;
 		group->pin = pin->pin.number;
+
+		/* And now we count the actual number of pins / groups */
+		pctl->ngroups++;
 	}
 
 	/*
@@ -1063,17 +1077,23 @@ static int sunxi_pinctrl_build_state(struct platform_device *pdev)
 	 * we'll reallocate that later anyway
 	 */
 	pctl->functions = devm_kzalloc(&pdev->dev,
-				pctl->desc->npins * sizeof(*pctl->functions),
-				GFP_KERNEL);
+				       pctl->ngroups * sizeof(*pctl->functions),
+				       GFP_KERNEL);
 	if (!pctl->functions)
 		return -ENOMEM;
 
 	/* Count functions and their associated groups */
 	for (i = 0; i < pctl->desc->npins; i++) {
 		const struct sunxi_desc_pin *pin = pctl->desc->pins + i;
-		struct sunxi_desc_function *func = pin->functions;
+		struct sunxi_desc_function *func;
+
+		if (pin->variant && !(pctl->variant & pin->variant))
+			continue;
+
+		for (func = pin->functions; func->name; func++) {
+			if (func->variant && !(pctl->variant & func->variant))
+				continue;
 
-		while (func->name) {
 			/* Create interrupt mapping while we're at it */
 			if (!strcmp(func->name, "irq")) {
 				int irqnum = func->irqnum + func->irqbank * IRQ_PER_BANK;
@@ -1081,22 +1101,32 @@ static int sunxi_pinctrl_build_state(struct platform_device *pdev)
 			}
 
 			sunxi_pinctrl_add_function(pctl, func->name);
-			func++;
 		}
 	}
 
+	/* And now allocated and fill the array for real */
 	pctl->functions = krealloc(pctl->functions,
-				pctl->nfunctions * sizeof(*pctl->functions),
-				GFP_KERNEL);
+				   pctl->nfunctions * sizeof(*pctl->functions),
+				   GFP_KERNEL);
+	if (!pctl->functions) {
+		kfree(pctl->functions);
+		return -ENOMEM;
+	}
 
 	for (i = 0; i < pctl->desc->npins; i++) {
 		const struct sunxi_desc_pin *pin = pctl->desc->pins + i;
-		struct sunxi_desc_function *func = pin->functions;
+		struct sunxi_desc_function *func;
 
-		while (func->name) {
+		if (pin->variant && !(pctl->variant & pin->variant))
+			continue;
+
+		for (func = pin->functions; func->name; func++) {
 			struct sunxi_pinctrl_function *func_item;
 			const char **func_grp;
 
+			if (func->variant && !(pctl->variant & func->variant))
+				continue;
+
 			func_item = sunxi_pinctrl_find_function_by_name(pctl,
 									func->name);
 			if (!func_item)
@@ -1116,7 +1146,6 @@ static int sunxi_pinctrl_build_state(struct platform_device *pdev)
 				func_grp++;
 
 			*func_grp = pin->pin.name;
-			func++;
 		}
 	}
 
@@ -1208,15 +1237,16 @@ static int sunxi_pinctrl_setup_debounce(struct sunxi_pinctrl *pctl,
 	return 0;
 }
 
-int sunxi_pinctrl_init(struct platform_device *pdev,
-		       const struct sunxi_pinctrl_desc *desc)
+int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
+				    const struct sunxi_pinctrl_desc *desc,
+				    unsigned long variant)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct pinctrl_desc *pctrl_desc;
 	struct pinctrl_pin_desc *pins;
 	struct sunxi_pinctrl *pctl;
 	struct resource *res;
-	int i, ret, last_pin;
+	int i, ret, last_pin, pin_idx;
 	struct clk *clk;
 
 	pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
@@ -1233,6 +1263,7 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
 
 	pctl->dev = &pdev->dev;
 	pctl->desc = desc;
+	pctl->variant = variant;
 
 	pctl->irq_array = devm_kcalloc(&pdev->dev,
 				       IRQ_PER_BANK * pctl->desc->irq_banks,
@@ -1253,8 +1284,14 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
 	if (!pins)
 		return -ENOMEM;
 
-	for (i = 0; i < pctl->desc->npins; i++)
-		pins[i] = pctl->desc->pins[i].pin;
+	for (i = 0, pin_idx = 0; i < pctl->desc->npins; i++) {
+		const struct sunxi_desc_pin *pin = pctl->desc->pins + i;
+
+		if (pin->variant && !(pctl->variant & pin->variant))
+			continue;
+
+		pins[pin_idx++] = pin->pin;
+	}
 
 	pctrl_desc = devm_kzalloc(&pdev->dev,
 				  sizeof(*pctrl_desc),
@@ -1265,7 +1302,7 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
 	pctrl_desc->name = dev_name(&pdev->dev);
 	pctrl_desc->owner = THIS_MODULE;
 	pctrl_desc->pins = pins;
-	pctrl_desc->npins = pctl->desc->npins;
+	pctrl_desc->npins = pctl->ngroups;
 	pctrl_desc->confops = &sunxi_pconf_ops;
 	pctrl_desc->pctlops = &sunxi_pctrl_ops;
 	pctrl_desc->pmxops =  &sunxi_pmx_ops;
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index f78a44a03189..539a3dd2d868 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -83,6 +83,7 @@
 #define SUN4I_FUNC_IRQ		6
 
 struct sunxi_desc_function {
+	unsigned long	variant;
 	const char	*name;
 	u8		muxval;
 	u8		irqbank;
@@ -91,6 +92,7 @@ struct sunxi_desc_function {
 
 struct sunxi_desc_pin {
 	struct pinctrl_pin_desc		pin;
+	unsigned long			variant;
 	struct sunxi_desc_function	*functions;
 };
 
@@ -128,6 +130,7 @@ struct sunxi_pinctrl {
 	unsigned			*irq_array;
 	spinlock_t			lock;
 	struct pinctrl_dev		*pctl_dev;
+	unsigned long			variant;
 };
 
 #define SUNXI_PIN(_pin, ...)					\
@@ -137,12 +140,27 @@ struct sunxi_pinctrl {
 			__VA_ARGS__, { } },			\
 	}
 
+#define SUNXI_PIN_VARIANT(_pin, _variant, ...)			\
+	{							\
+		.pin = _pin,					\
+		.variant = _variant,				\
+		.functions = (struct sunxi_desc_function[]){	\
+			__VA_ARGS__, { } },			\
+	}
+
 #define SUNXI_FUNCTION(_val, _name)				\
 	{							\
 		.name = _name,					\
 		.muxval = _val,					\
 	}
 
+#define SUNXI_FUNCTION_VARIANT(_val, _name, _variant)		\
+	{							\
+		.name = _name,					\
+		.muxval = _val,					\
+		.variant = _variant,				\
+	}
+
 #define SUNXI_FUNCTION_IRQ(_val, _irq)				\
 	{							\
 		.name = "irq",					\
@@ -290,7 +308,11 @@ static inline u32 sunxi_irq_status_offset(u16 irq)
 	return irq_num * IRQ_STATUS_IRQ_BITS;
 }
 
-int sunxi_pinctrl_init(struct platform_device *pdev,
-		       const struct sunxi_pinctrl_desc *desc);
+int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
+				    const struct sunxi_pinctrl_desc *desc,
+				    unsigned long variant);
+
+#define sunxi_pinctrl_init(_dev, _desc) \
+	sunxi_pinctrl_init_with_variant(_dev, _desc, 0)
 
 #endif /* __PINCTRL_SUNXI_H */
-- 
git-series 0.8.11
