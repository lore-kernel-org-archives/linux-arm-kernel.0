From: denis@eukrea.com (Denis Carikli)
Date: Wed, 12 Mar 2014 17:30:59 +0100
Subject: [PATCH v10][ 02/10] imx-drm: Add RGB666 support for parallel display.
In-Reply-To: <1394641867-15629-1-git-send-email-denis@eukrea.com>
References: <1394641867-15629-1-git-send-email-denis@eukrea.com>
Message-ID: <1394641867-15629-2-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
---
ChangeLog v8->v9:
- Rebased.
- Added Philipp Zabel's ack.
- Shortened the patch title.

ChangeLog v8->v9:
- Removed the Cc. They are now set in git-send-email directly.
- Rebased.

ChangeLog v7->v8:
- Shrinked even more the Cc list.

ChangeLog v6->v7:
- Shrinked even more the Cc list.

ChangeLog v5->v6:
- Remove people not concerned by this patch from the Cc list.

ChangeLog v3->v5:
- Use the correct RGB order.

ChangeLog v2->v3:
- Added some interested people in the Cc list.
- Removed the commit message long desciption that was just a copy of the short
  description.
- Rebased the patch.
- Fixed a copy-paste error in the ipu_dc_map_clear parameter.
---
 .../bindings/staging/imx-drm/fsl-imx-drm.txt       |    3 ++-
 drivers/staging/imx-drm/ipu-v3/ipu-dc.c            |    9 +++++++++
 drivers/staging/imx-drm/parallel-display.c         |    2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
index 3be5ce7..83137ef 100644
--- a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
+++ b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
@@ -60,7 +60,8 @@ Required properties:
 - compatible: Should be "fsl,imx-parallel-display"
 Optional properties:
 - interface_pix_fmt: How this display is connected to the
-  display interface. Currently supported types: "rgb24", "rgb565", "bgr666"
+  display interface. Currently supported types: "rgb24", "rgb565", "bgr666",
+  "rgb666"
 - edid: verbatim EDID data block describing attached display.
 - ddc: phandle describing the i2c bus handling the display data
   channel
diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
index d5de8bb..6f9abe8 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
@@ -92,6 +92,7 @@ enum ipu_dc_map {
 	IPU_DC_MAP_GBR24, /* TVEv2 */
 	IPU_DC_MAP_BGR666,
 	IPU_DC_MAP_BGR24,
+	IPU_DC_MAP_RGB666,
 };
 
 struct ipu_dc {
@@ -155,6 +156,8 @@ static int ipu_pixfmt_to_map(u32 fmt)
 		return IPU_DC_MAP_BGR666;
 	case V4L2_PIX_FMT_BGR24:
 		return IPU_DC_MAP_BGR24;
+	case V4L2_PIX_FMT_RGB666:
+		return IPU_DC_MAP_RGB666;
 	default:
 		return -EINVAL;
 	}
@@ -404,6 +407,12 @@ int ipu_dc_init(struct ipu_soc *ipu, struct device *dev,
 	ipu_dc_map_config(priv, IPU_DC_MAP_BGR24, 1, 15, 0xff); /* green */
 	ipu_dc_map_config(priv, IPU_DC_MAP_BGR24, 0, 23, 0xff); /* blue */
 
+	/* rgb666 */
+	ipu_dc_map_clear(priv, IPU_DC_MAP_RGB666);
+	ipu_dc_map_config(priv, IPU_DC_MAP_RGB666, 0, 5, 0xfc); /* blue */
+	ipu_dc_map_config(priv, IPU_DC_MAP_RGB666, 1, 11, 0xfc); /* green */
+	ipu_dc_map_config(priv, IPU_DC_MAP_RGB666, 2, 17, 0xfc); /* red */
+
 	return 0;
 }
 
diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
index c60b6c6..01b7ce5 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -219,6 +219,8 @@ static int imx_pd_bind(struct device *dev, struct device *master, void *data)
 			imxpd->interface_pix_fmt = V4L2_PIX_FMT_RGB565;
 		else if (!strcmp(fmt, "bgr666"))
 			imxpd->interface_pix_fmt = V4L2_PIX_FMT_BGR666;
+		else if (!strcmp(fmt, "rgb666"))
+			imxpd->interface_pix_fmt = V4L2_PIX_FMT_RGB666;
 	}
 
 	panel_node = of_parse_phandle(np, "fsl,panel", 0);
-- 
1.7.9.5
