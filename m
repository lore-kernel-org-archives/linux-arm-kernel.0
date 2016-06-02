From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  2 Jun 2016 16:31:35 +0200
Subject: [PATCH 08/20] drm: msm: Rely on the default ->best_encoder() behavior
 where appropriate
In-Reply-To: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1464877907-27723-9-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For all outputs except DSI we have a 1:1 relationship between connectors
and encoders and the driver is relying on the atomic helpers: we can
drop the custom ->best_encoder() and let the core call
drm_atomic_helper_best_encoder() for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/msm/edp/edp_connector.c            | 10 ----------
 drivers/gpu/drm/msm/hdmi/hdmi_connector.c          |  8 --------
 drivers/gpu/drm/msm/mdp/mdp4/mdp4_lvds_connector.c |  9 ---------
 3 files changed, 27 deletions(-)

diff --git a/drivers/gpu/drm/msm/edp/edp_connector.c b/drivers/gpu/drm/msm/edp/edp_connector.c
index 72360cd..5960628 100644
--- a/drivers/gpu/drm/msm/edp/edp_connector.c
+++ b/drivers/gpu/drm/msm/edp/edp_connector.c
@@ -91,15 +91,6 @@ static int edp_connector_mode_valid(struct drm_connector *connector,
 	return MODE_OK;
 }
 
-static struct drm_encoder *
-edp_connector_best_encoder(struct drm_connector *connector)
-{
-	struct edp_connector *edp_connector = to_edp_connector(connector);
-
-	DBG("");
-	return edp_connector->edp->encoder;
-}
-
 static const struct drm_connector_funcs edp_connector_funcs = {
 	.dpms = drm_atomic_helper_connector_dpms,
 	.detect = edp_connector_detect,
@@ -113,7 +104,6 @@ static const struct drm_connector_funcs edp_connector_funcs = {
 static const struct drm_connector_helper_funcs edp_connector_helper_funcs = {
 	.get_modes = edp_connector_get_modes,
 	.mode_valid = edp_connector_mode_valid,
-	.best_encoder = edp_connector_best_encoder,
 };
 
 /* initialize connector */
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_connector.c b/drivers/gpu/drm/msm/hdmi/hdmi_connector.c
index b15d726..a2515b4 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_connector.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_connector.c
@@ -406,13 +406,6 @@ static int msm_hdmi_connector_mode_valid(struct drm_connector *connector,
 	return 0;
 }
 
-static struct drm_encoder *
-msm_hdmi_connector_best_encoder(struct drm_connector *connector)
-{
-	struct hdmi_connector *hdmi_connector = to_hdmi_connector(connector);
-	return hdmi_connector->hdmi->encoder;
-}
-
 static const struct drm_connector_funcs hdmi_connector_funcs = {
 	.dpms = drm_atomic_helper_connector_dpms,
 	.detect = hdmi_connector_detect,
@@ -426,7 +419,6 @@ static const struct drm_connector_funcs hdmi_connector_funcs = {
 static const struct drm_connector_helper_funcs msm_hdmi_connector_helper_funcs = {
 	.get_modes = msm_hdmi_connector_get_modes,
 	.mode_valid = msm_hdmi_connector_mode_valid,
-	.best_encoder = msm_hdmi_connector_best_encoder,
 };
 
 /* initialize connector */
diff --git a/drivers/gpu/drm/msm/mdp/mdp4/mdp4_lvds_connector.c b/drivers/gpu/drm/msm/mdp/mdp4/mdp4_lvds_connector.c
index 2648cd7..353429b 100644
--- a/drivers/gpu/drm/msm/mdp/mdp4/mdp4_lvds_connector.c
+++ b/drivers/gpu/drm/msm/mdp/mdp4/mdp4_lvds_connector.c
@@ -90,14 +90,6 @@ static int mdp4_lvds_connector_mode_valid(struct drm_connector *connector,
 	return MODE_OK;
 }
 
-static struct drm_encoder *
-mdp4_lvds_connector_best_encoder(struct drm_connector *connector)
-{
-	struct mdp4_lvds_connector *mdp4_lvds_connector =
-			to_mdp4_lvds_connector(connector);
-	return mdp4_lvds_connector->encoder;
-}
-
 static const struct drm_connector_funcs mdp4_lvds_connector_funcs = {
 	.dpms = drm_atomic_helper_connector_dpms,
 	.detect = mdp4_lvds_connector_detect,
@@ -111,7 +103,6 @@ static const struct drm_connector_funcs mdp4_lvds_connector_funcs = {
 static const struct drm_connector_helper_funcs mdp4_lvds_connector_helper_funcs = {
 	.get_modes = mdp4_lvds_connector_get_modes,
 	.mode_valid = mdp4_lvds_connector_mode_valid,
-	.best_encoder = mdp4_lvds_connector_best_encoder,
 };
 
 /* initialize connector */
-- 
2.7.4
