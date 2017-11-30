From: seanpaul@chromium.org (Sean Paul)
Date: Wed, 29 Nov 2017 22:08:56 -0500
Subject: [RFC PATCH 1/6] drm: Add Content Protection property
In-Reply-To: <20171130030907.26848-1-seanpaul@chromium.org>
References: <20171130030907.26848-1-seanpaul@chromium.org>
Message-ID: <20171130030907.26848-2-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a new optional connector property to allow userspace to enable
protection over the content it is displaying. This will typically be implemented
by the driver using HDCP.

The property is a tri-state with the following values:
- OFF: Self explanatory, no content protection
- DESIRED: Userspace requests that the driver enable protection
- ENABLED: Once the driver has authenticated the link, it sets this value

The driver is responsible for downgrading ENABLED to DESIRED if the link becomes
unprotected. The driver should also maintain the desiredness of protection
across hotplug/dpms/suspend.

If this looks familiar, I posted [1] this 3 years ago. We have been using this
in ChromeOS across exynos, mediatek, and rockchip over that time.

Signed-off-by: Sean Paul <seanpaul@chromium.org>

[1] https://lists.freedesktop.org/archives/dri-devel/2014-December/073336.html
---
 drivers/gpu/drm/drm_atomic.c    |  8 ++++++++
 drivers/gpu/drm/drm_connector.c | 43 +++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_sysfs.c     | 29 +++++++++++++++++++++++++++
 include/drm/drm_connector.h     | 16 +++++++++++++++
 include/uapi/drm/drm_mode.h     |  4 ++++
 5 files changed, 100 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 37445d50816a..2212793eefa6 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1185,6 +1185,12 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
 		state->picture_aspect_ratio = val;
 	} else if (property == connector->scaling_mode_property) {
 		state->scaling_mode = val;
+	} else if (property == connector->content_protection_property) {
+		if (val == DRM_MODE_CONTENT_PROTECTION_ENABLED) {
+			DRM_DEBUG_KMS("only drivers can set CP Enabled\n");
+			return -EINVAL;
+		}
+		state->content_protection = val;
 	} else if (connector->funcs->atomic_set_property) {
 		return connector->funcs->atomic_set_property(connector,
 				state, property, val);
@@ -1264,6 +1270,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
 		*val = state->picture_aspect_ratio;
 	} else if (property == connector->scaling_mode_property) {
 		*val = state->scaling_mode;
+	} else if (property == connector->content_protection_property) {
+		*val = state->content_protection;
 	} else if (connector->funcs->atomic_get_property) {
 		return connector->funcs->atomic_get_property(connector,
 				state, property, val);
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 704fc8934616..de2345a4a125 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -698,6 +698,13 @@ static const struct drm_prop_enum_list drm_tv_subconnector_enum_list[] = {
 DRM_ENUM_NAME_FN(drm_get_tv_subconnector_name,
 		 drm_tv_subconnector_enum_list)
 
+static struct drm_prop_enum_list drm_cp_enum_list[] = {
+        { DRM_MODE_CONTENT_PROTECTION_OFF, "Off" },
+        { DRM_MODE_CONTENT_PROTECTION_DESIRED, "Desired" },
+        { DRM_MODE_CONTENT_PROTECTION_ENABLED, "Enabled" },
+};
+DRM_ENUM_NAME_FN(drm_get_content_protection_name, drm_cp_enum_list)
+
 /**
  * DOC: standard connector properties
  *
@@ -1046,6 +1053,42 @@ int drm_connector_attach_scaling_mode_property(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_connector_attach_scaling_mode_property);
 
+/**
+ * drm_connector_attach_content_protection_property - attach content protection
+ * property
+ *
+ * @connector: connector to attach CP property on.
+ *
+ * This is used to add support for content protection on select connectors.
+ * Content Protection is intentionally vague to allow for different underlying
+ * technologies, however it is most implemented by HDCP.
+ *
+ * The content protection will be set to &drm_connector_state.content_protection
+ *
+ * Returns:
+ * Zero on success, negative errno on failure.
+ */
+int drm_connector_attach_content_protection_property(
+		struct drm_connector *connector)
+{
+	struct drm_device *dev = connector->dev;
+	struct drm_property *prop;
+
+	prop = drm_property_create_enum(dev, 0, "Content Protection",
+					drm_cp_enum_list,
+					ARRAY_SIZE(drm_cp_enum_list));
+	if (!prop)
+		return -ENOMEM;
+
+	drm_object_attach_property(&connector->base, prop,
+				   DRM_MODE_CONTENT_PROTECTION_OFF);
+
+	connector->content_protection_property = prop;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_attach_content_protection_property);
+
 /**
  * drm_mode_create_aspect_ratio_property - create aspect ratio property
  * @dev: DRM device
diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index 1c5b5ce1fd7f..e8e15756dc59 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -21,6 +21,7 @@
 #include <drm/drm_sysfs.h>
 #include <drm/drmP.h>
 #include "drm_internal.h"
+#include "drm_crtc_internal.h"
 
 #define to_drm_minor(d) dev_get_drvdata(d)
 #define to_drm_connector(d) dev_get_drvdata(d)
@@ -229,16 +230,44 @@ static ssize_t modes_show(struct device *device,
 	return written;
 }
 
+static ssize_t content_protection_show(struct device *device,
+				       struct device_attribute *attr, char *buf)
+{
+	struct drm_connector *connector = to_drm_connector(device);
+	struct drm_device *dev = connector->dev;
+	struct drm_property *prop;
+	uint64_t cp;
+	int ret;
+
+	drm_modeset_lock_all(dev);
+
+	prop = connector->content_protection_property;
+	if (!prop) {
+		drm_modeset_unlock_all(dev);
+		return 0;
+	}
+
+	ret = drm_object_property_get_value(&connector->base, prop, &cp);
+	drm_modeset_unlock_all(dev);
+	if (ret)
+		return 0;
+
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			drm_get_content_protection_name((int)cp));
+}
+
 static DEVICE_ATTR_RW(status);
 static DEVICE_ATTR_RO(enabled);
 static DEVICE_ATTR_RO(dpms);
 static DEVICE_ATTR_RO(modes);
+static DEVICE_ATTR_RO(content_protection);
 
 static struct attribute *connector_dev_attrs[] = {
 	&dev_attr_status.attr,
 	&dev_attr_enabled.attr,
 	&dev_attr_dpms.attr,
 	&dev_attr_modes.attr,
+	&dev_attr_content_protection.attr,
 	NULL
 };
 
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 1543212b0449..ec6ea3953002 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -375,6 +375,12 @@ struct drm_connector_state {
 	 * upscaling, mostly used for built-in panels.
 	 */
 	unsigned int scaling_mode;
+
+	/**
+	 * @content_protection: Connector property to request content
+	 * protection. This is most commonly used for HDCP.
+	 */
+	unsigned int content_protection;
 };
 
 /**
@@ -722,6 +728,7 @@ struct drm_cmdline_mode {
  * @tile_h_size: horizontal size of this tile.
  * @tile_v_size: vertical size of this tile.
  * @scaling_mode_property:  Optional atomic property to control the upscaling.
+ * @content_protection_property: Optional property to control content protection
  *
  * Each connector may be connected to one or more CRTCs, or may be clonable by
  * another connector if they can share a CRTC.  Each connector also has a specific
@@ -812,6 +819,12 @@ struct drm_connector {
 
 	struct drm_property *scaling_mode_property;
 
+	/**
+	 * @content_protection_property: DRM ENUM property for content
+	 * protection
+	 */
+	struct drm_property *content_protection_property;
+
 	/**
 	 * @path_blob_ptr:
 	 *
@@ -1012,6 +1025,7 @@ const char *drm_get_dvi_i_subconnector_name(int val);
 const char *drm_get_dvi_i_select_name(int val);
 const char *drm_get_tv_subconnector_name(int val);
 const char *drm_get_tv_select_name(int val);
+const char *drm_get_content_protection_name(int val);
 
 int drm_mode_create_dvi_i_properties(struct drm_device *dev);
 int drm_mode_create_tv_properties(struct drm_device *dev,
@@ -1020,6 +1034,8 @@ int drm_mode_create_tv_properties(struct drm_device *dev,
 int drm_mode_create_scaling_mode_property(struct drm_device *dev);
 int drm_connector_attach_scaling_mode_property(struct drm_connector *connector,
 					       u32 scaling_mode_mask);
+int drm_connector_attach_content_protection_property(
+		struct drm_connector *connector);
 int drm_mode_create_aspect_ratio_property(struct drm_device *dev);
 int drm_mode_create_suggested_offset_properties(struct drm_device *dev);
 
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 5597a87154e5..03f4d22305c2 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -173,6 +173,10 @@ extern "C" {
 		DRM_MODE_REFLECT_X | \
 		DRM_MODE_REFLECT_Y)
 
+/* Content Protection Flags */
+#define DRM_MODE_CONTENT_PROTECTION_OFF		0
+#define DRM_MODE_CONTENT_PROTECTION_DESIRED     1
+#define DRM_MODE_CONTENT_PROTECTION_ENABLED     2
 
 struct drm_mode_modeinfo {
 	__u32 clock;
-- 
2.15.0.531.g2ccb3012c9-goog
