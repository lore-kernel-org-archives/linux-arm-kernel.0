From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  9 Aug 2013 14:20:54 +0200
Subject: [PATCH 5/5] pinctrl: imx: Use struct type for pins
In-Reply-To: <1376050854-3303-1-git-send-email-s.hauer@pengutronix.de>
References: <1376050854-3303-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1376050854-3303-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX pinctrl driver uses 5 different arrays for storing the
informations for pins. This requires five allocations. Instead,
use a struct type which is more cache friendly, readable and
requires less allocations. One array of integers is still needed
since the pinctrl framework forces us to maintain it.
This also adds checks whether the allocations are succesful which
were missing.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/pinctrl/pinctrl-imx.c | 71 ++++++++++++++++++++-----------------------
 drivers/pinctrl/pinctrl-imx.h | 36 +++++++++++++---------
 2 files changed, 54 insertions(+), 53 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
index f3c38e0..587dc0a 100644
--- a/drivers/pinctrl/pinctrl-imx.c
+++ b/drivers/pinctrl/pinctrl-imx.c
@@ -98,7 +98,7 @@ static int imx_get_group_pins(struct pinctrl_dev *pctldev, unsigned selector,
 	if (selector >= info->ngroups)
 		return -EINVAL;
 
-	*pins = info->groups[selector].pins;
+	*pins = info->groups[selector].pin_ids;
 	*npins = info->groups[selector].npins;
 
 	return 0;
@@ -134,7 +134,7 @@ static int imx_dt_node_to_map(struct pinctrl_dev *pctldev,
 	}
 
 	for (i = 0; i < grp->npins; i++) {
-		if (!(grp->configs[i] & IMX_NO_PAD_CTL))
+		if (!(grp->pins[i].config & IMX_NO_PAD_CTL))
 			map_num++;
 	}
 
@@ -159,11 +159,11 @@ static int imx_dt_node_to_map(struct pinctrl_dev *pctldev,
 	/* create config map */
 	new_map++;
 	for (i = j = 0; i < grp->npins; i++) {
-		if (!(grp->configs[i] & IMX_NO_PAD_CTL)) {
+		if (!(grp->pins[i].config & IMX_NO_PAD_CTL)) {
 			new_map[j].type = PIN_MAP_TYPE_CONFIGS_PIN;
 			new_map[j].data.configs.group_or_pin =
-					pin_get_name(pctldev, grp->pins[i]);
-			new_map[j].data.configs.configs = &grp->configs[i];
+					pin_get_name(pctldev, grp->pins[i].pin);
+			new_map[j].data.configs.configs = &grp->pins[i].config;
 			new_map[j].data.configs.num_configs = 1;
 			j++;
 		}
@@ -197,28 +197,23 @@ static int imx_pmx_enable(struct pinctrl_dev *pctldev, unsigned selector,
 	struct imx_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
 	const struct imx_pinctrl_soc_info *info = ipctl->info;
 	const struct imx_pin_reg *pin_reg;
-	const unsigned *pins, *mux, *input_val;
-	u16 *input_reg;
 	unsigned int npins, pin_id;
 	int i;
+	struct imx_pin_group *grp;
 
 	/*
 	 * Configure the mux mode for each pin in the group for a specific
 	 * function.
 	 */
-	pins = info->groups[group].pins;
-	npins = info->groups[group].npins;
-	mux = info->groups[group].mux_mode;
-	input_val = info->groups[group].input_val;
-	input_reg = info->groups[group].input_reg;
-
-	WARN_ON(!pins || !npins || !mux || !input_val || !input_reg);
+	grp = &info->groups[group];
+	npins = grp->npins;
 
 	dev_dbg(ipctl->dev, "enable function %s group %s\n",
-		info->functions[selector].name, info->groups[group].name);
+		info->functions[selector].name, grp->name);
 
 	for (i = 0; i < npins; i++) {
-		pin_id = pins[i];
+		struct imx_pin *pin = &grp->pins[i];
+		pin_id = pin->pin;
 		pin_reg = &info->pin_regs[pin_id];
 
 		if (!(info->flags & ZERO_OFFSET_VALID) && !pin_reg->mux_reg) {
@@ -231,20 +226,20 @@ static int imx_pmx_enable(struct pinctrl_dev *pctldev, unsigned selector,
 			u32 reg;
 			reg = readl(ipctl->base + pin_reg->mux_reg);
 			reg &= ~(0x7 << 20);
-			reg |= (mux[i] << 20);
+			reg |= (pin->mux_mode << 20);
 			writel(reg, ipctl->base + pin_reg->mux_reg);
 		} else {
-			writel(mux[i], ipctl->base + pin_reg->mux_reg);
+			writel(pin->mux_mode, ipctl->base + pin_reg->mux_reg);
 		}
 		dev_dbg(ipctl->dev, "write: offset 0x%x val 0x%x\n",
-			pin_reg->mux_reg, mux[i]);
+			pin_reg->mux_reg, pin->mux_mode);
 
 		/* some pins also need select input setting, set it if found */
-		if (input_reg[i]) {
-			writel(input_val[i], ipctl->base + input_reg[i]);
+		if (pin->input_reg) {
+			writel(pin->input_val, ipctl->base + pin->input_reg);
 			dev_dbg(ipctl->dev,
 				"==>select_input: offset 0x%x val 0x%x\n",
-				input_reg[i], input_val[i]);
+				pin->input_reg, pin->input_val);
 		}
 	}
 
@@ -373,8 +368,9 @@ static void imx_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
 	seq_printf(s, "\n");
 	grp = &info->groups[group];
 	for (i = 0; i < grp->npins; i++) {
-		name = pin_get_name(pctldev, grp->pins[i]);
-		ret = imx_pinconf_get(pctldev, grp->pins[i], &config);
+		struct imx_pin *pin = &grp->pins[i];
+		name = pin_get_name(pctldev, pin->pin);
+		ret = imx_pinconf_get(pctldev, pin->pin, &config);
 		if (ret)
 			return;
 		seq_printf(s, "%s: 0x%lx", name, config);
@@ -438,21 +434,19 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
 	}
 
 	grp->npins = size / pin_size;
-	grp->pins = devm_kzalloc(info->dev, grp->npins * sizeof(unsigned int),
-				GFP_KERNEL);
-	grp->mux_mode = devm_kzalloc(info->dev, grp->npins * sizeof(unsigned int),
+	grp->pins = devm_kzalloc(info->dev, grp->npins * sizeof(struct imx_pin),
 				GFP_KERNEL);
-	grp->input_reg = devm_kzalloc(info->dev, grp->npins * sizeof(u16),
-				GFP_KERNEL);
-	grp->input_val = devm_kzalloc(info->dev, grp->npins * sizeof(unsigned int),
-				GFP_KERNEL);
-	grp->configs = devm_kzalloc(info->dev, grp->npins * sizeof(unsigned long),
+	grp->pin_ids = devm_kzalloc(info->dev, grp->npins * sizeof(unsigned int),
 				GFP_KERNEL);
+	if (!grp->pins || ! grp->pin_ids)
+		return -ENOMEM;
+
 	for (i = 0; i < grp->npins; i++) {
 		u32 mux_reg = be32_to_cpu(*list++);
 		u32 conf_reg;
 		unsigned int pin_id;
 		struct imx_pin_reg *pin_reg;
+		struct imx_pin *pin = &grp->pins[i];
 
 		if (info->flags & SHARE_MUX_CONF_REG)
 			conf_reg = mux_reg;
@@ -461,18 +455,19 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
 
 		pin_id = mux_reg ? mux_reg / 4 : conf_reg / 4;
 		pin_reg = &info->pin_regs[pin_id];
-		grp->pins[i] = pin_id;
+		pin->pin = pin_id;
+		grp->pin_ids[i] = pin_id;
 		pin_reg->mux_reg = mux_reg;
 		pin_reg->conf_reg = conf_reg;
-		grp->input_reg[i] = be32_to_cpu(*list++);
-		grp->mux_mode[i] = be32_to_cpu(*list++);
-		grp->input_val[i] = be32_to_cpu(*list++);
+		pin->input_reg = be32_to_cpu(*list++);
+		pin->mux_mode = be32_to_cpu(*list++);
+		pin->input_val = be32_to_cpu(*list++);
 
 		/* SION bit is in mux register */
 		config = be32_to_cpu(*list++);
 		if (config & IMX_PAD_SION)
-			grp->mux_mode[i] |= IOMUXC_CONFIG_SION;
-		grp->configs[i] = config & ~IMX_PAD_SION;
+			pin->mux_mode |= IOMUXC_CONFIG_SION;
+		pin->config = config & ~IMX_PAD_SION;
 	}
 
 #ifdef DEBUG
diff --git a/drivers/pinctrl/pinctrl-imx.h b/drivers/pinctrl/pinctrl-imx.h
index bcedd99..db408b0 100644
--- a/drivers/pinctrl/pinctrl-imx.h
+++ b/drivers/pinctrl/pinctrl-imx.h
@@ -18,29 +18,35 @@
 struct platform_device;
 
 /**
+ * struct imx_pin_group - describes a single i.MX pin
+ * @pin: the pin_id of this pin
+ * @mux_mode: the mux mode for this pin.
+ * @input_reg: the select input register offset for this pin if any
+ *	0 if no select input setting needed.
+ * @input_val: the select input value for this pin.
+ * @configs: the config for this pin.
+ */
+struct imx_pin {
+	unsigned int pin;
+	unsigned int mux_mode;
+	u16 input_reg;
+	unsigned int input_val;
+	unsigned long config;
+};
+
+/**
  * struct imx_pin_group - describes an IMX pin group
  * @name: the name of this specific pin group
- * @pins: an array of discrete physical pins used in this group, taken
- *	from the driver-local pin enumeration space
  * @npins: the number of pins in this group array, i.e. the number of
  *	elements in .pins so we can iterate over that array
- * @mux_mode: the mux mode for each pin in this group. The size of this
- *	array is the same as pins.
- * @input_reg: select input register offset for this mux if any
- *	0 if no select input setting needed.
- * @input_val: the select input value for each pin in this group. The size of
- *	this array is the same as pins.
- * @configs: the config for each pin in this group. The size of this
- *	array is the same as pins.
+ * @pin_ids: array of pin_ids. pinctrl forces us to maintain such an array
+ * @pins: array of pins
  */
 struct imx_pin_group {
 	const char *name;
-	unsigned int *pins;
 	unsigned npins;
-	unsigned int *mux_mode;
-	u16 *input_reg;
-	unsigned int *input_val;
-	unsigned long *configs;
+	unsigned int *pin_ids;
+	struct imx_pin *pins;
 };
 
 /**
-- 
1.8.4.rc1
