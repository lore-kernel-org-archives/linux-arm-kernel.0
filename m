From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:24:40 +0100
Subject: [PATCH v2 08/43] drm/fourcc: Add helper to check if a format uses a
 YUV colorspace
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-9-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a new helper to check whether the format described by its
fourcc code uses a YUV colorspace, by returning the is_yuv entry for
the DRM info entry matching that format.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/drm_fourcc.c | 19 +++++++++++++++++++
 include/drm/drm_fourcc.h     |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index f523948c82b1..f85650c3463a 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -413,6 +413,25 @@ int drm_format_plane_height(int height, uint32_t format, int plane)
 }
 EXPORT_SYMBOL(drm_format_plane_height);
 
+/**
+ * drm_format_is_yuv - check that the format uses a YUV colorspace
+ * @format: pixel format
+ *
+ * Returns:
+ * A boolean indicating whether the format uses a YUV colorspace.
+ */
+bool drm_format_is_yuv(uint32_t format)
+{
+	const struct drm_format_info *info;
+
+	info = drm_format_info(format);
+	if (!info)
+		return false;
+
+	return info->is_yuv;
+}
+EXPORT_SYMBOL(drm_format_is_yuv);
+
 /**
  * drm_format_info_block_width - width in pixels of block.
  * @info: pixel format info
diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index bcb389f04618..569b70483505 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -157,6 +157,7 @@ int drm_format_horz_chroma_subsampling(uint32_t format);
 int drm_format_vert_chroma_subsampling(uint32_t format);
 int drm_format_plane_width(int width, uint32_t format, int plane);
 int drm_format_plane_height(int height, uint32_t format, int plane);
+bool drm_format_is_yuv(uint32_t format);
 unsigned int drm_format_info_block_width(const struct drm_format_info *info,
 					 int plane);
 unsigned int drm_format_info_block_height(const struct drm_format_info *info,
-- 
2.19.1
