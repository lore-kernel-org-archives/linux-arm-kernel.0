From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue,  7 Feb 2017 16:39:09 +0800
Subject: [PATCH v2 6/7] drm/rockchip: Respect page offset in IOMMU mmap
In-Reply-To: <1486456542-18675-1-git-send-email-mark.yao@rock-chips.com>
References: <1486456542-18675-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1486456749-19142-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: ?rjan Eide <orjan.eide@arm.com>

When mapping buffers through the PRIME DMA-buf mmap path we might be
given an offset which has to be respected. The DRM GEM mmap path already
takes care of zeroing out the fake mmap offset, so we can just make the
IOMMU mmap implementation always respect the offset.

TEST=graphics_GLBench

Signed-off-by: rjan Eide <orjan.eide@arm.com>
Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
Reviewed-on: https://chromium-review.googlesource.com/386477
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 1daa531..1769146 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -221,12 +221,16 @@ static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
 	unsigned int i, count = obj->size >> PAGE_SHIFT;
 	unsigned long user_count = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 	unsigned long uaddr = vma->vm_start;
+	unsigned long offset = vma->vm_pgoff;
+	unsigned long end = user_count + offset;
 	int ret;
 
-	if (user_count == 0 || user_count > count)
+	if (user_count == 0)
+		return -ENXIO;
+	if (end > count)
 		return -ENXIO;
 
-	for (i = 0; i < user_count; i++) {
+	for (i = offset; i < end; i++) {
 		ret = vm_insert_page(vma, uaddr, rk_obj->pages[i]);
 		if (ret)
 			return ret;
-- 
1.9.1
