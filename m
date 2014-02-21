From: denis@eukrea.com (Denis Carikli)
Date: Fri, 21 Feb 2014 15:00:02 +0100
Subject: [PATCHv7][ 5/7] staging: imx-drm: parallel display: add regulator
 support.
In-Reply-To: <1392991205-25371-1-git-send-email-denis@eukrea.com>
References: <1392991205-25371-1-git-send-email-denis@eukrea.com>
Message-ID: <1392991205-25371-5-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Eric B?nard <eric@eukrea.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marek Vasut <marex@denx.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: driverdev-devel at linuxdriverproject.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
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
index 3f7f09d..d65dad4 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -22,6 +22,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_crtc_helper.h>
+#include <linux/regulator/consumer.h>
 #include <linux/videodev2.h>
 #include <video/of_display_timing.h>
 
@@ -36,6 +37,7 @@ struct imx_parallel_display {
 	struct drm_encoder encoder;
 	struct imx_drm_encoder *imx_drm_encoder;
 	struct device *dev;
+	struct regulator *disp_reg;
 	void *edid;
 	int edid_len;
 	u32 interface_pix_fmt;
@@ -141,6 +143,9 @@ static void imx_pd_encoder_prepare(struct drm_encoder *encoder)
 {
 	struct imx_parallel_display *imxpd = enc_to_imxpd(encoder);
 
+	if (regulator_enable(imxpd->disp_reg))
+		dev_err(imxpd->dev, "Failed to enable regulator.\n");
+
 	imx_drm_crtc_panel_format(encoder->crtc, DRM_MODE_ENCODER_NONE,
 			imxpd->interface_pix_fmt);
 }
@@ -157,6 +162,10 @@ static void imx_pd_encoder_mode_set(struct drm_encoder *encoder,
 
 static void imx_pd_encoder_disable(struct drm_encoder *encoder)
 {
+	struct imx_parallel_display *imxpd = enc_to_imxpd(encoder);
+
+	if (regulator_disable(imxpd->disp_reg))
+		dev_err(imxpd->dev, "Failed to disable regulator.\n");
 }
 
 static void imx_pd_encoder_destroy(struct drm_encoder *encoder)
@@ -260,6 +269,10 @@ static int imx_pd_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	imxpd->disp_reg = devm_regulator_get(&pdev->dev, "display");
+	if (IS_ERR(imxpd->disp_reg))
+		return PTR_ERR(imxpd->disp_reg);
+
 	ret = imx_drm_encoder_add_possible_crtcs(imxpd->imx_drm_encoder, np);
 
 	platform_set_drvdata(pdev, imxpd);
-- 
1.7.9.5
