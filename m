From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Feb 2018 13:40:19 +0100
Subject: [PATCH] drm/pl111: Fix regression from fbdev CMA helper
Message-ID: <20180212124019.25268-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit d18df744de1a ("drm/pl111: Use drm_fb_cma_fbdev_init/fini()")
refactored the driver to use fbdev handling in the core, but
mistakedly limited the number of maximum connections to 0.

Predictably, zero possible connections also gives zero
framebuffers when using the system. So let's bump it to 1 so
we get our framebuffer back.

Cc: Noralf Tr?nnes <noralf@tronnes.org>
Cc: Eric Anholt <eric@anholt.net>
Fixes: d18df744de1a ("drm/pl111: Use drm_fb_cma_fbdev_init/fini()")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/pl111/pl111_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index acb738c69873..306ac7cabd90 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -138,7 +138,7 @@ static int pl111_modeset_init(struct drm_device *dev)
 
 	drm_mode_config_reset(dev);
 
-	drm_fb_cma_fbdev_init(dev, 32, 0);
+	drm_fb_cma_fbdev_init(dev, 32, 1);
 
 	drm_kms_helper_poll_init(dev);
 
-- 
2.14.3
