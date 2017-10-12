From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 12 Oct 2017 16:36:58 +0800
Subject: [PATCH 2/9] clk: sunxi-ng: nm: Check if requested rate is supported
 by fractional clock
In-Reply-To: <20171012083705.24409-1-wens@csie.org>
References: <20171012083705.24409-1-wens@csie.org>
Message-ID: <20171012083705.24409-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The round_rate callback for N-M-factor style clocks does not check if
the requested clock rate is supported by the fractional clock mode.
While this doesn't affect usage in practice, since the clock rates
are also supported through N-M factors, it does not match the set_rate
code.

Add a check to the round_rate callback so it matches the set_rate
callback.

Fixes: 6174a1e24b0d ("clk: sunxi-ng: Add N-M-factor clock support")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu_nm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
index a32158e8f2e3..84a5e7f17f6f 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.c
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -99,6 +99,9 @@ static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
 	struct ccu_nm *nm = hw_to_ccu_nm(hw);
 	struct _ccu_nm _nm;
 
+	if (ccu_frac_helper_has_rate(&nm->common, &nm->frac, rate))
+		return rate;
+
 	_nm.min_n = nm->n.min ?: 1;
 	_nm.max_n = nm->n.max ?: 1 << nm->n.width;
 	_nm.min_m = 1;
-- 
2.14.2
