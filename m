From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Sep 2016 23:14:02 +0800
Subject: [PATCH 4/4] drm/sun4i: dotclock: Round to closest clock rate
In-Reply-To: <20160915151402.15992-1-wens@csie.org>
References: <20160915151402.15992-1-wens@csie.org>
Message-ID: <20160915151402.15992-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With display pixel clocks we want to have the closest possible clock
rate, to minimize timing and refresh rate skews. Whether the actual
clock rate is higher or lower than the requested rate is less important.

Also check candidates against the requested rate, rather than the
ideal parent rate, the varying dividers also influence the difference
between the requested rate and the rounded rate.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_dotclock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_dotclock.c b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
index 3eb99784f371..d401156490f3 100644
--- a/drivers/gpu/drm/sun4i/sun4i_dotclock.c
+++ b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
@@ -90,7 +90,8 @@ static long sun4i_dclk_round_rate(struct clk_hw *hw, unsigned long rate,
 			goto out;
 		}
 
-		if ((rounded < ideal) && (rounded > best_parent)) {
+		if (abs(rate - rounded / i) <
+		    abs(rate - best_parent / best_div)) {
 			best_parent = rounded;
 			best_div = i;
 		}
-- 
2.9.3
