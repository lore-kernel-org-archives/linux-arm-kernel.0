From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue,  7 Feb 2017 16:37:50 +0800
Subject: [PATCH v2 5/7] drm/rockchip: Fix the call to drm_gem_put_pages()
In-Reply-To: <1486456542-18675-1-git-send-email-mark.yao>
References: <1486456542-18675-1-git-send-email-mark.yao>
Message-ID: <1486456670-18974-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Figa <tfiga@chromium.org>

When freeing the buffer we don't have any means of determining if the
buffer was read or written, so we must assume both and pass true for
both arguments of drm_gem_put_pages(). Let's fix the code which
currently passes false.

TEST=while true; do backlight_dbus_tool --set --percent=0 && sleep 8 &&
 backlight_dbus_tool --set --percent=100 && sleep 3 ; done

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
Reviewed-on: https://chromium-review.googlesource.com/382934
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index cc48673..1daa531 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -119,7 +119,7 @@ static void rockchip_gem_put_pages(struct rockchip_gem_object *rk_obj)
 {
 	sg_free_table(rk_obj->sgt);
 	kfree(rk_obj->sgt);
-	drm_gem_put_pages(&rk_obj->base, rk_obj->pages, false, false);
+	drm_gem_put_pages(&rk_obj->base, rk_obj->pages, true, true);
 }
 
 static int rockchip_gem_alloc_iommu(struct rockchip_gem_object *rk_obj,
-- 
1.9.1
