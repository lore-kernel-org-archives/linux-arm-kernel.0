From: ykk@rock-chips.com (Yakir Yang)
Date: Tue,  3 Feb 2015 10:15:14 -0500
Subject: [PATCH v3 09/15] drm: bridge/dw_hdmi: enable audio support for No-CEA
 display resolutions
In-Reply-To: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
References: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1422976514-30306-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the monitor support audio, so we should support audio for it, even if
the display resolution is No-CEA mode.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v3: None
Changes in v2:
- enable audio support for No-CEA display mode

 drivers/gpu/drm/bridge/dw_hdmi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 1c0515f..0bee5ea 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -1264,13 +1264,10 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 
 	hdmi->vic = drm_match_cea_mode(mode);
 
-	if (!hdmi->vic) {
+	if (hdmi->hdmi_data.video_mode.mdvi)
 		dev_dbg(hdmi->dev, "Non-CEA mode used in HDMI\n");
-		hdmi->hdmi_data.video_mode.mdvi = true;
-	} else {
+	else
 		dev_dbg(hdmi->dev, "CEA mode used vic=%d\n", hdmi->vic);
-		hdmi->hdmi_data.video_mode.mdvi = false;
-	}
 
 	if ((hdmi->vic == 6) || (hdmi->vic == 7) ||
 	    (hdmi->vic == 21) || (hdmi->vic == 22) ||
@@ -1538,6 +1535,7 @@ static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
 {
 	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
 					     connector);
+	struct hdmi_vmode *vmode = &hdmi->hdmi_data.video_mode;
 	struct edid *edid;
 	int ret;
 
@@ -1549,6 +1547,8 @@ static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
 		dev_dbg(hdmi->dev, "got edid: width[%d] x height[%d]\n",
 			edid->width_cm, edid->height_cm);
 
+		vmode->mdvi = !drm_detect_hdmi_monitor(edid);
+
 		drm_mode_connector_update_edid_property(connector, edid);
 		ret = drm_add_edid_modes(connector, edid);
 		kfree(edid);
-- 
2.1.2
