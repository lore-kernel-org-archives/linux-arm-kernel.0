From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 15 Dec 2017 13:10:45 +0100
Subject: [PATCH 2/4 v5] drm/bridge: Provide a way to embed timing info in
 bridges
In-Reply-To: <20171215121047.3650-1-linus.walleij@linaro.org>
References: <20171215121047.3650-1-linus.walleij@linaro.org>
Message-ID: <20171215121047.3650-3-linus.walleij@linaro.org>
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
ChangeLog ->v5:
- New patch
---
 include/drm/drm_bridge.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 682d01ba920c..3bf34f7c90d4 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -30,6 +30,7 @@
 
 struct drm_bridge;
 struct drm_panel;
+struct drm_bridge_timings;
 
 /**
  * struct drm_bridge_funcs - drm_bridge control functions
@@ -222,6 +223,22 @@ struct drm_bridge_funcs {
 	void (*enable)(struct drm_bridge *bridge);
 };
 
+/**
+ * struct drm_bridge_timings - timing information for the bridge
+ * @sampling_edge: whether the bridge samples the digital input signal from the
+ * display engine on the positive or negative edge of the clock - false means
+ * negative edge, true means positive edge.
+ * @setup_time_ps: the time in picoseconds the input data lines must be stable
+ * before the clock edge
+ * @hold_time_ps: the time in picoseconds taken for the bridge to sample the
+ * input signal after the rising or falling edge
+ */
+struct drm_bridge_timings {
+	bool sampling_edge;
+	u32 setup_time_ps;
+	u32 hold_time_ps;
+};
+
 /**
  * struct drm_bridge - central DRM bridge control structure
  * @dev: DRM device this bridge belongs to
@@ -229,6 +246,8 @@ struct drm_bridge_funcs {
  * @next: the next bridge in the encoder chain
  * @of_node: device node pointer to the bridge
  * @list: to keep track of all added bridges
+ * @timings: the timing specification for the bridge, if any (may
+ * be NULL)
  * @funcs: control functions
  * @driver_private: pointer to the bridge driver's internal context
  */
@@ -240,6 +259,7 @@ struct drm_bridge {
 	struct device_node *of_node;
 #endif
 	struct list_head list;
+	const struct drm_bridge_timings *timings;
 
 	const struct drm_bridge_funcs *funcs;
 	void *driver_private;
-- 
2.14.3
