From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon,  6 Oct 2014 21:50:39 +0200
Subject: [PATCH 2/3] imx-drm: parallel-display: Fix drm_panel support
In-Reply-To: <1412625040-15662-1-git-send-email-mpa@pengutronix.de>
References: <1412625040-15662-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1412625040-15662-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <philipp.zabel@gmail.com>

Call drm_panel_enable/disable in reaction to encoder_commit
and encoder_disable callbacks.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/staging/imx-drm/parallel-display.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
index df0c3e759616..2a8e84122e48 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -126,6 +126,10 @@ static void imx_pd_encoder_prepare(struct drm_encoder *encoder)
 
 static void imx_pd_encoder_commit(struct drm_encoder *encoder)
 {
+	struct imx_parallel_display *imxpd = enc_to_imxpd(encoder);
+
+	drm_panel_prepare(imxpd->panel);
+	drm_panel_enable(imxpd->panel);
 }
 
 static void imx_pd_encoder_mode_set(struct drm_encoder *encoder,
@@ -136,6 +140,10 @@ static void imx_pd_encoder_mode_set(struct drm_encoder *encoder,
 
 static void imx_pd_encoder_disable(struct drm_encoder *encoder)
 {
+	struct imx_parallel_display *imxpd = enc_to_imxpd(encoder);
+
+	drm_panel_disable(imxpd->panel);
+	drm_panel_unprepare(imxpd->panel);
 }
 
 static struct drm_connector_funcs imx_pd_connector_funcs = {
-- 
2.1.0
