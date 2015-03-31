From: wxt@rock-chips.com (Caesar Wang)
Date: Tue, 31 Mar 2015 18:22:50 +0800
Subject: [PATCH] drm: rockchip: Turn off VT switching on suspend
In-Reply-To: <1427797370-32441-1-git-send-email-wxt@rock-chips.com>
References: <1427797370-32441-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1427797370-32441-2-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drm/rockchip already has support for disabling all displays on suspend
and enabling them on resume.

Disable automatic VT switching on suspend by the pm console tracking
layer.

Tested on veyron, used `echo mem > sys/power/state`
  => verified no VT switch

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
index a5d889a..eb4e0db 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
@@ -119,6 +119,9 @@ static int rockchip_drm_fbdev_create(struct drm_fb_helper *helper,
 	DRM_DEBUG_KMS("FB [%dx%d]-%d kvaddr=%p offset=%ld size=%d\n",
 		      fb->width, fb->height, fb->depth, rk_obj->kvaddr,
 		      offset, size);
+
+	fbi->skip_vt_switch = true;
+
 	return 0;
 
 err_drm_framebuffer_unref:
-- 
1.9.1
