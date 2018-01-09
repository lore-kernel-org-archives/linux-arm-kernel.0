From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  9 Jan 2018 11:09:15 +0100
Subject: [PATCH v3 02/13] drm/sun4i: backend: Document the engine operations
In-Reply-To: <cover.8538fc1191390239557a21e2b0444c81eef1c581.1515492513.git-series.maxime.ripard@free-electrons.com>
References: <cover.8538fc1191390239557a21e2b0444c81eef1c581.1515492513.git-series.maxime.ripard@free-electrons.com>
Message-ID: <fdcd8ec3ae9ecd73ef089ede5218d3a41b49be05.1515492513.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our operations were missing some documentation to explain what was expected
from them.

Let's make that clearer.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sunxi_engine.h | 46 +++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sunxi_engine.h b/drivers/gpu/drm/sun4i/sunxi_engine.h
index 4cb70ae65c79..b374e074c7c3 100644
--- a/drivers/gpu/drm/sun4i/sunxi_engine.h
+++ b/drivers/gpu/drm/sun4i/sunxi_engine.h
@@ -15,12 +15,58 @@ struct drm_device;
 
 struct sunxi_engine;
 
+/**
+ * struct sunxi_engine_ops - helper operations for sunXi engines
+ *
+ * These hooks are used by the common part of the DRM driver to
+ * implement the proper behaviour.
+ */
 struct sunxi_engine_ops {
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
+	 * @layers_init:
+	 *
+	 * This callback is used to allocate, initialize and register
+	 * the layers supported by that engine.
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
 
+	/**
+	 * @apply_color_correction:
+	 *
+	 * This callback will enable the color correction in the
+	 * engine. This is useful only for the composite output.
+	 *
+	 * This function is optional.
+	 */
 	void (*apply_color_correction)(struct sunxi_engine *engine);
+
+	/**
+	 * @disable_color_correction:
+	 *
+	 * This callback will stop the color correction in the
+	 * engine. This is useful only for the composite output.
+	 *
+	 * This function is optional.
+	 */
 	void (*disable_color_correction)(struct sunxi_engine *engine);
 };
 
-- 
git-series 0.9.1
