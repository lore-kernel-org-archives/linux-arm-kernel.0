From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Mon, 27 Nov 2017 21:57:47 +0100
Subject: [PATCH 14/17] drm/sun4i: Add DE2 definitions for YUV formats
In-Reply-To: <20171127205750.19277-1-jernej.skrabec@siol.net>
References: <20171127205750.19277-1-jernej.skrabec@siol.net>
Message-ID: <20171127205750.19277-15-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit expands translation of DRM YUV format to HW specific
information.

It doesn't do any functional changes.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 147 +++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun8i_mixer.h |  16 ++++
 2 files changed, 159 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 2276eff8798d..00edfdc98499 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -29,92 +29,231 @@
 #include "sun8i_layer.h"
 #include "sunxi_engine.h"
 #include "sun8i_scaler.h"
+#include "sun8i_csc.h"
 
 struct de2_fmt_info {
-	u32 drm_fmt;
-	u32 de2_fmt;
+	u32			drm_fmt;
+	u32			de2_fmt;
+	bool			rgb;
+	enum sun8i_csc_mode	csc;
 };
 
 static const struct de2_fmt_info de2_formats[] = {
 	{
 		.drm_fmt = DRM_FORMAT_ARGB8888,
 		.de2_fmt = SUN8I_MIXER_FBFMT_ARGB8888,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_ABGR8888,
 		.de2_fmt = SUN8I_MIXER_FBFMT_ABGR8888,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_RGBA8888,
 		.de2_fmt = SUN8I_MIXER_FBFMT_RGBA8888,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_BGRA8888,
 		.de2_fmt = SUN8I_MIXER_FBFMT_BGRA8888,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_XRGB8888,
 		.de2_fmt = SUN8I_MIXER_FBFMT_XRGB8888,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_XBGR8888,
 		.de2_fmt = SUN8I_MIXER_FBFMT_XBGR8888,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_RGBX8888,
 		.de2_fmt = SUN8I_MIXER_FBFMT_RGBX8888,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_BGRX8888,
 		.de2_fmt = SUN8I_MIXER_FBFMT_BGRX8888,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_RGB888,
 		.de2_fmt = SUN8I_MIXER_FBFMT_RGB888,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_BGR888,
 		.de2_fmt = SUN8I_MIXER_FBFMT_BGR888,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_RGB565,
 		.de2_fmt = SUN8I_MIXER_FBFMT_RGB565,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_BGR565,
 		.de2_fmt = SUN8I_MIXER_FBFMT_BGR565,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_ARGB4444,
 		.de2_fmt = SUN8I_MIXER_FBFMT_ARGB4444,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_ABGR4444,
 		.de2_fmt = SUN8I_MIXER_FBFMT_ABGR4444,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_RGBA4444,
 		.de2_fmt = SUN8I_MIXER_FBFMT_RGBA4444,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_BGRA4444,
 		.de2_fmt = SUN8I_MIXER_FBFMT_BGRA4444,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_ARGB1555,
 		.de2_fmt = SUN8I_MIXER_FBFMT_ARGB1555,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_ABGR1555,
 		.de2_fmt = SUN8I_MIXER_FBFMT_ABGR1555,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_RGBA5551,
 		.de2_fmt = SUN8I_MIXER_FBFMT_RGBA5551,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_BGRA5551,
 		.de2_fmt = SUN8I_MIXER_FBFMT_BGRA5551,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_UYVY,
+		.de2_fmt = SUN8I_MIXER_FBFMT_UYVY,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YUV2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_VYUY,
+		.de2_fmt = SUN8I_MIXER_FBFMT_VYUY,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YUV2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_YUYV,
+		.de2_fmt = SUN8I_MIXER_FBFMT_YUYV,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YUV2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_YVYU,
+		.de2_fmt = SUN8I_MIXER_FBFMT_YVYU,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YUV2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_NV16,
+		.de2_fmt = SUN8I_MIXER_FBFMT_NV16,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YUV2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_NV61,
+		.de2_fmt = SUN8I_MIXER_FBFMT_NV61,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YUV2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_NV12,
+		.de2_fmt = SUN8I_MIXER_FBFMT_NV12,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YUV2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_NV21,
+		.de2_fmt = SUN8I_MIXER_FBFMT_NV21,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YUV2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_YUV444,
+		.de2_fmt = SUN8I_MIXER_FBFMT_RGB888,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_YUV2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_YUV422,
+		.de2_fmt = SUN8I_MIXER_FBFMT_YUV422,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YUV2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_YUV420,
+		.de2_fmt = SUN8I_MIXER_FBFMT_YUV420,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YUV2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_YUV411,
+		.de2_fmt = SUN8I_MIXER_FBFMT_YUV411,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YUV2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_YVU444,
+		.de2_fmt = SUN8I_MIXER_FBFMT_RGB888,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_YVU2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_YVU422,
+		.de2_fmt = SUN8I_MIXER_FBFMT_YUV422,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YVU2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_YVU420,
+		.de2_fmt = SUN8I_MIXER_FBFMT_YUV420,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YVU2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_YVU411,
+		.de2_fmt = SUN8I_MIXER_FBFMT_YUV411,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YVU2RGB,
 	},
 };
 
@@ -349,7 +488,7 @@ int sun8i_mixer_update_ui_layer_formats(struct sun8i_mixer *mixer,
 	u32 val;
 
 	fmt_info = sun8i_mixer_format_info(state->fb->format->format);
-	if (!fmt_info) {
+	if (!fmt_info || !fmt_info->rgb) {
 		DRM_DEBUG_DRIVER("Invalid format\n");
 		return -EINVAL;
 	}
@@ -370,7 +509,7 @@ int sun8i_mixer_update_vi_layer_formats(struct sun8i_mixer *mixer,
 	u32 val;
 
 	fmt_info = sun8i_mixer_format_info(state->fb->format->format);
-	if (!fmt_info) {
+	if (!fmt_info || !fmt_info->rgb) {
 		DRM_DEBUG_DRIVER("Invalid format\n");
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index 4fcf1653e345..c4fcaa0de40b 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -120,6 +120,22 @@
 #define SUN8I_MIXER_FBFMT_RGBA5551	18
 #define SUN8I_MIXER_FBFMT_BGRA5551	19
 
+#define SUN8I_MIXER_FBFMT_YUYV		0
+#define SUN8I_MIXER_FBFMT_UYVY		1
+#define SUN8I_MIXER_FBFMT_YVYU		2
+#define SUN8I_MIXER_FBFMT_VYUY		3
+#define SUN8I_MIXER_FBFMT_NV16		4
+#define SUN8I_MIXER_FBFMT_NV61		5
+#define SUN8I_MIXER_FBFMT_YUV422	6
+/* format 7 doesn't exist */
+#define SUN8I_MIXER_FBFMT_NV12		8
+#define SUN8I_MIXER_FBFMT_NV21		9
+#define SUN8I_MIXER_FBFMT_YUV420	10
+/* format 11 doesn't exist */
+/* format 12 is semi-planar YUV411 UVUV */
+/* format 13 is semi-planar YUV411 VUVU */
+#define SUN8I_MIXER_FBFMT_YUV411	14
+
 /*
  * These sub-engines are still unknown now, the EN registers are here only to
  * be used to disable these sub-engines.
-- 
2.15.0
