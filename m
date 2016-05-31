From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 31 May 2016 17:05:16 +0900
Subject: [PATCH 10/17] pinctrl: uniphier: introduce capability flag
In-Reply-To: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
References: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1464681923-7469-11-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core part of the UniPhier pinctrl driver needs to support a new
capability for upcoming UniPhier ARMv8 SoCs.  This sometimes happens
because pinctrl drivers include really SoC-specific stuff.

This commit intends to tidy up SoC-specific parameters of the existing
drivers before adding the new one.  Having just one flag would be
better than adding a new struct member every time a new SoC-specific
capability comes up.

At this time, there is one flag, UNIPHIER_PINCTRL_CAPS_DBGMUX_SEPARATE.
This capability (I'd say rather quirk) was added for PH1-Pro4 and
PH1-Pro5 as requirement from a customer.  For those SoCs, one pin-mux
setting is controlled by the combination of two separate registers; the
LSB bits at register offset (8 * N) and the MSB bits at (8 * N + 4).
Because it is impossible to update two separate registers atomically,
the LOAD_PINCTRL register should be set in order to make the pin-mux
settings really effective.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 35 +++++++++++++++++-------
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c  |  4 +--
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c |  4 +--
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c |  4 +--
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c |  4 +--
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c |  4 +--
 drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c |  4 +--
 drivers/pinctrl/uniphier/pinctrl-uniphier.h      |  6 ++--
 8 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
index 39e3375..ca2562a 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
@@ -552,9 +552,8 @@ static int uniphier_pmx_set_one_mux(struct pinctrl_dev *pctldev, unsigned pin,
 				    unsigned muxval)
 {
 	struct uniphier_pinctrl_priv *priv = pinctrl_dev_get_drvdata(pctldev);
-	unsigned mux_bits = priv->socdata->mux_bits;
-	unsigned reg_stride = priv->socdata->reg_stride;
-	unsigned reg, reg_end, shift, mask;
+	unsigned int mux_bits, reg_stride, reg, reg_end, shift, mask;
+	bool load_pinctrl;
 	int ret;
 
 	/* some pins need input-enabling */
@@ -563,6 +562,26 @@ static int uniphier_pmx_set_one_mux(struct pinctrl_dev *pctldev, unsigned pin,
 	if (ret)
 		return ret;
 
+	if (priv->socdata->caps & UNIPHIER_PINCTRL_CAPS_DBGMUX_SEPARATE) {
+		/*
+		 *  Mode     reg_offset     bit_position
+		 *  Normal    4 * n        shift+3:shift
+		 *  Debug     4 * n        shift+7:shift+4
+		 */
+		mux_bits = 4;
+		reg_stride = 8;
+		load_pinctrl = true;
+	} else {
+		/*
+		 *  Mode     reg_offset     bit_position
+		 *  Normal    8 * n        shift+3:shift
+		 *  Debug     8 * n + 4    shift+3:shift
+		 */
+		mux_bits = 8;
+		reg_stride = 4;
+		load_pinctrl = false;
+	}
+
 	reg = UNIPHIER_PINCTRL_PINMUX_BASE + pin * mux_bits / 32 * reg_stride;
 	reg_end = reg + reg_stride;
 	shift = pin * mux_bits % 32;
@@ -580,7 +599,7 @@ static int uniphier_pmx_set_one_mux(struct pinctrl_dev *pctldev, unsigned pin,
 		muxval >>= mux_bits;
 	}
 
-	if (priv->socdata->load_pinctrl) {
+	if (load_pinctrl) {
 		ret = regmap_write(priv->regmap,
 				   UNIPHIER_PINCTRL_LOAD_PINMUX, 1);
 		if (ret)
@@ -658,12 +677,8 @@ int uniphier_pinctrl_probe(struct platform_device *pdev,
 
 	if (!socdata ||
 	    !socdata->pins || !socdata->npins ||
-	    !socdata->groups ||
-	    !socdata->groups_count ||
-	    !socdata->functions ||
-	    !socdata->functions_count ||
-	    !socdata->mux_bits ||
-	    !socdata->reg_stride) {
+	    !socdata->groups || !socdata->groups_count ||
+	    !socdata->functions || !socdata->functions_count) {
 		dev_err(dev, "pinctrl socdata lacks necessary members\n");
 		return -EINVAL;
 	}
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
index 4ada574..edea90d 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
@@ -852,9 +852,7 @@ static struct uniphier_pinctrl_socdata uniphier_ld4_pindata = {
 	.groups_count = ARRAY_SIZE(uniphier_ld4_groups),
 	.functions = uniphier_ld4_functions,
 	.functions_count = ARRAY_SIZE(uniphier_ld4_functions),
-	.mux_bits = 8,
-	.reg_stride = 4,
-	.load_pinctrl = false,
+	.caps = 0,
 };
 
 static int uniphier_ld4_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
index 7ae42a4..2c9747b 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
@@ -1240,9 +1240,7 @@ static struct uniphier_pinctrl_socdata uniphier_ld6b_pindata = {
 	.groups_count = ARRAY_SIZE(uniphier_ld6b_groups),
 	.functions = uniphier_ld6b_functions,
 	.functions_count = ARRAY_SIZE(uniphier_ld6b_functions),
-	.mux_bits = 8,
-	.reg_stride = 4,
-	.load_pinctrl = false,
+	.caps = 0,
 };
 
 static int uniphier_ld6b_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
index 3735eb7..547359e 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
@@ -1526,9 +1526,7 @@ static struct uniphier_pinctrl_socdata uniphier_pro4_pindata = {
 	.groups_count = ARRAY_SIZE(uniphier_pro4_groups),
 	.functions = uniphier_pro4_functions,
 	.functions_count = ARRAY_SIZE(uniphier_pro4_functions),
-	.mux_bits = 4,
-	.reg_stride = 8,
-	.load_pinctrl = true,
+	.caps = UNIPHIER_PINCTRL_CAPS_DBGMUX_SEPARATE,
 };
 
 static int uniphier_pro4_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
index 7a883161..080332d 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
@@ -1317,9 +1317,7 @@ static struct uniphier_pinctrl_socdata uniphier_pro5_pindata = {
 	.groups_count = ARRAY_SIZE(uniphier_pro5_groups),
 	.functions = uniphier_pro5_functions,
 	.functions_count = ARRAY_SIZE(uniphier_pro5_functions),
-	.mux_bits = 4,
-	.reg_stride = 8,
-	.load_pinctrl = true,
+	.caps = UNIPHIER_PINCTRL_CAPS_DBGMUX_SEPARATE,
 };
 
 static int uniphier_pro5_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
index d8190e8..a2bf3f7 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
@@ -1235,9 +1235,7 @@ static struct uniphier_pinctrl_socdata uniphier_pxs2_pindata = {
 	.groups_count = ARRAY_SIZE(uniphier_pxs2_groups),
 	.functions = uniphier_pxs2_functions,
 	.functions_count = ARRAY_SIZE(uniphier_pxs2_functions),
-	.mux_bits = 8,
-	.reg_stride = 4,
-	.load_pinctrl = false,
+	.caps = 0,
 };
 
 static int uniphier_pxs2_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
index d2c4d90..ef86693 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
@@ -760,9 +760,7 @@ static struct uniphier_pinctrl_socdata uniphier_sld8_pindata = {
 	.groups_count = ARRAY_SIZE(uniphier_sld8_groups),
 	.functions = uniphier_sld8_functions,
 	.functions_count = ARRAY_SIZE(uniphier_sld8_functions),
-	.mux_bits = 8,
-	.reg_stride = 4,
-	.load_pinctrl = false,
+	.caps = 0,
 };
 
 static int uniphier_sld8_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier.h b/drivers/pinctrl/uniphier/pinctrl-uniphier.h
index eca379a..3fd5020 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier.h
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier.h
@@ -15,6 +15,7 @@
 #ifndef __PINCTRL_UNIPHIER_H__
 #define __PINCTRL_UNIPHIER_H__
 
+#include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -164,9 +165,8 @@ struct uniphier_pinctrl_socdata {
 	int groups_count;
 	const struct uniphier_pinmux_function *functions;
 	int functions_count;
-	unsigned mux_bits;
-	unsigned reg_stride;
-	bool load_pinctrl;
+	unsigned int caps;
+#define UNIPHIER_PINCTRL_CAPS_DBGMUX_SEPARATE	BIT(0)
 };
 
 #define UNIPHIER_PINCTRL_PIN(a, b, c, d, e, f, g)			\
-- 
1.9.1
