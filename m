From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 08 Aug 2015 17:03:24 +0100
Subject: [PATCH 01/12] drm: bridge/dw_hdmi: remove pixel repetition setting
 for all VICs
In-Reply-To: <20150808160251.GM7557@n2100.arm.linux.org.uk>
References: <20150808160251.GM7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZO6ai-0002qN-Nn@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dw_hdmi sets a pixel repetition factor of 1 for VICs 10-15, 25-30 and
35-38.  However, DRM uses their native resolutions in its timing
information.  For example, VIC 14 can be 1440x480 with no repetition,
or 720x480 with one pixel repetition.  As DRM uses 1440 pixels per line
for this video mode, we need no pixel repetition.

In any case, pixel repetition appears broken in dw_hdmi.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/dw_hdmi.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index f070ee07b8c9..1c0ee3476138 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -1236,18 +1236,7 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 	else
 		hdmi->hdmi_data.colorimetry = HDMI_COLORIMETRY_ITU_709;
 
-	if ((hdmi->vic == 10) || (hdmi->vic == 11) ||
-	    (hdmi->vic == 12) || (hdmi->vic == 13) ||
-	    (hdmi->vic == 14) || (hdmi->vic == 15) ||
-	    (hdmi->vic == 25) || (hdmi->vic == 26) ||
-	    (hdmi->vic == 27) || (hdmi->vic == 28) ||
-	    (hdmi->vic == 29) || (hdmi->vic == 30) ||
-	    (hdmi->vic == 35) || (hdmi->vic == 36) ||
-	    (hdmi->vic == 37) || (hdmi->vic == 38))
-		hdmi->hdmi_data.video_mode.mpixelrepetitionoutput = 1;
-	else
-		hdmi->hdmi_data.video_mode.mpixelrepetitionoutput = 0;
-
+	hdmi->hdmi_data.video_mode.mpixelrepetitionoutput = 0;
 	hdmi->hdmi_data.video_mode.mpixelrepetitioninput = 0;
 
 	/* TODO: Get input format from IPU (via FB driver interface) */
-- 
2.1.0
