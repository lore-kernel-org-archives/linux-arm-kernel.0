From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 16 Mar 2016 14:57:49 +0000
Subject: [PATCH] drm/fb_cma_helper: Implement fb_mmap callback
Message-ID: <11eb10d95109abc104beb94c0409d49644ea8517.1458140105.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the absence of an fb_mmap callback, the fbdev code falls back to a
naive implementation which relies upon the DMA address being the same
as the physical address, and the buffer being physically contiguous
from there. Whilst this often holds for standard CMA allocations via
the platform's regular DMA ops, if the allocation is provided by an
IOMMU then such assumptions can fall apart spectacularly.

To resolve this, reroute the fb_mmap call to the appropriate DMA API
implementation, as per the other cma_helper calls.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Hi dri-devel,

This is an empirical fix for something I tickled via the newly-added
ARM HDLCD driver on a Juno platform - I have no idea whatsoever about
how "proper" it is in terms of the DRM infrastructure, so feel free to
treat this as a bug report rather than an actual patch if appropriate ;)

 drivers/gpu/drm/drm_fb_cma_helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
index bb88e3d..117d7ea 100644
--- a/drivers/gpu/drm/drm_fb_cma_helper.c
+++ b/drivers/gpu/drm/drm_fb_cma_helper.c
@@ -23,6 +23,7 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_fb_cma_helper.h>
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 
 struct drm_fb_cma {
@@ -221,6 +222,12 @@ int drm_fb_cma_debugfs_show(struct seq_file *m, void *arg)
 EXPORT_SYMBOL_GPL(drm_fb_cma_debugfs_show);
 #endif
 
+static int drm_fb_cma_mmap(struct fb_info *info, struct vm_area_struct *vma)
+{
+	return dma_mmap_writecombine(info->device, vma, info->screen_base,
+				     info->fix.smem_start, info->fix.smem_len);
+}
+
 static struct fb_ops drm_fbdev_cma_ops = {
 	.owner		= THIS_MODULE,
 	.fb_fillrect	= drm_fb_helper_sys_fillrect,
@@ -231,6 +238,7 @@ static struct fb_ops drm_fbdev_cma_ops = {
 	.fb_blank	= drm_fb_helper_blank,
 	.fb_pan_display	= drm_fb_helper_pan_display,
 	.fb_setcmap	= drm_fb_helper_setcmap,
+	.fb_mmap	= drm_fb_cma_mmap,
 };
 
 static int drm_fbdev_cma_create(struct drm_fb_helper *helper,
-- 
2.7.3.dirty
