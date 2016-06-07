From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  7 Jun 2016 13:47:57 +0200
Subject: [PATCH v2 02/20] drm: arc: Rely on the default ->best_encoder()
 behavior
In-Reply-To: <1465300095-16971-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1465300095-16971-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1465300095-16971-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a 1:1 relationship between connectors and encoders and the
driver is relying on the atomic helpers: we can drop the custom
->best_encoder(), and let the core call drm_atomic_helper_best_encoder()
for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/arc/arcpgu_hdmi.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/arc/arcpgu_hdmi.c b/drivers/gpu/drm/arc/arcpgu_hdmi.c
index 08b6bae..b7a8b2a 100644
--- a/drivers/gpu/drm/arc/arcpgu_hdmi.c
+++ b/drivers/gpu/drm/arc/arcpgu_hdmi.c
@@ -46,23 +46,6 @@ static int arcpgu_drm_connector_get_modes(struct drm_connector *connector)
 	return sfuncs->get_modes(&slave->base, connector);
 }
 
-struct drm_encoder *
-arcpgu_drm_connector_best_encoder(struct drm_connector *connector)
-{
-	struct drm_encoder_slave *slave;
-	struct arcpgu_drm_connector *con =
-		container_of(connector, struct arcpgu_drm_connector, connector);
-
-	slave = con->encoder_slave;
-	if (slave == NULL) {
-		dev_err(connector->dev->dev,
-			"connector_best_encoder: cannot find slave encoder for connector\n");
-		return NULL;
-	}
-
-	return &slave->base;
-}
-
 static enum drm_connector_status
 arcpgu_drm_connector_detect(struct drm_connector *connector, bool force)
 {
@@ -97,7 +80,6 @@ static void arcpgu_drm_connector_destroy(struct drm_connector *connector)
 static const struct drm_connector_helper_funcs
 arcpgu_drm_connector_helper_funcs = {
 	.get_modes = arcpgu_drm_connector_get_modes,
-	.best_encoder = arcpgu_drm_connector_best_encoder,
 };
 
 static const struct drm_connector_funcs arcpgu_drm_connector_funcs = {
-- 
2.7.4
