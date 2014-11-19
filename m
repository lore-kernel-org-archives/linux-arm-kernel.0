From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 19 Nov 2014 12:15:33 +0100
Subject: [PATCH v3 04/19] drm: exynos: detach from default dma-mapping domain
 on init
In-Reply-To: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1416395748-10731-5-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds code, which detach sub-device nodes from default iommu
domain if such has been configured.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_iommu.c b/drivers/gpu/drm/exynos/exynos_drm_iommu.c
index b32b291f88ff..323601a52a25 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_iommu.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_iommu.c
@@ -100,6 +100,9 @@ int drm_iommu_attach_device(struct drm_device *drm_dev,
 
 	dma_set_max_seg_size(subdrv_dev, 0xffffffffu);
 
+	if (subdrv_dev->archdata.mapping)
+		arm_iommu_detach_device(subdrv_dev);
+
 	ret = arm_iommu_attach_device(subdrv_dev, dev->archdata.mapping);
 	if (ret < 0) {
 		DRM_DEBUG_KMS("failed iommu attach.\n");
-- 
1.9.2
