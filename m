From: denis@eukrea.com (Denis Carikli)
Date: Tue, 17 Jun 2014 15:34:51 +0200
Subject: [PATCH] imx-drm: parallel-display: Fix DPMS default state.
Message-ID: <1403012091-32109-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If connector->dpms is left untouched, it defaults
to DRM_MODE_DPMS_ON (0).

As a result, drm_helper_connector_dpms will exit when
it will be asked to set the state to DRM_MODE_DPMS_ON,
because it is already set.

That issue prevented displays from turning on at boot.

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 drivers/staging/imx-drm/parallel-display.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
index b567832..4ca61af 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -173,6 +173,13 @@ static int imx_pd_register(struct drm_device *drm,
 	if (ret)
 		return ret;
 
+	/* set the connector's dpms to OFF so that
+	 * drm_helper_connector_dpms() won't return
+	 * immediately since the current state is ON
+	 * at this point.
+	 */
+	imxpd->connector.dpms = DRM_MODE_DPMS_OFF;
+
 	drm_encoder_helper_add(&imxpd->encoder, &imx_pd_encoder_helper_funcs);
 	drm_encoder_init(drm, &imxpd->encoder, &imx_pd_encoder_funcs,
 			 DRM_MODE_ENCODER_NONE);
-- 
1.7.9.5
