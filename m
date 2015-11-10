From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue, 10 Nov 2015 17:59:10 +0800
Subject: [PATCH] drm/rockchip: vop: fix window origin calculation
Message-ID: <1447149550-18595-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dominik Behr <dbehr@chromium.org>

VOP_WINx_DSP_ST does not require subtracting 1 from the values written to
it. It actually causes the screen to be shifted by one pixel.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 48719df..4730ae4 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -959,8 +959,8 @@ static int vop_update_plane_event(struct drm_plane *plane,
 	val = (dest.y2 - dest.y1 - 1) << 16;
 	val |= (dest.x2 - dest.x1 - 1) & 0xffff;
 	VOP_WIN_SET(vop, win, dsp_info, val);
-	val = (dsp_sty - 1) << 16;
-	val |= (dsp_stx - 1) & 0xffff;
+	val = dsp_sty << 16;
+	val |= dsp_stx & 0xffff;
 	VOP_WIN_SET(vop, win, dsp_st, val);
 	VOP_WIN_SET(vop, win, rb_swap, rb_swap);
 
-- 
1.7.9.5
