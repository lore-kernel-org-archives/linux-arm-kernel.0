From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Jan 2018 11:35:37 +0100
Subject: [PATCH v2 08/19] drm/rcar-du: Convert to the new generic alpha
 property
In-Reply-To: <cover.9e7b6a702e4d90a13d08fbe3b0a319cbf4db687f.1516617243.git-series.maxime.ripard@free-electrons.com>
References: <cover.9e7b6a702e4d90a13d08fbe3b0a319cbf4db687f.1516617243.git-series.maxime.ripard@free-electrons.com>
Message-ID: <368e562a3dbe33cab54174ff1155b8bbe83c2ed7.1516617243.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have support for per-plane alpha in the core, let's use it.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.h   |  1 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c   |  5 +---
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 15 +++------
 drivers/gpu/drm/rcar-du/rcar_du_plane.h |  2 +-
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c   | 42 ++------------------------
 drivers/gpu/drm/rcar-du/rcar_du_vsp.h   |  2 +-
 6 files changed, 9 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
index f8cd79488ece..aff04adaae53 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
@@ -89,7 +89,6 @@ struct rcar_du_device {
 	struct rcar_du_vsp vsps[RCAR_DU_MAX_VSPS];
 
 	struct {
-		struct drm_property *alpha;
 		struct drm_property *colorkey;
 	} props;
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 566d1a948c8f..e1b5a7b460cc 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -417,11 +417,6 @@ static int rcar_du_encoders_init(struct rcar_du_device *rcdu)
 
 static int rcar_du_properties_init(struct rcar_du_device *rcdu)
 {
-	rcdu->props.alpha =
-		drm_property_create_range(rcdu->ddev, 0, "alpha", 0, 255);
-	if (rcdu->props.alpha == NULL)
-		return -ENOMEM;
-
 	/*
 	 * The color key is expressed as an RGB888 triplet stored in a 32-bit
 	 * integer in XRGB8888 format. Bit 24 is used as a flag to disable (0)
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index 61833cc1c699..5b34e8092c8b 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -423,7 +423,7 @@ static void rcar_du_plane_setup_mode(struct rcar_du_group *rgrp,
 		rcar_du_plane_write(rgrp, index, PnALPHAR, PnALPHAR_ABIT_0);
 	else
 		rcar_du_plane_write(rgrp, index, PnALPHAR,
-				    PnALPHAR_ABIT_X | state->alpha);
+				    PnALPHAR_ABIT_X | state->state.alpha);
 
 	pnmr = PnMR_BM_MD | state->format->pnmr;
 
@@ -667,11 +667,11 @@ static void rcar_du_plane_reset(struct drm_plane *plane)
 
 	state->hwindex = -1;
 	state->source = RCAR_DU_PLANE_MEMORY;
-	state->alpha = 255;
 	state->colorkey = RCAR_DU_COLORKEY_NONE;
 	state->state.zpos = plane->type == DRM_PLANE_TYPE_PRIMARY ? 0 : 1;
 
 	plane->state = &state->state;
+	plane->state->alpha = 255;
 	plane->state->plane = plane;
 }
 
@@ -683,9 +683,7 @@ static int rcar_du_plane_atomic_set_property(struct drm_plane *plane,
 	struct rcar_du_plane_state *rstate = to_rcar_plane_state(state);
 	struct rcar_du_device *rcdu = to_rcar_plane(plane)->group->dev;
 
-	if (property == rcdu->props.alpha)
-		rstate->alpha = val;
-	else if (property == rcdu->props.colorkey)
+	if (property == rcdu->props.colorkey)
 		rstate->colorkey = val;
 	else
 		return -EINVAL;
@@ -701,9 +699,7 @@ static int rcar_du_plane_atomic_get_property(struct drm_plane *plane,
 		container_of(state, const struct rcar_du_plane_state, state);
 	struct rcar_du_device *rcdu = to_rcar_plane(plane)->group->dev;
 
-	if (property == rcdu->props.alpha)
-		*val = rstate->alpha;
-	else if (property == rcdu->props.colorkey)
+	if (property == rcdu->props.colorkey)
 		*val = rstate->colorkey;
 	else
 		return -EINVAL;
@@ -772,10 +768,9 @@ int rcar_du_planes_init(struct rcar_du_group *rgrp)
 			continue;
 
 		drm_object_attach_property(&plane->plane.base,
-					   rcdu->props.alpha, 255);
-		drm_object_attach_property(&plane->plane.base,
 					   rcdu->props.colorkey,
 					   RCAR_DU_COLORKEY_NONE);
+		drm_plane_create_alpha_property(&plane->plane, 255);
 		drm_plane_create_zpos_property(&plane->plane, 1, 1, 7);
 	}
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.h b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
index f62e09f195de..2dc793ebd1a2 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
@@ -50,7 +50,6 @@ static inline struct rcar_du_plane *to_rcar_plane(struct drm_plane *plane)
  * @state: base DRM plane state
  * @format: information about the pixel format used by the plane
  * @hwindex: 0-based hardware plane index, -1 means unused
- * @alpha: value of the plane alpha property
  * @colorkey: value of the plane colorkey property
  */
 struct rcar_du_plane_state {
@@ -60,7 +59,6 @@ struct rcar_du_plane_state {
 	int hwindex;
 	enum rcar_du_plane_source source;
 
-	unsigned int alpha;
 	unsigned int colorkey;
 };
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
index 2c96147bc444..ee85f6fdffad 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
@@ -54,6 +54,7 @@ void rcar_du_vsp_enable(struct rcar_du_crtc *crtc)
 	};
 	struct rcar_du_plane_state state = {
 		.state = {
+			.alpha = 255,
 			.crtc = &crtc->crtc,
 			.crtc_x = 0,
 			.crtc_y = 0,
@@ -67,7 +68,6 @@ void rcar_du_vsp_enable(struct rcar_du_crtc *crtc)
 		},
 		.format = rcar_du_format_info(DRM_FORMAT_ARGB8888),
 		.source = RCAR_DU_PLANE_VSPD1,
-		.alpha = 255,
 		.colorkey = 0,
 	};
 
@@ -173,7 +173,7 @@ static void rcar_du_vsp_plane_setup(struct rcar_du_vsp_plane *plane)
 	struct vsp1_du_atomic_config cfg = {
 		.pixelformat = 0,
 		.pitch = fb->pitches[0],
-		.alpha = state->alpha,
+		.alpha = state->state.alpha,
 		.zpos = state->state.zpos,
 	};
 	unsigned int i;
@@ -351,44 +351,13 @@ static void rcar_du_vsp_plane_reset(struct drm_plane *plane)
 	if (state == NULL)
 		return;
 
-	state->alpha = 255;
+	state->state.alpha = 255;
 	state->state.zpos = plane->type == DRM_PLANE_TYPE_PRIMARY ? 0 : 1;
 
 	plane->state = &state->state;
 	plane->state->plane = plane;
 }
 
-static int rcar_du_vsp_plane_atomic_set_property(struct drm_plane *plane,
-	struct drm_plane_state *state, struct drm_property *property,
-	uint64_t val)
-{
-	struct rcar_du_vsp_plane_state *rstate = to_rcar_vsp_plane_state(state);
-	struct rcar_du_device *rcdu = to_rcar_vsp_plane(plane)->vsp->dev;
-
-	if (property == rcdu->props.alpha)
-		rstate->alpha = val;
-	else
-		return -EINVAL;
-
-	return 0;
-}
-
-static int rcar_du_vsp_plane_atomic_get_property(struct drm_plane *plane,
-	const struct drm_plane_state *state, struct drm_property *property,
-	uint64_t *val)
-{
-	const struct rcar_du_vsp_plane_state *rstate =
-		container_of(state, const struct rcar_du_vsp_plane_state, state);
-	struct rcar_du_device *rcdu = to_rcar_vsp_plane(plane)->vsp->dev;
-
-	if (property == rcdu->props.alpha)
-		*val = rstate->alpha;
-	else
-		return -EINVAL;
-
-	return 0;
-}
-
 static const struct drm_plane_funcs rcar_du_vsp_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
@@ -396,8 +365,6 @@ static const struct drm_plane_funcs rcar_du_vsp_plane_funcs = {
 	.destroy = drm_plane_cleanup,
 	.atomic_duplicate_state = rcar_du_vsp_plane_atomic_duplicate_state,
 	.atomic_destroy_state = rcar_du_vsp_plane_atomic_destroy_state,
-	.atomic_set_property = rcar_du_vsp_plane_atomic_set_property,
-	.atomic_get_property = rcar_du_vsp_plane_atomic_get_property,
 };
 
 int rcar_du_vsp_init(struct rcar_du_vsp *vsp, struct device_node *np,
@@ -454,8 +421,7 @@ int rcar_du_vsp_init(struct rcar_du_vsp *vsp, struct device_node *np,
 		if (type == DRM_PLANE_TYPE_PRIMARY)
 			continue;
 
-		drm_object_attach_property(&plane->plane.base,
-					   rcdu->props.alpha, 255);
+		drm_plane_create_alpha_property(&plane->plane, 255);
 		drm_plane_create_zpos_property(&plane->plane, 1, 1,
 					       vsp->num_planes - 1);
 	}
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp.h b/drivers/gpu/drm/rcar-du/rcar_du_vsp.h
index f876c512163c..8b19914761e4 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_vsp.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_vsp.h
@@ -44,7 +44,6 @@ static inline struct rcar_du_vsp_plane *to_rcar_vsp_plane(struct drm_plane *p)
  * @state: base DRM plane state
  * @format: information about the pixel format used by the plane
  * @sg_tables: scatter-gather tables for the frame buffer memory
- * @alpha: value of the plane alpha property
  * @zpos: value of the plane zpos property
  */
 struct rcar_du_vsp_plane_state {
@@ -53,7 +52,6 @@ struct rcar_du_vsp_plane_state {
 	const struct rcar_du_format_info *format;
 	struct sg_table sg_tables[3];
 
-	unsigned int alpha;
 	unsigned int zpos;
 };
 
-- 
git-series 0.9.1
