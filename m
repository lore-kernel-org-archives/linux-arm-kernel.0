From: rogerio.pimentel@freescale.com (Rogerio Pimentel)
Date: Wed, 3 Apr 2013 12:36:28 -0300
Subject: [PATCH 1/3] video: Make IPU KMS parse display-timings
Message-ID: <1365003390-26964-1-git-send-email-rogerio.pimentel@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Vasut <marex@denx.de>

This patch adds support for parsing of the DT display-timings prop
to IPU KMS driver.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Marek Vasut <marex@denx.de>
---
 drivers/staging/imx-drm/parallel-display.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
index a8064fc..2a25202 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -57,6 +57,7 @@ static void imx_pd_connector_destroy(struct drm_connector *connector)
 static int imx_pd_connector_get_modes(struct drm_connector *connector)
 {
 	struct imx_parallel_display *imxpd = con_to_imxpd(connector);
+	struct device_node *np = imxpd->dev->of_node;
 	int num_modes = 0;
 
 	if (imxpd->edid) {
@@ -72,6 +73,15 @@ static int imx_pd_connector_get_modes(struct drm_connector *connector)
 		num_modes++;
 	}
 
+	if (np) {
+		struct drm_display_mode *mode = drm_mode_create(connector->dev);
+		of_get_drm_display_mode(np, &imxpd->mode, 0);
+		drm_mode_copy(mode, &imxpd->mode);
+		mode->type |= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+		drm_mode_probed_add(connector, mode);
+		num_modes++;
+	}
+
 	return num_modes;
 }
 
-- 
1.7.10.4
