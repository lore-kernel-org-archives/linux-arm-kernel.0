From: peda@axentia.se (Peter Rosin)
Date: Tue, 17 Apr 2018 15:10:49 +0200
Subject: [PATCH v2 3/6] drm: of: introduce drm_of_media_bus_fmt
In-Reply-To: <20180417131052.16336-1-peda@axentia.se>
References: <20180417131052.16336-1-peda@axentia.se>
Message-ID: <20180417131052.16336-4-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a central function to parse a node according to the video
interface binding and get a media bus format.

Start with only supporting a very limited set of a few basic media
bus formats.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_of.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/drm/drm_of.h     |  7 +++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 4c191c050e7d..f9473edb60a7 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -212,6 +212,44 @@ int drm_of_encoder_active_endpoint(struct device_node *node,
 EXPORT_SYMBOL_GPL(drm_of_encoder_active_endpoint);
 
 /*
+ * drm_of_media_bus_fmt - return the media bus format described in the node
+ * @node: device tree node containing the media bus format
+ *
+ * @node is presumably an of-graph endpoint node.
+ *
+ * Return the media bus format, or zero if none is described. Or one of the
+ * standard error codes.
+ */
+int drm_of_media_bus_fmt(struct device_node *node)
+{
+	s32 bus_type;
+	u32 bus_width = 0;
+
+	if (!node)
+		return -EINVAL;
+
+	if (of_property_read_u32(node, "bus-type", &bus_type))
+		return 0;
+	if (bus_type != 0)
+		return -EINVAL;
+
+	of_property_read_u32(node, "bus-width", &bus_width);
+	switch (bus_width) {
+	case 12:
+		return MEDIA_BUS_FMT_RGB444_1X12;
+	case 16:
+		return MEDIA_BUS_FMT_RGB565_1X16;
+	case 18:
+		return MEDIA_BUS_FMT_RGB666_1X18;
+	case 24:
+		return MEDIA_BUS_FMT_RGB888_1X24;
+	default:
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_GPL(drm_of_media_bus_fmt);
+
+/*
  * drm_of_find_panel_or_bridge - return connected panel or bridge device
  * @np: device tree node containing encoder output ports
  * @panel: pointer to hold returned drm_panel
diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
index b93c239afb60..f86f0098b21e 100644
--- a/include/drm/drm_of.h
+++ b/include/drm/drm_of.h
@@ -29,6 +29,7 @@ int drm_of_component_probe(struct device *dev,
 int drm_of_encoder_active_endpoint(struct device_node *node,
 				   struct drm_encoder *encoder,
 				   struct of_endpoint *endpoint);
+int drm_of_media_bus_fmt(struct device_node *node);
 int drm_of_find_panel_or_bridge(const struct device_node *np,
 				int port, int endpoint,
 				struct drm_panel **panel,
@@ -62,6 +63,12 @@ static inline int drm_of_encoder_active_endpoint(struct device_node *node,
 {
 	return -EINVAL;
 }
+
+static inline int drm_of_media_bus_fmt(struct device_node *node)
+{
+	return -EINVAL;
+}
+
 static inline int drm_of_find_panel_or_bridge(const struct device_node *np,
 					      int port, int endpoint,
 					      struct drm_panel **panel,
-- 
2.11.0
