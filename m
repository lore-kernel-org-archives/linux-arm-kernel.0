From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Thu,  8 Feb 2018 16:20:28 +0100
Subject: [PATCH 3/3] phy: rockchip-typec: force to USB2 if DP at 4 lanes mode
In-Reply-To: <20180208152028.9997-1-enric.balletbo@collabora.com>
References: <20180208152028.9997-1-enric.balletbo@collabora.com>
Message-ID: <20180208152028.9997-3-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Zhong <zyw@rock-chips.com>

The usb3tousb2_en BIT will be clear to 0 in probe(), it make USB
controller work at USB3 mode, and if the USB phy is turned on with DP
only mode(4 lanes DP), the rockchip_usb3_phy_power_on() will return
directly, so usb3_host_disable and usb3_host_port these 2 BIT will keep
a same value as coreboot. In coreboot, these 3 BITs are set as USB2
mode, but now one of the bits is changed to USB3, it make USB controller
work at a unknown status.

These 3 BITs should be changed to USB2, if the Type-C works at 4 lanes
mode, and then switch it back to USB3 mode, when USB disconnect.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-typec.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index cc07f528cc48..087c754caf25 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -821,6 +821,18 @@ static int tcphy_get_mode(struct rockchip_typec_phy *tcphy)
 	return mode;
 }
 
+static int tcphy_cfg_usb3_to_usb2_only(struct rockchip_typec_phy *tcphy,
+				       bool value)
+{
+	struct rockchip_usb3phy_port_cfg *cfg = &tcphy->port_cfgs;
+
+	property_enable(tcphy, &cfg->usb3tousb2_en, value);
+	property_enable(tcphy, &cfg->usb3_host_disable, value);
+	property_enable(tcphy, &cfg->usb3_host_port, !value);
+
+	return 0;
+}
+
 static int rockchip_usb3_phy_power_on(struct phy *phy)
 {
 	struct rockchip_typec_phy *tcphy = phy_get_drvdata(phy);
@@ -838,8 +850,10 @@ static int rockchip_usb3_phy_power_on(struct phy *phy)
 	}
 
 	/* DP-only mode; fall back to USB2 */
-	if (!(new_mode & (MODE_DFP_USB | MODE_UFP_USB)))
+	if (!(new_mode & (MODE_DFP_USB | MODE_UFP_USB))) {
+		tcphy_cfg_usb3_to_usb2_only(tcphy, true);
 		goto unlock_ret;
+	}
 
 	if (tcphy->mode == new_mode)
 		goto unlock_ret;
@@ -855,9 +869,9 @@ static int rockchip_usb3_phy_power_on(struct phy *phy)
 		regmap_read(tcphy->grf_regs, reg->offset, &val);
 		if (!(val & BIT(reg->enable_bit))) {
 			tcphy->mode |= new_mode & (MODE_DFP_USB | MODE_UFP_USB);
+
 			/* enable usb3 host */
-			property_enable(tcphy, &cfg->usb3_host_disable, 0);
-			property_enable(tcphy, &cfg->usb3_host_port, 1);
+			tcphy_cfg_usb3_to_usb2_only(tcphy, false);
 			goto unlock_ret;
 		}
 		usleep_range(10, 20);
@@ -878,6 +892,7 @@ static int rockchip_usb3_phy_power_off(struct phy *phy)
 	struct rockchip_typec_phy *tcphy = phy_get_drvdata(phy);
 
 	mutex_lock(&tcphy->lock);
+	tcphy_cfg_usb3_to_usb2_only(tcphy, false);
 
 	if (tcphy->mode == MODE_DISCONNECT)
 		goto unlock;
-- 
2.15.1
