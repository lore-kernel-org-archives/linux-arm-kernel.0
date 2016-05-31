From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 31 May 2016 17:05:15 +0900
Subject: [PATCH 09/17] pinctrl: uniphier: support pin configuration in sparse
 pin space
In-Reply-To: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
References: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1464681923-7469-10-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unfortunately, the pin number of the new SoC, PH1-LD11, is not
contiguous.  The base frame work must be adjusted to support the new
SoC pinctrl driver.  The pin_desc_get() exploits radix-tree for pin
look-up, so it works more efficiently with sparse pin space.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 86 ++++++++++++------------
 1 file changed, 42 insertions(+), 44 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
index 017b84f..39e3375 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
@@ -64,10 +64,10 @@ static int uniphier_pctl_get_group_pins(struct pinctrl_dev *pctldev,
 static void uniphier_pctl_pin_dbg_show(struct pinctrl_dev *pctldev,
 				       struct seq_file *s, unsigned offset)
 {
-	const struct pinctrl_pin_desc *pin = &pctldev->desc->pins[offset];
+	const struct pin_desc *desc = pin_desc_get(pctldev, offset);
 	const char *pull_dir, *drv_type;
 
-	switch (uniphier_pin_get_pull_dir(pin->drv_data)) {
+	switch (uniphier_pin_get_pull_dir(desc->drv_data)) {
 	case UNIPHIER_PIN_PULL_UP:
 		pull_dir = "UP";
 		break;
@@ -87,7 +87,7 @@ static void uniphier_pctl_pin_dbg_show(struct pinctrl_dev *pctldev,
 		BUG();
 	}
 
-	switch (uniphier_pin_get_drv_type(pin->drv_data)) {
+	switch (uniphier_pin_get_drv_type(desc->drv_data)) {
 	case UNIPHIER_PIN_DRV_1BIT:
 		drv_type = "4/8(mA)";
 		break;
@@ -129,12 +129,12 @@ static const struct pinctrl_ops uniphier_pctlops = {
 };
 
 static int uniphier_conf_pin_bias_get(struct pinctrl_dev *pctldev,
-				      const struct pinctrl_pin_desc *pin,
+				      const struct pin_desc *desc,
 				      enum pin_config_param param)
 {
 	struct uniphier_pinctrl_priv *priv = pinctrl_dev_get_drvdata(pctldev);
 	enum uniphier_pin_pull_dir pull_dir =
-				uniphier_pin_get_pull_dir(pin->drv_data);
+				uniphier_pin_get_pull_dir(desc->drv_data);
 	unsigned int pupdctrl, reg, shift, val;
 	unsigned int expected = 1;
 	int ret;
@@ -164,7 +164,7 @@ static int uniphier_conf_pin_bias_get(struct pinctrl_dev *pctldev,
 		BUG();
 	}
 
-	pupdctrl = uniphier_pin_get_pupdctrl(pin->drv_data);
+	pupdctrl = uniphier_pin_get_pupdctrl(desc->drv_data);
 
 	reg = UNIPHIER_PINCTRL_PUPDCTRL_BASE + pupdctrl / 32 * 4;
 	shift = pupdctrl % 32;
@@ -179,12 +179,12 @@ static int uniphier_conf_pin_bias_get(struct pinctrl_dev *pctldev,
 }
 
 static int uniphier_conf_pin_drive_get(struct pinctrl_dev *pctldev,
-				       const struct pinctrl_pin_desc *pin,
+				       const struct pin_desc *desc,
 				       u16 *strength)
 {
 	struct uniphier_pinctrl_priv *priv = pinctrl_dev_get_drvdata(pctldev);
 	enum uniphier_pin_drv_type type =
-				uniphier_pin_get_drv_type(pin->drv_data);
+				uniphier_pin_get_drv_type(desc->drv_data);
 	const unsigned int strength_1bit[] = {4, 8};
 	const unsigned int strength_2bit[] = {8, 12, 16, 20};
 	const unsigned int strength_3bit[] = {4, 5, 7, 9, 11, 12, 14, 16};
@@ -222,7 +222,7 @@ static int uniphier_conf_pin_drive_get(struct pinctrl_dev *pctldev,
 		return -EINVAL;
 	}
 
-	drvctrl = uniphier_pin_get_drvctrl(pin->drv_data);
+	drvctrl = uniphier_pin_get_drvctrl(desc->drv_data);
 	drvctrl *= width;
 
 	reg += drvctrl / 32 * 4;
@@ -239,10 +239,10 @@ static int uniphier_conf_pin_drive_get(struct pinctrl_dev *pctldev,
 }
 
 static int uniphier_conf_pin_input_enable_get(struct pinctrl_dev *pctldev,
-					const struct pinctrl_pin_desc *pin)
+					      const struct pin_desc *desc)
 {
 	struct uniphier_pinctrl_priv *priv = pinctrl_dev_get_drvdata(pctldev);
-	unsigned int iectrl = uniphier_pin_get_iectrl(pin->drv_data);
+	unsigned int iectrl = uniphier_pin_get_iectrl(desc->drv_data);
 	unsigned int val;
 	int ret;
 
@@ -261,7 +261,7 @@ static int uniphier_conf_pin_config_get(struct pinctrl_dev *pctldev,
 					unsigned pin,
 					unsigned long *configs)
 {
-	const struct pinctrl_pin_desc *pin_desc = &pctldev->desc->pins[pin];
+	const struct pin_desc *desc = pin_desc_get(pctldev, pin);
 	enum pin_config_param param = pinconf_to_config_param(*configs);
 	bool has_arg = false;
 	u16 arg;
@@ -271,14 +271,14 @@ static int uniphier_conf_pin_config_get(struct pinctrl_dev *pctldev,
 	case PIN_CONFIG_BIAS_DISABLE:
 	case PIN_CONFIG_BIAS_PULL_UP:
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		ret = uniphier_conf_pin_bias_get(pctldev, pin_desc, param);
+		ret = uniphier_conf_pin_bias_get(pctldev, desc, param);
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
-		ret = uniphier_conf_pin_drive_get(pctldev, pin_desc, &arg);
+		ret = uniphier_conf_pin_drive_get(pctldev, desc, &arg);
 		has_arg = true;
 		break;
 	case PIN_CONFIG_INPUT_ENABLE:
-		ret = uniphier_conf_pin_input_enable_get(pctldev, pin_desc);
+		ret = uniphier_conf_pin_input_enable_get(pctldev, desc);
 		break;
 	default:
 		/* unsupported parameter */
@@ -293,13 +293,12 @@ static int uniphier_conf_pin_config_get(struct pinctrl_dev *pctldev,
 }
 
 static int uniphier_conf_pin_bias_set(struct pinctrl_dev *pctldev,
-				      const struct pinctrl_pin_desc *pin,
-				      enum pin_config_param param,
-				      u16 arg)
+				      const struct pin_desc *desc,
+				      enum pin_config_param param, u16 arg)
 {
 	struct uniphier_pinctrl_priv *priv = pinctrl_dev_get_drvdata(pctldev);
 	enum uniphier_pin_pull_dir pull_dir =
-				uniphier_pin_get_pull_dir(pin->drv_data);
+				uniphier_pin_get_pull_dir(desc->drv_data);
 	unsigned int pupdctrl, reg, shift;
 	unsigned int val = 1;
 
@@ -310,8 +309,8 @@ static int uniphier_conf_pin_bias_set(struct pinctrl_dev *pctldev,
 		if (pull_dir == UNIPHIER_PIN_PULL_UP_FIXED ||
 		    pull_dir == UNIPHIER_PIN_PULL_DOWN_FIXED) {
 			dev_err(pctldev->dev,
-				"can not disable pull register for pin %u (%s)\n",
-				pin->number, pin->name);
+				"can not disable pull register for pin %s\n",
+				desc->name);
 			return -EINVAL;
 		}
 		val = 0;
@@ -321,8 +320,8 @@ static int uniphier_conf_pin_bias_set(struct pinctrl_dev *pctldev,
 			return 0;
 		if (pull_dir != UNIPHIER_PIN_PULL_UP) {
 			dev_err(pctldev->dev,
-				"pull-up is unsupported for pin %u (%s)\n",
-				pin->number, pin->name);
+				"pull-up is unsupported for pin %s\n",
+				desc->name);
 			return -EINVAL;
 		}
 		if (arg == 0) {
@@ -335,8 +334,8 @@ static int uniphier_conf_pin_bias_set(struct pinctrl_dev *pctldev,
 			return 0;
 		if (pull_dir != UNIPHIER_PIN_PULL_DOWN) {
 			dev_err(pctldev->dev,
-				"pull-down is unsupported for pin %u (%s)\n",
-				pin->number, pin->name);
+				"pull-down is unsupported for pin %s\n",
+				desc->name);
 			return -EINVAL;
 		}
 		if (arg == 0) {
@@ -347,8 +346,8 @@ static int uniphier_conf_pin_bias_set(struct pinctrl_dev *pctldev,
 	case PIN_CONFIG_BIAS_PULL_PIN_DEFAULT:
 		if (pull_dir == UNIPHIER_PIN_PULL_NONE) {
 			dev_err(pctldev->dev,
-				"pull-up/down is unsupported for pin %u (%s)\n",
-				pin->number, pin->name);
+				"pull-up/down is unsupported for pin %s\n",
+				desc->name);
 			return -EINVAL;
 		}
 
@@ -359,7 +358,7 @@ static int uniphier_conf_pin_bias_set(struct pinctrl_dev *pctldev,
 		BUG();
 	}
 
-	pupdctrl = uniphier_pin_get_pupdctrl(pin->drv_data);
+	pupdctrl = uniphier_pin_get_pupdctrl(desc->drv_data);
 
 	reg = UNIPHIER_PINCTRL_PUPDCTRL_BASE + pupdctrl / 32 * 4;
 	shift = pupdctrl % 32;
@@ -368,12 +367,12 @@ static int uniphier_conf_pin_bias_set(struct pinctrl_dev *pctldev,
 }
 
 static int uniphier_conf_pin_drive_set(struct pinctrl_dev *pctldev,
-				       const struct pinctrl_pin_desc *pin,
+				       const struct pin_desc *desc,
 				       u16 strength)
 {
 	struct uniphier_pinctrl_priv *priv = pinctrl_dev_get_drvdata(pctldev);
 	enum uniphier_pin_drv_type type =
-				uniphier_pin_get_drv_type(pin->drv_data);
+				uniphier_pin_get_drv_type(desc->drv_data);
 	const unsigned int strength_1bit[] = {4, 8, -1};
 	const unsigned int strength_2bit[] = {8, 12, 16, 20, -1};
 	const unsigned int strength_3bit[] = {4, 5, 7, 9, 11, 12, 14, 16, -1};
@@ -398,8 +397,8 @@ static int uniphier_conf_pin_drive_set(struct pinctrl_dev *pctldev,
 		break;
 	default:
 		dev_err(pctldev->dev,
-			"cannot change drive strength for pin %u (%s)\n",
-			pin->number, pin->name);
+			"cannot change drive strength for pin %s\n",
+			desc->name);
 		return -EINVAL;
 	}
 
@@ -410,14 +409,14 @@ static int uniphier_conf_pin_drive_set(struct pinctrl_dev *pctldev,
 
 	if (val == 0) {
 		dev_err(pctldev->dev,
-			"unsupported drive strength %u mA for pin %u (%s)\n",
-			strength, pin->number, pin->name);
+			"unsupported drive strength %u mA for pin %s\n",
+			strength, desc->name);
 		return -EINVAL;
 	}
 
 	val--;
 
-	drvctrl = uniphier_pin_get_drvctrl(pin->drv_data);
+	drvctrl = uniphier_pin_get_drvctrl(desc->drv_data);
 	drvctrl *= width;
 
 	reg += drvctrl / 32 * 4;
@@ -429,11 +428,11 @@ static int uniphier_conf_pin_drive_set(struct pinctrl_dev *pctldev,
 }
 
 static int uniphier_conf_pin_input_enable(struct pinctrl_dev *pctldev,
-					  const struct pinctrl_pin_desc *pin,
+					  const struct pin_desc *desc,
 					  u16 enable)
 {
 	struct uniphier_pinctrl_priv *priv = pinctrl_dev_get_drvdata(pctldev);
-	unsigned int iectrl = uniphier_pin_get_iectrl(pin->drv_data);
+	unsigned int iectrl = uniphier_pin_get_iectrl(desc->drv_data);
 
 	if (enable == 0) {
 		/*
@@ -457,7 +456,7 @@ static int uniphier_conf_pin_config_set(struct pinctrl_dev *pctldev,
 					unsigned long *configs,
 					unsigned num_configs)
 {
-	const struct pinctrl_pin_desc *pin_desc = &pctldev->desc->pins[pin];
+	const struct pin_desc *desc = pin_desc_get(pctldev, pin);
 	int i, ret;
 
 	for (i = 0; i < num_configs; i++) {
@@ -470,16 +469,15 @@ static int uniphier_conf_pin_config_set(struct pinctrl_dev *pctldev,
 		case PIN_CONFIG_BIAS_PULL_UP:
 		case PIN_CONFIG_BIAS_PULL_DOWN:
 		case PIN_CONFIG_BIAS_PULL_PIN_DEFAULT:
-			ret = uniphier_conf_pin_bias_set(pctldev, pin_desc,
+			ret = uniphier_conf_pin_bias_set(pctldev, desc,
 							 param, arg);
 			break;
 		case PIN_CONFIG_DRIVE_STRENGTH:
-			ret = uniphier_conf_pin_drive_set(pctldev, pin_desc,
-							  arg);
+			ret = uniphier_conf_pin_drive_set(pctldev, desc, arg);
 			break;
 		case PIN_CONFIG_INPUT_ENABLE:
-			ret = uniphier_conf_pin_input_enable(pctldev,
-							     pin_desc, arg);
+			ret = uniphier_conf_pin_input_enable(pctldev, desc,
+							     arg);
 			break;
 		default:
 			dev_err(pctldev->dev,
@@ -561,7 +559,7 @@ static int uniphier_pmx_set_one_mux(struct pinctrl_dev *pctldev, unsigned pin,
 
 	/* some pins need input-enabling */
 	ret = uniphier_conf_pin_input_enable(pctldev,
-					     &pctldev->desc->pins[pin], 1);
+					     pin_desc_get(pctldev, pin), 1);
 	if (ret)
 		return ret;
 
-- 
1.9.1
