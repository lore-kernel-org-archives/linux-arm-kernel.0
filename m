From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  2 Jun 2016 16:31:39 +0200
Subject: [PATCH 12/20] drm: sun4i: Rely on the default ->best_encoder()
 behavior
In-Reply-To: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1464877907-27723-13-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All outputs have a 1:1 relationship between connectors and encoders
and the driver is relying on the atomic helpers: we can drop the custom
->best_encoder() implementations and let the core call
drm_atomic_helper_best_encoder() for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_rgb.c | 10 ----------
 drivers/gpu/drm/sun4i/sun4i_tv.c  |  9 ---------
 2 files changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index ab64948..442cfe2 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -90,19 +90,9 @@ static int sun4i_rgb_mode_valid(struct drm_connector *connector,
 	return MODE_OK;
 }
 
-static struct drm_encoder *
-sun4i_rgb_best_encoder(struct drm_connector *connector)
-{
-	struct sun4i_rgb *rgb =
-		drm_connector_to_sun4i_rgb(connector);
-
-	return &rgb->encoder;
-}
-
 static struct drm_connector_helper_funcs sun4i_rgb_con_helper_funcs = {
 	.get_modes	= sun4i_rgb_get_modes,
 	.mode_valid	= sun4i_rgb_mode_valid,
-	.best_encoder	= sun4i_rgb_best_encoder,
 };
 
 static enum drm_connector_status
diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
index bc047f9..b841478 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
@@ -526,18 +526,9 @@ static int sun4i_tv_comp_mode_valid(struct drm_connector *connector,
 	return MODE_OK;
 }
 
-static struct drm_encoder *
-sun4i_tv_comp_best_encoder(struct drm_connector *connector)
-{
-	struct sun4i_tv *tv = drm_connector_to_sun4i_tv(connector);
-
-	return &tv->encoder;
-}
-
 static struct drm_connector_helper_funcs sun4i_tv_comp_connector_helper_funcs = {
 	.get_modes	= sun4i_tv_comp_get_modes,
 	.mode_valid	= sun4i_tv_comp_mode_valid,
-	.best_encoder	= sun4i_tv_comp_best_encoder,
 };
 
 static enum drm_connector_status
-- 
2.7.4
