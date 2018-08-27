From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Mon, 27 Aug 2018 14:10:39 +0300
Subject: [RESEND 3/5] drm/mxsfb: Add pm_runtime calls to pipe_enable/disable
In-Reply-To: <cover.1535367027.git.leonard.crestez@nxp.com>
References: <cover.1535367027.git.leonard.crestez@nxp.com>
Message-ID: <22181175cbefbd997596969e1e3addc04063be03.1535367027.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding lcdif nodes to a power domain currently results in
black/corrupted screens or hangs because power is not correctly enabled
when required.

Ensure power is on when display is active by adding
pm_runtime_get/put_sync to mxsfb_pipe_enable/disable.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index ffe5137ccaf8..68d79f5dc0d3 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -101,23 +101,27 @@ static const struct drm_mode_config_funcs mxsfb_mode_config_funcs = {
 static void mxsfb_pipe_enable(struct drm_simple_display_pipe *pipe,
 			      struct drm_crtc_state *crtc_state,
 			      struct drm_plane_state *plane_state)
 {
 	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
+	struct drm_device *drm = pipe->plane.dev;
 
+	pm_runtime_get_sync(drm->dev);
 	drm_panel_prepare(mxsfb->panel);
 	mxsfb_crtc_enable(mxsfb);
 	drm_panel_enable(mxsfb->panel);
 }
 
 static void mxsfb_pipe_disable(struct drm_simple_display_pipe *pipe)
 {
 	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
+	struct drm_device *drm = pipe->plane.dev;
 
 	drm_panel_disable(mxsfb->panel);
 	mxsfb_crtc_disable(mxsfb);
 	drm_panel_unprepare(mxsfb->panel);
+	pm_runtime_put_sync(drm->dev);
 }
 
 static void mxsfb_pipe_update(struct drm_simple_display_pipe *pipe,
 			      struct drm_plane_state *plane_state)
 {
-- 
2.17.1
