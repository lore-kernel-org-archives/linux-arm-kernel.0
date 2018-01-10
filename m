From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 10 Jan 2018 17:34:14 +0900
Subject: [PATCH] pinctrl: uniphier: refactor drive strength get/set functions
Message-ID: <1515573254-8894-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is code duplication between uniphier_conf_pin_drive_get() and
uniphier_conf_pin_drive_set().  Factor out the common code into
uniphier_conf_get_drvctrl_data().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 176 ++++++++++++-----------
 1 file changed, 91 insertions(+), 85 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
index 26fda5c..ec0f77a 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
@@ -146,6 +146,71 @@ static const struct pinctrl_ops uniphier_pctlops = {
 	.dt_free_map = pinctrl_utils_free_map,
 };
 
+static const unsigned int uniphier_conf_drv_strengths_1bit[] = {4, 8};
+static const unsigned int uniphier_conf_drv_strengths_2bit[] = {8, 12, 16, 20};
+static const unsigned int uniphier_conf_drv_strengths_3bit[] = {4, 5, 7, 9, 11,
+								12, 14, 16};
+static const unsigned int uniphier_conf_drv_strengths_fixed4[] = {4};
+static const unsigned int uniphier_conf_drv_strengths_fixed5[] = {5};
+static const unsigned int uniphier_conf_drv_strengths_fixed8[] = {8};
+
+static int uniphier_conf_get_drvctrl_data(struct pinctrl_dev *pctldev,
+					  unsigned int pin, unsigned int *reg,
+					  unsigned int *shift,
+					  unsigned int *mask,
+					  const unsigned int **strengths)
+{
+	const struct pin_desc *desc = pin_desc_get(pctldev, pin);
+	enum uniphier_pin_drv_type type =
+				uniphier_pin_get_drv_type(desc->drv_data);
+	unsigned int base = 0;
+	unsigned int stride = 0;
+	unsigned int width = 0;
+	unsigned int drvctrl;
+
+	switch (type) {
+	case UNIPHIER_PIN_DRV_1BIT:
+		*strengths = uniphier_conf_drv_strengths_1bit;
+		base = UNIPHIER_PINCTRL_DRVCTRL_BASE;
+		stride = 1;
+		width = 1;
+		break;
+	case UNIPHIER_PIN_DRV_2BIT:
+		*strengths = uniphier_conf_drv_strengths_2bit;
+		base = UNIPHIER_PINCTRL_DRV2CTRL_BASE;
+		stride = 2;
+		width = 2;
+		break;
+	case UNIPHIER_PIN_DRV_3BIT:
+		*strengths = uniphier_conf_drv_strengths_3bit;
+		base = UNIPHIER_PINCTRL_DRV3CTRL_BASE;
+		stride = 4;
+		width = 3;
+		break;
+	case UNIPHIER_PIN_DRV_FIXED4:
+		*strengths = uniphier_conf_drv_strengths_fixed4;
+		break;
+	case UNIPHIER_PIN_DRV_FIXED5:
+		*strengths = uniphier_conf_drv_strengths_fixed5;
+		break;
+	case UNIPHIER_PIN_DRV_FIXED8:
+		*strengths = uniphier_conf_drv_strengths_fixed8;
+		break;
+	default:
+		/* drive strength control is not supported for this pin */
+		return -EINVAL;
+	}
+
+	drvctrl = uniphier_pin_get_drvctrl(desc->drv_data);
+	drvctrl *= stride;
+
+	*reg = base + drvctrl / 32 * 4;
+	*shift = drvctrl % 32;
+	*mask = (1U << width) - 1;
+
+	return 0;
+}
+
 static int uniphier_conf_pin_bias_get(struct pinctrl_dev *pctldev,
 				      unsigned int pin,
 				      enum pin_config_param param)
@@ -201,59 +266,24 @@ static int uniphier_conf_pin_drive_get(struct pinctrl_dev *pctldev,
 				       unsigned int pin, u32 *strength)
 {
 	struct uniphier_pinctrl_priv *priv = pinctrl_dev_get_drvdata(pctldev);
-	const struct pin_desc *desc = pin_desc_get(pctldev, pin);
-	enum uniphier_pin_drv_type type =
-				uniphier_pin_get_drv_type(desc->drv_data);
-	static const unsigned int strength_1bit[] = {4, 8};
-	static const unsigned int strength_2bit[] = {8, 12, 16, 20};
-	static const unsigned int strength_3bit[] = {4, 5, 7, 9, 11, 12,
-						     14, 16};
-	const unsigned int *supported_strength;
-	unsigned int drvctrl, reg, shift, mask, width, val;
+	unsigned int reg, shift, mask, val;
+	const unsigned int *strengths;
 	int ret;
 
-	switch (type) {
-	case UNIPHIER_PIN_DRV_1BIT:
-		supported_strength = strength_1bit;
-		reg = UNIPHIER_PINCTRL_DRVCTRL_BASE;
-		width = 1;
-		break;
-	case UNIPHIER_PIN_DRV_2BIT:
-		supported_strength = strength_2bit;
-		reg = UNIPHIER_PINCTRL_DRV2CTRL_BASE;
-		width = 2;
-		break;
-	case UNIPHIER_PIN_DRV_3BIT:
-		supported_strength = strength_3bit;
-		reg = UNIPHIER_PINCTRL_DRV3CTRL_BASE;
-		width = 4;
-		break;
-	case UNIPHIER_PIN_DRV_FIXED4:
-		*strength = 4;
-		return 0;
-	case UNIPHIER_PIN_DRV_FIXED5:
-		*strength = 5;
-		return 0;
-	case UNIPHIER_PIN_DRV_FIXED8:
-		*strength = 8;
-		return 0;
-	default:
-		/* drive strength control is not supported for this pin */
-		return -EINVAL;
-	}
-
-	drvctrl = uniphier_pin_get_drvctrl(desc->drv_data);
-	drvctrl *= width;
-
-	reg += drvctrl / 32 * 4;
-	shift = drvctrl % 32;
-	mask = (1U << width) - 1;
-
-	ret = regmap_read(priv->regmap, reg, &val);
+	ret = uniphier_conf_get_drvctrl_data(pctldev, pin, &reg, &shift,
+					     &mask, &strengths);
 	if (ret)
 		return ret;
 
-	*strength = supported_strength[(val >> shift) & mask];
+	if (mask) {
+		ret = regmap_read(priv->regmap, reg, &val);
+		if (ret)
+			return ret;
+	} else {
+		val = 0;
+	}
+
+	*strength = strengths[(val >> shift) & mask];
 
 	return 0;
 }
@@ -398,40 +428,20 @@ static int uniphier_conf_pin_drive_set(struct pinctrl_dev *pctldev,
 {
 	struct uniphier_pinctrl_priv *priv = pinctrl_dev_get_drvdata(pctldev);
 	const struct pin_desc *desc = pin_desc_get(pctldev, pin);
-	enum uniphier_pin_drv_type type =
-				uniphier_pin_get_drv_type(desc->drv_data);
-	static const unsigned int strength_1bit[] = {4, 8, -1};
-	static const unsigned int strength_2bit[] = {8, 12, 16, 20, -1};
-	static const unsigned int strength_3bit[] = {4, 5, 7, 9, 11, 12, 14,
-						     16, -1};
-	const unsigned int *supported_strength;
-	unsigned int drvctrl, reg, shift, mask, width, val;
+	unsigned int reg, shift, mask, val;
+	const unsigned int *strengths;
+	int ret;
 
-	switch (type) {
-	case UNIPHIER_PIN_DRV_1BIT:
-		supported_strength = strength_1bit;
-		reg = UNIPHIER_PINCTRL_DRVCTRL_BASE;
-		width = 1;
-		break;
-	case UNIPHIER_PIN_DRV_2BIT:
-		supported_strength = strength_2bit;
-		reg = UNIPHIER_PINCTRL_DRV2CTRL_BASE;
-		width = 2;
-		break;
-	case UNIPHIER_PIN_DRV_3BIT:
-		supported_strength = strength_3bit;
-		reg = UNIPHIER_PINCTRL_DRV3CTRL_BASE;
-		width = 4;
-		break;
-	default:
-		dev_err(pctldev->dev,
-			"cannot change drive strength for pin %s\n",
+	ret = uniphier_conf_get_drvctrl_data(pctldev, pin, &reg, &shift,
+					     &mask, &strengths);
+	if (ret) {
+		dev_err(pctldev->dev, "cannot set drive strength for pin %s\n",
 			desc->name);
-		return -EINVAL;
+		return ret;
 	}
 
-	for (val = 0; supported_strength[val] > 0; val++) {
-		if (supported_strength[val] > strength)
+	for (val = 0; val <= mask; val++) {
+		if (strengths[val] > strength)
 			break;
 	}
 
@@ -442,14 +452,10 @@ static int uniphier_conf_pin_drive_set(struct pinctrl_dev *pctldev,
 		return -EINVAL;
 	}
 
-	val--;
-
-	drvctrl = uniphier_pin_get_drvctrl(desc->drv_data);
-	drvctrl *= width;
+	if (!mask)
+		return 0;
 
-	reg += drvctrl / 32 * 4;
-	shift = drvctrl % 32;
-	mask = (1U << width) - 1;
+	val--;
 
 	return regmap_update_bits(priv->regmap, reg,
 				  mask << shift, val << shift);
-- 
2.7.4
