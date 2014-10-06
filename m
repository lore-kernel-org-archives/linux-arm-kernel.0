From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon,  6 Oct 2014 21:50:40 +0200
Subject: [PATCH 3/3] imx-drm: parallel-display: Fix dpms mode handling
In-Reply-To: <1412625040-15662-1-git-send-email-mpa@pengutronix.de>
References: <1412625040-15662-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1412625040-15662-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have to call drm_panel_prepare() and drm_panel_unprepare() when
switching on or off. This patch also replaces the if statement with an
switch statement to only catch ON and OFF modes.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/staging/imx-drm/parallel-display.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
index 2a8e84122e48..cbee12c4f5ec 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -104,10 +104,18 @@ static void imx_pd_encoder_dpms(struct drm_encoder *encoder, int mode)
 {
 	struct imx_parallel_display *imxpd = enc_to_imxpd(encoder);
 
-	if (mode != DRM_MODE_DPMS_ON)
-		drm_panel_disable(imxpd->panel);
-	else
+	switch (mode) {
+	case DRM_MODE_DPMS_ON:
+		drm_panel_prepare(imxpd->panel);
 		drm_panel_enable(imxpd->panel);
+		break;
+	case DRM_MODE_DPMS_OFF:
+		drm_panel_disable(imxpd->panel);
+		drm_panel_unprepare(imxpd->panel);
+		break;
+	default:
+		break;
+	}
 }
 
 static bool imx_pd_encoder_mode_fixup(struct drm_encoder *encoder,
-- 
2.1.0
