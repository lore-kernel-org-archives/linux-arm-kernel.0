From: zyw@rock-chips.com (Chris Zhong)
Date: Fri, 10 Feb 2017 15:44:14 +0800
Subject: [PATCH 4/4] drm/rockchip: cdn-dp: remove the DP phy switch
In-Reply-To: <1486712654-15431-1-git-send-email-zyw@rock-chips.com>
References: <1486712654-15431-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1486712654-15431-5-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are 2 Type-c PHYs in RK3399, but only one DP controller. Hence
only one PHY can connect to DP controller at one time, the other should
be disconnected. The GRF_SOC_CON26 register has a switch bit to do it,
set this bit means enable PHY 1, clear this bit means enable PHY 0.

If the board has 2 Type-C ports, the DP driver get the phy id from
devm_of_phy_get_by_index, and then control this switch according to
this id. But some others board only has one Type-C port, it may be PHY 0
or PHY 1. The dts node id can not tell us the correct PHY id. Hence move
this switch to PHY driver, the PHY driver can distinguish between PHY 0
and PHY 1, and then write the correct register bit.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 drivers/gpu/drm/rockchip/cdn-dp-core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 9ab67a6..d3f6e6b 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -43,8 +43,6 @@
 #define GRF_SOC_CON9		0x6224
 #define DP_SEL_VOP_LIT		BIT(12)
 #define GRF_SOC_CON26		0x6268
-#define UPHY_SEL_BIT		3
-#define UPHY_SEL_MASK		BIT(19)
 #define DPTX_HPD_SEL		(3 << 12)
 #define DPTX_HPD_DEL		(2 << 12)
 #define DPTX_HPD_SEL_MASK	(3 << 28)
@@ -403,11 +401,6 @@ static int cdn_dp_enable_phy(struct cdn_dp_device *dp, struct cdn_dp_port *port)
 	union extcon_property_value property;
 	int ret;
 
-	ret = cdn_dp_grf_write(dp, GRF_SOC_CON26,
-			       (port->id << UPHY_SEL_BIT) | UPHY_SEL_MASK);
-	if (ret)
-		return ret;
-
 	if (!port->phy_enabled) {
 		ret = phy_power_on(port->phy);
 		if (ret) {
-- 
2.6.3
