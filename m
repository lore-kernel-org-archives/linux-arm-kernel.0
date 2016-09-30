From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 30 Sep 2016 16:33:20 +0200
Subject: [PATCH] drm/sun4i: Check that the plane coordinates are not negative
Message-ID: <20160930143320.26241-1-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our planes cannot be set at negative coordinates. Make sure we reject such
configuration.

Reported-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_layer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index f0035bf5efea..f5463c4c2cde 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -29,6 +29,9 @@ struct sun4i_plane_desc {
 static int sun4i_backend_layer_atomic_check(struct drm_plane *plane,
 					    struct drm_plane_state *state)
 {
+	if ((state->crtc_x < 0) || (state->crtc_y < 0))
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.9.3
