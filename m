From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Wed,  7 Jun 2017 11:34:06 -0700
Subject: [PATCH v8 27/34] media: imx: csi: increase burst size for YUV formats
In-Reply-To: <1496860453-6282-1-git-send-email-steve_longerbeam@mentor.com>
References: <1496860453-6282-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1496860453-6282-28-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

The IDMAC supports burst sizes of up to 32 pixels for interleaved YUV
formats and up to 64 pixels for planar YUV formats.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/media/imx/imx-media-csi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 83c8697..b9220cc 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -332,6 +332,23 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
 		passthrough = true;
 		passthrough_bits = 16;
 		break;
+	case V4L2_PIX_FMT_YUV420:
+	case V4L2_PIX_FMT_NV12:
+		burst_size = (image.pix.width & 0x3f) ?
+			     ((image.pix.width & 0x1f) ?
+			      ((image.pix.width & 0xf) ? 8 : 16) : 32) : 64;
+		passthrough = (sensor_ep->bus_type != V4L2_MBUS_CSI2 &&
+			       sensor_ep->bus.parallel.bus_width >= 16);
+		passthrough_bits = 16;
+		break;
+	case V4L2_PIX_FMT_YUYV:
+	case V4L2_PIX_FMT_UYVY:
+		burst_size = (image.pix.width & 0x1f) ?
+			     ((image.pix.width & 0xf) ? 8 : 16) : 32;
+		passthrough = (sensor_ep->bus_type != V4L2_MBUS_CSI2 &&
+			       sensor_ep->bus.parallel.bus_width >= 16);
+		passthrough_bits = 16;
+		break;
 	default:
 		burst_size = (image.pix.width & 0xf) ? 8 : 16;
 		passthrough = (sensor_ep->bus_type != V4L2_MBUS_CSI2 &&
-- 
2.7.4
