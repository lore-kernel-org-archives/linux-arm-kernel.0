From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue,  7 Feb 2017 16:39:33 +0800
Subject: [PATCH v2 7/7] drm/rockchip: Call drm_gem_object_release() to destroy
 GEM base
In-Reply-To: <1486456542-18675-1-git-send-email-mark.yao@rock-chips.com>
References: <1486456542-18675-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1486456773-19233-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Figa <tfiga@chromium.org>

When converting the driver to use shmem-backed GEMs for IOMMU-enabled
systems, we forgot to add calls to drm_gem_object_release(), which gave
us a quite nice memory leak. This patch adds the missing calls.

Fixes: f11d5f0 ("FROMLIST: drm/rockchip: Do not use DMA mapping API if
attached to IOMMU domain")

TEST=while true; do backlight_dbus_tool --set --percent=0 && sleep 8 &&
 backlight_dbus_tool --set --percent=100 && sleep 3 ; done

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
Reviewed-on: https://chromium-review.googlesource.com/385456
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 1769146..df9e570 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -301,6 +301,12 @@ int rockchip_gem_mmap(struct file *filp, struct vm_area_struct *vma)
 	return rockchip_drm_gem_object_mmap(obj, vma);
 }
 
+static void rockchip_gem_release_object(struct rockchip_gem_object *rk_obj)
+{
+	drm_gem_object_release(&rk_obj->base);
+	kfree(rk_obj);
+}
+
 struct rockchip_gem_object *
 	rockchip_gem_create_object(struct drm_device *drm, unsigned int size,
 				   bool alloc_kmap)
@@ -326,7 +332,7 @@ struct rockchip_gem_object *
 	return rk_obj;
 
 err_free_rk_obj:
-	kfree(rk_obj);
+	rockchip_gem_release_object(rk_obj);
 	return ERR_PTR(ret);
 }
 
@@ -338,13 +344,11 @@ void rockchip_gem_free_object(struct drm_gem_object *obj)
 {
 	struct rockchip_gem_object *rk_obj;
 
-	drm_gem_free_mmap_offset(obj);
-
 	rk_obj = to_rockchip_obj(obj);
 
 	rockchip_gem_free_buf(rk_obj);
 
-	kfree(rk_obj);
+	rockchip_gem_release_object(rk_obj);
 }
 
 /*
-- 
1.9.1
