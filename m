From: mark.yao@rock-chips.com (Mark Yao)
Date: Mon, 31 Jul 2017 17:49:50 +0800
Subject: [PATCH 4/6] drm/rockchip: vop: round_up pitches to word align
In-Reply-To: <1501494569-6825-1-git-send-email-mark.yao@rock-chips.com>
References: <1501494569-6825-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1501494591-7034-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VOP pitch register is word align, need align to word.

VOP_WIN0_VIR:
  bit[31:16] win0_vir_stride_uv
    Number of words of Win0 uv Virtual width
  bit[15:0] win0_vir_width
    Number of words of Win0 yrgb Virtual width
    ARGB888 : win0_vir_width
    RGB888 : (win0_vir_width*3/4) + (win0_vir_width%3)
    RGB565 : ceil(win0_vir_width/2)
    YUV : ceil(win0_vir_width/4)

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 0b5fd75..fa0d9f7 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -756,7 +756,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	spin_lock(&vop->reg_lock);
 
 	VOP_WIN_SET(vop, win, format, format);
-	VOP_WIN_SET(vop, win, yrgb_vir, fb->pitches[0] >> 2);
+	VOP_WIN_SET(vop, win, yrgb_vir, DIV_ROUND_UP(fb->pitches[0], 4));
 	VOP_WIN_SET(vop, win, yrgb_mst, dma_addr);
 	if (is_yuv_support(fb->format->format)) {
 		int hsub = drm_format_horz_chroma_subsampling(fb->format->format);
@@ -770,7 +770,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 		offset += (src->y1 >> 16) * fb->pitches[1] / vsub;
 
 		dma_addr = rk_uv_obj->dma_addr + offset + fb->offsets[1];
-		VOP_WIN_SET(vop, win, uv_vir, fb->pitches[1] >> 2);
+		VOP_WIN_SET(vop, win, uv_vir, DIV_ROUND_UP(fb->pitches[1], 4));
 		VOP_WIN_SET(vop, win, uv_mst, dma_addr);
 	}
 
-- 
1.9.1
