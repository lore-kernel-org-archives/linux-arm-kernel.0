From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 27 Jul 2015 11:57:25 +0000
Subject: [PATCH] pinctrl: sirf: add power management support for atlas7
Message-ID: <1437998245-13135-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Chen <Wei.Chen@csr.com>

We had not implemented the pm interface of atlas7 pinctrl
and gpio drivers. So when system resumes from sleep, all
pin configuration and gpio status will be lost.

Now, we implement these interfaces to support pm.

At the same time, this patch also drops a lot of if-else
by look-up table for getting and setting pull.

Signed-off-by: Wei Chen <Wei.Chen@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/sirf/pinctrl-atlas7.c | 393 ++++++++++++++++++++++++++++------
 1 file changed, 326 insertions(+), 67 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-atlas7.c b/drivers/pinctrl/sirf/pinctrl-atlas7.c
index 9384e0a..95dbe55 100644
--- a/drivers/pinctrl/sirf/pinctrl-atlas7.c
+++ b/drivers/pinctrl/sirf/pinctrl-atlas7.c
@@ -148,6 +148,19 @@ enum altas7_pad_type {
 #define DIV_DISABLE	0x1
 #define DIV_ENABLE	0x0
 
+/* Number of Function input disable registers */
+#define NUM_OF_IN_DISABLE_REG	0x2
+
+/* Offset of Function input disable registers */
+#define IN_DISABLE_0_REG_SET		0x0A00
+#define IN_DISABLE_0_REG_CLR		0x0A04
+#define IN_DISABLE_1_REG_SET		0x0A08
+#define IN_DISABLE_1_REG_CLR		0x0A0C
+#define IN_DISABLE_VAL_0_REG_SET	0x0A80
+#define IN_DISABLE_VAL_0_REG_CLR	0x0A84
+#define IN_DISABLE_VAL_1_REG_SET	0x0A88
+#define IN_DISABLE_VAL_1_REG_CLR	0x0A8C
+
 struct dt_params {
 	const char *property;
 	int value;
@@ -197,6 +210,16 @@ struct atlas7_pad_config {
 	}
 
 /**
+ * struct atlas7_pad_status - Atlas7 Pad status
+ */
+struct atlas7_pad_status {
+	u8 func;
+	u8 pull;
+	u8 dstr;
+	u8 reserved;
+};
+
+/**
  * struct atlas7_pad_mux - Atlas7 mux
  * @bank:		The bank of this pad's registers on.
  * @pin	:		The ID of this Pad.
@@ -285,6 +308,9 @@ struct atlas7_pinctrl_data {
 /* Platform info of atlas7 pinctrl */
 #define ATLAS7_PINCTRL_REG_BANKS	2
 #define ATLAS7_PINCTRL_BANK_0_PINS	18
+#define ATLAS7_PINCTRL_BANK_1_PINS	141
+#define ATLAS7_PINCTRL_TOTAL_PINS	\
+	(ATLAS7_PINCTRL_BANK_0_PINS + ATLAS7_PINCTRL_BANK_1_PINS)
 
 /**
  * Atlas7 GPIO Chip
@@ -316,6 +342,7 @@ struct atlas7_gpio_bank {
 	unsigned int gpio_offset;
 	unsigned int ngpio;
 	const unsigned int *gpio_pins;
+	u32 sleep_data[NGPIO_OF_BANK];
 };
 
 struct atlas7_gpio_chip {
@@ -343,6 +370,9 @@ struct atlas7_pmx {
 	struct pinctrl_desc pctl_desc;
 	struct atlas7_pinctrl_data *pctl_data;
 	void __iomem *regs[ATLAS7_PINCTRL_REG_BANKS];
+	u32 status_ds[NUM_OF_IN_DISABLE_REG];
+	u32 status_dsv[NUM_OF_IN_DISABLE_REG];
+	struct atlas7_pad_status sleep_data[ATLAS7_PINCTRL_TOTAL_PINS];
 };
 
 /*
@@ -3480,6 +3510,93 @@ struct atlas7_pinctrl_data atlas7_ioc_data = {
 	.confs_cnt = ARRAY_SIZE(atlas7_ioc_pad_confs),
 };
 
+struct map_data {
+	u8 idx;
+	u8 data;
+};
+
+struct atlas7_pull_info {
+	u8 pad_type;
+	u8 mask;
+	const struct map_data *v2s;
+	const struct map_data *s2v;
+};
+
+/* Pull Register value map to status */
+static const struct map_data p4we_pull_v2s[] = {
+	{ P4WE_PULL_UP, PULL_UP },
+	{ P4WE_HIGH_HYSTERESIS, HIGH_HYSTERESIS },
+	{ P4WE_HIGH_Z, HIGH_Z },
+	{ P4WE_PULL_DOWN, PULL_DOWN },
+};
+
+static const struct map_data p16st_pull_v2s[] = {
+	{ P16ST_PULL_UP, PULL_UP },
+	{ PD, PULL_UNKNOWN },
+	{ P16ST_HIGH_Z, HIGH_Z },
+	{ P16ST_PULL_DOWN, PULL_DOWN },
+};
+
+static const struct map_data pm31_pull_v2s[] = {
+	{ PM31_PULL_DISABLED, PULL_DOWN },
+	{ PM31_PULL_ENABLED, PULL_UP },
+};
+
+static const struct map_data pangd_pull_v2s[] = {
+	{ PANGD_PULL_UP, PULL_UP },
+	{ PD, PULL_UNKNOWN },
+	{ PANGD_HIGH_Z, HIGH_Z },
+	{ PANGD_PULL_DOWN, PULL_DOWN },
+};
+
+/* Pull status map to register value */
+static const struct map_data p4we_pull_s2v[] = {
+	{ PULL_UP, P4WE_PULL_UP },
+	{ HIGH_HYSTERESIS, P4WE_HIGH_HYSTERESIS },
+	{ HIGH_Z, P4WE_HIGH_Z },
+	{ PULL_DOWN, P4WE_PULL_DOWN },
+	{ PULL_DISABLE, -1 },
+	{ PULL_ENABLE, -1 },
+};
+
+static const struct map_data p16st_pull_s2v[] = {
+	{ PULL_UP, P16ST_PULL_UP },
+	{ HIGH_HYSTERESIS, -1 },
+	{ HIGH_Z, P16ST_HIGH_Z },
+	{ PULL_DOWN, P16ST_PULL_DOWN },
+	{ PULL_DISABLE, -1 },
+	{ PULL_ENABLE, -1 },
+};
+
+static const struct map_data pm31_pull_s2v[] = {
+	{ PULL_UP, PM31_PULL_ENABLED },
+	{ HIGH_HYSTERESIS, -1 },
+	{ HIGH_Z, -1 },
+	{ PULL_DOWN, PM31_PULL_DISABLED },
+	{ PULL_DISABLE, -1 },
+	{ PULL_ENABLE, -1 },
+};
+
+static const struct map_data pangd_pull_s2v[] = {
+	{ PULL_UP, PANGD_PULL_UP },
+	{ HIGH_HYSTERESIS, -1 },
+	{ HIGH_Z, PANGD_HIGH_Z },
+	{ PULL_DOWN, PANGD_PULL_DOWN },
+	{ PULL_DISABLE, -1 },
+	{ PULL_ENABLE, -1 },
+};
+
+static const struct atlas7_pull_info atlas7_pull_map[] = {
+	{ PAD_T_4WE_PD, P4WE_PULL_MASK, p4we_pull_v2s, p4we_pull_s2v },
+	{ PAD_T_4WE_PU, P4WE_PULL_MASK, p4we_pull_v2s, p4we_pull_s2v },
+	{ PAD_T_16ST, P16ST_PULL_MASK, p16st_pull_v2s, p16st_pull_s2v },
+	{ PAD_T_M31_0204_PD, PM31_PULL_MASK, pm31_pull_v2s, pm31_pull_s2v },
+	{ PAD_T_M31_0204_PU, PM31_PULL_MASK, pm31_pull_v2s, pm31_pull_s2v },
+	{ PAD_T_M31_0610_PD, PM31_PULL_MASK, pm31_pull_v2s, pm31_pull_s2v },
+	{ PAD_T_M31_0610_PU, PM31_PULL_MASK, pm31_pull_v2s, pm31_pull_s2v },
+	{ PAD_T_AD, PANGD_PULL_MASK, pangd_pull_v2s, pangd_pull_s2v },
+};
+
 static inline u32 atlas7_pin_to_bank(u32 pin)
 {
 	return (pin >= ATLAS7_PINCTRL_BANK_0_PINS) ? 1 : 0;
@@ -3730,83 +3847,44 @@ static u32 convert_current_to_drive_strength(u32 type, u32 ma)
 	return DS_NULL;
 }
 
+static u32 altas7_pinctrl_get_pull_sel(struct atlas7_pmx *pmx, u32 pin)
+{
+	struct atlas7_pad_config *conf = &pmx->pctl_data->confs[pin];
+	const struct atlas7_pull_info *pull_info;
+	int bank;
+	unsigned long regv;
+
+	bank = atlas7_pin_to_bank(pin);
+	pull_info = &atlas7_pull_map[conf->type];
+
+	regv = readl(pmx->regs[bank] + conf->pupd_reg);
+	regv = (regv >> conf->pupd_bit) & pull_info->mask;
+
+	return pull_info->v2s[regv].data;
+}
+
 static int altas7_pinctrl_set_pull_sel(struct pinctrl_dev *pctldev,
 					u32 pin, u32 sel)
 {
 	struct atlas7_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
 	struct atlas7_pad_config *conf = &pmx->pctl_data->confs[pin];
-	u32 type = conf->type;
-	u32 shift = conf->pupd_bit;
-	u32 bank = atlas7_pin_to_bank(pin);
+	const struct atlas7_pull_info *pull_info;
+	u32 bank;
+	unsigned long regv;
 	void __iomem *pull_sel_reg, *pull_clr_reg;
 
+	bank = atlas7_pin_to_bank(pin);
+	pull_info = &atlas7_pull_map[conf->type];
+
 	pull_sel_reg = pmx->regs[bank] + conf->pupd_reg;
 	pull_clr_reg = CLR_REG(pull_sel_reg);
 
-	if (type == PAD_T_4WE_PD || type == PAD_T_4WE_PU) {
-		writel(P4WE_PULL_MASK << shift, pull_clr_reg);
-
-		if (sel == PULL_UP)
-			writel(P4WE_PULL_UP << shift, pull_sel_reg);
-		else if (sel == HIGH_HYSTERESIS)
-			writel(P4WE_HIGH_HYSTERESIS << shift, pull_sel_reg);
-		else if (sel == HIGH_Z)
-			writel(P4WE_HIGH_Z << shift, pull_sel_reg);
-		else if (sel == PULL_DOWN)
-			writel(P4WE_PULL_DOWN << shift, pull_sel_reg);
-		else {
-			pr_err("Unknown Pull select type for 4WEPAD#%d\n",
-				pin);
-			return -ENOTSUPP;
-		}
-	} else if (type == PAD_T_16ST) {
-		writel(P16ST_PULL_MASK << shift, pull_clr_reg);
-
-		if (sel == PULL_UP)
-			writel(P16ST_PULL_UP << shift, pull_sel_reg);
-		else if (sel == HIGH_Z)
-			writel(P16ST_HIGH_Z << shift, pull_sel_reg);
-		else if (sel == PULL_DOWN)
-			writel(P16ST_PULL_DOWN << shift, pull_sel_reg);
-		else {
-			pr_err("Unknown Pull select type for 16STPAD#%d\n",
-				pin);
-			return -ENOTSUPP;
-		}
-	} else if (type == PAD_T_M31_0204_PD ||
-		type == PAD_T_M31_0204_PU ||
-		type == PAD_T_M31_0610_PD ||
-		type == PAD_T_M31_0610_PU) {
-		writel(PM31_PULL_MASK << shift, pull_clr_reg);
-
-		if (sel == PULL_UP)
-			writel(PM31_PULL_ENABLED << shift, pull_sel_reg);
-		else if (sel == PULL_DOWN)
-			writel(PM31_PULL_DISABLED << shift, pull_sel_reg);
-		else {
-			pr_err("Unknown Pull select type for M31PAD#%d\n",
-				pin);
-			return -ENOTSUPP;
-		}
-	} else if (type == PAD_T_AD) {
-		writel(PANGD_PULL_MASK << shift, pull_clr_reg);
-
-		if (sel == PULL_UP)
-			writel(PANGD_PULL_UP << shift, pull_sel_reg);
-		else if (sel == HIGH_Z)
-			writel(PANGD_HIGH_Z << shift, pull_sel_reg);
-		else if (sel == PULL_DOWN)
-			writel(PANGD_PULL_DOWN << shift, pull_sel_reg);
-		else {
-			pr_err("Unknown Pull select type for A/D PAD#%d\n",
-				pin);
-			return -ENOTSUPP;
-		}
-	} else {
-			pr_err("Unknown Pad type[%d] for pull select PAD#%d\n",
-				type, pin);
-			return -ENOTSUPP;
-	}
+	/* Retrieve correspond register value from table by sel */
+	regv = pull_info->s2v[sel].data & pull_info->mask;
+
+	/* Clear & Set new value to pull register */
+	writel(pull_info->mask << conf->pupd_bit, pull_clr_reg);
+	writel(regv << conf->pupd_bit, pull_sel_reg);
 
 	pr_debug("PIN_CFG ### SET PIN#%d PULL SELECTOR:%d == OK ####\n",
 		pin, sel);
@@ -4101,14 +4179,144 @@ unmap_io:
 	return ret;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int atlas7_pinmux_suspend_noirq(struct device *dev)
+{
+	struct atlas7_pmx *pmx = dev_get_drvdata(dev);
+	struct atlas7_pad_status *status;
+	struct atlas7_pad_config *conf;
+	int idx;
+	u32 bank;
+	unsigned long regv;
+
+	for (idx = 0; idx < pmx->pctl_desc.npins; idx++) {
+		/* Get this Pad's descriptor from PINCTRL */
+		conf = &pmx->pctl_data->confs[idx];
+		bank = atlas7_pin_to_bank(idx);
+		status = &pmx->sleep_data[idx];
+
+		/* Save Function selector */
+		regv = readl(pmx->regs[bank] + conf->mux_reg);
+		status->func = (regv >> conf->mux_bit) & FUNC_CLEAR_MASK;
+
+		/* Check if Pad is in Analogue selector */
+		if (conf->ad_ctrl_reg == -1)
+			goto save_ds_sel;
+
+		regv = readl(pmx->regs[bank] + conf->ad_ctrl_reg);
+		if (!(regv & (conf->ad_ctrl_bit << ANA_CLEAR_MASK)))
+			status->func = FUNC_ANALOGUE;
+
+save_ds_sel:
+		if (conf->drvstr_reg == -1)
+			goto save_pull_sel;
+
+		/* Save Drive Strength selector */
+		regv = readl(pmx->regs[bank] + conf->drvstr_reg);
+		if (PAD_T_4WE_PD == conf->type || PAD_T_4WE_PU == conf->type)
+			status->dstr = (regv >> conf->drvstr_bit) &
+					DS_2BIT_MASK;
+		else if (PAD_T_16ST == conf->type)
+			status->dstr = (regv >> conf->drvstr_bit) &
+					DS_4BIT_MASK;
+		else if (PAD_T_M31_0204_PD == conf->type ||
+			PAD_T_M31_0204_PU == conf->type ||
+			PAD_T_M31_0610_PD == conf->type ||
+			PAD_T_M31_0610_PU == conf->type)
+			status->dstr = (regv >> conf->drvstr_bit) &
+					DS_1BIT_MASK;
+
+save_pull_sel:
+		/* Save Pull selector */
+		regv = readl(pmx->regs[bank] + conf->pupd_reg);
+		status->pull = altas7_pinctrl_get_pull_sel(pmx, idx);
+		pr_debug("idx %d %p %x: %x %x %x\n", idx,
+				pmx->regs[bank], conf->mux_reg,
+				status->func, status->pull, status->dstr);
+	}
+
+	/*
+	 * Save disable input selector, this selector is not for Pin,
+	 * but for Mux function.
+	 */
+	for (idx = 0; idx < NUM_OF_IN_DISABLE_REG; idx++) {
+		pmx->status_ds[idx] = readl(pmx->regs[BANK_DS] +
+					IN_DISABLE_0_REG_SET + 0x8 * idx);
+		pmx->status_dsv[idx] = readl(pmx->regs[BANK_DS] +
+					IN_DISABLE_VAL_0_REG_SET + 0x8 * idx);
+	}
+
+	return 0;
+}
+
+static int atlas7_pinmux_resume_noirq(struct device *dev)
+{
+	struct atlas7_pmx *pmx = dev_get_drvdata(dev);
+	struct atlas7_pad_status *status;
+	struct atlas7_pad_config *conf;
+	int idx;
+	u32 bank;
+
+	for (idx = 0; idx < pmx->pctl_desc.npins; idx++) {
+		/* Get this Pad's descriptor from PINCTRL */
+		conf = &pmx->pctl_data->confs[idx];
+		bank = atlas7_pin_to_bank(idx);
+		status = &pmx->sleep_data[idx];
+
+		/* Restore Function selector */
+		__atlas7_pmx_pin_enable(pmx, idx, (u32)status->func & 0xff);
+
+		if (FUNC_ANALOGUE == status->func)
+			goto restore_pull_sel;
+
+		/* Restore Drive Strength selector */
+		__altas7_pinctrl_set_drive_strength_sel(pmx->pctl, idx,
+						(u32)status->dstr & 0xff);
+
+restore_pull_sel:
+		/* Restore Pull selector */
+		altas7_pinctrl_set_pull_sel(pmx->pctl, idx,
+						(u32)status->pull & 0xff);
+	}
+
+	/*
+	 * Restore disable input selector, this selector is not for Pin,
+	 * but for Mux function
+	 */
+	for (idx = 0; idx < NUM_OF_IN_DISABLE_REG; idx++) {
+		writel(~0, pmx->regs[BANK_DS] +
+					IN_DISABLE_0_REG_CLR + 0x8 * idx);
+		writel(pmx->status_ds[idx], pmx->regs[BANK_DS] +
+					IN_DISABLE_0_REG_SET + 0x8 * idx);
+		writel(~0, pmx->regs[BANK_DS] +
+					IN_DISABLE_VAL_0_REG_CLR + 0x8 * idx);
+		writel(pmx->status_dsv[idx], pmx->regs[BANK_DS] +
+					IN_DISABLE_VAL_0_REG_SET + 0x8 * idx);
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops atlas7_pinmux_pm_ops = {
+	.suspend_noirq = atlas7_pinmux_suspend_noirq,
+	.resume_noirq = atlas7_pinmux_resume_noirq,
+	.freeze_noirq = atlas7_pinmux_suspend_noirq,
+	.restore_noirq = atlas7_pinmux_resume_noirq,
+};
+#endif
+
 static const struct of_device_id atlas7_pinmux_ids[] = {
 	{ .compatible = "sirf,atlas7-ioc",},
+	{},
 };
 
 static struct platform_driver atlas7_pinmux_driver = {
 	.driver = {
 		.name = "atlas7-ioc",
 		.of_match_table = atlas7_pinmux_ids,
+#ifdef CONFIG_PM_SLEEP
+		.pm = &atlas7_pinmux_pm_ops,
+#endif
 	},
 	.probe = atlas7_pinmux_probe,
 };
@@ -4496,6 +4704,7 @@ static void atlas7_gpio_set_value(struct gpio_chip *chip,
 
 static const struct of_device_id atlas7_gpio_ids[] = {
 	{ .compatible = "sirf,atlas7-gpio", },
+	{},
 };
 
 static int atlas7_gpio_probe(struct platform_device *pdev)
@@ -4612,17 +4821,67 @@ static int atlas7_gpio_probe(struct platform_device *pdev)
 		BUG_ON(!bank->pctldev);
 	}
 
+	platform_set_drvdata(pdev, a7gc);
+
 	dev_info(&pdev->dev, "add to system.\n");
 	return 0;
 failed:
 	return ret;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int atlas7_gpio_suspend_noirq(struct device *dev)
+{
+	struct atlas7_gpio_chip *a7gc = dev_get_drvdata(dev);
+	struct atlas7_gpio_bank *bank;
+	void __iomem *ctrl_reg;
+	u32 idx, pin;
+
+	for (idx = 0; idx < a7gc->nbank; idx++) {
+		bank = &a7gc->banks[idx];
+		for (pin = 0; pin < bank->ngpio; pin++) {
+			ctrl_reg = ATLAS7_GPIO_CTRL(bank, pin);
+			bank->sleep_data[pin] = readl(ctrl_reg);
+		}
+	}
+
+	return 0;
+}
+
+static int atlas7_gpio_resume_noirq(struct device *dev)
+{
+	struct atlas7_gpio_chip *a7gc = dev_get_drvdata(dev);
+	struct atlas7_gpio_bank *bank;
+	void __iomem *ctrl_reg;
+	u32 idx, pin;
+
+	for (idx = 0; idx < a7gc->nbank; idx++) {
+		bank = &a7gc->banks[idx];
+		for (pin = 0; pin < bank->ngpio; pin++) {
+			ctrl_reg = ATLAS7_GPIO_CTRL(bank, pin);
+			writel(bank->sleep_data[pin], ctrl_reg);
+		}
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops atlas7_gpio_pm_ops = {
+	.suspend_noirq = atlas7_gpio_suspend_noirq,
+	.resume_noirq = atlas7_gpio_resume_noirq,
+	.freeze_noirq = atlas7_gpio_suspend_noirq,
+	.restore_noirq = atlas7_gpio_resume_noirq,
+};
+#endif
+
 static struct platform_driver atlas7_gpio_driver = {
 	.driver = {
 		.name = "atlas7-gpio",
 		.owner = THIS_MODULE,
 		.of_match_table = atlas7_gpio_ids,
+#ifdef CONFIG_PM_SLEEP
+		.pm = &atlas7_gpio_pm_ops,
+#endif
 	},
 	.probe = atlas7_gpio_probe,
 };
-- 
2.3.5
