From: mark.yao@rock-chips.com (Mark Yao)
Date: Thu, 14 Jul 2016 11:33:27 +0800
Subject: [PATCH 5/6] drm/rockchip: vop: correct the source size of uv scale
 factor setting
In-Reply-To: <1468467090-6108-1-git-send-email-mark.yao@rock-chips.com>
References: <1468467090-6108-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1468467207-6715-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the input color format is YUV, we need to do some external scale
for CBCR. Like,
 * In YUV420 data format:
     cbcr_xscale = dst_w / src_w * 2;
     cbcr_yscale = dst_h / src_h * 2;
 * In YUV422 data format:
     cbcr_xscale = dst_w / src_w * 2;
     cbcr_yscale = dst_h / src_h;
 * In YUV444 data format
     cbcr_xscale = dst_w / src_w;
     cbcr_yscale = dst_h / src_h;

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index e01c435..aad105b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -328,9 +328,9 @@ static void scl_vop_cal_scl_fac(struct vop *vop, const struct vop_win_data *win,
 			    scl_cal_scale2(src_h, dst_h));
 		if (is_yuv) {
 			VOP_SCL_SET(vop, win, scale_cbcr_x,
-				    scl_cal_scale2(src_w, dst_w));
+				    scl_cal_scale2(cbcr_src_w, dst_w));
 			VOP_SCL_SET(vop, win, scale_cbcr_y,
-				    scl_cal_scale2(src_h, dst_h));
+				    scl_cal_scale2(cbcr_src_h, dst_h));
 		}
 		return;
 	}
-- 
1.9.1
