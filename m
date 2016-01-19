From: john@metanate.com (John Keeping)
Date: Tue, 19 Jan 2016 10:47:00 +0000
Subject: [PATCH v2 3/3] drm/rockchip: explain why we can't wait_for_vblanks
In-Reply-To: <cover.1453200263.git.john@metanate.com>
References: <cover.1453200263.git.john@metanate.com>
Message-ID: <921a9f91937bebfeef7d7f563339fe6e4bf63f67.1453200263.git.john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: John Keeping <john@metanate.com>
---
v2:
  - Add more detail of the particular race that could happen if we used
    drm_atomic_helper_wait_for_vblanks().

 drivers/gpu/drm/rockchip/rockchip_drm_fb.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index 679d23a..cf0b7bd 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -177,6 +177,21 @@ static void rockchip_crtc_wait_for_update(struct drm_crtc *crtc)
 		crtc_funcs->wait_for_update(crtc);
 }
 
+/*
+ * We can't use drm_atomic_helper_wait_for_vblanks() because rk3288 and rk3066
+ * have hardware counters for neither vblanks nor scanlines, which results in
+ * a race where:
+ *				| <-- HW vsync irq and reg take effect
+ *	       plane_commit --> |
+ *	get_vblank and wait --> |
+ *				| <-- handle_vblank, vblank->count + 1
+ *		 cleanup_fb --> |
+ *		iommu crash --> |
+ *				| <-- HW vsync irq and reg take effect
+ *
+ * This function is equivalent but uses rockchip_crtc_wait_for_update() instead
+ * of waiting for vblank_count to change.
+ */
 static void
 rockchip_atomic_wait_for_complete(struct drm_device *dev, struct drm_atomic_state *old_state)
 {
-- 
2.7.0.226.gfe986fe
