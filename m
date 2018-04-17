From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 17 Apr 2018 17:30:35 -0400
Subject: [net-next PATCH v4 06/13] net: netcp: ethss: use rgmii link status
 for 2u cpsw hardware
In-Reply-To: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
References: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1524000642-23944-7-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce rgmii link status to handle link state events for 2u
cpsw hardware on K2G.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/net/ethernet/ti/netcp_ethss.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 68b10b5..83acb72 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -171,6 +171,11 @@
 #define	GBE_RXHOOK_ORDER			0
 #define GBE_DEFAULT_ALE_AGEOUT			30
 #define SLAVE_LINK_IS_XGMII(s) ((s)->link_interface >= XGMII_LINK_MAC_PHY)
+#define SLAVE_LINK_IS_RGMII(s) \
+	(((s)->link_interface >= RGMII_LINK_MAC_PHY) && \
+	 ((s)->link_interface <= RGMII_LINK_MAC_PHY_NO_MDIO))
+#define SLAVE_LINK_IS_SGMII(s) \
+	((s)->link_interface <= SGMII_LINK_MAC_PHY_NO_MDIO)
 #define NETCP_LINK_STATE_INVALID		-1
 
 #define GBE_SET_REG_OFS(p, rb, rn) p->rb##_ofs.rn = \
@@ -554,6 +559,7 @@ struct gbe_ss_regs {
 struct gbe_ss_regs_ofs {
 	u16	id_ver;
 	u16	control;
+	u16	rgmii_status; /* 2U */
 };
 
 struct gbe_switch_regs {
@@ -2122,23 +2128,35 @@ static bool gbe_phy_link_status(struct gbe_slave *slave)
 	 return !slave->phy || slave->phy->link;
 }
 
+#define RGMII_REG_STATUS_LINK	BIT(0)
+
+static void netcp_2u_rgmii_get_port_link(struct gbe_priv *gbe_dev, bool *status)
+{
+	u32 val = 0;
+
+	val = readl(GBE_REG_ADDR(gbe_dev, ss_regs, rgmii_status));
+	*status = !!(val & RGMII_REG_STATUS_LINK);
+}
+
 static void netcp_ethss_update_link_state(struct gbe_priv *gbe_dev,
 					  struct gbe_slave *slave,
 					  struct net_device *ndev)
 {
-	int sp = slave->slave_num;
-	int phy_link_state, sgmii_link_state = 1, link_state;
+	bool sw_link_state = true, phy_link_state;
+	int sp = slave->slave_num, link_state;
 
 	if (!slave->open)
 		return;
 
-	if (!SLAVE_LINK_IS_XGMII(slave)) {
-		sgmii_link_state =
-			netcp_sgmii_get_port_link(SGMII_BASE(gbe_dev, sp), sp);
-	}
+	if (SLAVE_LINK_IS_RGMII(slave))
+		netcp_2u_rgmii_get_port_link(gbe_dev,
+					     &sw_link_state);
+	if (SLAVE_LINK_IS_SGMII(slave))
+		sw_link_state =
+		netcp_sgmii_get_port_link(SGMII_BASE(gbe_dev, sp), sp);
 
 	phy_link_state = gbe_phy_link_status(slave);
-	link_state = phy_link_state & sgmii_link_state;
+	link_state = phy_link_state & sw_link_state;
 
 	if (atomic_xchg(&slave->link_state, link_state) != link_state)
 		netcp_ethss_link_state_action(gbe_dev, ndev, slave,
@@ -3437,6 +3455,8 @@ static int set_gbenu_ethss_priv(struct gbe_priv *gbe_dev,
 
 	/* Subsystem registers */
 	GBENU_SET_REG_OFS(gbe_dev, ss_regs, id_ver);
+	/* ok to set for MU, but used by 2U only */
+	GBENU_SET_REG_OFS(gbe_dev, ss_regs, rgmii_status);
 
 	/* Switch module registers */
 	GBENU_SET_REG_OFS(gbe_dev, switch_regs, id_ver);
-- 
1.9.1
