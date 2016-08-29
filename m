From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Mon, 29 Aug 2016 14:26:58 +0200
Subject: [PATCH v3 06/14] drivers: clk: st: Handle clk synchronous mode for
 video clocks
In-Reply-To: <1472473626-15398-1-git-send-email-gabriel.fernandez@st.com>
References: <1472473626-15398-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1472473626-15398-7-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch configures the semi-synchronous mode of the video clocks
of clkgenD2.

Signed-off-by: Olivier Bideau <olivier.bideau@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Acked-by: Peter Griffin <peter.griffin@linaro.org>
---
 .../devicetree/bindings/clock/st/st,flexgen.txt    |  2 ++
 drivers/clk/st/clk-flexgen.c                       | 37 ++++++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/st/st,flexgen.txt b/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
index d68f6a5f..7ff77fc 100644
--- a/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
+++ b/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
@@ -62,6 +62,8 @@ Required properties:
   "st,flexgen"
   "st,flexgen-audio", "st,flexgen" (enable clock propagation on parent for
   audio use case)
+  "st,flexgen-video", "st,flexgen" (enable clock propagation on parent
+					and activate synchronous mode)
 
 - #clock-cells : from common clock binding; shall be set to 1 (multiple clock
   outputs).
diff --git a/drivers/clk/st/clk-flexgen.c b/drivers/clk/st/clk-flexgen.c
index 7ed05f0..a485f3b 100644
--- a/drivers/clk/st/clk-flexgen.c
+++ b/drivers/clk/st/clk-flexgen.c
@@ -17,6 +17,7 @@
 
 struct clkgen_data {
 	unsigned long flags;
+	bool mode;
 };
 
 struct flexgen {
@@ -32,9 +33,14 @@ struct flexgen {
 	struct clk_gate fgate;
 	/* Final divisor */
 	struct clk_divider fdiv;
+	/* Asynchronous mode control */
+	struct clk_gate sync;
+	/* hw control flags */
+	bool control_mode;
 };
 
 #define to_flexgen(_hw) container_of(_hw, struct flexgen, hw)
+#define to_clk_gate(_hw) container_of(_hw, struct clk_gate, hw)
 
 static int flexgen_enable(struct clk_hw *hw)
 {
@@ -143,12 +149,21 @@ static int flexgen_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct flexgen *flexgen = to_flexgen(hw);
 	struct clk_hw *pdiv_hw = &flexgen->pdiv.hw;
 	struct clk_hw *fdiv_hw = &flexgen->fdiv.hw;
+	struct clk_hw *sync_hw = &flexgen->sync.hw;
+	struct clk_gate *config = to_clk_gate(sync_hw);
 	unsigned long div = 0;
 	int ret = 0;
+	u32 reg;
 
 	__clk_hw_set_clk(pdiv_hw, hw);
 	__clk_hw_set_clk(fdiv_hw, hw);
 
+	if (flexgen->control_mode) {
+		reg = readl(config->reg);
+		reg &= ~BIT(config->bit_idx);
+		writel(reg, config->reg);
+	}
+
 	div = clk_best_div(parent_rate, rate);
 
 	/*
@@ -182,7 +197,7 @@ static const struct clk_ops flexgen_ops = {
 static struct clk *clk_register_flexgen(const char *name,
 				const char **parent_names, u8 num_parents,
 				void __iomem *reg, spinlock_t *lock, u32 idx,
-				unsigned long flexgen_flags) {
+				unsigned long flexgen_flags, bool mode) {
 	struct flexgen *fgxbar;
 	struct clk *clk;
 	struct clk_init_data init;
@@ -231,6 +246,13 @@ static struct clk *clk_register_flexgen(const char *name,
 	fgxbar->fdiv.reg = fdiv_reg;
 	fgxbar->fdiv.width = 6;
 
+	/* Final divider sync config */
+	fgxbar->sync.lock = lock;
+	fgxbar->sync.reg = fdiv_reg;
+	fgxbar->sync.bit_idx = 7;
+
+	fgxbar->control_mode = mode;
+
 	fgxbar->hw.init = &init;
 
 	clk = clk_register(NULL, &fgxbar->hw);
@@ -267,11 +289,20 @@ static const struct clkgen_data clkgen_audio = {
 	.flags = CLK_SET_RATE_PARENT,
 };
 
+static const struct clkgen_data clkgen_video = {
+	.flags = CLK_SET_RATE_PARENT,
+	.mode = 1,
+};
+
 static const struct of_device_id flexgen_of_match[] = {
 	{
 		.compatible = "st,flexgen-audio",
 		.data = &clkgen_audio,
 	},
+	{
+		.compatible = "st,flexgen-video",
+		.data = &clkgen_video,
+	},
 	{}
 };
 
@@ -287,6 +318,7 @@ static void __init st_of_flexgen_setup(struct device_node *np)
 	struct clkgen_data *data = NULL;
 	unsigned long flex_flags = 0;
 	int ret;
+	bool clk_mode = 0;
 
 	pnode = of_get_parent(np);
 	if (!pnode)
@@ -304,6 +336,7 @@ static void __init st_of_flexgen_setup(struct device_node *np)
 	if (match) {
 		data = (struct clkgen_data *)match->data;
 		flex_flags = data->flags;
+		clk_mode = data->mode;
 	}
 
 	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
@@ -347,7 +380,7 @@ static void __init st_of_flexgen_setup(struct device_node *np)
 			continue;
 
 		clk = clk_register_flexgen(clk_name, parents, num_parents,
-					   reg, rlock, i, flex_flags);
+					   reg, rlock, i, flex_flags, clk_mode);
 
 		if (IS_ERR(clk))
 			goto err;
-- 
1.9.1
