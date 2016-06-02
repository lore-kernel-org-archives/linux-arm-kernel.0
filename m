From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  2 Jun 2016 16:31:47 +0200
Subject: [PATCH 20/20] drm/bridge: dw-hdmi: Use
 drm_atomic_helper_best_encoder()
In-Reply-To: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1464877907-27723-21-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a 1:1 relationship between connectors and encoders, which means
we can rely on the drm_atomic_helper_best_encoder() behavior.

We still have to explicitly assign ->best_encoder() to
drm_atomic_helper_best_encoder(), because the automated fallback to
drm_atomic_helper_best_encoder() when ->best_encoder() is NULL is only
available when the DRM device is using the atomic helpers, and this bridge
is compatible with non-atomic and atomic devices.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/bridge/dw-hdmi.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw-hdmi.c b/drivers/gpu/drm/bridge/dw-hdmi.c
index c9d9412..70b1f7d 100644
--- a/drivers/gpu/drm/bridge/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/dw-hdmi.c
@@ -1476,15 +1476,6 @@ dw_hdmi_connector_mode_valid(struct drm_connector *connector,
 	return mode_status;
 }
 
-static struct drm_encoder *dw_hdmi_connector_best_encoder(struct drm_connector
-							   *connector)
-{
-	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
-					     connector);
-
-	return hdmi->encoder;
-}
-
 static void dw_hdmi_connector_destroy(struct drm_connector *connector)
 {
 	drm_connector_unregister(connector);
@@ -1525,7 +1516,7 @@ static const struct drm_connector_funcs dw_hdmi_atomic_connector_funcs = {
 static const struct drm_connector_helper_funcs dw_hdmi_connector_helper_funcs = {
 	.get_modes = dw_hdmi_connector_get_modes,
 	.mode_valid = dw_hdmi_connector_mode_valid,
-	.best_encoder = dw_hdmi_connector_best_encoder,
+	.best_encoder = drm_atomic_helper_best_encoder,
 };
 
 static const struct drm_bridge_funcs dw_hdmi_bridge_funcs = {
-- 
2.7.4
