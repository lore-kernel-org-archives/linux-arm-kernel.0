From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  7 Dec 2017 16:58:54 +0100
Subject: [PATCH v4 09/15] drm/sun4i: Add A83T support
In-Reply-To: <cover.e46a07c0e181d735c807dc94fe0ce0ea013788be.1512662253.git-series.maxime.ripard@free-electrons.com>
References: <cover.e46a07c0e181d735c807dc94fe0ce0ea013788be.1512662253.git-series.maxime.ripard@free-electrons.com>
Message-ID: <e508e91fa0683d30c3e98d37795a1f003c8c3e0c.1512662253.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the A83T display pipeline.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c   |  1 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c  |  5 +++++
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 11 +++++++++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 49215d91c853..6f5e721b545e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -347,6 +347,7 @@ static const struct of_device_id sun4i_drv_of_table[] = {
 	{ .compatible = "allwinner,sun6i-a31s-display-engine" },
 	{ .compatible = "allwinner,sun7i-a20-display-engine" },
 	{ .compatible = "allwinner,sun8i-a33-display-engine" },
+	{ .compatible = "allwinner,sun8i-a83t-display-engine" },
 	{ .compatible = "allwinner,sun8i-v3s-display-engine" },
 	{ }
 };
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 777c7348d0cf..a0f651d2a495 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -1136,6 +1136,10 @@ static const struct sun4i_tcon_quirks sun8i_a33_quirks = {
 	.has_lvds_pll		= true,
 };
 
+static const struct sun4i_tcon_quirks sun8i_a83t_lcd_quirks = {
+	/* nothing is supported */
+};
+
 static const struct sun4i_tcon_quirks sun8i_v3s_quirks = {
 	/* nothing is supported */
 };
@@ -1148,6 +1152,7 @@ const struct of_device_id sun4i_tcon_of_table[] = {
 	{ .compatible = "allwinner,sun6i-a31s-tcon", .data = &sun6i_a31s_quirks },
 	{ .compatible = "allwinner,sun7i-a20-tcon", .data = &sun7i_a20_quirks },
 	{ .compatible = "allwinner,sun8i-a33-tcon", .data = &sun8i_a33_quirks },
+	{ .compatible = "allwinner,sun8i-a83t-tcon-lcd", .data = &sun8i_a83t_lcd_quirks },
 	{ .compatible = "allwinner,sun8i-v3s-tcon", .data = &sun8i_v3s_quirks },
 	{ }
 };
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index ff235e3228ce..1c963b5af522 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -477,6 +477,13 @@ static int sun8i_mixer_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct sun8i_mixer_cfg sun8i_a83t_mixer0_cfg = {
+	.ccsc		= 0,
+	.scaler_mask	= 0xf,
+	.ui_num		= 3,
+	.vi_num		= 1,
+};
+
 static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
 	.vi_num = 2,
 	.ui_num = 1,
@@ -487,6 +494,10 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
 
 static const struct of_device_id sun8i_mixer_of_table[] = {
 	{
+		.compatible = "allwinner,sun8i-a83t-de2-mixer-0",
+		.data = &sun8i_a83t_mixer0_cfg,
+	},
+	{
 		.compatible = "allwinner,sun8i-v3s-de2-mixer",
 		.data = &sun8i_v3s_mixer_cfg,
 	},
-- 
git-series 0.9.1
