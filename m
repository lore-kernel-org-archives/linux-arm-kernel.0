From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:24:38 +0100
Subject: [PATCH v2 06/43] drm/sun4i: backend: Refine the logic behind using
 the frontend
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-7-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Checking that scaling is in use is not sufficient as a condition to
decide to use the frontend.

Since not all layer formats are supported by the frontend, we need to
check for that support first. Then, the frontend must only be enabled
if the backend doesn't support the format or that scaling is required.

Signed-off-by:Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 7dd24eb03f89..735fea7ead0b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -449,16 +449,32 @@ static bool sun4i_backend_plane_uses_frontend(struct drm_plane_state *state)
 {
 	struct sun4i_layer *layer = plane_to_sun4i_layer(state->plane);
 	struct sun4i_backend *backend = layer->backend;
+	uint32_t format = state->fb->format->format;
 
 	if (IS_ERR(backend->frontend))
 		return false;
 
+	if (!sun4i_frontend_format_is_supported(format))
+		return false;
+
+	if (!sun4i_backend_format_is_supported(format))
+		return true;
+
 	/*
 	 * TODO: The backend alone allows 2x and 4x integer scaling, including
 	 * support for an alpha component (which the frontend doesn't support).
-	 * Use the backend directly instead of the frontend in this case.
+	 * Use the backend directly instead of the frontend in this case, with
+	 * another test to return false.
+	 */
+
+	if (sun4i_backend_plane_uses_scaler(state))
+		return true;
+
+	/*
+	 * Here the format is supported by both the frontend and the backend
+	 * and no frontend scaling is required, so use the backend directly.
 	 */
-	return sun4i_backend_plane_uses_scaler(state);
+	return false;
 }
 
 static void sun4i_backend_atomic_begin(struct sunxi_engine *engine,
-- 
2.19.1
