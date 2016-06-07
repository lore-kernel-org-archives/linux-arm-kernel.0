From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  7 Jun 2016 13:48:14 +0200
Subject: [PATCH v2 19/20] drm/bridge: ps8622: Rely on the default
 ->best_encoder() behavior
In-Reply-To: <1465300095-16971-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1465300095-16971-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1465300095-16971-20-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a 1:1 relationship between connectors and encoders, and the driver
is relying on the atomic helpers: we can drop the custom ->best_encoder(),
and let the core call drm_atomic_helper_best_encoder() for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/bridge/parade-ps8622.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bridge/parade-ps8622.c
index be881e9..5cd8dd7 100644
--- a/drivers/gpu/drm/bridge/parade-ps8622.c
+++ b/drivers/gpu/drm/bridge/parade-ps8622.c
@@ -474,18 +474,8 @@ static int ps8622_get_modes(struct drm_connector *connector)
 	return drm_panel_get_modes(ps8622->panel);
 }
 
-static struct drm_encoder *ps8622_best_encoder(struct drm_connector *connector)
-{
-	struct ps8622_bridge *ps8622;
-
-	ps8622 = connector_to_ps8622(connector);
-
-	return ps8622->bridge.encoder;
-}
-
 static const struct drm_connector_helper_funcs ps8622_connector_helper_funcs = {
 	.get_modes = ps8622_get_modes,
-	.best_encoder = ps8622_best_encoder,
 };
 
 static enum drm_connector_status ps8622_detect(struct drm_connector *connector,
-- 
2.7.4
