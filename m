From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Thu,  9 Jul 2015 13:57:38 +0200
Subject: [PATCH 1/3] drivers: clk: st: Support for enable/disable in Clockgen
 PLLs
In-Reply-To: <1436443060-12866-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1436443060-12866-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1436443060-12866-2-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds support for enable/disable of the Clockgen PLLs
clkgen_pll_enable/clkgen_pll_disable added as generic function for all PLLs
+ __enable

Signed-off-by: Pankaj Dev <pankaj.dev@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 drivers/clk/st/clkgen-pll.c | 93 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
index 72d1c27..bd2fcd3 100644
--- a/drivers/clk/st/clkgen-pll.c
+++ b/drivers/clk/st/clkgen-pll.c
@@ -42,6 +42,7 @@ static DEFINE_SPINLOCK(clkgena_c32_odf_lock);
 
 struct clkgen_pll_data {
 	struct clkgen_field pdn_status;
+	struct clkgen_field pdn_ctrl;
 	struct clkgen_field locked_status;
 	struct clkgen_field mdiv;
 	struct clkgen_field ndiv;
@@ -61,6 +62,7 @@ static const struct clk_ops st_pll1200c32_ops;
 
 static const struct clkgen_pll_data st_pll1600c65_ax = {
 	.pdn_status	= CLKGEN_FIELD(0x0, 0x1,			19),
+	.pdn_ctrl	= CLKGEN_FIELD(0x10,	0x1,			0),
 	.locked_status	= CLKGEN_FIELD(0x0, 0x1,			31),
 	.mdiv		= CLKGEN_FIELD(0x0, C65_MDIV_PLL1600_MASK,	0),
 	.ndiv		= CLKGEN_FIELD(0x0, C65_NDIV_MASK,		8),
@@ -69,6 +71,7 @@ static const struct clkgen_pll_data st_pll1600c65_ax = {
 
 static const struct clkgen_pll_data st_pll800c65_ax = {
 	.pdn_status	= CLKGEN_FIELD(0x0,	0x1,			19),
+	.pdn_ctrl	= CLKGEN_FIELD(0xC,	0x1,			1),
 	.locked_status	= CLKGEN_FIELD(0x0,	0x1,			31),
 	.mdiv		= CLKGEN_FIELD(0x0,	C65_MDIV_PLL800_MASK,	0),
 	.ndiv		= CLKGEN_FIELD(0x0,	C65_NDIV_MASK,		8),
@@ -78,6 +81,7 @@ static const struct clkgen_pll_data st_pll800c65_ax = {
 
 static const struct clkgen_pll_data st_pll3200c32_a1x_0 = {
 	.pdn_status	= CLKGEN_FIELD(0x0,	0x1,			31),
+	.pdn_ctrl	= CLKGEN_FIELD(0x18,	0x1,			0),
 	.locked_status	= CLKGEN_FIELD(0x4,	0x1,			31),
 	.ndiv		= CLKGEN_FIELD(0x0,	C32_NDIV_MASK,		0x0),
 	.idf		= CLKGEN_FIELD(0x4,	C32_IDF_MASK,		0x0),
@@ -95,6 +99,7 @@ static const struct clkgen_pll_data st_pll3200c32_a1x_0 = {
 
 static const struct clkgen_pll_data st_pll3200c32_a1x_1 = {
 	.pdn_status	= CLKGEN_FIELD(0xC,	0x1,			31),
+	.pdn_ctrl	= CLKGEN_FIELD(0x18,	0x1,			1),
 	.locked_status	= CLKGEN_FIELD(0x10,	0x1,			31),
 	.ndiv		= CLKGEN_FIELD(0xC,	C32_NDIV_MASK,		0x0),
 	.idf		= CLKGEN_FIELD(0x10,	C32_IDF_MASK,		0x0),
@@ -113,6 +118,7 @@ static const struct clkgen_pll_data st_pll3200c32_a1x_1 = {
 /* 415 specific */
 static const struct clkgen_pll_data st_pll3200c32_a9_415 = {
 	.pdn_status	= CLKGEN_FIELD(0x0,	0x1,			0),
+	.pdn_ctrl	= CLKGEN_FIELD(0x0,	0x1,			0),
 	.locked_status	= CLKGEN_FIELD(0x6C,	0x1,			0),
 	.ndiv		= CLKGEN_FIELD(0x0,	C32_NDIV_MASK,		9),
 	.idf		= CLKGEN_FIELD(0x0,	C32_IDF_MASK,		22),
@@ -124,6 +130,7 @@ static const struct clkgen_pll_data st_pll3200c32_a9_415 = {
 
 static const struct clkgen_pll_data st_pll3200c32_ddr_415 = {
 	.pdn_status	= CLKGEN_FIELD(0x0,	0x1,			0),
+	.pdn_ctrl	= CLKGEN_FIELD(0x0,	0x1,			0),
 	.locked_status	= CLKGEN_FIELD(0x100,	0x1,			0),
 	.ndiv		= CLKGEN_FIELD(0x8,	C32_NDIV_MASK,		0),
 	.idf		= CLKGEN_FIELD(0x0,	C32_IDF_MASK,		25),
@@ -136,7 +143,8 @@ static const struct clkgen_pll_data st_pll3200c32_ddr_415 = {
 };
 
 static const struct clkgen_pll_data st_pll1200c32_gpu_415 = {
-	.pdn_status	= CLKGEN_FIELD(0x144,	0x1,			3),
+	.pdn_status	= CLKGEN_FIELD(0x4,	0x1,			0),
+	.pdn_ctrl	= CLKGEN_FIELD(0x4,	0x1,			0),
 	.locked_status	= CLKGEN_FIELD(0x168,	0x1,			0),
 	.ldf		= CLKGEN_FIELD(0x0,	C32_LDF_MASK,		3),
 	.idf		= CLKGEN_FIELD(0x0,	C32_IDF_MASK,		0),
@@ -148,6 +156,7 @@ static const struct clkgen_pll_data st_pll1200c32_gpu_415 = {
 /* 416 specific */
 static const struct clkgen_pll_data st_pll3200c32_a9_416 = {
 	.pdn_status	= CLKGEN_FIELD(0x0,	0x1,			0),
+	.pdn_ctrl	= CLKGEN_FIELD(0x0,	0x1,			0),
 	.locked_status	= CLKGEN_FIELD(0x6C,	0x1,			0),
 	.ndiv		= CLKGEN_FIELD(0x8,	C32_NDIV_MASK,		0),
 	.idf		= CLKGEN_FIELD(0x0,	C32_IDF_MASK,		25),
@@ -159,6 +168,7 @@ static const struct clkgen_pll_data st_pll3200c32_a9_416 = {
 
 static const struct clkgen_pll_data st_pll3200c32_ddr_416 = {
 	.pdn_status	= CLKGEN_FIELD(0x0,	0x1,			0),
+	.pdn_ctrl	= CLKGEN_FIELD(0x0,	0x1,			0),
 	.locked_status	= CLKGEN_FIELD(0x10C,	0x1,			0),
 	.ndiv		= CLKGEN_FIELD(0x8,	C32_NDIV_MASK,		0),
 	.idf		= CLKGEN_FIELD(0x0,	C32_IDF_MASK,		25),
@@ -172,6 +182,7 @@ static const struct clkgen_pll_data st_pll3200c32_ddr_416 = {
 
 static const struct clkgen_pll_data st_pll1200c32_gpu_416 = {
 	.pdn_status	= CLKGEN_FIELD(0x8E4,	0x1,			3),
+	.pdn_ctrl	= CLKGEN_FIELD(0x8E4,	0x1,			3),
 	.locked_status	= CLKGEN_FIELD(0x90C,	0x1,			0),
 	.ldf		= CLKGEN_FIELD(0x0,	C32_LDF_MASK,		3),
 	.idf		= CLKGEN_FIELD(0x0,	C32_IDF_MASK,		0),
@@ -183,6 +194,7 @@ static const struct clkgen_pll_data st_pll1200c32_gpu_416 = {
 static const struct clkgen_pll_data st_pll3200c32_407_a0 = {
 	/* 407 A0 */
 	.pdn_status	= CLKGEN_FIELD(0x2a0,	0x1,			8),
+	.pdn_ctrl	= CLKGEN_FIELD(0x2a0,	0x1,			8),
 	.locked_status	= CLKGEN_FIELD(0x2a0,	0x1,			24),
 	.ndiv		= CLKGEN_FIELD(0x2a4,	C32_NDIV_MASK,		16),
 	.idf		= CLKGEN_FIELD(0x2a4,	C32_IDF_MASK,		0x0),
@@ -195,6 +207,7 @@ static const struct clkgen_pll_data st_pll3200c32_407_a0 = {
 static const struct clkgen_pll_data st_pll3200c32_407_c0_0 = {
 	/* 407 C0 PLL0 */
 	.pdn_status	= CLKGEN_FIELD(0x2a0,	0x1,			8),
+	.pdn_ctrl	= CLKGEN_FIELD(0x2a0,	0x1,			8),
 	.locked_status	= CLKGEN_FIELD(0x2a0,	0x1,			24),
 	.ndiv		= CLKGEN_FIELD(0x2a4,	C32_NDIV_MASK,		16),
 	.idf		= CLKGEN_FIELD(0x2a4,	C32_IDF_MASK,		0x0),
@@ -207,6 +220,7 @@ static const struct clkgen_pll_data st_pll3200c32_407_c0_0 = {
 static const struct clkgen_pll_data st_pll3200c32_407_c0_1 = {
 	/* 407 C0 PLL1 */
 	.pdn_status	= CLKGEN_FIELD(0x2c8,	0x1,			8),
+	.pdn_ctrl	= CLKGEN_FIELD(0x2c8,	0x1,			8),
 	.locked_status	= CLKGEN_FIELD(0x2c8,	0x1,			24),
 	.ndiv		= CLKGEN_FIELD(0x2cc,	C32_NDIV_MASK,		16),
 	.idf		= CLKGEN_FIELD(0x2cc,	C32_IDF_MASK,		0x0),
@@ -219,6 +233,7 @@ static const struct clkgen_pll_data st_pll3200c32_407_c0_1 = {
 static const struct clkgen_pll_data st_pll3200c32_407_a9 = {
 	/* 407 A9 */
 	.pdn_status	= CLKGEN_FIELD(0x1a8,	0x1,			0),
+	.pdn_ctrl	= CLKGEN_FIELD(0x1a8,	0x1,			0),
 	.locked_status	= CLKGEN_FIELD(0x87c,	0x1,			0),
 	.ndiv		= CLKGEN_FIELD(0x1b0,	C32_NDIV_MASK,		0),
 	.idf		= CLKGEN_FIELD(0x1a8,	C32_IDF_MASK,		25),
@@ -270,6 +285,73 @@ static int clkgen_pll_is_enabled(struct clk_hw *hw)
 	return !poweroff;
 }
 
+static int __clkgen_pll_enable(struct clk_hw *hw)
+{
+	struct clkgen_pll *pll = to_clkgen_pll(hw);
+	unsigned long timeout;
+	int ret = 0;
+
+	if (clkgen_pll_is_enabled(hw))
+		return 0;
+
+	CLKGEN_WRITE(pll, pdn_ctrl, 0);
+
+	timeout = jiffies + msecs_to_jiffies(10);
+
+	while (!clkgen_pll_is_locked(hw)) {
+		if (time_after(jiffies, timeout))
+			return -ETIMEDOUT;
+		cpu_relax();
+	}
+
+	pr_debug("%s:%s enabled\n", __clk_get_name(hw->clk), __func__);
+
+	return ret;
+}
+
+static int clkgen_pll_enable(struct clk_hw *hw)
+{
+	struct clkgen_pll *pll = to_clkgen_pll(hw);
+	unsigned long flags = 0;
+	int ret = 0;
+
+	if (pll->lock)
+		spin_lock_irqsave(pll->lock, flags);
+
+	ret = __clkgen_pll_enable(hw);
+
+	if (pll->lock)
+		spin_unlock_irqrestore(pll->lock, flags);
+
+	return ret;
+}
+
+static void __clkgen_pll_disable(struct clk_hw *hw)
+{
+	struct clkgen_pll *pll = to_clkgen_pll(hw);
+
+	if (!clkgen_pll_is_enabled(hw))
+		return;
+
+	CLKGEN_WRITE(pll, pdn_ctrl, 1);
+
+	pr_debug("%s:%s disabled\n", __clk_get_name(hw->clk), __func__);
+}
+
+static void clkgen_pll_disable(struct clk_hw *hw)
+{
+	struct clkgen_pll *pll = to_clkgen_pll(hw);
+	unsigned long flags = 0;
+
+	if (pll->lock)
+		spin_lock_irqsave(pll->lock, flags);
+
+	__clkgen_pll_disable(hw);
+
+	if (pll->lock)
+		spin_unlock_irqrestore(pll->lock, flags);
+}
+
 static unsigned long recalc_stm_pll800c65(struct clk_hw *hw,
 		unsigned long parent_rate)
 {
@@ -371,21 +453,29 @@ static unsigned long recalc_stm_pll1200c32(struct clk_hw *hw,
 }
 
 static const struct clk_ops st_pll1600c65_ops = {
+	.enable		= clkgen_pll_enable,
+	.disable	= clkgen_pll_disable,
 	.is_enabled	= clkgen_pll_is_enabled,
 	.recalc_rate	= recalc_stm_pll1600c65,
 };
 
 static const struct clk_ops st_pll800c65_ops = {
+	.enable		= clkgen_pll_enable,
+	.disable	= clkgen_pll_disable,
 	.is_enabled	= clkgen_pll_is_enabled,
 	.recalc_rate	= recalc_stm_pll800c65,
 };
 
 static const struct clk_ops stm_pll3200c32_ops = {
+	.enable		= clkgen_pll_enable,
+	.disable	= clkgen_pll_disable,
 	.is_enabled	= clkgen_pll_is_enabled,
 	.recalc_rate	= recalc_stm_pll3200c32,
 };
 
 static const struct clk_ops st_pll1200c32_ops = {
+	.enable		= clkgen_pll_enable,
+	.disable	= clkgen_pll_disable,
 	.is_enabled	= clkgen_pll_is_enabled,
 	.recalc_rate	= recalc_stm_pll1200c32,
 };
@@ -413,6 +503,7 @@ static struct clk * __init clkgen_pll_register(const char *parent_name,
 	pll->data = pll_data;
 	pll->regs_base = reg;
 	pll->hw.init = &init;
+	pll->lock = lock;
 
 	clk = clk_register(NULL, &pll->hw);
 	if (IS_ERR(clk)) {
-- 
1.9.1
