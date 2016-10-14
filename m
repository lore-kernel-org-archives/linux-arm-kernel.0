From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 14 Oct 2016 11:18:17 +0200
Subject: [PATCH v2 4/6] clk: stm32f4: Add RTC clock
In-Reply-To: <1476436699-21879-1-git-send-email-gabriel.fernandez@st.com>
References: <1476436699-21879-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1476436699-21879-5-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch introduces the support of the RTC clock.
RTC clock can have 3 sources: lsi, lse and hse_rtc.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32f4.c | 135 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 789a8f77..bf9448d 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -126,7 +126,7 @@ struct stm32f4_gate_data {
 	{ STM32F4_RCC_APB2ENR, 26,	"ltdc",		"apb2_div" },
 };
 
-enum { SYSTICK, FCLK, CLK_LSI, CLK_LSE, END_PRIMARY_CLK };
+enum { SYSTICK, FCLK, CLK_LSI, CLK_LSE, CLK_HSE_RTC, CLK_RTC, END_PRIMARY_CLK };
 /*
  * MAX_CLKS is the maximum value in the enumeration below plus the combined
  * hweight of stm32f42xx_gate_map (plus one).
@@ -310,6 +310,15 @@ static inline void enable_power_domain_write_protection(void)
 	regmap_update_bits(pdrm, 0x00, (1 << 8), (0 << 8));
 }
 
+static inline void sofware_reset_backup_domain(void)
+{
+	unsigned long val;
+
+	val = readl(base + STM32F4_RCC_BDCR);
+	writel(val |= (1 << 16), base + STM32F4_RCC_BDCR);
+	writel(val & ~(1 << 16), base + STM32F4_RCC_BDCR);
+}
+
 struct stm32_rgate {
 	struct	clk_hw hw;
 	struct	clk_gate gate;
@@ -396,6 +405,113 @@ static struct clk_hw *clk_register_rgate(struct device *dev, const char *name,
 	return hw;
 }
 
+static int cclk_gate_enable(struct clk_hw *hw)
+{
+	int ret;
+
+	disable_power_domain_write_protection();
+
+	ret = clk_gate_ops.enable(hw);
+
+	enable_power_domain_write_protection();
+
+	return ret;
+}
+
+static void cclk_gate_disable(struct clk_hw *hw)
+{
+	disable_power_domain_write_protection();
+
+	clk_gate_ops.disable(hw);
+
+	enable_power_domain_write_protection();
+}
+
+static int cclk_gate_is_enabled(struct clk_hw *hw)
+{
+	return clk_gate_ops.is_enabled(hw);
+}
+
+static const struct clk_ops cclk_gate_ops = {
+	.enable		= cclk_gate_enable,
+	.disable	= cclk_gate_disable,
+	.is_enabled	= cclk_gate_is_enabled,
+};
+
+static u8 cclk_mux_get_parent(struct clk_hw *hw)
+{
+	return clk_mux_ops.get_parent(hw);
+}
+
+
+static int cclk_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	int ret;
+
+	disable_power_domain_write_protection();
+
+	sofware_reset_backup_domain();
+
+	ret = clk_mux_ops.set_parent(hw, index);
+
+	enable_power_domain_write_protection();
+
+	return ret;
+}
+
+
+static const struct clk_ops cclk_mux_ops = {
+	.get_parent = cclk_mux_get_parent,
+	.set_parent = cclk_mux_set_parent,
+};
+
+static struct clk_hw *stm32_register_cclk(struct device *dev, const char *name,
+		const char * const *parent_names, int num_parents,
+		void __iomem *reg, u8 bit_idx, u8 shift, unsigned long flags,
+		spinlock_t *lock)
+{
+	struct clk_hw *hw;
+	struct clk_gate *gate;
+	struct clk_mux *mux;
+
+	gate = kzalloc(sizeof(struct clk_gate), GFP_KERNEL);
+	if (!gate) {
+		hw = ERR_PTR(-EINVAL);
+		goto fail;
+	}
+
+	mux = kzalloc(sizeof(struct clk_mux), GFP_KERNEL);
+	if (!mux) {
+		kfree(gate);
+		hw = ERR_PTR(-EINVAL);
+		goto fail;
+	}
+
+	gate->reg = reg;
+	gate->bit_idx = bit_idx;
+	gate->flags = 0;
+	gate->lock = lock;
+
+	mux->reg = reg;
+	mux->shift = shift;
+	mux->mask = 3;
+	mux->flags = 0;
+
+	hw = clk_hw_register_composite(dev, name, parent_names, num_parents,
+			&mux->hw, &cclk_mux_ops,
+			NULL, NULL,
+			&gate->hw, &cclk_gate_ops,
+			flags);
+
+	if (IS_ERR(hw)) {
+		kfree(gate);
+		kfree(mux);
+	}
+
+fail:
+	return hw;
+}
+
 static const char *sys_parents[] __initdata =   { "hsi", NULL, "pll" };
 
 const char *rtc_parents[4] = {
@@ -501,6 +617,23 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 		goto fail;
 	}
 
+	clks[CLK_HSE_RTC] = clk_hw_register_divider(NULL, "hse-rtc", "clk-hse",
+			0, base + STM32F4_RCC_CFGR, 16, 5, 0,
+			&stm32f4_clk_lock);
+
+	if (IS_ERR(clks[CLK_HSE_RTC])) {
+		pr_err("Unable to register hse-rtc clock\n");
+		goto fail;
+	}
+
+	clks[CLK_RTC] = stm32_register_cclk(NULL, "rtc", rtc_parents, 4,
+			base + STM32F4_RCC_BDCR, 15, 8, 0, &stm32f4_clk_lock);
+
+	if (IS_ERR(clks[CLK_RTC])) {
+		pr_err("Unable to register rtc clock\n");
+		goto fail;
+	}
+
 	of_clk_add_hw_provider(np, stm32f4_rcc_lookup_clk, NULL);
 	return;
 fail:
-- 
1.9.1
