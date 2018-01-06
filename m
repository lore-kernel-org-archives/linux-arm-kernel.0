From: stefan@agner.ch (Stefan Agner)
Date: Sat,  6 Jan 2018 15:25:49 +0100
Subject: [PATCH v2 1/5] pinctrl: imx: use struct imx_pinctrl_soc_info as a
 const
In-Reply-To: <20180106142553.15322-1-stefan@agner.ch>
References: <20180106142553.15322-1-stefan@agner.ch>
Message-ID: <20180106142553.15322-2-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For some SoCs the struct imx_pinctrl_soc_info is passed through
of_device_id.data which is const. Most variables are already const
or otherwise not written. However, some fields are modified at
runtime. Move those fields to the dynamically allocated struct
imx_pinctrl.

Fixes: b3060044e495 ("pinctrl: freescale: imx7d: make of_device_ids const")
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Gary Bisson <gary.bisson@boundarydevices.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/pinctrl/freescale/pinctrl-imx.c     | 79 ++++++++++++++---------------
 drivers/pinctrl/freescale/pinctrl-imx.h     | 11 ++--
 drivers/pinctrl/freescale/pinctrl-imx7ulp.c |  3 +-
 drivers/pinctrl/freescale/pinctrl-vf610.c   |  3 +-
 4 files changed, 44 insertions(+), 52 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 6e472691d8ee..86256d25c4a3 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -62,7 +62,6 @@ static int imx_dt_node_to_map(struct pinctrl_dev *pctldev,
 			struct pinctrl_map **map, unsigned *num_maps)
 {
 	struct imx_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
-	struct imx_pinctrl_soc_info *info = ipctl->info;
 	const struct group_desc *grp;
 	struct pinctrl_map *new_map;
 	struct device_node *parent;
@@ -75,7 +74,7 @@ static int imx_dt_node_to_map(struct pinctrl_dev *pctldev,
 	 */
 	grp = imx_pinctrl_find_group_by_name(pctldev, np->name);
 	if (!grp) {
-		dev_err(info->dev, "unable to find group for node %s\n",
+		dev_err(ipctl->dev, "unable to find group for node %s\n",
 			np->name);
 		return -EINVAL;
 	}
@@ -146,7 +145,7 @@ static int imx_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
 		       unsigned group)
 {
 	struct imx_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
-	struct imx_pinctrl_soc_info *info = ipctl->info;
+	const struct imx_pinctrl_soc_info *info = ipctl->info;
 	const struct imx_pin_reg *pin_reg;
 	unsigned int npins, pin_id;
 	int i;
@@ -174,7 +173,7 @@ static int imx_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
 		struct imx_pin *pin = &((struct imx_pin *)(grp->data))[i];
 
 		pin_id = pin->pin;
-		pin_reg = &info->pin_regs[pin_id];
+		pin_reg = &ipctl->pin_regs[pin_id];
 
 		if (pin_reg->mux_reg == -1) {
 			dev_dbg(ipctl->dev, "Pin(%s) does not support mux function\n",
@@ -255,7 +254,7 @@ static u32 imx_pinconf_decode_generic_config(struct imx_pinctrl *ipctl,
 					      unsigned long *configs,
 					      unsigned int num_configs)
 {
-	struct imx_pinctrl_soc_info *info = ipctl->info;
+	const struct imx_pinctrl_soc_info *info = ipctl->info;
 	struct imx_cfg_params_decode *decode;
 	enum pin_config_param param;
 	u32 raw_config = 0;
@@ -289,7 +288,7 @@ static u32 imx_pinconf_decode_generic_config(struct imx_pinctrl *ipctl,
 static u32 imx_pinconf_parse_generic_config(struct device_node *np,
 					    struct imx_pinctrl *ipctl)
 {
-	struct imx_pinctrl_soc_info *info = ipctl->info;
+	const struct imx_pinctrl_soc_info *info = ipctl->info;
 	struct pinctrl_dev *pctl = ipctl->pctl;
 	unsigned int num_configs;
 	unsigned long *configs;
@@ -310,11 +309,11 @@ static int imx_pinconf_get(struct pinctrl_dev *pctldev,
 			     unsigned pin_id, unsigned long *config)
 {
 	struct imx_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
-	struct imx_pinctrl_soc_info *info = ipctl->info;
-	const struct imx_pin_reg *pin_reg = &info->pin_regs[pin_id];
+	const struct imx_pinctrl_soc_info *info = ipctl->info;
+	const struct imx_pin_reg *pin_reg = &ipctl->pin_regs[pin_id];
 
 	if (pin_reg->conf_reg == -1) {
-		dev_err(info->dev, "Pin(%s) does not support config function\n",
+		dev_err(ipctl->dev, "Pin(%s) does not support config function\n",
 			info->pins[pin_id].name);
 		return -EINVAL;
 	}
@@ -332,12 +331,12 @@ static int imx_pinconf_set(struct pinctrl_dev *pctldev,
 			     unsigned num_configs)
 {
 	struct imx_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
-	struct imx_pinctrl_soc_info *info = ipctl->info;
-	const struct imx_pin_reg *pin_reg = &info->pin_regs[pin_id];
+	const struct imx_pinctrl_soc_info *info = ipctl->info;
+	const struct imx_pin_reg *pin_reg = &ipctl->pin_regs[pin_id];
 	int i;
 
 	if (pin_reg->conf_reg == -1) {
-		dev_err(info->dev, "Pin(%s) does not support config function\n",
+		dev_err(ipctl->dev, "Pin(%s) does not support config function\n",
 			info->pins[pin_id].name);
 		return -EINVAL;
 	}
@@ -368,8 +367,7 @@ static void imx_pinconf_dbg_show(struct pinctrl_dev *pctldev,
 				   struct seq_file *s, unsigned pin_id)
 {
 	struct imx_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
-	struct imx_pinctrl_soc_info *info = ipctl->info;
-	const struct imx_pin_reg *pin_reg = &info->pin_regs[pin_id];
+	const struct imx_pin_reg *pin_reg = &ipctl->pin_regs[pin_id];
 	unsigned long config;
 
 	if (!pin_reg || pin_reg->conf_reg == -1) {
@@ -427,13 +425,13 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
 				    struct imx_pinctrl *ipctl,
 				    u32 index)
 {
-	struct imx_pinctrl_soc_info *info = ipctl->info;
+	const struct imx_pinctrl_soc_info *info = ipctl->info;
 	int size, pin_size;
 	const __be32 *list;
 	int i;
 	u32 config;
 
-	dev_dbg(info->dev, "group(%d): %s\n", index, np->name);
+	dev_dbg(ipctl->dev, "group(%d): %s\n", index, np->name);
 
 	if (info->flags & SHARE_MUX_CONF_REG)
 		pin_size = SHARE_FSL_PIN_SIZE;
@@ -460,7 +458,7 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
 	if (!list) {
 		list = of_get_property(np, "pinmux", &size);
 		if (!list) {
-			dev_err(info->dev,
+			dev_err(ipctl->dev,
 				"no fsl,pins and pins property in node %pOF\n", np);
 			return -EINVAL;
 		}
@@ -468,7 +466,7 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
 
 	/* we do not check return since it's safe node passed down */
 	if (!size || size % pin_size) {
-		dev_err(info->dev, "Invalid fsl,pins or pins property in node %pOF\n", np);
+		dev_err(ipctl->dev, "Invalid fsl,pins or pins property in node %pOF\n", np);
 		return -EINVAL;
 	}
 
@@ -476,9 +474,9 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
 	config = imx_pinconf_parse_generic_config(np, ipctl);
 
 	grp->num_pins = size / pin_size;
-	grp->data = devm_kzalloc(info->dev, grp->num_pins *
+	grp->data = devm_kzalloc(ipctl->dev, grp->num_pins *
 				 sizeof(struct imx_pin), GFP_KERNEL);
-	grp->pins = devm_kzalloc(info->dev, grp->num_pins *
+	grp->pins = devm_kzalloc(ipctl->dev, grp->num_pins *
 				 sizeof(unsigned int), GFP_KERNEL);
 	if (!grp->pins || !grp->data)
 		return -ENOMEM;
@@ -502,7 +500,7 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
 		}
 
 		pin_id = (mux_reg != -1) ? mux_reg / 4 : conf_reg / 4;
-		pin_reg = &info->pin_regs[pin_id];
+		pin_reg = &ipctl->pin_regs[pin_id];
 		pin->pin = pin_id;
 		grp->pins[i] = pin_id;
 		pin_reg->mux_reg = mux_reg;
@@ -524,7 +522,7 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
 			pin->config = config & ~IMX_PAD_SION;
 		}
 
-		dev_dbg(info->dev, "%s: 0x%x 0x%08lx", info->pins[pin_id].name,
+		dev_dbg(ipctl->dev, "%s: 0x%x 0x%08lx", info->pins[pin_id].name,
 				pin->mux_mode, pin->config);
 	}
 
@@ -536,13 +534,12 @@ static int imx_pinctrl_parse_functions(struct device_node *np,
 				       u32 index)
 {
 	struct pinctrl_dev *pctl = ipctl->pctl;
-	struct imx_pinctrl_soc_info *info = ipctl->info;
 	struct device_node *child;
 	struct function_desc *func;
 	struct group_desc *grp;
 	u32 i = 0;
 
-	dev_dbg(info->dev, "parse function(%d): %s\n", index, np->name);
+	dev_dbg(pctl->dev, "parse function(%d): %s\n", index, np->name);
 
 	func = pinmux_generic_get_function(pctl, index);
 	if (!func)
@@ -552,10 +549,10 @@ static int imx_pinctrl_parse_functions(struct device_node *np,
 	func->name = np->name;
 	func->num_group_names = of_get_child_count(np);
 	if (func->num_group_names == 0) {
-		dev_err(info->dev, "no groups defined in %pOF\n", np);
+		dev_err(ipctl->dev, "no groups defined in %pOF\n", np);
 		return -EINVAL;
 	}
-	func->group_names = devm_kcalloc(info->dev, func->num_group_names,
+	func->group_names = devm_kcalloc(ipctl->dev, func->num_group_names,
 					 sizeof(char *), GFP_KERNEL);
 	if (!func->group_names)
 		return -ENOMEM;
@@ -563,15 +560,15 @@ static int imx_pinctrl_parse_functions(struct device_node *np,
 	for_each_child_of_node(np, child) {
 		func->group_names[i] = child->name;
 
-		grp = devm_kzalloc(info->dev, sizeof(struct group_desc),
+		grp = devm_kzalloc(ipctl->dev, sizeof(struct group_desc),
 				   GFP_KERNEL);
 		if (!grp)
 			return -ENOMEM;
 
-		mutex_lock(&info->mutex);
+		mutex_lock(&ipctl->mutex);
 		radix_tree_insert(&pctl->pin_group_tree,
-				  info->group_index++, grp);
-		mutex_unlock(&info->mutex);
+				  ipctl->group_index++, grp);
+		mutex_unlock(&ipctl->mutex);
 
 		imx_pinctrl_parse_groups(child, grp, ipctl, i++);
 	}
@@ -608,7 +605,6 @@ static int imx_pinctrl_probe_dt(struct platform_device *pdev,
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *child;
 	struct pinctrl_dev *pctl = ipctl->pctl;
-	struct imx_pinctrl_soc_info *info = ipctl->info;
 	u32 nfuncs = 0;
 	u32 i = 0;
 	bool flat_funcs;
@@ -635,13 +631,13 @@ static int imx_pinctrl_probe_dt(struct platform_device *pdev,
 		if (!function)
 			return -ENOMEM;
 
-		mutex_lock(&info->mutex);
+		mutex_lock(&ipctl->mutex);
 		radix_tree_insert(&pctl->pin_function_tree, i, function);
-		mutex_unlock(&info->mutex);
+		mutex_unlock(&ipctl->mutex);
 	}
 	pctl->num_functions = nfuncs;
 
-	info->group_index = 0;
+	ipctl->group_index = 0;
 	if (flat_funcs) {
 		pctl->num_groups = of_get_child_count(np);
 	} else {
@@ -672,7 +668,7 @@ static void imx_free_resources(struct imx_pinctrl *ipctl)
 }
 
 int imx_pinctrl_probe(struct platform_device *pdev,
-		      struct imx_pinctrl_soc_info *info)
+		      const struct imx_pinctrl_soc_info *info)
 {
 	struct regmap_config config = { .name = "gpr" };
 	struct device_node *dev_np = pdev->dev.of_node;
@@ -687,7 +683,6 @@ int imx_pinctrl_probe(struct platform_device *pdev,
 		dev_err(&pdev->dev, "wrong pinctrl info\n");
 		return -EINVAL;
 	}
-	info->dev = &pdev->dev;
 
 	if (info->gpr_compatible) {
 		gpr = syscon_regmap_lookup_by_compatible(info->gpr_compatible);
@@ -700,14 +695,14 @@ int imx_pinctrl_probe(struct platform_device *pdev,
 	if (!ipctl)
 		return -ENOMEM;
 
-	info->pin_regs = devm_kmalloc(&pdev->dev, sizeof(*info->pin_regs) *
+	ipctl->pin_regs = devm_kmalloc(&pdev->dev, sizeof(*ipctl->pin_regs) *
 				      info->npins, GFP_KERNEL);
-	if (!info->pin_regs)
+	if (!ipctl->pin_regs)
 		return -ENOMEM;
 
 	for (i = 0; i < info->npins; i++) {
-		info->pin_regs[i].mux_reg = -1;
-		info->pin_regs[i].conf_reg = -1;
+		ipctl->pin_regs[i].mux_reg = -1;
+		ipctl->pin_regs[i].conf_reg = -1;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -751,10 +746,10 @@ int imx_pinctrl_probe(struct platform_device *pdev,
 	/* platform specific callback */
 	imx_pmx_ops.gpio_set_direction = info->gpio_set_direction;
 
-	mutex_init(&info->mutex);
+	mutex_init(&ipctl->mutex);
 
 	ipctl->info = info;
-	ipctl->dev = info->dev;
+	ipctl->dev = &pdev->dev;
 	platform_set_drvdata(pdev, ipctl);
 	ret = devm_pinctrl_register_and_init(&pdev->dev,
 					     imx_pinctrl_desc, ipctl,
diff --git a/drivers/pinctrl/freescale/pinctrl-imx.h b/drivers/pinctrl/freescale/pinctrl-imx.h
index 5aa22b52c1d4..41ee75537da4 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.h
+++ b/drivers/pinctrl/freescale/pinctrl-imx.h
@@ -58,14 +58,10 @@ struct imx_cfg_params_decode {
 };
 
 struct imx_pinctrl_soc_info {
-	struct device *dev;
 	const struct pinctrl_pin_desc *pins;
 	unsigned int npins;
-	struct imx_pin_reg *pin_regs;
-	unsigned int group_index;
 	unsigned int flags;
 	const char *gpr_compatible;
-	struct mutex mutex;
 
 	/* MUX_MODE shift and mask in case SHARE_MUX_CONF_REG */
 	unsigned int mux_mask;
@@ -95,7 +91,10 @@ struct imx_pinctrl {
 	struct pinctrl_dev *pctl;
 	void __iomem *base;
 	void __iomem *input_sel_base;
-	struct imx_pinctrl_soc_info *info;
+	const struct imx_pinctrl_soc_info *info;
+	struct imx_pin_reg *pin_regs;
+	unsigned int group_index;
+	struct mutex mutex;
 };
 
 #define IMX_CFG_PARAMS_DECODE(p, m, o) \
@@ -117,5 +116,5 @@ struct imx_pinctrl {
 #define IOMUXC_CONFIG_SION	(0x1 << 4)
 
 int imx_pinctrl_probe(struct platform_device *pdev,
-			struct imx_pinctrl_soc_info *info);
+			const struct imx_pinctrl_soc_info *info);
 #endif /* __DRIVERS_PINCTRL_IMX_H */
diff --git a/drivers/pinctrl/freescale/pinctrl-imx7ulp.c b/drivers/pinctrl/freescale/pinctrl-imx7ulp.c
index b7bebb292f37..9161c984f57b 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx7ulp.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx7ulp.c
@@ -307,11 +307,10 @@ static int imx7ulp_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 					  unsigned offset, bool input)
 {
 	struct imx_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
-	struct imx_pinctrl_soc_info *info = ipctl->info;
 	const struct imx_pin_reg *pin_reg;
 	u32 reg;
 
-	pin_reg = &info->pin_regs[offset];
+	pin_reg = &ipctl->pin_regs[offset];
 	if (pin_reg->mux_reg == -1)
 		return -EINVAL;
 
diff --git a/drivers/pinctrl/freescale/pinctrl-vf610.c b/drivers/pinctrl/freescale/pinctrl-vf610.c
index ac18bb6d6d5e..42745c690be3 100644
--- a/drivers/pinctrl/freescale/pinctrl-vf610.c
+++ b/drivers/pinctrl/freescale/pinctrl-vf610.c
@@ -300,11 +300,10 @@ static int vf610_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 					unsigned offset, bool input)
 {
 	struct imx_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
-	struct imx_pinctrl_soc_info *info = ipctl->info;
 	const struct imx_pin_reg *pin_reg;
 	u32 reg;
 
-	pin_reg = &info->pin_regs[offset];
+	pin_reg = &ipctl->pin_regs[offset];
 	if (pin_reg->mux_reg == -1)
 		return -EINVAL;
 
-- 
2.15.1
