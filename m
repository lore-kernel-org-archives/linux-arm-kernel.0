From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 30 Mar 2015 20:40:11 +0100
Subject: [PATCH RFC 03/11] drm: bridge/dw_hdmi: simplify hdmi_config_AVI() a
 little
In-Reply-To: <20150330193911.GM24899@n2100.arm.linux.org.uk>
References: <20150330193911.GM24899@n2100.arm.linux.org.uk>
Message-ID: <E1YcfXf-0002ue-If@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a YCBCR format is selected, we can merely copy the colorimetry
information directly as we use the same definitions for both the
unpacked AVI info frame and the hdmi_data_info structure.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/dw_hdmi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 44c63883db19..fd02a220ad5b 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -944,10 +944,7 @@ static void hdmi_config_AVI(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 			frame.extended_colorimetry =
 				HDMI_EXTENDED_COLORIMETRY_XV_YCC_709;
 	} else if (hdmi->hdmi_data.enc_out_format != RGB) {
-		if (hdmi->hdmi_data.colorimetry == HDMI_COLORIMETRY_ITU_601)
-			frame.colorimetry = HDMI_COLORIMETRY_ITU_601;
-		else /*hdmi->hdmi_data.colorimetry == HDMI_COLORIMETRY_ITU_709*/
-			frame.colorimetry = HDMI_COLORIMETRY_ITU_709;
+		frame.colorimetry = hdmi->hdmi_data.colorimetry;
 		frame.extended_colorimetry = HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
 	} else { /* Carries no data */
 		frame.colorimetry = HDMI_COLORIMETRY_NONE;
-- 
1.8.3.1
