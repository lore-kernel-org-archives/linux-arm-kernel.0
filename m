From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 17 Feb 2017 11:13:24 +0800
Subject: [PATCH 1/7] drm/sun4i: Move drm_mode_config_cleanup call to main
 driver
In-Reply-To: <20170217031330.14087-1-wens@csie.org>
References: <20170217031330.14087-1-wens@csie.org>
Message-ID: <20170217031330.14087-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drm_mode_config_cleanup is the complement of drm_mode_config_init, which
is called in the bind function of sun4i_drv. drm_mode_config_cleanup
should be put in the unbind function to match.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c         | 1 +
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 4ce665349f6b..99a0f1861be2 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -188,6 +188,7 @@ static void sun4i_drv_unbind(struct device *dev)
 	drm_dev_unregister(drm);
 	drm_kms_helper_poll_fini(drm);
 	sun4i_framebuffer_free(drm);
+	drm_mode_config_cleanup(drm);
 	drm_vblank_cleanup(drm);
 	drm_dev_unref(drm);
 }
diff --git a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
index 8b6ce619ad81..0c72b54c047d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
@@ -50,5 +50,4 @@ void sun4i_framebuffer_free(struct drm_device *drm)
 	struct sun4i_drv *drv = drm->dev_private;
 
 	drm_fbdev_cma_fini(drv->fbdev);
-	drm_mode_config_cleanup(drm);
 }
-- 
2.11.0
