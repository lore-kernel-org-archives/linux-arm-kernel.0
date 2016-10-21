From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 21 Oct 2016 11:23:28 +0200
Subject: [PATCH v3 1/3] clk: stm32f4: Add LSI & LSE clocks
In-Reply-To: <1477041810-12313-1-git-send-email-gabriel.fernandez@st.com>
References: <1477041810-12313-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1477041810-12313-2-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch introduces the support of the LSI & LSE clocks.
The clock drivers needs to disable the power domain write protection
using syscon/regmap to enable these clocks.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32f4.c | 131 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 126 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 02d6810..6427e0f 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -19,10 +19,14 @@
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/ioport.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 
 #define STM32F4_RCC_PLLCFGR		0x04
 #define STM32F4_RCC_CFGR		0x08
@@ -31,6 +35,8 @@
 #define STM32F4_RCC_AHB3ENR		0x38
 #define STM32F4_RCC_APB1ENR		0x40
 #define STM32F4_RCC_APB2ENR		0x44
+#define STM32F4_RCC_BDCR		0x70
+#define STM32F4_RCC_CSR			0x74
 
 struct stm32f4_gate_data {
 	u8	offset;
@@ -120,13 +126,12 @@ struct stm32f4_gate_data {
 	{ STM32F4_RCC_APB2ENR, 26,	"ltdc",		"apb2_div" },
 };
 
+enum { SYSTICK, FCLK, CLK_LSI, CLK_LSE, END_PRIMARY_CLK };
 /*
  * MAX_CLKS is the maximum value in the enumeration below plus the combined
  * hweight of stm32f42xx_gate_map (plus one).
  */
-#define MAX_CLKS 74
-
-enum { SYSTICK, FCLK };
+#define MAX_CLKS (71 + END_PRIMARY_CLK + 1)
 
 /*
  * This bitmask tells us which bit offsets (0..192) on STM32F4[23]xxx
@@ -140,6 +145,8 @@ struct stm32f4_gate_data {
 static DEFINE_SPINLOCK(stm32f4_clk_lock);
 static void __iomem *base;
 
+static struct regmap *pdrm;
+
 /*
  * "Multiplier" device for APBx clocks.
  *
@@ -259,7 +266,7 @@ static int stm32f4_rcc_lookup_clk_idx(u8 primary, u8 secondary)
 	u64 table[ARRAY_SIZE(stm32f42xx_gate_map)];
 
 	if (primary == 1) {
-		if (WARN_ON(secondary > FCLK))
+		if (WARN_ON(secondary >= END_PRIMARY_CLK))
 			return -EINVAL;
 		return secondary;
 	}
@@ -276,7 +283,7 @@ static int stm32f4_rcc_lookup_clk_idx(u8 primary, u8 secondary)
 	table[BIT_ULL_WORD(secondary)] &=
 	    GENMASK_ULL(secondary % BITS_PER_LONG_LONG, 0);
 
-	return FCLK + hweight64(table[0]) +
+	return END_PRIMARY_CLK - 1 + hweight64(table[0]) +
 	       (BIT_ULL_WORD(secondary) >= 1 ? hweight64(table[1]) : 0) +
 	       (BIT_ULL_WORD(secondary) >= 2 ? hweight64(table[2]) : 0);
 }
@@ -292,6 +299,98 @@ static int stm32f4_rcc_lookup_clk_idx(u8 primary, u8 secondary)
 	return clks[i];
 }
 
+#define to_rgclk(_rgate) container_of(_rgate, struct stm32_rgate, gate)
+
+static inline void disable_power_domain_write_protection(void)
+{
+	if (pdrm)
+		regmap_update_bits(pdrm, 0x00, (1 << 8), (1 << 8));
+}
+
+static inline void enable_power_domain_write_protection(void)
+{
+	if (pdrm)
+		regmap_update_bits(pdrm, 0x00, (1 << 8), (0 << 8));
+}
+
+struct stm32_rgate {
+	struct	clk_gate gate;
+	u8	bit_rdy_idx;
+};
+
+#define RTC_TIMEOUT 1000000
+
+static int rgclk_enable(struct clk_hw *hw)
+{
+	struct clk_gate *gate = to_clk_gate(hw);
+	struct stm32_rgate *rgate = to_rgclk(gate);
+	u32 reg;
+	int ret;
+
+	disable_power_domain_write_protection();
+
+	clk_gate_ops.enable(hw);
+
+	ret = readl_relaxed_poll_timeout_atomic(gate->reg, reg,
+			reg & rgate->bit_rdy_idx, 1000, RTC_TIMEOUT);
+
+	enable_power_domain_write_protection();
+	return ret;
+}
+
+static void rgclk_disable(struct clk_hw *hw)
+{
+	clk_gate_ops.disable(hw);
+}
+
+static int rgclk_is_enabled(struct clk_hw *hw)
+{
+	return clk_gate_ops.is_enabled(hw);
+}
+
+static const struct clk_ops rgclk_ops = {
+	.enable = rgclk_enable,
+	.disable = rgclk_disable,
+	.is_enabled = rgclk_is_enabled,
+};
+
+static struct clk_hw *clk_register_rgate(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		void __iomem *reg, u8 bit_idx, u8 bit_rdy_idx,
+		u8 clk_gate_flags, spinlock_t *lock)
+{
+	struct stm32_rgate *rgate;
+	struct clk_init_data init = { NULL };
+	struct clk_hw *hw;
+	int ret;
+
+	rgate = kzalloc(sizeof(*rgate), GFP_KERNEL);
+	if (!rgate)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &rgclk_ops;
+	init.flags = flags;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	rgate->bit_rdy_idx = bit_rdy_idx;
+
+	rgate->gate.lock = lock;
+	rgate->gate.reg = reg;
+	rgate->gate.bit_idx = bit_idx;
+	rgate->gate.hw.init = &init;
+
+	hw = &rgate->gate.hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret) {
+		kfree(rgate);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
+
 static const char *sys_parents[] __initdata =   { "hsi", NULL, "pll" };
 
 static const struct clk_div_table ahb_div_table[] = {
@@ -319,6 +418,12 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 		return;
 	}
 
+	pdrm = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
+	if (IS_ERR(pdrm)) {
+		pdrm = NULL;
+		pr_warn("%s: Unable to get syscfg\n", __func__);
+	}
+
 	hse_clk = of_clk_get_parent_name(np, 0);
 
 	clk_register_fixed_rate_with_accuracy(NULL, "hsi", NULL, 0,
@@ -371,6 +476,22 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 		}
 	}
 
+	clks[CLK_LSI] = clk_register_rgate(NULL, "lsi", "clk-lsi", 0,
+			base + STM32F4_RCC_CSR, 0, 2, 0, &stm32f4_clk_lock);
+
+	if (IS_ERR(clks[CLK_LSI])) {
+		pr_err("Unable to register lsi clock\n");
+		goto fail;
+	}
+
+	clks[CLK_LSE] = clk_register_rgate(NULL, "lse", "clk-lse", 0,
+			base + STM32F4_RCC_BDCR, 0, 2, 0, &stm32f4_clk_lock);
+
+	if (IS_ERR(clks[CLK_LSE])) {
+		pr_err("Unable to register lse clock\n");
+		goto fail;
+	}
+
 	of_clk_add_hw_provider(np, stm32f4_rcc_lookup_clk, NULL);
 	return;
 fail:
-- 
1.9.1
