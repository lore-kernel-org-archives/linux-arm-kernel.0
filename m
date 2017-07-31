From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 31 Jul 2017 15:21:10 +0900
Subject: [PATCH 5/6] pinctrl: uniphier: add suspend / resume support
In-Reply-To: <1501482071-9819-1-git-send-email-yamada.masahiro@socionext.com>
References: <1501482071-9819-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1501482071-9819-6-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Save registers lost in the sleep when suspending, and restore them
when resuming.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 178 +++++++++++++++++++++++
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c |   1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c |   1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c  |   1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c |   1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c |   1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c |   1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c |   1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c |   1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier.h      |   2 +
 10 files changed, 188 insertions(+)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
index b976e9109b1d..5d8c9efd8135 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
@@ -13,6 +13,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/list.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/pinctrl/pinconf.h>
@@ -34,11 +35,19 @@
 #define UNIPHIER_PINCTRL_PUPDCTRL_BASE	0x1a00
 #define UNIPHIER_PINCTRL_IECTRL_BASE	0x1d00
 
+struct uniphier_pinctrl_reg_region {
+	struct list_head node;
+	unsigned int base;
+	unsigned int nregs;
+	u32 vals[0];
+};
+
 struct uniphier_pinctrl_priv {
 	struct pinctrl_desc pctldesc;
 	struct pinctrl_dev *pctldev;
 	struct regmap *regmap;
 	struct uniphier_pinctrl_socdata *socdata;
+	struct list_head reg_regions;
 };
 
 static int uniphier_pctl_get_groups_count(struct pinctrl_dev *pctldev)
@@ -688,12 +697,177 @@ static const struct pinmux_ops uniphier_pmxops = {
 	.strict = true,
 };
 
+#ifdef CONFIG_PM_SLEEP
+static int uniphier_pinctrl_suspend(struct device *dev)
+{
+	struct uniphier_pinctrl_priv *priv = dev_get_drvdata(dev);
+	struct uniphier_pinctrl_reg_region *r;
+	int ret;
+
+	list_for_each_entry(r, &priv->reg_regions, node) {
+		ret = regmap_bulk_read(priv->regmap, r->base, r->vals,
+				       r->nregs);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int uniphier_pinctrl_resume(struct device *dev)
+{
+	struct uniphier_pinctrl_priv *priv = dev_get_drvdata(dev);
+	struct uniphier_pinctrl_reg_region *r;
+	int ret;
+
+	list_for_each_entry(r, &priv->reg_regions, node) {
+		ret = regmap_bulk_write(priv->regmap, r->base, r->vals,
+					r->nregs);
+		if (ret)
+			return ret;
+	}
+
+	if (priv->socdata->caps & UNIPHIER_PINCTRL_CAPS_DBGMUX_SEPARATE) {
+		ret = regmap_write(priv->regmap,
+				   UNIPHIER_PINCTRL_LOAD_PINMUX, 1);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int uniphier_pinctrl_add_reg_region(struct device *dev,
+					   struct uniphier_pinctrl_priv *priv,
+					   unsigned int base,
+					   unsigned int count,
+					   unsigned int width)
+{
+	struct uniphier_pinctrl_reg_region *region;
+	unsigned int nregs;
+
+	if (!count)
+		return 0;
+
+	nregs = DIV_ROUND_UP(count * width, 32);
+
+	region = devm_kzalloc(dev,
+			      sizeof(*region) + sizeof(region->vals[0]) * nregs,
+			      GFP_KERNEL);
+	if (!region)
+		return -ENOMEM;
+
+	region->base = base;
+	region->nregs = nregs;
+
+	list_add_tail(&region->node, &priv->reg_regions);
+
+	return 0;
+}
+#endif
+
+static int uniphier_pinctrl_pm_init(struct device *dev,
+				    struct uniphier_pinctrl_priv *priv)
+{
+#ifdef CONFIG_PM_SLEEP
+	const struct uniphier_pinctrl_socdata *socdata = priv->socdata;
+	unsigned int num_drvctrl = 0;
+	unsigned int num_drv2ctrl = 0;
+	unsigned int num_drv3ctrl = 0;
+	unsigned int num_pupdctrl = 0;
+	unsigned int num_iectrl = 0;
+	unsigned int iectrl, drvctrl, pupdctrl;
+	enum uniphier_pin_drv_type drv_type;
+	enum uniphier_pin_pull_dir pull_dir;
+	int i, ret;
+
+	for (i = 0; i < socdata->npins; i++) {
+		void *drv_data = socdata->pins[i].drv_data;
+
+		drvctrl = uniphier_pin_get_drvctrl(drv_data);
+		drv_type = uniphier_pin_get_drv_type(drv_data);
+		pupdctrl = uniphier_pin_get_pupdctrl(drv_data);
+		pull_dir = uniphier_pin_get_pull_dir(drv_data);
+		iectrl = uniphier_pin_get_iectrl(drv_data);
+
+		switch (drv_type) {
+		case UNIPHIER_PIN_DRV_1BIT:
+			num_drvctrl = max(num_drvctrl, drvctrl + 1);
+			break;
+		case UNIPHIER_PIN_DRV_2BIT:
+			num_drv2ctrl = max(num_drv2ctrl, drvctrl + 1);
+			break;
+		case UNIPHIER_PIN_DRV_3BIT:
+			num_drv3ctrl = max(num_drv3ctrl, drvctrl + 1);
+			break;
+		default:
+			break;
+		}
+
+		if (pull_dir == UNIPHIER_PIN_PULL_UP ||
+		    pull_dir == UNIPHIER_PIN_PULL_DOWN)
+			num_pupdctrl = max(num_pupdctrl, pupdctrl + 1);
+
+		if (iectrl != UNIPHIER_PIN_IECTRL_NONE) {
+			if (socdata->caps & UNIPHIER_PINCTRL_CAPS_PERPIN_IECTRL)
+				iectrl = i;
+			num_iectrl = max(num_iectrl, iectrl + 1);
+		}
+	}
+
+	INIT_LIST_HEAD(&priv->reg_regions);
+
+	ret = uniphier_pinctrl_add_reg_region(dev, priv,
+					      UNIPHIER_PINCTRL_PINMUX_BASE,
+					      socdata->npins, 8);
+	if (ret)
+		return ret;
+
+	ret = uniphier_pinctrl_add_reg_region(dev, priv,
+					      UNIPHIER_PINCTRL_DRVCTRL_BASE,
+					      num_drvctrl, 1);
+	if (ret)
+		return ret;
+
+	ret = uniphier_pinctrl_add_reg_region(dev, priv,
+					      UNIPHIER_PINCTRL_DRV2CTRL_BASE,
+					      num_drv2ctrl, 2);
+	if (ret)
+		return ret;
+
+	ret = uniphier_pinctrl_add_reg_region(dev, priv,
+					      UNIPHIER_PINCTRL_DRV3CTRL_BASE,
+					      num_drv3ctrl, 3);
+	if (ret)
+		return ret;
+
+	ret = uniphier_pinctrl_add_reg_region(dev, priv,
+					      UNIPHIER_PINCTRL_PUPDCTRL_BASE,
+					      num_pupdctrl, 1);
+	if (ret)
+		return ret;
+
+	ret = uniphier_pinctrl_add_reg_region(dev, priv,
+					      UNIPHIER_PINCTRL_IECTRL_BASE,
+					      num_iectrl, 1);
+	if (ret)
+		return ret;
+#endif
+	return 0;
+}
+
+const struct dev_pm_ops uniphier_pinctrl_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(uniphier_pinctrl_suspend,
+				     uniphier_pinctrl_resume)
+};
+
 int uniphier_pinctrl_probe(struct platform_device *pdev,
 			   struct uniphier_pinctrl_socdata *socdata)
 {
 	struct device *dev = &pdev->dev;
 	struct uniphier_pinctrl_priv *priv;
 	struct device_node *parent;
+	int ret;
 
 	if (!socdata ||
 	    !socdata->pins || !socdata->npins ||
@@ -725,6 +899,10 @@ int uniphier_pinctrl_probe(struct platform_device *pdev,
 	priv->pctldesc.confops = &uniphier_confops;
 	priv->pctldesc.owner = dev->driver->owner;
 
+	ret = uniphier_pinctrl_pm_init(dev, priv);
+	if (ret)
+		return ret;
+
 	priv->pctldev = devm_pinctrl_register(dev, &priv->pctldesc, priv);
 	if (IS_ERR(priv->pctldev)) {
 		dev_err(dev, "failed to register UniPhier pinctrl driver\n");
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
index be08de07146e..745706920642 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
@@ -643,6 +643,7 @@ static struct platform_driver uniphier_ld11_pinctrl_driver = {
 	.driver = {
 		.name = "uniphier-ld11-pinctrl",
 		.of_match_table = uniphier_ld11_pinctrl_match,
+		.pm = &uniphier_pinctrl_pm_ops,
 	},
 };
 builtin_platform_driver(uniphier_ld11_pinctrl_driver);
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
index e5bc7c36c1e4..82f754cd85d9 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
@@ -733,6 +733,7 @@ static struct platform_driver uniphier_ld20_pinctrl_driver = {
 	.driver = {
 		.name = "uniphier-ld20-pinctrl",
 		.of_match_table = uniphier_ld20_pinctrl_match,
+		.pm = &uniphier_pinctrl_pm_ops,
 	},
 };
 builtin_platform_driver(uniphier_ld20_pinctrl_driver);
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
index 7db3fd0f72e5..840382847212 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
@@ -740,6 +740,7 @@ static struct platform_driver uniphier_ld4_pinctrl_driver = {
 	.driver = {
 		.name = "uniphier-ld4-pinctrl",
 		.of_match_table = uniphier_ld4_pinctrl_match,
+		.pm = &uniphier_pinctrl_pm_ops,
 	},
 };
 builtin_platform_driver(uniphier_ld4_pinctrl_driver);
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
index 2d8dc0f0b907..493a90c6d733 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
@@ -950,6 +950,7 @@ static struct platform_driver uniphier_ld6b_pinctrl_driver = {
 	.driver = {
 		.name = "uniphier-ld6b-pinctrl",
 		.of_match_table = uniphier_ld6b_pinctrl_match,
+		.pm = &uniphier_pinctrl_pm_ops,
 	},
 };
 builtin_platform_driver(uniphier_ld6b_pinctrl_driver);
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
index 1c95a4689eda..24d358290a0c 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
@@ -1245,6 +1245,7 @@ static struct platform_driver uniphier_pro4_pinctrl_driver = {
 	.driver = {
 		.name = "uniphier-pro4-pinctrl",
 		.of_match_table = uniphier_pro4_pinctrl_match,
+		.pm = &uniphier_pinctrl_pm_ops,
 	},
 };
 builtin_platform_driver(uniphier_pro4_pinctrl_driver);
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
index d0d730b2e71e..9381a4ff4389 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
@@ -1003,6 +1003,7 @@ static struct platform_driver uniphier_pro5_pinctrl_driver = {
 	.driver = {
 		.name = "uniphier-pro5-pinctrl",
 		.of_match_table = uniphier_pro5_pinctrl_match,
+		.pm = &uniphier_pinctrl_pm_ops,
 	},
 };
 builtin_platform_driver(uniphier_pro5_pinctrl_driver);
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
index e323c3e19a41..c0ef40ae99a7 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
@@ -937,6 +937,7 @@ static struct platform_driver uniphier_pxs2_pinctrl_driver = {
 	.driver = {
 		.name = "uniphier-pxs2-pinctrl",
 		.of_match_table = uniphier_pxs2_pinctrl_match,
+		.pm = &uniphier_pinctrl_pm_ops,
 	},
 };
 builtin_platform_driver(uniphier_pxs2_pinctrl_driver);
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
index f0221e93aa25..1af430d701be 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
@@ -669,6 +669,7 @@ static struct platform_driver uniphier_sld8_pinctrl_driver = {
 	.driver = {
 		.name = "uniphier-sld8-pinctrl",
 		.of_match_table = uniphier_sld8_pinctrl_match,
+		.pm = &uniphier_pinctrl_pm_ops,
 	},
 };
 builtin_platform_driver(uniphier_sld8_pinctrl_driver);
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier.h b/drivers/pinctrl/uniphier/pinctrl-uniphier.h
index 24e48e3ed048..c075ecb8e5db 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier.h
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier.h
@@ -192,4 +192,6 @@ struct uniphier_pinctrl_socdata {
 int uniphier_pinctrl_probe(struct platform_device *pdev,
 			   struct uniphier_pinctrl_socdata *socdata);
 
+extern const struct dev_pm_ops uniphier_pinctrl_pm_ops;
+
 #endif /* __PINCTRL_UNIPHIER_H__ */
-- 
2.7.4
