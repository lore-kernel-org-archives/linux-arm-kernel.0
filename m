From: Ying.Liu@freescale.com (Liu Ying)
Date: Thu, 14 May 2015 10:21:39 +0800
Subject: [PATCH v9.5.1 09/20] drm/dsi: Add a helper to get bits per pixel of
 MIPI DSI pixel format
Message-ID: <1431570099-29216-1-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a helper to get bits per pixel value of MIPI DSI pixel format.
The helper takes a parameter in the type 'enum mipi_dsi_pixel_format' and
returns it's bits per pixel value if the parameter is valid, otherwise, it
returns -EINVAL.  The helper makes users' life easier to do the conversion
from a specific MIPI DSI pixel format to it's bits per pixel value.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
v9.5->v9.5.1:
 * To address Thierry Reding's comments, add a commit message to describe why
   the helper is useful and when to use it and fix typo in kernel-doc from
   'mipi dsi' to 'MIPI DSI'.

v9->v9.5:
 * Add kernel-doc for the new helper function to address Daniel Vetter's
   comment.

v8->v9:
 * Rebase onto the imx-drm/next branch of Philipp Zabel's open git repository.

v7->v8:
 * None.

v6->v7:
 * None.

v5->v6:
 * Address the over 80 characters in one line warning reported by the
   checkpatch.pl script.

v4->v5:
 * None.

v3->v4:
 * None.

v2->v3:
 * None.

v1->v2:
 * Thierry Reding suggested that the mipi_dsi_pixel_format_to_bpp() function
   could be placed at the common DRM MIPI DSI driver.
   This patch is newly added.

 include/drm/drm_mipi_dsi.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index f1d8d0d..186b15b 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -163,6 +163,28 @@ static inline struct mipi_dsi_device *to_mipi_dsi_device(struct device *dev)
 	return container_of(dev, struct mipi_dsi_device, dev);
 }
 
+/**
+ * mipi_dsi_pixel_format_to_bpp() - get bits per pixel for a MIPI DSI
+ *    pixel format
+ * @fmt: MIPI DSI pixel format
+ *
+ * Return: The bits per pixel value for the MIPI DSI pixel format on success or
+ *    a negative error code on failure.
+ */
+static inline int mipi_dsi_pixel_format_to_bpp(enum mipi_dsi_pixel_format fmt)
+{
+	switch (fmt) {
+	case MIPI_DSI_FMT_RGB888:
+	case MIPI_DSI_FMT_RGB666:
+		return 24;
+	case MIPI_DSI_FMT_RGB666_PACKED:
+		return 18;
+	case MIPI_DSI_FMT_RGB565:
+		return 16;
+	}
+	return -EINVAL;
+}
+
 struct mipi_dsi_device *of_find_mipi_dsi_device_by_node(struct device_node *np);
 int mipi_dsi_attach(struct mipi_dsi_device *dsi);
 int mipi_dsi_detach(struct mipi_dsi_device *dsi);
-- 
1.9.1
