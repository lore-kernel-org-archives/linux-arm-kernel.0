From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 12 Oct 2017 16:37:00 +0800
Subject: [PATCH 4/9] clk: sunxi-ng: nm: Add support for sigma-delta modulation
In-Reply-To: <20171012083705.24409-1-wens@csie.org>
References: <20171012083705.24409-1-wens@csie.org>
Message-ID: <20171012083705.24409-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the N-M-style clocks, namely the PLLs, support sigma-delta
modulation to do fractional-N frequency synthesis. This is used in
the audio PLL to generate the exact frequency the audio blocks need.
These frequencies can not be generated with integer N-M factors.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu_nm.c | 22 +++++++++++++++++++++-
 drivers/clk/sunxi-ng/ccu_nm.h | 25 +++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
index 84a5e7f17f6f..7620aa973a6e 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.c
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -90,6 +90,14 @@ static unsigned long ccu_nm_recalc_rate(struct clk_hw *hw,
 	if (!m)
 		m++;
 
+	if (ccu_sdm_helper_is_enabled(&nm->common, &nm->sdm)) {
+		unsigned long rate =
+			ccu_sdm_helper_read_rate(&nm->common, &nm->sdm,
+						 m, n);
+		if (rate)
+			return rate;
+	}
+
 	return parent_rate * n / m;
 }
 
@@ -102,6 +110,9 @@ static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
 	if (ccu_frac_helper_has_rate(&nm->common, &nm->frac, rate))
 		return rate;
 
+	if (ccu_sdm_helper_has_rate(&nm->common, &nm->sdm, rate))
+		return rate;
+
 	_nm.min_n = nm->n.min ?: 1;
 	_nm.max_n = nm->n.max ?: 1 << nm->n.width;
 	_nm.min_m = 1;
@@ -143,7 +154,16 @@ static int ccu_nm_set_rate(struct clk_hw *hw, unsigned long rate,
 	_nm.min_m = 1;
 	_nm.max_m = nm->m.max ?: 1 << nm->m.width;
 
-	ccu_nm_find_best(parent_rate, rate, &_nm);
+	if (ccu_sdm_helper_has_rate(&nm->common, &nm->sdm, rate)) {
+		ccu_sdm_helper_enable(&nm->common, &nm->sdm, rate);
+
+		/* Sigma delta modulation requires specific N and M factors */
+		ccu_sdm_helper_get_factors(&nm->common, &nm->sdm, rate,
+					   &_nm.m, &_nm.n);
+	} else {
+		ccu_sdm_helper_disable(&nm->common, &nm->sdm);
+		ccu_nm_find_best(parent_rate, rate, &_nm);
+	}
 
 	spin_lock_irqsave(nm->common.lock, flags);
 
diff --git a/drivers/clk/sunxi-ng/ccu_nm.h b/drivers/clk/sunxi-ng/ccu_nm.h
index e87fd186da78..c623b0c7a23c 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.h
+++ b/drivers/clk/sunxi-ng/ccu_nm.h
@@ -20,6 +20,7 @@
 #include "ccu_div.h"
 #include "ccu_frac.h"
 #include "ccu_mult.h"
+#include "ccu_sdm.h"
 
 /*
  * struct ccu_nm - Definition of an N-M clock
@@ -33,10 +34,34 @@ struct ccu_nm {
 	struct ccu_mult_internal	n;
 	struct ccu_div_internal		m;
 	struct ccu_frac_internal	frac;
+	struct ccu_sdm_internal		sdm;
 
 	struct ccu_common	common;
 };
 
+#define SUNXI_CCU_NM_WITH_SDM_GATE_LOCK(_struct, _name, _parent, _reg,	\
+					_nshift, _nwidth,		\
+					_mshift, _mwidth,		\
+					_sdm_table, _sdm_en,		\
+					_sdm_reg, _sdm_reg_en,		\
+					_gate, _lock, _flags)		\
+	struct ccu_nm _struct = {					\
+		.enable		= _gate,				\
+		.lock		= _lock,				\
+		.n		= _SUNXI_CCU_MULT(_nshift, _nwidth),	\
+		.m		= _SUNXI_CCU_DIV(_mshift, _mwidth),	\
+		.sdm		= _SUNXI_CCU_SDM(_sdm_table, _sdm_en,	\
+						 _sdm_reg, _sdm_reg_en),\
+		.common		= {					\
+			.reg		= _reg,				\
+			.features	= CCU_FEATURE_SIGMA_DELTA_MOD,	\
+			.hw.init	= CLK_HW_INIT(_name,		\
+						      _parent,		\
+						      &ccu_nm_ops,	\
+						      _flags),		\
+		},							\
+	}
+
 #define SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(_struct, _name, _parent, _reg,	\
 					 _nshift, _nwidth,		\
 					 _mshift, _mwidth,		\
-- 
2.14.2
