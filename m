From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 06 Apr 2017 15:55:29 +0200
Subject: [PATCH] [media] imx: csi: retain current field order and
 colorimetry setting as default
In-Reply-To: <1490661656-10318-22-git-send-email-steve_longerbeam@mentor.com>
References: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
 <1490661656-10318-22-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1491486929.2392.29.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the the field order is set to ANY in set_fmt, choose the currently
set field order. If the colorspace is set to DEFAULT, choose the current
colorspace.  If any of xfer_func, ycbcr_enc or quantization are set to
DEFAULT, either choose the current setting, or the default setting for the
new colorspace, if non-DEFAULT colorspace was given.

This allows to let field order and colorimetry settings be propagated
from upstream by calling media-ctl on the upstream entity source pad,
and then call media-ctl on the sink pad to manually set the input frame
interval, without changing the already set field order and colorimetry
information.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
This is based on imx-media-staging-md-v14, and it is supposed to allow
configuring the pipeline with media-ctl like this:

1) media-ctl --set-v4l2 "'tc358743 1-000f':0[fmt:UYVY8_1X16/1920x1080]"
2) media-ctl --set-v4l2 "'imx6-mipi-csi2':1[fmt:UYVY8_1X16/1920x108]"
3) media-ctl --set-v4l2 "'ipu1_csi0_mux':2[fmt:UYVY8_1X16/1920x1080]"
4) media-ctl --set-v4l2 "'ipu1_csi0':0[fmt:UYVY8_1X16/1920x1080 at 1/60]"
5) media-ctl --set-v4l2 "'ipu1_csi0':2[fmt:AYUV32/1920x1080 at 1/30]"

Without having step 4) overwrite the colorspace and field order set on
'ipu1_csi0':0 by the propagation in step 3).
---
 drivers/staging/media/imx/imx-media-csi.c | 34 +++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 64dc454f6b371..d94ce1de2bf05 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1325,6 +1325,40 @@ static int csi_set_fmt(struct v4l2_subdev *sd,
 	csi_try_fmt(priv, sensor, cfg, sdformat, crop, compose, &cc);
 
 	fmt = __csi_get_fmt(priv, cfg, sdformat->pad, sdformat->which);
+
+	/* Retain current field setting as default */
+	if (sdformat->format.field == V4L2_FIELD_ANY)
+		sdformat->format.field = fmt->field;
+
+	/* Retain current colorspace setting as default */
+	if (sdformat->format.colorspace == V4L2_COLORSPACE_DEFAULT) {
+		sdformat->format.colorspace = fmt->colorspace;
+		if (sdformat->format.xfer_func == V4L2_XFER_FUNC_DEFAULT)
+			sdformat->format.xfer_func = fmt->xfer_func;
+		if (sdformat->format.ycbcr_enc == V4L2_YCBCR_ENC_DEFAULT)
+			sdformat->format.ycbcr_enc = fmt->ycbcr_enc;
+		if (sdformat->format.quantization == V4L2_QUANTIZATION_DEFAULT)
+			sdformat->format.quantization = fmt->quantization;
+	} else {
+		if (sdformat->format.xfer_func == V4L2_XFER_FUNC_DEFAULT) {
+			sdformat->format.xfer_func =
+				V4L2_MAP_XFER_FUNC_DEFAULT(
+						sdformat->format.colorspace);
+		}
+		if (sdformat->format.ycbcr_enc == V4L2_YCBCR_ENC_DEFAULT) {
+			sdformat->format.ycbcr_enc =
+				V4L2_MAP_YCBCR_ENC_DEFAULT(
+						sdformat->format.colorspace);
+		}
+		if (sdformat->format.quantization == V4L2_QUANTIZATION_DEFAULT) {
+			sdformat->format.quantization =
+				V4L2_MAP_QUANTIZATION_DEFAULT(
+						cc->cs != IPUV3_COLORSPACE_YUV,
+						sdformat->format.colorspace,
+						sdformat->format.ycbcr_enc);
+		}
+	}
+
 	*fmt = sdformat->format;
 
 	if (sdformat->pad == CSI_SINK_PAD) {
-- 
2.11.0
