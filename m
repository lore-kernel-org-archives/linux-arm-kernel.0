From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  8 Apr 2013 18:04:32 +0200
Subject: [PATCH 1/7] staging: drm/imx: ipu-dc: add 24-bit GBR support to DC
In-Reply-To: <1365437078-22579-1-git-send-email-p.zabel@pengutronix.de>
References: <1365437078-22579-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1365437078-22579-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

24-bit GBR order is needed on the display interface connected
to the Television Encoder (TVEv2) on i.MX53.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/imx-drm.h       | 10 ++++++++++
 drivers/staging/imx-drm/ipu-v3/ipu-dc.c | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/staging/imx-drm/imx-drm.h b/drivers/staging/imx-drm/imx-drm.h
index ae28a49..a24508f 100644
--- a/drivers/staging/imx-drm/imx-drm.h
+++ b/drivers/staging/imx-drm/imx-drm.h
@@ -1,8 +1,18 @@
 #ifndef _IMX_DRM_H_
 #define _IMX_DRM_H_
 
+#include <linux/videodev2.h>
+
+#define IPU_PIX_FMT_GBR24	v4l2_fourcc('G', 'B', 'R', '3')
+
+struct drm_crtc;
+struct drm_connector;
+struct drm_device;
+struct drm_encoder;
 struct imx_drm_crtc;
 struct drm_fbdev_cma;
+struct drm_framebuffer;
+struct platform_device;
 
 struct imx_drm_crtc_helper_funcs {
 	int (*enable_vblank)(struct drm_crtc *crtc);
diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
index 93c7579..fad5057 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 
+#include "../imx-drm.h"
 #include "imx-ipu-v3.h"
 #include "ipu-prv.h"
 
@@ -86,6 +87,7 @@ struct ipu_dc_priv;
 enum ipu_dc_map {
 	IPU_DC_MAP_RGB24,
 	IPU_DC_MAP_RGB565,
+	IPU_DC_MAP_GBR24, /* TVEv2 */
 };
 
 struct ipu_dc {
@@ -136,6 +138,8 @@ static int ipu_pixfmt_to_map(u32 fmt)
 		return IPU_DC_MAP_RGB24;
 	case V4L2_PIX_FMT_RGB565:
 		return IPU_DC_MAP_RGB565;
+	case IPU_PIX_FMT_GBR24:
+		return IPU_DC_MAP_GBR24;
 	default:
 		return -EINVAL;
 	}
@@ -364,6 +368,12 @@ int ipu_dc_init(struct ipu_soc *ipu, struct device *dev,
 	ipu_dc_map_config(priv, IPU_DC_MAP_RGB565, 1, 10, 0xfc); /* green */
 	ipu_dc_map_config(priv, IPU_DC_MAP_RGB565, 2, 15, 0xf8); /* red */
 
+	/* gbr24 */
+	ipu_dc_map_clear(priv, IPU_DC_MAP_GBR24);
+	ipu_dc_map_config(priv, IPU_DC_MAP_GBR24, 2, 15, 0xff); /* green */
+	ipu_dc_map_config(priv, IPU_DC_MAP_GBR24, 1, 7, 0xff); /* blue */
+	ipu_dc_map_config(priv, IPU_DC_MAP_GBR24, 0, 23, 0xff); /* red */
+
 	return 0;
 }
 
-- 
1.8.2.rc2
