From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Mon, 27 Aug 2018 14:10:41 +0300
Subject: [RESEND 5/5] drm/mxsfb: Switch to drm_atomic_helper_commit_tail_rpm
In-Reply-To: <cover.1535367027.git.leonard.crestez@nxp.com>
References: <cover.1535367027.git.leonard.crestez@nxp.com>
Message-ID: <1dcf9e3b25ddff3906491a2ce43ac5c1a3f2167a.1535367027.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The lcdif block is only powered on when display is active so plane
updates when not enabled are not valid. Writing to an unpowered IP block
is mostly ignored but can trigger bus errors on some chips.

Prevent this situation by switching to drm_atomic_helper_commit_tail_rpm
and having the drm core ensure atomic_plane_update is only called while
the crtc is active. This avoids having to keep track of "enabled" bits
inside the mxsfb driver.

This also requires handling the vblank event for disable from
mxsfb_pipe_disable.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Suggested-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index d797dfd40d98..5777e730085b 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -96,10 +96,14 @@ static const struct drm_mode_config_funcs mxsfb_mode_config_funcs = {
 	.fb_create		= drm_gem_fb_create,
 	.atomic_check		= drm_atomic_helper_check,
 	.atomic_commit		= drm_atomic_helper_commit,
 };
 
+static const struct drm_mode_config_helper_funcs mxsfb_mode_config_helpers = {
+	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
+};
+
 static void mxsfb_pipe_enable(struct drm_simple_display_pipe *pipe,
 			      struct drm_crtc_state *crtc_state,
 			      struct drm_plane_state *plane_state)
 {
 	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
@@ -113,15 +117,25 @@ static void mxsfb_pipe_enable(struct drm_simple_display_pipe *pipe,
 
 static void mxsfb_pipe_disable(struct drm_simple_display_pipe *pipe)
 {
 	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
 	struct drm_device *drm = pipe->plane.dev;
+	struct drm_crtc *crtc = &pipe->crtc;
+	struct drm_pending_vblank_event *event;
 
 	drm_panel_disable(mxsfb->panel);
 	mxsfb_crtc_disable(mxsfb);
 	drm_panel_unprepare(mxsfb->panel);
 	pm_runtime_put_sync(drm->dev);
+
+	spin_lock_irq(&drm->event_lock);
+	event = crtc->state->event;
+	if (event) {
+		crtc->state->event = NULL;
+		drm_crtc_send_vblank_event(crtc, event);
+	}
+	spin_unlock_irq(&drm->event_lock);
 }
 
 static void mxsfb_pipe_update(struct drm_simple_display_pipe *pipe,
 			      struct drm_plane_state *plane_state)
 {
@@ -232,10 +246,11 @@ static int mxsfb_load(struct drm_device *drm, unsigned long flags)
 	drm->mode_config.min_width	= MXSFB_MIN_XRES;
 	drm->mode_config.min_height	= MXSFB_MIN_YRES;
 	drm->mode_config.max_width	= MXSFB_MAX_XRES;
 	drm->mode_config.max_height	= MXSFB_MAX_YRES;
 	drm->mode_config.funcs		= &mxsfb_mode_config_funcs;
+	drm->mode_config.helper_private	= &mxsfb_mode_config_helpers;
 
 	drm_mode_config_reset(drm);
 
 	pm_runtime_get_sync(drm->dev);
 	ret = drm_irq_install(drm, platform_get_irq(pdev, 0));
-- 
2.17.1
