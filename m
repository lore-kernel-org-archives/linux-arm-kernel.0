From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Apr 2015 10:21:40 +0100
Subject: [PATCH RFC v2 05/13] drm: bridge/dw_hdmi: simplify hdmi_config_AVI()
 a little
In-Reply-To: <20150402092050.GH24899@n2100.arm.linux.org.uk>
References: <20150402092050.GH24899@n2100.arm.linux.org.uk>
Message-ID: <E1YdbJk-000852-Uw@rmk-PC.arm.linux.org.uk>
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
index 0f3ccfa3ccfc..a8bd3fbf4300 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -943,10 +943,7 @@ static void hdmi_config_AVI(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
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
