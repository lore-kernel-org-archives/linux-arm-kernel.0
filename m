From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  7 Oct 2016 00:06:23 +0800
Subject: [PATCH 3/9] drm/sun4i: Put dotclock range into tcon quirks and check
 against them
In-Reply-To: <20161006160629.11198-1-wens@csie.org>
References: <20161006160629.11198-1-wens@csie.org>
Message-ID: <20161006160629.11198-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit bb43d40d7c83 ("drm/sun4i: rgb: Validate the clock rate") the
driver was rounding the requested clock rate and then checking the
result against the original requested rate.

This does not work well for a number of reasons:

  - The pixel clock does not have enough resolution to be able to
    provide all sub-MHz clock rates. This makes it filter out most modes
    found in simple-panel.

  - When first introduced, the main limiting factors were the video PLL
    clock range (27 ~ 381 MHz) and the lowest divider (6). On sun6i and
    later, the valid PLL clock range is extended to 30 ~ 600 MHz. The
    PLL's multiplier and divider can make it go much higher out of range,
    but the clock driver currently has no checks for it.

Since the limits are well known, we can hard code the range into the
tcon driver, and check against them. And we really only care about the
upper limit, which affects the highest resolutions we can support.

Fixes: bb43d40d7c83 ("drm/sun4i: rgb: Validate the clock rate")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_rgb.c  | 8 +-------
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 ++
 drivers/gpu/drm/sun4i/sun4i_tcon.h | 1 +
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index 8b520d9f5bd9..edbb42ead1f1 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -60,8 +60,6 @@ static int sun4i_rgb_mode_valid(struct drm_connector *connector,
 	struct sun4i_tcon *tcon = drv->tcon;
 	u32 hsync = mode->hsync_end - mode->hsync_start;
 	u32 vsync = mode->vsync_end - mode->vsync_start;
-	unsigned long rate = mode->clock * 1000;
-	long rounded_rate;
 
 	DRM_DEBUG_DRIVER("Validating modes...\n");
 
@@ -93,11 +91,7 @@ static int sun4i_rgb_mode_valid(struct drm_connector *connector,
 
 	DRM_DEBUG_DRIVER("Vertical parameters OK\n");
 
-	rounded_rate = clk_round_rate(tcon->dclk, rate);
-	if (rounded_rate < rate)
-		return MODE_CLOCK_LOW;
-
-	if (rounded_rate > rate)
+	if (mode->clock > tcon->quirks->max_clock)
 		return MODE_CLOCK_HIGH;
 
 	DRM_DEBUG_DRIVER("Clock rate OK\n");
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index c6c1c7ce94a1..5a5407193753 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -583,6 +583,7 @@ static int sun4i_tcon_remove(struct platform_device *pdev)
 }
 
 const struct sun4i_tcon_quirks sun5i_a13_quirks = {
+	.max_clock	= 63500,
 	.is_sun5i	= true,
 	.has_channel_1	= true,
 	.has_bypass_src	= true,
@@ -590,6 +591,7 @@ const struct sun4i_tcon_quirks sun5i_a13_quirks = {
 };
 
 const struct sun4i_tcon_quirks sun8i_a33_quirks = {
+	.max_clock	= 200000,
 	/* nothing is supported */
 };
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index 96c4f15c6922..972ca2b7c8c2 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -143,6 +143,7 @@
 #define SUN4I_TCON_MAX_CHANNELS		2
 
 struct sun4i_tcon_quirks {
+	int	max_clock;	/* Highest possible dotclock in kHz */
 	bool	is_sun5i;	/* sun5i has undocumented mux */
 	bool	has_channel_1;	/* a33 does not have channel 1 */
 	bool	has_bypass_src;	/* has separate input bypassing CEU */
-- 
2.9.3
