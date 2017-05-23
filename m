From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Tue, 23 May 2017 14:39:43 +0800
Subject: [PATCH] drm/rockchip: Don't allow zero sized gem buffer
Message-ID: <1495521583-29151-1-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The system would crash when trying to alloc zero sized gem buffer:
[    6.712435] Unable to handle kernel NULL pointer dereference at virtual address 00000010 <--ZERO_SIZE_PTR
...
[    6.757502] PC is at sg_alloc_table_from_pages+0x170/0x1ec

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index df9e570..8917922 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -315,6 +315,11 @@ struct rockchip_gem_object *
 	struct drm_gem_object *obj;
 	int ret;
 
+	if (!size) {
+		DRM_ERROR("gem buffer size is zero\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	size = round_up(size, PAGE_SIZE);
 
 	rk_obj = kzalloc(sizeof(*rk_obj), GFP_KERNEL);
-- 
2.1.4
