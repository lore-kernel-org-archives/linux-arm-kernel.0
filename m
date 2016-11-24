From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Thu, 24 Nov 2016 15:45:44 +0100
Subject: [PATCH v2 4/9] clk: stm32f4: Add lcd-tft clock
In-Reply-To: <1479998749-20358-1-git-send-email-gabriel.fernandez@st.com>
References: <1479998749-20358-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1479998749-20358-5-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch introduces lcd-tft clock for stm32f4 soc.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 .../devicetree/bindings/clock/st,stm32-rcc.txt     |   1 +
 drivers/clk/clk-stm32f4.c                          | 118 +++++++++++++++++++++
 include/dt-bindings/clock/stm32f4-clock.h          |   3 +-
 3 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt b/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
index eb6733c..4cd08da6 100644
--- a/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
+++ b/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
@@ -76,6 +76,7 @@ The secondary index is bound with the following magic numbers:
 	5	CLK_RTC		(real-time clock)
 	6	PLL_VCO_I2S	(vco frequency of I2S pll)
 	7	PLL_VCO_SAI	(vco frequency of SAI pll)
+	8	CLK_LCD		(LCD-TFT)
 
 Example:
 
diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 3918305..86244fc 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -47,6 +47,7 @@
 #define STM32F4_RCC_CSR			0x74
 #define STM32F4_RCC_PLLI2SCFGR		0x84
 #define STM32F4_RCC_PLLSAICFGR		0x88
+#define STM32F4_RCC_DCKCFGR		0x8c
 
 struct stm32f4_gate_data {
 	u8	offset;
@@ -932,11 +933,42 @@ static struct clk_hw *stm32_register_cclk(struct device *dev, const char *name,
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
@@ -944,6 +976,8 @@ struct stm32f4_clk_data {
 	.gates_map	= stm32f42xx_gate_map,
 	.gates_num	= ARRAY_SIZE(stm32f429_gates),
 	.pll_data	= stm32f429_pll,
+	.aux_clk	= stm32f429_aux_clk,
+	.aux_clk_num	= ARRAY_SIZE(stm32f429_aux_clk),
 };
 
 static const struct stm32f4_clk_data stm32f469_clk_data = {
@@ -951,6 +985,8 @@ struct stm32f4_clk_data {
 	.gates_map	= stm32f46xx_gate_map,
 	.gates_num	= ARRAY_SIZE(stm32f469_gates),
 	.pll_data	= stm32f469_pll,
+	.aux_clk	= stm32f429_aux_clk,
+	.aux_clk_num	= ARRAY_SIZE(stm32f429_aux_clk),
 };
 
 static const struct of_device_id stm32f4_of_match[] = {
@@ -965,6 +1001,66 @@ struct stm32f4_clk_data {
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
@@ -1120,6 +1216,28 @@ static void __init stm32f4_rcc_init(struct device_node *np)
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
diff --git a/include/dt-bindings/clock/stm32f4-clock.h b/include/dt-bindings/clock/stm32f4-clock.h
index 56b8e10..1be4a3a 100644
--- a/include/dt-bindings/clock/stm32f4-clock.h
+++ b/include/dt-bindings/clock/stm32f4-clock.h
@@ -27,7 +27,8 @@
 #define CLK_RTC			5
 #define PLL_VCO_I2S		6
 #define PLL_VCO_SAI		7
+#define CLK_LCD			8
 
-#define END_PRIMARY_CLK		8
+#define END_PRIMARY_CLK		9
 
 #endif
-- 
1.9.1
