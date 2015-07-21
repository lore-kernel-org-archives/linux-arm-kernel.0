From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue, 21 Jul 2015 16:20:03 +0800
Subject: [PATCH v3 2/6] drm/rockchip: vop: Fix window dest start point
In-Reply-To: <1437466807-13689-1-git-send-email-mark.yao@rock-chips.com>
References: <1437466807-13689-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1437466807-13689-3-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dest start point use crtc_x/y is wrong, crtc_x/y is not equal
to dest.x1/y1 at plane scale.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 3558acb..c7e0283 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -634,11 +634,9 @@ static int vop_update_plane_event(struct drm_plane *plane,
 
 	actual_w = (src.x2 - src.x1) >> 16;
 	actual_h = (src.y2 - src.y1) >> 16;
-	crtc_x = max(0, crtc_x);
-	crtc_y = max(0, crtc_y);
 
-	dsp_stx = crtc_x + crtc->mode.htotal - crtc->mode.hsync_start;
-	dsp_sty = crtc_y + crtc->mode.vtotal - crtc->mode.vsync_start;
+	dsp_stx = dest.x1 + crtc->mode.htotal - crtc->mode.hsync_start;
+	dsp_sty = dest.y1 + crtc->mode.vtotal - crtc->mode.vsync_start;
 
 	offset = (src.x1 >> 16) * (fb->bits_per_pixel >> 3);
 	offset += (src.y1 >> 16) * fb->pitches[0];
-- 
1.7.9.5
