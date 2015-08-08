From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 08 Aug 2015 17:03:45 +0100
Subject: [PATCH 05/12] drm: bridge/dw_hdmi: add support for interlaced video
 modes
In-Reply-To: <20150808160251.GM7557@n2100.arm.linux.org.uk>
References: <20150808160251.GM7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZO6b3-0002qv-BK@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for interlaced video modes to the dw_hdmi bridge.  This
mainly involves halving the vertical parameters to be programmed into
the bridge registers, and setting the interlace_allowed connector flag.

This brings working 1080i support.  However, 480i and 576i fail to
work due to the lack of proper pixel repetition support, which is not
trivial to add due to the tabular PLL parameterisation.  Hence, we
filter out these modes in our mode_valid() method.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/dw_hdmi.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 8edf4c31f55c..2e211b8331ed 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -1060,6 +1060,7 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 	u8 inv_val;
 	struct hdmi_vmode *vmode = &hdmi->hdmi_data.video_mode;
 	int hblank, vblank, h_de_hs, v_de_vs, hsync_len, vsync_len;
+	unsigned int vdisplay;
 
 	vmode->mpixelclock = mode->clock * 1000;
 
@@ -1099,13 +1100,29 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 
 	hdmi_writeb(hdmi, inv_val, HDMI_FC_INVIDCONF);
 
+	vdisplay = mode->vdisplay;
+	vblank = mode->vtotal - mode->vdisplay;
+	v_de_vs = mode->vsync_start - mode->vdisplay;
+	vsync_len = mode->vsync_end - mode->vsync_start;
+
+	/*
+	 * When we're setting an interlaced mode, we need
+	 * to adjust the vertical timing to suit.
+	 */
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE) {
+		vdisplay /= 2;
+		vblank /= 2;
+		v_de_vs /= 2;
+		vsync_len /= 2;
+	}
+
 	/* Set up horizontal active pixel width */
 	hdmi_writeb(hdmi, mode->hdisplay >> 8, HDMI_FC_INHACTV1);
 	hdmi_writeb(hdmi, mode->hdisplay, HDMI_FC_INHACTV0);
 
 	/* Set up vertical active lines */
-	hdmi_writeb(hdmi, mode->vdisplay >> 8, HDMI_FC_INVACTV1);
-	hdmi_writeb(hdmi, mode->vdisplay, HDMI_FC_INVACTV0);
+	hdmi_writeb(hdmi, vdisplay >> 8, HDMI_FC_INVACTV1);
+	hdmi_writeb(hdmi, vdisplay, HDMI_FC_INVACTV0);
 
 	/* Set up horizontal blanking pixel region width */
 	hblank = mode->htotal - mode->hdisplay;
@@ -1113,7 +1130,6 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 	hdmi_writeb(hdmi, hblank, HDMI_FC_INHBLANK0);
 
 	/* Set up vertical blanking pixel region width */
-	vblank = mode->vtotal - mode->vdisplay;
 	hdmi_writeb(hdmi, vblank, HDMI_FC_INVBLANK);
 
 	/* Set up HSYNC active edge delay width (in pixel clks) */
@@ -1122,7 +1138,6 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 	hdmi_writeb(hdmi, h_de_hs, HDMI_FC_HSYNCINDELAY0);
 
 	/* Set up VSYNC active edge delay (in lines) */
-	v_de_vs = mode->vsync_start - mode->vdisplay;
 	hdmi_writeb(hdmi, v_de_vs, HDMI_FC_VSYNCINDELAY);
 
 	/* Set up HSYNC active pulse width (in pixel clks) */
@@ -1131,7 +1146,6 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 	hdmi_writeb(hdmi, hsync_len, HDMI_FC_HSYNCINWIDTH0);
 
 	/* Set up VSYNC active edge delay (in lines) */
-	vsync_len = mode->vsync_end - mode->vsync_start;
 	hdmi_writeb(hdmi, vsync_len, HDMI_FC_VSYNCINWIDTH);
 }
 
@@ -1593,6 +1607,8 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
 	if (!hdmi)
 		return -ENOMEM;
 
+	hdmi->connector.interlace_allowed = 1;
+
 	hdmi->plat_data = plat_data;
 	hdmi->dev = dev;
 	hdmi->dev_type = plat_data->dev_type;
-- 
2.1.0
