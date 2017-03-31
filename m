From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 31 Mar 2017 10:51:52 +0100
Subject: [PATCH 3/3] drm/arm: hdlcd: check for rotation
In-Reply-To: <20170331094937.GO7909@n2100.armlinux.org.uk>
References: <20170331094937.GO7909@n2100.armlinux.org.uk>
Message-ID: <E1cttDk-00067G-1b@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hdlcd does not support rotation - check for it and reject plane updates
that try to rotate a plane.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/arm/hdlcd_crtc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
index cf70184fd028..171acc842368 100644
--- a/drivers/gpu/drm/arm/hdlcd_crtc.c
+++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
@@ -215,6 +215,10 @@ static int hdlcd_plane_atomic_check(struct drm_plane *plane,
 	if (!crtc)
 		return 0;
 
+	/* We do not support rotation */
+	if (state->rotation != DRM_ROTATE_0)
+		return -EINVAL;
+
 	crtc_state = drm_atomic_get_existing_crtc_state(state->state, crtc);
 	if (!crtc_state->enable)
 		return -EINVAL;
-- 
2.7.4
