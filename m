From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:25:07 +0100
Subject: [PATCH v2 35/43] drm/sun4i: frontend: Add and use helper for checking
 tiling support
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-36-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces a helper to check whether a frontend input format
supports tiling mode. This helper is used when tiling is requested in
the frontend format support helper.

Only semiplanar and planar YUV formats are supported by the hardware.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 3f76a5572449..b9c18fa2fff3 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -120,6 +120,26 @@ static bool sun4i_frontend_format_chroma_requires_swap(uint32_t fmt)
 	}
 }
 
+static bool sun4i_frontend_format_supports_tiling(uint32_t fmt)
+{
+	switch (fmt) {
+	case DRM_FORMAT_NV12:
+	case DRM_FORMAT_NV16:
+	case DRM_FORMAT_NV21:
+	case DRM_FORMAT_NV61:
+	case DRM_FORMAT_YUV411:
+	case DRM_FORMAT_YUV420:
+	case DRM_FORMAT_YUV422:
+	case DRM_FORMAT_YVU420:
+	case DRM_FORMAT_YVU422:
+	case DRM_FORMAT_YVU411:
+		return true;
+
+	default:
+		return false;
+	}
+}
+
 void sun4i_frontend_update_buffer(struct sun4i_frontend *frontend,
 				  struct drm_plane *plane)
 {
@@ -355,7 +375,9 @@ bool sun4i_frontend_format_is_supported(uint32_t fmt, uint64_t modifier)
 {
 	unsigned int i;
 
-	if (modifier != DRM_FORMAT_MOD_LINEAR)
+	if (modifier == DRM_FORMAT_MOD_ALLWINNER_TILED)
+		return sun4i_frontend_format_supports_tiling(fmt);
+	else if (modifier != DRM_FORMAT_MOD_LINEAR)
 		return false;
 
 	for (i = 0; i < ARRAY_SIZE(sun4i_frontend_formats); i++)
-- 
2.19.1
