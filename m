From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:03 -0700
Subject: [PATCH 04/34] clk: bcm2835: Migrate to clk_hw based registration and
 OF APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-5-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Eric Anholt <eric@anholt.net>
Cc: Martin Sperl <kernel@martin.sperl.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/bcm/clk-bcm2835-aux.c | 28 ++++++-------
 drivers/clk/bcm/clk-bcm2835.c     | 83 +++++++++++++++++++++------------------
 2 files changed, 57 insertions(+), 54 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835-aux.c b/drivers/clk/bcm/clk-bcm2835-aux.c
index 3a177ade6e6c..bd750cf2238d 100644
--- a/drivers/clk/bcm/clk-bcm2835-aux.c
+++ b/drivers/clk/bcm/clk-bcm2835-aux.c
@@ -25,7 +25,7 @@
 static int bcm2835_aux_clk_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct clk_onecell_data *onecell;
+	struct clk_hw_onecell_data *onecell;
 	const char *parent;
 	struct clk *parent_clk;
 	struct resource *res;
@@ -41,28 +41,24 @@ static int bcm2835_aux_clk_probe(struct platform_device *pdev)
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
 
-	onecell = devm_kmalloc(dev, sizeof(*onecell), GFP_KERNEL);
+	onecell = devm_kmalloc(dev, sizeof(*onecell) + sizeof(*onecell->hws) *
+			       BCM2835_AUX_CLOCK_COUNT, GFP_KERNEL);
 	if (!onecell)
 		return -ENOMEM;
-	onecell->clk_num = BCM2835_AUX_CLOCK_COUNT;
-	onecell->clks = devm_kcalloc(dev, BCM2835_AUX_CLOCK_COUNT,
-				     sizeof(*onecell->clks), GFP_KERNEL);
-	if (!onecell->clks)
-		return -ENOMEM;
+	onecell->num = BCM2835_AUX_CLOCK_COUNT;
 
 	gate = reg + BCM2835_AUXENB;
-	onecell->clks[BCM2835_AUX_CLOCK_UART] =
-		clk_register_gate(dev, "aux_uart", parent, 0, gate, 0, 0, NULL);
-
-	onecell->clks[BCM2835_AUX_CLOCK_SPI1] =
-		clk_register_gate(dev, "aux_spi1", parent, 0, gate, 1, 0, NULL);
+	onecell->hws[BCM2835_AUX_CLOCK_UART] =
+		clk_hw_register_gate(dev, "aux_uart", parent, 0, gate, 0, 0, NULL);
 
-	onecell->clks[BCM2835_AUX_CLOCK_SPI2] =
-		clk_register_gate(dev, "aux_spi2", parent, 0, gate, 2, 0, NULL);
+	onecell->hws[BCM2835_AUX_CLOCK_SPI1] =
+		clk_hw_register_gate(dev, "aux_spi1", parent, 0, gate, 1, 0, NULL);
 
-	of_clk_add_provider(pdev->dev.of_node, of_clk_src_onecell_get, onecell);
+	onecell->hws[BCM2835_AUX_CLOCK_SPI2] =
+		clk_hw_register_gate(dev, "aux_spi2", parent, 0, gate, 2, 0, NULL);
 
-	return 0;
+	return of_clk_add_hw_provider(pdev->dev.of_node, of_clk_hw_onecell_get,
+				      onecell);
 }
 
 static const struct of_device_id bcm2835_aux_clk_of_match[] = {
diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 7a7970865c2d..0131b922d3c5 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -302,8 +302,8 @@ struct bcm2835_cprman {
 	spinlock_t regs_lock; /* spinlock for all clocks */
 	const char *osc_name;
 
-	struct clk_onecell_data onecell;
-	struct clk *clks[];
+	/* Must be last */
+	struct clk_hw_onecell_data onecell;
 };
 
 static inline void cprman_write(struct bcm2835_cprman *cprman, u32 reg, u32 val)
@@ -344,24 +344,24 @@ static int bcm2835_debugfs_regset(struct bcm2835_cprman *cprman, u32 base,
  */
 void __init bcm2835_init_clocks(void)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	int ret;
 
-	clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, 0, 126000000);
-	if (IS_ERR(clk))
+	hw = clk_hw_register_fixed_rate(NULL, "apb_pclk", NULL, 0, 126000000);
+	if (IS_ERR(hw))
 		pr_err("apb_pclk not registered\n");
 
-	clk = clk_register_fixed_rate(NULL, "uart0_pclk", NULL, 0, 3000000);
-	if (IS_ERR(clk))
+	hw = clk_hw_register_fixed_rate(NULL, "uart0_pclk", NULL, 0, 3000000);
+	if (IS_ERR(hw))
 		pr_err("uart0_pclk not registered\n");
-	ret = clk_register_clkdev(clk, NULL, "20201000.uart");
+	ret = clk_hw_register_clkdev(hw, NULL, "20201000.uart");
 	if (ret)
 		pr_err("uart0_pclk alias not registered\n");
 
-	clk = clk_register_fixed_rate(NULL, "uart1_pclk", NULL, 0, 125000000);
-	if (IS_ERR(clk))
+	hw = clk_hw_register_fixed_rate(NULL, "uart1_pclk", NULL, 0, 125000000);
+	if (IS_ERR(hw))
 		pr_err("uart1_pclk not registered\n");
-	ret = clk_register_clkdev(clk, NULL, "20215000.uart");
+	ret = clk_hw_register_clkdev(hw, NULL, "20215000.uart");
 	if (ret)
 		pr_err("uart1_pclk alias not registered\n");
 }
@@ -1121,11 +1121,12 @@ static const struct clk_ops bcm2835_vpu_clock_clk_ops = {
 	.debug_init = bcm2835_clock_debug_init,
 };
 
-static struct clk *bcm2835_register_pll(struct bcm2835_cprman *cprman,
-					const struct bcm2835_pll_data *data)
+static struct clk_hw *bcm2835_register_pll(struct bcm2835_cprman *cprman,
+					   const struct bcm2835_pll_data *data)
 {
 	struct bcm2835_pll *pll;
 	struct clk_init_data init;
+	int ret;
 
 	memset(&init, 0, sizeof(init));
 
@@ -1144,17 +1145,20 @@ static struct clk *bcm2835_register_pll(struct bcm2835_cprman *cprman,
 	pll->data = data;
 	pll->hw.init = &init;
 
-	return devm_clk_register(cprman->dev, &pll->hw);
+	ret = devm_clk_hw_register(cprman->dev, &pll->hw);
+	if (ret)
+		return NULL;
+	return &pll->hw;
 }
 
-static struct clk *
+static struct clk_hw *
 bcm2835_register_pll_divider(struct bcm2835_cprman *cprman,
 			     const struct bcm2835_pll_divider_data *data)
 {
 	struct bcm2835_pll_divider *divider;
 	struct clk_init_data init;
-	struct clk *clk;
 	const char *divider_name;
+	int ret;
 
 	if (data->fixed_divider != 1) {
 		divider_name = devm_kasprintf(cprman->dev, GFP_KERNEL,
@@ -1188,32 +1192,33 @@ bcm2835_register_pll_divider(struct bcm2835_cprman *cprman,
 	divider->cprman = cprman;
 	divider->data = data;
 
-	clk = devm_clk_register(cprman->dev, &divider->div.hw);
-	if (IS_ERR(clk))
-		return clk;
+	ret = devm_clk_hw_register(cprman->dev, &divider->div.hw);
+	if (ret)
+		return ERR_PTR(ret);
 
 	/*
 	 * PLLH's channels have a fixed divide by 10 afterwards, which
 	 * is what our consumers are actually using.
 	 */
 	if (data->fixed_divider != 1) {
-		return clk_register_fixed_factor(cprman->dev, data->name,
-						 divider_name,
-						 CLK_SET_RATE_PARENT,
-						 1,
-						 data->fixed_divider);
+		return clk_hw_register_fixed_factor(cprman->dev, data->name,
+						    divider_name,
+						    CLK_SET_RATE_PARENT,
+						    1,
+						    data->fixed_divider);
 	}
 
-	return clk;
+	return &divider->div.hw;
 }
 
-static struct clk *bcm2835_register_clock(struct bcm2835_cprman *cprman,
+static struct clk_hw *bcm2835_register_clock(struct bcm2835_cprman *cprman,
 					  const struct bcm2835_clock_data *data)
 {
 	struct bcm2835_clock *clock;
 	struct clk_init_data init;
 	const char *parents[1 << CM_SRC_BITS];
 	size_t i;
+	int ret;
 
 	/*
 	 * Replace our "xosc" references with the oscillator's
@@ -1247,7 +1252,10 @@ static struct clk *bcm2835_register_clock(struct bcm2835_cprman *cprman,
 	clock->data = data;
 	clock->hw.init = &init;
 
-	return devm_clk_register(cprman->dev, &clock->hw);
+	ret = devm_clk_hw_register(cprman->dev, &clock->hw);
+	if (ret)
+		return ERR_PTR(ret);
+	return &clock->hw;
 }
 
 static struct clk *bcm2835_register_gate(struct bcm2835_cprman *cprman,
@@ -1259,8 +1267,8 @@ static struct clk *bcm2835_register_gate(struct bcm2835_cprman *cprman,
 				 CM_GATE_BIT, 0, &cprman->regs_lock);
 }
 
-typedef struct clk *(*bcm2835_clk_register)(struct bcm2835_cprman *cprman,
-					    const void *data);
+typedef struct clk_hw *(*bcm2835_clk_register)(struct bcm2835_cprman *cprman,
+					       const void *data);
 struct bcm2835_clk_desc {
 	bcm2835_clk_register clk_register;
 	const void *data;
@@ -1793,15 +1801,15 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 static int bcm2835_clk_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct clk **clks;
+	struct clk_hw **hws;
 	struct bcm2835_cprman *cprman;
 	struct resource *res;
 	const struct bcm2835_clk_desc *desc;
 	const size_t asize = ARRAY_SIZE(clk_desc_array);
 	size_t i;
 
-	cprman = devm_kzalloc(dev,
-			      sizeof(*cprman) + asize * sizeof(*clks),
+	cprman = devm_kzalloc(dev, sizeof(*cprman) +
+			      sizeof(*cprman->onecell.hws) * asize,
 			      GFP_KERNEL);
 	if (!cprman)
 		return -ENOMEM;
@@ -1819,18 +1827,17 @@ static int bcm2835_clk_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, cprman);
 
-	cprman->onecell.clk_num = asize;
-	cprman->onecell.clks = cprman->clks;
-	clks = cprman->clks;
+	cprman->onecell.num = asize;
+	hws = cprman->onecell.hws;
 
 	for (i = 0; i < asize; i++) {
 		desc = &clk_desc_array[i];
 		if (desc->clk_register && desc->data)
-			clks[i] = desc->clk_register(cprman, desc->data);
+			hws[i] = desc->clk_register(cprman, desc->data);
 	}
 
-	return of_clk_add_provider(dev->of_node, of_clk_src_onecell_get,
-				   &cprman->onecell);
+	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
+				      &cprman->onecell);
 }
 
 static const struct of_device_id bcm2835_clk_of_match[] = {
-- 
2.7.4
