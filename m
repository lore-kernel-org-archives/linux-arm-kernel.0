From: peda@axentia.se (Peter Rosin)
Date: Mon, 26 Mar 2018 23:24:44 +0200
Subject: [PATCH v2 2/5] drm: bridge: add API to query the expected input
 formats of bridges
In-Reply-To: <20180326212447.7380-1-peda@axentia.se>
References: <20180326212447.7380-1-peda@axentia.se>
Message-ID: <20180326212447.7380-3-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bridges may affect the required bus output format of the encoder, in
which case it may be wrong to use the output format of the panel or
connector as is. Add infrastructure to address this problem.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_bridge.c | 32 ++++++++++++++++++++++++++++++++
 include/drm/drm_bridge.h     | 18 ++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 1638bfe9627c..f85e61b7416e 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -348,6 +348,38 @@ void drm_bridge_enable(struct drm_bridge *bridge)
 }
 EXPORT_SYMBOL(drm_bridge_enable);
 
+/**
+ * drm_bridge_input_formats - get the expected bus input format of the bridge
+ * @bridge: bridge control structure
+ * @bus_formats: where to store a pointer to the bus input formats
+ *
+ * Calls the &drm_bridge_funcs.input_formats op for the frist bridge in the
+ * chain that has registered this op.
+ *
+ * Note that the bridge passed should normally be the bridge closest to the
+ * encoder, but possibly the bridge closest to an intermediate bridge in
+ * convoluted cases.
+ *
+ * RETURNS:
+ * The number of bus input formats the bridge accepts. Zero means that
+ * the chain of bridges are not converting the bus format and that the
+ * format of the drm_connector should be used.
+ */
+int drm_bridge_input_formats(struct drm_bridge *bridge,
+			     const u32 **bus_formats)
+{
+	int ret = 0;
+
+	if (!bridge)
+		return 0;
+
+	if (bridge->funcs->input_formats)
+		ret = bridge->funcs->input_formats(bridge, bus_formats);
+
+	return ret ?: drm_bridge_input_formats(bridge->next, bus_formats);
+}
+EXPORT_SYMBOL(drm_bridge_input_formats);
+
 #ifdef CONFIG_OF
 /**
  * of_drm_find_bridge - find the bridge corresponding to the device node in
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 682d01ba920c..ae8d3c4af0b8 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -220,6 +220,22 @@ struct drm_bridge_funcs {
 	 * The enable callback is optional.
 	 */
 	void (*enable)(struct drm_bridge *bridge);
+
+	/**
+	 * @input_formats:
+	 *
+	 * The callback reports the expected bus input formats of the bridge.
+	 *
+	 * The @input_formats callback is optional. The bridge is assumed to
+	 * not convert the bus format if the callback is not installed.
+	 *
+	 * RETURNS:
+	 *
+	 * Zero if the bridge does not convert the bus format, otherwise the
+	 * number of bus input formats returned in &bus_formats.
+	 */
+	int (*input_formats)(struct drm_bridge *bridge,
+			     const u32 **bus_formats);
 };
 
 /**
@@ -263,6 +279,8 @@ void drm_bridge_mode_set(struct drm_bridge *bridge,
 			struct drm_display_mode *adjusted_mode);
 void drm_bridge_pre_enable(struct drm_bridge *bridge);
 void drm_bridge_enable(struct drm_bridge *bridge);
+int drm_bridge_input_formats(struct drm_bridge *bridge,
+			     const u32 **bus_formats);
 
 #ifdef CONFIG_DRM_PANEL_BRIDGE
 struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel,
-- 
2.11.0
