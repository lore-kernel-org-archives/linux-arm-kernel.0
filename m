From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 10 Apr 2015 16:22:38 +0200
Subject: [PATCH v2] pinctrl: imx: Allow parsing DT without function nodes
Message-ID: <1428675758-15335-1-git-send-email-mpa@pengutronix.de>
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

I fixed the detection of the old and new format in v2. There is now a dedicated
function which searches for the first occurence of 'fsl,pins' in a child node
or a child's child node. If child is found, it is assumed that there are no
function device nodes.

Best Regards,

Markus

 drivers/pinctrl/freescale/pinctrl-imx.c | 55 +++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 2cc400b0a26b..62c38ab23489 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -606,6 +606,29 @@ static int imx_pinctrl_parse_functions(struct device_node *np,
 	return 0;
 }
 
+/*
+ * Check if the DT contains pins in the direct child nodes. This indicates the
+ * newer DT format to store pins. This function returns true if the first found
+ * fsl,pins property is in a child of np. Otherwise false is returned.
+ */
+static bool imx_pinctrl_dt_is_flat_functions(struct device_node *np)
+{
+	struct device_node *function_np;
+	struct device_node *pinctrl_np;
+
+	for_each_child_of_node(np, function_np) {
+		if (of_property_read_bool(function_np, "fsl,pins"))
+			return true;
+
+		for_each_child_of_node(function_np, pinctrl_np) {
+			if (of_property_read_bool(pinctrl_np, "fsl,pins"))
+				return false;
+		}
+	}
+
+	return true;
+}
+
 static int imx_pinctrl_probe_dt(struct platform_device *pdev,
 				struct imx_pinctrl_soc_info *info)
 {
@@ -613,14 +636,20 @@ static int imx_pinctrl_probe_dt(struct platform_device *pdev,
 	struct device_node *child;
 	u32 nfuncs = 0;
 	u32 i = 0;
+	bool flat_funcs;
 
 	if (!np)
 		return -ENODEV;
 
-	nfuncs = of_get_child_count(np);
-	if (nfuncs <= 0) {
-		dev_err(&pdev->dev, "no functions defined\n");
-		return -EINVAL;
+	flat_funcs = imx_pinctrl_dt_is_flat_functions(np);
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
@@ -629,16 +658,24 @@ static int imx_pinctrl_probe_dt(struct platform_device *pdev,
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
