From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Thu,  9 Jul 2015 13:57:39 +0200
Subject: [PATCH 2/3] drivers: clk: st: PLL rate change implementation for DVFS
In-Reply-To: <1436443060-12866-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1436443060-12866-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1436443060-12866-3-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change A9 PLL rate, as per requirement from the cpufreq framework,
for DVFS. For rate change, the A9 clock needs to be temporarily sourced
from PLL external to A9 and then sourced back to A9-PLL

Signed-off-by: Pankaj Dev <pankaj.dev@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 drivers/clk/st/clkgen-mux.c |   3 +
 drivers/clk/st/clkgen-pll.c | 182 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/clk/st/clkgen.h     |   2 +
 3 files changed, 180 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/st/clkgen-mux.c b/drivers/clk/st/clkgen-mux.c
index 717c4a9..a75633b 100644
--- a/drivers/clk/st/clkgen-mux.c
+++ b/drivers/clk/st/clkgen-mux.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/of_address.h>
 #include <linux/clk-provider.h>
+#include "clkgen.h"
 
 static DEFINE_SPINLOCK(clkgena_divmux_lock);
 static DEFINE_SPINLOCK(clkgenf_lock);
@@ -575,6 +576,7 @@ static struct clkgen_mux_data stih415_a9_mux_data = {
 	.offset = 0,
 	.shift = 1,
 	.width = 2,
+	.lock = &clkgen_a9_lock,
 };
 static struct clkgen_mux_data stih416_a9_mux_data = {
 	.offset = 0,
@@ -585,6 +587,7 @@ static struct clkgen_mux_data stih407_a9_mux_data = {
 	.offset = 0x1a4,
 	.shift = 0,
 	.width = 2,
+	.lock = &clkgen_a9_lock,
 };
 
 static const struct of_device_id mux_of_match[] = {
diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
index bd2fcd3..04d66ee1d 100644
--- a/drivers/clk/st/clkgen-pll.c
+++ b/drivers/clk/st/clkgen-pll.c
@@ -21,6 +21,7 @@
 #include "clkgen.h"
 
 static DEFINE_SPINLOCK(clkgena_c32_odf_lock);
+DEFINE_SPINLOCK(clkgen_a9_lock);
 
 /*
  * Common PLL configuration register bits for PLL800 and PLL1600 C65
@@ -37,6 +38,7 @@ static DEFINE_SPINLOCK(clkgena_c32_odf_lock);
 #define C32_IDF_MASK (0x7)
 #define C32_ODF_MASK (0x3f)
 #define C32_LDF_MASK (0x7f)
+#define C32_CP_MASK (0x1f)
 
 #define C32_MAX_ODFS (4)
 
@@ -49,15 +51,20 @@ struct clkgen_pll_data {
 	struct clkgen_field pdiv;
 	struct clkgen_field idf;
 	struct clkgen_field ldf;
+	struct clkgen_field cp;
 	unsigned int num_odfs;
 	struct clkgen_field odf[C32_MAX_ODFS];
 	struct clkgen_field odf_gate[C32_MAX_ODFS];
+	bool switch2pll_en;
+	struct clkgen_field switch2pll;
+	spinlock_t *lock;
 	const struct clk_ops *ops;
 };
 
 static const struct clk_ops st_pll1600c65_ops;
 static const struct clk_ops st_pll800c65_ops;
 static const struct clk_ops stm_pll3200c32_ops;
+static const struct clk_ops stm_pll3200c32_a9_ops;
 static const struct clk_ops st_pll1200c32_ops;
 
 static const struct clkgen_pll_data st_pll1600c65_ax = {
@@ -240,7 +247,11 @@ static const struct clkgen_pll_data st_pll3200c32_407_a9 = {
 	.num_odfs = 1,
 	.odf		= { CLKGEN_FIELD(0x1b0, C32_ODF_MASK,		8) },
 	.odf_gate	= { CLKGEN_FIELD(0x1ac, 0x1,			28) },
-	.ops		= &stm_pll3200c32_ops,
+	.switch2pll_en	= true,
+	.cp		= CLKGEN_FIELD(0x1a8,	C32_CP_MASK,		1),
+	.switch2pll	= CLKGEN_FIELD(0x1a4,	0x1,			1),
+	.lock = &clkgen_a9_lock,
+	.ops		= &stm_pll3200c32_a9_ops,
 };
 
 /**
@@ -266,10 +277,26 @@ struct clkgen_pll {
 	struct clk_hw		hw;
 	struct clkgen_pll_data	*data;
 	void __iomem		*regs_base;
+	spinlock_t	*lock;
+
+	u32 ndiv;
+	u32 idf;
+	u32 odf;
+	u32 cp;
 };
 
 #define to_clkgen_pll(_hw) container_of(_hw, struct clkgen_pll, hw)
 
+struct stm_pll {
+	unsigned long mdiv;
+	unsigned long ndiv;
+	unsigned long pdiv;
+	unsigned long odf;
+	unsigned long idf;
+	unsigned long ldf;
+	unsigned long cp;
+};
+
 static int clkgen_pll_is_locked(struct clk_hw *hw)
 {
 	struct clkgen_pll *pll = to_clkgen_pll(hw);
@@ -304,6 +331,9 @@ static int __clkgen_pll_enable(struct clk_hw *hw)
 		cpu_relax();
 	}
 
+	if (pll->data->switch2pll_en)
+		CLKGEN_WRITE(pll, switch2pll, 0);
+
 	pr_debug("%s:%s enabled\n", __clk_get_name(hw->clk), __func__);
 
 	return ret;
@@ -333,6 +363,9 @@ static void __clkgen_pll_disable(struct clk_hw *hw)
 	if (!clkgen_pll_is_enabled(hw))
 		return;
 
+	if (pll->data->switch2pll_en)
+		CLKGEN_WRITE(pll, switch2pll, 1);
+
 	CLKGEN_WRITE(pll, pdn_ctrl, 1);
 
 	pr_debug("%s:%s disabled\n", __clk_get_name(hw->clk), __func__);
@@ -403,6 +436,67 @@ static unsigned long recalc_stm_pll1600c65(struct clk_hw *hw,
 	return rate;
 }
 
+static int clk_pll3200c32_get_params(unsigned long input, unsigned long output,
+			  struct stm_pll *pll)
+{
+	unsigned long i, n;
+	unsigned long deviation = ~0;
+	unsigned long new_freq;
+	long new_deviation;
+	/* Charge pump table: highest ndiv value for cp=6 to 25 */
+	static const unsigned char cp_table[] = {
+		48, 56, 64, 72, 80, 88, 96, 104, 112, 120,
+		128, 136, 144, 152, 160, 168, 176, 184, 192
+	};
+
+	/* Output clock range: 800Mhz to 1600Mhz */
+	if (output < 800000000 || output > 1600000000)
+		return -EINVAL;
+
+	input /= 1000;
+	output /= 1000;
+
+	for (i = 1; i <= 7 && deviation; i++) {
+		n = i * output / (2 * input);
+
+		/* Checks */
+		if (n < 8)
+			continue;
+		if (n > 200)
+			break;
+
+		new_freq = (input * 2 * n) / i;
+
+		new_deviation = abs(new_freq - output);
+
+		if (!new_deviation || new_deviation < deviation) {
+			pll->idf  = i;
+			pll->ndiv = n;
+			deviation = new_deviation;
+		}
+	}
+
+	if (deviation == ~0) /* No solution found */
+		return -EINVAL;
+
+	/* Computing recommended charge pump value */
+	for (pll->cp = 6; pll->ndiv > cp_table[pll->cp-6]; (pll->cp)++)
+		;
+
+	return 0;
+}
+
+static int clk_pll3200c32_get_rate(unsigned long input, struct stm_pll *pll,
+			unsigned long *rate)
+{
+	if (!pll->idf)
+		pll->idf = 1;
+
+	*rate = ((2 * (input / 1000) * pll->ndiv) / pll->idf) * 1000;
+
+	return 0;
+}
+
 static unsigned long recalc_stm_pll3200c32(struct clk_hw *hw,
 		unsigned long parent_rate)
 {
@@ -425,6 +519,70 @@ static unsigned long recalc_stm_pll3200c32(struct clk_hw *hw,
 	return rate;
 }
 
+static long round_rate_stm_pll3200c32(struct clk_hw *hw, unsigned long rate,
+		unsigned long *prate)
+{
+	struct stm_pll params;
+
+	if (!clk_pll3200c32_get_params(*prate, rate, &params))
+		clk_pll3200c32_get_rate(*prate, &params, &rate);
+	else {
+		pr_debug("%s: %s rate %ld Invalid\n", __func__,
+			 __clk_get_name(hw->clk), rate);
+		return 0;
+	}
+
+	pr_debug("%s: %s new rate %ld [ndiv=%u] [idf=%u]\n",
+		 __func__, __clk_get_name(hw->clk),
+		 rate, (unsigned int)params.ndiv,
+		 (unsigned int)params.idf);
+
+	return rate;
+}
+
+static int set_rate_stm_pll3200c32(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct clkgen_pll *pll = to_clkgen_pll(hw);
+	struct stm_pll params;
+	long hwrate = 0;
+	unsigned long flags = 0;
+
+	if (!rate || !parent_rate)
+		return -EINVAL;
+
+	if (!clk_pll3200c32_get_params(parent_rate, rate, &params))
+		clk_pll3200c32_get_rate(parent_rate, &params, &hwrate);
+
+	pr_debug("%s: %s new rate %ld [ndiv=0x%x] [idf=0x%x]\n",
+		 __func__, __clk_get_name(hw->clk),
+		 hwrate, (unsigned int)params.ndiv,
+		 (unsigned int)params.idf);
+
+	if (!hwrate)
+		return -EINVAL;
+
+	pll->ndiv = params.ndiv;
+	pll->idf = params.idf;
+	pll->cp = params.cp;
+
+	clkgen_pll_disable(hw);
+
+	if (pll->lock)
+		spin_lock_irqsave(pll->lock, flags);
+
+	CLKGEN_WRITE(pll, ndiv, pll->ndiv);
+	CLKGEN_WRITE(pll, idf, pll->idf);
+	CLKGEN_WRITE(pll, cp, pll->cp);
+
+	if (pll->lock)
+		spin_unlock_irqrestore(pll->lock, flags);
+
+	clkgen_pll_enable(hw);
+
+	return 0;
+}
+
 static unsigned long recalc_stm_pll1200c32(struct clk_hw *hw,
 		unsigned long parent_rate)
 {
@@ -473,6 +631,15 @@ static const struct clk_ops stm_pll3200c32_ops = {
 	.recalc_rate	= recalc_stm_pll3200c32,
 };
 
+static const struct clk_ops stm_pll3200c32_a9_ops = {
+	.enable		= clkgen_pll_enable,
+	.disable	= clkgen_pll_disable,
+	.is_enabled	= clkgen_pll_is_enabled,
+	.recalc_rate	= recalc_stm_pll3200c32,
+	.round_rate	= round_rate_stm_pll3200c32,
+	.set_rate	= set_rate_stm_pll3200c32,
+};
+
 static const struct clk_ops st_pll1200c32_ops = {
 	.enable		= clkgen_pll_enable,
 	.disable	= clkgen_pll_disable,
@@ -483,7 +650,7 @@ static const struct clk_ops st_pll1200c32_ops = {
 static struct clk * __init clkgen_pll_register(const char *parent_name,
 				struct clkgen_pll_data	*pll_data,
 				void __iomem *reg,
-				const char *clk_name)
+				const char *clk_name, spinlock_t *lock)
 {
 	struct clkgen_pll *pll;
 	struct clk *clk;
@@ -590,7 +757,7 @@ static void __init clkgena_c65_pll_setup(struct device_node *np)
 	 */
 	clk_data->clks[0] = clkgen_pll_register(parent_name,
 			(struct clkgen_pll_data *) &st_pll1600c65_ax,
-			reg + CLKGENAx_PLL0_OFFSET, clk_name);
+			reg + CLKGENAx_PLL0_OFFSET, clk_name, NULL);
 
 	if (IS_ERR(clk_data->clks[0]))
 		goto err;
@@ -619,7 +786,7 @@ static void __init clkgena_c65_pll_setup(struct device_node *np)
 	 */
 	clk_data->clks[2] = clkgen_pll_register(parent_name,
 			(struct clkgen_pll_data *) &st_pll800c65_ax,
-			reg + CLKGENAx_PLL1_OFFSET, clk_name);
+			reg + CLKGENAx_PLL1_OFFSET, clk_name, NULL);
 
 	if (IS_ERR(clk_data->clks[2]))
 		goto err;
@@ -646,7 +813,7 @@ static struct clk * __init clkgen_odf_register(const char *parent_name,
 	struct clk_gate *gate;
 	struct clk_divider *div;
 
-	flags = CLK_GET_RATE_NOCACHE | CLK_SET_RATE_GATE;
+	flags = CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT;
 
 	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
 	if (!gate)
@@ -754,7 +921,8 @@ static void __init clkgen_c32_pll_setup(struct device_node *np)
 	if (!pll_base)
 		return;
 
-	clk = clkgen_pll_register(parent_name, data, pll_base, np->name);
+	clk = clkgen_pll_register(parent_name, data, pll_base, np->name,
+				  data->lock);
 	if (IS_ERR(clk))
 		return;
 
@@ -843,7 +1011,7 @@ static void __init clkgengpu_c32_pll_setup(struct device_node *np)
 	/*
 	 * PLL 1200MHz output
 	 */
-	clk = clkgen_pll_register(parent_name, data, reg, clk_name);
+	clk = clkgen_pll_register(parent_name, data, reg, clk_name, data->lock);
 
 	if (!IS_ERR(clk))
 		of_clk_add_provider(np, of_clk_src_simple_get, clk);
diff --git a/drivers/clk/st/clkgen.h b/drivers/clk/st/clkgen.h
index 35c8632..f7ec2d9 100644
--- a/drivers/clk/st/clkgen.h
+++ b/drivers/clk/st/clkgen.h
@@ -9,6 +9,8 @@ Copyright (C) 2014 STMicroelectronics
 #ifndef __CLKGEN_INFO_H
 #define __CLKGEN_INFO_H
 
+extern spinlock_t clkgen_a9_lock;
+
 struct clkgen_field {
 	unsigned int offset;
 	unsigned int mask;
-- 
1.9.1
