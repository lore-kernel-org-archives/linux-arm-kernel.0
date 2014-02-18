From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 18 Feb 2014 20:09:56 +0000
Subject: [PATCH 04/34] imx-drm: imx-hdmi: clean up setting of vp_conf
In-Reply-To: <20140218200900.GM21483@n2100.arm.linux.org.uk>
References: <20140218200900.GM21483@n2100.arm.linux.org.uk>
Message-ID: <E1WFqzM-0007iK-P6@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-hdmi.c | 49 +++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index 2fa8658cebd4..ec5b5e2ada34 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -555,7 +555,7 @@ static void hdmi_video_packetize(struct imx_hdmi *hdmi)
 	unsigned int remap_size = HDMI_VP_REMAP_YCC422_16bit;
 	unsigned int output_select = HDMI_VP_CONF_OUTPUT_SELECTOR_PP;
 	struct hdmi_data_info *hdmi_data = &hdmi->hdmi_data;
-	u8 val;
+	u8 val, vp_conf;
 
 	if (hdmi_data->enc_out_format == RGB
 		|| hdmi_data->enc_out_format == YCBCR444) {
@@ -599,47 +599,42 @@ static void hdmi_video_packetize(struct imx_hdmi *hdmi)
 
 	/* Data from pixel repeater block */
 	if (hdmi_data->pix_repet_factor > 1) {
-		hdmi_modb(hdmi, HDMI_VP_CONF_PR_EN_ENABLE |
-				HDMI_VP_CONF_BYPASS_SELECT_PIX_REPEATER,
-			  HDMI_VP_CONF_PR_EN_MASK |
-			  HDMI_VP_CONF_BYPASS_SELECT_MASK, HDMI_VP_CONF);
+		vp_conf = HDMI_VP_CONF_PR_EN_ENABLE |
+			  HDMI_VP_CONF_BYPASS_SELECT_PIX_REPEATER;
 	} else { /* data from packetizer block */
-		hdmi_modb(hdmi, HDMI_VP_CONF_PR_EN_DISABLE |
-				HDMI_VP_CONF_BYPASS_SELECT_VID_PACKETIZER,
-			  HDMI_VP_CONF_PR_EN_MASK |
-			  HDMI_VP_CONF_BYPASS_SELECT_MASK, HDMI_VP_CONF);
+		vp_conf = HDMI_VP_CONF_PR_EN_DISABLE |
+			  HDMI_VP_CONF_BYPASS_SELECT_VID_PACKETIZER;
 	}
 
+	hdmi_modb(hdmi, vp_conf,
+		  HDMI_VP_CONF_PR_EN_MASK |
+		  HDMI_VP_CONF_BYPASS_SELECT_MASK, HDMI_VP_CONF);
+
 	hdmi_modb(hdmi, 1 << HDMI_VP_STUFF_IDEFAULT_PHASE_OFFSET,
 		  HDMI_VP_STUFF_IDEFAULT_PHASE_MASK, HDMI_VP_STUFF);
 
 	hdmi_writeb(hdmi, remap_size, HDMI_VP_REMAP);
 
 	if (output_select == HDMI_VP_CONF_OUTPUT_SELECTOR_PP) {
-		hdmi_modb(hdmi, HDMI_VP_CONF_BYPASS_EN_DISABLE |
-				HDMI_VP_CONF_PP_EN_ENABLE |
-				HDMI_VP_CONF_YCC422_EN_DISABLE,
-			  HDMI_VP_CONF_BYPASS_EN_MASK |
-			  HDMI_VP_CONF_PP_EN_ENMASK |
-			  HDMI_VP_CONF_YCC422_EN_MASK, HDMI_VP_CONF);
+		vp_conf = HDMI_VP_CONF_BYPASS_EN_DISABLE |
+			  HDMI_VP_CONF_PP_EN_ENABLE |
+			  HDMI_VP_CONF_YCC422_EN_DISABLE;
 	} else if (output_select == HDMI_VP_CONF_OUTPUT_SELECTOR_YCC422) {
-		hdmi_modb(hdmi, HDMI_VP_CONF_BYPASS_EN_DISABLE |
-				HDMI_VP_CONF_PP_EN_DISABLE |
-				HDMI_VP_CONF_YCC422_EN_ENABLE,
-			  HDMI_VP_CONF_BYPASS_EN_MASK |
-			  HDMI_VP_CONF_PP_EN_ENMASK |
-			  HDMI_VP_CONF_YCC422_EN_MASK, HDMI_VP_CONF);
+		vp_conf = HDMI_VP_CONF_BYPASS_EN_DISABLE |
+			  HDMI_VP_CONF_PP_EN_DISABLE |
+			  HDMI_VP_CONF_YCC422_EN_ENABLE;
 	} else if (output_select == HDMI_VP_CONF_OUTPUT_SELECTOR_BYPASS) {
-		hdmi_modb(hdmi, HDMI_VP_CONF_BYPASS_EN_ENABLE |
-				HDMI_VP_CONF_PP_EN_DISABLE |
-				HDMI_VP_CONF_YCC422_EN_DISABLE,
-			  HDMI_VP_CONF_BYPASS_EN_MASK |
-			  HDMI_VP_CONF_PP_EN_ENMASK |
-			  HDMI_VP_CONF_YCC422_EN_MASK, HDMI_VP_CONF);
+		vp_conf = HDMI_VP_CONF_BYPASS_EN_ENABLE |
+			  HDMI_VP_CONF_PP_EN_DISABLE |
+			  HDMI_VP_CONF_YCC422_EN_DISABLE;
 	} else {
 		return;
 	}
 
+	hdmi_modb(hdmi, vp_conf,
+		  HDMI_VP_CONF_BYPASS_EN_MASK | HDMI_VP_CONF_PP_EN_ENMASK |
+		  HDMI_VP_CONF_YCC422_EN_MASK, HDMI_VP_CONF);
+
 	hdmi_modb(hdmi, HDMI_VP_STUFF_PP_STUFFING_STUFFING_MODE |
 			HDMI_VP_STUFF_YCC422_STUFFING_STUFFING_MODE,
 		  HDMI_VP_STUFF_PP_STUFFING_MASK |
-- 
1.8.3.1
