From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 26 Jul 2016 15:04:28 +0800
Subject: [PATCH 6/9] clk: sunxi-ng: nkm: Add mux to support multiple parents
In-Reply-To: <1469516671-19377-1-git-send-email-wens@csie.org>
References: <1469516671-19377-1-git-send-email-wens@csie.org>
Message-ID: <1469516671-19377-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MIPI mode of the MIPI-PLL on A31 is an NKM-style PLL with 2
selectable parents.

Add mux support to the NKM clock.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu_nkm.c | 40 ++++++++++++++++++++++++++++++++++------
 drivers/clk/sunxi-ng/ccu_nkm.h | 23 +++++++++++++++++++++++
 2 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index 2071822b1e9c..182452919ede 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -93,19 +93,30 @@ static unsigned long ccu_nkm_recalc_rate(struct clk_hw *hw,
 	return parent_rate * (n + 1) * (k + 1) / (m + 1);
 }
 
-static long ccu_nkm_round_rate(struct clk_hw *hw, unsigned long rate,
-			      unsigned long *parent_rate)
+static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
+					unsigned long parent_rate,
+					unsigned long rate,
+					void *data)
 {
-	struct ccu_nkm *nkm = hw_to_ccu_nkm(hw);
+	struct ccu_nkm *nkm = data;
 	struct _ccu_nkm _nkm;
 
 	_nkm.max_n = 1 << nkm->n.width;
 	_nkm.max_k = 1 << nkm->k.width;
 	_nkm.max_m = 1 << nkm->m.width;
 
-	ccu_nkm_find_best(*parent_rate, rate, &_nkm);
+	ccu_nkm_find_best(parent_rate, rate, &_nkm);
 
-	return *parent_rate * _nkm.n * _nkm.k / _nkm.m;
+	return parent_rate * _nkm.n * _nkm.k / _nkm.m;
+}
+
+static int ccu_nkm_determine_rate(struct clk_hw *hw,
+				  struct clk_rate_request *req)
+{
+	struct ccu_nkm *nkm = hw_to_ccu_nkm(hw);
+
+	return ccu_mux_helper_determine_rate(&nkm->common, &nkm->mux,
+					     req, ccu_nkm_round_rate, nkm);
 }
 
 static int ccu_nkm_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -142,12 +153,29 @@ static int ccu_nkm_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
+static u8 ccu_nkm_get_parent(struct clk_hw *hw)
+{
+	struct ccu_nkm *nkm = hw_to_ccu_nkm(hw);
+
+	return ccu_mux_helper_get_parent(&nkm->common, &nkm->mux);
+}
+
+static int ccu_nkm_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct ccu_nkm *nkm = hw_to_ccu_nkm(hw);
+
+	return ccu_mux_helper_set_parent(&nkm->common, &nkm->mux, index);
+}
+
 const struct clk_ops ccu_nkm_ops = {
 	.disable	= ccu_nkm_disable,
 	.enable		= ccu_nkm_enable,
 	.is_enabled	= ccu_nkm_is_enabled,
 
+	.get_parent	= ccu_nkm_get_parent,
+	.set_parent	= ccu_nkm_set_parent,
+
+	.determine_rate	= ccu_nkm_determine_rate,
 	.recalc_rate	= ccu_nkm_recalc_rate,
-	.round_rate	= ccu_nkm_round_rate,
 	.set_rate	= ccu_nkm_set_rate,
 };
diff --git a/drivers/clk/sunxi-ng/ccu_nkm.h b/drivers/clk/sunxi-ng/ccu_nkm.h
index 1936ac1c6b37..fcb152fc4eda 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.h
+++ b/drivers/clk/sunxi-ng/ccu_nkm.h
@@ -32,10 +32,33 @@ struct ccu_nkm {
 	struct _ccu_mult	n;
 	struct _ccu_mult	k;
 	struct _ccu_div		m;
+	struct ccu_mux_internal	mux;
 
 	struct ccu_common	common;
 };
 
+#define SUNXI_CCU_NKM_WITH_MUX_GATE_LOCK(_struct, _name, _parents, _reg, \
+					 _nshift, _nwidth,		\
+					 _kshift, _kwidth,		\
+					 _mshift, _mwidth,		\
+					 _muxshift, _muxwidth,		\
+					 _gate, _lock, _flags)		\
+	struct ccu_nkm _struct = {					\
+		.enable		= _gate,				\
+		.lock		= _lock,				\
+		.k		= _SUNXI_CCU_MULT(_kshift, _kwidth),	\
+		.n		= _SUNXI_CCU_MULT(_nshift, _nwidth),	\
+		.m		= _SUNXI_CCU_DIV(_mshift, _mwidth),	\
+		.mux		= SUNXI_CLK_MUX(_muxshift, _muxwidth),	\
+		.common		= {					\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT_PARENTS(_name,	\
+						      _parents,		\
+						      &ccu_nkm_ops,	\
+						      _flags),		\
+		},							\
+	}
+
 #define SUNXI_CCU_NKM_WITH_GATE_LOCK(_struct, _name, _parent, _reg,	\
 				     _nshift, _nwidth,			\
 				     _kshift, _kwidth,			\
-- 
2.8.1
