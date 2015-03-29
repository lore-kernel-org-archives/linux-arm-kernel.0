From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 29 Mar 2015 23:20:04 +0200
Subject: [PATCH] pinctrl: imx: Allow parsing DT without function nodes
Message-ID: <1427664004-21056-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The old format to define pinctrl settings for imx in DT has two
hierarchy levels. The first level are function device nodes. The second
level are pingroups which contain a property fsl,pins. The original
intention was to define all pin functions in a single dtsi file and just
reference the correct ones in the board files.
This idea was rejected some time ago leading to the current design to
have all the pinfunctions defined in the board files. So we don't need
the function device nodes anymore.

This patch changes the pinctrl driver to accept devicetrees which do not
have the first hierarchy level, function device nodes. For example
karo-tx25 already has such a devicetree. Old devicetrees are still
parsed and supported.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/pinctrl/freescale/pinctrl-imx.c | 41 +++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 448f10986c28..4f1b0e4ff361 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -610,14 +610,29 @@ static int imx_pinctrl_probe_dt(struct platform_device *pdev,
 	struct device_node *child;
 	u32 nfuncs = 0;
 	u32 i = 0;
+	bool flat_funcs = false;
 
 	if (!np)
 		return -ENODEV;
 
-	nfuncs = of_get_child_count(np);
-	if (nfuncs <= 0) {
-		dev_err(&pdev->dev, "no functions defined\n");
-		return -EINVAL;
+	/*
+	 * Check if the DT contains pins in the direct child nodes. This
+	 * indicates the newer DT format to store pins. The old format with
+	 * function devicenodes which contain group nodes which contain
+	 * fsl,pins is still parsed if flat_funcs is false.
+	 */
+	child = of_get_next_child(np, NULL);
+	if (child)
+		flat_funcs = of_property_read_bool(child, "fsl,pins");
+
+	if (flat_funcs) {
+		nfuncs = 1;
+	} else {
+		nfuncs = of_get_child_count(np);
+		if (nfuncs <= 0) {
+			dev_err(&pdev->dev, "no functions defined\n");
+			return -EINVAL;
+		}
 	}
 
 	info->nfunctions = nfuncs;
@@ -626,16 +641,24 @@ static int imx_pinctrl_probe_dt(struct platform_device *pdev,
 	if (!info->functions)
 		return -ENOMEM;
 
-	info->ngroups = 0;
-	for_each_child_of_node(np, child)
-		info->ngroups += of_get_child_count(child);
+	if (flat_funcs) {
+		info->ngroups = of_get_child_count(np);
+	} else {
+		info->ngroups = 0;
+		for_each_child_of_node(np, child)
+			info->ngroups += of_get_child_count(child);
+	}
 	info->groups = devm_kzalloc(&pdev->dev, info->ngroups * sizeof(struct imx_pin_group),
 					GFP_KERNEL);
 	if (!info->groups)
 		return -ENOMEM;
 
-	for_each_child_of_node(np, child)
-		imx_pinctrl_parse_functions(child, info, i++);
+	if (flat_funcs) {
+		imx_pinctrl_parse_functions(np, info, 0);
+	} else {
+		for_each_child_of_node(np, child)
+			imx_pinctrl_parse_functions(child, info, i++);
+	}
 
 	return 0;
 }
-- 
2.1.4
