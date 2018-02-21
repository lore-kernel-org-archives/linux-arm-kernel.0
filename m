From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 21 Feb 2018 13:57:02 +0100
Subject: [PATCH 2/3] drm/sun4i: rgb: Fix potential division by zero
In-Reply-To: <20180221125703.4595-1-maxime.ripard@bootlin.com>
References: <20180221125703.4595-1-maxime.ripard@bootlin.com>
Message-ID: <20180221125703.4595-2-maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the case where mode_valid callback of our RGB connector was called
before mode_set was being called, the range of dividers would not be set,
resulting in a division by zero later on in the clk_round_rate logic.

Set the range of dividers before calling clk_round_rate to fix this.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_rgb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index 832f8f9bc47f..b8da5a50a61d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -92,6 +92,8 @@ static int sun4i_rgb_mode_valid(struct drm_connector *connector,
 
 	DRM_DEBUG_DRIVER("Vertical parameters OK\n");
 
+	tcon->dclk_min_div = 6;
+	tcon->dclk_max_div = 127;
 	rounded_rate = clk_round_rate(tcon->dclk, rate);
 	if (rounded_rate < rate)
 		return MODE_CLOCK_LOW;
-- 
2.14.3
