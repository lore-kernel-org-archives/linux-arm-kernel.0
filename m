From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 27 Dec 2017 23:14:42 +0100
Subject: [PATCH net-next 2/6] phy: cp110-comphy: 2.5G SGMII mode
In-Reply-To: <20171227221446.18459-1-antoine.tenart@free-electrons.com>
References: <20171227221446.18459-1-antoine.tenart@free-electrons.com>
Message-ID: <20171227221446.18459-3-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allow the CP100 comphy to configure some lanes in the
2.5G SGMII mode. This mode is quite close to SGMII and uses nearly the
same code path.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
index a0d522154cdf..946a6ed7b66f 100644
--- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
@@ -135,19 +135,25 @@ struct mvebu_comhy_conf {
 static const struct mvebu_comhy_conf mvebu_comphy_cp110_modes[] = {
 	/* lane 0 */
 	MVEBU_COMPHY_CONF(0, 1, PHY_MODE_SGMII, 0x1),
+	MVEBU_COMPHY_CONF(0, 1, PHY_MODE_SGMII_2_5G, 0x1),
 	/* lane 1 */
 	MVEBU_COMPHY_CONF(1, 2, PHY_MODE_SGMII, 0x1),
+	MVEBU_COMPHY_CONF(1, 2, PHY_MODE_SGMII_2_5G, 0x1),
 	/* lane 2 */
 	MVEBU_COMPHY_CONF(2, 0, PHY_MODE_SGMII, 0x1),
+	MVEBU_COMPHY_CONF(2, 0, PHY_MODE_SGMII_2_5G, 0x1),
 	MVEBU_COMPHY_CONF(2, 0, PHY_MODE_10GKR, 0x1),
 	/* lane 3 */
 	MVEBU_COMPHY_CONF(3, 1, PHY_MODE_SGMII, 0x2),
+	MVEBU_COMPHY_CONF(3, 1, PHY_MODE_SGMII_2_5G, 0x2),
 	/* lane 4 */
 	MVEBU_COMPHY_CONF(4, 0, PHY_MODE_SGMII, 0x2),
+	MVEBU_COMPHY_CONF(4, 0, PHY_MODE_SGMII_2_5G, 0x2),
 	MVEBU_COMPHY_CONF(4, 0, PHY_MODE_10GKR, 0x2),
 	MVEBU_COMPHY_CONF(4, 1, PHY_MODE_SGMII, 0x1),
 	/* lane 5 */
 	MVEBU_COMPHY_CONF(5, 2, PHY_MODE_SGMII, 0x1),
+	MVEBU_COMPHY_CONF(5, 2, PHY_MODE_SGMII_2_5G, 0x1),
 };
 
 struct mvebu_comphy_priv {
@@ -206,6 +212,10 @@ static void mvebu_comphy_ethernet_init_reset(struct mvebu_comphy_lane *lane,
 	if (mode == PHY_MODE_10GKR)
 		val |= MVEBU_COMPHY_SERDES_CFG0_GEN_RX(0xe) |
 		       MVEBU_COMPHY_SERDES_CFG0_GEN_TX(0xe);
+	else if (mode == PHY_MODE_SGMII_2_5G)
+		val |= MVEBU_COMPHY_SERDES_CFG0_GEN_RX(0x8) |
+		       MVEBU_COMPHY_SERDES_CFG0_GEN_TX(0x8) |
+		       MVEBU_COMPHY_SERDES_CFG0_HALF_BUS;
 	else if (mode == PHY_MODE_SGMII)
 		val |= MVEBU_COMPHY_SERDES_CFG0_GEN_RX(0x6) |
 		       MVEBU_COMPHY_SERDES_CFG0_GEN_TX(0x6) |
@@ -296,13 +306,13 @@ static int mvebu_comphy_init_plls(struct mvebu_comphy_lane *lane,
 	return 0;
 }
 
-static int mvebu_comphy_set_mode_sgmii(struct phy *phy)
+static int mvebu_comphy_set_mode_sgmii(struct phy *phy, enum phy_mode mode)
 {
 	struct mvebu_comphy_lane *lane = phy_get_drvdata(phy);
 	struct mvebu_comphy_priv *priv = lane->priv;
 	u32 val;
 
-	mvebu_comphy_ethernet_init_reset(lane, PHY_MODE_SGMII);
+	mvebu_comphy_ethernet_init_reset(lane, mode);
 
 	val = readl(priv->base + MVEBU_COMPHY_RX_CTRL1(lane->id));
 	val &= ~MVEBU_COMPHY_RX_CTRL1_CLK8T_EN;
@@ -487,7 +497,8 @@ static int mvebu_comphy_power_on(struct phy *phy)
 
 	switch (lane->mode) {
 	case PHY_MODE_SGMII:
-		ret = mvebu_comphy_set_mode_sgmii(phy);
+	case PHY_MODE_SGMII_2_5G:
+		ret = mvebu_comphy_set_mode_sgmii(phy, lane->mode);
 		break;
 	case PHY_MODE_10GKR:
 		ret = mvebu_comphy_set_mode_10gkr(phy);
-- 
2.14.3
