From: megous@megous.com (megous at megous.com)
Date: Fri, 25 Nov 2016 01:28:47 +0100
Subject: [PATCH] clk: sunxi-ng: fix PLL_CPUX adjusting on H3
Message-ID: <20161125002852.18097-1-megous@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ondrej Jirman <megous@megous.com>

When adjusting PLL_CPUX on H3, the PLL is temporarily driven
too high, and the system becomes unstable (oopses or hangs).

Add a notifier to avoid this situation by temporarily switching
to a known stable 24 MHz oscillator.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Tested-by: Lutz Sammer <johns98@gmx.net>
---
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index 614d47c..cf266c9 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -809,6 +809,13 @@ static const struct sunxi_ccu_desc sun8i_h3_ccu_desc = {
 	.num_resets	= ARRAY_SIZE(sun8i_h3_ccu_resets),
 };
 
+static struct ccu_mux_nb sun8i_h3_cpu_nb = {
+	.common		= &cpux_clk.common,
+	.cm		= &cpux_clk.mux,
+	.delay_us	= 1, /* > 8 clock cycles at 24 MHz */
+	.bypass_index	= 1, /* index of 24 MHz oscillator */
+};
+
 static void __init sun8i_h3_ccu_setup(struct device_node *node)
 {
 	void __iomem *reg;
@@ -827,6 +834,9 @@ static void __init sun8i_h3_ccu_setup(struct device_node *node)
 	writel(val | (3 << 16), reg + SUN8I_H3_PLL_AUDIO_REG);
 
 	sunxi_ccu_probe(node, reg, &sun8i_h3_ccu_desc);
+
+	ccu_mux_notifier_register(pll_cpux_clk.common.hw.clk,
+				  &sun8i_h3_cpu_nb);
 }
 CLK_OF_DECLARE(sun8i_h3_ccu, "allwinner,sun8i-h3-ccu",
 	       sun8i_h3_ccu_setup);
-- 
2.10.2
