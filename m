From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  9 Oct 2017 22:53:37 +0200
Subject: [PATCH v2 1/3] pinctrl: sunxi: Introduce the strict flag
In-Reply-To: <cover.3e8ef5cb08d0164375d7644df0548e5f39b0fe66.1507582414.git-series.maxime.ripard@free-electrons.com>
References: <cover.3e8ef5cb08d0164375d7644df0548e5f39b0fe66.1507582414.git-series.maxime.ripard@free-electrons.com>
Message-ID: <c764ce12c83daefabaaea6a2df293c68f078c5e2.1507582414.git-series.maxime.ripard@free-electrons.com>
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
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 12 +++++++++++-
 drivers/pinctrl/sunxi/pinctrl-sunxi.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 52edf3b5988d..3bbb34435e0f 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -1245,6 +1245,7 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 	struct pinctrl_desc *pctrl_desc;
 	struct pinctrl_pin_desc *pins;
 	struct sunxi_pinctrl *pctl;
+	struct pinmux_ops *pmxops;
 	struct resource *res;
 	int i, ret, last_pin, pin_idx;
 	struct clk *clk;
@@ -1305,7 +1306,16 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 	pctrl_desc->npins = pctl->ngroups;
 	pctrl_desc->confops = &sunxi_pconf_ops;
 	pctrl_desc->pctlops = &sunxi_pctrl_ops;
-	pctrl_desc->pmxops =  &sunxi_pmx_ops;
+
+	pmxops = devm_kmemdup(&pdev->dev, &sunxi_pmx_ops, sizeof(sunxi_pmx_ops),
+			      GFP_KERNEL);
+	if (!pmxops)
+		return -ENOMEM;
+
+	if (desc->disable_strict_mode)
+		pmxops->strict = false;
+
+	pctrl_desc->pmxops = pmxops;
 
 	pctl->pctl_dev = devm_pinctrl_register(&pdev->dev, pctrl_desc, pctl);
 	if (IS_ERR(pctl->pctl_dev)) {
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
