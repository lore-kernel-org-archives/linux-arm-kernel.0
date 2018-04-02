From: m-karicheri2@ti.com (Murali Karicheri)
Date: Mon, 2 Apr 2018 10:37:57 -0400
Subject: [net-next PATCH v3 07/11] net: netcp: ethss: map vlan priorities to
 zero flow
In-Reply-To: <1522679881-25643-1-git-send-email-m-karicheri2@ti.com>
References: <1522679881-25643-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1522679881-25643-8-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver currently support only vlan priority zero. So map the
vlan priorities to zero flow in hardware.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/net/ethernet/ti/netcp_ethss.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index ab6c918..33d70d4 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -600,6 +600,7 @@ struct gbe_port_regs {
 struct gbe_port_regs_ofs {
 	u16	port_vlan;
 	u16	tx_pri_map;
+	u16     rx_pri_map;
 	u16	sa_lo;
 	u16	sa_hi;
 	u16	ts_ctl;
@@ -2300,6 +2301,13 @@ static int gbe_slave_open(struct gbe_intf *gbe_intf)
 	gbe_sgmii_rtreset(priv, slave, false);
 	gbe_port_config(priv, slave, priv->rx_packet_max);
 	gbe_set_slave_mac(slave, gbe_intf);
+	/* For NU & 2U switch, map the vlan priorities to zero
+	 * as we only configure to use priority 0
+	 */
+	if (IS_SS_ID_MU(priv))
+		writel(HOST_TX_PRI_MAP_DEFAULT,
+		       GBE_REG_ADDR(slave, port_regs, rx_pri_map));
+
 	/* enable forwarding */
 	cpsw_ale_control_set(priv->ale, slave->port_num,
 			     ALE_PORT_STATE, ALE_PORT_STATE_FORWARD);
@@ -3001,6 +3009,7 @@ static int init_slave(struct gbe_priv *gbe_dev, struct gbe_slave *slave,
 		/* Initialize  slave port register offsets */
 		GBENU_SET_REG_OFS(slave, port_regs, port_vlan);
 		GBENU_SET_REG_OFS(slave, port_regs, tx_pri_map);
+		GBENU_SET_REG_OFS(slave, port_regs, rx_pri_map);
 		GBENU_SET_REG_OFS(slave, port_regs, sa_lo);
 		GBENU_SET_REG_OFS(slave, port_regs, sa_hi);
 		GBENU_SET_REG_OFS(slave, port_regs, ts_ctl);
-- 
1.9.1
