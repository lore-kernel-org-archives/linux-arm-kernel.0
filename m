From: hjc@rock-chips.com (Sandy Huang)
Date: Tue, 26 Jun 2018 16:16:44 +0800
Subject: [PATCH] drm/rockchip: vop: fixup linebuffer mode calc error
Message-ID: <1530001004-25036-1-git-send-email-hjc@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

linebuffer mode should be LB_YUV_3840X5 when width is bigger
than 1280 in yuv mode.
seperate yuv and rgb case make the scl_vop_cal_lb_mode() logic
is clearer.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1523960108-190541-1-git-send-email-hjc at rock-chips.com
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 084acdd..fcb9104 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -331,16 +331,19 @@ static inline int scl_vop_cal_lb_mode(int width, bool is_yuv)
 {
 	int lb_mode;
 
-	if (width > 2560)
-		lb_mode = LB_RGB_3840X2;
-	else if (width > 1920)
-		lb_mode = LB_RGB_2560X4;
-	else if (!is_yuv)
-		lb_mode = LB_RGB_1920X5;
-	else if (width > 1280)
-		lb_mode = LB_YUV_3840X5;
-	else
-		lb_mode = LB_YUV_2560X8;
+	if (is_yuv) {
+		if (width > 1280)
+			lb_mode = LB_YUV_3840X5;
+		else
+			lb_mode = LB_YUV_2560X8;
+	} else {
+		if (width > 2560)
+			lb_mode = LB_RGB_3840X2;
+		else if (width > 1920)
+			lb_mode = LB_RGB_2560X4;
+		else
+			lb_mode = LB_RGB_1920X5;
+	}
 
 	return lb_mode;
 }
-- 
2.7.4
