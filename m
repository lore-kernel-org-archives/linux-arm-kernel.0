From: john@metanate.com (John Keeping)
Date: Thu, 14 Jul 2016 16:29:15 +0100
Subject: [PATCH] drm/rockchip: allocate correct crtc state structure on reset
Message-ID: <20160714152915.31235-1-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because we are using a custom crtc_state structure, we must override the
reset helper to allocate the correct amount of memory.

Cc: stable at vger.kernel.org
Fixes: 4e257d9eee23 ("drm/rockchip: get rid of rockchip_drm_crtc_mode_config")
Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 1c4d5b5a70a2..21e1247098be 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1048,6 +1048,17 @@ static void vop_crtc_destroy(struct drm_crtc *crtc)
 	drm_crtc_cleanup(crtc);
 }
 
+static void vop_crtc_reset(struct drm_crtc *crtc)
+{
+	if (crtc->state)
+		__drm_atomic_helper_crtc_destroy_state(crtc, crtc->state);
+	kfree(crtc->state);
+
+	crtc->state = kzalloc(sizeof(struct rockchip_crtc_state), GFP_KERNEL);
+	if (crtc->state)
+		crtc->state->crtc = crtc;
+}
+
 static struct drm_crtc_state *vop_crtc_duplicate_state(struct drm_crtc *crtc)
 {
 	struct rockchip_crtc_state *rockchip_state;
@@ -1073,7 +1084,7 @@ static const struct drm_crtc_funcs vop_crtc_funcs = {
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.destroy = vop_crtc_destroy,
-	.reset = drm_atomic_helper_crtc_reset,
+	.reset = vop_crtc_reset,
 	.atomic_duplicate_state = vop_crtc_duplicate_state,
 	.atomic_destroy_state = vop_crtc_destroy_state,
 };
-- 
2.9.0.465.g8850cbc.dirty
