From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  2 Mar 2018 10:09:45 +0100
Subject: [PATCH 1/4] drm/pl111: Make the default BPP a per-variant variable
In-Reply-To: <20180302090948.6399-1-linus.walleij@linaro.org>
References: <20180302090948.6399-1-linus.walleij@linaro.org>
Message-ID: <20180302090948.6399-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PL110, Integrator and Versatile boards strongly prefer to
use 16 BPP even if other modes are supported, both to keep down
memory consumption and also to easier find a good match to
supported resolutions with consideration taken to the memory
bandwidth of the platforms.

Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/pl111/pl111_drm.h       | 2 ++
 drivers/gpu/drm/pl111/pl111_drv.c       | 4 +++-
 drivers/gpu/drm/pl111/pl111_versatile.c | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/pl111/pl111_drm.h b/drivers/gpu/drm/pl111/pl111_drm.h
index 6d0e450e51b1..360fbdd2203c 100644
--- a/drivers/gpu/drm/pl111/pl111_drm.h
+++ b/drivers/gpu/drm/pl111/pl111_drm.h
@@ -43,6 +43,7 @@ struct drm_minor;
  * @broken_vblank: the vblank IRQ is broken on this variant
  * @formats: array of supported pixel formats on this variant
  * @nformats: the length of the array of supported pixel formats
+ * @fb_bpp: desired bits per pixel on the default framebuffer
  */
 struct pl111_variant_data {
 	const char *name;
@@ -52,6 +53,7 @@ struct pl111_variant_data {
 	bool broken_vblank;
 	const u32 *formats;
 	unsigned int nformats;
+	unsigned int fb_bpp;
 };
 
 struct pl111_drm_dev_private {
diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index 1231905150d0..73d252351438 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -192,7 +192,7 @@ static int pl111_modeset_init(struct drm_device *dev)
 
 	drm_mode_config_reset(dev);
 
-	drm_fb_cma_fbdev_init(dev, 32, 0);
+	drm_fb_cma_fbdev_init(dev, priv->variant->fb_bpp, 0);
 
 	drm_kms_helper_poll_init(dev);
 
@@ -341,6 +341,7 @@ static const struct pl111_variant_data pl110_variant = {
 	.is_pl110 = true,
 	.formats = pl110_pixel_formats,
 	.nformats = ARRAY_SIZE(pl110_pixel_formats),
+	.fb_bpp = 16,
 };
 
 /* RealView, Versatile Express etc use this modern variant */
@@ -365,6 +366,7 @@ static const struct pl111_variant_data pl111_variant = {
 	.name = "PL111",
 	.formats = pl111_pixel_formats,
 	.nformats = ARRAY_SIZE(pl111_pixel_formats),
+	.fb_bpp = 32,
 };
 
 static const struct amba_id pl111_id_table[] = {
diff --git a/drivers/gpu/drm/pl111/pl111_versatile.c b/drivers/gpu/drm/pl111/pl111_versatile.c
index 11024ad64181..9825f6d52788 100644
--- a/drivers/gpu/drm/pl111/pl111_versatile.c
+++ b/drivers/gpu/drm/pl111/pl111_versatile.c
@@ -241,6 +241,7 @@ static const struct pl111_variant_data pl110_integrator = {
 	.broken_vblank = true,
 	.formats = pl110_integrator_pixel_formats,
 	.nformats = ARRAY_SIZE(pl110_integrator_pixel_formats),
+	.fb_bpp = 16,
 };
 
 /*
@@ -253,6 +254,7 @@ static const struct pl111_variant_data pl110_versatile = {
 	.external_bgr = true,
 	.formats = pl110_versatile_pixel_formats,
 	.nformats = ARRAY_SIZE(pl110_versatile_pixel_formats),
+	.fb_bpp = 16,
 };
 
 int pl111_versatile_init(struct device *dev, struct pl111_drm_dev_private *priv)
-- 
2.14.3
