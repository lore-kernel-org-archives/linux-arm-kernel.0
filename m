From: heiko@sntech.de (Heiko Stuebner)
Date: Mon,  5 Feb 2018 15:34:30 +0100
Subject: [PATCH 4/9] drm/bridge: dw-hdmi: export hotplug functions
In-Reply-To: <20180205143435.4723-1-heiko@sntech.de>
References: <20180205143435.4723-1-heiko@sntech.de>
Message-ID: <20180205143435.4723-5-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Algea Cao <algea.cao@rock-chips.com>

External phys may not provide their own hotplug-related
routines but instead rely on the dw-hdmi ones.
Export these functions so that external hdmi-phys can
use them if necessary.

Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
[export all 3 hotplug-related functions]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 11 +++++++----
 include/drm/bridge/dw_hdmi.h              |  6 +++++-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 7255fafce089..2760e1b51422 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1251,14 +1251,15 @@ static void dw_hdmi_phy_disable(struct dw_hdmi *hdmi, void *data)
 	dw_hdmi_phy_power_off(hdmi);
 }
 
-static enum drm_connector_status dw_hdmi_phy_read_hpd(struct dw_hdmi *hdmi,
-						      void *data)
+enum drm_connector_status dw_hdmi_phy_read_hpd(struct dw_hdmi *hdmi,
+					       void *data)
 {
 	return hdmi_readb(hdmi, HDMI_PHY_STAT0) & HDMI_PHY_HPD ?
 		connector_status_connected : connector_status_disconnected;
 }
+EXPORT_SYMBOL_GPL(dw_hdmi_phy_read_hpd);
 
-static void dw_hdmi_phy_update_hpd(struct dw_hdmi *hdmi, void *data,
+void dw_hdmi_phy_update_hpd(struct dw_hdmi *hdmi, void *data,
 				   bool force, bool disabled, bool rxsense)
 {
 	u8 old_mask = hdmi->phy_mask;
@@ -1271,8 +1272,9 @@ static void dw_hdmi_phy_update_hpd(struct dw_hdmi *hdmi, void *data,
 	if (old_mask != hdmi->phy_mask)
 		hdmi_writeb(hdmi, hdmi->phy_mask, HDMI_PHY_MASK0);
 }
+EXPORT_SYMBOL_GPL(dw_hdmi_phy_update_hpd);
 
-static void dw_hdmi_phy_setup_hpd(struct dw_hdmi *hdmi, void *data)
+void dw_hdmi_phy_setup_hpd(struct dw_hdmi *hdmi, void *data)
 {
 	/*
 	 * Configure the PHY RX SENSE and HPD interrupts polarities and clear
@@ -1291,6 +1293,7 @@ static void dw_hdmi_phy_setup_hpd(struct dw_hdmi *hdmi, void *data)
 	hdmi_writeb(hdmi, ~(HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE),
 		    HDMI_IH_MUTE_PHY_STAT0);
 }
+EXPORT_SYMBOL_GPL(dw_hdmi_phy_setup_hpd);
 
 static const struct dw_hdmi_phy_ops dw_hdmi_synopsys_phy_ops = {
 	.init = dw_hdmi_phy_init,
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index c5bc2804b29e..d9d7c75b3bfb 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -152,7 +152,11 @@ int dw_hdmi_bind(struct platform_device *pdev, struct drm_encoder *encoder,
 		 const struct dw_hdmi_plat_data *plat_data);
 
 void dw_hdmi_setup_rx_sense(struct device *dev, bool hpd, bool rx_sense);
-
+enum drm_connector_status dw_hdmi_phy_read_hpd(struct dw_hdmi *hdmi,
+					       void *data);
+void dw_hdmi_phy_update_hpd(struct dw_hdmi *hdmi, void *data,
+				   bool force, bool disabled, bool rxsense);
+void dw_hdmi_phy_setup_hpd(struct dw_hdmi *hdmi, void *data);
 void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);
 void dw_hdmi_audio_enable(struct dw_hdmi *hdmi);
 void dw_hdmi_audio_disable(struct dw_hdmi *hdmi);
-- 
2.15.1
