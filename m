From: denis@eukrea.com (Denis Carikli)
Date: Thu, 17 Oct 2013 17:02:12 +0200
Subject: [Patch v2][ 14/37] staging: imx-drm: parallel display: add regulator
 support.
In-Reply-To: <1382022155-21954-1-git-send-email-denis@eukrea.com>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
Message-ID: <1382022155-21954-15-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
Cc: linux-arm-kernel at lists.infradead.org
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 drivers/staging/imx-drm/parallel-display.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
index 1c8f63f..dfab7b5 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -22,6 +22,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_crtc_helper.h>
+#include <linux/regulator/consumer.h>
 #include <linux/videodev2.h>
 #include <video/videomode.h>
 #include <video/of_display_timing.h>
@@ -37,6 +38,7 @@ struct imx_parallel_display {
 	struct drm_encoder encoder;
 	struct imx_drm_encoder *imx_drm_encoder;
 	struct device *dev;
+	struct regulator *lcd_reg;
 	void *edid;
 	int edid_len;
 	u32 interface_pix_fmt;
@@ -129,6 +131,10 @@ static void imx_pd_encoder_prepare(struct drm_encoder *encoder)
 {
 	struct imx_parallel_display *imxpd = enc_to_imxpd(encoder);
 
+	if (imxpd->lcd_reg)
+		if (regulator_enable(imxpd->lcd_reg))
+			dev_err(imxpd->dev, "Failed to enable lcd regulator.\n");
+
 	imx_drm_crtc_panel_format(encoder->crtc, DRM_MODE_ENCODER_NONE,
 			imxpd->interface_pix_fmt);
 }
@@ -145,6 +151,11 @@ static void imx_pd_encoder_mode_set(struct drm_encoder *encoder,
 
 static void imx_pd_encoder_disable(struct drm_encoder *encoder)
 {
+	struct imx_parallel_display *imxpd = enc_to_imxpd(encoder);
+
+	if (imxpd->lcd_reg)
+		if (regulator_disable(imxpd->lcd_reg))
+			dev_err(imxpd->dev, "Failed to disable lcd regulator.\n");
 }
 
 static void imx_pd_encoder_destroy(struct drm_encoder *encoder)
@@ -248,6 +259,14 @@ static int imx_pd_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	imxpd->lcd_reg = devm_regulator_get(&pdev->dev, "lcd");
+	if (IS_ERR(imxpd->lcd_reg)) {
+		dev_dbg(&pdev->dev, "no lcd-supply given.\n");
+		imxpd->lcd_reg = NULL;
+	} else {
+		dev_info(&pdev->dev, "lcd-supply found.\n");
+	}
+
 	ret = imx_drm_encoder_add_possible_crtcs(imxpd->imx_drm_encoder, np);
 
 	platform_set_drvdata(pdev, imxpd);
-- 
1.7.9.5
