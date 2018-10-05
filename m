From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Fri,  5 Oct 2018 23:59:50 +0200
Subject: [PATCH v3 1/2] drm/sun4i: tcon: fix check of tcon->panel null pointer
In-Reply-To: <20181004195605.txvbkshvxklyzxyb@flea>
References: <20181004195605.txvbkshvxklyzxyb@flea>
Message-ID: <20181005215951.99003-1-giulio.benetti@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since tcon->panel is a pointer returned by of_drm_find_panel() need to
check if it is not NULL, hence a valid pointer.
IS_ERR() instead checks return error values, not NULL pointers.

Substitute "if (!IS_ERR(tcon->panel))" with "if (tcon->panel)".

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
Changes V1->V2:
* correct same bug for all same occurences in drm/sun4i folder

Changes V2->V3:
* Improve commit log

 drivers/gpu/drm/sun4i/sun4i_lvds.c | 4 ++--
 drivers/gpu/drm/sun4i/sun4i_rgb.c  | 4 ++--
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.c b/drivers/gpu/drm/sun4i/sun4i_lvds.c
index af7dcb6da351..e7eb0d1e17be 100644
--- a/drivers/gpu/drm/sun4i/sun4i_lvds.c
+++ b/drivers/gpu/drm/sun4i/sun4i_lvds.c
@@ -75,7 +75,7 @@ static void sun4i_lvds_encoder_enable(struct drm_encoder *encoder)
 
 	DRM_DEBUG_DRIVER("Enabling LVDS output\n");
 
-	if (!IS_ERR(tcon->panel)) {
+	if (tcon->panel) {
 		drm_panel_prepare(tcon->panel);
 		drm_panel_enable(tcon->panel);
 	}
@@ -88,7 +88,7 @@ static void sun4i_lvds_encoder_disable(struct drm_encoder *encoder)
 
 	DRM_DEBUG_DRIVER("Disabling LVDS output\n");
 
-	if (!IS_ERR(tcon->panel)) {
+	if (tcon->panel) {
 		drm_panel_disable(tcon->panel);
 		drm_panel_unprepare(tcon->panel);
 	}
diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index bf068da6b12e..f4a22689eb54 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -135,7 +135,7 @@ static void sun4i_rgb_encoder_enable(struct drm_encoder *encoder)
 
 	DRM_DEBUG_DRIVER("Enabling RGB output\n");
 
-	if (!IS_ERR(tcon->panel)) {
+	if (tcon->panel) {
 		drm_panel_prepare(tcon->panel);
 		drm_panel_enable(tcon->panel);
 	}
@@ -148,7 +148,7 @@ static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
 
 	DRM_DEBUG_DRIVER("Disabling RGB output\n");
 
-	if (!IS_ERR(tcon->panel)) {
+	if (tcon->panel) {
 		drm_panel_disable(tcon->panel);
 		drm_panel_unprepare(tcon->panel);
 	}
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index c78cd35a1294..e4b3bd0307ef 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -555,7 +555,7 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	 * Following code is a way to avoid quirks all around TCON
 	 * and DOTCLOCK drivers.
 	 */
-	if (!IS_ERR(tcon->panel)) {
+	if (tcon->panel) {
 		struct drm_panel *panel = tcon->panel;
 		struct drm_connector *connector = panel->connector;
 		struct drm_display_info display_info = connector->display_info;
-- 
2.17.1
