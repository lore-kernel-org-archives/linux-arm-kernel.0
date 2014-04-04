From: djkurtz@chromium.org (Daniel Kurtz)
Date: Fri,  4 Apr 2014 17:22:02 +0800
Subject: [PATCH 2/2] drm/exynos/fbdev: don't set mode_config.fb_base
In-Reply-To: <1396603322-13585-1-git-send-email-djkurtz@chromium.org>
References: <1396603322-13585-1-git-send-email-djkurtz@chromium.org>
Message-ID: <1396603322-13585-2-git-send-email-djkurtz@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AFAICT, the fb_base of a drm_device's mode_config is never used.  It isn't
accessed by core drm, it isn't used by fbmem, and it isn't exposed to user
space.

Furthermore, it is probably supposed to be a physical address, not the
dma address mapped to the display controller, so this is just wrong.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
index 2dcc589..3270a36 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
@@ -121,7 +121,6 @@ static int exynos_drm_fbdev_update(struct drm_fb_helper *helper,
 	offset = fbi->var.xoffset * (fb->bits_per_pixel >> 3);
 	offset += fbi->var.yoffset * fb->pitches[0];
 
-	dev->mode_config.fb_base = (resource_size_t)buffer->dma_addr;
 	fbi->screen_base = buffer->kvaddr + offset;
 	fbi->screen_size = size;
 
-- 
1.9.1.423.g4596e3a
