From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Wed, 20 Jul 2016 12:03:02 +0800
Subject: [PATCH 1/4] drm/mediatek: do mtk_hdmi_send_infoframe after HDMI clock
 enable
In-Reply-To: <1468987385-37353-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1468987385-37353-1-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <1468987385-37353-2-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Junzhi Zhao <junzhi.zhao@mediatek.com>

The mtk_hdmi_send_infoframe have to
be run after PLL and PIXEL clock of HDMI enable.
Make sure that HDMI inforframes can be sent
successfully.

Signed-off-by: Junzhi Zhao <junzhi.zhao@mediatek.com>
Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index ba812ef..d8609f5 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1133,12 +1133,6 @@ static int mtk_hdmi_output_set_display_mode(struct mtk_hdmi *hdmi,
 	phy_power_on(hdmi->phy);
 	mtk_hdmi_aud_output_config(hdmi, mode);
 
-	mtk_hdmi_setup_audio_infoframe(hdmi);
-	mtk_hdmi_setup_avi_infoframe(hdmi, mode);
-	mtk_hdmi_setup_spd_infoframe(hdmi, "mediatek", "On-chip HDMI");
-	if (mode->flags & DRM_MODE_FLAG_3D_MASK)
-		mtk_hdmi_setup_vendor_specific_infoframe(hdmi, mode);
-
 	mtk_hdmi_hw_vid_black(hdmi, false);
 	mtk_hdmi_hw_aud_unmute(hdmi);
 	mtk_hdmi_hw_send_av_unmute(hdmi);
@@ -1401,14 +1395,25 @@ static void mtk_hdmi_bridge_pre_enable(struct drm_bridge *bridge)
 	hdmi->powered = true;
 }
 
+static void mtk_hdmi_send_infoframe(struct mtk_hdmi *hdmi,
+				    struct drm_display_mode *mode)
+{
+	mtk_hdmi_setup_audio_infoframe(hdmi);
+	mtk_hdmi_setup_avi_infoframe(hdmi, mode);
+	mtk_hdmi_setup_spd_infoframe(hdmi, "mediatek", "On-chip HDMI");
+	if (mode->flags & DRM_MODE_FLAG_3D_MASK)
+		mtk_hdmi_setup_vendor_specific_infoframe(hdmi, mode);
+}
+
 static void mtk_hdmi_bridge_enable(struct drm_bridge *bridge)
 {
 	struct mtk_hdmi *hdmi = hdmi_ctx_from_bridge(bridge);
 
+	phy_power_on(hdmi->phy);
 	mtk_hdmi_output_set_display_mode(hdmi, &hdmi->mode);
 	clk_prepare_enable(hdmi->clk[MTK_HDMI_CLK_HDMI_PLL]);
 	clk_prepare_enable(hdmi->clk[MTK_HDMI_CLK_HDMI_PIXEL]);
-	phy_power_on(hdmi->phy);
+	mtk_hdmi_send_infoframe(hdmi, &hdmi->mode);
 
 	hdmi->enabled = true;
 }
-- 
1.7.9.5
