From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon,  3 Nov 2014 15:54:47 +0100
Subject: [PATCH v2 2/3] imx-drm: parallel-display: Fix drm_panel support
In-Reply-To: <1415026488-25309-1-git-send-email-mpa@pengutronix.de>
References: <1415026488-25309-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1415026488-25309-3-git-send-email-mpa@pengutronix.de>
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
index b2719c4a0561..0992bbf01adc 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -128,6 +128,10 @@ static void imx_pd_encoder_prepare(struct drm_encoder *encoder)
 
 static void imx_pd_encoder_commit(struct drm_encoder *encoder)
 {
+	struct imx_parallel_display *imxpd = enc_to_imxpd(encoder);
+
+	drm_panel_prepare(imxpd->panel);
+	drm_panel_enable(imxpd->panel);
 }
 
 static void imx_pd_encoder_mode_set(struct drm_encoder *encoder,
@@ -138,6 +142,10 @@ static void imx_pd_encoder_mode_set(struct drm_encoder *encoder,
 
 static void imx_pd_encoder_disable(struct drm_encoder *encoder)
 {
+	struct imx_parallel_display *imxpd = enc_to_imxpd(encoder);
+
+	drm_panel_disable(imxpd->panel);
+	drm_panel_unprepare(imxpd->panel);
 }
 
 static struct drm_connector_funcs imx_pd_connector_funcs = {
-- 
2.1.1
