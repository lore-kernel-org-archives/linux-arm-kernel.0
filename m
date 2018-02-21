From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 21 Feb 2018 13:57:03 +0100
Subject: [PATCH 3/3] drm/sun4i: crtc: Call drm_crtc_vblank_on /
 drm_crtc_vblank_off
In-Reply-To: <20180221125703.4595-1-maxime.ripard@bootlin.com>
References: <20180221125703.4595-1-maxime.ripard@bootlin.com>
Message-ID: <20180221125703.4595-3-maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure that the CRTC code will call the enable/disable_vblank hooks.

Otherwise, since the refcounting will be off, we might end up in a
situation where the vblank management functions are called while the CRTC
is off.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_crtc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
index 5decae0069d0..78cbc3145e44 100644
--- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
@@ -93,6 +93,8 @@ static void sun4i_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	DRM_DEBUG_DRIVER("Disabling the CRTC\n");
 
+	drm_crtc_vblank_off(crtc);
+
 	sun4i_tcon_set_status(scrtc->tcon, encoder, false);
 
 	if (crtc->state->event && !crtc->state->active) {
@@ -113,6 +115,8 @@ static void sun4i_crtc_atomic_enable(struct drm_crtc *crtc,
 	DRM_DEBUG_DRIVER("Enabling the CRTC\n");
 
 	sun4i_tcon_set_status(scrtc->tcon, encoder, true);
+
+	drm_crtc_vblank_on(crtc);
 }
 
 static void sun4i_crtc_mode_set_nofb(struct drm_crtc *crtc)
-- 
2.14.3
