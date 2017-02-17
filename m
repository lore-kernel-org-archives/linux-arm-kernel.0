From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 17 Feb 2017 11:13:25 +0800
Subject: [PATCH 2/7] drm/sun4i: Fix up error path cleanup for master bind
 function
In-Reply-To: <20170217031330.14087-1-wens@csie.org>
References: <20170217031330.14087-1-wens@csie.org>
Message-ID: <20170217031330.14087-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The master bind function calls numerous drm functions which initialize
underlying structures. It also tries to bind the various components
of the display pipeline, some of which may add additional drm objects.

This patch adds proper cleanup functions in the error path of the
master bind function.

This requires the patch "drm/sun4i: Move drm_mode_config_cleanup call
to main driver", which splits out drm_mode_config_cleanup from
sun4i_framebuffer_free so we can call it separately.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 99a0f1861be2..8e777167bca4 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -136,7 +136,7 @@ static int sun4i_drv_bind(struct device *dev)
 	ret = component_bind_all(drm->dev, drm);
 	if (ret) {
 		dev_err(drm->dev, "Couldn't bind all pipelines components\n");
-		goto free_drm;
+		goto cleanup_mode_config;
 	}
 
 	/* Create our layers */
@@ -144,7 +144,7 @@ static int sun4i_drv_bind(struct device *dev)
 	if (IS_ERR(drv->layers)) {
 		dev_err(drm->dev, "Couldn't create the planes\n");
 		ret = PTR_ERR(drv->layers);
-		goto free_drm;
+		goto cleanup_mode_config;
 	}
 
 	/* Create our CRTC */
@@ -152,7 +152,7 @@ static int sun4i_drv_bind(struct device *dev)
 	if (!drv->crtc) {
 		dev_err(drm->dev, "Couldn't create the CRTC\n");
 		ret = -EINVAL;
-		goto free_drm;
+		goto cleanup_mode_config;
 	}
 	drm->irq_enabled = true;
 
@@ -164,7 +164,7 @@ static int sun4i_drv_bind(struct device *dev)
 	if (IS_ERR(drv->fbdev)) {
 		dev_err(drm->dev, "Couldn't create our framebuffer\n");
 		ret = PTR_ERR(drv->fbdev);
-		goto free_drm;
+		goto cleanup_mode_config;
 	}
 
 	/* Enable connectors polling */
@@ -172,10 +172,16 @@ static int sun4i_drv_bind(struct device *dev)
 
 	ret = drm_dev_register(drm, 0);
 	if (ret)
-		goto free_drm;
+		goto finish_poll;
 
 	return 0;
 
+finish_poll:
+	drm_kms_helper_poll_fini(drm);
+	sun4i_framebuffer_free(drm);
+cleanup_mode_config:
+	drm_mode_config_cleanup(drm);
+	drm_vblank_cleanup(drm);
 free_drm:
 	drm_dev_unref(drm);
 	return ret;
-- 
2.11.0
