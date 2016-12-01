From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Thu, 1 Dec 2016 16:27:44 +0100
Subject: [PATCH v3 4/9] clk: stm32f4: Add lcd-tft clock
In-Reply-To: <1480606069-5178-1-git-send-email-gabriel.fernandez@st.com>
References: <1480606069-5178-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1480606069-5178-5-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch introduces lcd-tft clock for stm32f4 soc.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32f4.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 98856ac..86244fc 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -933,11 +933,42 @@ static struct clk_hw *stm32_register_cclk(struct device *dev, const char *name,
 	"no-clock", "lse", "lsi", "hse-rtc"
 };
 
+static const char *lcd_parent[1] = { "pllsai-r-div" };
+
+struct stm32_aux_clk {
+	int idx;
+	const char *name;
+	const char * const *parent_names;
+	int num_parents;
+	int offset_mux;
+	u8 shift;
+	u8 mask;
+	int offset_gate;
+	u8 bit_idx;
+	unsigned long flags;
+};
+
 struct stm32f4_clk_data {
 	const struct stm32f4_gate_data *gates_data;
 	const u64 *gates_map;
 	int gates_num;
 	const struct stm32f4_pll_data *pll_data;
+	const struct stm32_aux_clk *aux_clk;
+	int aux_clk_num;
+};
+
+#define NONE -1
+#define NO_IDX  NONE
+#define NO_MUX  NONE
+#define NO_GATE NONE
+
+static const struct stm32_aux_clk stm32f429_aux_clk[] = {
+	{
+		CLK_LCD, "lcd-tft", lcd_parent, ARRAY_SIZE(lcd_parent),
+		NO_MUX, 0, 0,
+		STM32F4_RCC_APB2ENR, 26,
+		CLK_SET_RATE_PARENT
+	},
 };
 
 static const struct stm32f4_clk_data stm32f429_clk_data = {
@@ -945,6 +976,8 @@ struct stm32f4_clk_data {
 	.gates_map	= stm32f42xx_gate_map,
 	.gates_num	= ARRAY_SIZE(stm32f429_gates),
 	.pll_data	= stm32f429_pll,
+	.aux_clk	= stm32f429_aux_clk,
+	.aux_clk_num	= ARRAY_SIZE(stm32f429_aux_clk),
 };
 
 static const struct stm32f4_clk_data stm32f469_clk_data = {
@@ -952,6 +985,8 @@ struct stm32f4_clk_data {
 	.gates_map	= stm32f46xx_gate_map,
 	.gates_num	= ARRAY_SIZE(stm32f469_gates),
 	.pll_data	= stm32f469_pll,
+	.aux_clk	= stm32f429_aux_clk,
+	.aux_clk_num	= ARRAY_SIZE(stm32f429_aux_clk),
 };
 
 static const struct of_device_id stm32f4_of_match[] = {
@@ -966,6 +1001,66 @@ struct stm32f4_clk_data {
 	{}
 };
 
+static struct clk_hw *stm32_register_aux_clk(const char *name,
+		const char * const *parent_names, int num_parents,
+		int offset_mux, u8 shift, u8 mask,
+		int offset_gate, u8 bit_idx,
+		unsigned long flags, spinlock_t *lock)
+{
+	struct clk_hw *hw;
+	struct clk_gate *gate;
+	struct clk_mux *mux = NULL;
+	struct clk_hw *mux_hw = NULL, *gate_hw = NULL;
+	const struct clk_ops *mux_ops = NULL, *gate_ops = NULL;
+
+	if (offset_gate != NO_GATE) {
+		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+		if (!gate) {
+			hw = ERR_PTR(-EINVAL);
+			goto fail;
+		}
+
+		gate->reg = base + offset_gate;
+		gate->bit_idx = bit_idx;
+		gate->flags = 0;
+		gate->lock = lock;
+		gate_hw = &gate->hw;
+		gate_ops = &clk_gate_ops;
+	}
+
+	if (offset_mux != NO_MUX) {
+		mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+		if (!mux) {
+			kfree(gate);
+			hw = ERR_PTR(-EINVAL);
+			goto fail;
+		}
+
+		mux->reg = base + offset_mux;
+		mux->shift = shift;
+		mux->mask = mask;
+		mux->flags = 0;
+		mux_hw = &mux->hw;
+		mux_ops = &clk_mux_ops;
+	}
+
+	if (mux_hw == NULL && gate_hw == NULL)
+		return ERR_PTR(-EINVAL);
+
+	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
+			mux_hw, mux_ops,
+			NULL, NULL,
+			gate_hw, gate_ops,
+			flags);
+
+	if (IS_ERR(hw)) {
+		kfree(gate);
+		kfree(mux);
+	}
+fail:
+	return hw;
+}
+
 static void __init stm32f4_rcc_init(struct device_node *np)
 {
 	const char *hse_clk;
@@ -1121,6 +1216,28 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 		goto fail;
 	}
 
+	for (n = 0; n < data->aux_clk_num; n++) {
+		const struct stm32_aux_clk *aux_clk;
+		struct clk_hw *hw;
+
+		aux_clk = &data->aux_clk[n];
+
+		hw = stm32_register_aux_clk(aux_clk->name,
+				aux_clk->parent_names, aux_clk->num_parents,
+				aux_clk->offset_mux, aux_clk->shift,
+				aux_clk->mask, aux_clk->offset_gate,
+				aux_clk->bit_idx, aux_clk->flags,
+				&stm32f4_clk_lock);
+
+		if (IS_ERR(hw)) {
+			pr_warn("Unable to register %s clk\n", aux_clk->name);
+			continue;
+		}
+
+		if (aux_clk->idx != NO_IDX)
+			clks[aux_clk->idx] = hw;
+	}
+
 	of_clk_add_hw_provider(np, stm32f4_rcc_lookup_clk, NULL);
 	return;
 fail:
-- 
1.9.1
