From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 17 Feb 2017 11:13:30 +0800
Subject: [PATCH 7/7] drm/sun4i: Make sun4i_crtc_init return ERR_PTR style
 error codes
In-Reply-To: <20170217031330.14087-1-wens@csie.org>
References: <20170217031330.14087-1-wens@csie.org>
Message-ID: <20170217031330.14087-8-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sun4i_crtc_init can fail for a number of reasons. Instead of returning
a NULL pointer when it fails, pass back the encountered error using
ERR_PTR.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_crtc.c | 4 ++--
 drivers/gpu/drm/sun4i/sun4i_drv.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
index 4a192210574f..4e2e89c3104f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
@@ -121,7 +121,7 @@ struct sun4i_crtc *sun4i_crtc_init(struct drm_device *drm)
 
 	scrtc = devm_kzalloc(drm->dev, sizeof(*scrtc), GFP_KERNEL);
 	if (!scrtc)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	scrtc->drv = drv;
 
 	ret = drm_crtc_init_with_planes(drm, &scrtc->crtc,
@@ -131,7 +131,7 @@ struct sun4i_crtc *sun4i_crtc_init(struct drm_device *drm)
 					NULL);
 	if (ret) {
 		dev_err(drm->dev, "Couldn't init DRM CRTC\n");
-		return NULL;
+		return ERR_PTR(ret);
 	}
 
 	drm_crtc_helper_add(&scrtc->crtc, &sun4i_crtc_helper_funcs);
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 63c46643fdd1..fc6ef4066c59 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -153,9 +153,9 @@ static int sun4i_drv_bind(struct device *dev)
 
 	/* Create our CRTC */
 	drv->crtc = sun4i_crtc_init(drm);
-	if (!drv->crtc) {
+	if (IS_ERR(drv->crtc)) {
 		dev_err(drm->dev, "Couldn't create the CRTC\n");
-		ret = -EINVAL;
+		ret = PTR_ERR(drv->crtc);
 		goto cleanup_mode_config;
 	}
 	drm->irq_enabled = true;
-- 
2.11.0
