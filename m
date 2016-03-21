From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 21 Mar 2016 17:38:03 +0800
Subject: [RFC PATCH v1 1/4] drm: rockchip: add a common subdrv interfaces
In-Reply-To: <1458552518-25527-1-git-send-email-ykk@rock-chips.com>
References: <1458552518-25527-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1458553083-26535-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a common subdrv register/unregister interfaces, help
external driver to hook the drm open/close event.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 49 +++++++++++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h | 15 +++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 896da09..4e0feb2 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -36,6 +36,8 @@
 #define DRIVER_MAJOR	1
 #define DRIVER_MINOR	0
 
+static LIST_HEAD(rockchip_drm_subdrv_list);
+
 /*
  * Attach a (component) device to the shared drm dma mapping from master drm
  * device.  This is used by the VOPs to map GEM buffers to a common DMA
@@ -251,6 +253,51 @@ static int rockchip_drm_unload(struct drm_device *drm_dev)
 	return 0;
 }
 
+int rockchip_register_subdrv(struct drm_rockchip_subdrv *subdrv)
+{
+	if (!subdrv)
+		return -EINVAL;
+
+	list_add_tail(&subdrv->list, &rockchip_drm_subdrv_list);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rockchip_register_subdrv);
+
+int rockchip_unregister_subdrv(struct drm_rockchip_subdrv *subdrv)
+{
+	if (!subdrv)
+		return -EINVAL;
+
+	list_del(&subdrv->list);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rockchip_unregister_subdrv);
+
+static int rockchip_drm_open(struct drm_device *dev, struct drm_file *file)
+{
+	struct drm_rockchip_subdrv *subdrv;
+	int ret = 0;
+
+	list_for_each_entry(subdrv, &rockchip_drm_subdrv_list, list) {
+		ret = subdrv->open(dev, subdrv->dev, file);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void rockchip_drm_preclose(struct drm_device *dev,
+				  struct drm_file *file)
+{
+	struct drm_rockchip_subdrv *subdrv;
+
+	list_for_each_entry(subdrv, &rockchip_drm_subdrv_list, list)
+		subdrv->close(dev, subdrv->dev, file);
+}
+
 void rockchip_drm_lastclose(struct drm_device *dev)
 {
 	struct rockchip_drm_private *priv = dev->dev_private;
@@ -281,6 +328,8 @@ static struct drm_driver rockchip_drm_driver = {
 				  DRIVER_PRIME | DRIVER_ATOMIC,
 	.load			= rockchip_drm_load,
 	.unload			= rockchip_drm_unload,
+	.open			= rockchip_drm_open,
+	.preclose		= rockchip_drm_preclose,
 	.lastclose		= rockchip_drm_lastclose,
 	.get_vblank_counter	= drm_vblank_no_hw_counter,
 	.enable_vblank		= rockchip_drm_crtc_enable_vblank,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 3529f69..5ea5fcb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -42,6 +42,17 @@ struct rockchip_crtc_funcs {
 	void (*wait_for_update)(struct drm_crtc *crtc);
 };
 
+struct drm_rockchip_subdrv {
+	struct list_head list;
+	struct device *dev;
+	struct drm_device *drm_dev;
+
+	int (*open)(struct drm_device *drm_dev, struct device *dev,
+		    struct drm_file *file);
+	void (*close)(struct drm_device *drm_dev, struct device *dev,
+		      struct drm_file *file);
+};
+
 struct rockchip_atomic_commit {
 	struct work_struct	work;
 	struct drm_atomic_state *state;
@@ -73,4 +84,8 @@ int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
 				   struct device *dev);
 void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
 				    struct device *dev);
+
+int rockchip_register_subdrv(struct drm_rockchip_subdrv *subdrv);
+int rockchip_unregister_subdrv(struct drm_rockchip_subdrv *subdrv);
+
 #endif /* _ROCKCHIP_DRM_DRV_H_ */
-- 
1.9.1
