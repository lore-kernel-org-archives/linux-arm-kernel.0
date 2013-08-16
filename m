From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 16 Aug 2013 08:37:06 +0200
Subject: [PATCH 5/5] pinctrl: imx: Use struct type for pins
In-Reply-To: <CACRpkdZ6Ba=54cc036G34NJdpEhCXiCQpFnKi_eZFXumQSkeog@mail.gmail.com>
References: <1376050854-3303-1-git-send-email-s.hauer@pengutronix.de>
 <1376050854-3303-6-git-send-email-s.hauer@pengutronix.de>
 <CACRpkdZk4jz3dg6aoZqsMT5VXJUQxwrZOyAVLCU3UsExAXChAA@mail.gmail.com>
 <20130815050842.GF26614@pengutronix.de>
 <CACRpkdZ6Ba=54cc036G34NJdpEhCXiCQpFnKi_eZFXumQSkeog@mail.gmail.com>
Message-ID: <20130816063706.GL26614@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 10:11:47PM +0200, Linus Walleij wrote:
> On Thu, Aug 15, 2013 at 7:08 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Wed, Aug 14, 2013 at 10:41:20PM +0200, Linus Walleij wrote:
> >> On Fri, Aug 9, 2013 at 2:20 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >>
> >> > The i.MX pinctrl driver uses 5 different arrays for storing the
> >> > informations for pins. This requires five allocations. Instead,
> >> > use a struct type which is more cache friendly, readable and
> >> > requires less allocations. One array of integers is still needed
> >> > since the pinctrl framework forces us to maintain it.
> >> > This also adds checks whether the allocations are succesful which
> >> > were missing.
> >> >
> >> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> >>
> >> Hm appears to be dependent on 4/5 so can't apply this one
> >> in isolation ... but it looks good.
> >>
> >> Would be nice to have a handshake from Shawn and/or Dong
> >> on these patches BTW.
> >
> > What do you mean with handshake? Shawn acked the series.
> 
> Oh he did? I just haven't seen that message ... I have to look
> around.
> 
> But hm, 5/5 still does not apply cleanly after applying 4/5,
> I guess I have some alien patch in the pinctrl tree that you
> don't have, can you try to create a rebased version of this
> one patch on to of my "devel" branch?

Sure, here we go.

Sascha

8<--------------------------------------------------

>From bc70faee0f54a0e4c9ca047ca75864975aa5d0fd Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Sun, 28 Jul 2013 16:29:22 +0200
Subject: [PATCH] pinctrl: imx: Use struct type for pins

The i.MX pinctrl driver uses 5 different arrays for storing the
informations for pins. This requires five allocations. Instead,
use a struct type which is more cache friendly, readable and
requires less allocations. One array of integers is still needed
since the pinctrl framework forces us to maintain it.
This also adds checks whether the allocations are succesful which
were missing.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/pinctrl/pinctrl-imx.c | 79 ++++++++++++++++++++-----------------------
 drivers/pinctrl/pinctrl-imx.h | 36 ++++++++++++--------
 2 files changed, 58 insertions(+), 57 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
index 81ffb17..3a14245 100644
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
@@ -231,13 +226,13 @@ static int imx_pmx_enable(struct pinctrl_dev *pctldev, unsigned selector,
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
 
 		/*
 		 * If the select input value begins with 0xff, it's a quirky
@@ -252,8 +247,8 @@ static int imx_pmx_enable(struct pinctrl_dev *pctldev, unsigned selector,
 		 * in device tree, and then decode them here for setting
 		 * up the select input bits in general purpose register.
 		 */
-		if (input_val[i] >> 24 == 0xff) {
-			u32 val = input_val[i];
+		if (pin->input_val >> 24 == 0xff) {
+			u32 val = pin->input_val;
 			u8 select = val & 0xff;
 			u8 width = (val >> 8) & 0xff;
 			u8 shift = (val >> 16) & 0xff;
@@ -262,19 +257,19 @@ static int imx_pmx_enable(struct pinctrl_dev *pctldev, unsigned selector,
 			 * The input_reg[i] here is actually some IOMUXC general
 			 * purpose register, not regular select input register.
 			 */
-			val = readl(ipctl->base + input_reg[i]);
+			val = readl(ipctl->base + pin->input_val);
 			val &= ~mask;
 			val |= select << shift;
-			writel(val, ipctl->base + input_reg[i]);
-		} else if (input_reg[i]) {
+			writel(val, ipctl->base + pin->input_val);
+		} else if (pin->input_val) {
 			/*
 			 * Regular select input register can never be at offset
 			 * 0, and we only print register value for regular case.
 			 */
-			writel(input_val[i], ipctl->base + input_reg[i]);
+			writel(pin->input_val, ipctl->base + pin->input_reg);
 			dev_dbg(ipctl->dev,
 				"==>select_input: offset 0x%x val 0x%x\n",
-				input_reg[i], input_val[i]);
+				pin->input_reg, pin->input_val);
 		}
 	}
 
@@ -403,8 +398,9 @@ static void imx_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
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
@@ -468,21 +464,19 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
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
@@ -491,18 +485,19 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
 
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
1.8.4.rc2

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
