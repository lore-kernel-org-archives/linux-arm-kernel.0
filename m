From: ykk@rock-chips.com (Yakir Yang)
Date: Sun, 22 Nov 2015 21:42:48 +0800
Subject: [RFC PATCH v1 1/2] drm: Add Content Protection properties to drm
In-Reply-To: <1448199077-10221-1-git-send-email-ykk@rock-chips.com>
References: <1448199077-10221-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1448199768-5066-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Paul <seanpaul@chromium.org>

Add new standard connector properties to track whether content protection
(ex: hdcp) is desired by userspace. There are two properties involved,
"Content Protection" and "Content Protection KSV".

The "Content Protection" property allows userspace to request protection
on a connector. Set "Desired" to enable, "Undesired" to disable.

The "Content Protection KSV" property reflects the current state of
protection. If the KSV is 0, the connection is not protected. Once the
driver has enabled protection, it will update the the value with the KSV
(or similarly unique identifier, if not using HDCP) of the first-hop
device (sink or repeater).

Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 drivers/gpu/drm/drm_crtc.c  | 21 +++++++++++++++++++++
 drivers/gpu/drm/drm_sysfs.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_crtc.h      |  3 +++
 include/uapi/drm/drm_mode.h |  4 ++++
 4 files changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 32dd134..de7ae6a 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -78,6 +78,13 @@ static const struct drm_prop_enum_list drm_plane_type_enum_list[] = {
 	{ DRM_PLANE_TYPE_CURSOR, "Cursor" },
 };
 
+static struct drm_prop_enum_list drm_cp_enum_list[] = {
+	{ DRM_MODE_CONTENT_PROTECTION_UNDESIRED, "Undesired" },
+	{ DRM_MODE_CONTENT_PROTECTION_DESIRED, "Desired" },
+};
+
+DRM_ENUM_NAME_FN(drm_get_content_protection_name, drm_cp_enum_list)
+
 /*
  * Optional properties
  */
@@ -1470,6 +1477,20 @@ static int drm_mode_create_standard_properties(struct drm_device *dev)
 		return -ENOMEM;
 	dev->mode_config.prop_mode_id = prop;
 
+	prop = drm_property_create_enum(dev, 0,
+					"Content Protection", drm_cp_enum_list,
+					ARRAY_SIZE(drm_cp_enum_list));
+	if (!prop)
+		return -ENOMEM;
+	dev->mode_config.content_protection_property = prop;
+
+	prop = drm_property_create_range(dev, DRM_MODE_PROP_IMMUTABLE,
+					 "Content Protection KSV", 0,
+					 0xFFFFFFFFFF);
+	if (!prop)
+		return -ENOMEM;
+	dev->mode_config.content_protection_ksv_property = prop;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index c75f022..dc122b8 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -248,6 +248,48 @@ static ssize_t enabled_show(struct device *device,
 			"disabled");
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
+	prop = dev->mode_config.content_protection_property;
+	if (!prop)
+		return 0;
+
+	ret = drm_object_property_get_value(&connector->base, prop, &cp);
+	if (ret)
+		return 0;
+
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			drm_get_content_protection_name((int)cp));
+}
+
+static ssize_t content_protection_ksv_show(struct device *device,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct drm_connector *connector = to_drm_connector(device);
+	struct drm_device *dev = connector->dev;
+	struct drm_property *prop;
+	uint64_t ksv;
+	int ret;
+
+	prop = dev->mode_config.content_protection_ksv_property;
+	if (!prop)
+		return 0;
+
+	ret = drm_object_property_get_value(&connector->base, prop, &ksv);
+	if (ret)
+		return 0;
+
+	return snprintf(buf, PAGE_SIZE, "%llx\n", ksv);
+}
+
 static ssize_t edid_show(struct file *filp, struct kobject *kobj,
 			 struct bin_attribute *attr, char *buf, loff_t off,
 			 size_t count)
@@ -399,12 +441,16 @@ static DEVICE_ATTR_RW(status);
 static DEVICE_ATTR_RO(enabled);
 static DEVICE_ATTR_RO(dpms);
 static DEVICE_ATTR_RO(modes);
+static DEVICE_ATTR_RO(content_protection);
+static DEVICE_ATTR_RO(content_protection_ksv);
 
 static struct attribute *connector_dev_attrs[] = {
 	&dev_attr_status.attr,
 	&dev_attr_enabled.attr,
 	&dev_attr_dpms.attr,
 	&dev_attr_modes.attr,
+	&dev_attr_content_protection.attr,
+	&dev_attr_content_protection_ksv.attr,
 	NULL
 };
 
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 173535a..ba2bc37 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -1118,6 +1118,8 @@ struct drm_mode_config {
 	struct drm_property *prop_crtc_id;
 	struct drm_property *prop_active;
 	struct drm_property *prop_mode_id;
+	struct drm_property *content_protection_property;
+	struct drm_property *content_protection_ksv_property;
 
 	/* DVI-I properties */
 	struct drm_property *dvi_i_subconnector_property;
@@ -1286,6 +1288,7 @@ extern void drm_encoder_cleanup(struct drm_encoder *encoder);
 extern const char *drm_get_connector_status_name(enum drm_connector_status status);
 extern const char *drm_get_subpixel_order_name(enum subpixel_order order);
 extern const char *drm_get_dpms_name(int val);
+extern const char *drm_get_content_protection_name(int val);
 extern const char *drm_get_dvi_i_subconnector_name(int val);
 extern const char *drm_get_dvi_i_select_name(int val);
 extern const char *drm_get_tv_subconnector_name(int val);
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 6c11ca4..7b08342 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -81,6 +81,10 @@
 #define DRM_MODE_DPMS_SUSPEND	2
 #define DRM_MODE_DPMS_OFF	3
 
+/* Content Protection Flags */
+#define DRM_MODE_CONTENT_PROTECTION_UNDESIRED   0
+#define DRM_MODE_CONTENT_PROTECTION_DESIRED     1
+
 /* Scaling mode options */
 #define DRM_MODE_SCALE_NONE		0 /* Unmodified timing (display or
 					     software can still scale) */
-- 
1.9.1
