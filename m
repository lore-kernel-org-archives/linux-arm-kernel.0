From: denis@eukrea.com (Denis Carikli)
Date: Thu,  6 Mar 2014 17:04:27 +0100
Subject: [PATCH v9][ 6/8] staging: imx-drm: parallel display: add regulator
 support.
In-Reply-To: <1394121869-13387-1-git-send-email-denis@eukrea.com>
References: <1394121702-13257-3-git-send-email-denis@eukrea.com>
 <1394121869-13387-1-git-send-email-denis@eukrea.com>
Message-ID: <1394121869-13387-3-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v8->v9:
- Removed the Cc. They are now set in git-send-email directly.
- Rebased.

ChangeLog v7->v8:
- Shrinked even more the Cc list.
- Rebased.

ChangeLog v6->v7:
- Shrinked even more the Cc list.
- Rebased the patch and included video/of_display_timing.h
---
 .../bindings/staging/imx-drm/fsl-imx-drm.txt       |    1 +
 drivers/staging/imx-drm/parallel-display.c         |   13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
index 2d24425..4dd7ce5 100644
--- a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
+++ b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
@@ -28,6 +28,7 @@ Required properties:
 - compatible: Should be "fsl,imx-parallel-display"
 - crtc: the crtc this display is connected to, see below
 Optional properties:
+- display-supply : phandle to the regulator device tree node if needed.
 - interface_pix_fmt: How this display is connected to the
   crtc. Currently supported types: "rgb24", "rgb565", "bgr666", "rgb666"
 - edid: verbatim EDID data block describing attached display.
diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
index 084500b..0e0c5ac 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -24,6 +24,7 @@
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_panel.h>
+#include <linux/regulator/consumer.h>
 #include <linux/videodev2.h>
 #include <video/of_display_timing.h>
 
@@ -36,6 +37,7 @@ struct imx_parallel_display {
 	struct drm_connector connector;
 	struct drm_encoder encoder;
 	struct device *dev;
+	struct regulator *disp_reg;
 	void *edid;
 	int edid_len;
 	u32 interface_pix_fmt;
@@ -155,6 +157,9 @@ static void imx_pd_encoder_prepare(struct drm_encoder *encoder)
 {
 	struct imx_parallel_display *imxpd = enc_to_imxpd(encoder);
 
+	if (regulator_enable(imxpd->disp_reg))
+		dev_err(imxpd->dev, "Failed to enable regulator.\n");
+
 	imx_drm_panel_format(encoder, imxpd->interface_pix_fmt);
 }
 
@@ -170,6 +175,10 @@ static void imx_pd_encoder_mode_set(struct drm_encoder *encoder,
 
 static void imx_pd_encoder_disable(struct drm_encoder *encoder)
 {
+	struct imx_parallel_display *imxpd = enc_to_imxpd(encoder);
+
+	if (regulator_disable(imxpd->disp_reg))
+		dev_err(imxpd->dev, "Failed to disable regulator.\n");
 }
 
 static struct drm_connector_funcs imx_pd_connector_funcs = {
@@ -267,6 +276,10 @@ static int imx_pd_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		return ret;
 
+	imxpd->disp_reg = devm_regulator_get(dev, "display");
+	if (IS_ERR(imxpd->disp_reg))
+		return PTR_ERR(imxpd->disp_reg);
+
 	dev_set_drvdata(dev, imxpd);
 
 	return 0;
-- 
1.7.9.5
