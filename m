From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  8 Sep 2017 15:50:15 +0800
Subject: [PATCH 7/8] drm/sun4i: call drm_vblank_init with correct number of
 crtcs
In-Reply-To: <20170908075016.18657-1-wens@csie.org>
References: <20170908075016.18657-1-wens@csie.org>
Message-ID: <20170908075016.18657-8-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we want to have vblank on both pipelines at the same time, we need
to call drm_vblank_init with num_crtcs = 2.

Instead, since the crtc init calls correctly set mode_config.num_crtc,
we can move the drm_vblank_init call to after the crtc init code is
called, which is the component bind part. Then we can just pass
mode_config.num_crtc in.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 2ff4233fe2da..a2012638d5f7 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -106,11 +106,6 @@ static int sun4i_drv_bind(struct device *dev)
 		goto free_drm;
 	}
 
-	/* drm_vblank_init calls kcalloc, which can fail */
-	ret = drm_vblank_init(drm, 1);
-	if (ret)
-		goto free_mem_region;
-
 	drm_mode_config_init(drm);
 
 	ret = component_bind_all(drm->dev, drm);
@@ -119,6 +114,11 @@ static int sun4i_drv_bind(struct device *dev)
 		goto cleanup_mode_config;
 	}
 
+	/* drm_vblank_init calls kcalloc, which can fail */
+	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
+	if (ret)
+		goto free_mem_region;
+
 	drm->irq_enabled = true;
 
 	/* Remove early framebuffers (ie. simplefb) */
-- 
2.14.1
