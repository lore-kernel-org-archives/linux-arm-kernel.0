From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 12 Jan 2018 08:48:52 +0100
Subject: [PATCH 2/4 v7] drm/bridge: Provide a way to embed timing info in
 bridges
In-Reply-To: <20180112074854.9560-1-linus.walleij@linaro.org>
References: <20180112074854.9560-1-linus.walleij@linaro.org>
Message-ID: <20180112074854.9560-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After some discussion and failed patch sets trying to convey
the right timing information between the display engine and
a bridge using the connector, I try instead to use an optional
timing information container in the bridge itself, so that
display engines can retrieve it from any bridge and use it to
determine how to drive outputs.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v6->v7:
- Fix the comment style to use the new inline type of kerneldoc
  for struct members.
- Need an explicit ACK/review by someone on this patch to continue
  with the series...
ChangeLog v5->v6:
- Sort forward struct declarations alphabetically
- Switch to using DRM_BUS_FLAG_PIXDATA_[POS|NEG]EDGE to indicate
  positive or negatice clock samling edge
ChangeLog ->v5:
- New patch
---
 include/drm/drm_bridge.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 682d01ba920c..d3c2eea0bb63 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -29,6 +29,7 @@
 #include <drm/drm_modes.h>
 
 struct drm_bridge;
+struct drm_bridge_timings;
 struct drm_panel;
 
 /**
@@ -222,6 +223,35 @@ struct drm_bridge_funcs {
 	void (*enable)(struct drm_bridge *bridge);
 };
 
+/**
+ * struct drm_bridge_timings - timing information for the bridge
+ */
+struct drm_bridge_timings {
+	/**
+	 * @sampling_edge:
+	 *
+	 * Tells whether the bridge samples the digital input signal
+	 * from the display engine on the positive or negative edge of the clock,
+	 * this should reuse the DRM_BUS_FLAG_PIXDATA_[POS|NEG]EDGE bitwise
+	 * flags from the DRM connector (bit 2 and 3 valid).
+	 */
+	u32 sampling_edge;
+	/**
+	 * @setup_time_ps:
+	 *
+	 * Defines the time in picoseconds the input data lines must be
+	 * stable before the clock edge.
+	 */
+	u32 setup_time_ps;
+	/**
+	 * @hold_time_ps:
+	 *
+	 * Defines the time in picoseconds taken for the bridge to sample the
+	 * input signal after the clock edge.
+	 */
+	u32 hold_time_ps;
+};
+
 /**
  * struct drm_bridge - central DRM bridge control structure
  * @dev: DRM device this bridge belongs to
@@ -229,6 +259,8 @@ struct drm_bridge_funcs {
  * @next: the next bridge in the encoder chain
  * @of_node: device node pointer to the bridge
  * @list: to keep track of all added bridges
+ * @timings: the timing specification for the bridge, if any (may
+ * be NULL)
  * @funcs: control functions
  * @driver_private: pointer to the bridge driver's internal context
  */
@@ -240,6 +272,7 @@ struct drm_bridge {
 	struct device_node *of_node;
 #endif
 	struct list_head list;
+	const struct drm_bridge_timings *timings;
 
 	const struct drm_bridge_funcs *funcs;
 	void *driver_private;
-- 
2.14.3
