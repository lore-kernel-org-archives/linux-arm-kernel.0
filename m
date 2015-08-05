From: 21cnbao@gmail.com (Barry Song)
Date: Wed,  5 Aug 2015 03:22:14 +0000
Subject: [PATCH] pinctrl: atlas7: clear ugly branch statements for pull and
 drivestrength
Message-ID: <1438744934-15395-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Chen <Wei.Chen@csr.com>

To set/get atlas7 pull & drive strength, we use lots of if/else
to check pad type. But except mask value or immediate value, all
actions in these conditional branches are the same.
So we use predefined pull info table and drive strength table
to reduce these redundancy code.

Signed-off-by: Wei Chen <Wei.Chen@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/sirf/pinctrl-atlas7.c | 193 +++++++++++++++++-----------------
 1 file changed, 94 insertions(+), 99 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-atlas7.c b/drivers/pinctrl/sirf/pinctrl-atlas7.c
index d16e629..9df0c5f 100644
--- a/drivers/pinctrl/sirf/pinctrl-atlas7.c
+++ b/drivers/pinctrl/sirf/pinctrl-atlas7.c
@@ -3510,11 +3510,19 @@ struct atlas7_pinctrl_data atlas7_ioc_data = {
 	.confs_cnt = ARRAY_SIZE(atlas7_ioc_pad_confs),
 };
 
+/* Simple map data structure */
 struct map_data {
 	u8 idx;
 	u8 data;
 };
 
+/**
+ * struct atlas7_pull_info - Atlas7 Pad pull info
+ * @type:The type of this Pad.
+ * @mask:The mas value of this pin's pull bits.
+ * @v2s: The map of pull register value to pull status.
+ * @s2v: The map of pull status to pull register value.
+ */
 struct atlas7_pull_info {
 	u8 pad_type;
 	u8 mask;
@@ -3597,6 +3605,65 @@ static const struct atlas7_pull_info atlas7_pull_map[] = {
 	{ PAD_T_AD, PANGD_PULL_MASK, pangd_pull_v2s, pangd_pull_s2v },
 };
 
+/**
+ * struct atlas7_ds_ma_info - Atlas7 Pad DriveStrength & currents info
+ * @ma:		The Drive Strength in current value .
+ * @ds_16st:	The correspond raw value of 16st pad.
+ * @ds_4we:	The correspond raw value of 4we pad.
+ * @ds_0204m31:	The correspond raw value of 0204m31 pad.
+ * @ds_0610m31:	The correspond raw value of 0610m31 pad.
+ */
+struct atlas7_ds_ma_info {
+	u32 ma;
+	u32 ds_16st;
+	u32 ds_4we;
+	u32 ds_0204m31;
+	u32 ds_0610m31;
+};
+
+static const struct atlas7_ds_ma_info atlas7_ma2ds_map[] = {
+	{ 2, DS_16ST_0, DS_4WE_0, DS_M31_0, DS_NULL },
+	{ 4, DS_16ST_1, DS_NULL, DS_M31_1, DS_NULL },
+	{ 6, DS_16ST_2, DS_NULL, DS_NULL, DS_M31_0 },
+	{ 8, DS_16ST_3, DS_4WE_1, DS_NULL, DS_NULL },
+	{ 10, DS_16ST_4, DS_NULL, DS_NULL, DS_M31_1 },
+	{ 12, DS_16ST_5, DS_NULL, DS_NULL, DS_NULL },
+	{ 14, DS_16ST_6, DS_NULL, DS_NULL, DS_NULL },
+	{ 16, DS_16ST_7, DS_4WE_2, DS_NULL, DS_NULL },
+	{ 18, DS_16ST_8, DS_NULL, DS_NULL, DS_NULL },
+	{ 20, DS_16ST_9, DS_NULL, DS_NULL, DS_NULL },
+	{ 22, DS_16ST_10, DS_NULL, DS_NULL, DS_NULL },
+	{ 24, DS_16ST_11, DS_NULL, DS_NULL, DS_NULL },
+	{ 26, DS_16ST_12, DS_NULL, DS_NULL, DS_NULL },
+	{ 28, DS_16ST_13, DS_4WE_3, DS_NULL, DS_NULL },
+	{ 30, DS_16ST_14, DS_NULL, DS_NULL, DS_NULL },
+	{ 32, DS_16ST_15, DS_NULL, DS_NULL, DS_NULL },
+};
+
+/**
+ * struct atlas7_ds_info - Atlas7 Pad DriveStrength info
+ * @type:		The type of this Pad.
+ * @mask:		The mask value of this pin's pull bits.
+ * @imval:		The immediate value of drives trength register.
+ */
+struct atlas7_ds_info {
+	u8 type;
+	u8 mask;
+	u8 imval;
+	u8 reserved;
+};
+
+static const struct atlas7_ds_info atlas7_ds_map[] = {
+	{ PAD_T_4WE_PD, DS_2BIT_MASK, DS_2BIT_IM_VAL },
+	{ PAD_T_4WE_PU, DS_2BIT_MASK, DS_2BIT_IM_VAL },
+	{ PAD_T_16ST, DS_4BIT_MASK, DS_4BIT_IM_VAL },
+	{ PAD_T_M31_0204_PD, DS_1BIT_MASK, DS_1BIT_IM_VAL },
+	{ PAD_T_M31_0204_PU, DS_1BIT_MASK, DS_1BIT_IM_VAL },
+	{ PAD_T_M31_0610_PD, DS_1BIT_MASK, DS_1BIT_IM_VAL },
+	{ PAD_T_M31_0610_PU, DS_1BIT_MASK, DS_1BIT_IM_VAL },
+	{ PAD_T_AD, DS_NULL, DS_NULL },
+};
+
 static inline u32 atlas7_pin_to_bank(u32 pin)
 {
 	return (pin >= ATLAS7_PINCTRL_BANK_0_PINS) ? 1 : 0;
@@ -3799,70 +3866,27 @@ static int atlas7_pmx_set_mux(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
-struct atlas7_ds_info {
-	u32 ma;
-	u32 ds_16st;
-	u32 ds_4we;
-	u32 ds_0204m31;
-	u32 ds_0610m31;
-};
-
-const struct atlas7_ds_info atlas7_ds_map[] = {
-	{ 2, DS_16ST_0, DS_4WE_0, DS_M31_0, DS_NULL},
-	{ 4, DS_16ST_1, DS_NULL, DS_M31_1, DS_NULL},
-	{ 6, DS_16ST_2, DS_NULL, DS_NULL, DS_M31_0},
-	{ 8, DS_16ST_3, DS_4WE_1, DS_NULL, DS_NULL},
-	{ 10, DS_16ST_4, DS_NULL, DS_NULL, DS_M31_1},
-	{ 12, DS_16ST_5, DS_NULL, DS_NULL, DS_NULL},
-	{ 14, DS_16ST_6, DS_NULL, DS_NULL, DS_NULL},
-	{ 16, DS_16ST_7, DS_4WE_2, DS_NULL, DS_NULL},
-	{ 18, DS_16ST_8, DS_NULL, DS_NULL, DS_NULL},
-	{ 20, DS_16ST_9, DS_NULL, DS_NULL, DS_NULL},
-	{ 22, DS_16ST_10, DS_NULL, DS_NULL, DS_NULL},
-	{ 24, DS_16ST_11, DS_NULL, DS_NULL, DS_NULL},
-	{ 26, DS_16ST_12, DS_NULL, DS_NULL, DS_NULL},
-	{ 28, DS_16ST_13, DS_4WE_3, DS_NULL, DS_NULL},
-	{ 30, DS_16ST_14, DS_NULL, DS_NULL, DS_NULL},
-	{ 32, DS_16ST_15, DS_NULL, DS_NULL, DS_NULL},
-};
-
 static u32 convert_current_to_drive_strength(u32 type, u32 ma)
 {
 	int idx;
 
-	for (idx = 0; idx < ARRAY_SIZE(atlas7_ds_map); idx++) {
-		if (atlas7_ds_map[idx].ma != ma)
+	for (idx = 0; idx < ARRAY_SIZE(atlas7_ma2ds_map); idx++) {
+		if (atlas7_ma2ds_map[idx].ma != ma)
 			continue;
 
 		if (type == PAD_T_4WE_PD || type == PAD_T_4WE_PU)
-			return atlas7_ds_map[idx].ds_4we;
+			return atlas7_ma2ds_map[idx].ds_4we;
 		else if (type == PAD_T_16ST)
-			return atlas7_ds_map[idx].ds_16st;
+			return atlas7_ma2ds_map[idx].ds_16st;
 		else if (type == PAD_T_M31_0204_PD || type == PAD_T_M31_0204_PU)
-			return atlas7_ds_map[idx].ds_0204m31;
+			return atlas7_ma2ds_map[idx].ds_0204m31;
 		else if (type == PAD_T_M31_0610_PD || type == PAD_T_M31_0610_PU)
-			return atlas7_ds_map[idx].ds_0610m31;
+			return atlas7_ma2ds_map[idx].ds_0610m31;
 	}
 
 	return DS_NULL;
 }
 
-static u32 altas7_pinctrl_get_pull_sel(struct atlas7_pmx *pmx, u32 pin)
-{
-	struct atlas7_pad_config *conf = &pmx->pctl_data->confs[pin];
-	const struct atlas7_pull_info *pull_info;
-	int bank;
-	unsigned long regv;
-
-	bank = atlas7_pin_to_bank(pin);
-	pull_info = &atlas7_pull_map[conf->type];
-
-	regv = readl(pmx->regs[bank] + conf->pupd_reg);
-	regv = (regv >> conf->pupd_bit) & pull_info->mask;
-
-	return pull_info->v2s[regv].data;
-}
-
 static int altas7_pinctrl_set_pull_sel(struct pinctrl_dev *pctldev,
 					u32 pin, u32 sel)
 {
@@ -3871,19 +3895,17 @@ static int altas7_pinctrl_set_pull_sel(struct pinctrl_dev *pctldev,
 	const struct atlas7_pull_info *pull_info;
 	u32 bank;
 	unsigned long regv;
-	void __iomem *pull_sel_reg, *pull_clr_reg;
+	void __iomem *pull_sel_reg;
 
 	bank = atlas7_pin_to_bank(pin);
 	pull_info = &atlas7_pull_map[conf->type];
-
 	pull_sel_reg = pmx->regs[bank] + conf->pupd_reg;
-	pull_clr_reg = CLR_REG(pull_sel_reg);
 
 	/* Retrieve correspond register value from table by sel */
 	regv = pull_info->s2v[sel].data & pull_info->mask;
 
 	/* Clear & Set new value to pull register */
-	writel(pull_info->mask << conf->pupd_bit, pull_clr_reg);
+	writel(pull_info->mask << conf->pupd_bit, CLR_REG(pull_sel_reg));
 	writel(regv << conf->pupd_bit, pull_sel_reg);
 
 	pr_debug("PIN_CFG ### SET PIN#%d PULL SELECTOR:%d == OK ####\n",
@@ -3896,43 +3918,25 @@ static int __altas7_pinctrl_set_drive_strength_sel(struct pinctrl_dev *pctldev,
 {
 	struct atlas7_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
 	struct atlas7_pad_config *conf = &pmx->pctl_data->confs[pin];
-	u32 type = conf->type;
-	u32 shift = conf->drvstr_bit;
-	u32 bank = atlas7_pin_to_bank(pin);
-	void __iomem *ds_sel_reg, *ds_clr_reg;
-
-	ds_sel_reg = pmx->regs[bank] + conf->drvstr_reg;
-	ds_clr_reg = CLR_REG(ds_sel_reg);
-	if (type == PAD_T_4WE_PD || type == PAD_T_4WE_PU) {
-		if (sel & (~DS_2BIT_MASK))
-			goto unsupport;
-
-		writel(DS_2BIT_IM_VAL << shift, ds_clr_reg);
-		writel(sel << shift, ds_sel_reg);
-
-		return 0;
-	} else if (type == PAD_T_16ST) {
-		if (sel & (~DS_4BIT_MASK))
-			goto unsupport;
+	const struct atlas7_ds_info *ds_info;
+	u32 bank;
+	void __iomem *ds_sel_reg;
 
-		writel(DS_4BIT_IM_VAL << shift, ds_clr_reg);
-		writel(sel << shift, ds_sel_reg);
+	ds_info = &atlas7_ds_map[conf->type];
+	if (sel & (~(ds_info->mask)))
+		goto unsupport;
 
-		return 0;
-	} else if (type == PAD_T_M31_0204_PD ||	type == PAD_T_M31_0204_PU ||
-		type == PAD_T_M31_0610_PD || type == PAD_T_M31_0610_PU) {
-		if (sel & (~DS_1BIT_MASK))
-			goto unsupport;
+	bank = atlas7_pin_to_bank(pin);
+	ds_sel_reg = pmx->regs[bank] + conf->drvstr_reg;
 
-		writel(DS_1BIT_IM_VAL << shift, ds_clr_reg);
-		writel(sel << shift, ds_sel_reg);
+	writel(ds_info->imval << conf->drvstr_bit, CLR_REG(ds_sel_reg));
+	writel(sel << conf->drvstr_bit, ds_sel_reg);
 
-		return 0;
-	}
+	return 0;
 
 unsupport:
 	pr_err("Pad#%d type[%d] doesn't support ds code[%d]!\n",
-		pin, type, sel);
+		pin, conf->type, sel);
 	return -ENOTSUPP;
 }
 
@@ -4185,6 +4189,8 @@ static int atlas7_pinmux_suspend_noirq(struct device *dev)
 	struct atlas7_pmx *pmx = dev_get_drvdata(dev);
 	struct atlas7_pad_status *status;
 	struct atlas7_pad_config *conf;
+	const struct atlas7_ds_info *ds_info;
+	const struct atlas7_pull_info *pull_info;
 	int idx;
 	u32 bank;
 	unsigned long regv;
@@ -4212,27 +4218,16 @@ save_ds_sel:
 			goto save_pull_sel;
 
 		/* Save Drive Strength selector */
+		ds_info = &atlas7_ds_map[conf->type];
 		regv = readl(pmx->regs[bank] + conf->drvstr_reg);
-		if (PAD_T_4WE_PD == conf->type || PAD_T_4WE_PU == conf->type)
-			status->dstr = (regv >> conf->drvstr_bit) &
-					DS_2BIT_MASK;
-		else if (PAD_T_16ST == conf->type)
-			status->dstr = (regv >> conf->drvstr_bit) &
-					DS_4BIT_MASK;
-		else if (PAD_T_M31_0204_PD == conf->type ||
-			PAD_T_M31_0204_PU == conf->type ||
-			PAD_T_M31_0610_PD == conf->type ||
-			PAD_T_M31_0610_PU == conf->type)
-			status->dstr = (regv >> conf->drvstr_bit) &
-					DS_1BIT_MASK;
+		status->dstr = (regv >> conf->drvstr_bit) & ds_info->mask;
 
 save_pull_sel:
 		/* Save Pull selector */
+		pull_info = &atlas7_pull_map[conf->type];
 		regv = readl(pmx->regs[bank] + conf->pupd_reg);
-		status->pull = altas7_pinctrl_get_pull_sel(pmx, idx);
-		pr_debug("idx %d %p %x: %x %x %x\n", idx,
-				pmx->regs[bank], conf->mux_reg,
-				status->func, status->pull, status->dstr);
+		regv = (regv >> conf->pupd_bit) & pull_info->mask;
+		status->pull = pull_info->v2s[regv].data;
 	}
 
 	/*
-- 
2.3.5
