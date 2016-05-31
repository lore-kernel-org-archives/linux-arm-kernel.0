From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 31 May 2016 17:05:21 +0900
Subject: [PATCH 15/17] pinctrl: uniphier: allow to have pinctrl node under
 syscon node
In-Reply-To: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
References: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1464681923-7469-16-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the UniPhier pinctrl driver itself is a syscon, but it
turned out much more reasonable to make it a child node of a syscon
because our syscon node consists of a bunch of system configuration
registers, not only pinctrl, but also phy, and misc registers.
It is difficult to split the node.

To allow to migrate to the new DT structure, this commit adds new
compatible strings to not disturb the existing DT.  After a while,
the old binding will be removed.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 38 ++++++++++++++++++------
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c  |  1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c |  1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c |  1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c |  1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c |  1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c |  1 +
 7 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
index 5bfcfa8..9b2ee71 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
@@ -14,6 +14,7 @@
 
 #include <linux/export.h>
 #include <linux/mfd/syscon.h>
+#include <linux/of.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinctrl.h>
@@ -29,6 +30,7 @@ struct uniphier_pinctrl_priv {
 	struct pinctrl_desc pctldesc;
 	struct pinctrl_dev *pctldev;
 	struct regmap *regmap;
+	unsigned int regbase;
 	struct uniphier_pinctrl_socdata *socdata;
 };
 
@@ -169,7 +171,7 @@ static int uniphier_conf_pin_bias_get(struct pinctrl_dev *pctldev,
 	reg = UNIPHIER_PINCTRL_PUPDCTRL_BASE + pupdctrl / 32 * 4;
 	shift = pupdctrl % 32;
 
-	ret = regmap_read(priv->regmap, reg, &val);
+	ret = regmap_read(priv->regmap, priv->regbase + reg, &val);
 	if (ret)
 		return ret;
 
@@ -229,7 +231,7 @@ static int uniphier_conf_pin_drive_get(struct pinctrl_dev *pctldev,
 	shift = drvctrl % 32;
 	mask = (1U << width) - 1;
 
-	ret = regmap_read(priv->regmap, reg, &val);
+	ret = regmap_read(priv->regmap, priv->regbase + reg, &val);
 	if (ret)
 		return ret;
 
@@ -250,7 +252,8 @@ static int uniphier_conf_pin_input_enable_get(struct pinctrl_dev *pctldev,
 		/* This pin is always input-enabled. */
 		return 0;
 
-	ret = regmap_read(priv->regmap, UNIPHIER_PINCTRL_IECTRL, &val);
+	ret = regmap_read(priv->regmap,
+			  priv->regbase + UNIPHIER_PINCTRL_IECTRL, &val);
 	if (ret)
 		return ret;
 
@@ -363,7 +366,8 @@ static int uniphier_conf_pin_bias_set(struct pinctrl_dev *pctldev,
 	reg = UNIPHIER_PINCTRL_PUPDCTRL_BASE + pupdctrl / 32 * 4;
 	shift = pupdctrl % 32;
 
-	return regmap_update_bits(priv->regmap, reg, 1 << shift, val << shift);
+	return regmap_update_bits(priv->regmap, priv->regbase + reg,
+				  1 << shift, val << shift);
 }
 
 static int uniphier_conf_pin_drive_set(struct pinctrl_dev *pctldev,
@@ -423,7 +427,7 @@ static int uniphier_conf_pin_drive_set(struct pinctrl_dev *pctldev,
 	shift = drvctrl % 32;
 	mask = (1U << width) - 1;
 
-	return regmap_update_bits(priv->regmap, reg,
+	return regmap_update_bits(priv->regmap, priv->regbase + reg,
 				  mask << shift, val << shift);
 }
 
@@ -447,7 +451,7 @@ static int uniphier_conf_pin_input_enable(struct pinctrl_dev *pctldev,
 	if (iectrl == UNIPHIER_PIN_IECTRL_NONE)
 		return enable ? 0 : -EINVAL;
 
-	reg = UNIPHIER_PINCTRL_IECTRL + iectrl / 32 * 4;
+	reg = priv->regbase + UNIPHIER_PINCTRL_IECTRL + iectrl / 32 * 4;
 	mask = BIT(iectrl % 32);
 
 	return regmap_update_bits(priv->regmap, reg, mask, enable ? mask : 0);
@@ -597,7 +601,7 @@ static int uniphier_pmx_set_one_mux(struct pinctrl_dev *pctldev, unsigned pin,
 	 * stored in the offset+4.
 	 */
 	for (; reg < reg_end; reg += 4) {
-		ret = regmap_update_bits(priv->regmap, reg,
+		ret = regmap_update_bits(priv->regmap, priv->regbase + reg,
 					 mask << shift, muxval << shift);
 		if (ret)
 			return ret;
@@ -606,7 +610,8 @@ static int uniphier_pmx_set_one_mux(struct pinctrl_dev *pctldev, unsigned pin,
 
 	if (load_pinctrl) {
 		ret = regmap_write(priv->regmap,
-				   UNIPHIER_PINCTRL_LOAD_PINMUX, 1);
+				   priv->regbase + UNIPHIER_PINCTRL_LOAD_PINMUX,
+				   1);
 		if (ret)
 			return ret;
 	}
@@ -679,6 +684,7 @@ int uniphier_pinctrl_probe(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct uniphier_pinctrl_priv *priv;
+	struct device_node *parent;
 
 	if (!socdata ||
 	    !socdata->pins || !socdata->npins ||
@@ -692,7 +698,21 @@ int uniphier_pinctrl_probe(struct platform_device *pdev,
 	if (!priv)
 		return -ENOMEM;
 
-	priv->regmap = syscon_node_to_regmap(dev->of_node);
+	if (of_device_is_compatible(dev->of_node, "socionext,ph1-ld4-pinctrl") ||
+	    of_device_is_compatible(dev->of_node, "socionext,ph1-pro4-pinctrl") ||
+	    of_device_is_compatible(dev->of_node, "socionext,ph1-sld8-pinctrl") ||
+	    of_device_is_compatible(dev->of_node, "socionext,ph1-pro5-pinctrl") ||
+	    of_device_is_compatible(dev->of_node, "socionext,proxstream2-pinctrl") ||
+	    of_device_is_compatible(dev->of_node, "socionext,ph1-ld6b-pinctrl")) {
+		/* old binding */
+		priv->regmap = syscon_node_to_regmap(dev->of_node);
+	} else {
+		priv->regbase = 0x1000;
+		parent = of_get_parent(dev->of_node);
+		priv->regmap = syscon_node_to_regmap(parent);
+		of_node_put(parent);
+	}
+
 	if (IS_ERR(priv->regmap)) {
 		dev_err(dev, "failed to get regmap\n");
 		return PTR_ERR(priv->regmap);
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
index 7437483..98044bc 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
@@ -914,6 +914,7 @@ static int uniphier_ld4_pinctrl_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id uniphier_ld4_pinctrl_match[] = {
+	{ .compatible = "socionext,uniphier-ld4-pinctrl" },
 	{ .compatible = "socionext,ph1-ld4-pinctrl" },
 	{ /* sentinel */ }
 };
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
index d575194..6c0d66c 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
@@ -1275,6 +1275,7 @@ static int uniphier_ld6b_pinctrl_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id uniphier_ld6b_pinctrl_match[] = {
+	{ .compatible = "socionext,uniphier-ld6b-pinctrl" },
 	{ .compatible = "socionext,ph1-ld6b-pinctrl" },
 	{ /* sentinel */ }
 };
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
index 35c5c51..8c61493 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
@@ -1573,6 +1573,7 @@ static int uniphier_pro4_pinctrl_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id uniphier_pro4_pinctrl_match[] = {
+	{ .compatible = "socionext,uniphier-pro4-pinctrl" },
 	{ .compatible = "socionext,ph1-pro4-pinctrl" },
 	{ /* sentinel */ }
 };
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
index f94eb42..55d4a12 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
@@ -1364,6 +1364,7 @@ static int uniphier_pro5_pinctrl_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id uniphier_pro5_pinctrl_match[] = {
+	{ .compatible = "socionext,uniphier-pro5-pinctrl" },
 	{ .compatible = "socionext,ph1-pro5-pinctrl" },
 	{ /* sentinel */ }
 };
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
index c879be3..8e1d73e 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
@@ -1254,6 +1254,7 @@ static int uniphier_pxs2_pinctrl_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id uniphier_pxs2_pinctrl_match[] = {
+	{ .compatible = "socionext,uniphier-pxs2-pinctrl" },
 	{ .compatible = "socionext,proxstream2-pinctrl" },
 	{ /* sentinel */ }
 };
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
index 096a460..8ea740d 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
@@ -841,6 +841,7 @@ static int uniphier_sld8_pinctrl_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id uniphier_sld8_pinctrl_match[] = {
+	{ .compatible = "socionext,uniphier-sld8-pinctrl" },
 	{ .compatible = "socionext,ph1-sld8-pinctrl" },
 	{ /* sentinel */ }
 };
-- 
1.9.1
