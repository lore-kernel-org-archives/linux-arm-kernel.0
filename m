From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 31 Jul 2018 10:26:39 +0100
Subject: [PATCH 1/4] drm/i2c: tda998x: move mode_valid() to bridge
In-Reply-To: <20180731092343.GH17271@n2100.armlinux.org.uk>
References: <20180731092343.GH17271@n2100.armlinux.org.uk>
Message-ID: <E1fkQvP-0003n8-L9@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the mode_valid() implementation to the bridge instead of the
connector, as we're checking the bridge's capabilities.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 8ca5c9786bdf..58831b6a4722 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1244,21 +1244,6 @@ static int tda998x_connector_get_modes(struct drm_connector *connector)
 	return n;
 }
 
-static int tda998x_connector_mode_valid(struct drm_connector *connector,
-					struct drm_display_mode *mode)
-{
-	/* TDA19988 dotclock can go up to 165MHz */
-	struct tda998x_priv *priv = conn_to_tda998x_priv(connector);
-
-	if (mode->clock > ((priv->rev == TDA19988) ? 165000 : 150000))
-		return MODE_CLOCK_HIGH;
-	if (mode->htotal >= BIT(13))
-		return MODE_BAD_HVALUE;
-	if (mode->vtotal >= BIT(11))
-		return MODE_BAD_VVALUE;
-	return MODE_OK;
-}
-
 static struct drm_encoder *
 tda998x_connector_best_encoder(struct drm_connector *connector)
 {
@@ -1270,7 +1255,6 @@ tda998x_connector_best_encoder(struct drm_connector *connector)
 static
 const struct drm_connector_helper_funcs tda998x_connector_helper_funcs = {
 	.get_modes = tda998x_connector_get_modes,
-	.mode_valid = tda998x_connector_mode_valid,
 	.best_encoder = tda998x_connector_best_encoder,
 };
 
@@ -1316,6 +1300,21 @@ static void tda998x_bridge_detach(struct drm_bridge *bridge)
 	drm_connector_cleanup(&priv->connector);
 }
 
+static int tda998x_bridge_mode_valid(struct drm_bridge *bridge,
+				     const struct drm_display_mode *mode)
+{
+	/* TDA19988 dotclock can go up to 165MHz */
+	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
+
+	if (mode->clock > ((priv->rev == TDA19988) ? 165000 : 150000))
+		return MODE_CLOCK_HIGH;
+	if (mode->htotal >= BIT(13))
+		return MODE_BAD_HVALUE;
+	if (mode->vtotal >= BIT(11))
+		return MODE_BAD_VVALUE;
+	return MODE_OK;
+}
+
 static void tda998x_bridge_enable(struct drm_bridge *bridge)
 {
 	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
@@ -1562,6 +1561,7 @@ static void tda998x_bridge_mode_set(struct drm_bridge *bridge,
 static const struct drm_bridge_funcs tda998x_bridge_funcs = {
 	.attach = tda998x_bridge_attach,
 	.detach = tda998x_bridge_detach,
+	.mode_valid = tda998x_bridge_mode_valid,
 	.disable = tda998x_bridge_disable,
 	.mode_set = tda998x_bridge_mode_set,
 	.enable = tda998x_bridge_enable,
-- 
2.7.4
