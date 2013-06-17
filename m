From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon, 17 Jun 2013 11:02:52 +0200
Subject: [PATCH v2] staging: imx_drm: imx_ldb: fix 18 bit format
Message-ID: <1371459772-16443-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Niebel <Markus.Niebel@tqs.de>

Since 18 bit is supported as datawidth in device tree it should be
supported in driver. Beside the LDB channel the IPU channel has also
to be configured to use BGR666.

Signed-off-by: Markus Niebel <Markus.Niebel@tqs.de>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
This is based on the series: "staging: drm/imx: Add LDB support" by Philipp.

Changes since v1:
	- fixed function call: imx_drm_crtc_panel_format_pins -> imx_drm_crtc_panel_format

 drivers/staging/imx-drm/imx-ldb.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/imx-drm/imx-ldb.c b/drivers/staging/imx-drm/imx-ldb.c
index 0a7e4da..92a0e21 100644
--- a/drivers/staging/imx-drm/imx-ldb.c
+++ b/drivers/staging/imx-drm/imx-ldb.c
@@ -179,6 +179,7 @@ static void imx_ldb_encoder_prepare(struct drm_encoder *encoder)
 	struct imx_ldb_channel *imx_ldb_ch = enc_to_imx_ldb_ch(encoder);
 	struct imx_ldb *ldb = imx_ldb_ch->ldb;
 	struct drm_display_mode *mode = &encoder->crtc->mode;
+	u32 pixel_fmt;
 	unsigned long serial_clk;
 	unsigned long di_clk = mode->clock * 1000;
 	int mux = imx_drm_encoder_get_mux_id(imx_ldb_ch->imx_drm_encoder,
@@ -194,8 +195,23 @@ static void imx_ldb_encoder_prepare(struct drm_encoder *encoder)
 		imx_ldb_set_clock(ldb, mux, imx_ldb_ch->chno, serial_clk, di_clk);
 	}
 
+	switch (imx_ldb_ch->chno) {
+	case 0:
+		pixel_fmt = (ldb->ldb_ctrl & LDB_DATA_WIDTH_CH0_24) ?
+			V4L2_PIX_FMT_RGB24 : V4L2_PIX_FMT_BGR666;
+		break;
+	case 1:
+		pixel_fmt = (ldb->ldb_ctrl & LDB_DATA_WIDTH_CH1_24) ?
+			V4L2_PIX_FMT_RGB24 : V4L2_PIX_FMT_BGR666;
+		break;
+	default:
+		dev_err(ldb->dev, "unable to config di%d panel format\n",
+			imx_ldb_ch->chno);
+		pixel_fmt = V4L2_PIX_FMT_RGB24;
+	}
+
 	imx_drm_crtc_panel_format(encoder->crtc, DRM_MODE_ENCODER_LVDS,
-			V4L2_PIX_FMT_RGB24);
+			pixel_fmt);
 }
 
 static void imx_ldb_encoder_commit(struct drm_encoder *encoder)
-- 
1.8.3.1
