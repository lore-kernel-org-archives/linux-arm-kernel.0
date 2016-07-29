From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Fri, 29 Jul 2016 17:04:11 +0800
Subject: [PATCH 4/7] drm/mediatek: Use drm_atomic destroy_state helpers
In-Reply-To: <1469783054-54567-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1469783054-54567-1-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <1469783054-54567-5-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the core destroy_state helpers to destroy core state to ensure we don't
leak if/when more fields get added later.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c  |    3 +--
 drivers/gpu/drm/mediatek/mtk_drm_plane.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index d6fbefa..733b2a3 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -112,8 +112,7 @@ static void mtk_drm_crtc_reset(struct drm_crtc *crtc)
 	struct mtk_crtc_state *state;
 
 	if (crtc->state) {
-		if (crtc->state->mode_blob)
-			drm_property_unreference_blob(crtc->state->mode_blob);
+		__drm_atomic_helper_crtc_destroy_state(crtc->state);
 
 		state = to_mtk_crtc_state(crtc->state);
 		memset(state, 0, sizeof(*state));
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index 86b7aed..17172ba 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -73,8 +73,7 @@ static void mtk_plane_reset(struct drm_plane *plane)
 	struct mtk_plane_state *state;
 
 	if (plane->state) {
-		if (plane->state->fb)
-			drm_framebuffer_unreference(plane->state->fb);
+		__drm_atomic_helper_plane_destroy_state(plane->state);
 
 		state = to_mtk_plane_state(plane->state);
 		memset(state, 0, sizeof(*state));
-- 
1.7.9.5
