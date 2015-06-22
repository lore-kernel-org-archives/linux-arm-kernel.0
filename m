From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Mon, 22 Jun 2015 18:12:24 +0300
Subject: [patch v2 1/2] pinctrl: samsung: don't truncate the last char
In-Reply-To: <20150619085203.GO28762@mwanda>
Message-ID: <20150622151223.GA14156@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We were allocating enough space because sizeof("-grp") and
sizeof("-mux") are both equal to 5 but in the snprintf() we only allowed
for 4 characters so the last 'p' and 'x' characters were truncated.

The allocate and sprintf can be done in one step with the kasprintf().

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos5440.c b/drivers/pinctrl/samsung/pinctrl-exynos5440.c
index f5619fb..fa84db6 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos5440.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos5440.c
@@ -44,9 +44,7 @@
 #define PIN_NAME_LENGTH		10
 
 #define GROUP_SUFFIX		"-grp"
-#define GSUFFIX_LEN		sizeof(GROUP_SUFFIX)
 #define FUNCTION_SUFFIX		"-mux"
-#define FSUFFIX_LEN		sizeof(FUNCTION_SUFFIX)
 
 /*
  * pin configuration type and its value are packed together into a 16-bits.
@@ -215,12 +213,11 @@ static int exynos5440_dt_node_to_map(struct pinctrl_dev *pctldev,
 	 * Allocate memory for pin group name. The pin group name is derived
 	 * from the node name from which these map entries are be created.
 	 */
-	gname = kzalloc(strlen(np->name) + GSUFFIX_LEN, GFP_KERNEL);
+	gname = kasprintf(GFP_KERNEL, "%s%s", np->name, GROUP_SUFFIX);
 	if (!gname) {
 		dev_err(dev, "failed to alloc memory for group name\n");
 		goto free_map;
 	}
-	snprintf(gname, strlen(np->name) + 4, "%s%s", np->name, GROUP_SUFFIX);
 
 	/*
 	 * don't have config options? then skip over to creating function
@@ -254,13 +251,12 @@ static int exynos5440_dt_node_to_map(struct pinctrl_dev *pctldev,
 skip_cfgs:
 	/* create the function map entry */
 	if (of_find_property(np, "samsung,exynos5440-pin-function", NULL)) {
-		fname = kzalloc(strlen(np->name) + FSUFFIX_LEN,	GFP_KERNEL);
+		fname = kasprintf(GFP_KERNEL,
+				  "%s%s", np->name, FUNCTION_SUFFIX);
 		if (!fname) {
 			dev_err(dev, "failed to alloc memory for func name\n");
 			goto free_cfg;
 		}
-		snprintf(fname, strlen(np->name) + 4, "%s%s", np->name,
-			 FUNCTION_SUFFIX);
 
 		map[*nmaps].data.mux.group = gname;
 		map[*nmaps].data.mux.function = fname;
@@ -710,14 +706,12 @@ static int exynos5440_pinctrl_parse_dt(struct platform_device *pdev,
 		}
 
 		/* derive pin group name from the node name */
-		gname = devm_kzalloc(dev, strlen(cfg_np->name) + GSUFFIX_LEN,
-					GFP_KERNEL);
+		gname = devm_kasprintf(dev, GFP_KERNEL,
+				       "%s%s", cfg_np->name, GROUP_SUFFIX);
 		if (!gname) {
 			dev_err(dev, "failed to alloc memory for group name\n");
 			return -ENOMEM;
 		}
-		snprintf(gname, strlen(cfg_np->name) + 4, "%s%s", cfg_np->name,
-			 GROUP_SUFFIX);
 
 		grp->name = gname;
 		grp->pins = pin_list;
@@ -731,14 +725,12 @@ skip_to_pin_function:
 			continue;
 
 		/* derive function name from the node name */
-		fname = devm_kzalloc(dev, strlen(cfg_np->name) + FSUFFIX_LEN,
-					GFP_KERNEL);
+		fname = devm_kasprintf(dev, GFP_KERNEL,
+				       "%s%s", cfg_np->name, FUNCTION_SUFFIX);
 		if (!fname) {
 			dev_err(dev, "failed to alloc memory for func name\n");
 			return -ENOMEM;
 		}
-		snprintf(fname, strlen(cfg_np->name) + 4, "%s%s", cfg_np->name,
-			 FUNCTION_SUFFIX);
 
 		func->name = fname;
 		func->groups = devm_kzalloc(dev, sizeof(char *), GFP_KERNEL);
