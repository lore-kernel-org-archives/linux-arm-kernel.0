From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue,  7 Feb 2017 14:09:36 +0800
Subject: [PATCH 4/4] drm/rockchip: gem: fixup iommu_map_sg error path
In-Reply-To: <1486447776-30543-1-git-send-email-mark.yao@rock-chips.com>
References: <1486447776-30543-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1486447776-30543-5-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The return value of iommu_map_sg is size_t, it's unsigned,
So check ret < 0 is wrong.

And if iommu_map_sg is error, it's return value is zero, but
rockchip_gem_iommu_map feel the zero return value is success,
bug happen:

[    5.227458] [drm:rockchip_gem_iommu_map] *ERROR* failed to map buffer: 0
[   12.291590] WARNING: at drivers/gpu/drm/drm_mm.c:369
[   12.291611] Modules linked in:
[   12.291634]
[   12.291658] CPU: 4 PID: 338 Comm: cameraserver Not tainted 4.4.41 #196
[   12.291680] Hardware name: rockchip,rk3399-mid (DT)
[   12.291703] task: ffffffc0e5a23100 ti: ffffffc0e5a64000 task.ti: ffffffc0e5a64000
[   12.291739] PC is at drm_mm_remove_node+0xc/0xf8
[   12.291766] LR is@rockchip_gem_iommu_unmap+0x3c/0x54
[   12.303799] [<ffffff80084526e0>] drm_mm_remove_node+0xc/0xf8
[   12.303827] [<ffffff8008475430>] rockchip_gem_free_object+0x98/0x168
[   12.303854] [<ffffff8008449e80>] drm_gem_object_free+0x2c/0x34
[   12.303878] [<ffffff80084626c4>] drm_gem_dmabuf_release+0x90/0xa4
[   12.303904] [<ffffff80084ee73c>] dma_buf_release+0x64/0x15c
[   12.303929] [<ffffff80081aa8dc>] __fput+0xe0/0x1a4
[   12.303950] [<ffffff80081aa9f8>] ____fput+0xc/0x14
[   12.303977] [<ffffff80080b65ec>] task_work_run+0xa0/0xc0
[   12.304004] [<ffffff8008087f18>] do_notify_resume+0x40/0x54
[   12.304026] [<ffffff80080825e4>] work_pending+0x10/0x14

Change-Id: Id79c052691270553c1c60086f9926f39a5296354
Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 8d27965..cc48673 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -44,8 +44,10 @@ static int rockchip_gem_iommu_map(struct rockchip_gem_object *rk_obj)
 
 	ret = iommu_map_sg(private->domain, rk_obj->dma_addr, rk_obj->sgt->sgl,
 			   rk_obj->sgt->nents, prot);
-	if (ret < 0) {
-		DRM_ERROR("failed to map buffer: %zd\n", ret);
+	if (ret < rk_obj->base.size) {
+		DRM_ERROR("failed to map buffer: size=%zd request_size=%zd\n",
+			  ret, rk_obj->base.size);
+		ret = -ENOMEM;
 		goto err_remove_node;
 	}
 
-- 
1.9.1
