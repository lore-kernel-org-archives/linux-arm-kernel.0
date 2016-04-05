From: john@metanate.com (John Keeping)
Date: Tue,  5 Apr 2016 14:50:32 +0100
Subject: [PATCH 2/2] drm/rockchip: don't leak iommu mapping
In-Reply-To: <1459864232-25033-1-git-send-email-john@metanate.com>
References: <1459864232-25033-1-git-send-email-john@metanate.com>
Message-ID: <1459864232-25033-2-git-send-email-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm_iommu_attach_device() takes its own reference to the mapping we give
it.  Since we do not keep a reference to the mapping ourselves, we must
release it before returning.

Also fix the error path, which fails to release the mapping if it has
called arm_iommu_detach_device() since that clears archdata.mapping.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 7695c79..1e2d88b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -218,6 +218,7 @@ static int rockchip_drm_load(struct drm_device *drm_dev, unsigned long flags)
 	if (ret)
 		goto err_vblank_cleanup;
 
+	arm_iommu_release_mapping(mapping);
 	return 0;
 err_vblank_cleanup:
 	drm_vblank_cleanup(drm_dev);
@@ -228,7 +229,7 @@ err_unbind:
 err_detach_device:
 	arm_iommu_detach_device(dev);
 err_release_mapping:
-	arm_iommu_release_mapping(dev->archdata.mapping);
+	arm_iommu_release_mapping(mapping);
 err_config_cleanup:
 	drm_mode_config_cleanup(drm_dev);
 	drm_dev->dev_private = NULL;
-- 
2.8.0.rc4.238.g874082a
