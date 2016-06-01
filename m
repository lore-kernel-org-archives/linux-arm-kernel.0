From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:04 -0700
Subject: [PATCH 05/34] clk: bcm: iproc: Migrate to clk_hw based registration
 and OF APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-6-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Ray Jui <rjui@broadcom.com>
Cc: Jon Mason <jonmason@broadcom.com>
Cc: Simran Rai <ssimran@broadcom.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/bcm/clk-iproc-armpll.c |  9 ++++-----
 drivers/clk/bcm/clk-iproc-asiu.c   | 27 +++++++++++++--------------
 drivers/clk/bcm/clk-iproc-pll.c    | 32 ++++++++++++++++----------------
 3 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/bcm/clk-iproc-armpll.c b/drivers/clk/bcm/clk-iproc-armpll.c
index a196ee28a17a..2924abc4470f 100644
--- a/drivers/clk/bcm/clk-iproc-armpll.c
+++ b/drivers/clk/bcm/clk-iproc-armpll.c
@@ -242,7 +242,6 @@ static const struct clk_ops iproc_arm_pll_ops = {
 void __init iproc_armpll_setup(struct device_node *node)
 {
 	int ret;
-	struct clk *clk;
 	struct iproc_arm_pll *pll;
 	struct clk_init_data init;
 	const char *parent_name;
@@ -263,18 +262,18 @@ void __init iproc_armpll_setup(struct device_node *node)
 	init.num_parents = (parent_name ? 1 : 0);
 	pll->hw.init = &init;
 
-	clk = clk_register(NULL, &pll->hw);
-	if (WARN_ON(IS_ERR(clk)))
+	ret = clk_hw_register(NULL, &pll->hw);
+	if (WARN_ON(ret))
 		goto err_iounmap;
 
-	ret = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	ret = of_clk_add_hw_provider(node, of_clk_hw_simple_get, &pll->hw);
 	if (WARN_ON(ret))
 		goto err_clk_unregister;
 
 	return;
 
 err_clk_unregister:
-	clk_unregister(clk);
+	clk_hw_unregister(&pll->hw);
 err_iounmap:
 	iounmap(pll->base);
 err_free_pll:
diff --git a/drivers/clk/bcm/clk-iproc-asiu.c b/drivers/clk/bcm/clk-iproc-asiu.c
index f630e1bbdcfe..4360e481368b 100644
--- a/drivers/clk/bcm/clk-iproc-asiu.c
+++ b/drivers/clk/bcm/clk-iproc-asiu.c
@@ -37,7 +37,7 @@ struct iproc_asiu {
 	void __iomem *div_base;
 	void __iomem *gate_base;
 
-	struct clk_onecell_data clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct iproc_asiu_clk *clks;
 };
 
@@ -197,11 +197,11 @@ void __init iproc_asiu_setup(struct device_node *node,
 	if (WARN_ON(!asiu))
 		return;
 
-	asiu->clk_data.clk_num = num_clks;
-	asiu->clk_data.clks = kcalloc(num_clks, sizeof(*asiu->clk_data.clks),
-				      GFP_KERNEL);
-	if (WARN_ON(!asiu->clk_data.clks))
+	asiu->clk_data = kzalloc(sizeof(*asiu->clk_data->hws) * num_clks +
+				 sizeof(*asiu->clk_data), GFP_KERNEL);
+	if (WARN_ON(!asiu->clk_data))
 		goto err_clks;
+	asiu->clk_data->num = num_clks;
 
 	asiu->clks = kcalloc(num_clks, sizeof(*asiu->clks), GFP_KERNEL);
 	if (WARN_ON(!asiu->clks))
@@ -217,7 +217,6 @@ void __init iproc_asiu_setup(struct device_node *node,
 
 	for (i = 0; i < num_clks; i++) {
 		struct clk_init_data init;
-		struct clk *clk;
 		const char *parent_name;
 		struct iproc_asiu_clk *asiu_clk;
 		const char *clk_name;
@@ -240,22 +239,22 @@ void __init iproc_asiu_setup(struct device_node *node,
 		init.num_parents = (parent_name ? 1 : 0);
 		asiu_clk->hw.init = &init;
 
-		clk = clk_register(NULL, &asiu_clk->hw);
-		if (WARN_ON(IS_ERR(clk)))
+		ret = clk_hw_register(NULL, &asiu_clk->hw);
+		if (WARN_ON(ret))
 			goto err_clk_register;
-		asiu->clk_data.clks[i] = clk;
+		asiu->clk_data->hws[i] = &asiu_clk->hw;
 	}
 
-	ret = of_clk_add_provider(node, of_clk_src_onecell_get,
-				  &asiu->clk_data);
+	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
+				     asiu->clk_data);
 	if (WARN_ON(ret))
 		goto err_clk_register;
 
 	return;
 
 err_clk_register:
-	for (i = 0; i < num_clks; i++)
-		clk_unregister(asiu->clk_data.clks[i]);
+	while (--i >= 0)
+		clk_hw_unregister(asiu->clk_data->hws[i]);
 	iounmap(asiu->gate_base);
 
 err_iomap_gate:
@@ -265,7 +264,7 @@ err_iomap_div:
 	kfree(asiu->clks);
 
 err_asiu_clks:
-	kfree(asiu->clk_data.clks);
+	kfree(asiu->clk_data);
 
 err_clks:
 	kfree(asiu);
diff --git a/drivers/clk/bcm/clk-iproc-pll.c b/drivers/clk/bcm/clk-iproc-pll.c
index fd492a5dad12..e04634c46395 100644
--- a/drivers/clk/bcm/clk-iproc-pll.c
+++ b/drivers/clk/bcm/clk-iproc-pll.c
@@ -89,7 +89,7 @@ struct iproc_pll {
 	const struct iproc_pll_vco_param *vco_param;
 	unsigned int num_vco_entries;
 
-	struct clk_onecell_data clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct iproc_clk *clks;
 };
 
@@ -625,7 +625,6 @@ void __init iproc_pll_clk_setup(struct device_node *node,
 				unsigned int num_clks)
 {
 	int i, ret;
-	struct clk *clk;
 	struct iproc_pll *pll;
 	struct iproc_clk *iclk;
 	struct clk_init_data init;
@@ -638,11 +637,11 @@ void __init iproc_pll_clk_setup(struct device_node *node,
 	if (WARN_ON(!pll))
 		return;
 
-	pll->clk_data.clk_num = num_clks;
-	pll->clk_data.clks = kcalloc(num_clks, sizeof(*pll->clk_data.clks),
-				     GFP_KERNEL);
-	if (WARN_ON(!pll->clk_data.clks))
+	pll->clk_data = kzalloc(sizeof(*pll->clk_data->hws) * num_clks +
+				sizeof(*pll->clk_data), GFP_KERNEL);
+	if (WARN_ON(!pll->clk_data))
 		goto err_clk_data;
+	pll->clk_data->num = num_clks;
 
 	pll->clks = kcalloc(num_clks, sizeof(*pll->clks), GFP_KERNEL);
 	if (WARN_ON(!pll->clks))
@@ -694,11 +693,11 @@ void __init iproc_pll_clk_setup(struct device_node *node,
 
 	iproc_pll_sw_cfg(pll);
 
-	clk = clk_register(NULL, &iclk->hw);
-	if (WARN_ON(IS_ERR(clk)))
+	ret = clk_hw_register(NULL, &iclk->hw);
+	if (WARN_ON(ret))
 		goto err_pll_register;
 
-	pll->clk_data.clks[0] = clk;
+	pll->clk_data->hws[0] = &iclk->hw;
 
 	/* now initialize and register all leaf clocks */
 	for (i = 1; i < num_clks; i++) {
@@ -724,22 +723,23 @@ void __init iproc_pll_clk_setup(struct device_node *node,
 		init.num_parents = (parent_name ? 1 : 0);
 		iclk->hw.init = &init;
 
-		clk = clk_register(NULL, &iclk->hw);
-		if (WARN_ON(IS_ERR(clk)))
+		ret = clk_hw_register(NULL, &iclk->hw);
+		if (WARN_ON(ret))
 			goto err_clk_register;
 
-		pll->clk_data.clks[i] = clk;
+		pll->clk_data->hws[i] = &iclk->hw;
 	}
 
-	ret = of_clk_add_provider(node, of_clk_src_onecell_get, &pll->clk_data);
+	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
+				     pll->clk_data);
 	if (WARN_ON(ret))
 		goto err_clk_register;
 
 	return;
 
 err_clk_register:
-	for (i = 0; i < num_clks; i++)
-		clk_unregister(pll->clk_data.clks[i]);
+	while (--i >= 0)
+		clk_hw_unregister(pll->clk_data->hws[i]);
 
 err_pll_register:
 	if (pll->status_base != pll->control_base)
@@ -759,7 +759,7 @@ err_pll_iomap:
 	kfree(pll->clks);
 
 err_clks:
-	kfree(pll->clk_data.clks);
+	kfree(pll->clk_data);
 
 err_clk_data:
 	kfree(pll);
-- 
2.7.4
