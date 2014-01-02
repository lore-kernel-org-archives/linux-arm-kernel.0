From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:26:42 +0000
Subject: [PATCH RFC 11/46] imx-drm: imx-hdmi: fix pixel clock
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1Vypms-0007EF-0J@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The correct pixel clock can be found in the drm_display_mode structure.
Use this rather than trying to calculate it from the h/v total and the
refresh rate, which can be inaccurate.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-hdmi.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index ff00759b4d6f..fe3a6779b620 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -1206,8 +1206,7 @@ static void hdmi_av_composer(struct imx_hdmi *hdmi,
 	vmode->mhsyncpolarity = !!(mode->flags & DRM_MODE_FLAG_PHSYNC);
 	vmode->mvsyncpolarity = !!(mode->flags & DRM_MODE_FLAG_PVSYNC);
 	vmode->minterlaced = !!(mode->flags & DRM_MODE_FLAG_INTERLACE);
-	vmode->mpixelclock = mode->htotal * mode->vtotal *
-			     drm_mode_vrefresh(mode);
+	vmode->mpixelclock = mode->clock * 1000;
 
 	dev_dbg(hdmi->dev, "final pixclk = %d\n", vmode->mpixelclock);
 
-- 
1.7.4.4
