From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  5 Dec 2017 16:10:19 +0100
Subject: [PATCH v3 07/15] drm/sun4i: Create minimal multipliers and dividers
In-Reply-To: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
References: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
Message-ID: <42424895bd242dceeeeacf3f83e1c24aa03fb60f.1512486553.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The various outputs the TCON can provide have different constraints on the
dotclock divider. Let's make them configurable by the various mode_set
functions.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_dotclock.c | 10 +++++++---
 drivers/gpu/drm/sun4i/sun4i_tcon.c     |  2 ++
 drivers/gpu/drm/sun4i/sun4i_tcon.h     |  2 ++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_dotclock.c b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
index d401156490f3..023f39bda633 100644
--- a/drivers/gpu/drm/sun4i/sun4i_dotclock.c
+++ b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
@@ -17,8 +17,9 @@
 #include "sun4i_dotclock.h"
 
 struct sun4i_dclk {
-	struct clk_hw	hw;
-	struct regmap	*regmap;
+	struct clk_hw		hw;
+	struct regmap		*regmap;
+	struct sun4i_tcon	*tcon;
 };
 
 static inline struct sun4i_dclk *hw_to_dclk(struct clk_hw *hw)
@@ -73,11 +74,13 @@ static unsigned long sun4i_dclk_recalc_rate(struct clk_hw *hw,
 static long sun4i_dclk_round_rate(struct clk_hw *hw, unsigned long rate,
 				  unsigned long *parent_rate)
 {
+	struct sun4i_dclk *dclk = hw_to_dclk(hw);
+	struct sun4i_tcon *tcon = dclk->tcon;
 	unsigned long best_parent = 0;
 	u8 best_div = 1;
 	int i;
 
-	for (i = 6; i <= 127; i++) {
+	for (i = tcon->dclk_min_div; i <= tcon->dclk_max_div; i++) {
 		unsigned long ideal = rate * i;
 		unsigned long rounded;
 
@@ -167,6 +170,7 @@ int sun4i_dclk_create(struct device *dev, struct sun4i_tcon *tcon)
 	dclk = devm_kzalloc(dev, sizeof(*dclk), GFP_KERNEL);
 	if (!dclk)
 		return -ENOMEM;
+	dclk->tcon = tcon;
 
 	init.name = clk_name;
 	init.ops = &sun4i_dclk_ops;
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index ea056a3d2131..46e28ca1f676 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -177,6 +177,8 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	u8 clk_delay;
 	u32 val = 0;
 
+	tcon->dclk_min_div = 6;
+	tcon->dclk_max_div = 127;
 	sun4i_tcon0_mode_set_common(tcon, mode);
 
 	/* Adjust clock delay */
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index 839266a38505..bd3ad7684870 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -169,6 +169,8 @@ struct sun4i_tcon {
 
 	/* Pixel clock */
 	struct clk			*dclk;
+	u8				dclk_max_div;
+	u8				dclk_min_div;
 
 	/* Reset control */
 	struct reset_control		*lcd_rst;
-- 
git-series 0.9.1
