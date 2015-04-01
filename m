From: heiko@sntech.de (Heiko Stuebner)
Date: Wed,  1 Apr 2015 12:09:36 +0200
Subject: [PATCH RFC v2 02/12] drm/connector: add functionality to register
 connectors to a global list
In-Reply-To: <1427882986-19110-1-git-send-email-heiko@sntech.de>
References: <1427882986-19110-1-git-send-email-heiko@sntech.de>
Message-ID: <1427882986-19110-3-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows standalone connectors to be registered and found again
through their devicetree node when going through their connection graph.

Setting the of_node property is of course still optional, as it is not
necessary in most cases to lookup connectors that are part of a bigger
component.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/drm_crtc.c | 41 +++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_crtc.h     |  7 +++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index b63e69d..8b49ea7 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -852,6 +852,47 @@ static void drm_connector_get_cmdline_mode(struct drm_connector *connector)
 		      mode->interlace ?  " interlaced" : "");
 }
 
+static DEFINE_MUTEX(connector_lock);
+static LIST_HEAD(connector_list);
+
+int drm_connector_add(struct drm_connector *connector)
+{
+	mutex_lock(&connector_lock);
+	list_add_tail(&connector->list, &connector_list);
+	mutex_unlock(&connector_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_add);
+
+void drm_connector_remove(struct drm_connector *connector)
+{
+	mutex_lock(&connector_lock);
+	list_del_init(&connector->list);
+	mutex_unlock(&connector_lock);
+}
+EXPORT_SYMBOL(drm_connector_remove);
+
+#ifdef CONFIG_OF
+struct drm_connector *of_drm_find_connector(struct device_node *np)
+{
+	struct drm_connector *connector;
+
+	mutex_lock(&connector_lock);
+
+	list_for_each_entry(connector, &connector_list, list) {
+		if (connector->of_node == np) {
+			mutex_unlock(&connector_lock);
+			return connector;
+		}
+	}
+
+	mutex_unlock(&connector_lock);
+	return NULL;
+}
+EXPORT_SYMBOL(of_drm_find_connector);
+#endif
+
 /**
  * drm_connector_init - Init a preallocated connector
  * @dev: DRM device
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 76994ba..37b230b 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -671,6 +671,10 @@ struct drm_encoder {
  */
 struct drm_connector {
 	struct drm_device *dev;
+#ifdef CONFIG_OF
+	struct device_node *of_node;
+#endif
+	struct list_head list;
 	struct device *kdev;
 	struct device_attribute *attr;
 	struct list_head head;
@@ -1213,6 +1217,9 @@ static inline uint32_t drm_crtc_mask(struct drm_crtc *crtc)
 
 extern void drm_connector_ida_init(void);
 extern void drm_connector_ida_destroy(void);
+extern int drm_connector_add(struct drm_connector *connector);
+extern void drm_connector_remove(struct drm_connector *connector);
+extern struct drm_connector *of_drm_find_connector(struct device_node *np);
 extern int drm_connector_init(struct drm_device *dev,
 			      struct drm_connector *connector,
 			      const struct drm_connector_funcs *funcs,
-- 
2.1.4
