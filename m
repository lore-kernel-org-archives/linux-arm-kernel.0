From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue,  7 Feb 2017 14:09:35 +0800
Subject: [PATCH 3/4] drm/rockchip: gem: add mutex lock for drm mm
In-Reply-To: <1486447776-30543-1-git-send-email-mark.yao@rock-chips.com>
References: <1486447776-30543-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1486447776-30543-4-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drm_mm_insert_node_generic and drm_mm_remove_node may access same
resource with list ops, it's not threads safe, so protect this context
with mutex lock.

Fix bug:
[49451.856244] ==================================================================
[49451.856350] BUG: KASAN: wild-memory-access on address dead000000000108
[49451.856379] Write of size 8 by task Binder:218_4/683
[49451.856417] CPU: 2 PID: 683 Comm: Binder:218_4 Not tainted 4.4.36 #62
[49451.856443] Hardware name: Rockchip RK3399 Excavator Board edp (Android) (DT)
[49451.856469] Call trace:
[49451.856519] [<ffffff900808a9d0>] dump_backtrace+0x0/0x230
[49451.856556] [<ffffff900808ac14>] show_stack+0x14/0x1c
[49451.856592] [<ffffff90084a4de0>] dump_stack+0xa0/0xc8
[49451.856633] [<ffffff900821b700>] kasan_report+0x110/0x4dc
[49451.856670] [<ffffff900821aa84>] __asan_store8+0x24/0x7c
[49451.856715] [<ffffff90086158c4>] drm_mm_insert_node_generic+0x2dc/0x464
[49451.856760] [<ffffff90086406a8>] rockchip_gem_iommu_map+0x60/0x158
[49451.856794] [<ffffff9008640bb4>] rockchip_gem_create_object+0x278/0x488
[49451.856827] [<ffffff9008641020>] rockchip_gem_create_with_handle+0x24/0x10c
[49451.856862] [<ffffff9008641364>] rockchip_gem_create_ioctl+0x3c/0x50
[49451.856896] [<ffffff900860aee4>] drm_ioctl+0x354/0x52c
[49451.856939] [<ffffff900823d948>] do_vfs_ioctl+0x670/0x78c
[49451.856976] [<ffffff900823dac4>] SyS_ioctl+0x60/0x88
[49451.857009] [<ffffff9008082ef0>] el0_svc_naked+0x24/0x28

Change-Id: I2ea377aa9ca24f70c59e2d86f2a6ad5ccb9c0891
Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 1 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h | 2 ++
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 9 +++++++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 7a610e9..b360e62 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -146,6 +146,7 @@ static int rockchip_drm_init_iommu(struct drm_device *drm_dev)
 	DRM_DEBUG("IOMMU context initialized (aperture: %#llx-%#llx)\n",
 		  start, end);
 	drm_mm_init(&private->mm, start, end - start + 1);
+	mutex_init(&private->mm_lock);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 7c123d9..adc3930 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -62,6 +62,8 @@ struct rockchip_drm_private {
 	const struct rockchip_crtc_funcs *crtc_funcs[ROCKCHIP_MAX_CRTC];
 	struct drm_atomic_state *state;
 	struct iommu_domain *domain;
+	/* protect drm_mm on multi-threads */
+	struct mutex mm_lock;
 	struct drm_mm mm;
 	struct list_head psr_list;
 	spinlock_t psr_list_lock;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 5209392..8d27965 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -28,9 +28,13 @@ static int rockchip_gem_iommu_map(struct rockchip_gem_object *rk_obj)
 	int prot = IOMMU_READ | IOMMU_WRITE;
 	ssize_t ret;
 
+	mutex_lock(&private->mm_lock);
+
 	ret = drm_mm_insert_node_generic(&private->mm, &rk_obj->mm,
 					 rk_obj->base.size, PAGE_SIZE,
 					 0, 0);
+
+	mutex_unlock(&private->mm_lock);
 	if (ret < 0) {
 		DRM_ERROR("out of I/O virtual memory: %zd\n", ret);
 		return ret;
@@ -61,8 +65,13 @@ static int rockchip_gem_iommu_unmap(struct rockchip_gem_object *rk_obj)
 	struct rockchip_drm_private *private = drm->dev_private;
 
 	iommu_unmap(private->domain, rk_obj->dma_addr, rk_obj->size);
+
+	mutex_lock(&private->mm_lock);
+
 	drm_mm_remove_node(&rk_obj->mm);
 
+	mutex_unlock(&private->mm_lock);
+
 	return 0;
 }
 
-- 
1.9.1
