From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 27 Mar 2018 12:31:43 -0400
Subject: [net-next PATCH v2 04/10] net: netcp: ethss: add support for handling
 sgmii link interface
In-Reply-To: <1522168309-12338-1-git-send-email-m-karicheri2@ti.com>
References: <1522168309-12338-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1522168309-12338-5-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2u cpsw hardware on K2G uses sgmii link to interface with Phy. So add
support for this interface in the code so that drover can be re-used
for 2u hardware.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/net/ethernet/ti/netcp.h       |  2 ++
 drivers/net/ethernet/ti/netcp_ethss.c | 18 ++++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/netcp.h b/drivers/net/ethernet/ti/netcp.h
index 8900a6f..416f732 100644
--- a/drivers/net/ethernet/ti/netcp.h
+++ b/drivers/net/ethernet/ti/netcp.h
@@ -33,6 +33,8 @@
 #define SGMII_LINK_MAC_MAC_FORCED	2
 #define SGMII_LINK_MAC_FIBER		3
 #define SGMII_LINK_MAC_PHY_NO_MDIO	4
+#define RGMII_LINK_MAC_PHY		5
+#define RGMII_LINK_MAC_PHY_NO_MDIO	7
 #define XGMII_LINK_MAC_PHY		10
 #define XGMII_LINK_MAC_MAC_FORCED	11
 
diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 1dea891..ab9d369 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -166,6 +166,9 @@
 #define	GBE_RXHOOK_ORDER			0
 #define GBE_DEFAULT_ALE_AGEOUT			30
 #define SLAVE_LINK_IS_XGMII(s) ((s)->link_interface >= XGMII_LINK_MAC_PHY)
+#define SLAVE_LINK_IS_RGMII(s) \
+	(((s)->link_interface >= RGMII_LINK_MAC_PHY) && \
+	 ((s)->link_interface <= RGMII_LINK_MAC_PHY_NO_MDIO))
 #define NETCP_LINK_STATE_INVALID		-1
 
 #define GBE_SET_REG_OFS(p, rb, rn) p->rb##_ofs.rn = \
@@ -2091,8 +2094,9 @@ static void netcp_ethss_link_state_action(struct gbe_priv *gbe_dev,
 				     ALE_PORT_STATE_FORWARD);
 
 		if (ndev && slave->open &&
-		    slave->link_interface != SGMII_LINK_MAC_PHY &&
-		    slave->link_interface != XGMII_LINK_MAC_PHY)
+		    ((slave->link_interface != SGMII_LINK_MAC_PHY) &&
+		    (slave->link_interface != RGMII_LINK_MAC_PHY) &&
+		    (slave->link_interface != XGMII_LINK_MAC_PHY)))
 			netif_carrier_on(ndev);
 	} else {
 		writel(mac_control, GBE_REG_ADDR(slave, emac_regs,
@@ -2101,8 +2105,9 @@ static void netcp_ethss_link_state_action(struct gbe_priv *gbe_dev,
 				     ALE_PORT_STATE,
 				     ALE_PORT_STATE_DISABLE);
 		if (ndev &&
-		    slave->link_interface != SGMII_LINK_MAC_PHY &&
-		    slave->link_interface != XGMII_LINK_MAC_PHY)
+		    ((slave->link_interface != SGMII_LINK_MAC_PHY) &&
+		    (slave->link_interface != RGMII_LINK_MAC_PHY) &&
+		    (slave->link_interface != XGMII_LINK_MAC_PHY)))
 			netif_carrier_off(ndev);
 	}
 
@@ -2914,6 +2919,7 @@ static int init_slave(struct gbe_priv *gbe_dev, struct gbe_slave *slave,
 
 	slave->open = false;
 	if ((slave->link_interface == SGMII_LINK_MAC_PHY) ||
+	    (slave->link_interface == RGMII_LINK_MAC_PHY) ||
 	    (slave->link_interface == XGMII_LINK_MAC_PHY))
 		slave->phy_node = of_parse_phandle(node, "phy-handle", 0);
 	slave->port_num = gbe_get_slave_port(gbe_dev, slave->slave_num);
@@ -3076,6 +3082,9 @@ static void init_secondary_ports(struct gbe_priv *gbe_dev,
 	if (slave->link_interface == SGMII_LINK_MAC_PHY) {
 		phy_mode = PHY_INTERFACE_MODE_SGMII;
 		slave->phy_port_t = PORT_MII;
+	} else if (slave->link_interface == RGMII_LINK_MAC_PHY) {
+		phy_mode = PHY_INTERFACE_MODE_RGMII;
+		slave->phy_port_t = PORT_MII;
 	} else {
 		phy_mode = PHY_INTERFACE_MODE_NA;
 		slave->phy_port_t = PORT_FIBRE;
@@ -3083,6 +3092,7 @@ static void init_secondary_ports(struct gbe_priv *gbe_dev,
 
 	for_each_sec_slave(slave, gbe_dev) {
 		if ((slave->link_interface != SGMII_LINK_MAC_PHY) &&
+		    (slave->link_interface != RGMII_LINK_MAC_PHY) &&
 		    (slave->link_interface != XGMII_LINK_MAC_PHY))
 			continue;
 		slave->phy =
-- 
1.9.1
