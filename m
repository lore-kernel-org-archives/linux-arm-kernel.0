From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Jan 2014 16:13:47 +0000
Subject: [PATCH] fix compilation of imx-hdmi
Message-ID: <20140130161347.GD15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx-hdmi creates a hdmi_colorimetry enum.  This is also defined by
include/linux/hdmi.h, which gets included now via DRM headers since
985e5dc207e133 (drm/edid: Populate picture aspect ratio for CEA modes).
This leads to the compiler complaining:

drivers/staging/imx-drm/imx-hdmi.c:58:6: error: nested redefinition of 'enum hdmi_colorimetry'
drivers/staging/imx-drm/imx-hdmi.c:58:6: error: redeclaration of 'enum hdmi_colorimetry'
include/linux/hdmi.h:48:6: note: originally defined here

Fix it by using the one in linux/hdmi.h

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-hdmi.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index d358d89e11c4..74d635fcb3d5 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -55,11 +55,6 @@ enum hdmi_datamap {
 	YCbCr422_12B = 0x12,
 };
 
-enum hdmi_colorimetry {
-	ITU601,
-	ITU709,
-};
-
 enum imx_hdmi_devtype {
 	IMX6Q_HDMI,
 	IMX6DL_HDMI,
@@ -475,12 +470,12 @@ static void imx_hdmi_update_csc_coeffs(struct imx_hdmi *hdmi)
 
 	if (is_color_space_conversion(hdmi)) {
 		if (hdmi->hdmi_data.enc_out_format == RGB) {
-			if (hdmi->hdmi_data.colorimetry == ITU601)
+			if (hdmi->hdmi_data.colorimetry == HDMI_COLORIMETRY_ITU_601)
 				csc_coeff = &csc_coeff_rgb_out_eitu601;
 			else
 				csc_coeff = &csc_coeff_rgb_out_eitu709;
 		} else if (hdmi->hdmi_data.enc_in_format == RGB) {
-			if (hdmi->hdmi_data.colorimetry == ITU601)
+			if (hdmi->hdmi_data.colorimetry == HDMI_COLORIMETRY_ITU_601)
 				csc_coeff = &csc_coeff_rgb_in_eitu601;
 			else
 				csc_coeff = &csc_coeff_rgb_in_eitu709;
@@ -1009,14 +1004,14 @@ static void hdmi_config_AVI(struct imx_hdmi *hdmi)
 	/* Set up colorimetry */
 	if (hdmi->hdmi_data.enc_out_format == XVYCC444) {
 		colorimetry = HDMI_FC_AVICONF1_COLORIMETRY_EXTENDED_INFO;
-		if (hdmi->hdmi_data.colorimetry == ITU601)
+		if (hdmi->hdmi_data.colorimetry == HDMI_COLORIMETRY_ITU_601)
 			ext_colorimetry =
 				HDMI_FC_AVICONF2_EXT_COLORIMETRY_XVYCC601;
 		else /* hdmi->hdmi_data.colorimetry == ITU709 */
 			ext_colorimetry =
 				HDMI_FC_AVICONF2_EXT_COLORIMETRY_XVYCC709;
 	} else if (hdmi->hdmi_data.enc_out_format != RGB) {
-		if (hdmi->hdmi_data.colorimetry == ITU601)
+		if (hdmi->hdmi_data.colorimetry == HDMI_COLORIMETRY_ITU_601)
 			colorimetry = HDMI_FC_AVICONF1_COLORIMETRY_SMPTE;
 		else /* hdmi->hdmi_data.colorimetry == ITU709 */
 			colorimetry = HDMI_FC_AVICONF1_COLORIMETRY_ITUR;
@@ -1247,9 +1242,9 @@ static int imx_hdmi_setup(struct imx_hdmi *hdmi, struct drm_display_mode *mode)
 		(hdmi->vic == 21) || (hdmi->vic == 22) ||
 		(hdmi->vic == 2) || (hdmi->vic == 3) ||
 		(hdmi->vic == 17) || (hdmi->vic == 18))
-		hdmi->hdmi_data.colorimetry = ITU601;
+		hdmi->hdmi_data.colorimetry = HDMI_COLORIMETRY_ITU_601;
 	else
-		hdmi->hdmi_data.colorimetry = ITU709;
+		hdmi->hdmi_data.colorimetry = HDMI_COLORIMETRY_ITU_709;
 
 	if ((hdmi->vic == 10) || (hdmi->vic == 11) ||
 		(hdmi->vic == 12) || (hdmi->vic == 13) ||

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
