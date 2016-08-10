From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Wed, 10 Aug 2016 11:30:51 -0600
Subject: [PATCH] exynos-drm: Fix display manager failing to start without
 IOMMU problem
Message-ID: <1470850251-9150-1-git-send-email-shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix exynos_drm_gem_create_ioctl() attempts to allocate non-contiguous GEM
memory without IOMMU. In this case, there is no point in attempting to
allocate non-contiguous memory, only to return error during the next step
from exynos_drm_framebuffer_init() which leads to display manager failing
to start.

Check if non-contiguous GEM memory is requested without IOMMU. If so,
allocate contiguous GEM memory to help display manager start.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_gem.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
index 4c4cb0e..4719116 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
@@ -266,6 +266,20 @@ int exynos_drm_gem_create_ioctl(struct drm_device *dev, void *data,
 	struct exynos_drm_gem *exynos_gem;
 	int ret;
 
+	/*
+	 * Check if non-contiguous GEM memory is requested without IOMMU.
+	 * If so, allocate contiguous GEM memory.
+	 *
+	 * There is no point in attempting to allocate non-contiguous memory,
+	 * only to return error from exynos_drm_framebuffer_init() which leads
+	 * to display manager failing to start.
+	*/
+	if (!is_drm_iommu_supported(dev) &&
+	    (args->flags & EXYNOS_BO_NONCONTIG)) {
+		args->flags &= ~EXYNOS_BO_NONCONTIG;
+		args->flags |= EXYNOS_BO_CONTIG;
+	}
+
 	exynos_gem = exynos_drm_gem_create(dev, args->flags, args->size);
 	if (IS_ERR(exynos_gem))
 		return PTR_ERR(exynos_gem);
-- 
2.7.4
