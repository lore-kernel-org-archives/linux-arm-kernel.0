From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:27:48 +0000
Subject: [PATCH RFC 24/46] imx-drm: provide common connector mode validation
 function
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1Vypnw-0007F7-EB@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a common connector mode validation function, which can be used
to limit the available modes according to other components in the
system.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-drm-core.c     |    7 +++++++
 drivers/staging/imx-drm/imx-drm.h          |    3 +++
 drivers/staging/imx-drm/imx-hdmi.c         |    9 +--------
 drivers/staging/imx-drm/imx-ldb.c          |    8 +-------
 drivers/staging/imx-drm/imx-tve.c          |    5 +++++
 drivers/staging/imx-drm/parallel-display.c |    8 +-------
 6 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 8aef203a017b..d7cb0af9479a 100644
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
index c8152043143f..8421c715ce14 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -1410,13 +1410,6 @@ static int imx_hdmi_connector_get_modes(struct drm_connector *connector)
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
@@ -1505,7 +1498,7 @@ static struct drm_connector_funcs imx_hdmi_connector_funcs = {
 
 static struct drm_connector_helper_funcs imx_hdmi_connector_helper_funcs = {
 	.get_modes = imx_hdmi_connector_get_modes,
-	.mode_valid = imx_hdmi_connector_mode_valid,
+	.mode_valid = imx_drm_connector_mode_valid,
 	.best_encoder = imx_hdmi_connector_best_encoder,
 };
 
diff --git a/drivers/staging/imx-drm/imx-ldb.c b/drivers/staging/imx-drm/imx-ldb.c
index bbcbd52f0169..81a23685b42d 100644
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
@@ -330,7 +324,7 @@ static struct drm_connector_funcs imx_ldb_connector_funcs = {
 static struct drm_connector_helper_funcs imx_ldb_connector_helper_funcs = {
 	.get_modes = imx_ldb_connector_get_modes,
 	.best_encoder = imx_ldb_connector_best_encoder,
-	.mode_valid = imx_ldb_connector_mode_valid,
+	.mode_valid = imx_drm_connector_mode_valid,
 };
 
 static struct drm_encoder_funcs imx_ldb_encoder_funcs = {
diff --git a/drivers/staging/imx-drm/imx-tve.c b/drivers/staging/imx-drm/imx-tve.c
index 2c44fef8d58b..f315c5250fe8 100644
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
index 24aa9beedcfb..789950b87b29 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -84,12 +84,6 @@ static int imx_pd_connector_get_modes(struct drm_connector *connector)
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
@@ -146,7 +140,7 @@ static struct drm_connector_funcs imx_pd_connector_funcs = {
 static struct drm_connector_helper_funcs imx_pd_connector_helper_funcs = {
 	.get_modes = imx_pd_connector_get_modes,
 	.best_encoder = imx_pd_connector_best_encoder,
-	.mode_valid = imx_pd_connector_mode_valid,
+	.mode_valid = imx_drm_connector_mode_valid,
 };
 
 static struct drm_encoder_funcs imx_pd_encoder_funcs = {
-- 
1.7.4.4
