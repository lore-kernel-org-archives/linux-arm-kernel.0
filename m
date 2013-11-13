From: denis@eukrea.com (Denis Carikli)
Date: Wed, 13 Nov 2013 10:23:20 +0100
Subject: [PATCHv4][ 4/7] staging: imx-drm: parallel display: add regulator
 support.
In-Reply-To: <1384334603-14208-1-git-send-email-denis@eukrea.com>
References: <1384334603-14208-1-git-send-email-denis@eukrea.com>
Message-ID: <1384334603-14208-4-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: driverdev-devel at linuxdriverproject.org
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel at lists.freedesktop.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v2->v3:
- Added some interested people in the Cc list.
- the lcd-supply is now called display-supply (not all display are LCD).
- The code and documentation was updated accordingly.
- regulator_is_enabled now guard the regulator enables/disables because
  regulator_disable does not check the regulator state.
---
 .../bindings/staging/imx-drm/fsl-imx-drm.txt       |    1 +
 drivers/staging/imx-drm/parallel-display.c         |   22 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

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
index 46b6fce..195ec60 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -22,6 +22,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_crtc_helper.h>
+#include <linux/regulator/consumer.h>
 #include <linux/videodev2.h>
 
 #include "imx-drm.h"
@@ -35,6 +36,7 @@ struct imx_parallel_display {
 	struct drm_encoder encoder;
 	struct imx_drm_encoder *imx_drm_encoder;
 	struct device *dev;
+	struct regulator *disp_reg;
 	void *edid;
 	int edid_len;
 	u32 interface_pix_fmt;
@@ -139,6 +141,12 @@ static void imx_pd_encoder_prepare(struct drm_encoder *encoder)
 {
 	struct imx_parallel_display *imxpd = enc_to_imxpd(encoder);
 
+	if (imxpd->disp_reg && !regulator_is_enabled(imxpd->disp_reg)) {
+		if (regulator_enable(imxpd->disp_reg))
+			dev_err(imxpd->dev,
+				"Failed to enable regulator.\n");
+	}
+
 	imx_drm_crtc_panel_format(encoder->crtc, DRM_MODE_ENCODER_NONE,
 			imxpd->interface_pix_fmt);
 }
@@ -155,6 +163,12 @@ static void imx_pd_encoder_mode_set(struct drm_encoder *encoder,
 
 static void imx_pd_encoder_disable(struct drm_encoder *encoder)
 {
+	struct imx_parallel_display *imxpd = enc_to_imxpd(encoder);
+
+	if (imxpd->disp_reg && regulator_is_enabled(imxpd->disp_reg)) {
+		if (regulator_disable(imxpd->disp_reg))
+			dev_err(imxpd->dev, "Failed to disable regulator.\n");
+	}
 }
 
 static void imx_pd_encoder_destroy(struct drm_encoder *encoder)
@@ -258,6 +272,14 @@ static int imx_pd_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	imxpd->disp_reg = devm_regulator_get(&pdev->dev, "display");
+	if (IS_ERR(imxpd->disp_reg)) {
+		dev_warn(&pdev->dev, "Operating without display regulator.\n");
+		imxpd->disp_reg = NULL;
+	} else {
+		dev_info(&pdev->dev, "Using display regulator.\n");
+	}
+
 	ret = imx_drm_encoder_add_possible_crtcs(imxpd->imx_drm_encoder, np);
 
 	platform_set_drvdata(pdev, imxpd);
-- 
1.7.9.5
