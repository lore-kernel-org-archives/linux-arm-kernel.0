From: kernel@esmil.dk (Emil Renner Berthing)
Date: Sat, 29 Mar 2014 00:05:54 +0100
Subject: [PATCH] staging: imx-drm: add LVDS666 support for parallel display
Message-ID: <1396047954-27175-1-git-send-email-kernel@esmil.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support the LVDS666 format on the IPUv3 parallel display.
This makes the screen work on my Hercules eCAFE Slim HD.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 .../devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt          | 1 +
 drivers/staging/imx-drm/ipu-v3/ipu-dc.c                          | 9 +++++++++
 drivers/staging/imx-drm/parallel-display.c                       | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
index 3be5ce7..e75f0e5 100644
--- a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
+++ b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
@@ -61,6 +61,7 @@ Required properties:
 Optional properties:
 - interface_pix_fmt: How this display is connected to the
   display interface. Currently supported types: "rgb24", "rgb565", "bgr666"
+  and "lvds666".
 - edid: verbatim EDID data block describing attached display.
 - ddc: phandle describing the i2c bus handling the display data
   channel
diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
index 156bbea..9945609 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
@@ -91,6 +91,7 @@ enum ipu_dc_map {
 	IPU_DC_MAP_RGB565,
 	IPU_DC_MAP_GBR24, /* TVEv2 */
 	IPU_DC_MAP_BGR666,
+	IPU_DC_MAP_LVDS666,
 	IPU_DC_MAP_BGR24,
 };
 
@@ -155,6 +156,8 @@ static int ipu_pixfmt_to_map(u32 fmt)
 		return IPU_DC_MAP_GBR24;
 	case V4L2_PIX_FMT_BGR666:
 		return IPU_DC_MAP_BGR666;
+	case v4l2_fourcc('L', 'V', 'D', '6'):
+		return IPU_DC_MAP_LVDS666;
 	case V4L2_PIX_FMT_BGR24:
 		return IPU_DC_MAP_BGR24;
 	default:
@@ -409,6 +412,12 @@ int ipu_dc_init(struct ipu_soc *ipu, struct device *dev,
 	ipu_dc_map_config(priv, IPU_DC_MAP_BGR666, 1, 11, 0xfc); /* green */
 	ipu_dc_map_config(priv, IPU_DC_MAP_BGR666, 2, 17, 0xfc); /* red */
 
+	/* lvds666 */
+	ipu_dc_map_clear(priv, IPU_DC_MAP_LVDS666);
+	ipu_dc_map_config(priv, IPU_DC_MAP_LVDS666, 0, 5, 0xfc); /* blue */
+	ipu_dc_map_config(priv, IPU_DC_MAP_LVDS666, 1, 15, 0xfc); /* green */
+	ipu_dc_map_config(priv, IPU_DC_MAP_LVDS666, 2, 21, 0xfc); /* red */
+
 	/* bgr24 */
 	ipu_dc_map_clear(priv, IPU_DC_MAP_BGR24);
 	ipu_dc_map_config(priv, IPU_DC_MAP_BGR24, 2, 7, 0xff); /* red */
diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
index b25e787..e194f92 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -214,6 +214,8 @@ static int imx_pd_bind(struct device *dev, struct device *master, void *data)
 			imxpd->interface_pix_fmt = V4L2_PIX_FMT_RGB565;
 		else if (!strcmp(fmt, "bgr666"))
 			imxpd->interface_pix_fmt = V4L2_PIX_FMT_BGR666;
+		else if (!strcmp(fmt, "lvds666"))
+			imxpd->interface_pix_fmt = v4l2_fourcc('L', 'V', 'D', '6');
 	}
 
 	panel_node = of_parse_phandle(np, "fsl,panel", 0);
-- 
1.9.1
