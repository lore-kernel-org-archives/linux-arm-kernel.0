From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  3 Oct 2016 12:21:03 +0200
Subject: [PATCH 5/9] pinctrl: sunxi: Support generic binding
In-Reply-To: <cover.26c6f76b361d146fb079d744251f020ef6d2db7d.1475489558.git-series.maxime.ripard@free-electrons.com>
References: <cover.26c6f76b361d146fb079d744251f020ef6d2db7d.1475489558.git-series.maxime.ripard@free-electrons.com>
Message-ID: <1b45160fb37e2dcabd855d2192fc403a1c4db324.1475489558.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our bindings are mostly irrelevant now that we have generic pinctrl
bindings that cover exactly the same uses cases.

Add support for the new ones, and obviously keep our old binding support in
order to keep the ABI stable.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 48 ++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index cec977fcf98c..b52af7f1418a 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -150,18 +150,33 @@ static int sunxi_pctrl_get_group_pins(struct pinctrl_dev *pctldev,
 
 static bool sunxi_pctrl_has_bias_prop(struct device_node *node)
 {
-	return of_find_property(node, "allwinner,pull", NULL);
+	return of_find_property(node, "bias-pull-up", NULL) ||
+		of_find_property(node, "bias-pull-down", NULL) ||
+		of_find_property(node, "bias-disable", NULL) ||
+		of_find_property(node, "allwinner,pull", NULL);
 }
 
 static bool sunxi_pctrl_has_drive_prop(struct device_node *node)
 {
-	return of_find_property(node, "allwinner,drive", NULL);
+	return of_find_property(node, "drive-strength", NULL) ||
+		of_find_property(node, "allwinner,drive", NULL);
 }
 
 static int sunxi_pctrl_parse_bias_prop(struct device_node *node)
 {
 	u32 val;
 
+	/* Try the new style binding */
+	if (of_find_property(node, "bias-pull-up", NULL))
+		return PIN_CONFIG_BIAS_PULL_UP;
+
+	if (of_find_property(node, "bias-pull-down", NULL))
+		return PIN_CONFIG_BIAS_PULL_DOWN;
+
+	if (of_find_property(node, "bias-disable", NULL))
+		return PIN_CONFIG_BIAS_DISABLE;
+
+	/* And fall back to the old binding */
 	if (of_property_read_u32(node, "allwinner,pull", &val))
 		return -EINVAL;
 
@@ -181,6 +196,21 @@ static int sunxi_pctrl_parse_drive_prop(struct device_node *node)
 {
 	u32 val;
 
+	/* Try the new style binding */
+	if (!of_property_read_u32(node, "drive-strength", &val)) {
+		/* We can't go below 10mA ... */
+		if (val < 10)
+			return -EINVAL;
+
+		/* ... and only up to 40 mA ... */
+		if (val > 40)
+			val = 40;
+
+		/* by steps of 10 mA */
+		return rounddown(val, 10);
+	}
+
+	/* And then fall back to the old binding */
 	if (of_property_read_u32(node, "allwinner,drive", &val))
 		return -EINVAL;
 
@@ -192,6 +222,12 @@ static const char *sunxi_pctrl_parse_function_prop(struct device_node *node)
 	const char *function;
 	int ret;
 
+	/* Try the generic binding */
+	ret = of_property_read_string(node, "function", &function);
+	if (!ret)
+		return function;
+
+	/* And fall back to our legacy one */
 	ret = of_property_read_string(node, "allwinner,function", &function);
 	if (!ret)
 		return function;
@@ -204,6 +240,14 @@ static const char *sunxi_pctrl_find_pins_prop(struct device_node *node,
 {
 	int count;
 
+	/* Try the generic binding */
+	count = of_property_count_strings(node, "pins");
+	if (count > 0) {
+		*npins = count;
+		return "pins";
+	}
+
+	/* And fall back to our legacy one */
 	count = of_property_count_strings(node, "allwinner,pins");
 	if (count > 0) {
 		*npins = count;
-- 
git-series 0.8.10
