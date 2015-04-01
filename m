From: heiko@sntech.de (Heiko Stuebner)
Date: Wed,  1 Apr 2015 12:09:35 +0200
Subject: [PATCH RFC v2 01/12] drm/encoder: add functionality to register
 encoders to a global list
In-Reply-To: <1427882986-19110-1-git-send-email-heiko@sntech.de>
References: <1427882986-19110-1-git-send-email-heiko@sntech.de>
Message-ID: <1427882986-19110-2-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows standalone encoders to be registered and found again
through their devicetree node when going through their connection graph.

Setting the of_node property is of course still optional, as it is not
necessary in most cases to lookup encoders that are part of a bigger
component.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/drm_crtc.c | 41 +++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_crtc.h     |  8 ++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index f6d04c7..b63e69d 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -1066,6 +1066,47 @@ void drm_connector_unplug_all(struct drm_device *dev)
 }
 EXPORT_SYMBOL(drm_connector_unplug_all);
 
+static DEFINE_MUTEX(encoder_lock);
+static LIST_HEAD(encoder_list);
+
+int drm_encoder_add(struct drm_encoder *encoder)
+{
+	mutex_lock(&encoder_lock);
+	list_add_tail(&encoder->list, &encoder_list);
+	mutex_unlock(&encoder_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_encoder_add);
+
+void drm_encoder_remove(struct drm_encoder *encoder)
+{
+	mutex_lock(&encoder_lock);
+	list_del_init(&encoder->list);
+	mutex_unlock(&encoder_lock);
+}
+EXPORT_SYMBOL(drm_encoder_remove);
+
+#ifdef CONFIG_OF
+struct drm_encoder *of_drm_find_encoder(struct device_node *np)
+{
+	struct drm_encoder *encoder;
+
+	mutex_lock(&encoder_lock);
+
+	list_for_each_entry(encoder, &encoder_list, list) {
+		if (encoder->of_node == np) {
+			mutex_unlock(&encoder_lock);
+			return encoder;
+		}
+	}
+
+	mutex_unlock(&encoder_lock);
+	return NULL;
+}
+EXPORT_SYMBOL(of_drm_find_encoder);
+#endif
+
 /**
  * drm_encoder_init - Init a preallocated encoder
  * @dev: drm device
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 920e21a..76994ba 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -569,6 +569,7 @@ struct drm_encoder_funcs {
 /**
  * struct drm_encoder - central DRM encoder structure
  * @dev: parent DRM device
+ * @of_node: device node pointer to the bridge
  * @head: list management
  * @base: base KMS object
  * @name: encoder name
@@ -585,6 +586,10 @@ struct drm_encoder_funcs {
  */
 struct drm_encoder {
 	struct drm_device *dev;
+#ifdef CONFIG_OF
+	struct device_node *of_node;
+#endif
+	struct list_head list;
 	struct list_head head;
 
 	struct drm_mode_object base;
@@ -1225,6 +1230,9 @@ extern void drm_bridge_remove(struct drm_bridge *bridge);
 extern struct drm_bridge *of_drm_find_bridge(struct device_node *np);
 extern int drm_bridge_attach(struct drm_device *dev, struct drm_bridge *bridge);
 
+extern int drm_encoder_add(struct drm_encoder *encoder);
+extern void drm_encoder_remove(struct drm_encoder *encoder);
+extern struct drm_encoder *of_drm_find_encoder(struct device_node *np);
 extern int drm_encoder_init(struct drm_device *dev,
 			    struct drm_encoder *encoder,
 			    const struct drm_encoder_funcs *funcs,
-- 
2.1.4
