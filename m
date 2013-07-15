From: denis@eukrea.com (Denis Carikli)
Date: Mon, 15 Jul 2013 16:57:03 +0200
Subject: [PATCH 18/22] staging: video: imx: Add RGB666 support for parallel
 display
In-Reply-To: <1373900227-341-1-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
Message-ID: <1373900227-341-19-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support the RGB666 format on the IPUv3 parallel display.

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 .../bindings/staging/imx-drm/fsl-imx-drm.txt       |    2 +-
 drivers/staging/imx-drm/ipu-v3/ipu-dc.c            |    9 +++++++++
 drivers/staging/imx-drm/parallel-display.c         |    2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
index b876d49..2d24425 100644
--- a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
+++ b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
@@ -29,7 +29,7 @@ Required properties:
 - crtc: the crtc this display is connected to, see below
 Optional properties:
 - interface_pix_fmt: How this display is connected to the
-  crtc. Currently supported types: "rgb24", "rgb565", "bgr666"
+  crtc. Currently supported types: "rgb24", "rgb565", "bgr666", "rgb666"
 - edid: verbatim EDID data block describing attached display.
 - ddc: phandle describing the i2c bus handling the display data
   channel
diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
index 59f03f9..41049b9 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
@@ -91,6 +91,7 @@ enum ipu_dc_map {
 	IPU_DC_MAP_RGB565,
 	IPU_DC_MAP_GBR24, /* TVEv2 */
 	IPU_DC_MAP_BGR666,
+	IPU_DC_MAP_RGB666,
 };
 
 struct ipu_dc {
@@ -152,6 +153,8 @@ static int ipu_pixfmt_to_map(u32 fmt)
 		return IPU_DC_MAP_GBR24;
 	case V4L2_PIX_FMT_BGR666:
 		return IPU_DC_MAP_BGR666;
+	case V4L2_PIX_FMT_RGB666:
+		return IPU_DC_MAP_RGB666;
 	default:
 		return -EINVAL;
 	}
@@ -394,6 +397,12 @@ int ipu_dc_init(struct ipu_soc *ipu, struct device *dev,
 	ipu_dc_map_config(priv, IPU_DC_MAP_BGR666, 1, 11, 0xfc); /* green */
 	ipu_dc_map_config(priv, IPU_DC_MAP_BGR666, 2, 17, 0xfc); /* red */
 
+	/* rgb666 */
+	ipu_dc_map_clear(priv, IPU_DC_MAP_BGR666);
+	ipu_dc_map_config(priv, IPU_DC_MAP_RGB666, 2, 17, 0xfc); /* red */
+	ipu_dc_map_config(priv, IPU_DC_MAP_RGB666, 1, 11, 0xfc); /* green */
+	ipu_dc_map_config(priv, IPU_DC_MAP_RGB666, 0, 5, 0xfc); /* blue */
+
 	return 0;
 }
 
diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
index fee9b10..dd65236 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -236,6 +236,8 @@ static int imx_pd_probe(struct platform_device *pdev)
 			imxpd->interface_pix_fmt = V4L2_PIX_FMT_RGB565;
 		else if (!strcmp(fmt, "bgr666"))
 			imxpd->interface_pix_fmt = V4L2_PIX_FMT_BGR666;
+		else if (!strcmp(fmt, "rgb666"))
+			imxpd->interface_pix_fmt = V4L2_PIX_FMT_RGB666;
 	}
 
 	imxpd->dev = &pdev->dev;
-- 
1.7.9.5
