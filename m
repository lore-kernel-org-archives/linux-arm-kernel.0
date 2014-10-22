From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 22 Oct 2014 20:26:46 +0200
Subject: [PATCH v2 3/9] net: pxa168_eth: Prepare proper libphy handling
In-Reply-To: <1414002412-13615-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1414002412-13615-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1414002412-13615-4-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current libphy handling in pxa168_eth lacks proper phy_connect. Prepare
to fix this by first moving phy properties from platform_data to private
driver data.

Tested-by: Antoine T?nart <antoine.tenart@free-electrons.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Changelog:
v1->v2:
- get phy-connection-type from controller node instead of PHY node
  (Reported by Sergei Shtylyov)

Cc: "David S. Miller" <davem@davemloft.net>
Cc: "Antoine T?nart" <antoine.tenart@free-electrons.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: netdev at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/net/ethernet/marvell/pxa168_eth.c | 38 +++++++++++++++++++------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/marvell/pxa168_eth.c b/drivers/net/ethernet/marvell/pxa168_eth.c
index c3b209cd0660..3918887e09c5 100644
--- a/drivers/net/ethernet/marvell/pxa168_eth.c
+++ b/drivers/net/ethernet/marvell/pxa168_eth.c
@@ -197,6 +197,9 @@ struct tx_desc {
 struct pxa168_eth_private {
 	int port_num;		/* User Ethernet port number    */
 	int phy_addr;
+	int phy_speed;
+	int phy_duplex;
+	phy_interface_t phy_intf;
 
 	int rx_resource_err;	/* Rx ring resource error flag */
 
@@ -1394,19 +1397,17 @@ static void phy_init(struct pxa168_eth_private *pep)
 {
 	struct phy_device *phy = pep->phy;
 
-	phy_attach(pep->dev, dev_name(&phy->dev), PHY_INTERFACE_MODE_MII);
+	phy_attach(pep->dev, dev_name(&phy->dev), pep->phy_intf);
 
-	if (pep->pd && pep->pd->speed != 0) {
+	phy->speed = pep->phy_speed;
+	phy->duplex = pep->phy_duplex;
+	phy->autoneg = AUTONEG_ENABLE;
+	phy->supported &= PHY_BASIC_FEATURES;
+	phy->advertising = phy->supported | ADVERTISED_Autoneg;
+
+	if (pep->phy_speed != 0) {
 		phy->autoneg = AUTONEG_DISABLE;
 		phy->advertising = 0;
-		phy->speed = pep->pd->speed;
-		phy->duplex = pep->pd->duplex;
-	} else {
-		phy->autoneg = AUTONEG_ENABLE;
-		phy->speed = 0;
-		phy->duplex = 0;
-		phy->supported &= PHY_BASIC_FEATURES;
-		phy->advertising = phy->supported | ADVERTISED_Autoneg;
 	}
 
 	phy_start_aneg(phy);
@@ -1416,9 +1417,6 @@ static int ethernet_phy_setup(struct net_device *dev)
 {
 	struct pxa168_eth_private *pep = netdev_priv(dev);
 
-	if (pep->pd && pep->pd->init)
-		pep->pd->init();
-
 	pep->phy = phy_scan(pep, pep->phy_addr & 0x1f);
 	if (pep->phy != NULL)
 		phy_init(pep);
@@ -1552,13 +1550,23 @@ static int pxa168_eth_probe(struct platform_device *pdev)
 
 		pep->port_num = pep->pd->port_number;
 		pep->phy_addr = pep->pd->phy_addr;
+		pep->phy_speed = pep->pd->speed;
+		pep->phy_duplex = pep->pd->duplex;
+		pep->phy_intf = pep->pd->intf;
+
+		if (pep->pd->init)
+			pep->pd->init();
 	} else if (pdev->dev.of_node) {
 		of_property_read_u32(pdev->dev.of_node, "port-id",
 				     &pep->port_num);
 
 		np = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
-		if (np)
-			of_property_read_u32(np, "reg", &pep->phy_addr);
+		if (!np) {
+			dev_err(&pdev->dev, "missing phy-handle\n");
+			return -EINVAL;
+		}
+		of_property_read_u32(np, "reg", &pep->phy_addr);
+		pep->phy_intf = of_get_phy_mode(pdev->dev.of_node);
 	}
 
 	/* Hardware supports only 3 ports */
-- 
2.1.1
