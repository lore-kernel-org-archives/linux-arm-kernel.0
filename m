From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Apr 2012 17:33:42 +0200
Subject: [PATCH 1/7] drm: remove legacy mode_group handling
In-Reply-To: <1334158428-23735-1-git-send-email-s.hauer@pengutronix.de>
References: <1334158428-23735-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334158428-23735-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During initialization of a drm device a struct drm_mode_group is
filled with the encoder/connector/crtc ids from the corresponding
lists, so the drm_mode_group contains the same data as already is
in the lists. Then in drm_mode_getresources either the lists or
the drm_mode_group are used. As both contain the same data,
we can remove the drm_mode_group and all code around it altogether
without losing functionality.

The legacy mode group handling was introduced for a later support
of for example two X servers running simultaneously in different
control groups on different heads, each with their own mode
configuration.

This code is present and unchanged since the initial drm commit
in 11/2008.  This code is not evolving and currently gets in the
way of implementing a more dynamic (de-)registration of encoders
and connectors. Instead of using an allocated array of pointers
to the components used in a particular control group a better way
would be to use a list instead. This would allow to add/remove
components to a control group without having to reallocate the
array of pointers.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/gpu/drm/drm_crtc.c     |  158 +++++++++-------------------------------
 drivers/gpu/drm/drm_pci.c      |    8 --
 drivers/gpu/drm/drm_platform.c |    8 --
 drivers/gpu/drm/drm_usb.c      |    6 --
 include/drm/drmP.h             |    1 -
 include/drm/drm_crtc.h         |   24 +-----
 6 files changed, 35 insertions(+), 170 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index d3aaeb6..b14496e 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -944,50 +944,6 @@ void drm_mode_config_init(struct drm_device *dev)
 }
 EXPORT_SYMBOL(drm_mode_config_init);
 
-int drm_mode_group_init(struct drm_device *dev, struct drm_mode_group *group)
-{
-	uint32_t total_objects = 0;
-
-	total_objects += dev->mode_config.num_crtc;
-	total_objects += dev->mode_config.num_connector;
-	total_objects += dev->mode_config.num_encoder;
-
-	group->id_list = kzalloc(total_objects * sizeof(uint32_t), GFP_KERNEL);
-	if (!group->id_list)
-		return -ENOMEM;
-
-	group->num_crtcs = 0;
-	group->num_connectors = 0;
-	group->num_encoders = 0;
-	return 0;
-}
-
-int drm_mode_group_init_legacy_group(struct drm_device *dev,
-				     struct drm_mode_group *group)
-{
-	struct drm_crtc *crtc;
-	struct drm_encoder *encoder;
-	struct drm_connector *connector;
-	int ret;
-
-	if ((ret = drm_mode_group_init(dev, group)))
-		return ret;
-
-	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head)
-		group->id_list[group->num_crtcs++] = crtc->base.id;
-
-	list_for_each_entry(encoder, &dev->mode_config.encoder_list, head)
-		group->id_list[group->num_crtcs + group->num_encoders++] =
-		encoder->base.id;
-
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head)
-		group->id_list[group->num_crtcs + group->num_encoders +
-			       group->num_connectors++] = connector->base.id;
-
-	return 0;
-}
-EXPORT_SYMBOL(drm_mode_group_init_legacy_group);
-
 /**
  * drm_mode_config_cleanup - free up DRM mode_config info
  * @dev: DRM device
@@ -1158,7 +1114,6 @@ int drm_mode_getresources(struct drm_device *dev, void *data,
 	uint32_t __user *crtc_id;
 	uint32_t __user *connector_id;
 	uint32_t __user *encoder_id;
-	struct drm_mode_group *mode_group;
 
 	if (!drm_core_check_feature(dev, DRIVER_MODESET))
 		return -EINVAL;
@@ -1172,23 +1127,14 @@ int drm_mode_getresources(struct drm_device *dev, void *data,
 	list_for_each(lh, &file_priv->fbs)
 		fb_count++;
 
-	mode_group = &file_priv->master->minor->mode_group;
-	if (file_priv->master->minor->type == DRM_MINOR_CONTROL) {
-
-		list_for_each(lh, &dev->mode_config.crtc_list)
-			crtc_count++;
-
-		list_for_each(lh, &dev->mode_config.connector_list)
-			connector_count++;
+	list_for_each(lh, &dev->mode_config.crtc_list)
+		crtc_count++;
 
-		list_for_each(lh, &dev->mode_config.encoder_list)
-			encoder_count++;
-	} else {
+	list_for_each(lh, &dev->mode_config.connector_list)
+		connector_count++;
 
-		crtc_count = mode_group->num_crtcs;
-		connector_count = mode_group->num_connectors;
-		encoder_count = mode_group->num_encoders;
-	}
+	list_for_each(lh, &dev->mode_config.encoder_list)
+		encoder_count++;
 
 	card_res->max_height = dev->mode_config.max_height;
 	card_res->min_height = dev->mode_config.min_height;
@@ -1214,25 +1160,14 @@ int drm_mode_getresources(struct drm_device *dev, void *data,
 	if (card_res->count_crtcs >= crtc_count) {
 		copied = 0;
 		crtc_id = (uint32_t __user *)(unsigned long)card_res->crtc_id_ptr;
-		if (file_priv->master->minor->type == DRM_MINOR_CONTROL) {
-			list_for_each_entry(crtc, &dev->mode_config.crtc_list,
-					    head) {
-				DRM_DEBUG_KMS("[CRTC:%d]\n", crtc->base.id);
-				if (put_user(crtc->base.id, crtc_id + copied)) {
-					ret = -EFAULT;
-					goto out;
-				}
-				copied++;
-			}
-		} else {
-			for (i = 0; i < mode_group->num_crtcs; i++) {
-				if (put_user(mode_group->id_list[i],
-					     crtc_id + copied)) {
-					ret = -EFAULT;
-					goto out;
-				}
-				copied++;
+		list_for_each_entry(crtc, &dev->mode_config.crtc_list,
+				    head) {
+			DRM_DEBUG_KMS("[CRTC:%d]\n", crtc->base.id);
+			if (put_user(crtc->base.id, crtc_id + copied)) {
+				ret = -EFAULT;
+				goto out;
 			}
+			copied++;
 		}
 	}
 	card_res->count_crtcs = crtc_count;
@@ -1241,29 +1176,17 @@ int drm_mode_getresources(struct drm_device *dev, void *data,
 	if (card_res->count_encoders >= encoder_count) {
 		copied = 0;
 		encoder_id = (uint32_t __user *)(unsigned long)card_res->encoder_id_ptr;
-		if (file_priv->master->minor->type == DRM_MINOR_CONTROL) {
-			list_for_each_entry(encoder,
-					    &dev->mode_config.encoder_list,
-					    head) {
-				DRM_DEBUG_KMS("[ENCODER:%d:%s]\n", encoder->base.id,
-						drm_get_encoder_name(encoder));
-				if (put_user(encoder->base.id, encoder_id +
-					     copied)) {
-					ret = -EFAULT;
-					goto out;
-				}
-				copied++;
-			}
-		} else {
-			for (i = mode_group->num_crtcs; i < mode_group->num_crtcs + mode_group->num_encoders; i++) {
-				if (put_user(mode_group->id_list[i],
-					     encoder_id + copied)) {
-					ret = -EFAULT;
-					goto out;
-				}
-				copied++;
+		list_for_each_entry(encoder,
+				    &dev->mode_config.encoder_list,
+				    head) {
+			DRM_DEBUG_KMS("[ENCODER:%d:%s]\n", encoder->base.id,
+					drm_get_encoder_name(encoder));
+			if (put_user(encoder->base.id, encoder_id +
+				     copied)) {
+				ret = -EFAULT;
+				goto out;
 			}
-
+			copied++;
 		}
 	}
 	card_res->count_encoders = encoder_count;
@@ -1272,31 +1195,18 @@ int drm_mode_getresources(struct drm_device *dev, void *data,
 	if (card_res->count_connectors >= connector_count) {
 		copied = 0;
 		connector_id = (uint32_t __user *)(unsigned long)card_res->connector_id_ptr;
-		if (file_priv->master->minor->type == DRM_MINOR_CONTROL) {
-			list_for_each_entry(connector,
-					    &dev->mode_config.connector_list,
-					    head) {
-				DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n",
-					connector->base.id,
-					drm_get_connector_name(connector));
-				if (put_user(connector->base.id,
-					     connector_id + copied)) {
-					ret = -EFAULT;
-					goto out;
-				}
-				copied++;
-			}
-		} else {
-			int start = mode_group->num_crtcs +
-				mode_group->num_encoders;
-			for (i = start; i < start + mode_group->num_connectors; i++) {
-				if (put_user(mode_group->id_list[i],
-					     connector_id + copied)) {
-					ret = -EFAULT;
-					goto out;
-				}
-				copied++;
+		list_for_each_entry(connector,
+				    &dev->mode_config.connector_list,
+				    head) {
+			DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n",
+				connector->base.id,
+				drm_get_connector_name(connector));
+			if (put_user(connector->base.id,
+				     connector_id + copied)) {
+				ret = -EFAULT;
+				goto out;
 			}
+			copied++;
 		}
 	}
 	card_res->count_connectors = connector_count;
diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
index 13f3d93..d5424c5 100644
--- a/drivers/gpu/drm/drm_pci.c
+++ b/drivers/gpu/drm/drm_pci.c
@@ -357,14 +357,6 @@ int drm_get_pci_dev(struct pci_dev *pdev, const struct pci_device_id *ent,
 			goto err_g4;
 	}
 
-	/* setup the grouping for the legacy output */
-	if (drm_core_check_feature(dev, DRIVER_MODESET)) {
-		ret = drm_mode_group_init_legacy_group(dev,
-						&dev->primary->mode_group);
-		if (ret)
-			goto err_g4;
-	}
-
 	list_add_tail(&dev->driver_item, &driver->device_list);
 
 	DRM_INFO("Initialized %s %d.%d.%d %s for %s on minor %d\n",
diff --git a/drivers/gpu/drm/drm_platform.c b/drivers/gpu/drm/drm_platform.c
index 82431dc..0c36d63 100644
--- a/drivers/gpu/drm/drm_platform.c
+++ b/drivers/gpu/drm/drm_platform.c
@@ -80,14 +80,6 @@ int drm_get_platform_dev(struct platform_device *platdev,
 			goto err_g3;
 	}
 
-	/* setup the grouping for the legacy output */
-	if (drm_core_check_feature(dev, DRIVER_MODESET)) {
-		ret = drm_mode_group_init_legacy_group(dev,
-				&dev->primary->mode_group);
-		if (ret)
-			goto err_g3;
-	}
-
 	list_add_tail(&dev->driver_item, &driver->device_list);
 
 	mutex_unlock(&drm_global_mutex);
diff --git a/drivers/gpu/drm/drm_usb.c b/drivers/gpu/drm/drm_usb.c
index c8c83da..8c7be4a 100644
--- a/drivers/gpu/drm/drm_usb.c
+++ b/drivers/gpu/drm/drm_usb.c
@@ -43,12 +43,6 @@ int drm_get_usb_dev(struct usb_interface *interface,
 			goto err_g3;
 	}
 
-	/* setup the grouping for the legacy output */
-	ret = drm_mode_group_init_legacy_group(dev,
-					       &dev->primary->mode_group);
-	if (ret)
-		goto err_g3;
-
 	list_add_tail(&dev->driver_item, &driver->device_list);
 
 	mutex_unlock(&drm_global_mutex);
diff --git a/include/drm/drmP.h b/include/drm/drmP.h
index dd73104..fe7884f 100644
--- a/include/drm/drmP.h
+++ b/include/drm/drmP.h
@@ -1032,7 +1032,6 @@ struct drm_minor {
 
 	struct drm_master *master; /* currently active master for this node */
 	struct list_head master_list;
-	struct drm_mode_group mode_group;
 };
 
 /* mode specified on the command line */
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index e250eda..0ac6be0 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -692,28 +692,6 @@ struct drm_mode_config_funcs {
 };
 
 /**
- * drm_mode_group - group of mode setting resources for potential sub-grouping
- * @num_crtcs: CRTC count
- * @num_encoders: encoder count
- * @num_connectors: connector count
- * @id_list: list of KMS object IDs in this group
- *
- * Currently this simply tracks the global mode setting state.  But in the
- * future it could allow groups of objects to be set aside into independent
- * control groups for use by different user level processes (e.g. two X servers
- * running simultaneously on different heads, each with their own mode
- * configuration and freedom of mode setting).
- */
-struct drm_mode_group {
-	uint32_t num_crtcs;
-	uint32_t num_encoders;
-	uint32_t num_connectors;
-
-	/* list of object IDs for this group */
-	uint32_t *id_list;
-};
-
-/**
  * drm_mode_config - Mode configuration control structure
  * @mutex: mutex protecting KMS related lists and structures
  * @idr_mutex: mutex for KMS ID allocation and management
@@ -851,7 +829,7 @@ extern char *drm_get_dvi_i_select_name(int val);
 extern char *drm_get_tv_subconnector_name(int val);
 extern char *drm_get_tv_select_name(int val);
 extern void drm_fb_release(struct drm_file *file_priv);
-extern int drm_mode_group_init_legacy_group(struct drm_device *dev, struct drm_mode_group *group);
+#define HAVE_MODEGROUP_REMOVED
 extern struct edid *drm_get_edid(struct drm_connector *connector,
 				 struct i2c_adapter *adapter);
 extern int drm_add_edid_modes(struct drm_connector *connector, struct edid *edid);
-- 
1.7.9.5
