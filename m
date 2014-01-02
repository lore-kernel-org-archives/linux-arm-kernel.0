From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:26:57 +0000
Subject: [PATCH RFC 14/46] imx-drm: imx-hdmi: get rid of clk manipulations in
 imx_hdmi_fb_registered()
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1Vypn7-0007ES-BK@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock manipulations do nothing for us: the clock is already enabled
by the only caller (imx_hdmi_platform_probe()).  Get rid of these and
simplify the code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-hdmi.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index 267d3c9114c6..1eb12c57aa3e 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -1448,12 +1448,6 @@ static int imx_hdmi_setup(struct imx_hdmi *hdmi, struct drm_display_mode *mode)
 /* Wait until we are registered to enable interrupts */
 static int imx_hdmi_fb_registered(struct imx_hdmi *hdmi)
 {
-	int ret;
-
-	ret = clk_prepare_enable(hdmi->iahb_clk);
-	if (ret)
-		return ret;
-
 	hdmi_writeb(hdmi, HDMI_PHY_I2CM_INT_ADDR_DONE_POL,
 		    HDMI_PHY_I2CM_INT_ADDR);
 
@@ -1470,8 +1464,6 @@ static int imx_hdmi_fb_registered(struct imx_hdmi *hdmi)
 	/* Unmute interrupts */
 	hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_HPD, HDMI_IH_MUTE_PHY_STAT0);
 
-	clk_disable_unprepare(hdmi->iahb_clk);
-
 	return 0;
 }
 
-- 
1.7.4.4
