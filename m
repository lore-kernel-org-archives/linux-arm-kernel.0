From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 22 Aug 2017 19:08:26 +0200
Subject: [PATCH net-next v2 06/10] net: mvpp2: set maximum packet size for 10G
 ports
In-Reply-To: <20170822170830.32413-1-antoine.tenart@free-electrons.com>
References: <20170822170830.32413-1-antoine.tenart@free-electrons.com>
Message-ID: <20170822170830.32413-7-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Chulski <stefanc@marvell.com>

Set maximum packet size for XLG 10G ports. Missing maximum packet size
for XLG configuration will cause kernel panic if oversized packet is
received by port.

Signed-off-by: Stefan Chulski <stefanc@marvell.com>
Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 64e0a1bae7d0..b2d2b4c9d5af 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -363,7 +363,9 @@
 #define     MVPP22_XLG_CTRL0_MAC_RESET_DIS	BIT(1)
 #define     MVPP22_XLG_CTRL0_RX_FLOW_CTRL_EN	BIT(7)
 #define     MVPP22_XLG_CTRL0_MIB_CNT_DIS	BIT(14)
-
+#define MVPP22_XLG_CTRL1_REG			0x104
+#define     MVPP22_XLG_CTRL1_FRAMESIZELIMIT	BIT(0)
+#define     MVPP22_XLG_CTRL1_FRAMESIZELIMIT_MASK	0x1fff
 #define MVPP22_XLG_CTRL3_REG			0x11c
 #define     MVPP22_XLG_CTRL3_MACMODESELECT_MASK	(7 << 13)
 #define     MVPP22_XLG_CTRL3_MACMODESELECT_GMAC	(0 << 13)
@@ -4498,6 +4500,18 @@ static inline void mvpp2_gmac_max_rx_size_set(struct mvpp2_port *port)
 	writel(val, port->base + MVPP2_GMAC_CTRL_0_REG);
 }
 
+/* Change maximum receive size of the port */
+static inline void mvpp2_xlg_max_rx_size_set(struct mvpp2_port *port)
+{
+	u32 val;
+
+	val =  readl(port->base + MVPP22_XLG_CTRL1_REG);
+	val &= ~MVPP22_XLG_CTRL1_FRAMESIZELIMIT_MASK;
+	val |= ((port->pkt_size - MVPP2_MH_SIZE) / 2) <<
+	       MVPP22_XLG_CTRL1_FRAMESIZELIMIT;
+	writel(val, port->base + MVPP22_XLG_CTRL1_REG);
+}
+
 /* Set defaults to the MVPP2 port */
 static void mvpp2_defaults_set(struct mvpp2_port *port)
 {
@@ -6076,7 +6090,13 @@ static void mvpp2_start_dev(struct mvpp2_port *port)
 	struct net_device *ndev = port->dev;
 	int i;
 
-	mvpp2_gmac_max_rx_size_set(port);
+	if (port->gop_id == 0 &&
+	    (port->phy_interface == PHY_INTERFACE_MODE_XAUI ||
+	     port->phy_interface == PHY_INTERFACE_MODE_10GKR))
+		mvpp2_xlg_max_rx_size_set(port);
+	else
+		mvpp2_gmac_max_rx_size_set(port);
+
 	mvpp2_txp_max_tx_size_set(port);
 
 	for (i = 0; i < port->nqvecs; i++)
-- 
2.13.5
