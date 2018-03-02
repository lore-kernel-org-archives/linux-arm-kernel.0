From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  2 Mar 2018 10:09:47 +0100
Subject: [PATCH 3/4] drm/pl111: Handle the RealView variant separately
In-Reply-To: <20180302090948.6399-1-linus.walleij@linaro.org>
References: <20180302090948.6399-1-linus.walleij@linaro.org>
Message-ID: <20180302090948.6399-4-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to cut down the default bpp to 16 on the RealView so
we can have a 1024x768 framebuffer console by default. The
memory bandwidth limitations makes this not work with the
PL111 default of 32bpp.

This builds on top of the earlier patches making the
framebuffer default bpp a per-variant variable.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/pl111/pl111_versatile.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/pl111/pl111_versatile.c b/drivers/gpu/drm/pl111/pl111_versatile.c
index 9825f6d52788..f15391d994b6 100644
--- a/drivers/gpu/drm/pl111/pl111_versatile.c
+++ b/drivers/gpu/drm/pl111/pl111_versatile.c
@@ -230,6 +230,23 @@ static const u32 pl110_versatile_pixel_formats[] = {
 	DRM_FORMAT_XRGB1555,
 };
 
+static const u32 pl111_realview_pixel_formats[] = {
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_BGR565,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_ABGR1555,
+	DRM_FORMAT_XBGR1555,
+	DRM_FORMAT_ARGB1555,
+	DRM_FORMAT_XRGB1555,
+	DRM_FORMAT_ABGR4444,
+	DRM_FORMAT_XBGR4444,
+	DRM_FORMAT_ARGB4444,
+	DRM_FORMAT_XRGB4444,
+};
+
 /*
  * The Integrator variant is a PL110 with a bunch of broken, or not
  * yet implemented features
@@ -257,6 +274,18 @@ static const struct pl111_variant_data pl110_versatile = {
 	.fb_bpp = 16,
 };
 
+/*
+ * RealView PL111 variant, the only real difference from the vanilla
+ * PL111 is that we select 16bpp framebuffer by default to be able
+ * to get 1024x768 without saturating the memory bus.
+ */
+static const struct pl111_variant_data pl111_realview = {
+	.name = "PL111 RealView",
+	.formats = pl111_realview_pixel_formats,
+	.nformats = ARRAY_SIZE(pl111_realview_pixel_formats),
+	.fb_bpp = 16,
+};
+
 int pl111_versatile_init(struct device *dev, struct pl111_drm_dev_private *priv)
 {
 	const struct of_device_id *clcd_id;
@@ -306,6 +335,7 @@ int pl111_versatile_init(struct device *dev, struct pl111_drm_dev_private *priv)
 	case REALVIEW_CLCD_PBA8:
 	case REALVIEW_CLCD_PBX:
 		versatile_syscon_map = map;
+		priv->variant = &pl111_realview;
 		priv->variant_display_enable = pl111_realview_clcd_enable;
 		priv->variant_display_disable = pl111_realview_clcd_disable;
 		dev_info(dev, "set up callbacks for RealView PL111\n");
-- 
2.14.3
