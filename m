From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Sep 2016 23:14:00 +0800
Subject: [PATCH 2/4] drm/sun4i: dotclock: Fix clock rate read back calcation
In-Reply-To: <20160915151402.15992-1-wens@csie.org>
References: <20160915151402.15992-1-wens@csie.org>
Message-ID: <20160915151402.15992-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When reading back the divider set in the register, we mask off the
bits that aren't part of the divider. Unfortunately the mask used
here was not converted from the field width.

Fix this by converting the field width to a proper bit mask.

Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_dotclock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_dotclock.c b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
index 4332da48b1b3..1b6c2253192e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_dotclock.c
+++ b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
@@ -62,7 +62,7 @@ static unsigned long sun4i_dclk_recalc_rate(struct clk_hw *hw,
 	regmap_read(dclk->regmap, SUN4I_TCON0_DCLK_REG, &val);
 
 	val >>= SUN4I_TCON0_DCLK_DIV_SHIFT;
-	val &= SUN4I_TCON0_DCLK_DIV_WIDTH;
+	val &= (1 << SUN4I_TCON0_DCLK_DIV_WIDTH) - 1;
 
 	if (!val)
 		val = 1;
-- 
2.9.3
