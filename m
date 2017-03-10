From: seanpaul@chromium.org (Sean Paul)
Date: Thu,  9 Mar 2017 23:32:47 -0500
Subject: [PATCH 32/41] drm/rockchip: Flush PSR before committing modeset
 disables/enables
In-Reply-To: <20170310043305.17216-1-seanpaul@chromium.org>
References: <20170310043305.17216-1-seanpaul@chromium.org>
Message-ID: <20170310043305.17216-33-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Figa <tfiga@chromium.org>

Currently PSR flush is triggered from CRTC's .atomic_begin() callback,
which is executed after modeset disables and enables and before plane
updates are committed. Since PSR flush and re-enable can be triggered
asynchronously by external sources (input event, delayed work), it can
race with hardware programming done in the aforementioned stages.

To avoid the race, we can trigger PSR flush before committing modeset
disables/enables. This also has the advantage of removing some
PSR-specific knowledge from the VOP driver.

Cc: Kristian H. Kristensen <hoegsberg@chromium.org>
Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  | 13 +++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  7 -------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index 81f9548672b0..2067f4afadf3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -175,10 +175,23 @@ static void rockchip_drm_output_poll_changed(struct drm_device *dev)
 }
 
 static void
+rockchip_drm_psr_flush_state(struct drm_atomic_state *state)
+{
+	struct drm_crtc_state *crtc_state;
+	struct drm_crtc *crtc;
+	int i;
+
+	for_each_crtc_in_state(state, crtc, crtc_state, i)
+		rockchip_drm_psr_flush(crtc);
+}
+
+static void
 rockchip_atomic_commit_tail(struct drm_atomic_state *state)
 {
 	struct drm_device *dev = state->dev;
 
+	rockchip_drm_psr_flush_state(state);
+
 	drm_atomic_helper_commit_modeset_disables(dev, state);
 
 	drm_atomic_helper_commit_modeset_enables(dev, state);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index ea3fff4170d9..879efc3a6c67 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1067,18 +1067,11 @@ static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
 	}
 }
 
-static void vop_crtc_atomic_begin(struct drm_crtc *crtc,
-				  struct drm_crtc_state *old_crtc_state)
-{
-	rockchip_drm_psr_flush(crtc);
-}
-
 static const struct drm_crtc_helper_funcs vop_crtc_helper_funcs = {
 	.enable = vop_crtc_enable,
 	.disable = vop_crtc_disable,
 	.mode_fixup = vop_crtc_mode_fixup,
 	.atomic_flush = vop_crtc_atomic_flush,
-	.atomic_begin = vop_crtc_atomic_begin,
 };
 
 static void vop_crtc_destroy(struct drm_crtc *crtc)
-- 
2.12.0.246.ga2ecc84866-goog
