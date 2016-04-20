From: mark.yao@rock-chips.com (Mark Yao)
Date: Wed, 20 Apr 2016 10:53:33 +0800
Subject: [PATCH v2] drm/rockchip: support non-iommu buffer path
In-Reply-To: <1461032372-14630-1-git-send-email-mark.yao@rock-chips.com>
References: <1461032372-14630-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1461120813-1117-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some rockchip vop not support iommu, need use non-iommu
buffer for it. And if we get iommu issues, we can compare
the issues with non-iommu path, the would help the debug.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
Changes in v2
Advised by Heiko Stuebner
- use more suitable message print.

 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |   64 +++++++++++++++++++--------
 1 file changed, 46 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index f556a8f..00aa175 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -36,6 +36,8 @@
 #define DRIVER_MAJOR	1
 #define DRIVER_MINOR	0
 
+static bool is_support_iommu = true;
+
 /*
  * Attach a (component) device to the shared drm dma mapping from master drm
  * device.  This is used by the VOPs to map GEM buffers to a common DMA
@@ -47,6 +49,9 @@ int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
 	struct dma_iommu_mapping *mapping = drm_dev->dev->archdata.mapping;
 	int ret;
 
+	if (!is_support_iommu)
+		return 0;
+
 	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
@@ -59,6 +64,9 @@ int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
 void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
 				    struct device *dev)
 {
+	if (!is_support_iommu)
+		return;
+
 	arm_iommu_detach_device(dev);
 }
 
@@ -152,23 +160,26 @@ static int rockchip_drm_load(struct drm_device *drm_dev, unsigned long flags)
 		goto err_config_cleanup;
 	}
 
-	/* TODO(djkurtz): fetch the mapping start/size from somewhere */
-	mapping = arm_iommu_create_mapping(&platform_bus_type, 0x00000000,
-					   SZ_2G);
-	if (IS_ERR(mapping)) {
-		ret = PTR_ERR(mapping);
-		goto err_config_cleanup;
-	}
+	if (is_support_iommu) {
+		/* TODO(djkurtz): fetch the mapping start/size from somewhere */
+		mapping = arm_iommu_create_mapping(&platform_bus_type,
+						   0x00000000,
+						   SZ_2G);
+		if (IS_ERR(mapping)) {
+			ret = PTR_ERR(mapping);
+			goto err_config_cleanup;
+		}
 
-	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
-	if (ret)
-		goto err_release_mapping;
+		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+		if (ret)
+			goto err_release_mapping;
 
-	dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
+		dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
 
-	ret = arm_iommu_attach_device(dev, mapping);
-	if (ret)
-		goto err_release_mapping;
+		ret = arm_iommu_attach_device(dev, mapping);
+		if (ret)
+			goto err_release_mapping;
+	}
 
 	/* Try to bind all sub drivers. */
 	ret = component_bind_all(dev, drm_dev);
@@ -226,9 +237,11 @@ err_kms_helper_poll_fini:
 err_unbind:
 	component_unbind_all(dev, drm_dev);
 err_detach_device:
-	arm_iommu_detach_device(dev);
+	if (is_support_iommu)
+		arm_iommu_detach_device(dev);
 err_release_mapping:
-	arm_iommu_release_mapping(dev->archdata.mapping);
+	if (is_support_iommu)
+		arm_iommu_release_mapping(dev->archdata.mapping);
 err_config_cleanup:
 	drm_mode_config_cleanup(drm_dev);
 	drm_dev->dev_private = NULL;
@@ -243,8 +256,10 @@ static int rockchip_drm_unload(struct drm_device *drm_dev)
 	drm_vblank_cleanup(drm_dev);
 	drm_kms_helper_poll_fini(drm_dev);
 	component_unbind_all(dev, drm_dev);
-	arm_iommu_detach_device(dev);
-	arm_iommu_release_mapping(dev->archdata.mapping);
+	if (is_support_iommu) {
+		arm_iommu_detach_device(dev);
+		arm_iommu_release_mapping(dev->archdata.mapping);
+	}
 	drm_mode_config_cleanup(drm_dev);
 	drm_dev->dev_private = NULL;
 
@@ -488,6 +503,8 @@ static int rockchip_drm_platform_probe(struct platform_device *pdev)
 	 * works as expected.
 	 */
 	for (i = 0;; i++) {
+		struct device_node *iommu;
+
 		port = of_parse_phandle(np, "ports", i);
 		if (!port)
 			break;
@@ -497,6 +514,17 @@ static int rockchip_drm_platform_probe(struct platform_device *pdev)
 			continue;
 		}
 
+		iommu = of_parse_phandle(port->parent, "iommus", 0);
+		if (!iommu || !of_device_is_available(iommu->parent)) {
+			dev_dbg(dev, "no iommu attached for %s, using non-iommu buffers\n",
+				port->parent->full_name);
+			/*
+			 * if there is a crtc not support iommu, force set all
+			 * crtc use non-iommu buffer.
+			 */
+			is_support_iommu = false;
+		}
+
 		component_match_add(dev, &match, compare_of, port->parent);
 		of_node_put(port);
 	}
-- 
1.7.9.5
