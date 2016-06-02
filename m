From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  2 Jun 2016 16:31:40 +0200
Subject: [PATCH 13/20] drm: tegra: Rely on the default ->best_encoder()
 behavior
In-Reply-To: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1464877907-27723-14-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All outputs have a 1:1 relationship between connectors and encoders
and the driver is relying on the atomic helpers: we can drop the custom
->best_encoder() implementation and let the core call
drm_atomic_helper_best_encoder() for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/tegra/drm.h    | 2 --
 drivers/gpu/drm/tegra/dsi.c    | 1 -
 drivers/gpu/drm/tegra/hdmi.c   | 1 -
 drivers/gpu/drm/tegra/output.c | 8 --------
 drivers/gpu/drm/tegra/rgb.c    | 1 -
 drivers/gpu/drm/tegra/sor.c    | 1 -
 6 files changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
index f52d6cb2..0ddcce1 100644
--- a/drivers/gpu/drm/tegra/drm.h
+++ b/drivers/gpu/drm/tegra/drm.h
@@ -239,8 +239,6 @@ int tegra_output_init(struct drm_device *drm, struct tegra_output *output);
 void tegra_output_exit(struct tegra_output *output);
 
 int tegra_output_connector_get_modes(struct drm_connector *connector);
-struct drm_encoder *
-tegra_output_connector_best_encoder(struct drm_connector *connector);
 enum drm_connector_status
 tegra_output_connector_detect(struct drm_connector *connector, bool force);
 void tegra_output_connector_destroy(struct drm_connector *connector);
diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index d1239eb..099cccb 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -794,7 +794,6 @@ tegra_dsi_connector_mode_valid(struct drm_connector *connector,
 static const struct drm_connector_helper_funcs tegra_dsi_connector_helper_funcs = {
 	.get_modes = tegra_output_connector_get_modes,
 	.mode_valid = tegra_dsi_connector_mode_valid,
-	.best_encoder = tegra_output_connector_best_encoder,
 };
 
 static const struct drm_encoder_funcs tegra_dsi_encoder_funcs = {
diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index b7ef492..2fdb879 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -806,7 +806,6 @@ static const struct drm_connector_helper_funcs
 tegra_hdmi_connector_helper_funcs = {
 	.get_modes = tegra_output_connector_get_modes,
 	.mode_valid = tegra_hdmi_connector_mode_valid,
-	.best_encoder = tegra_output_connector_best_encoder,
 };
 
 static const struct drm_encoder_funcs tegra_hdmi_encoder_funcs = {
diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/output.c
index 46664b6..1480f6a 100644
--- a/drivers/gpu/drm/tegra/output.c
+++ b/drivers/gpu/drm/tegra/output.c
@@ -42,14 +42,6 @@ int tegra_output_connector_get_modes(struct drm_connector *connector)
 	return err;
 }
 
-struct drm_encoder *
-tegra_output_connector_best_encoder(struct drm_connector *connector)
-{
-	struct tegra_output *output = connector_to_output(connector);
-
-	return &output->encoder;
-}
-
 enum drm_connector_status
 tegra_output_connector_detect(struct drm_connector *connector, bool force)
 {
diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
index e246334..a131b44 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -112,7 +112,6 @@ tegra_rgb_connector_mode_valid(struct drm_connector *connector,
 static const struct drm_connector_helper_funcs tegra_rgb_connector_helper_funcs = {
 	.get_modes = tegra_output_connector_get_modes,
 	.mode_valid = tegra_rgb_connector_mode_valid,
-	.best_encoder = tegra_output_connector_best_encoder,
 };
 
 static const struct drm_encoder_funcs tegra_rgb_encoder_funcs = {
diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index 757c6e8..34958d7 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -1087,7 +1087,6 @@ tegra_sor_connector_mode_valid(struct drm_connector *connector,
 static const struct drm_connector_helper_funcs tegra_sor_connector_helper_funcs = {
 	.get_modes = tegra_sor_connector_get_modes,
 	.mode_valid = tegra_sor_connector_mode_valid,
-	.best_encoder = tegra_output_connector_best_encoder,
 };
 
 static const struct drm_encoder_funcs tegra_sor_encoder_funcs = {
-- 
2.7.4
