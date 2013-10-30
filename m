From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 30 Oct 2013 20:43:09 +0000
Subject: [PATCH 4/6] imx-drm: hdmi: get rid of pointless fb_reg
In-Reply-To: <20131030193622.GN16735@n2100.arm.linux.org.uk>
References: <20131030193622.GN16735@n2100.arm.linux.org.uk>
Message-ID: <E1Vbcbd-00062i-EX@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fb_reg provides no real benefit to the driver: imx_hdmi_fb_registered()
will never be called multiple times.  Let's get rid of this.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-hdmi.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index 0cba5d4a9966..267d3c9114c6 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -130,7 +130,6 @@ struct imx_hdmi {
 	int vic;
 
 	u8 edid[HDMI_EDID_LEN];
-	bool fb_reg;
 	bool cable_plugin;
 
 	bool phy_enabled;
@@ -1451,9 +1450,6 @@ static int imx_hdmi_fb_registered(struct imx_hdmi *hdmi)
 {
 	int ret;
 
-	if (hdmi->fb_reg)
-		return 0;
-
 	ret = clk_prepare_enable(hdmi->iahb_clk);
 	if (ret)
 		return ret;
@@ -1474,8 +1470,6 @@ static int imx_hdmi_fb_registered(struct imx_hdmi *hdmi)
 	/* Unmute interrupts */
 	hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_HPD, HDMI_IH_MUTE_PHY_STAT0);
 
-	hdmi->fb_reg = true;
-
 	clk_disable_unprepare(hdmi->iahb_clk);
 
 	return 0;
-- 
1.7.4.4
