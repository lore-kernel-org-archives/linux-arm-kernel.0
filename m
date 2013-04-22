From: marex@denx.de (Marek Vasut)
Date: Mon, 22 Apr 2013 23:19:31 +0200
Subject: [PATCH V2] video: imx: Add BGR666 support for parallel display
Message-ID: <1366665571-8897-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support the BGR666 format on the IPUv3 parallel display.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Bill Pemberton <wfp5p@virginia.edu>
---
 .../devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt       |    2 +-
 drivers/staging/imx-drm/ipu-v3/ipu-dc.c                       |    9 +++++++++
 drivers/staging/imx-drm/parallel-display.c                    |    2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

V2: Update documentation

diff --git a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
index f769857..b876d49 100644
--- a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
+++ b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
@@ -29,7 +29,7 @@ Required properties:
 - crtc: the crtc this display is connected to, see below
 Optional properties:
 - interface_pix_fmt: How this display is connected to the
-  crtc. Currently supported types: "rgb24", "rgb565"
+  crtc. Currently supported types: "rgb24", "rgb565", "bgr666"
 - edid: verbatim EDID data block describing attached display.
 - ddc: phandle describing the i2c bus handling the display data
   channel
diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
index 1cb0631..59f03f9 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
@@ -90,6 +90,7 @@ enum ipu_dc_map {
 	IPU_DC_MAP_RGB24,
 	IPU_DC_MAP_RGB565,
 	IPU_DC_MAP_GBR24, /* TVEv2 */
+	IPU_DC_MAP_BGR666,
 };
 
 struct ipu_dc {
@@ -149,6 +150,8 @@ static int ipu_pixfmt_to_map(u32 fmt)
 		return IPU_DC_MAP_RGB565;
 	case IPU_PIX_FMT_GBR24:
 		return IPU_DC_MAP_GBR24;
+	case V4L2_PIX_FMT_BGR666:
+		return IPU_DC_MAP_BGR666;
 	default:
 		return -EINVAL;
 	}
@@ -385,6 +388,12 @@ int ipu_dc_init(struct ipu_soc *ipu, struct device *dev,
 	ipu_dc_map_config(priv, IPU_DC_MAP_GBR24, 1, 7, 0xff); /* blue */
 	ipu_dc_map_config(priv, IPU_DC_MAP_GBR24, 0, 23, 0xff); /* red */
 
+	/* bgr666 */
+	ipu_dc_map_clear(priv, IPU_DC_MAP_BGR666);
+	ipu_dc_map_config(priv, IPU_DC_MAP_BGR666, 0, 5, 0xfc); /* blue */
+	ipu_dc_map_config(priv, IPU_DC_MAP_BGR666, 1, 11, 0xfc); /* green */
+	ipu_dc_map_config(priv, IPU_DC_MAP_BGR666, 2, 17, 0xfc); /* red */
+
 	return 0;
 }
 
diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
index 2a25202..e7fba62 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -230,6 +230,8 @@ static int imx_pd_probe(struct platform_device *pdev)
 			imxpd->interface_pix_fmt = V4L2_PIX_FMT_RGB24;
 		else if (!strcmp(fmt, "rgb565"))
 			imxpd->interface_pix_fmt = V4L2_PIX_FMT_RGB565;
+		else if (!strcmp(fmt, "bgr666"))
+			imxpd->interface_pix_fmt = V4L2_PIX_FMT_BGR666;
 	}
 
 	imxpd->dev = &pdev->dev;
-- 
1.7.10.4
