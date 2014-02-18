From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 18 Feb 2014 20:10:43 +0000
Subject: [PATCH 13/34] imx-drm: provide common connector mode validation
 function
In-Reply-To: <20140218200900.GM21483@n2100.arm.linux.org.uk>
References: <20140218200900.GM21483@n2100.arm.linux.org.uk>
Message-ID: <E1WFr07-0007jD-67@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a common connector mode validation function, which can be used
to limit the available modes according to other components in the
system.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-drm-core.c     | 7 +++++++
 drivers/staging/imx-drm/imx-drm.h          | 3 +++
 drivers/staging/imx-drm/imx-hdmi.c         | 9 +--------
 drivers/staging/imx-drm/imx-ldb.c          | 8 +-------
 drivers/staging/imx-drm/imx-tve.c          | 5 +++++
 drivers/staging/imx-drm/parallel-display.c | 8 +-------
 6 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index c5268847a54e..7f14ed040072 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -211,6 +211,13 @@ static const struct file_operations imx_drm_driver_fops = {
 	.llseek = noop_llseek,
 };
 
+int imx_drm_connector_mode_valid(struct drm_connector *connector,
+	struct drm_display_mode *mode)
+{
+	return MODE_OK;
+}
+EXPORT_SYMBOL(imx_drm_connector_mode_valid);
+
 static struct imx_drm_device *imx_drm_device;
 
 static struct imx_drm_device *__imx_drm_device(void)
diff --git a/drivers/staging/imx-drm/imx-drm.h b/drivers/staging/imx-drm/imx-drm.h
index 5649f180dc44..4eb594ce9cff 100644
--- a/drivers/staging/imx-drm/imx-drm.h
+++ b/drivers/staging/imx-drm/imx-drm.h
@@ -68,4 +68,7 @@ int imx_drm_encoder_get_mux_id(struct drm_encoder *encoder);
 int imx_drm_encoder_add_possible_crtcs(struct imx_drm_encoder *imx_drm_encoder,
 		struct device_node *np);
 
+int imx_drm_connector_mode_valid(struct drm_connector *connector,
+	struct drm_display_mode *mode);
+
 #endif /* _IMX_DRM_H_ */
diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index a90f08d52ee7..4b690459f3bb 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -1406,13 +1406,6 @@ static int imx_hdmi_connector_get_modes(struct drm_connector *connector)
 	return 0;
 }
 
-static int imx_hdmi_connector_mode_valid(struct drm_connector *connector,
-			  struct drm_display_mode *mode)
-{
-
-	return MODE_OK;
-}
-
 static struct drm_encoder *imx_hdmi_connector_best_encoder(struct drm_connector
 							   *connector)
 {
@@ -1501,7 +1494,7 @@ static struct drm_connector_funcs imx_hdmi_connector_funcs = {
 
 static struct drm_connector_helper_funcs imx_hdmi_connector_helper_funcs = {
 	.get_modes = imx_hdmi_connector_get_modes,
-	.mode_valid = imx_hdmi_connector_mode_valid,
+	.mode_valid = imx_drm_connector_mode_valid,
 	.best_encoder = imx_hdmi_connector_best_encoder,
 };
 
diff --git a/drivers/staging/imx-drm/imx-ldb.c b/drivers/staging/imx-drm/imx-ldb.c
index 4aa47ae2a3ca..c6ec1e9e95cc 100644
--- a/drivers/staging/imx-drm/imx-ldb.c
+++ b/drivers/staging/imx-drm/imx-ldb.c
@@ -120,12 +120,6 @@ static int imx_ldb_connector_get_modes(struct drm_connector *connector)
 	return num_modes;
 }
 
-static int imx_ldb_connector_mode_valid(struct drm_connector *connector,
-			  struct drm_display_mode *mode)
-{
-	return 0;
-}
-
 static struct drm_encoder *imx_ldb_connector_best_encoder(
 		struct drm_connector *connector)
 {
@@ -329,7 +323,7 @@ static struct drm_connector_funcs imx_ldb_connector_funcs = {
 static struct drm_connector_helper_funcs imx_ldb_connector_helper_funcs = {
 	.get_modes = imx_ldb_connector_get_modes,
 	.best_encoder = imx_ldb_connector_best_encoder,
-	.mode_valid = imx_ldb_connector_mode_valid,
+	.mode_valid = imx_drm_connector_mode_valid,
 };
 
 static struct drm_encoder_funcs imx_ldb_encoder_funcs = {
diff --git a/drivers/staging/imx-drm/imx-tve.c b/drivers/staging/imx-drm/imx-tve.c
index 9abc7ca8b6cf..2d4e0973a02a 100644
--- a/drivers/staging/imx-drm/imx-tve.c
+++ b/drivers/staging/imx-drm/imx-tve.c
@@ -254,6 +254,11 @@ static int imx_tve_connector_mode_valid(struct drm_connector *connector,
 {
 	struct imx_tve *tve = con_to_tve(connector);
 	unsigned long rate;
+	int ret;
+
+	ret = imx_drm_connector_mode_valid(connector, mode);
+	if (ret != MODE_OK)
+		return ret;
 
 	/* pixel clock with 2x oversampling */
 	rate = clk_round_rate(tve->clk, 2000UL * mode->clock) / 2000;
diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
index 351d61dede00..18a3e8aae22a 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -85,12 +85,6 @@ static int imx_pd_connector_get_modes(struct drm_connector *connector)
 	return num_modes;
 }
 
-static int imx_pd_connector_mode_valid(struct drm_connector *connector,
-			  struct drm_display_mode *mode)
-{
-	return 0;
-}
-
 static struct drm_encoder *imx_pd_connector_best_encoder(
 		struct drm_connector *connector)
 {
@@ -147,7 +141,7 @@ static struct drm_connector_funcs imx_pd_connector_funcs = {
 static struct drm_connector_helper_funcs imx_pd_connector_helper_funcs = {
 	.get_modes = imx_pd_connector_get_modes,
 	.best_encoder = imx_pd_connector_best_encoder,
-	.mode_valid = imx_pd_connector_mode_valid,
+	.mode_valid = imx_drm_connector_mode_valid,
 };
 
 static struct drm_encoder_funcs imx_pd_encoder_funcs = {
-- 
1.8.3.1
