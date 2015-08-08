From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 08 Aug 2015 17:04:05 +0100
Subject: [PATCH 09/12] drm: bridge/dw_hdmi: rename dw_hdmi_phy_enable_power()
In-Reply-To: <20150808160251.GM7557@n2100.arm.linux.org.uk>
References: <20150808160251.GM7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZO6bN-0002uc-UE@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dw_hdmi_phy_enable_power() is not about enabling and disabling power.
It is about allowing or preventing power-down mode being entered - the
register is documented as "Power-down enable (active low 0b)."

This can be seen as the bit has no effect when the HDMI phy is
operational on iMX6 hardware.

Rename the function to dw_hdmi_phy_enable_powerdown() to reflect the
documentation, make it take a bool for the 'enable' argument, and invert
the value to be written.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/dw_hdmi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index fbac8386552b..7b8a4e942a71 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -737,9 +737,9 @@ static int hdmi_phy_i2c_write(struct dw_hdmi *hdmi, unsigned short data,
 	return 0;
 }
 
-static void dw_hdmi_phy_enable_power(struct dw_hdmi *hdmi, u8 enable)
+static void dw_hdmi_phy_enable_powerdown(struct dw_hdmi *hdmi, bool enable)
 {
-	hdmi_mask_writeb(hdmi, enable, HDMI_PHY_CONF0,
+	hdmi_mask_writeb(hdmi, !enable, HDMI_PHY_CONF0,
 			 HDMI_PHY_CONF0_PDZ_OFFSET,
 			 HDMI_PHY_CONF0_PDZ_MASK);
 }
@@ -879,7 +879,7 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi, unsigned char prep,
 	/* REMOVE CLK TERM */
 	hdmi_phy_i2c_write(hdmi, 0x8000, 0x05);  /* CKCALCTRL */
 
-	dw_hdmi_phy_enable_power(hdmi, 1);
+	dw_hdmi_phy_enable_powerdown(hdmi, false);
 
 	/* toggle TMDS enable */
 	dw_hdmi_phy_enable_tmds(hdmi, 0);
@@ -924,7 +924,7 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi)
 		dw_hdmi_phy_sel_data_en_pol(hdmi, 1);
 		dw_hdmi_phy_sel_interface_control(hdmi, 0);
 		dw_hdmi_phy_enable_tmds(hdmi, 0);
-		dw_hdmi_phy_enable_power(hdmi, 0);
+		dw_hdmi_phy_enable_powerdown(hdmi, true);
 
 		/* Enable CSC */
 		ret = hdmi_phy_configure(hdmi, 0, 8, cscon);
@@ -1155,7 +1155,7 @@ static void dw_hdmi_phy_disable(struct dw_hdmi *hdmi)
 		return;
 
 	dw_hdmi_phy_enable_tmds(hdmi, 0);
-	dw_hdmi_phy_enable_power(hdmi, 0);
+	dw_hdmi_phy_enable_powerdown(hdmi, true);
 
 	hdmi->phy_enabled = false;
 }
-- 
2.1.0
