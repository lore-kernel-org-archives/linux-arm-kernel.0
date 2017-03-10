From: seanpaul@chromium.org (Sean Paul)
Date: Thu,  9 Mar 2017 23:32:19 -0500
Subject: [PATCH 04/41] drm/rockchip: Respect page offset for PRIME mmap calls
In-Reply-To: <20170310043305.17216-1-seanpaul@chromium.org>
References: <20170310043305.17216-1-seanpaul@chromium.org>
Message-ID: <20170310043305.17216-5-seanpaul@chromium.org>
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

BUG=chrome-os-partner:56615
TEST=graphics_GLBench

Cc: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: ?rjan Eide <orjan.eide@arm.com>
Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 5dffe276d2a7..7fa2cb77bdc0 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -263,7 +263,6 @@ static int rockchip_drm_gem_object_mmap(struct drm_gem_object *obj,
 	 * VM_PFNMAP flag that was set by drm_gem_mmap_obj()/drm_gem_mmap().
 	 */
 	vma->vm_flags &= ~VM_PFNMAP;
-	vma->vm_pgoff = 0;
 
 	if (rk_obj->pages)
 		ret = rockchip_drm_gem_object_mmap_iommu(obj, vma);
@@ -298,6 +297,12 @@ int rockchip_gem_mmap(struct file *filp, struct vm_area_struct *vma)
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
2.12.0.246.ga2ecc84866-goog
