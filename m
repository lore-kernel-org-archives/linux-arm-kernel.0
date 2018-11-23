From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:24:42 +0100
Subject: [PATCH v2 10/43] drm/fourcc: Add format helpers for checking YUV
 planes disposition
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-11-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces new format helpers that use the previously-introduced
format info helpers for checking YUV planes disposition.

Only the format fourcc is required by these helpers and the formats are
iterated from the list.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/drm_fourcc.c | 60 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_fourcc.h     |  3 ++
 2 files changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index f85650c3463a..b56e773f9f63 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -432,6 +432,66 @@ bool drm_format_is_yuv(uint32_t format)
 }
 EXPORT_SYMBOL(drm_format_is_yuv);
 
+/**
+ * drm_format_is_yuv_packed - check that the format is a YUV format with data
+ * laid in a single plane
+ * @format: pixel format
+ *
+ * Returns:
+ * A boolean indicating whether the format is a packed YUV format
+ */
+bool drm_format_is_yuv_packed(uint32_t format)
+{
+	const struct drm_format_info *info;
+
+	info = drm_format_info(format);
+	if (!info)
+		return false;
+
+	return drm_format_info_is_yuv_packed(info);
+}
+EXPORT_SYMBOL(drm_format_is_yuv_packed);
+
+/**
+ * drm_format_is_yuv_semiplanar - check that the format is a YUV format with
+ * data laid in two planes (luminance and chrominance)
+ * @format: pixel format
+ *
+ * Returns:
+ * A boolean indicating whether the format is a semiplanar YUV format
+ */
+bool drm_format_is_yuv_semiplanar(uint32_t format)
+{
+	const struct drm_format_info *info;
+
+	info = drm_format_info(format);
+	if (!info)
+		return false;
+
+	return drm_format_info_is_yuv_semiplanar(info);
+}
+EXPORT_SYMBOL(drm_format_is_yuv_semiplanar);
+
+/**
+ * drm_format_is_yuv_planar - check that the format is a YUV format with data
+ * laid in three planes (one for each YUV component)
+ * @format: pixel format
+ *
+ * Returns:
+ * A boolean indicating whether the format is a planar YUV format
+ */
+bool drm_format_is_yuv_planar(uint32_t format)
+{
+	const struct drm_format_info *info;
+
+	info = drm_format_info(format);
+	if (!info)
+		return false;
+
+	return drm_format_info_is_yuv_planar(info);
+}
+EXPORT_SYMBOL(drm_format_is_yuv_planar);
+
 /**
  * drm_format_info_block_width - width in pixels of block.
  * @info: pixel format info
diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index f43d5ba412fb..b652b711df1a 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -200,6 +200,9 @@ int drm_format_vert_chroma_subsampling(uint32_t format);
 int drm_format_plane_width(int width, uint32_t format, int plane);
 int drm_format_plane_height(int height, uint32_t format, int plane);
 bool drm_format_is_yuv(uint32_t format);
+bool drm_format_is_yuv_packed(uint32_t format);
+bool drm_format_is_yuv_semiplanar(uint32_t format);
+bool drm_format_is_yuv_planar(uint32_t format);
 unsigned int drm_format_info_block_width(const struct drm_format_info *info,
 					 int plane);
 unsigned int drm_format_info_block_height(const struct drm_format_info *info,
-- 
2.19.1
