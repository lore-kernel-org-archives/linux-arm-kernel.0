From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  2 Jun 2016 16:31:43 +0200
Subject: [PATCH 16/20] drm: omap: Rely on the default ->best_encoder() behavior
In-Reply-To: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1464877907-27723-17-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a 1:1 relationship between connectors and encoders and the
driver is relying on the atomic helpers: we can drop the custom
->best_encoder() implementation and let the core call
drm_atomic_helper_best_encoder() for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/omapdrm/omap_connector.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
index ce2d67b..80af5e1 100644
--- a/drivers/gpu/drm/omapdrm/omap_connector.c
+++ b/drivers/gpu/drm/omapdrm/omap_connector.c
@@ -256,13 +256,6 @@ static int omap_connector_mode_valid(struct drm_connector *connector,
 	return ret;
 }
 
-struct drm_encoder *omap_connector_attached_encoder(
-		struct drm_connector *connector)
-{
-	struct omap_connector *omap_connector = to_omap_connector(connector);
-	return omap_connector->encoder;
-}
-
 static const struct drm_connector_funcs omap_connector_funcs = {
 	.dpms = drm_atomic_helper_connector_dpms,
 	.reset = drm_atomic_helper_connector_reset,
@@ -276,7 +269,6 @@ static const struct drm_connector_funcs omap_connector_funcs = {
 static const struct drm_connector_helper_funcs omap_connector_helper_funcs = {
 	.get_modes = omap_connector_get_modes,
 	.mode_valid = omap_connector_mode_valid,
-	.best_encoder = omap_connector_attached_encoder,
 };
 
 /* initialize connector */
-- 
2.7.4
