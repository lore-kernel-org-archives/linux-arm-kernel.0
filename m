From: lori.hikichi@broadcom.com (Lori Hikichi)
Date: Mon, 14 Aug 2017 12:00:38 -0700
Subject: [PATCH v1 1/4] clk: iproc: Allow iproc pll to runtime calculate vco
 parameters
In-Reply-To: <1502737241-2040-1-git-send-email-lori.hikichi@broadcom.com>
References: <1502737241-2040-1-git-send-email-lori.hikichi@broadcom.com>
Message-ID: <1502737241-2040-2-git-send-email-lori.hikichi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the ability for the iproc pll to calculate the pll parameters at
runtime instead of only using predefined tables. This ability allows
the clock users to select from the full range of vco frequencies.
The old method of table based programming is retained so that existing
users will retain expected behavior. The flag IPROC_CLK_PLL_CALC_PARAM
will need to be set to enable the new runtime calculation method.
Currently, this is only being enabled for the audio pll.

This feature also revealed a problem with the driver using the
round_rate api.  The round_rate api does not allow for frequencies larger
than 2^31 to be returned.  Those large frequencies are interpreted as an
error code. Therefore, we are moving to the determine_rate api which
solves this problem.

Signed-off-by: Simran Rai <ssimran@broadcom.com>
Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
---
 drivers/clk/bcm/clk-cygnus.c    | 25 +++--------
 drivers/clk/bcm/clk-iproc-pll.c | 97 ++++++++++++++++++++++++++++++++++-------
 drivers/clk/bcm/clk-iproc.h     |  5 +++
 3 files changed, 92 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/bcm/clk-cygnus.c b/drivers/clk/bcm/clk-cygnus.c
index 464fdc4..b8d073e 100644
--- a/drivers/clk/bcm/clk-cygnus.c
+++ b/drivers/clk/bcm/clk-cygnus.c
@@ -269,23 +269,10 @@ static void __init cygnus_asiu_init(struct device_node *node)
 }
 CLK_OF_DECLARE(cygnus_asiu_clk, "brcm,cygnus-asiu-clk", cygnus_asiu_init);
 
-/*
- * AUDIO PLL VCO frequency parameter table
- *
- * PLL output frequency = ((ndiv_int + ndiv_frac / 2^20) *
- * (parent clock rate / pdiv)
- *
- * On Cygnus, parent is the 25MHz oscillator
- */
-static const struct iproc_pll_vco_param audiopll_vco_params[] = {
-	/* rate (Hz) ndiv_int ndiv_frac pdiv */
-	{ 1354750204UL,  54,     199238,   1 },
-	{ 1769470191UL,  70,     816639,   1 },
-};
-
 static const struct iproc_pll_ctrl audiopll = {
 	.flags = IPROC_CLK_PLL_NEEDS_SW_CFG | IPROC_CLK_PLL_HAS_NDIV_FRAC |
-		IPROC_CLK_PLL_USER_MODE_ON | IPROC_CLK_PLL_RESET_ACTIVE_LOW,
+		IPROC_CLK_PLL_USER_MODE_ON | IPROC_CLK_PLL_RESET_ACTIVE_LOW |
+		IPROC_CLK_PLL_CALC_PARAM,
 	.reset = RESET_VAL(0x5c, 0, 1),
 	.dig_filter = DF_VAL(0x48, 0, 3, 6, 4, 3, 3),
 	.sw_ctrl = SW_CTRL_VAL(0x4, 0),
@@ -300,8 +287,7 @@ static void __init cygnus_asiu_init(struct device_node *node)
 static const struct iproc_clk_ctrl audiopll_clk[] = {
 	[BCM_CYGNUS_AUDIOPLL_CH0] = {
 		.channel = BCM_CYGNUS_AUDIOPLL_CH0,
-		.flags = IPROC_CLK_AON |
-				IPROC_CLK_MCLK_DIV_BY_2,
+		.flags = IPROC_CLK_AON | IPROC_CLK_MCLK_DIV_BY_2,
 		.enable = ENABLE_VAL(0x14, 8, 10, 9),
 		.mdiv = REG_VAL(0x14, 0, 8),
 	},
@@ -321,9 +307,8 @@ static void __init cygnus_asiu_init(struct device_node *node)
 
 static void __init cygnus_audiopll_clk_init(struct device_node *node)
 {
-	iproc_pll_clk_setup(node, &audiopll, audiopll_vco_params,
-			    ARRAY_SIZE(audiopll_vco_params), audiopll_clk,
-			    ARRAY_SIZE(audiopll_clk));
+	iproc_pll_clk_setup(node, &audiopll, NULL, 0,
+			    audiopll_clk,  ARRAY_SIZE(audiopll_clk));
 }
 CLK_OF_DECLARE(cygnus_audiopll, "brcm,cygnus-audiopll",
 			cygnus_audiopll_clk_init);
diff --git a/drivers/clk/bcm/clk-iproc-pll.c b/drivers/clk/bcm/clk-iproc-pll.c
index 375d8dd..9514ecf 100644
--- a/drivers/clk/bcm/clk-iproc-pll.c
+++ b/drivers/clk/bcm/clk-iproc-pll.c
@@ -95,6 +95,39 @@ struct iproc_pll {
 
 #define to_iproc_clk(hw) container_of(hw, struct iproc_clk, hw)
 
+static int pll_calc_param(unsigned long target_rate,
+			unsigned long parent_rate,
+			struct iproc_pll_vco_param *vco_out)
+{
+	u64 ndiv_int, ndiv_frac, residual;
+
+	ndiv_int = target_rate / parent_rate;
+
+	if (!ndiv_int || (ndiv_int > 255))
+		return -EINVAL;
+
+	residual = target_rate - (ndiv_int * parent_rate);
+	residual <<= 20;
+
+	/*
+	 * Add half of the divisor so the result will be rounded to closest
+	 * instead of rounded down.
+	 */
+	residual += (parent_rate / 2);
+	ndiv_frac = div64_u64((u64)residual, (u64)parent_rate);
+
+	vco_out->ndiv_int = ndiv_int;
+	vco_out->ndiv_frac = ndiv_frac;
+	vco_out->pdiv = 1;
+
+	vco_out->rate = vco_out->ndiv_int * parent_rate;
+	residual = (u64)vco_out->ndiv_frac * (u64)parent_rate;
+	residual >>= 20;
+	vco_out->rate += residual;
+
+	return 0;
+}
+
 /*
  * Based on the target frequency, find a match from the VCO frequency parameter
  * table and return its index
@@ -252,11 +285,10 @@ static void __pll_bring_out_reset(struct iproc_pll *pll, unsigned int kp,
 	iproc_pll_write(pll, pll->control_base, reset->offset, val);
 }
 
-static int pll_set_rate(struct iproc_clk *clk, unsigned int rate_index,
+static int pll_set_rate(struct iproc_clk *clk, struct iproc_pll_vco_param *vco,
 			unsigned long parent_rate)
 {
 	struct iproc_pll *pll = clk->pll;
-	const struct iproc_pll_vco_param *vco = &pll->vco_param[rate_index];
 	const struct iproc_pll_ctrl *ctrl = pll->ctrl;
 	int ka = 0, ki, kp, ret;
 	unsigned long rate = vco->rate;
@@ -431,25 +463,50 @@ static unsigned long iproc_pll_recalc_rate(struct clk_hw *hw,
 	return clk->rate;
 }
 
-static long iproc_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-				 unsigned long *parent_rate)
+static int iproc_pll_determine_rate(struct clk_hw *hw,
+		struct clk_rate_request *req)
 {
-	unsigned i;
+	unsigned int  i;
 	struct iproc_clk *clk = to_iproc_clk(hw);
 	struct iproc_pll *pll = clk->pll;
+	const struct iproc_pll_ctrl *ctrl = pll->ctrl;
+	unsigned long  diff, best_diff;
+	unsigned int  best_idx = 0;
+	int ret;
 
-	if (rate == 0 || *parent_rate == 0 || !pll->vco_param)
+	if (req->rate == 0 || req->best_parent_rate == 0)
 		return -EINVAL;
 
+	if (ctrl->flags & IPROC_CLK_PLL_CALC_PARAM) {
+		struct iproc_pll_vco_param vco_param;
+
+		ret = pll_calc_param(req->rate, req->best_parent_rate,
+					&vco_param);
+		if (ret)
+			return ret;
+
+		req->rate = vco_param.rate;
+		return 0;
+	}
+
+	if (!pll->vco_param)
+		return -EINVAL;
+
+	best_diff = ULONG_MAX;
 	for (i = 0; i < pll->num_vco_entries; i++) {
-		if (rate <= pll->vco_param[i].rate)
+		diff = abs(req->rate - pll->vco_param[i].rate);
+		if (diff <= best_diff) {
+			best_diff = diff;
+			best_idx = i;
+		}
+		/* break now if perfect match */
+		if (diff == 0)
 			break;
 	}
 
-	if (i == pll->num_vco_entries)
-		i--;
+	req->rate = pll->vco_param[best_idx].rate;
 
-	return pll->vco_param[i].rate;
+	return 0;
 }
 
 static int iproc_pll_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -457,13 +514,23 @@ static int iproc_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct iproc_clk *clk = to_iproc_clk(hw);
 	struct iproc_pll *pll = clk->pll;
+	const struct iproc_pll_ctrl *ctrl = pll->ctrl;
+	struct iproc_pll_vco_param vco_param;
 	int rate_index, ret;
 
-	rate_index = pll_get_rate_index(pll, rate);
-	if (rate_index < 0)
-		return rate_index;
+	if (ctrl->flags & IPROC_CLK_PLL_CALC_PARAM) {
+		ret = pll_calc_param(rate, parent_rate, &vco_param);
+		if (ret)
+			return ret;
+	} else {
+		rate_index = pll_get_rate_index(pll, rate);
+		if (rate_index < 0)
+			return rate_index;
+
+		vco_param = pll->vco_param[rate_index];
+	}
 
-	ret = pll_set_rate(clk, rate_index, parent_rate);
+	ret = pll_set_rate(clk, &vco_param, parent_rate);
 	return ret;
 }
 
@@ -471,7 +538,7 @@ static int iproc_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	.enable = iproc_pll_enable,
 	.disable = iproc_pll_disable,
 	.recalc_rate = iproc_pll_recalc_rate,
-	.round_rate = iproc_pll_round_rate,
+	.determine_rate = iproc_pll_determine_rate,
 	.set_rate = iproc_pll_set_rate,
 };
 
diff --git a/drivers/clk/bcm/clk-iproc.h b/drivers/clk/bcm/clk-iproc.h
index 2148b4e..a48ddd3 100644
--- a/drivers/clk/bcm/clk-iproc.h
+++ b/drivers/clk/bcm/clk-iproc.h
@@ -81,6 +81,11 @@
 #define IPROC_CLK_PLL_RESET_ACTIVE_LOW BIT(9)
 
 /*
+ * Calculate the PLL parameters are runtime, instead of using table
+ */
+#define IPROC_CLK_PLL_CALC_PARAM BIT(10)
+
+/*
  * Parameters for VCO frequency configuration
  *
  * VCO frequency =
-- 
1.9.1
