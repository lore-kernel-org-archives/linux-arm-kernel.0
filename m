From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:24:58 +0100
Subject: [PATCH v2 26/43] drm/sun4i: frontend: Add support for packed YUV422
 input formats
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-27-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces support for packed YUV formats with 4:2:2 sampling using
the frontend. Definitions are introduced for the data format and pixel
sequence input format register values.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  5 +++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 4700133b96e0..f443e8e1d8ec 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -130,6 +130,8 @@ static int sun4i_frontend_drm_format_to_input_fmt(uint32_t fmt, u32 *val)
 {
 	if (!drm_format_is_yuv(fmt))
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB;
+	else if (drm_format_is_yuv_sampling_422(fmt))
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV422;
 	else
 		return -EINVAL;
 
@@ -153,10 +155,26 @@ static int sun4i_frontend_drm_format_to_input_sequence(uint32_t fmt, u32 *val)
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_BGRX;
 		return 0;
 
+	case DRM_FORMAT_UYVY:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_UYVY;
+		return 0;
+
+	case DRM_FORMAT_VYUY:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_VYUY;
+		return 0;
+
 	case DRM_FORMAT_XRGB8888:
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_XRGB;
 		return 0;
 
+	case DRM_FORMAT_YUYV:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_YUYV;
+		return 0;
+
+	case DRM_FORMAT_YVYU:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_YVYU;
+		return 0;
+
 	default:
 		return -EINVAL;
 	}
@@ -180,7 +198,11 @@ static int sun4i_frontend_drm_format_to_output_fmt(uint32_t fmt, u32 *val)
 
 static const uint32_t sun4i_frontend_formats[] = {
 	DRM_FORMAT_BGRX8888,
+	DRM_FORMAT_UYVY,
+	DRM_FORMAT_VYUY,
 	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_YUYV,
+	DRM_FORMAT_YVYU,
 };
 
 bool sun4i_frontend_format_is_supported(uint32_t fmt)
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index fb097c34e160..399755939a28 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -27,7 +27,12 @@
 
 #define SUN4I_FRONTEND_INPUT_FMT_REG		0x04c
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PACKED	(1 << 8)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV422	(1 << 4)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB		(5 << 4)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_UYVY		0
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_YUYV		1
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_VYUY		2
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_YVYU		3
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_BGRX		0
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_XRGB		1
 
-- 
2.19.1
