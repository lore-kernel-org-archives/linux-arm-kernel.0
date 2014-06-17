From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Jun 2014 22:52:42 +0800
Subject: [PATCH v2 05/20] clk: sunxi: Support factor clocks with N multiplier
 factor starting from 1
In-Reply-To: <1403016777-15121-1-git-send-email-wens@csie.org>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
Message-ID: <1403016777-15121-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PLLs on newer Allwinner SoC's, such as the A31 and A23, have a
N multiplier factor that starts from 1, not 0.

This patch adds an option to the clock driver's config data structures
to define the difference.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-factors.c | 5 ++++-
 drivers/clk/sunxi/clk-factors.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index 3806d97..399cf4d 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -62,7 +62,10 @@ static unsigned long clk_factors_recalc_rate(struct clk_hw *hw,
 		p = FACTOR_GET(config->pshift, config->pwidth, reg);
 
 	/* Calculate the rate */
-	rate = (parent_rate * n * (k + 1) >> p) / (m + 1);
+	if (config->n_from_one)
+		rate = (parent_rate * (n + 1) * (k + 1) >> p) / (m + 1);
+	else
+		rate = (parent_rate * n * (k + 1) >> p) / (m + 1);
 
 	return rate;
 }
diff --git a/drivers/clk/sunxi/clk-factors.h b/drivers/clk/sunxi/clk-factors.h
index 02e1a43..0484a48 100644
--- a/drivers/clk/sunxi/clk-factors.h
+++ b/drivers/clk/sunxi/clk-factors.h
@@ -15,6 +15,7 @@ struct clk_factors_config {
 	u8 mwidth;
 	u8 pshift;
 	u8 pwidth;
+	u8 n_from_one;
 };
 
 struct clk_factors {
-- 
2.0.0
