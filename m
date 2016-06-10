From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Fri, 10 Jun 2016 13:14:13 +0200
Subject: [PATCH] drm/rockchip: Drop drm_driver.load/unload callbacks
Message-ID: <1465557253-10670-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

They are deprecated and by moving their implementations to bind/unbind
we can call drm_connector_register_all instead of open-coding it.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 87 ++++++++++-------------------
 1 file changed, 30 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index f5a68fc031ed..8202c0634e4c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -37,6 +37,7 @@
 #define DRIVER_MINOR	0
 
 static bool is_support_iommu = true;
+static struct drm_driver rockchip_drm_driver;
 
 /*
  * Attach a (component) device to the shared drm dma mapping from master drm
@@ -132,18 +133,29 @@ static void rockchip_drm_crtc_disable_vblank(struct drm_device *dev,
 		priv->crtc_funcs[pipe]->disable_vblank(crtc);
 }
 
-static int rockchip_drm_load(struct drm_device *drm_dev, unsigned long flags)
+static int rockchip_drm_bind(struct device *dev)
 {
+	struct drm_device *drm_dev;
 	struct rockchip_drm_private *private;
 	struct dma_iommu_mapping *mapping = NULL;
-	struct device *dev = drm_dev->dev;
-	struct drm_connector *connector;
 	int ret;
 
-	private = devm_kzalloc(drm_dev->dev, sizeof(*private), GFP_KERNEL);
-	if (!private)
+	drm_dev = drm_dev_alloc(&rockchip_drm_driver, dev);
+	if (!drm_dev)
 		return -ENOMEM;
 
+	ret = drm_dev_register(drm_dev, 0);
+	if (ret)
+		goto err_free;
+
+	dev_set_drvdata(dev, drm_dev);
+
+	private = devm_kzalloc(drm_dev->dev, sizeof(*private), GFP_KERNEL);
+	if (!private) {
+		ret = -ENOMEM;
+		goto err_unregister;
+	}
+
 	mutex_init(&private->commit.lock);
 	INIT_WORK(&private->commit.work, rockchip_drm_atomic_work);
 
@@ -186,21 +198,10 @@ static int rockchip_drm_load(struct drm_device *drm_dev, unsigned long flags)
 	if (ret)
 		goto err_detach_device;
 
-	/*
-	 * All components are now added, we can publish the connector sysfs
-	 * entries to userspace.  This will generate hotplug events and so
-	 * userspace will expect to be able to access DRM at this point.
-	 */
-	list_for_each_entry(connector, &drm_dev->mode_config.connector_list,
-			head) {
-		ret = drm_connector_register(connector);
-		if (ret) {
-			dev_err(drm_dev->dev,
-				"[CONNECTOR:%d:%s] drm_connector_register failed: %d\n",
-				connector->base.id,
-				connector->name, ret);
-			goto err_unbind;
-		}
+	ret = drm_connector_register_all(drm_dev);
+	if (ret) {
+		dev_err(dev, "failed to register connectors\n");
+		goto err_unbind;
 	}
 
 	/* init kms poll for handling hpd */
@@ -240,12 +241,16 @@ err_release_mapping:
 err_config_cleanup:
 	drm_mode_config_cleanup(drm_dev);
 	drm_dev->dev_private = NULL;
+err_unregister:
+	drm_dev_unregister(drm_dev);
+err_free:
+	drm_dev_unref(drm_dev);
 	return ret;
 }
 
-static int rockchip_drm_unload(struct drm_device *drm_dev)
+static void rockchip_drm_unbind(struct device *dev)
 {
-	struct device *dev = drm_dev->dev;
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
 	rockchip_drm_fbdev_fini(drm_dev);
 	drm_vblank_cleanup(drm_dev);
@@ -255,8 +260,9 @@ static int rockchip_drm_unload(struct drm_device *drm_dev)
 		arm_iommu_detach_device(dev);
 	drm_mode_config_cleanup(drm_dev);
 	drm_dev->dev_private = NULL;
-
-	return 0;
+	drm_dev_unregister(drm_dev);
+	drm_dev_unref(drm_dev);
+	dev_set_drvdata(dev, NULL);
 }
 
 static void rockchip_drm_crtc_cancel_pending_vblank(struct drm_crtc *crtc,
@@ -308,8 +314,6 @@ const struct vm_operations_struct rockchip_drm_vm_ops = {
 static struct drm_driver rockchip_drm_driver = {
 	.driver_features	= DRIVER_MODESET | DRIVER_GEM |
 				  DRIVER_PRIME | DRIVER_ATOMIC,
-	.load			= rockchip_drm_load,
-	.unload			= rockchip_drm_unload,
 	.preclose		= rockchip_drm_preclose,
 	.lastclose		= rockchip_drm_lastclose,
 	.get_vblank_counter	= drm_vblank_no_hw_counter,
@@ -449,37 +453,6 @@ static void rockchip_add_endpoints(struct device *dev,
 	}
 }
 
-static int rockchip_drm_bind(struct device *dev)
-{
-	struct drm_device *drm;
-	int ret;
-
-	drm = drm_dev_alloc(&rockchip_drm_driver, dev);
-	if (!drm)
-		return -ENOMEM;
-
-	ret = drm_dev_register(drm, 0);
-	if (ret)
-		goto err_free;
-
-	dev_set_drvdata(dev, drm);
-
-	return 0;
-
-err_free:
-	drm_dev_unref(drm);
-	return ret;
-}
-
-static void rockchip_drm_unbind(struct device *dev)
-{
-	struct drm_device *drm = dev_get_drvdata(dev);
-
-	drm_dev_unregister(drm);
-	drm_dev_unref(drm);
-	dev_set_drvdata(dev, NULL);
-}
-
 static const struct component_master_ops rockchip_drm_ops = {
 	.bind = rockchip_drm_bind,
 	.unbind = rockchip_drm_unbind,
-- 
2.5.5
