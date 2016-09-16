From: tfiga@chromium.org (Tomasz Figa)
Date: Fri, 16 Sep 2016 18:17:22 +0900
Subject: [PATCH] drm/rockchip: Respect page offset for PRIME mmap calls
Message-ID: <1474017442-7262-1-git-send-email-tfiga@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: ?rjan Eide <orjan.eide@arm.com>

When mapping external DMA-bufs through the PRIME mmap call, we might be
given an offset which has to be respected. However for the internal DRM
GEM mmap path, we have to ignore the fake mmap offset used to identify
the buffer only. Currently the code always zeroes out vma->vm_pgoff,
which breaks the former.

This patch fixes the problem by moving the vm_pgoff assignment to a
function that is used only for GEM mmap path, so that the PRIME path
retains the original offset.

Fixes: a8594f2 ("drm/rockchip: unset pgoff when mmap'ing gems")

Signed-off-by: ?rjan Eide <orjan.eide@arm.com>
Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Cc: stable at vger.kernel.org
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index b70f942..cab4d60 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -64,7 +64,6 @@ static int rockchip_drm_gem_object_mmap(struct drm_gem_object *obj,
 	 * VM_PFNMAP flag that was set by drm_gem_mmap_obj()/drm_gem_mmap().
 	 */
 	vma->vm_flags &= ~VM_PFNMAP;
-	vma->vm_pgoff = 0;
 
 	ret = dma_mmap_attrs(drm->dev, vma, rk_obj->kvaddr, rk_obj->dma_addr,
 			     obj->size, rk_obj->dma_attrs);
@@ -96,6 +95,12 @@ int rockchip_gem_mmap(struct file *filp, struct vm_area_struct *vma)
 	if (ret)
 		return ret;
 
+	/*
+	 * Set vm_pgoff (used as a fake buffer offset by DRM) to 0 and map the
+	 * whole buffer from the start.
+	 */
+	vma->vm_pgoff = 0;
+
 	obj = vma->vm_private_data;
 
 	return rockchip_drm_gem_object_mmap(obj, vma);
-- 
2.8.0.rc3.226.g39d4020
