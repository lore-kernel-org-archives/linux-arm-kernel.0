From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Sat, 16 Feb 2013 10:25:07 +0100
Subject: [PATCH v2] pinctrl: Declare operation structures as const
Message-ID: <1361006707-28981-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pinconf, pinctrl and pinmux operation structures hold function
pointers that are never modified. Declare them as const.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/devicetree.c          | 4 ++--
 drivers/pinctrl/mvebu/pinctrl-mvebu.c | 6 +++---
 drivers/pinctrl/pinconf.c             | 2 +-
 drivers/pinctrl/pinctrl-abx500.c      | 6 +++---
 drivers/pinctrl/pinctrl-at91.c        | 6 +++---
 drivers/pinctrl/pinctrl-bcm2835.c     | 6 +++---
 drivers/pinctrl/pinctrl-exynos5440.c  | 6 +++---
 drivers/pinctrl/pinctrl-falcon.c      | 2 +-
 drivers/pinctrl/pinctrl-imx.c         | 6 +++---
 drivers/pinctrl/pinctrl-lantiq.c      | 4 ++--
 drivers/pinctrl/pinctrl-mxs.c         | 6 +++---
 drivers/pinctrl/pinctrl-nomadik.c     | 6 +++---
 drivers/pinctrl/pinctrl-pxa3xx.c      | 4 ++--
 drivers/pinctrl/pinctrl-samsung.c     | 6 +++---
 drivers/pinctrl/pinctrl-single.c      | 6 +++---
 drivers/pinctrl/pinctrl-sirf.c        | 4 ++--
 drivers/pinctrl/pinctrl-sunxi.c       | 6 +++---
 drivers/pinctrl/pinctrl-tegra.c       | 6 +++---
 drivers/pinctrl/pinctrl-u300.c        | 6 +++---
 drivers/pinctrl/pinctrl-xway.c        | 2 +-
 drivers/pinctrl/spear/pinctrl-spear.c | 4 ++--
 include/linux/pinctrl/pinctrl.h       | 6 +++---
 22 files changed, 55 insertions(+), 55 deletions(-)

Changes compared to v1:

- Rebase on top of
  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
- Constify pinctrl-abx500.c and pinctrl-sunxi.c

diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index fd40a11..c7b7cb4 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -41,7 +41,7 @@ static void dt_free_map(struct pinctrl_dev *pctldev,
 		     struct pinctrl_map *map, unsigned num_maps)
 {
 	if (pctldev) {
-		struct pinctrl_ops *ops = pctldev->desc->pctlops;
+		const struct pinctrl_ops *ops = pctldev->desc->pctlops;
 		ops->dt_free_map(pctldev, map, num_maps);
 	} else {
 		/* There is no pctldev for PIN_MAP_TYPE_DUMMY_STATE */
@@ -122,7 +122,7 @@ static int dt_to_map_one_config(struct pinctrl *p, const char *statename,
 {
 	struct device_node *np_pctldev;
 	struct pinctrl_dev *pctldev;
-	struct pinctrl_ops *ops;
+	const struct pinctrl_ops *ops;
 	int ret;
 	struct pinctrl_map *map;
 	unsigned num_maps;
diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.c b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
index c689c04..6114991 100644
--- a/drivers/pinctrl/mvebu/pinctrl-mvebu.c
+++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
@@ -263,7 +263,7 @@ static void mvebu_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
 	return;
 }
 
-static struct pinconf_ops mvebu_pinconf_ops = {
+static const struct pinconf_ops mvebu_pinconf_ops = {
 	.pin_config_group_get = mvebu_pinconf_group_get,
 	.pin_config_group_set = mvebu_pinconf_group_set,
 	.pin_config_group_dbg_show = mvebu_pinconf_group_dbg_show,
@@ -369,7 +369,7 @@ static int mvebu_pinmux_gpio_set_direction(struct pinctrl_dev *pctldev,
 	return -ENOTSUPP;
 }
 
-static struct pinmux_ops mvebu_pinmux_ops = {
+static const struct pinmux_ops mvebu_pinmux_ops = {
 	.get_functions_count = mvebu_pinmux_get_funcs_count,
 	.get_function_name = mvebu_pinmux_get_func_name,
 	.get_function_groups = mvebu_pinmux_get_groups,
@@ -470,7 +470,7 @@ static void mvebu_pinctrl_dt_free_map(struct pinctrl_dev *pctldev,
 	kfree(map);
 }
 
-static struct pinctrl_ops mvebu_pinctrl_ops = {
+static const struct pinctrl_ops mvebu_pinctrl_ops = {
 	.get_groups_count = mvebu_pinctrl_get_groups_count,
 	.get_group_name = mvebu_pinctrl_get_group_name,
 	.get_group_pins = mvebu_pinctrl_get_group_pins,
diff --git a/drivers/pinctrl/pinconf.c b/drivers/pinctrl/pinconf.c
index ac8d382..8aefd28 100644
--- a/drivers/pinctrl/pinconf.c
+++ b/drivers/pinctrl/pinconf.c
@@ -670,7 +670,7 @@ static int pinconf_dbg_config_print(struct seq_file *s, void *d)
 	struct pinctrl_maps *maps_node;
 	struct pinctrl_map const *map;
 	struct pinctrl_dev *pctldev = NULL;
-	struct pinconf_ops *confops = NULL;
+	const struct pinconf_ops *confops = NULL;
 	int i, j;
 	bool found = false;
 
diff --git a/drivers/pinctrl/pinctrl-abx500.c b/drivers/pinctrl/pinctrl-abx500.c
index caecdd3..169d72c 100644
--- a/drivers/pinctrl/pinctrl-abx500.c
+++ b/drivers/pinctrl/pinctrl-abx500.c
@@ -656,7 +656,7 @@ static void abx500_gpio_disable_free(struct pinctrl_dev *pctldev,
 {
 }
 
-static struct pinmux_ops abx500_pinmux_ops = {
+static const struct pinmux_ops abx500_pinmux_ops = {
 	.get_functions_count = abx500_pmx_get_funcs_cnt,
 	.get_function_name = abx500_pmx_get_func_name,
 	.get_function_groups = abx500_pmx_get_func_groups,
@@ -704,7 +704,7 @@ static void abx500_pin_dbg_show(struct pinctrl_dev *pctldev,
 				 chip->base + offset - 1);
 }
 
-static struct pinctrl_ops abx500_pinctrl_ops = {
+static const struct pinctrl_ops abx500_pinctrl_ops = {
 	.get_groups_count = abx500_get_groups_cnt,
 	.get_group_name = abx500_get_group_name,
 	.get_group_pins = abx500_get_group_pins,
@@ -778,7 +778,7 @@ int abx500_pin_config_set(struct pinctrl_dev *pctldev,
 	return ret;
 }
 
-static struct pinconf_ops abx500_pinconf_ops = {
+static const struct pinconf_ops abx500_pinconf_ops = {
 	.pin_config_get = abx500_pin_config_get,
 	.pin_config_set = abx500_pin_config_set,
 };
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 471c71f..1cba6f7 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -294,7 +294,7 @@ static void at91_dt_free_map(struct pinctrl_dev *pctldev,
 {
 }
 
-static struct pinctrl_ops at91_pctrl_ops = {
+static const struct pinctrl_ops at91_pctrl_ops = {
 	.get_groups_count	= at91_get_groups_count,
 	.get_group_name		= at91_get_group_name,
 	.get_group_pins		= at91_get_group_pins,
@@ -696,7 +696,7 @@ static void at91_gpio_disable_free(struct pinctrl_dev *pctldev,
 	/* Set the pin to some default state, GPIO is usually default */
 }
 
-static struct pinmux_ops at91_pmx_ops = {
+static const struct pinmux_ops at91_pmx_ops = {
 	.get_functions_count	= at91_pmx_get_funcs_count,
 	.get_function_name	= at91_pmx_get_func_name,
 	.get_function_groups	= at91_pmx_get_groups,
@@ -776,7 +776,7 @@ static void at91_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
 {
 }
 
-static struct pinconf_ops at91_pinconf_ops = {
+static const struct pinconf_ops at91_pinconf_ops = {
 	.pin_config_get			= at91_pinconf_get,
 	.pin_config_set			= at91_pinconf_set,
 	.pin_config_dbg_show		= at91_pinconf_dbg_show,
diff --git a/drivers/pinctrl/pinctrl-bcm2835.c b/drivers/pinctrl/pinctrl-bcm2835.c
index d347b9f..f822db3 100644
--- a/drivers/pinctrl/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/pinctrl-bcm2835.c
@@ -795,7 +795,7 @@ out:
 	return err;
 }
 
-static struct pinctrl_ops bcm2835_pctl_ops = {
+static const struct pinctrl_ops bcm2835_pctl_ops = {
 	.get_groups_count = bcm2835_pctl_get_groups_count,
 	.get_group_name = bcm2835_pctl_get_group_name,
 	.get_group_pins = bcm2835_pctl_get_group_pins,
@@ -872,7 +872,7 @@ static int bcm2835_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
-static struct pinmux_ops bcm2835_pmx_ops = {
+static const struct pinmux_ops bcm2835_pmx_ops = {
 	.get_functions_count = bcm2835_pmx_get_functions_count,
 	.get_function_name = bcm2835_pmx_get_function_name,
 	.get_function_groups = bcm2835_pmx_get_function_groups,
@@ -916,7 +916,7 @@ static int bcm2835_pinconf_set(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
-static struct pinconf_ops bcm2835_pinconf_ops = {
+static const struct pinconf_ops bcm2835_pinconf_ops = {
 	.pin_config_get = bcm2835_pinconf_get,
 	.pin_config_set = bcm2835_pinconf_set,
 };
diff --git a/drivers/pinctrl/pinctrl-exynos5440.c b/drivers/pinctrl/pinctrl-exynos5440.c
index 1427299..cde7c56 100644
--- a/drivers/pinctrl/pinctrl-exynos5440.c
+++ b/drivers/pinctrl/pinctrl-exynos5440.c
@@ -286,7 +286,7 @@ static void exynos5440_dt_free_map(struct pinctrl_dev *pctldev,
 }
 
 /* list of pinctrl callbacks for the pinctrl core */
-static struct pinctrl_ops exynos5440_pctrl_ops = {
+static const struct pinctrl_ops exynos5440_pctrl_ops = {
 	.get_groups_count	= exynos5440_get_group_count,
 	.get_group_name		= exynos5440_get_group_name,
 	.get_group_pins		= exynos5440_get_group_pins,
@@ -374,7 +374,7 @@ static int exynos5440_pinmux_gpio_set_direction(struct pinctrl_dev *pctldev,
 }
 
 /* list of pinmux callbacks for the pinmux vertical in pinctrl core */
-static struct pinmux_ops exynos5440_pinmux_ops = {
+static const struct pinmux_ops exynos5440_pinmux_ops = {
 	.get_functions_count	= exynos5440_get_functions_count,
 	.get_function_name	= exynos5440_pinmux_get_fname,
 	.get_function_groups	= exynos5440_pinmux_get_groups,
@@ -523,7 +523,7 @@ static int exynos5440_pinconf_group_get(struct pinctrl_dev *pctldev,
 }
 
 /* list of pinconfig callbacks for pinconfig vertical in the pinctrl code */
-static struct pinconf_ops exynos5440_pinconf_ops = {
+static const struct pinconf_ops exynos5440_pinconf_ops = {
 	.pin_config_get		= exynos5440_pinconf_get,
 	.pin_config_set		= exynos5440_pinconf_set,
 	.pin_config_group_get	= exynos5440_pinconf_group_get,
diff --git a/drivers/pinctrl/pinctrl-falcon.c b/drivers/pinctrl/pinctrl-falcon.c
index 4a0d54a..67e4ea9 100644
--- a/drivers/pinctrl/pinctrl-falcon.c
+++ b/drivers/pinctrl/pinctrl-falcon.c
@@ -353,7 +353,7 @@ static void falcon_pinconf_group_dbg_show(struct pinctrl_dev *pctrldev,
 {
 }
 
-static struct pinconf_ops falcon_pinconf_ops = {
+static const struct pinconf_ops falcon_pinconf_ops = {
 	.pin_config_get			= falcon_pinconf_get,
 	.pin_config_set			= falcon_pinconf_set,
 	.pin_config_group_get		= falcon_pinconf_group_get,
diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
index 43a6f1f..2719563 100644
--- a/drivers/pinctrl/pinctrl-imx.c
+++ b/drivers/pinctrl/pinctrl-imx.c
@@ -207,7 +207,7 @@ static void imx_dt_free_map(struct pinctrl_dev *pctldev,
 	kfree(map);
 }
 
-static struct pinctrl_ops imx_pctrl_ops = {
+static const struct pinctrl_ops imx_pctrl_ops = {
 	.get_groups_count = imx_get_groups_count,
 	.get_group_name = imx_get_group_name,
 	.get_group_pins = imx_get_group_pins,
@@ -299,7 +299,7 @@ static int imx_pmx_get_groups(struct pinctrl_dev *pctldev, unsigned selector,
 	return 0;
 }
 
-static struct pinmux_ops imx_pmx_ops = {
+static const struct pinmux_ops imx_pmx_ops = {
 	.get_functions_count = imx_pmx_get_funcs_count,
 	.get_function_name = imx_pmx_get_func_name,
 	.get_function_groups = imx_pmx_get_groups,
@@ -397,7 +397,7 @@ static void imx_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
 	}
 }
 
-static struct pinconf_ops imx_pinconf_ops = {
+static const struct pinconf_ops imx_pinconf_ops = {
 	.pin_config_get = imx_pinconf_get,
 	.pin_config_set = imx_pinconf_set,
 	.pin_config_dbg_show = imx_pinconf_dbg_show,
diff --git a/drivers/pinctrl/pinctrl-lantiq.c b/drivers/pinctrl/pinctrl-lantiq.c
index a703846..615c500 100644
--- a/drivers/pinctrl/pinctrl-lantiq.c
+++ b/drivers/pinctrl/pinctrl-lantiq.c
@@ -169,7 +169,7 @@ static int ltq_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
-static struct pinctrl_ops ltq_pctrl_ops = {
+static const struct pinctrl_ops ltq_pctrl_ops = {
 	.get_groups_count	= ltq_get_group_count,
 	.get_group_name		= ltq_get_group_name,
 	.get_group_pins		= ltq_get_group_pins,
@@ -311,7 +311,7 @@ static int ltq_pmx_gpio_request_enable(struct pinctrl_dev *pctrldev,
 	return info->apply_mux(pctrldev, mfp, pin_func);
 }
 
-static struct pinmux_ops ltq_pmx_ops = {
+static const struct pinmux_ops ltq_pmx_ops = {
 	.get_functions_count	= ltq_pmx_func_count,
 	.get_function_name	= ltq_pmx_func_name,
 	.get_function_groups	= ltq_pmx_get_groups,
diff --git a/drivers/pinctrl/pinctrl-mxs.c b/drivers/pinctrl/pinctrl-mxs.c
index dd227d2..c164872 100644
--- a/drivers/pinctrl/pinctrl-mxs.c
+++ b/drivers/pinctrl/pinctrl-mxs.c
@@ -158,7 +158,7 @@ static void mxs_dt_free_map(struct pinctrl_dev *pctldev,
 	kfree(map);
 }
 
-static struct pinctrl_ops mxs_pinctrl_ops = {
+static const struct pinctrl_ops mxs_pinctrl_ops = {
 	.get_groups_count = mxs_get_groups_count,
 	.get_group_name = mxs_get_group_name,
 	.get_group_pins = mxs_get_group_pins,
@@ -219,7 +219,7 @@ static int mxs_pinctrl_enable(struct pinctrl_dev *pctldev, unsigned selector,
 	return 0;
 }
 
-static struct pinmux_ops mxs_pinmux_ops = {
+static const struct pinmux_ops mxs_pinmux_ops = {
 	.get_functions_count = mxs_pinctrl_get_funcs_count,
 	.get_function_name = mxs_pinctrl_get_func_name,
 	.get_function_groups = mxs_pinctrl_get_func_groups,
@@ -319,7 +319,7 @@ static void mxs_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
 		seq_printf(s, "0x%lx", config);
 }
 
-static struct pinconf_ops mxs_pinconf_ops = {
+static const struct pinconf_ops mxs_pinconf_ops = {
 	.pin_config_get = mxs_pinconf_get,
 	.pin_config_set = mxs_pinconf_set,
 	.pin_config_group_get = mxs_pinconf_group_get,
diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index b885c09..60c9ead 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -1764,7 +1764,7 @@ int nmk_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
-static struct pinctrl_ops nmk_pinctrl_ops = {
+static const struct pinctrl_ops nmk_pinctrl_ops = {
 	.get_groups_count = nmk_get_groups_cnt,
 	.get_group_name = nmk_get_group_name,
 	.get_group_pins = nmk_get_group_pins,
@@ -1975,7 +1975,7 @@ static void nmk_gpio_disable_free(struct pinctrl_dev *pctldev,
 	/* Set the pin to some default state, GPIO is usually default */
 }
 
-static struct pinmux_ops nmk_pinmux_ops = {
+static const struct pinmux_ops nmk_pinmux_ops = {
 	.get_functions_count = nmk_pmx_get_funcs_cnt,
 	.get_function_name = nmk_pmx_get_func_name,
 	.get_function_groups = nmk_pmx_get_func_groups,
@@ -2089,7 +2089,7 @@ static int nmk_pin_config_set(struct pinctrl_dev *pctldev, unsigned pin,
 	return 0;
 }
 
-static struct pinconf_ops nmk_pinconf_ops = {
+static const struct pinconf_ops nmk_pinconf_ops = {
 	.pin_config_get = nmk_pin_config_get,
 	.pin_config_set = nmk_pin_config_set,
 };
diff --git a/drivers/pinctrl/pinctrl-pxa3xx.c b/drivers/pinctrl/pinctrl-pxa3xx.c
index 51f8a38..3ff638b 100644
--- a/drivers/pinctrl/pinctrl-pxa3xx.c
+++ b/drivers/pinctrl/pinctrl-pxa3xx.c
@@ -52,7 +52,7 @@ static int pxa3xx_get_group_pins(struct pinctrl_dev *pctrldev,
 	return 0;
 }
 
-static struct pinctrl_ops pxa3xx_pctrl_ops = {
+static const struct pinctrl_ops pxa3xx_pctrl_ops = {
 	.get_groups_count = pxa3xx_get_groups_count,
 	.get_group_name	= pxa3xx_get_group_name,
 	.get_group_pins	= pxa3xx_get_group_pins,
@@ -160,7 +160,7 @@ static int pxa3xx_pmx_request_gpio(struct pinctrl_dev *pctrldev,
 	return 0;
 }
 
-static struct pinmux_ops pxa3xx_pmx_ops = {
+static const struct pinmux_ops pxa3xx_pmx_ops = {
 	.get_functions_count	= pxa3xx_pmx_get_funcs_count,
 	.get_function_name	= pxa3xx_pmx_get_func_name,
 	.get_function_groups	= pxa3xx_pmx_get_groups,
diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
index 5c20ed0..4402c57 100644
--- a/drivers/pinctrl/pinctrl-samsung.c
+++ b/drivers/pinctrl/pinctrl-samsung.c
@@ -214,7 +214,7 @@ static void samsung_dt_free_map(struct pinctrl_dev *pctldev,
 }
 
 /* list of pinctrl callbacks for the pinctrl core */
-static struct pinctrl_ops samsung_pctrl_ops = {
+static const struct pinctrl_ops samsung_pctrl_ops = {
 	.get_groups_count	= samsung_get_group_count,
 	.get_group_name		= samsung_get_group_name,
 	.get_group_pins		= samsung_get_group_pins,
@@ -357,7 +357,7 @@ static int samsung_pinmux_gpio_set_direction(struct pinctrl_dev *pctldev,
 }
 
 /* list of pinmux callbacks for the pinmux vertical in pinctrl core */
-static struct pinmux_ops samsung_pinmux_ops = {
+static const struct pinmux_ops samsung_pinmux_ops = {
 	.get_functions_count	= samsung_get_functions_count,
 	.get_function_name	= samsung_pinmux_get_fname,
 	.get_function_groups	= samsung_pinmux_get_groups,
@@ -468,7 +468,7 @@ static int samsung_pinconf_group_get(struct pinctrl_dev *pctldev,
 }
 
 /* list of pinconfig callbacks for pinconfig vertical in the pinctrl code */
-static struct pinconf_ops samsung_pinconf_ops = {
+static const struct pinconf_ops samsung_pinconf_ops = {
 	.pin_config_get		= samsung_pinconf_get,
 	.pin_config_set		= samsung_pinconf_set,
 	.pin_config_group_get	= samsung_pinconf_group_get,
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index f6a360b8..f4f31e3 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -281,7 +281,7 @@ static int pcs_dt_node_to_map(struct pinctrl_dev *pctldev,
 				struct device_node *np_config,
 				struct pinctrl_map **map, unsigned *num_maps);
 
-static struct pinctrl_ops pcs_pinctrl_ops = {
+static const struct pinctrl_ops pcs_pinctrl_ops = {
 	.get_groups_count = pcs_get_groups_count,
 	.get_group_name = pcs_get_group_name,
 	.get_group_pins = pcs_get_group_pins,
@@ -436,7 +436,7 @@ static int pcs_request_gpio(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
-static struct pinmux_ops pcs_pinmux_ops = {
+static const struct pinmux_ops pcs_pinmux_ops = {
 	.get_functions_count = pcs_get_functions_count,
 	.get_function_name = pcs_get_function_name,
 	.get_function_groups = pcs_get_function_groups,
@@ -479,7 +479,7 @@ static void pcs_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
 {
 }
 
-static struct pinconf_ops pcs_pinconf_ops = {
+static const struct pinconf_ops pcs_pinconf_ops = {
 	.pin_config_get = pcs_pinconf_get,
 	.pin_config_set = pcs_pinconf_set,
 	.pin_config_group_get = pcs_pinconf_group_get,
diff --git a/drivers/pinctrl/pinctrl-sirf.c b/drivers/pinctrl/pinctrl-sirf.c
index 498b2ba..c605f42 100644
--- a/drivers/pinctrl/pinctrl-sirf.c
+++ b/drivers/pinctrl/pinctrl-sirf.c
@@ -979,7 +979,7 @@ static void sirfsoc_dt_free_map(struct pinctrl_dev *pctldev,
 	kfree(map);
 }
 
-static struct pinctrl_ops sirfsoc_pctrl_ops = {
+static const struct pinctrl_ops sirfsoc_pctrl_ops = {
 	.get_groups_count = sirfsoc_get_groups_count,
 	.get_group_name = sirfsoc_get_group_name,
 	.get_group_pins = sirfsoc_get_group_pins,
@@ -1181,7 +1181,7 @@ static int sirfsoc_pinmux_request_gpio(struct pinctrl_dev *pmxdev,
 	return 0;
 }
 
-static struct pinmux_ops sirfsoc_pinmux_ops = {
+static const struct pinmux_ops sirfsoc_pinmux_ops = {
 	.enable = sirfsoc_pinmux_enable,
 	.disable = sirfsoc_pinmux_disable,
 	.get_functions_count = sirfsoc_pinmux_get_funcs_count,
diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
index 80b11e3..46b8f2d 100644
--- a/drivers/pinctrl/pinctrl-sunxi.c
+++ b/drivers/pinctrl/pinctrl-sunxi.c
@@ -1029,7 +1029,7 @@ static void sunxi_pctrl_dt_free_map(struct pinctrl_dev *pctldev,
 	kfree(map);
 }
 
-static struct pinctrl_ops sunxi_pctrl_ops = {
+static const struct pinctrl_ops sunxi_pctrl_ops = {
 	.dt_node_to_map		= sunxi_pctrl_dt_node_to_map,
 	.dt_free_map		= sunxi_pctrl_dt_free_map,
 	.get_groups_count	= sunxi_pctrl_get_groups_count,
@@ -1098,7 +1098,7 @@ static int sunxi_pconf_group_set(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
-static struct pinconf_ops sunxi_pconf_ops = {
+static const struct pinconf_ops sunxi_pconf_ops = {
 	.pin_config_group_get	= sunxi_pconf_group_get,
 	.pin_config_group_set	= sunxi_pconf_group_set,
 };
@@ -1204,7 +1204,7 @@ error:
 	return ret;
 }
 
-static struct pinmux_ops sunxi_pmx_ops = {
+static const struct pinmux_ops sunxi_pmx_ops = {
 	.get_functions_count	= sunxi_pmx_get_funcs_cnt,
 	.get_function_name	= sunxi_pmx_get_func_name,
 	.get_function_groups	= sunxi_pmx_get_func_groups,
diff --git a/drivers/pinctrl/pinctrl-tegra.c b/drivers/pinctrl/pinctrl-tegra.c
index f195d77..2fa9bc6 100644
--- a/drivers/pinctrl/pinctrl-tegra.c
+++ b/drivers/pinctrl/pinctrl-tegra.c
@@ -316,7 +316,7 @@ static int tegra_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
-static struct pinctrl_ops tegra_pinctrl_ops = {
+static const struct pinctrl_ops tegra_pinctrl_ops = {
 	.get_groups_count = tegra_pinctrl_get_groups_count,
 	.get_group_name = tegra_pinctrl_get_group_name,
 	.get_group_pins = tegra_pinctrl_get_group_pins,
@@ -401,7 +401,7 @@ static void tegra_pinctrl_disable(struct pinctrl_dev *pctldev,
 	pmx_writel(pmx, val, g->mux_bank, g->mux_reg);
 }
 
-static struct pinmux_ops tegra_pinmux_ops = {
+static const struct pinmux_ops tegra_pinmux_ops = {
 	.get_functions_count = tegra_pinctrl_get_funcs_count,
 	.get_function_name = tegra_pinctrl_get_func_name,
 	.get_function_groups = tegra_pinctrl_get_func_groups,
@@ -676,7 +676,7 @@ static void tegra_pinconf_config_dbg_show(struct pinctrl_dev *pctldev,
 }
 #endif
 
-static struct pinconf_ops tegra_pinconf_ops = {
+static const struct pinconf_ops tegra_pinconf_ops = {
 	.pin_config_get = tegra_pinconf_get,
 	.pin_config_set = tegra_pinconf_set,
 	.pin_config_group_get = tegra_pinconf_group_get,
diff --git a/drivers/pinctrl/pinctrl-u300.c b/drivers/pinctrl/pinctrl-u300.c
index 718ec57..844803e 100644
--- a/drivers/pinctrl/pinctrl-u300.c
+++ b/drivers/pinctrl/pinctrl-u300.c
@@ -860,7 +860,7 @@ static void u300_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
 	seq_printf(s, " " DRIVER_NAME);
 }
 
-static struct pinctrl_ops u300_pctrl_ops = {
+static const struct pinctrl_ops u300_pctrl_ops = {
 	.get_groups_count = u300_get_groups_count,
 	.get_group_name = u300_get_group_name,
 	.get_group_pins = u300_get_group_pins,
@@ -1003,7 +1003,7 @@ static int u300_pmx_get_groups(struct pinctrl_dev *pctldev, unsigned selector,
 	return 0;
 }
 
-static struct pinmux_ops u300_pmx_ops = {
+static const struct pinmux_ops u300_pmx_ops = {
 	.get_functions_count = u300_pmx_get_funcs_count,
 	.get_function_name = u300_pmx_get_func_name,
 	.get_function_groups = u300_pmx_get_groups,
@@ -1046,7 +1046,7 @@ static int u300_pin_config_set(struct pinctrl_dev *pctldev, unsigned pin,
 	return 0;
 }
 
-static struct pinconf_ops u300_pconf_ops = {
+static const struct pinconf_ops u300_pconf_ops = {
 	.is_generic = true,
 	.pin_config_get = u300_pin_config_get,
 	.pin_config_set = u300_pin_config_set,
diff --git a/drivers/pinctrl/pinctrl-xway.c b/drivers/pinctrl/pinctrl-xway.c
index 53cb6a3..718a263 100644
--- a/drivers/pinctrl/pinctrl-xway.c
+++ b/drivers/pinctrl/pinctrl-xway.c
@@ -552,7 +552,7 @@ int xway_pinconf_group_set(struct pinctrl_dev *pctldev,
 	return ret;
 }
 
-static struct pinconf_ops xway_pinconf_ops = {
+static const struct pinconf_ops xway_pinconf_ops = {
 	.pin_config_get	= xway_pinconf_get,
 	.pin_config_set	= xway_pinconf_set,
 	.pin_config_group_set = xway_pinconf_group_set,
diff --git a/drivers/pinctrl/spear/pinctrl-spear.c b/drivers/pinctrl/spear/pinctrl-spear.c
index 6a7dae7..116da04 100644
--- a/drivers/pinctrl/spear/pinctrl-spear.c
+++ b/drivers/pinctrl/spear/pinctrl-spear.c
@@ -198,7 +198,7 @@ static void spear_pinctrl_dt_free_map(struct pinctrl_dev *pctldev,
 	kfree(map);
 }
 
-static struct pinctrl_ops spear_pinctrl_ops = {
+static const struct pinctrl_ops spear_pinctrl_ops = {
 	.get_groups_count = spear_pinctrl_get_groups_cnt,
 	.get_group_name = spear_pinctrl_get_group_name,
 	.get_group_pins = spear_pinctrl_get_group_pins,
@@ -340,7 +340,7 @@ static void gpio_disable_free(struct pinctrl_dev *pctldev,
 	gpio_request_endisable(pctldev, range, offset, false);
 }
 
-static struct pinmux_ops spear_pinmux_ops = {
+static const struct pinmux_ops spear_pinmux_ops = {
 	.get_functions_count = spear_pinctrl_get_funcs_count,
 	.get_function_name = spear_pinctrl_get_func_name,
 	.get_function_groups = spear_pinctrl_get_func_groups,
diff --git a/include/linux/pinctrl/pinctrl.h b/include/linux/pinctrl/pinctrl.h
index 778804d..2c2a9e8 100644
--- a/include/linux/pinctrl/pinctrl.h
+++ b/include/linux/pinctrl/pinctrl.h
@@ -118,9 +118,9 @@ struct pinctrl_desc {
 	const char *name;
 	struct pinctrl_pin_desc const *pins;
 	unsigned int npins;
-	struct pinctrl_ops *pctlops;
-	struct pinmux_ops *pmxops;
-	struct pinconf_ops *confops;
+	const struct pinctrl_ops *pctlops;
+	const struct pinmux_ops *pmxops;
+	const struct pinconf_ops *confops;
 	struct module *owner;
 };
 
-- 
Regards,

Laurent Pinchart
