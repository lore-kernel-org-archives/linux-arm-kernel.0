From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue, 21 Jul 2015 16:20:02 +0800
Subject: [PATCH v3 1/6] drm/rockchip: vop: Fix virtual stride calculation
In-Reply-To: <1437466807-13689-1-git-send-email-mark.yao@rock-chips.com>
References: <1437466807-13689-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1437466807-13689-2-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vir_stride need number words of the virtual width, and fb->pitches
save bytes_per_pixel, so just div 4 switch to stride.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
Changes in v3:
Adviced by Tomasz Figa
- use more suitable tile for this patch. 

Changes in v2: None

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 4557f33..3558acb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -644,7 +644,7 @@ static int vop_update_plane_event(struct drm_plane *plane,
 	offset += (src.y1 >> 16) * fb->pitches[0];
 	yrgb_mst = rk_obj->dma_addr + offset;
 
-	y_vir_stride = fb->pitches[0] / (fb->bits_per_pixel >> 3);
+	y_vir_stride = fb->pitches[0] >> 2;
 
 	/*
 	 * If this plane update changes the plane's framebuffer, (or more
-- 
1.7.9.5
