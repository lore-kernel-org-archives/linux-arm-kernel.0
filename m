From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 14 Feb 2017 11:35:22 +0800
Subject: [PATCH 1/5] clk: sunxi-ng: mp: Adjust parent rate for pre-dividers
In-Reply-To: <20170214033526.16977-1-wens@csie.org>
References: <20170214033526.16977-1-wens@csie.org>
Message-ID: <20170214033526.16977-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MP style clocks support an mux with pre-dividers. While the driver
correctly accounted for them in the .determine_rate callback, it did
not in the .recalc_rate and .set_rate callbacks.

This means when calculating the factors in the .set_rate callback, they
would be off by a factor of the active pre-divider. Same goes for
reading back the clock rate after it is set.

Fixes: 2ab836db5097 ("clk: sunxi-ng: Add M-P factor clock support")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Maybe we want to Cc stable for this one?

 drivers/clk/sunxi-ng/ccu_mp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_mp.c b/drivers/clk/sunxi-ng/ccu_mp.c
index 22c2ca7a2a22..b583f186a804 100644
--- a/drivers/clk/sunxi-ng/ccu_mp.c
+++ b/drivers/clk/sunxi-ng/ccu_mp.c
@@ -85,6 +85,10 @@ static unsigned long ccu_mp_recalc_rate(struct clk_hw *hw,
 	unsigned int m, p;
 	u32 reg;
 
+	/* Adjust parent_rate according to pre-dividers */
+	ccu_mux_helper_adjust_parent_for_prediv(&cmp->common, &cmp->mux,
+						-1, &parent_rate);
+
 	reg = readl(cmp->common.base + cmp->common.reg);
 
 	m = reg >> cmp->m.shift;
@@ -117,6 +121,10 @@ static int ccu_mp_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned int m, p;
 	u32 reg;
 
+	/* Adjust parent_rate according to pre-dividers */
+	ccu_mux_helper_adjust_parent_for_prediv(&cmp->common, &cmp->mux,
+						-1, &parent_rate);
+
 	max_m = cmp->m.max ?: 1 << cmp->m.width;
 	max_p = cmp->p.max ?: 1 << ((1 << cmp->p.width) - 1);
 
-- 
2.11.0
