From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Mon, 22 Jun 2015 18:13:15 +0300
Subject: [patch v2 2/2] pinctrl: samsung: remove "out of memory" messages
In-Reply-To: <20150619085203.GO28762@mwanda>
Message-ID: <20150622151315.GB14156@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Checkpatch.pl complains about these:

WARNING: Possible unnecessary 'out of memory' message

The messages use a little extra RAM and they add a few extra lines of
code.  We're probably never going to hit these out of memory situations
but if we did then kmalloc() has pretty good error messages built-in.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos5440.c b/drivers/pinctrl/samsung/pinctrl-exynos5440.c
index fa84db6..5574b8a 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos5440.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos5440.c
@@ -203,10 +203,8 @@ static int exynos5440_dt_node_to_map(struct pinctrl_dev *pctldev,
 
 	/* Allocate memory for pin-map entries */
 	map = kzalloc(sizeof(*map) * map_cnt, GFP_KERNEL);
-	if (!map) {
-		dev_err(dev, "could not alloc memory for pin-maps\n");
+	if (!map)
 		return -ENOMEM;
-	}
 	*nmaps = 0;
 
 	/*
@@ -214,10 +212,8 @@ static int exynos5440_dt_node_to_map(struct pinctrl_dev *pctldev,
 	 * from the node name from which these map entries are be created.
 	 */
 	gname = kasprintf(GFP_KERNEL, "%s%s", np->name, GROUP_SUFFIX);
-	if (!gname) {
-		dev_err(dev, "failed to alloc memory for group name\n");
+	if (!gname)
 		goto free_map;
-	}
 
 	/*
 	 * don't have config options? then skip over to creating function
@@ -228,10 +224,8 @@ static int exynos5440_dt_node_to_map(struct pinctrl_dev *pctldev,
 
 	/* Allocate memory for config entries */
 	cfg = kzalloc(sizeof(*cfg) * cfg_cnt, GFP_KERNEL);
-	if (!cfg) {
-		dev_err(dev, "failed to alloc memory for configs\n");
+	if (!cfg)
 		goto free_gname;
-	}
 
 	/* Prepare a list of config settings */
 	for (idx = 0, cfg_cnt = 0; idx < ARRAY_SIZE(pcfgs); idx++) {
@@ -253,10 +247,8 @@ skip_cfgs:
 	if (of_find_property(np, "samsung,exynos5440-pin-function", NULL)) {
 		fname = kasprintf(GFP_KERNEL,
 				  "%s%s", np->name, FUNCTION_SUFFIX);
-		if (!fname) {
-			dev_err(dev, "failed to alloc memory for func name\n");
+		if (!fname)
 			goto free_cfg;
-		}
 
 		map[*nmaps].data.mux.group = gname;
 		map[*nmaps].data.mux.function = fname;
@@ -647,10 +639,8 @@ static int exynos5440_pinctrl_parse_dt_pins(struct platform_device *pdev,
 	}
 
 	*pin_list = devm_kzalloc(dev, *npins * sizeof(**pin_list), GFP_KERNEL);
-	if (!*pin_list) {
-		dev_err(dev, "failed to allocate memory for pin list\n");
+	if (!*pin_list)
 		return -ENOMEM;
-	}
 
 	return of_property_read_u32_array(cfg_np, "samsung,exynos5440-pins",
 			*pin_list, *npins);
@@ -678,17 +668,15 @@ static int exynos5440_pinctrl_parse_dt(struct platform_device *pdev,
 		return -EINVAL;
 
 	groups = devm_kzalloc(dev, grp_cnt * sizeof(*groups), GFP_KERNEL);
-	if (!groups) {
-		dev_err(dev, "failed allocate memory for ping group list\n");
+	if (!groups)
 		return -EINVAL;
-	}
+
 	grp = groups;
 
 	functions = devm_kzalloc(dev, grp_cnt * sizeof(*functions), GFP_KERNEL);
-	if (!functions) {
-		dev_err(dev, "failed to allocate memory for function list\n");
+	if (!functions)
 		return -EINVAL;
-	}
+
 	func = functions;
 
 	/*
@@ -708,10 +696,8 @@ static int exynos5440_pinctrl_parse_dt(struct platform_device *pdev,
 		/* derive pin group name from the node name */
 		gname = devm_kasprintf(dev, GFP_KERNEL,
 				       "%s%s", cfg_np->name, GROUP_SUFFIX);
-		if (!gname) {
-			dev_err(dev, "failed to alloc memory for group name\n");
+		if (!gname)
 			return -ENOMEM;
-		}
 
 		grp->name = gname;
 		grp->pins = pin_list;
@@ -727,18 +713,13 @@ skip_to_pin_function:
 		/* derive function name from the node name */
 		fname = devm_kasprintf(dev, GFP_KERNEL,
 				       "%s%s", cfg_np->name, FUNCTION_SUFFIX);
-		if (!fname) {
-			dev_err(dev, "failed to alloc memory for func name\n");
+		if (!fname)
 			return -ENOMEM;
-		}
 
 		func->name = fname;
 		func->groups = devm_kzalloc(dev, sizeof(char *), GFP_KERNEL);
-		if (!func->groups) {
-			dev_err(dev, "failed to alloc memory for group list "
-					"in pin function");
+		if (!func->groups)
 			return -ENOMEM;
-		}
 		func->groups[0] = gname;
 		func->num_groups = gname ? 1 : 0;
 		func->function = function;
@@ -766,10 +747,8 @@ static int exynos5440_pinctrl_register(struct platform_device *pdev,
 	int pin, ret;
 
 	ctrldesc = devm_kzalloc(dev, sizeof(*ctrldesc), GFP_KERNEL);
-	if (!ctrldesc) {
-		dev_err(dev, "could not allocate memory for pinctrl desc\n");
+	if (!ctrldesc)
 		return -ENOMEM;
-	}
 
 	ctrldesc->name = "exynos5440-pinctrl";
 	ctrldesc->owner = THIS_MODULE;
@@ -779,10 +758,8 @@ static int exynos5440_pinctrl_register(struct platform_device *pdev,
 
 	pindesc = devm_kzalloc(&pdev->dev, sizeof(*pindesc) *
 				EXYNOS5440_MAX_PINS, GFP_KERNEL);
-	if (!pindesc) {
-		dev_err(&pdev->dev, "mem alloc for pin descriptors failed\n");
+	if (!pindesc)
 		return -ENOMEM;
-	}
 	ctrldesc->pins = pindesc;
 	ctrldesc->npins = EXYNOS5440_MAX_PINS;
 
@@ -796,10 +773,8 @@ static int exynos5440_pinctrl_register(struct platform_device *pdev,
 	 */
 	pin_names = devm_kzalloc(&pdev->dev, sizeof(char) * PIN_NAME_LENGTH *
 					ctrldesc->npins, GFP_KERNEL);
-	if (!pin_names) {
-		dev_err(&pdev->dev, "mem alloc for pin names failed\n");
+	if (!pin_names)
 		return -ENOMEM;
-	}
 
 	/* for each pin, set the name of the pin */
 	for (pin = 0; pin < ctrldesc->npins; pin++) {
@@ -836,10 +811,8 @@ static int exynos5440_gpiolib_register(struct platform_device *pdev,
 	int ret;
 
 	gc = devm_kzalloc(&pdev->dev, sizeof(*gc), GFP_KERNEL);
-	if (!gc) {
-		dev_err(&pdev->dev, "mem alloc for gpio_chip failed\n");
+	if (!gc)
 		return -ENOMEM;
-	}
 
 	priv->gc = gc;
 	gc->base = 0;
@@ -941,10 +914,8 @@ static int exynos5440_gpio_irq_init(struct platform_device *pdev,
 
 	intd = devm_kzalloc(dev, sizeof(*intd) * EXYNOS5440_MAX_GPIO_INT,
 					GFP_KERNEL);
-	if (!intd) {
-		dev_err(dev, "failed to allocate memory for gpio intr data\n");
+	if (!intd)
 		return -ENOMEM;
-	}
 
 	for (i = 0; i < EXYNOS5440_MAX_GPIO_INT; i++) {
 		irq = irq_of_parse_and_map(dev->of_node, i);
@@ -987,10 +958,8 @@ static int exynos5440_pinctrl_probe(struct platform_device *pdev)
 	}
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(dev, "could not allocate memory for private data\n");
+	if (!priv)
 		return -ENOMEM;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->reg_base = devm_ioremap_resource(&pdev->dev, res);
