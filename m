From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Thu,  1 Mar 2018 22:34:27 +0100
Subject: [PATCH v3 01/16] clk: sunxi-ng: Add check for minimal rate to NM PLLs
In-Reply-To: <20180301213442.16677-1-jernej.skrabec@siol.net>
References: <20180301213442.16677-1-jernej.skrabec@siol.net>
Message-ID: <20180301213442.16677-2-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some NM PLLs doesn't work well when their output clock rate is set below
certain rate.

Add support for that constrain.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu_nm.c |  7 +++++++
 drivers/clk/sunxi-ng/ccu_nm.h | 27 +++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
index a16de092bf94..4e2073307f34 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.c
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -117,6 +117,13 @@ static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
 	if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate *= nm->fixed_post_div;
 
+	if (rate < nm->min_rate) {
+		rate = nm->min_rate;
+		if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
+			rate /= nm->fixed_post_div;
+		return rate;
+	}
+
 	if (ccu_frac_helper_has_rate(&nm->common, &nm->frac, rate)) {
 		if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 			rate /= nm->fixed_post_div;
diff --git a/drivers/clk/sunxi-ng/ccu_nm.h b/drivers/clk/sunxi-ng/ccu_nm.h
index eba586b4c7d0..1d8b459c50b7 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.h
+++ b/drivers/clk/sunxi-ng/ccu_nm.h
@@ -37,6 +37,7 @@ struct ccu_nm {
 	struct ccu_sdm_internal		sdm;
 
 	unsigned int		fixed_post_div;
+	unsigned int		min_rate;
 
 	struct ccu_common	common;
 };
@@ -88,6 +89,32 @@ struct ccu_nm {
 		},							\
 	}
 
+#define SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN(_struct, _name, _parent,	\
+					     _reg, _min_rate,		\
+					     _nshift, _nwidth,		\
+					     _mshift, _mwidth,		\
+					     _frac_en, _frac_sel,	\
+					     _frac_rate_0, _frac_rate_1,\
+					     _gate, _lock, _flags)	\
+	struct ccu_nm _struct = {					\
+		.enable		= _gate,				\
+		.lock		= _lock,				\
+		.n		= _SUNXI_CCU_MULT(_nshift, _nwidth),	\
+		.m		= _SUNXI_CCU_DIV(_mshift, _mwidth),	\
+		.frac		= _SUNXI_CCU_FRAC(_frac_en, _frac_sel,	\
+						  _frac_rate_0,		\
+						  _frac_rate_1),	\
+		.min_rate	= _min_rate,				\
+		.common		= {					\
+			.reg		= _reg,				\
+			.features	= CCU_FEATURE_FRACTIONAL,	\
+			.hw.init	= CLK_HW_INIT(_name,		\
+						      _parent,		\
+						      &ccu_nm_ops,	\
+						      _flags),		\
+		},							\
+	}
+
 #define SUNXI_CCU_NM_WITH_GATE_LOCK(_struct, _name, _parent, _reg,	\
 				    _nshift, _nwidth,			\
 				    _mshift, _mwidth,			\
-- 
2.16.2
