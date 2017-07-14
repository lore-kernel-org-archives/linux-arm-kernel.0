From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 14 Jul 2017 14:42:54 +0800
Subject: [PATCH 03/11] clk: sunxi-ng: a83t: Support new timing mode for mmc2
 clock
In-Reply-To: <20170714064302.20383-1-wens@csie.org>
References: <20170714064302.20383-1-wens@csie.org>
Message-ID: <20170714064302.20383-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMC2 clock supports a new timing mode. When the new mode is active,
the output clock rate is halved.

This patch sets the feature flag for the new timing mode, and adds
a pre-divider based on the mode bit.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c | 38 +++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
index 947f9f6e05d2..ee6688e9b361 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
@@ -418,14 +418,36 @@ static SUNXI_CCU_PHASE(mmc1_sample_clk, "mmc1-sample", "mmc1",
 static SUNXI_CCU_PHASE(mmc1_output_clk, "mmc1-output", "mmc1",
 		       0x08c, 8, 3, 0);
 
-/* TODO Support MMC2 clock's new timing mode. */
-static SUNXI_CCU_MP_WITH_MUX_GATE(mmc2_clk, "mmc2", mod0_default_parents,
-				  0x090,
-				  0, 4,		/* M */
-				  16, 2,	/* P */
-				  24, 2,	/* mux */
-				  BIT(31),	/* gate */
-				  0);
+/*
+ * MMC2 supports both old and new timing modes. When the new timing
+ * mode is active, the output clock rate is halved by two. Here we
+ * treat it as a variable pre-divider. Note that the pre-divider is
+ * _not_ included in the possible factors during a set clock rate
+ * operation. It is only read out.
+ */
+static const struct ccu_mux_var_prediv mmc2_new_timing_predivs[] = {
+	{ .index = 0, .shift = 30, .width = 1 },
+	{ .index = 1, .shift = 30, .width = 1 },
+};
+static struct ccu_mp mmc2_clk = {
+	.enable = BIT(31),
+	.m      = _SUNXI_CCU_DIV(0, 4),
+	.p      = _SUNXI_CCU_DIV(16, 2),
+	.mux    = {
+		.shift  = 24,
+		.width  = 2,
+		.var_predivs    = mmc2_new_timing_predivs,
+		.n_var_predivs  = ARRAY_SIZE(mmc2_new_timing_predivs),
+	},
+	.common         = {
+		.reg            = 0x090,
+		.features	= CCU_FEATURE_MMC_TIMING_SWITCH,
+		.hw.init        = CLK_HW_INIT_PARENTS("mmc2",
+						      mod0_default_parents,
+						      &ccu_mp_ops,
+						      CLK_GET_RATE_NOCACHE),
+	},
+};
 
 static SUNXI_CCU_PHASE(mmc2_sample_clk, "mmc2-sample", "mmc2",
 		       0x090, 20, 3, 0);
-- 
2.13.2
