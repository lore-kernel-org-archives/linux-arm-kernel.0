From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  9 Jan 2018 11:56:32 +0100
Subject: [PATCH 13/19] drm/sun4i: backend: Set a default zpos in our reset hook
In-Reply-To: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
References: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
Message-ID: <63f77d84e998ae7b9a1a583de94c1a5c13cb10cb.1515494838.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The our plane state zpos value will be set only if there's an existing
state attached to the plane when creating the property.

However, this is not the case during the probe, and we therefore need to
put our default value in our reset hook.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_layer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index c448cb6b9fa9..03549646528a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -28,6 +28,7 @@ struct sun4i_plane_desc {
 
 static void sun4i_backend_layer_reset(struct drm_plane *plane)
 {
+	struct sun4i_layer *layer = plane_to_sun4i_layer(plane);
 	struct sun4i_layer_state *state;
 
 	if (plane->state) {
@@ -43,6 +44,7 @@ static void sun4i_backend_layer_reset(struct drm_plane *plane)
 	if (state) {
 		plane->state = &state->state;
 		plane->state->plane = plane;
+		plane->state->zpos = layer->id;
 	}
 }
 
-- 
git-series 0.9.1
