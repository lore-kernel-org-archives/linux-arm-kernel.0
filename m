From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 31 May 2016 17:05:12 +0900
Subject: [PATCH 06/17] pinctrl: uniphier: allocate struct pinctrl_desc in
 probe function
In-Reply-To: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
References: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1464681923-7469-7-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, every SoC driver defines struct pinctrl_desc statically,
i.e. it consumes memory footprint even if it is not probed.

In multi-platform, many pinctrl drivers are linked (generally as
built-in objects), although only one of them is actually used.
So, it is reasonable to allocate memory dynamically where possible.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 19 +++++++++++--------
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c  | 10 +++-------
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c | 10 +++-------
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c | 10 +++-------
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c | 10 +++-------
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c | 10 +++-------
 drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c | 10 +++-------
 drivers/pinctrl/uniphier/pinctrl-uniphier.h      |  8 ++++----
 8 files changed, 33 insertions(+), 54 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
index 4aa67c6..953b13a 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
@@ -26,6 +26,7 @@
 #include "pinctrl-uniphier.h"
 
 struct uniphier_pinctrl_priv {
+	struct pinctrl_desc pctldesc;
 	struct pinctrl_dev *pctldev;
 	struct regmap *regmap;
 	struct uniphier_pinctrl_socdata *socdata;
@@ -639,13 +640,13 @@ static const struct pinmux_ops uniphier_pmxops = {
 };
 
 int uniphier_pinctrl_probe(struct platform_device *pdev,
-			   struct pinctrl_desc *desc,
 			   struct uniphier_pinctrl_socdata *socdata)
 {
 	struct device *dev = &pdev->dev;
 	struct uniphier_pinctrl_priv *priv;
 
 	if (!socdata ||
+	    !socdata->pins || !socdata->npins ||
 	    !socdata->groups ||
 	    !socdata->groups_count ||
 	    !socdata->functions ||
@@ -667,13 +668,15 @@ int uniphier_pinctrl_probe(struct platform_device *pdev,
 	}
 
 	priv->socdata = socdata;
-	desc->name = dev->driver->name;
-	desc->pctlops = &uniphier_pctlops;
-	desc->pmxops = &uniphier_pmxops;
-	desc->confops = &uniphier_confops;
-	desc->owner = dev->driver->owner;
-
-	priv->pctldev = devm_pinctrl_register(dev, desc, priv);
+	priv->pctldesc.name = dev->driver->name;
+	priv->pctldesc.pins = socdata->pins;
+	priv->pctldesc.npins = socdata->npins;
+	priv->pctldesc.pctlops = &uniphier_pctlops;
+	priv->pctldesc.pmxops = &uniphier_pmxops;
+	priv->pctldesc.confops = &uniphier_confops;
+	priv->pctldesc.owner = dev->driver->owner;
+
+	priv->pctldev = devm_pinctrl_register(dev, &priv->pctldesc, priv);
 	if (IS_ERR(priv->pctldev)) {
 		dev_err(dev, "failed to register UniPhier pinctrl driver\n");
 		return PTR_ERR(priv->pctldev);
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
index 1e7bacd..7b8cf31 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
@@ -846,6 +846,8 @@ static const struct uniphier_pinmux_function uniphier_ld4_functions[] = {
 };
 
 static struct uniphier_pinctrl_socdata uniphier_ld4_pindata = {
+	.pins = uniphier_ld4_pins,
+	.npins = ARRAY_SIZE(uniphier_ld4_pins),
 	.groups = uniphier_ld4_groups,
 	.groups_count = ARRAY_SIZE(uniphier_ld4_groups),
 	.functions = uniphier_ld4_functions,
@@ -855,15 +857,9 @@ static struct uniphier_pinctrl_socdata uniphier_ld4_pindata = {
 	.load_pinctrl = false,
 };
 
-static struct pinctrl_desc uniphier_ld4_pinctrl_desc = {
-	.pins = uniphier_ld4_pins,
-	.npins = ARRAY_SIZE(uniphier_ld4_pins),
-};
-
 static int uniphier_ld4_pinctrl_probe(struct platform_device *pdev)
 {
-	return uniphier_pinctrl_probe(pdev, &uniphier_ld4_pinctrl_desc,
-				      &uniphier_ld4_pindata);
+	return uniphier_pinctrl_probe(pdev, &uniphier_ld4_pindata);
 }
 
 static const struct of_device_id uniphier_ld4_pinctrl_match[] = {
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
index 458c8a4..b8d1df9 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
@@ -1234,6 +1234,8 @@ static const struct uniphier_pinmux_function uniphier_ld6b_functions[] = {
 };
 
 static struct uniphier_pinctrl_socdata uniphier_ld6b_pindata = {
+	.pins = uniphier_ld6b_pins,
+	.npins = ARRAY_SIZE(uniphier_ld6b_pins),
 	.groups = uniphier_ld6b_groups,
 	.groups_count = ARRAY_SIZE(uniphier_ld6b_groups),
 	.functions = uniphier_ld6b_functions,
@@ -1243,15 +1245,9 @@ static struct uniphier_pinctrl_socdata uniphier_ld6b_pindata = {
 	.load_pinctrl = false,
 };
 
-static struct pinctrl_desc uniphier_ld6b_pinctrl_desc = {
-	.pins = uniphier_ld6b_pins,
-	.npins = ARRAY_SIZE(uniphier_ld6b_pins),
-};
-
 static int uniphier_ld6b_pinctrl_probe(struct platform_device *pdev)
 {
-	return uniphier_pinctrl_probe(pdev, &uniphier_ld6b_pinctrl_desc,
-				      &uniphier_ld6b_pindata);
+	return uniphier_pinctrl_probe(pdev, &uniphier_ld6b_pindata);
 }
 
 static const struct of_device_id uniphier_ld6b_pinctrl_match[] = {
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
index 7fcaeb5..d88b351 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
@@ -1520,6 +1520,8 @@ static const struct uniphier_pinmux_function uniphier_pro4_functions[] = {
 };
 
 static struct uniphier_pinctrl_socdata uniphier_pro4_pindata = {
+	.pins = uniphier_pro4_pins,
+	.npins = ARRAY_SIZE(uniphier_pro4_pins),
 	.groups = uniphier_pro4_groups,
 	.groups_count = ARRAY_SIZE(uniphier_pro4_groups),
 	.functions = uniphier_pro4_functions,
@@ -1529,15 +1531,9 @@ static struct uniphier_pinctrl_socdata uniphier_pro4_pindata = {
 	.load_pinctrl = true,
 };
 
-static struct pinctrl_desc uniphier_pro4_pinctrl_desc = {
-	.pins = uniphier_pro4_pins,
-	.npins = ARRAY_SIZE(uniphier_pro4_pins),
-};
-
 static int uniphier_pro4_pinctrl_probe(struct platform_device *pdev)
 {
-	return uniphier_pinctrl_probe(pdev, &uniphier_pro4_pinctrl_desc,
-				      &uniphier_pro4_pindata);
+	return uniphier_pinctrl_probe(pdev, &uniphier_pro4_pindata);
 }
 
 static const struct of_device_id uniphier_pro4_pinctrl_match[] = {
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
index 47fa57e..6282ace 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
@@ -1311,6 +1311,8 @@ static const struct uniphier_pinmux_function uniphier_pro5_functions[] = {
 };
 
 static struct uniphier_pinctrl_socdata uniphier_pro5_pindata = {
+	.pins = uniphier_pro5_pins,
+	.npins = ARRAY_SIZE(uniphier_pro5_pins),
 	.groups = uniphier_pro5_groups,
 	.groups_count = ARRAY_SIZE(uniphier_pro5_groups),
 	.functions = uniphier_pro5_functions,
@@ -1320,15 +1322,9 @@ static struct uniphier_pinctrl_socdata uniphier_pro5_pindata = {
 	.load_pinctrl = true,
 };
 
-static struct pinctrl_desc uniphier_pro5_pinctrl_desc = {
-	.pins = uniphier_pro5_pins,
-	.npins = ARRAY_SIZE(uniphier_pro5_pins),
-};
-
 static int uniphier_pro5_pinctrl_probe(struct platform_device *pdev)
 {
-	return uniphier_pinctrl_probe(pdev, &uniphier_pro5_pinctrl_desc,
-				      &uniphier_pro5_pindata);
+	return uniphier_pinctrl_probe(pdev, &uniphier_pro5_pindata);
 }
 
 static const struct of_device_id uniphier_pro5_pinctrl_match[] = {
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
index 246e2be..8c48f31 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
@@ -1229,6 +1229,8 @@ static const struct uniphier_pinmux_function uniphier_pxs2_functions[] = {
 };
 
 static struct uniphier_pinctrl_socdata uniphier_pxs2_pindata = {
+	.pins = uniphier_pxs2_pins,
+	.npins = ARRAY_SIZE(uniphier_pxs2_pins),
 	.groups = uniphier_pxs2_groups,
 	.groups_count = ARRAY_SIZE(uniphier_pxs2_groups),
 	.functions = uniphier_pxs2_functions,
@@ -1238,15 +1240,9 @@ static struct uniphier_pinctrl_socdata uniphier_pxs2_pindata = {
 	.load_pinctrl = false,
 };
 
-static struct pinctrl_desc uniphier_pxs2_pinctrl_desc = {
-	.pins = uniphier_pxs2_pins,
-	.npins = ARRAY_SIZE(uniphier_pxs2_pins),
-};
-
 static int uniphier_pxs2_pinctrl_probe(struct platform_device *pdev)
 {
-	return uniphier_pinctrl_probe(pdev, &uniphier_pxs2_pinctrl_desc,
-				      &uniphier_pxs2_pindata);
+	return uniphier_pinctrl_probe(pdev, &uniphier_pxs2_pindata);
 }
 
 static const struct of_device_id uniphier_pxs2_pinctrl_match[] = {
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
index 915259f..caf5380 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
@@ -754,6 +754,8 @@ static const struct uniphier_pinmux_function uniphier_sld8_functions[] = {
 };
 
 static struct uniphier_pinctrl_socdata uniphier_sld8_pindata = {
+	.pins = uniphier_sld8_pins,
+	.npins = ARRAY_SIZE(uniphier_sld8_pins),
 	.groups = uniphier_sld8_groups,
 	.groups_count = ARRAY_SIZE(uniphier_sld8_groups),
 	.functions = uniphier_sld8_functions,
@@ -763,15 +765,9 @@ static struct uniphier_pinctrl_socdata uniphier_sld8_pindata = {
 	.load_pinctrl = false,
 };
 
-static struct pinctrl_desc uniphier_sld8_pinctrl_desc = {
-	.pins = uniphier_sld8_pins,
-	.npins = ARRAY_SIZE(uniphier_sld8_pins),
-};
-
 static int uniphier_sld8_pinctrl_probe(struct platform_device *pdev)
 {
-	return uniphier_pinctrl_probe(pdev, &uniphier_sld8_pinctrl_desc,
-				      &uniphier_sld8_pindata);
+	return uniphier_pinctrl_probe(pdev, &uniphier_sld8_pindata);
 }
 
 static const struct of_device_id uniphier_sld8_pinctrl_match[] = {
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier.h b/drivers/pinctrl/uniphier/pinctrl-uniphier.h
index a21154f..0322413 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier.h
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier.h
@@ -19,6 +19,8 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 
+struct platform_device;
+
 #define UNIPHIER_PINCTRL_PINMUX_BASE	0x0
 #define UNIPHIER_PINCTRL_LOAD_PINMUX	0x700
 #define UNIPHIER_PINCTRL_DRVCTRL_BASE	0x800
@@ -154,6 +156,8 @@ struct uniphier_pinmux_function {
 };
 
 struct uniphier_pinctrl_socdata {
+	const struct pinctrl_pin_desc *pins;
+	unsigned int npins;
 	const struct uniphier_pinctrl_group *groups;
 	int groups_count;
 	const struct uniphier_pinmux_function *functions;
@@ -205,11 +209,7 @@ struct uniphier_pinctrl_socdata {
 		.num_groups = ARRAY_SIZE(func##_groups),		\
 	}
 
-struct platform_device;
-struct pinctrl_desc;
-
 int uniphier_pinctrl_probe(struct platform_device *pdev,
-			   struct pinctrl_desc *desc,
 			   struct uniphier_pinctrl_socdata *socdata);
 
 #endif /* __PINCTRL_UNIPHIER_H__ */
-- 
1.9.1
