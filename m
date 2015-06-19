From: ykk@rock-chips.com (Yakir Yang)
Date: Sat, 20 Jun 2015 00:21:42 +0800
Subject: [PATCH v5 2/6] drm: bridge/dw_hdmi: enable audio when sink device is
 HDMI and has audio
In-Reply-To: <1434730417-10629-1-git-send-email-ykk@rock-chips.com>
References: <1434730417-10629-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1434730902-10875-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original code only provide audio func when video code is a CEA mode,
but I found that No-CEA mode could also play sound when sink is HDMI mode
and has audio. So I think if sink device has the ability to play audio,
then source should enable audio support that set fc_invidconf to HDMI mode
and config n/cts rightly.

And actually we could know those information through parsing sink edid.
drm_detect_hdmi_monitor() could report whether sink is a HDMI monitor,
drm_detect_monitor_audio() could return whether sink has audio.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v5:
- Take Russell suggest that create "sink_has_audio" and "sink_is_hdmi" in
  struct hdmi, and keep vmode's mdvi changeless.
- Config fc_invidconf to HDMI mode when sink device is HDMI monitor.

Changes in v4:
- Take Dainel suggest that introduce drm_detect_monitor_audio() to judge
  whether source should config audio.

Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/bridge/dw_hdmi.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index f717a2a..417cc82 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -119,6 +119,8 @@ struct dw_hdmi {
 
 	u8 edid[HDMI_EDID_LEN];
 	bool cable_plugin;
+	bool sink_is_hdmi;
+	bool sink_has_audio;
 
 	bool phy_enabled;
 	struct drm_display_mode previous_mode;
@@ -1152,7 +1154,11 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 		HDMI_FC_INVIDCONF_IN_I_P_INTERLACED :
 		HDMI_FC_INVIDCONF_IN_I_P_PROGRESSIVE;
 
-	inv_val |= (vmode->mdvi ?
+	/*
+	 * when sink device is hdmi monitor, then we can config
+	 * this to hdmi_mode even if the video mode is No-CEA mode.
+	 */
+	inv_val |= (hdmi->sink_is_hdmi ?
 		HDMI_FC_INVIDCONF_DVI_MODEZ_DVI_MODE :
 		HDMI_FC_INVIDCONF_DVI_MODEZ_HDMI_MODE);
 
@@ -1330,11 +1336,10 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 	/* HDMI Initialization Step B.3 */
 	dw_hdmi_enable_video_path(hdmi);
 
-	/* not for DVI mode */
-	if (hdmi->hdmi_data.video_mode.mdvi) {
-		dev_dbg(hdmi->dev, "%s DVI mode\n", __func__);
+	if (!hdmi->sink_has_audio) {
+		dev_info(hdmi->dev, "sink device does not support audio\n");
 	} else {
-		dev_dbg(hdmi->dev, "%s CEA mode\n", __func__);
+		dev_dbg(hdmi->dev, "sink device support audio\n");
 
 		/* HDMI Initialization Step E - Configure audio */
 		hdmi_clk_regenerator_update_pixel_clock(hdmi);
@@ -1500,6 +1505,9 @@ static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
 		dev_dbg(hdmi->dev, "got edid: width[%d] x height[%d]\n",
 			edid->width_cm, edid->height_cm);
 
+		hdmi->sink_is_hdmi = drm_detect_hdmi_monitor(edid);
+		hdmi->sink_has_audio = drm_detect_monitor_audio(edid);
+
 		drm_mode_connector_update_edid_property(connector, edid);
 		ret = drm_add_edid_modes(connector, edid);
 		/* Store the ELD */
-- 
2.1.2
