From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  7 Jun 2016 13:48:13 +0200
Subject: [PATCH v2 18/20] drm/bridge: ptn3460: Rely on the default
 ->best_encoder() behavior
In-Reply-To: <1465300095-16971-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1465300095-16971-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1465300095-16971-19-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a 1:1 relationship between connectors and encoders, and the driver
is relying on the atomic helpers: we can drop the custom ->best_encoder(),
and let the core call drm_atomic_helper_best_encoder() for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/bridge/nxp-ptn3460.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
index 7ecd59f..93f3dac 100644
--- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
+++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
@@ -235,16 +235,8 @@ out:
 	return num_modes;
 }
 
-static struct drm_encoder *ptn3460_best_encoder(struct drm_connector *connector)
-{
-	struct ptn3460_bridge *ptn_bridge = connector_to_ptn3460(connector);
-
-	return ptn_bridge->bridge.encoder;
-}
-
 static const struct drm_connector_helper_funcs ptn3460_connector_helper_funcs = {
 	.get_modes = ptn3460_get_modes,
-	.best_encoder = ptn3460_best_encoder,
 };
 
 static enum drm_connector_status ptn3460_detect(struct drm_connector *connector,
-- 
2.7.4
