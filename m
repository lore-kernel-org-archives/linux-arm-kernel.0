From: mark.yao@rock-chips.com (Mark Yao)
Date: Mon, 31 Jul 2017 17:49:55 +0800
Subject: [PATCH 5/6] drm/rockchip: vop: report error when check resource error
In-Reply-To: <1501494569-6825-1-git-send-email-mark.yao@rock-chips.com>
References: <1501494569-6825-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1501494596-7090-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The user would be confused while facing a error commit without
any error report.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index fa0d9f7..999c2e0 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -674,8 +674,10 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
 	 * Src.x1 can be odd when do clip, but yuv plane start point
 	 * need align with 2 pixel.
 	 */
-	if (is_yuv_support(fb->format->format) && ((state->src.x1 >> 16) % 2))
+	if (is_yuv_support(fb->format->format) && ((state->src.x1 >> 16) % 2)) {
+		DRM_ERROR("Invalid Source: Yuv format not support odd xpos\n");
 		return -EINVAL;
+	}
 
 	return 0;
 }
-- 
1.9.1
