From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  2 Jun 2016 16:31:41 +0200
Subject: [PATCH 14/20] drm: vc4: Rely on the default ->best_encoder() behavior
In-Reply-To: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1464877907-27723-15-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All outputs have a 1:1 relationship between connectors and encoders and
the driver is relying on the atomic helpers: we can drop the custom
->best_encoder() implementations and let the core call
drm_atomic_helper_best_encoder() for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/vc4/vc4_dpi.c  | 9 ---------
 drivers/gpu/drm/vc4/vc4_hdmi.c | 9 ---------
 2 files changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dpi.c b/drivers/gpu/drm/vc4/vc4_dpi.c
index 9817dbf..dba1114 100644
--- a/drivers/gpu/drm/vc4/vc4_dpi.c
+++ b/drivers/gpu/drm/vc4/vc4_dpi.c
@@ -208,14 +208,6 @@ static int vc4_dpi_connector_get_modes(struct drm_connector *connector)
 	return 0;
 }
 
-static struct drm_encoder *
-vc4_dpi_connector_best_encoder(struct drm_connector *connector)
-{
-	struct vc4_dpi_connector *dpi_connector =
-		to_vc4_dpi_connector(connector);
-	return dpi_connector->encoder;
-}
-
 static const struct drm_connector_funcs vc4_dpi_connector_funcs = {
 	.dpms = drm_atomic_helper_connector_dpms,
 	.detect = vc4_dpi_connector_detect,
@@ -228,7 +220,6 @@ static const struct drm_connector_funcs vc4_dpi_connector_funcs = {
 
 static const struct drm_connector_helper_funcs vc4_dpi_connector_helper_funcs = {
 	.get_modes = vc4_dpi_connector_get_modes,
-	.best_encoder = vc4_dpi_connector_best_encoder,
 };
 
 static struct drm_connector *vc4_dpi_connector_init(struct drm_device *dev,
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index fd2644d..68df91c 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -208,14 +208,6 @@ static int vc4_hdmi_connector_get_modes(struct drm_connector *connector)
 	return ret;
 }
 
-static struct drm_encoder *
-vc4_hdmi_connector_best_encoder(struct drm_connector *connector)
-{
-	struct vc4_hdmi_connector *hdmi_connector =
-		to_vc4_hdmi_connector(connector);
-	return hdmi_connector->encoder;
-}
-
 static const struct drm_connector_funcs vc4_hdmi_connector_funcs = {
 	.dpms = drm_atomic_helper_connector_dpms,
 	.detect = vc4_hdmi_connector_detect,
@@ -228,7 +220,6 @@ static const struct drm_connector_funcs vc4_hdmi_connector_funcs = {
 
 static const struct drm_connector_helper_funcs vc4_hdmi_connector_helper_funcs = {
 	.get_modes = vc4_hdmi_connector_get_modes,
-	.best_encoder = vc4_hdmi_connector_best_encoder,
 };
 
 static struct drm_connector *vc4_hdmi_connector_init(struct drm_device *dev,
-- 
2.7.4
