From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 27 Mar 2018 12:31:42 -0400
Subject: [net-next PATCH v2 03/10] net: netcp: ethss: make call to
 gbe_sgmii_config() conditional
In-Reply-To: <1522168309-12338-1-git-send-email-m-karicheri2@ti.com>
References: <1522168309-12338-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1522168309-12338-4-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a preparatory patch to add support for 2u cpsw hardware found on
K2G SoC, make call to gbe_sgmii_config() conditional. This is required
since 2u uses RGMII interface instead of SGMII and to allow for driver
re-use.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/net/ethernet/ti/netcp_ethss.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 56dbc0b..1dea891 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -2271,7 +2271,8 @@ static int gbe_slave_open(struct gbe_intf *gbe_intf)
 
 	void (*hndlr)(struct net_device *) = gbe_adjust_link;
 
-	gbe_sgmii_config(priv, slave);
+	if ((priv->ss_version == GBE_SS_VERSION_14) || IS_SS_ID_NU(priv))
+		gbe_sgmii_config(priv, slave);
 	gbe_port_reset(slave);
 	gbe_sgmii_rtreset(priv, slave, false);
 	gbe_port_config(priv, slave, priv->rx_packet_max);
@@ -3039,7 +3040,9 @@ static void init_secondary_ports(struct gbe_priv *gbe_dev,
 			continue;
 		}
 
-		gbe_sgmii_config(gbe_dev, slave);
+		if ((gbe_dev->ss_version == GBE_SS_VERSION_14) ||
+		    IS_SS_ID_NU(gbe_dev))
+			gbe_sgmii_config(gbe_dev, slave);
 		gbe_port_reset(slave);
 		gbe_port_config(gbe_dev, slave, gbe_dev->rx_packet_max);
 		list_add_tail(&slave->slave_list, &gbe_dev->secondary_slaves);
-- 
1.9.1
