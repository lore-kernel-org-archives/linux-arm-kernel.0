From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 31 May 2016 17:05:17 +0900
Subject: [PATCH 11/17] pinctrl: uniphier: support per-pin input enable for new
 SoCs
In-Reply-To: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
References: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1464681923-7469-12-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Upcoming new pinctrl drivers for PH1-LD11 and PH-LD20 support input
signal gating for each pin.  (While, existing ones only support it
per pin-group.)  This commit updates the core part for that.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 24 +++++++++++++-----------
 drivers/pinctrl/uniphier/pinctrl-uniphier.h      |  1 +
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
index ca2562a..d774a8e 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
@@ -433,22 +433,24 @@ static int uniphier_conf_pin_input_enable(struct pinctrl_dev *pctldev,
 {
 	struct uniphier_pinctrl_priv *priv = pinctrl_dev_get_drvdata(pctldev);
 	unsigned int iectrl = uniphier_pin_get_iectrl(desc->drv_data);
+	unsigned int reg, mask;
 
-	if (enable == 0) {
-		/*
-		 * Multiple pins share one input enable, so per-pin disabling
-		 * is impossible.
-		 */
-		dev_err(pctldev->dev, "unable to disable input\n");
+	/*
+	 * Multiple pins share one input enable, per-pin disabling is
+	 * impossible.
+	 */
+	if (!(priv->socdata->caps & UNIPHIER_PINCTRL_CAPS_PERPIN_IECTRL) &&
+	    !enable)
 		return -EINVAL;
-	}
 
+	/* UNIPHIER_PIN_IECTRL_NONE means the pin is always input-enabled */
 	if (iectrl == UNIPHIER_PIN_IECTRL_NONE)
-		/* This pin is always input-enabled. nothing to do. */
-		return 0;
+		return enable ? 0 : -EINVAL;
+
+	reg = UNIPHIER_PINCTRL_IECTRL + iectrl / 32 * 4;
+	mask = BIT(iectrl % 32);
 
-	return regmap_update_bits(priv->regmap, UNIPHIER_PINCTRL_IECTRL,
-				  BIT(iectrl), BIT(iectrl));
+	return regmap_update_bits(priv->regmap, reg, mask, enable ? mask : 0);
 }
 
 static int uniphier_conf_pin_config_set(struct pinctrl_dev *pctldev,
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier.h b/drivers/pinctrl/uniphier/pinctrl-uniphier.h
index 3fd5020..9941a4c 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier.h
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier.h
@@ -166,6 +166,7 @@ struct uniphier_pinctrl_socdata {
 	const struct uniphier_pinmux_function *functions;
 	int functions_count;
 	unsigned int caps;
+#define UNIPHIER_PINCTRL_CAPS_PERPIN_IECTRL	BIT(1)
 #define UNIPHIER_PINCTRL_CAPS_DBGMUX_SEPARATE	BIT(0)
 };
 
-- 
1.9.1
