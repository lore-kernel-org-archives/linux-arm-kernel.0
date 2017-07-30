From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sun, 30 Jul 2017 18:41:48 +0200
Subject: [PATCH 2/4] clk: sunxi-ng: multiplier: Fix fractional mode
In-Reply-To: <20170730164150.26302-1-jernej.skrabec@siol.net>
References: <20170730164150.26302-1-jernej.skrabec@siol.net>
Message-ID: <20170730164150.26302-3-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver for multiplier clock is missing a call to
ccu_frac_helper_enable() when fractional mode is selected.

Add a call to ccu_frac_helper_enable().

Fixes: d77e8135b340 ("clk: sunxi-ng: multiplier: Add fractional support")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu_mult.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mult.c b/drivers/clk/sunxi-ng/ccu_mult.c
index 20d0300867f2..ee5e96222cb2 100644
--- a/drivers/clk/sunxi-ng/ccu_mult.c
+++ b/drivers/clk/sunxi-ng/ccu_mult.c
@@ -111,10 +111,13 @@ static int ccu_mult_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long flags;
 	u32 reg;
 
-	if (ccu_frac_helper_has_rate(&cm->common, &cm->frac, rate))
+	if (ccu_frac_helper_has_rate(&cm->common, &cm->frac, rate)) {
+		ccu_frac_helper_enable(&cm->common, &cm->frac);
+
 		return ccu_frac_helper_set_rate(&cm->common, &cm->frac, rate);
-	else
+	} else {
 		ccu_frac_helper_disable(&cm->common, &cm->frac);
+	}
 
 	parent_rate = ccu_mux_helper_apply_prediv(&cm->common, &cm->mux, -1,
 						  parent_rate);
-- 
2.13.3
