From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Fri, 16 Feb 2018 13:09:55 +0100
Subject: [PATCH v3 5/6] phy: rockchip-typec: support DP phy switch
In-Reply-To: <20180216120956.19034-1-enric.balletbo@collabora.com>
References: <20180216120956.19034-1-enric.balletbo@collabora.com>
Message-ID: <20180216120956.19034-5-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Zhong <zyw@rock-chips.com>

There are 2 Type-c PHYs in RK3399, but only one DP controller. Hence
only one PHY can connect to DP controller at one time, the other should
be disconnected. The GRF_SOC_CON26 register has a switch bit to do it,
set this bit means enable PHY 1, clear this bit means enable PHY 0.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes since v2:
- None.
Changes since v1:
- This patch is new on these series but as a consequence of the work
  done need to be reworked. The patch was send some time ago [1] but
  got stuck, so it's also and attempt to revive it.

[1] https://lkml.org/lkml/2017/2/10/74

 drivers/phy/rockchip/phy-rockchip-typec.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index 9bc4d4bd46d3..1c79785a5439 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -364,6 +364,7 @@ struct usb3phy_reg {
  * @pipe_status: the register of type-c phy pipe status.
  * @usb3_host_disable: the register of type-c usb3 host disable.
  * @usb3_host_port: the register of type-c usb3 host port.
+ * @uphy_dp_sel: the register of type-c phy DP select control.
  */
 struct rockchip_usb3phy_port_cfg {
 	unsigned int reg;
@@ -373,6 +374,7 @@ struct rockchip_usb3phy_port_cfg {
 	struct usb3phy_reg pipe_status;
 	struct usb3phy_reg usb3_host_disable;
 	struct usb3phy_reg usb3_host_port;
+	struct usb3phy_reg uphy_dp_sel;
 };
 
 struct rockchip_typec_phy {
@@ -446,6 +448,7 @@ static const struct rockchip_usb3phy_port_cfg rk3399_usb3phy_port_cfgs[] = {
 		.pipe_status	= { 0xe5c0, 0, 0 },
 		.usb3_host_disable = { 0x2434, 0, 16 },
 		.usb3_host_port = { 0x2434, 12, 28 },
+		.uphy_dp_sel	= { 0x6268, 19, 19 },
 	},
 	{
 		.reg = 0xff800000,
@@ -455,6 +458,7 @@ static const struct rockchip_usb3phy_port_cfg rk3399_usb3phy_port_cfgs[] = {
 		.pipe_status	= { 0xe5c0, 16, 16 },
 		.usb3_host_disable = { 0x2444, 0, 16 },
 		.usb3_host_port = { 0x2444, 12, 28 },
+		.uphy_dp_sel	= { 0x6268, 3, 19 },
 	},
 	{ /* sentinel */ }
 };
@@ -856,7 +860,7 @@ static int tcphy_get_mode(struct rockchip_typec_phy *tcphy)
 static int tcphy_cfg_usb3_to_usb2_only(struct rockchip_typec_phy *tcphy,
 				       bool value)
 {
-	struct rockchip_usb3phy_port_cfg *cfg = tcphy->port_cfgs;
+	const struct rockchip_usb3phy_port_cfg *cfg = tcphy->port_cfgs;
 
 	property_enable(tcphy, &cfg->usb3tousb2_en, value);
 	property_enable(tcphy, &cfg->usb3_host_disable, value);
@@ -947,6 +951,7 @@ static const struct phy_ops rockchip_usb3_phy_ops = {
 static int rockchip_dp_phy_power_on(struct phy *phy)
 {
 	struct rockchip_typec_phy *tcphy = phy_get_drvdata(phy);
+	const struct rockchip_usb3phy_port_cfg *cfg = tcphy->port_cfgs;
 	int new_mode, ret = 0;
 	u32 val;
 
@@ -979,6 +984,8 @@ static int rockchip_dp_phy_power_on(struct phy *phy)
 	if (ret)
 		goto unlock_ret;
 
+	property_enable(tcphy, &cfg->uphy_dp_sel, 1);
+
 	ret = readx_poll_timeout(readl, tcphy->base + DP_MODE_CTL,
 				 val, val & DP_MODE_A2, 1000,
 				 PHY_MODE_SET_TIMEOUT);
-- 
2.15.1
