From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu,  1 Mar 2018 20:18:46 +0100
Subject: [PATCH 2/2] drm/sun4i: backend: Support YUV planes
In-Reply-To: <cover.f0cb3210f2d878853ef16506da152f38ba2e3286.1519931807.git-series.maxime.ripard@bootlin.com>
References: <cover.f0cb3210f2d878853ef16506da152f38ba2e3286.1519931807.git-series.maxime.ripard@bootlin.com>
Message-ID: <66088c1398bd3189123f28a89a7ccc669fe9f296.1519931807.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have the guarantee that we will have only a single YUV plane,
actually support them. The way it works is not really straightforward,
since we first need to enable the YUV mode in the plane that we want to
setup, and then we have a few registers to setup the YUV buffer and
parameters.

We also need to setup the color correction to actually have something
displayed.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 79 ++++++++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun4i_layer.c   |  4 +-
 2 files changed, 83 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 486dfd357920..7e647044cbed 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -42,6 +42,12 @@ static const u32 sunxi_rgb2yuv_coef[12] = {
 	0x000001c1, 0x00003e88, 0x00003fb8, 0x00000808
 };
 
+static const u32 sunxi_bt601_yuv2rgb_coef[12] = {
+	0x000004a7, 0x00001e6f, 0x00001cbf, 0x00000877,
+	0x000004a7, 0x00000000, 0x00000662, 0x00003211,
+	0x000004a7, 0x00000812, 0x00000000, 0x00002eb1,
+};
+
 static inline bool sun4i_backend_format_is_planar_yuv(uint32_t format)
 {
 	switch (format) {
@@ -198,6 +204,55 @@ int sun4i_backend_update_layer_coord(struct sun4i_backend *backend,
 	return 0;
 }
 
+static int sun4i_backend_update_yuv_format(struct sun4i_backend *backend,
+					   int layer, struct drm_plane *plane)
+{
+	struct drm_plane_state *state = plane->state;
+	struct drm_framebuffer *fb = state->fb;
+	uint32_t format = fb->format->format;
+	u32 val = SUN4I_BACKEND_IYUVCTL_EN;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sunxi_bt601_yuv2rgb_coef); i++)
+		regmap_write(backend->engine.regs,
+			     SUN4I_BACKEND_YGCOEF_REG(i),
+			     sunxi_bt601_yuv2rgb_coef[i]);
+
+	/*
+	 * We should do that only for a single plane, but the
+	 * framebuffer's atomic_check has our back on this.
+	 */
+	regmap_update_bits(backend->engine.regs, SUN4I_BACKEND_ATTCTL_REG0(layer),
+			   SUN4I_BACKEND_ATTCTL_REG0_LAY_YUVEN,
+			   SUN4I_BACKEND_ATTCTL_REG0_LAY_YUVEN);
+
+	if (sun4i_backend_format_is_packed_yuv422(format))
+		val |= SUN4I_BACKEND_IYUVCTL_FBFMT_PACKED_YUV422;
+	else
+		DRM_DEBUG_DRIVER("Unknown YUV format\n");
+
+	switch (format) {
+	case DRM_FORMAT_YUYV:
+		val |= SUN4I_BACKEND_IYUVCTL_FBPS_VYUY;
+		break;
+	case DRM_FORMAT_YVYU:
+		val |= SUN4I_BACKEND_IYUVCTL_FBPS_UYVY;
+		break;
+	case DRM_FORMAT_UYVY:
+		val |= SUN4I_BACKEND_IYUVCTL_FBPS_YVYU;
+		break;
+	case DRM_FORMAT_VYUY:
+		val |= SUN4I_BACKEND_IYUVCTL_FBPS_YUYV;
+		break;
+	default:
+		DRM_DEBUG_DRIVER("Unknown YUV pixel sequence\n");
+	}
+
+	regmap_write(backend->engine.regs, SUN4I_BACKEND_IYUVCTL_REG, val);
+
+	return 0;
+}
+
 int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
 				       int layer, struct drm_plane *plane)
 {
@@ -207,6 +262,10 @@ int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
 	u32 val;
 	int ret;
 
+	/* Clear the YUV mode */
+	regmap_update_bits(backend->engine.regs, SUN4I_BACKEND_ATTCTL_REG0(layer),
+			   SUN4I_BACKEND_ATTCTL_REG0_LAY_YUVEN, 0);
+
 	if (plane->state->crtc)
 		interlaced = plane->state->crtc->state->adjusted_mode.flags
 			& DRM_MODE_FLAG_INTERLACE;
@@ -218,6 +277,9 @@ int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
 	DRM_DEBUG_DRIVER("Switching display backend interlaced mode %s\n",
 			 interlaced ? "on" : "off");
 
+	if (sun4i_backend_format_is_yuv(fb->format->format))
+		return sun4i_backend_update_yuv_format(backend, layer, plane);
+
 	ret = sun4i_backend_drm_format_to_layer(fb->format->format, &val);
 	if (ret) {
 		DRM_DEBUG_DRIVER("Invalid format\n");
@@ -255,6 +317,20 @@ int sun4i_backend_update_layer_frontend(struct sun4i_backend *backend,
 	return 0;
 }
 
+static int sun4i_backend_update_yuv_buffer(struct sun4i_backend *backend,
+					   struct drm_framebuffer *fb,
+					   dma_addr_t paddr)
+{
+	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
+	regmap_write(backend->engine.regs, SUN4I_BACKEND_IYUVADD_REG(0), paddr);
+
+	DRM_DEBUG_DRIVER("Layer line width: %d bits\n", fb->pitches[0] * 8);
+	regmap_write(backend->engine.regs, SUN4I_BACKEND_IYUVLINEWIDTH_REG(0),
+		     fb->pitches[0] * 8);
+
+	return 0;
+}
+
 int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
 				      int layer, struct drm_plane *plane)
 {
@@ -280,6 +356,9 @@ int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
 	 */
 	paddr -= PHYS_OFFSET;
 
+	if (sun4i_backend_format_is_yuv(fb->format->format))
+		return sun4i_backend_update_yuv_buffer(backend, fb, paddr);
+
 	/* Write the 32 lower bits of the address (in bits) */
 	lo_paddr = paddr << 3;
 	DRM_DEBUG_DRIVER("Setting address lower bits to 0x%x\n", lo_paddr);
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 33ad377569ec..2949a3c912c1 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -134,7 +134,11 @@ static const uint32_t sun4i_backend_layer_formats[] = {
 	DRM_FORMAT_RGBA4444,
 	DRM_FORMAT_RGB888,
 	DRM_FORMAT_RGB565,
+	DRM_FORMAT_UYVY,
+	DRM_FORMAT_VYUY,
 	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_YUYV,
+	DRM_FORMAT_YVYU,
 };
 
 static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
-- 
git-series 0.9.1
