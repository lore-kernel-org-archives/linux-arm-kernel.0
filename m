From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Dec 2017 15:57:49 +0100
Subject: [PATCH v2 02/12] sun4i/drm: backend: Document the engine operations
In-Reply-To: <cover.baf97666d4bb722f2acfdc2c98c0461e58f31b9e.1513609024.git-series.maxime.ripard@free-electrons.com>
References: <cover.baf97666d4bb722f2acfdc2c98c0461e58f31b9e.1513609024.git-series.maxime.ripard@free-electrons.com>
Message-ID: <4f1b699706740031c0f3ab4113223e37f62dce6b.1513609024.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our operations were missing some documentation to explain what was expected
from them.

Let's make that clearer.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c |  2 +-
 drivers/gpu/drm/sun4i/sunxi_engine.h  | 51 ++++++++++++++++++++++++++--
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index c99d1a7e815a..f971d3fb5ee4 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -93,7 +93,7 @@ void sun4i_backend_layer_enable(struct sun4i_backend *backend,
 static int sun4i_backend_drm_format_to_layer(struct drm_plane *plane,
 					     u32 format, u32 *mode)
 {
-	if ((plane->type == DRM_PLANE_TYPE_PRIMARY) &&
+	if (plane && (plane->type == DRM_PLANE_TYPE_PRIMARY) &&
 	    (format == DRM_FORMAT_ARGB8888))
 		format = DRM_FORMAT_XRGB8888;
 
diff --git a/drivers/gpu/drm/sun4i/sunxi_engine.h b/drivers/gpu/drm/sun4i/sunxi_engine.h
index 4cb70ae65c79..36c8388b1646 100644
--- a/drivers/gpu/drm/sun4i/sunxi_engine.h
+++ b/drivers/gpu/drm/sun4i/sunxi_engine.h
@@ -15,13 +15,60 @@ struct drm_device;
 
 struct sunxi_engine;
 
+/**
+ * struct sunxi_engine_ops - helper operations for sunXi engines
+ *
+ * These hooks are used by the common part of the DRM driver to
+ * implement the proper behaviour.
+ */
 struct sunxi_engine_ops {
+	/**
+	 * @apply_color_correction:
+	 *
+	 * This callback will enable the color correction in the
+	 * backend. This is useful only for the composite output.
+	 *
+	 * This function is optional.
+	 */
+	void (*apply_color_correction)(struct sunxi_engine *engine);
+
+	/**
+	 * @commit:
+	 *
+	 * This callback will trigger the hardware switch to commit
+	 * the new configuration that has been setup during the next
+	 * vblank period.
+	 *
+	 * This function is optional.
+	 */
 	void (*commit)(struct sunxi_engine *engine);
+
+	/**
+	 * @disable_color_correction:
+	 *
+	 * This callback will stop the color correction in the
+	 * backend. This is useful only for the composite output.
+	 *
+	 * This function is optional.
+	 */
+	void (*disable_color_correction)(struct sunxi_engine *engine);
+
+	/**
+	 * @layers_init:
+	 *
+	 * This callback is used to allocate, initialize and register
+	 * the layers supported by that backend.
+	 *
+	 * This function is mandatory.
+	 *
+	 * RETURNS:
+	 *
+	 * The array of struct drm_plane backing the layers, or an
+	 * error pointer on failure.
+	 */
 	struct drm_plane **(*layers_init)(struct drm_device *drm,
 					  struct sunxi_engine *engine);
 
-	void (*apply_color_correction)(struct sunxi_engine *engine);
-	void (*disable_color_correction)(struct sunxi_engine *engine);
 };
 
 /**
-- 
git-series 0.9.1
