From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Thu, 4 Aug 2016 10:59:57 +0800
Subject: [PATCH v2 7/7] drm/mediatek: Fix mtk_atomic_complete for runtime_pm
In-Reply-To: <1470279597-60453-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1470279597-60453-1-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <1470279597-60453-8-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To properly implement atomic w/ runtime pm, we move
drm_atomic_helper_commit_modeset_enables() above
drm_atomic_helper_commit_planes() to ensure CRTCs are enabled before
modifying plane registers, and set active_only to true to filter out
plane update notifications when the CRTC is disabled.

According to the document from linux kernel:
Set the active_only parameters to true in order not to receive plane
update notifications related to a disabled CRTC. This avoids the need
to manually ignore plane updates in driver code when the driver and/or
hardware can't or just don't need to deal with updates on disabled
CRTCs, for example when supporting runtime PM.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index b1223d5..507392a 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -61,10 +61,25 @@ static void mtk_atomic_complete(struct mtk_drm_private *private,
 
 	mtk_atomic_wait_for_fences(state);
 
+	/*
+	 * Mediatek drm supports runtime PM, so plane registers cannot be
+	 * written when their crtc is disabled.
+	 *
+	 * The comment for drm_atomic_helper_commit states:
+	 *     For drivers supporting runtime PM the recommended sequence is
+	 *
+	 *     drm_atomic_helper_commit_modeset_disables(dev, state);
+	 *     drm_atomic_helper_commit_modeset_enables(dev, state);
+	 *     drm_atomic_helper_commit_planes(dev, state, true);
+	 *
+	 * See the kerneldoc entries for these three functions for more details.
+	 */
 	drm_atomic_helper_commit_modeset_disables(drm, state);
-	drm_atomic_helper_commit_planes(drm, state, false);
 	drm_atomic_helper_commit_modeset_enables(drm, state);
+	drm_atomic_helper_commit_planes(drm, state, true);
+
 	drm_atomic_helper_wait_for_vblanks(drm, state);
+
 	drm_atomic_helper_cleanup_planes(drm, state);
 	drm_atomic_state_free(state);
 }
-- 
1.7.9.5
