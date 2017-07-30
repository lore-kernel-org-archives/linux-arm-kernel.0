From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sun, 30 Jul 2017 18:41:50 +0200
Subject: [PATCH 4/4] clk: sunxi-ng: Wait for lock when using fractional mode
In-Reply-To: <20170730164150.26302-1-jernej.skrabec@siol.net>
References: <20170730164150.26302-1-jernej.skrabec@siol.net>
Message-ID: <20170730164150.26302-5-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently ccu_frac_helper_set_rate() doesn't wait for a lock bit to be
set before returning. Because of that, unstable clock may be used.

Add a wait for lock in the helper function.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu_frac.c | 4 +++-
 drivers/clk/sunxi-ng/ccu_frac.h | 2 +-
 drivers/clk/sunxi-ng/ccu_mult.c | 3 ++-
 drivers/clk/sunxi-ng/ccu_nm.c   | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_frac.c b/drivers/clk/sunxi-ng/ccu_frac.c
index ff9e72dc5337..d1d168d4c4f0 100644
--- a/drivers/clk/sunxi-ng/ccu_frac.c
+++ b/drivers/clk/sunxi-ng/ccu_frac.c
@@ -85,7 +85,7 @@ unsigned long ccu_frac_helper_read_rate(struct ccu_common *common,
 
 int ccu_frac_helper_set_rate(struct ccu_common *common,
 			     struct ccu_frac_internal *cf,
-			     unsigned long rate)
+			     unsigned long rate, u32 lock)
 {
 	unsigned long flags;
 	u32 reg, sel;
@@ -106,5 +106,7 @@ int ccu_frac_helper_set_rate(struct ccu_common *common,
 	writel(reg | sel, common->base + common->reg);
 	spin_unlock_irqrestore(common->lock, flags);
 
+	ccu_helper_wait_for_lock(common, lock);
+
 	return 0;
 }
diff --git a/drivers/clk/sunxi-ng/ccu_frac.h b/drivers/clk/sunxi-ng/ccu_frac.h
index 7b1ee380156f..efe2dd6bac01 100644
--- a/drivers/clk/sunxi-ng/ccu_frac.h
+++ b/drivers/clk/sunxi-ng/ccu_frac.h
@@ -48,6 +48,6 @@ unsigned long ccu_frac_helper_read_rate(struct ccu_common *common,
 
 int ccu_frac_helper_set_rate(struct ccu_common *common,
 			     struct ccu_frac_internal *cf,
-			     unsigned long rate);
+			     unsigned long rate, u32 lock);
 
 #endif /* _CCU_FRAC_H_ */
diff --git a/drivers/clk/sunxi-ng/ccu_mult.c b/drivers/clk/sunxi-ng/ccu_mult.c
index ee5e96222cb2..12e0783caee6 100644
--- a/drivers/clk/sunxi-ng/ccu_mult.c
+++ b/drivers/clk/sunxi-ng/ccu_mult.c
@@ -114,7 +114,8 @@ static int ccu_mult_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (ccu_frac_helper_has_rate(&cm->common, &cm->frac, rate)) {
 		ccu_frac_helper_enable(&cm->common, &cm->frac);
 
-		return ccu_frac_helper_set_rate(&cm->common, &cm->frac, rate);
+		return ccu_frac_helper_set_rate(&cm->common, &cm->frac,
+						rate, cm->lock);
 	} else {
 		ccu_frac_helper_disable(&cm->common, &cm->frac);
 	}
diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
index c6ba866b99d3..a32158e8f2e3 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.c
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -129,7 +129,8 @@ static int ccu_nm_set_rate(struct clk_hw *hw, unsigned long rate,
 
 		ccu_frac_helper_enable(&nm->common, &nm->frac);
 
-		return ccu_frac_helper_set_rate(&nm->common, &nm->frac, rate);
+		return ccu_frac_helper_set_rate(&nm->common, &nm->frac,
+						rate, nm->lock);
 	} else {
 		ccu_frac_helper_disable(&nm->common, &nm->frac);
 	}
-- 
2.13.3
