From: b32955@freescale.com (Huang Shijie)
Date: Wed, 27 Feb 2013 10:35:53 +0800
Subject: [PATCH 2/2] pinctrl: imx: use pin_func_ids to search the pinctrl item.
In-Reply-To: <1361932553-8218-1-git-send-email-b32955@freescale.com>
References: <1361932553-8218-1-git-send-email-b32955@freescale.com>
Message-ID: <1361932553-8218-2-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The uart may works in DTE mode or DCE mode. The customer can sets the different
modes by the pinctrl. But the pinctrl items for DTE or DCE may share the
same Pad id, such as:
  MX6Q_PAD_EIM_D27__UART2_RXD_DTE and MX6Q_PAD_EIM_D27__WEIM_WEIM_D_27
  share the same MX6Q_PAD_EIM_D27 pad id.

The current code only search the pinctrl items by pad id. So if there two
pinctrl items shares the same pad id, the current code only use the first one,
even you tell the system to use the second one in the DTS file.

This patch adds a new field pin_func_ids to imx_pin_group{}, and uses the
pin_func_ids as the index to search the pinctrl items. In this way, we can
avoid the issue.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/pinctrl/pinctrl-imx.c |   30 ++++++++++++++++++++++--------
 drivers/pinctrl/pinctrl-imx.h |    1 +
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
index 4cebb9c..8c6abc0 100644
--- a/drivers/pinctrl/pinctrl-imx.c
+++ b/drivers/pinctrl/pinctrl-imx.c
@@ -56,11 +56,15 @@ struct imx_pinctrl {
 
 static const struct imx_pin_reg *imx_find_pin_reg(
 				const struct imx_pinctrl_soc_info *info,
-				unsigned pin, bool is_mux, unsigned mux)
+				unsigned pin, bool is_mux, unsigned mux,
+				int pin_func_id)
 {
 	const struct imx_pin_reg *pin_reg = NULL;
 	int i;
 
+	if (pin_func_id > -1 && pin_func_id < info->npin_regs)
+		return info->pin_regs + pin_func_id;
+
 	for (i = 0; i < info->npin_regs; i++) {
 		pin_reg = &info->pin_regs[i];
 		if (pin_reg->pid != pin)
@@ -223,8 +227,10 @@ static int imx_pmx_enable(struct pinctrl_dev *pctldev, unsigned selector,
 	struct imx_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
 	const struct imx_pinctrl_soc_info *info = ipctl->info;
 	const struct imx_pin_reg *pin_reg;
-	const unsigned *pins, *mux;
+	const unsigned int *pins, *mux;
+	int *pin_func_ids;
 	unsigned int npins, pin_id;
+	int pin_func_id;
 	int i;
 
 	/*
@@ -234,6 +240,7 @@ static int imx_pmx_enable(struct pinctrl_dev *pctldev, unsigned selector,
 	pins = info->groups[group].pins;
 	npins = info->groups[group].npins;
 	mux = info->groups[group].mux_mode;
+	pin_func_ids = info->groups[group].pin_func_ids;
 
 	WARN_ON(!pins || !npins || !mux);
 
@@ -242,8 +249,10 @@ static int imx_pmx_enable(struct pinctrl_dev *pctldev, unsigned selector,
 
 	for (i = 0; i < npins; i++) {
 		pin_id = pins[i];
+		pin_func_id = pin_func_ids[i];
 
-		pin_reg = imx_find_pin_reg(info, pin_id, 1, mux[i]);
+		pin_reg = imx_find_pin_reg(info, pin_id, 1, mux[i],
+					pin_func_id);
 		if (!pin_reg)
 			return -EINVAL;
 
@@ -254,8 +263,9 @@ static int imx_pmx_enable(struct pinctrl_dev *pctldev, unsigned selector,
 		}
 
 		writel(mux[i], ipctl->base + pin_reg->mux_reg);
-		dev_dbg(ipctl->dev, "write: offset 0x%x val 0x%x\n",
-			pin_reg->mux_reg, mux[i]);
+		dev_dbg(ipctl->dev,
+			"Pinid(%d), func-id(%d), write: offset 0x%x val 0x%x\n",
+			pin_id, pin_func_id, pin_reg->mux_reg, mux[i]);
 
 		/* some pins also need select input setting, set it if found */
 		if (pin_reg->input_reg) {
@@ -313,7 +323,7 @@ static int imx_pinconf_get(struct pinctrl_dev *pctldev,
 	const struct imx_pinctrl_soc_info *info = ipctl->info;
 	const struct imx_pin_reg *pin_reg;
 
-	pin_reg = imx_find_pin_reg(info, pin_id, 0, 0);
+	pin_reg = imx_find_pin_reg(info, pin_id, 0, 0, -1);
 	if (!pin_reg)
 		return -EINVAL;
 
@@ -335,7 +345,7 @@ static int imx_pinconf_set(struct pinctrl_dev *pctldev,
 	const struct imx_pinctrl_soc_info *info = ipctl->info;
 	const struct imx_pin_reg *pin_reg;
 
-	pin_reg = imx_find_pin_reg(info, pin_id, 0, 0);
+	pin_reg = imx_find_pin_reg(info, pin_id, 0, 0, -1);
 	if (!pin_reg)
 		return -EINVAL;
 
@@ -363,7 +373,7 @@ static void imx_pinconf_dbg_show(struct pinctrl_dev *pctldev,
 	const struct imx_pin_reg *pin_reg;
 	unsigned long config;
 
-	pin_reg = imx_find_pin_reg(info, pin_id, 0, 0);
+	pin_reg = imx_find_pin_reg(info, pin_id, 0, 0, -1);
 	if (!pin_reg || !pin_reg->conf_reg) {
 		seq_printf(s, "N/A");
 		return;
@@ -460,6 +470,9 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
 				GFP_KERNEL);
 	grp->configs = devm_kzalloc(info->dev, grp->npins * sizeof(unsigned long),
 				GFP_KERNEL);
+	grp->pin_func_ids = devm_kzalloc(info->dev,
+				grp->npins * sizeof(unsigned long), GFP_KERNEL);
+
 	for (i = 0, j = 0; i < size; i += 2, j++) {
 		pin_func_id = be32_to_cpu(*list++);
 		ret = imx_pinctrl_get_pin_id_and_mux(info, pin_func_id,
@@ -473,6 +486,7 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
 		if (config & IMX_PAD_SION)
 			grp->mux_mode[j] |= IOMUXC_CONFIG_SION;
 		grp->configs[j] = config & ~IMX_PAD_SION;
+		grp->pin_func_ids[j] = pin_func_id;
 	}
 
 #ifdef DEBUG
diff --git a/drivers/pinctrl/pinctrl-imx.h b/drivers/pinctrl/pinctrl-imx.h
index 9b65e78..2c11b2f 100644
--- a/drivers/pinctrl/pinctrl-imx.h
+++ b/drivers/pinctrl/pinctrl-imx.h
@@ -35,6 +35,7 @@ struct imx_pin_group {
 	unsigned npins;
 	unsigned int *mux_mode;
 	unsigned long *configs;
+	int *pin_func_ids;
 };
 
 /**
-- 
1.7.1
