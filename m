From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  9 Jan 2018 11:56:20 +0100
Subject: [PATCH 01/19] drm/fourcc: Add a function to tell if the format embeds
 alpha
In-Reply-To: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
References: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
Message-ID: <b58c65b26e59dff7917d90846cb797a11ca09efa.1515494838.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's a bunch of drivers that duplicate the same function to know if a
particular format embeds an alpha component or not.

Let's create a helper to avoid duplicating that logic.

Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Eric Anholt <eric@anholt.net>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mark Yao <mark.yao@rock-chips.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/drm_fourcc.c | 43 +++++++++++++++++++++++++++++++++++++-
 include/drm/drm_fourcc.h     |  1 +-
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 9c0152df45ad..6e6227d6a46b 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -348,3 +348,46 @@ int drm_format_plane_height(int height, uint32_t format, int plane)
 	return height / info->vsub;
 }
 EXPORT_SYMBOL(drm_format_plane_height);
+
+/**
+ * drm_format_has_alpha - get whether the format embeds an alpha component
+ * @format: pixel format (DRM_FORMAT_*)
+ *
+ * Returns:
+ * true if the format embeds an alpha component, false otherwise.
+ */
+bool drm_format_has_alpha(uint32_t format)
+{
+	switch (format) {
+	case DRM_FORMAT_ARGB4444:
+	case DRM_FORMAT_ABGR4444:
+	case DRM_FORMAT_RGBA4444:
+	case DRM_FORMAT_BGRA4444:
+	case DRM_FORMAT_ARGB1555:
+	case DRM_FORMAT_ABGR1555:
+	case DRM_FORMAT_RGBA5551:
+	case DRM_FORMAT_BGRA5551:
+	case DRM_FORMAT_ARGB8888:
+	case DRM_FORMAT_ABGR8888:
+	case DRM_FORMAT_RGBA8888:
+	case DRM_FORMAT_BGRA8888:
+	case DRM_FORMAT_ARGB2101010:
+	case DRM_FORMAT_ABGR2101010:
+	case DRM_FORMAT_RGBA1010102:
+	case DRM_FORMAT_BGRA1010102:
+	case DRM_FORMAT_AYUV:
+	case DRM_FORMAT_XRGB8888_A8:
+	case DRM_FORMAT_XBGR8888_A8:
+	case DRM_FORMAT_RGBX8888_A8:
+	case DRM_FORMAT_BGRX8888_A8:
+	case DRM_FORMAT_RGB888_A8:
+	case DRM_FORMAT_BGR888_A8:
+	case DRM_FORMAT_RGB565_A8:
+	case DRM_FORMAT_BGR565_A8:
+		return true;
+
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL(drm_format_has_alpha);
diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index 6942e84b6edd..e08fc22c5f78 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -69,5 +69,6 @@ int drm_format_vert_chroma_subsampling(uint32_t format);
 int drm_format_plane_width(int width, uint32_t format, int plane);
 int drm_format_plane_height(int height, uint32_t format, int plane);
 const char *drm_get_format_name(uint32_t format, struct drm_format_name_buf *buf);
+bool drm_format_has_alpha(uint32_t format);
 
 #endif /* __DRM_FOURCC_H__ */
-- 
git-series 0.9.1
