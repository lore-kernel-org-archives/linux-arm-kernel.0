From: heiko@sntech.de (Heiko Stuebner)
Date: Mon,  5 Feb 2018 15:34:29 +0100
Subject: [PATCH 3/9] drm/bridge: dw-hdmi: allow overriding of phy-type reading
In-Reply-To: <20180205143435.4723-1-heiko@sntech.de>
References: <20180205143435.4723-1-heiko@sntech.de>
Message-ID: <20180205143435.4723-4-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some IP implementations the reading of the phy-type may be broken.
One example are the Rockchip rk3228 and rk3328 socs that use a separate
phy from Innosilicon but still report the HDMI20_TX type.

So allow the glue driver to force a specific type, like the vendor-phy
for these cases.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 +++-
 include/drm/bridge/dw_hdmi.h              | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index a38db40ce990..7255fafce089 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2200,7 +2200,9 @@ static int dw_hdmi_detect_phy(struct dw_hdmi *hdmi)
 	unsigned int i;
 	u8 phy_type;
 
-	phy_type = hdmi_readb(hdmi, HDMI_CONFIG2_ID);
+	phy_type = (hdmi->plat_data->phy_force_type) ?
+				hdmi->plat_data->phy_force_type :
+				hdmi_readb(hdmi, HDMI_CONFIG2_ID);
 
 	if (phy_type == DW_HDMI_PHY_VENDOR_PHY) {
 		/* Vendor PHYs require support from the glue layer. */
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index 182f83283e24..c5bc2804b29e 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -133,6 +133,7 @@ struct dw_hdmi_plat_data {
 	const struct dw_hdmi_phy_ops *phy_ops;
 	const char *phy_name;
 	void *phy_data;
+	u8 phy_force_type;
 
 	/* Synopsys PHY support */
 	const struct dw_hdmi_mpll_config *mpll_cfg;
-- 
2.15.1
