From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  3 Jan 2017 10:20:54 +0100
Subject: [PATCH] drm/meson: Fix plane atomic check when no crtc for the plane
Message-ID: <1483435254-27955-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When no CRTC is associated with the plane, the meson_plane_atomic_check()
call breaks the kernel with an Oops.

Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_plane.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
index 4942ca0..7890e30 100644
--- a/drivers/gpu/drm/meson/meson_plane.c
+++ b/drivers/gpu/drm/meson/meson_plane.c
@@ -51,6 +51,9 @@ static int meson_plane_atomic_check(struct drm_plane *plane,
 	struct drm_crtc_state *crtc_state;
 	struct drm_rect clip = { 0, };
 
+	if (!state->crtc)
+		return 0;
+
 	crtc_state = drm_atomic_get_crtc_state(state->state, state->crtc);
 	if (IS_ERR(crtc_state))
 		return PTR_ERR(crtc_state);
-- 
1.9.1
