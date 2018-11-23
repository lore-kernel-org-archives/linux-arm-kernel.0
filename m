From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:24:49 +0100
Subject: [PATCH v2 17/43] drm/sun4i: frontend: Add helpers for input data mode
 and pixel sequence
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-18-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces new helpers for retrieving the input data mode and pixel
sequence register field values based on the DRM format instead of
hardcoding these. This makes it easier to add support for more formats.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 46 +++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index f54b1c4a9264..bb5977a466f3 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -116,6 +116,30 @@ static int sun4i_frontend_drm_format_to_input_fmt(uint32_t fmt, u32 *val)
 	}
 }
 
+static int sun4i_frontend_drm_format_to_input_mode(uint32_t fmt, u32 *val)
+{
+	switch (fmt) {
+	case DRM_FORMAT_XRGB8888:
+		*val = 1;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int sun4i_frontend_drm_format_to_input_sequence(uint32_t fmt, u32 *val)
+{
+	switch (fmt) {
+	case DRM_FORMAT_XRGB8888:
+		*val = 1;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static int sun4i_frontend_drm_format_to_output_fmt(uint32_t fmt, u32 *val)
 {
 	switch (fmt) {
@@ -149,17 +173,29 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
+	uint32_t format = fb->format->format;
 	u32 out_fmt_val;
-	u32 in_fmt_val;
+	u32 in_fmt_val, in_mod_val, in_ps_val;
 	int ret;
 
-	ret = sun4i_frontend_drm_format_to_input_fmt(fb->format->format,
-						     &in_fmt_val);
+	ret = sun4i_frontend_drm_format_to_input_fmt(format, &in_fmt_val);
 	if (ret) {
 		DRM_DEBUG_DRIVER("Invalid input format\n");
 		return ret;
 	}
 
+	ret = sun4i_frontend_drm_format_to_input_mode(format, &in_mod_val);
+	if (ret) {
+		DRM_DEBUG_DRIVER("Invalid input mode\n");
+		return ret;
+	}
+
+	ret = sun4i_frontend_drm_format_to_input_sequence(format, &in_ps_val);
+	if (ret) {
+		DRM_DEBUG_DRIVER("Invalid pixel sequence\n");
+		return ret;
+	}
+
 	ret = sun4i_frontend_drm_format_to_output_fmt(out_fmt, &out_fmt_val);
 	if (ret) {
 		DRM_DEBUG_DRIVER("Invalid output format\n");
@@ -182,9 +218,9 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 			   SUN4I_FRONTEND_BYPASS_CSC_EN);
 
 	regmap_write(frontend->regs, SUN4I_FRONTEND_INPUT_FMT_REG,
-		     SUN4I_FRONTEND_INPUT_FMT_DATA_MOD(1) |
+		     SUN4I_FRONTEND_INPUT_FMT_DATA_MOD(in_mod_val) |
 		     SUN4I_FRONTEND_INPUT_FMT_DATA_FMT(in_fmt_val) |
-		     SUN4I_FRONTEND_INPUT_FMT_PS(1));
+		     SUN4I_FRONTEND_INPUT_FMT_PS(in_ps_val));
 
 	/*
 	 * TODO: It look like the A31 and A80 at least will need the
-- 
2.19.1
