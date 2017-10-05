From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Oct 2017 22:54:06 +0200
Subject: [PATCH 1/3] pinctrl: sunxi: Introduce the strict flag
In-Reply-To: <cover.7a61d0bb31530def29efd8b4286d8c0afdaab347.1507236823.git-series.maxime.ripard@free-electrons.com>
References: <cover.7a61d0bb31530def29efd8b4286d8c0afdaab347.1507236823.git-series.maxime.ripard@free-electrons.com>
Message-ID: <d05b00e25ec1c466bb5852b0ce06b3e67d93f9a7.1507236823.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our pinctrl device should have had strict set all along. However, it wasn't
the case, and most of our old device trees also have a pinctrl group in
addition to the GPIOs properties, which mean that we can't really turn it
on now.

All our new SoCs don't have that group, so we should still enable that mode
on the newer one though.

In order to enable it by default, add a flag that will allow to disable
that mode that should be set by pinctrl drivers that cannot be migrated.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 5 ++++-
 drivers/pinctrl/sunxi/pinctrl-sunxi.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 52edf3b5988d..1753a5b1573f 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -690,7 +690,7 @@ sunxi_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
-static const struct pinmux_ops sunxi_pmx_ops = {
+static struct pinmux_ops sunxi_pmx_ops = {
 	.get_functions_count	= sunxi_pmx_get_funcs_cnt,
 	.get_function_name	= sunxi_pmx_get_func_name,
 	.get_function_groups	= sunxi_pmx_get_func_groups,
@@ -1307,6 +1307,9 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 	pctrl_desc->pctlops = &sunxi_pctrl_ops;
 	pctrl_desc->pmxops =  &sunxi_pmx_ops;
 
+	if (desc->disable_strict_mode)
+		sunxi_pmx_ops.strict = false;
+
 	pctl->pctl_dev = devm_pinctrl_register(&pdev->dev, pctrl_desc, pctl);
 	if (IS_ERR(pctl->pctl_dev)) {
 		dev_err(&pdev->dev, "couldn't register pinctrl driver\n");
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index 1bfc0d8a55df..11b128f54ed2 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -112,6 +112,7 @@ struct sunxi_pinctrl_desc {
 	unsigned			irq_banks;
 	unsigned			irq_bank_base;
 	bool				irq_read_needs_mux;
+	bool				disable_strict_mode;
 };
 
 struct sunxi_pinctrl_function {
-- 
git-series 0.9.1
