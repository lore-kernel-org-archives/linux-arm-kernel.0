From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Sat,  1 Apr 2017 19:35:26 +0800
Subject: [PATCH v2 6/9] drm/rockchip: Reoder unload sequence
In-Reply-To: <1491046529-4310-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1491046529-4310-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <1491046529-4310-7-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should not cleanup iommu before cleanup other resources.

Reorder unload sequence, follow exynos drm.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v2: None

 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index b360e62..a5d83cb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -244,11 +244,13 @@ static void rockchip_drm_unbind(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
 	rockchip_drm_fbdev_fini(drm_dev);
-	drm_vblank_cleanup(drm_dev);
 	drm_kms_helper_poll_fini(drm_dev);
+
+	drm_vblank_cleanup(drm_dev);
 	component_unbind_all(dev, drm_dev);
-	rockchip_iommu_cleanup(drm_dev);
 	drm_mode_config_cleanup(drm_dev);
+	rockchip_iommu_cleanup(drm_dev);
+
 	drm_dev->dev_private = NULL;
 	drm_dev_unregister(drm_dev);
 	drm_dev_unref(drm_dev);
-- 
2.1.4
