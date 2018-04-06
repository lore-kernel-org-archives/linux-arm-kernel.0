From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 6 Apr 2018 08:39:28 +0200
Subject: [PATCH 1/6] clk: stm32mp1: add missing static
In-Reply-To: <1522996773-24129-1-git-send-email-gabriel.fernandez@st.com>
References: <1522996773-24129-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1522996773-24129-2-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

Add missing static for const parent names and clock ops.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index f1d5967..62f172c 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -216,7 +216,7 @@
 	"pclk5", "pll3_q", "ck_hsi", "ck_csi", "pll4_q", "ck_hse"
 };
 
-const char * const usart234578_src[] = {
+static const char * const usart234578_src[] = {
 	"pclk1", "pll4_q", "ck_hsi", "ck_csi", "ck_hse"
 };
 
@@ -316,10 +316,8 @@ struct stm32_clk_mgate {
 struct clock_config {
 	u32 id;
 	const char *name;
-	union {
-		const char *parent_name;
-		const char * const *parent_names;
-	};
+	const char *parent_name;
+	const char * const *parent_names;
 	int num_parents;
 	unsigned long flags;
 	void *cfg;
@@ -469,7 +467,7 @@ static void mp1_gate_clk_disable(struct clk_hw *hw)
 	}
 }
 
-const struct clk_ops mp1_gate_clk_ops = {
+static const struct clk_ops mp1_gate_clk_ops = {
 	.enable		= mp1_gate_clk_enable,
 	.disable	= mp1_gate_clk_disable,
 	.is_enabled	= clk_gate_is_enabled,
@@ -698,7 +696,7 @@ static void mp1_mgate_clk_disable(struct clk_hw *hw)
 		mp1_gate_clk_disable(hw);
 }
 
-const struct clk_ops mp1_mgate_clk_ops = {
+static const struct clk_ops mp1_mgate_clk_ops = {
 	.enable		= mp1_mgate_clk_enable,
 	.disable	= mp1_mgate_clk_disable,
 	.is_enabled	= clk_gate_is_enabled,
@@ -732,7 +730,7 @@ static int clk_mmux_set_parent(struct clk_hw *hw, u8 index)
 	return 0;
 }
 
-const struct clk_ops clk_mmux_ops = {
+static const struct clk_ops clk_mmux_ops = {
 	.get_parent	= clk_mmux_get_parent,
 	.set_parent	= clk_mmux_set_parent,
 	.determine_rate	= __clk_mux_determine_rate,
@@ -1048,10 +1046,10 @@ struct stm32_pll_cfg {
 	u32 offset;
 };
 
-struct clk_hw *_clk_register_pll(struct device *dev,
-				 struct clk_hw_onecell_data *clk_data,
-				 void __iomem *base, spinlock_t *lock,
-				 const struct clock_config *cfg)
+static struct clk_hw *_clk_register_pll(struct device *dev,
+					struct clk_hw_onecell_data *clk_data,
+					void __iomem *base, spinlock_t *lock,
+					const struct clock_config *cfg)
 {
 	struct stm32_pll_cfg *stm_pll_cfg = cfg->cfg;
 
@@ -1417,7 +1415,7 @@ enum {
 	G_LAST
 };
 
-struct stm32_mgate mp1_mgate[G_LAST];
+static struct stm32_mgate mp1_mgate[G_LAST];
 
 #define _K_GATE(_id, _gate_offset, _gate_bit_idx, _gate_flags,\
 	       _mgate, _ops)\
@@ -1440,7 +1438,7 @@ enum {
 	       &mp1_mgate[_id], &mp1_mgate_clk_ops)
 
 /* Peripheral gates */
-struct stm32_gate_cfg per_gate_cfg[G_LAST] = {
+static struct stm32_gate_cfg per_gate_cfg[G_LAST] = {
 	/* Multi gates */
 	K_GATE(G_MDIO,		RCC_APB1ENSETR, 31, 0),
 	K_MGATE(G_DAC12,	RCC_APB1ENSETR, 29, 0),
@@ -1600,7 +1598,7 @@ enum {
 	M_LAST
 };
 
-struct stm32_mmux ker_mux[M_LAST];
+static struct stm32_mmux ker_mux[M_LAST];
 
 #define _K_MUX(_id, _offset, _shift, _width, _mux_flags, _mmux, _ops)\
 	[_id] = {\
@@ -1623,7 +1621,7 @@ enum {
 	_K_MUX(_id, _offset, _shift, _width, _mux_flags,\
 			&ker_mux[_id], &clk_mmux_ops)
 
-const struct stm32_mux_cfg ker_mux_cfg[M_LAST] = {
+static const struct stm32_mux_cfg ker_mux_cfg[M_LAST] = {
 	/* Kernel multi mux */
 	K_MMUX(M_SDMMC12, RCC_SDMMC12CKSELR, 0, 3, 0),
 	K_MMUX(M_SPI23, RCC_SPI2S23CKSELR, 0, 3, 0),
-- 
1.9.1
