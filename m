From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  2 Jun 2016 16:31:44 +0200
Subject: [PATCH 17/20] drm/bridge: anx78xx: Rely on the default
 ->best_encoder() behavior
In-Reply-To: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1464877907-27723-18-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a 1:1 relationship between connectors and encoders, and the driver
is relying on the atomic helpers: we can drop the custom ->best_encoder(),
and let the core call drm_atomic_helper_best_encoder() for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/bridge/analogix-anx78xx.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix-anx78xx.c
index d087b05..f9f03bc 100644
--- a/drivers/gpu/drm/bridge/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix-anx78xx.c
@@ -986,16 +986,8 @@ unlock:
 	return num_modes;
 }
 
-static struct drm_encoder *anx78xx_best_encoder(struct drm_connector *connector)
-{
-	struct anx78xx *anx78xx = connector_to_anx78xx(connector);
-
-	return anx78xx->bridge.encoder;
-}
-
 static const struct drm_connector_helper_funcs anx78xx_connector_helper_funcs = {
 	.get_modes = anx78xx_get_modes,
-	.best_encoder = anx78xx_best_encoder,
 };
 
 static enum drm_connector_status anx78xx_detect(struct drm_connector *connector,
-- 
2.7.4
