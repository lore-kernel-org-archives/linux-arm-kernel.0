From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 10 Dec 2014 16:48:21 +0100
Subject: [RFC 03/15] drm/panel: add restrack support
In-Reply-To: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
References: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
Message-ID: <1418226513-14105-4-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds Device Tree restrack support to drm/panel framework.
As panels supports only Device Tree based lookup all panels can be
converted to restrack.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/drm_panel.c | 97 +++++++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_panel.h     |  4 ++
 include/linux/restrack.h    |  2 +
 3 files changed, 103 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 2ef988e..db04696 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -22,7 +22,9 @@
  */
 
 #include <linux/err.h>
+#include <linux/of_graph.h>
 #include <linux/module.h>
+#include <linux/restrack.h>
 
 #include <drm/drm_crtc.h>
 #include <drm/drm_panel.h>
@@ -41,6 +43,7 @@ int drm_panel_add(struct drm_panel *panel)
 	mutex_lock(&panel_lock);
 	list_add_tail(&panel->list, &panel_list);
 	mutex_unlock(&panel_lock);
+	restrack_up(RESTRACK_TYPE_DRM_PANEL, panel->dev->of_node, panel);
 
 	return 0;
 }
@@ -48,6 +51,7 @@ EXPORT_SYMBOL(drm_panel_add);
 
 void drm_panel_remove(struct drm_panel *panel)
 {
+	restrack_down(RESTRACK_TYPE_DRM_PANEL, panel->dev->of_node, panel);
 	mutex_lock(&panel_lock);
 	list_del_init(&panel->list);
 	mutex_unlock(&panel_lock);
@@ -93,6 +97,99 @@ struct drm_panel *of_drm_find_panel(struct device_node *np)
 	return NULL;
 }
 EXPORT_SYMBOL(of_drm_find_panel);
+
+struct drm_panel_restrack_desc {
+	struct drm_panel **ptr;
+	const char *name;
+	int port;
+	struct restrack_desc desc;
+};
+
+static int drm_panel_restrack_init(struct device *dev,
+		struct restrack_desc *desc)
+{
+	struct drm_panel_restrack_desc *rd = restrack_desc_to_rd(rd, desc);
+	struct device_node *np;
+
+	if (rd->name) {
+		desc->if_id = of_parse_phandle(dev->of_node, rd->name, 0);
+		goto end;
+	}
+
+	np = NULL;
+	while ((np = of_graph_get_next_endpoint(dev->of_node, np))) {
+		struct of_endpoint ep;
+
+		of_graph_parse_endpoint(np, &ep);
+		if (ep.port != rd->port)
+			continue;
+		desc->if_id = of_graph_get_remote_port_parent(np);
+		of_node_put(np);
+		break;
+	}
+
+end:
+	return desc->if_id ? 0 : -EINVAL;
+}
+
+static void drm_panel_restrack_destroy(struct device *dev,
+		struct restrack_desc *desc)
+{
+	struct drm_panel_restrack_desc *rd = restrack_desc_to_rd(rd, desc);
+
+	of_node_put(desc->if_id);
+	kfree(rd);
+}
+
+static int drm_panel_restrack_ifup(struct device *dev,
+		struct restrack_desc *desc, void *data)
+{
+	struct drm_panel_restrack_desc *rd = restrack_desc_to_rd(rd, desc);
+
+	*rd->ptr = data;
+	return PTR_ERR_OR_ZERO(*rd->ptr);
+}
+
+static void drm_panel_restrack_ifdown(struct device *dev,
+		struct restrack_desc *desc, void *data)
+{
+	struct drm_panel_restrack_desc *rd = restrack_desc_to_rd(rd, desc);
+
+	*rd->ptr = ERR_PTR(-EPROBE_DEFER);
+}
+
+static const struct restrack_ops drm_panel_restrack_ops = {
+	.if_type = RESTRACK_TYPE_DRM_PANEL,
+	.init = drm_panel_restrack_init,
+	.destroy = drm_panel_restrack_destroy,
+	.if_up = drm_panel_restrack_ifup,
+	.if_down = drm_panel_restrack_ifdown,
+};
+
+/**
+ * drm_panel_restrack_desc - drm_panel resource descriptor allocator
+ * @panel: pointer to variable which will be set to drm_panel handle
+ * @prop_name: property name containing phandle to the panel node, it can be
+ *	       NULL if driver uses only of_graph
+ * @port: of_graph port number in case of_graph is used
+ *
+ * The function creates resource description for panel, which shall be used by
+ * *restrack_register functions.
+ */
+struct restrack_desc *drm_panel_restrack_desc(struct drm_panel **panel,
+		const char *prop_name, int port)
+{
+	struct drm_panel_restrack_desc *rd;
+
+	RESTRACK_DESC_ALLOC(rd, drm_panel_restrack_ops, panel, prop_name);
+	if (!rd)
+		return ERR_PTR(-ENOMEM);
+
+	rd->port = port;
+	return &rd->desc;
+}
+EXPORT_SYMBOL_GPL(drm_panel_restrack_desc);
+
 #endif
 
 MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 1fbcc96..46eb88e 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -130,6 +130,10 @@ int drm_panel_detach(struct drm_panel *panel);
 
 #ifdef CONFIG_OF
 struct drm_panel *of_drm_find_panel(struct device_node *np);
+
+struct restrack_desc;
+struct restrack_desc *drm_panel_restrack_desc(struct drm_panel **panel,
+		const char *prop_name, int port);
 #else
 static inline struct drm_panel *of_drm_find_panel(struct device_node *np)
 {
diff --git a/include/linux/restrack.h b/include/linux/restrack.h
index 6cf8144f..af5b617 100644
--- a/include/linux/restrack.h
+++ b/include/linux/restrack.h
@@ -3,6 +3,8 @@
 
 #include <linux/track.h>
 
+#define RESTRACK_TYPE_DRM_PANEL 1
+
 struct device;
 struct restrack_ctx;
 struct restrack_desc;
-- 
1.9.1
