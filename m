From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Mon,  7 Nov 2016 01:29:32 +0800
Subject: [PATCH 2/2] clk: sunxi-ng: fix up PLL_CPUX adjusting for A23/A33
In-Reply-To: <20161106172932.39478-1-icenowy@aosc.xyz>
References: <20161106172932.39478-1-icenowy@aosc.xyz>
Message-ID: <20161106172932.39478-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When adjusting PLL_CPUX on A23/A33, the PLL is driven too high, and the
system stucks.

Add a notifier to avoid this situation.

The code is ported from ccu-sun6i-a31.c.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Patch 4.9-rc too.
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c | 10 ++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
index 44c4775..41a8594 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
@@ -709,6 +709,13 @@ static const struct sunxi_ccu_desc sun8i_a23_ccu_desc = {
 	.num_resets	= ARRAY_SIZE(sun8i_a23_ccu_resets),
 };
 
+static struct ccu_mux_nb sun8i_a23_cpu_nb = {
+	.common		= &cpux_clk.common,
+	.cm		= &cpux_clk.mux,
+	.delay_us	= 1, /* > 8 clock cycles at 24 MHz */
+	.bypass_index	= 1, /* index of 24 MHz oscillator */
+};
+
 static void __init sun8i_a23_ccu_setup(struct device_node *node)
 {
 	void __iomem *reg;
@@ -732,6 +739,9 @@ static void __init sun8i_a23_ccu_setup(struct device_node *node)
 	writel(val, reg + SUN8I_A23_PLL_MIPI_REG);
 
 	sunxi_ccu_probe(node, reg, &sun8i_a23_ccu_desc);
+
+	ccu_mux_notifier_register(pll_cpux_clk.common.hw.clk,
+				  &sun8i_a23_cpu_nb);
 }
 CLK_OF_DECLARE(sun8i_a23_ccu, "allwinner,sun8i-a23-ccu",
 	       sun8i_a23_ccu_setup);
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
index 59cfdc8..3efbb6e 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
@@ -752,6 +752,13 @@ static const struct sunxi_ccu_desc sun8i_a33_ccu_desc = {
 	.num_resets	= ARRAY_SIZE(sun8i_a33_ccu_resets),
 };
 
+static struct ccu_mux_nb sun8i_a33_cpu_nb = {
+	.common		= &cpux_clk.common,
+	.cm		= &cpux_clk.mux,
+	.delay_us	= 1, /* > 8 clock cycles at 24 MHz */
+	.bypass_index	= 1, /* index of 24 MHz oscillator */
+};
+
 static void __init sun8i_a33_ccu_setup(struct device_node *node)
 {
 	void __iomem *reg;
@@ -775,6 +782,9 @@ static void __init sun8i_a33_ccu_setup(struct device_node *node)
 	writel(val, reg + SUN8I_A33_PLL_MIPI_REG);
 
 	sunxi_ccu_probe(node, reg, &sun8i_a33_ccu_desc);
+
+	ccu_mux_notifier_register(pll_cpux_clk.common.hw.clk,
+				  &sun8i_a33_cpu_nb);
 }
 CLK_OF_DECLARE(sun8i_a33_ccu, "allwinner,sun8i-a33-ccu",
 	       sun8i_a33_ccu_setup);
-- 
2.10.1
