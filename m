From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  7 Jun 2016 13:48:11 +0200
Subject: [PATCH v2 16/20] drm: omap: Rely on the default ->best_encoder()
 behavior
In-Reply-To: <1465300095-16971-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1465300095-16971-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1465300095-16971-17-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a 1:1 relationship between connectors and encoders and the
driver is relying on the atomic helpers: we can drop the custom
->best_encoder() implementation and let the core call
drm_atomic_helper_best_encoder() for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/gpu/drm/omapdrm/omap_connector.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
index ce2d67b..137fe69 100644
--- a/drivers/gpu/drm/omapdrm/omap_connector.c
+++ b/drivers/gpu/drm/omapdrm/omap_connector.c
@@ -32,7 +32,6 @@
 struct omap_connector {
 	struct drm_connector base;
 	struct omap_dss_device *dssdev;
-	struct drm_encoder *encoder;
 	bool hdmi_mode;
 };
 
@@ -256,13 +255,6 @@ static int omap_connector_mode_valid(struct drm_connector *connector,
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
@@ -276,7 +268,6 @@ static const struct drm_connector_funcs omap_connector_funcs = {
 static const struct drm_connector_helper_funcs omap_connector_helper_funcs = {
 	.get_modes = omap_connector_get_modes,
 	.mode_valid = omap_connector_mode_valid,
-	.best_encoder = omap_connector_attached_encoder,
 };
 
 /* initialize connector */
@@ -296,7 +287,6 @@ struct drm_connector *omap_connector_init(struct drm_device *dev,
 		goto fail;
 
 	omap_connector->dssdev = dssdev;
-	omap_connector->encoder = encoder;
 
 	connector = &omap_connector->base;
 
-- 
2.7.4
