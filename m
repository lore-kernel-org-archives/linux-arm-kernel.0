From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Jul 2017 16:12:59 +0200
Subject: [PATCH 04/18] drm/sun4i: Remove useless atomic_check
In-Reply-To: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
References: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
Message-ID: <effdc5f1e0fe485b141c057bb66f9dadf7433a88.1499955058.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The atomic_check callback is optional, and we don't implement anything in
some parts of our drivers. Let's remove it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_layer.c | 7 -------
 drivers/gpu/drm/sun4i/sun4i_rgb.c   | 8 --------
 drivers/gpu/drm/sun4i/sun4i_tv.c    | 8 --------
 3 files changed, 23 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index ead4f9d4c1ee..62b08cb47ccd 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -25,12 +25,6 @@ struct sun4i_plane_desc {
 	       uint32_t                nformats;
 };
 
-static int sun4i_backend_layer_atomic_check(struct drm_plane *plane,
-					    struct drm_plane_state *state)
-{
-	return 0;
-}
-
 static void sun4i_backend_layer_atomic_disable(struct drm_plane *plane,
 					       struct drm_plane_state *old_state)
 {
@@ -53,7 +47,6 @@ static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
 }
 
 static struct drm_plane_helper_funcs sun4i_backend_layer_helper_funcs = {
-	.atomic_check	= sun4i_backend_layer_atomic_check,
 	.atomic_disable	= sun4i_backend_layer_atomic_disable,
 	.atomic_update	= sun4i_backend_layer_atomic_update,
 };
diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index 422b191faa77..76362c09c608 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -128,13 +128,6 @@ static struct drm_connector_funcs sun4i_rgb_con_funcs = {
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 };
 
-static int sun4i_rgb_atomic_check(struct drm_encoder *encoder,
-				  struct drm_crtc_state *crtc_state,
-				  struct drm_connector_state *conn_state)
-{
-	return 0;
-}
-
 static void sun4i_rgb_encoder_enable(struct drm_encoder *encoder)
 {
 	struct sun4i_rgb *rgb = drm_encoder_to_sun4i_rgb(encoder);
@@ -182,7 +175,6 @@ static void sun4i_rgb_encoder_mode_set(struct drm_encoder *encoder,
 }
 
 static struct drm_encoder_helper_funcs sun4i_rgb_enc_helper_funcs = {
-	.atomic_check	= sun4i_rgb_atomic_check,
 	.mode_set	= sun4i_rgb_encoder_mode_set,
 	.disable	= sun4i_rgb_encoder_disable,
 	.enable		= sun4i_rgb_encoder_enable,
diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
index 338b9e5bb2a3..73bfe7b1cd78 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
@@ -341,13 +341,6 @@ static void sun4i_tv_mode_to_drm_mode(const struct tv_mode *tv_mode,
 	mode->vtotal = mode->vsync_end  + tv_mode->vback_porch;
 }
 
-static int sun4i_tv_atomic_check(struct drm_encoder *encoder,
-				 struct drm_crtc_state *crtc_state,
-				 struct drm_connector_state *conn_state)
-{
-	return 0;
-}
-
 static void sun4i_tv_disable(struct drm_encoder *encoder)
 {
 	struct sun4i_tv *tv = drm_encoder_to_sun4i_tv(encoder);
@@ -489,7 +482,6 @@ static void sun4i_tv_mode_set(struct drm_encoder *encoder,
 }
 
 static struct drm_encoder_helper_funcs sun4i_tv_helper_funcs = {
-	.atomic_check	= sun4i_tv_atomic_check,
 	.disable	= sun4i_tv_disable,
 	.enable		= sun4i_tv_enable,
 	.mode_set	= sun4i_tv_mode_set,
-- 
git-series 0.9.1
