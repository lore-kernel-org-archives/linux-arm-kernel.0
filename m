From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue, 19 Apr 2016 11:17:24 +0800
Subject: [PATCH] drm/rockchip: rewrite IOMMU support code
In-Reply-To: <1455870164-25337-1-git-send-email-m.szyprowski@samsung.com>
References: <1455870164-25337-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1461035844-23026-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is base on Marek Szyprowski's patch:
	[RFC 0/3] Unify IOMMU-based DMA-mapping code for ARM and ARM64
	[https://lkml.org/lkml/2016/2/19/79]

And the patch is learn from Marek Szyprowski's exynos patch:
  (drm/exynos: rewrite IOMMU support code)

The patch replaces usage of ARM-specific IOMMU/DMA-mapping related calls
with new generic code for managing DMA-IOMMU integration layer. It also
removes all the hacks, which were needed to configure common DMA/IO address
space on the virtual rockchip-drm device.

This patch now works on Rockchip ARM64 rk3399 platform.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/Kconfig            |    3 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |   81 +++++++++++++++++++--------
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |    1 +
 3 files changed, 60 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index d4c6a89..731f5c3 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -1,7 +1,6 @@
 config DRM_ROCKCHIP
 	tristate "DRM Support for Rockchip"
-	depends on BROKEN
-	depends on DRM && ROCKCHIP_IOMMU
+	depends on DRM && IOMMU_DMA
 	depends on RESET_CONTROLLER
 	select DRM_KMS_HELPER
 	select DRM_KMS_FB_HELPER
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 7176483..772bca3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -14,7 +14,7 @@
  * GNU General Public License for more details.
  */
 
-#include <asm/dma-iommu.h>
+#include <linux/dma-iommu.h>
 
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
@@ -44,7 +44,8 @@
 int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
 				   struct device *dev)
 {
-	struct dma_iommu_mapping *mapping = drm_dev->dev->archdata.mapping;
+	struct rockchip_drm_private *private = drm_dev->dev_private;
+	struct iommu_domain *domain = private->domain;
 	int ret;
 
 	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
@@ -52,14 +53,28 @@ int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
 		return ret;
 
 	dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
+	ret = iommu_attach_device(domain, dev);
+	if (ret) {
+		dev_err(dev, "Failed to attach iommu device\n");
+		return ret;
+	}
 
-	return arm_iommu_attach_device(dev, mapping);
+	if (!common_iommu_setup_dma_ops(dev, 0x10000000, SZ_2G, domain->ops)) {
+		dev_err(dev, "Failed to set dma_ops\n");
+		iommu_detach_device(domain, dev);
+		ret = -ENODEV;
+	}
+
+	return ret;
 }
 
 void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
 				    struct device *dev)
 {
-	arm_iommu_detach_device(dev);
+	struct rockchip_drm_private *private = drm_dev->dev_private;
+	struct iommu_domain *domain = private->domain;
+
+	iommu_detach_device(domain, dev);
 }
 
 int rockchip_register_crtc_funcs(struct drm_crtc *crtc,
@@ -127,9 +142,9 @@ static void rockchip_drm_crtc_disable_vblank(struct drm_device *dev,
 static int rockchip_drm_load(struct drm_device *drm_dev, unsigned long flags)
 {
 	struct rockchip_drm_private *private;
-	struct dma_iommu_mapping *mapping;
 	struct device *dev = drm_dev->dev;
 	struct drm_connector *connector;
+	struct iommu_group *group;
 	int ret;
 
 	private = devm_kzalloc(drm_dev->dev, sizeof(*private), GFP_KERNEL);
@@ -152,23 +167,36 @@ static int rockchip_drm_load(struct drm_device *drm_dev, unsigned long flags)
 		goto err_config_cleanup;
 	}
 
-	/* TODO(djkurtz): fetch the mapping start/size from somewhere */
-	mapping = arm_iommu_create_mapping(&platform_bus_type, 0x00000000,
-					   SZ_2G);
-	if (IS_ERR(mapping)) {
-		ret = PTR_ERR(mapping);
-		goto err_config_cleanup;
-	}
+	private->domain = iommu_domain_alloc(&platform_bus_type);
+	if (!private->domain)
+		return -ENOMEM;
 
-	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	ret = iommu_get_dma_cookie(private->domain);
 	if (ret)
-		goto err_release_mapping;
-
-	dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
+		goto err_free_domain;
+
+	group = iommu_group_get(dev);
+	if (!group) {
+		group = iommu_group_alloc();
+		if (IS_ERR(group)) {
+			dev_err(dev, "Failed to allocate IOMMU group\n");
+			goto err_put_cookie;
+		}
 
-	ret = arm_iommu_attach_device(dev, mapping);
+		ret = iommu_group_add_device(group, dev);
+		iommu_group_put(group);
+		if (ret) {
+			dev_err(dev, "failed to add device to IOMMU group\n");
+			goto err_put_cookie;
+		}
+	}
+	/*
+	 * Attach virtual iommu device, sub iommu device can share the same
+	 * mapping with it.
+	 */
+	ret = rockchip_drm_dma_attach_device(drm_dev, dev);
 	if (ret)
-		goto err_release_mapping;
+		goto err_group_remove_device;
 
 	/* Try to bind all sub drivers. */
 	ret = component_bind_all(dev, drm_dev);
@@ -226,9 +254,13 @@ err_kms_helper_poll_fini:
 err_unbind:
 	component_unbind_all(dev, drm_dev);
 err_detach_device:
-	arm_iommu_detach_device(dev);
-err_release_mapping:
-	arm_iommu_release_mapping(dev->archdata.mapping);
+	rockchip_drm_dma_detach_device(drm_dev, dev);
+err_group_remove_device:
+	iommu_group_remove_device(dev);
+err_put_cookie:
+	iommu_put_dma_cookie(private->domain);
+err_free_domain:
+	iommu_domain_free(private->domain);
 err_config_cleanup:
 	drm_mode_config_cleanup(drm_dev);
 	drm_dev->dev_private = NULL;
@@ -238,13 +270,16 @@ err_config_cleanup:
 static int rockchip_drm_unload(struct drm_device *drm_dev)
 {
 	struct device *dev = drm_dev->dev;
+	struct rockchip_drm_private *private = drm_dev->dev_private;
 
 	rockchip_drm_fbdev_fini(drm_dev);
 	drm_vblank_cleanup(drm_dev);
 	drm_kms_helper_poll_fini(drm_dev);
 	component_unbind_all(dev, drm_dev);
-	arm_iommu_detach_device(dev);
-	arm_iommu_release_mapping(dev->archdata.mapping);
+	rockchip_drm_dma_detach_device(drm_dev, dev);
+	iommu_group_remove_device(dev);
+	iommu_put_dma_cookie(private->domain);
+	iommu_domain_free(private->domain);
 	drm_mode_config_cleanup(drm_dev);
 	drm_dev->dev_private = NULL;
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 234cec2..2677b95 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -62,6 +62,7 @@ struct rockchip_drm_private {
 	const struct rockchip_crtc_funcs *crtc_funcs[ROCKCHIP_MAX_CRTC];
 
 	struct rockchip_atomic_commit commit;
+	struct iommu_domain *domain;
 };
 
 void rockchip_drm_atomic_work(struct work_struct *work);
-- 
1.7.9.5
