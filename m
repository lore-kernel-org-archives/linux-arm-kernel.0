From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Apr 2015 10:21:46 +0100
Subject: [PATCH RFC v2 06/13] drm: bridge/dw_hdmi: remove
 mhsyncpolarity/mvsyncpolarity/minterlaced
In-Reply-To: <20150402092050.GH24899@n2100.arm.linux.org.uk>
References: <20150402092050.GH24899@n2100.arm.linux.org.uk>
Message-ID: <E1YdbJq-000856-1r@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the struct hdmi_vmode mhsyncpolarity/mvsyncpolarity/minterlaced
members, which are only used within a single function.  We can directly
reference the appropriate mode->flags instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/dw_hdmi.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index a8bd3fbf4300..75728ba552d0 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -82,9 +82,6 @@ static const u16 csc_coeff_rgb_in_eitu709[3][4] = {
 
 struct hdmi_vmode {
 	bool mdvi;
-	bool mhsyncpolarity;
-	bool mvsyncpolarity;
-	bool minterlaced;
 	bool mdataenablepolarity;
 
 	unsigned int mpixelclock;
@@ -1024,9 +1021,6 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 	struct hdmi_vmode *vmode = &hdmi->hdmi_data.video_mode;
 	int hblank, vblank, h_de_hs, v_de_vs, hsync_len, vsync_len;
 
-	vmode->mhsyncpolarity = !!(mode->flags & DRM_MODE_FLAG_PHSYNC);
-	vmode->mvsyncpolarity = !!(mode->flags & DRM_MODE_FLAG_PVSYNC);
-	vmode->minterlaced = !!(mode->flags & DRM_MODE_FLAG_INTERLACE);
 	vmode->mpixelclock = mode->clock * 1000;
 
 	dev_dbg(hdmi->dev, "final pixclk = %d\n", vmode->mpixelclock);
@@ -1036,13 +1030,13 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_ACTIVE :
 		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_INACTIVE);
 
-	inv_val |= (vmode->mvsyncpolarity ?
+	inv_val |= mode->flags & DRM_MODE_FLAG_PVSYNC ?
 		HDMI_FC_INVIDCONF_VSYNC_IN_POLARITY_ACTIVE_HIGH :
-		HDMI_FC_INVIDCONF_VSYNC_IN_POLARITY_ACTIVE_LOW);
+		HDMI_FC_INVIDCONF_VSYNC_IN_POLARITY_ACTIVE_LOW;
 
-	inv_val |= (vmode->mhsyncpolarity ?
+	inv_val |= mode->flags & DRM_MODE_FLAG_PHSYNC ?
 		HDMI_FC_INVIDCONF_HSYNC_IN_POLARITY_ACTIVE_HIGH :
-		HDMI_FC_INVIDCONF_HSYNC_IN_POLARITY_ACTIVE_LOW);
+		HDMI_FC_INVIDCONF_HSYNC_IN_POLARITY_ACTIVE_LOW;
 
 	inv_val |= (vmode->mdataenablepolarity ?
 		HDMI_FC_INVIDCONF_DE_IN_POLARITY_ACTIVE_HIGH :
@@ -1051,13 +1045,13 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 	if (hdmi->vic == 39)
 		inv_val |= HDMI_FC_INVIDCONF_R_V_BLANK_IN_OSC_ACTIVE_HIGH;
 	else
-		inv_val |= (vmode->minterlaced ?
+		inv_val |= mode->flags & DRM_MODE_FLAG_INTERLACE ?
 			HDMI_FC_INVIDCONF_R_V_BLANK_IN_OSC_ACTIVE_HIGH :
-			HDMI_FC_INVIDCONF_R_V_BLANK_IN_OSC_ACTIVE_LOW);
+			HDMI_FC_INVIDCONF_R_V_BLANK_IN_OSC_ACTIVE_LOW;
 
-	inv_val |= (vmode->minterlaced ?
+	inv_val |= mode->flags & DRM_MODE_FLAG_INTERLACE ?
 		HDMI_FC_INVIDCONF_IN_I_P_INTERLACED :
-		HDMI_FC_INVIDCONF_IN_I_P_PROGRESSIVE);
+		HDMI_FC_INVIDCONF_IN_I_P_PROGRESSIVE;
 
 	inv_val |= (vmode->mdvi ?
 		HDMI_FC_INVIDCONF_DVI_MODEZ_DVI_MODE :
-- 
1.8.3.1
