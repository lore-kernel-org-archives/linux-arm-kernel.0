From: djkurtz@chromium.org (Daniel Kurtz)
Date: Fri,  4 Apr 2014 17:22:01 +0800
Subject: [PATCH 1/2] drm/exynos/fbdev: don't set fix.smem/mmio_{start,len}
Message-ID: <1396603322-13585-1-git-send-email-djkurtz@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kernel access to the eyxnos fbdev framebuffer is via its gem object's
kernel mapping (kvaddr, stored in info->screen_base).

User space access is provided by mmap(), read() and write() of /dev/fb/fb0.
These functions also only use screen_base/screen_size().

Therefore, it is not necessary to set fix->smem_{start,len} or
fix->mmio_{start,len} fields.

This avoids leaking kernel, physical and dma mapped addresses to user
space via the ioctls FBIOGET_VSCREENINFO and FBIOGET_FSCREENINFO.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
index 5fa342e..2dcc589 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
@@ -123,14 +123,7 @@ static int exynos_drm_fbdev_update(struct drm_fb_helper *helper,
 
 	dev->mode_config.fb_base = (resource_size_t)buffer->dma_addr;
 	fbi->screen_base = buffer->kvaddr + offset;
-	if (is_drm_iommu_supported(dev))
-		fbi->fix.smem_start = (unsigned long)
-			(page_to_phys(sg_page(buffer->sgt->sgl)) + offset);
-	else
-		fbi->fix.smem_start = (unsigned long)buffer->dma_addr;
-
 	fbi->screen_size = size;
-	fbi->fix.smem_len = size;
 
 	return 0;
 }
-- 
1.9.1.423.g4596e3a
