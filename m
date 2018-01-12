From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 12 Jan 2018 08:51:30 +0100
Subject: [PATCH net-next v5 4/4] net: mvpp2: 2500baseX support
In-Reply-To: <20180112075130.30890-1-antoine.tenart@free-electrons.com>
References: <20180112075130.30890-1-antoine.tenart@free-electrons.com>
Message-ID: <20180112075130.30890-5-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the 2500Base-X PHY mode support in the Marvell PPv2
driver. 2500Base-X is quite close to 1000Base-X and SGMII modes and uses
nearly the same code path.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/marvell/mvpp2.c | 49 ++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 257a6b99b4ca..38f9a79481c6 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -4502,6 +4502,7 @@ static int mvpp22_gop_init(struct mvpp2_port *port)
 		break;
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
 		mvpp22_gop_init_sgmii(port);
 		break;
 	case PHY_INTERFACE_MODE_10GKR:
@@ -4540,7 +4541,8 @@ static void mvpp22_gop_unmask_irq(struct mvpp2_port *port)
 
 	if (phy_interface_mode_is_rgmii(port->phy_interface) ||
 	    port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
-	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
+	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    port->phy_interface == PHY_INTERFACE_MODE_2500BASEX) {
 		/* Enable the GMAC link status irq for this port */
 		val = readl(port->base + MVPP22_GMAC_INT_SUM_MASK);
 		val |= MVPP22_GMAC_INT_SUM_MASK_LINK_STAT;
@@ -4571,7 +4573,8 @@ static void mvpp22_gop_mask_irq(struct mvpp2_port *port)
 
 	if (phy_interface_mode_is_rgmii(port->phy_interface) ||
 	    port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
-	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
+	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    port->phy_interface == PHY_INTERFACE_MODE_2500BASEX) {
 		val = readl(port->base + MVPP22_GMAC_INT_SUM_MASK);
 		val &= ~MVPP22_GMAC_INT_SUM_MASK_LINK_STAT;
 		writel(val, port->base + MVPP22_GMAC_INT_SUM_MASK);
@@ -4584,7 +4587,8 @@ static void mvpp22_gop_setup_irq(struct mvpp2_port *port)
 
 	if (phy_interface_mode_is_rgmii(port->phy_interface) ||
 	    port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
-	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
+	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    port->phy_interface == PHY_INTERFACE_MODE_2500BASEX) {
 		val = readl(port->base + MVPP22_GMAC_INT_MASK);
 		val |= MVPP22_GMAC_INT_MASK_LINK_STAT;
 		writel(val, port->base + MVPP22_GMAC_INT_MASK);
@@ -4599,6 +4603,16 @@ static void mvpp22_gop_setup_irq(struct mvpp2_port *port)
 	mvpp22_gop_unmask_irq(port);
 }
 
+/* Sets the PHY mode of the COMPHY (which configures the serdes lanes).
+ *
+ * The PHY mode used by the PPv2 driver comes from the network subsystem, while
+ * the one given to the COMPHY comes from the generic PHY subsystem. Hence they
+ * differ.
+ *
+ * The COMPHY configures the serdes lanes regardless of the actual use of the
+ * lanes by the physical layer. This is why configurations like
+ * "PPv2 (2500BaseX) - COMPHY (2500SGMII)" are valid.
+ */
 static int mvpp22_comphy_init(struct mvpp2_port *port)
 {
 	enum phy_mode mode;
@@ -4612,6 +4626,9 @@ static int mvpp22_comphy_init(struct mvpp2_port *port)
 	case PHY_INTERFACE_MODE_1000BASEX:
 		mode = PHY_MODE_SGMII;
 		break;
+	case PHY_INTERFACE_MODE_2500BASEX:
+		mode = PHY_MODE_2500SGMII;
+		break;
 	case PHY_INTERFACE_MODE_10GKR:
 		mode = PHY_MODE_10GKR;
 		break;
@@ -4631,7 +4648,8 @@ static void mvpp2_port_mii_gmac_configure_mode(struct mvpp2_port *port)
 	u32 val;
 
 	if (port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
-	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
+	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    port->phy_interface == PHY_INTERFACE_MODE_2500BASEX) {
 		val = readl(port->base + MVPP22_GMAC_CTRL_4_REG);
 		val |= MVPP22_CTRL4_SYNC_BYPASS_DIS | MVPP22_CTRL4_DP_CLK_SEL |
 		       MVPP22_CTRL4_QSGMII_BYPASS_ACTIVE;
@@ -4647,7 +4665,8 @@ static void mvpp2_port_mii_gmac_configure_mode(struct mvpp2_port *port)
 	}
 
 	val = readl(port->base + MVPP2_GMAC_CTRL_0_REG);
-	if (port->phy_interface == PHY_INTERFACE_MODE_1000BASEX)
+	if (port->phy_interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    port->phy_interface == PHY_INTERFACE_MODE_2500BASEX)
 		val |= MVPP2_GMAC_PORT_TYPE_MASK;
 	else
 		val &= ~MVPP2_GMAC_PORT_TYPE_MASK;
@@ -4660,7 +4679,13 @@ static void mvpp2_port_mii_gmac_configure_mode(struct mvpp2_port *port)
 	if (port->phy_interface == PHY_INTERFACE_MODE_SGMII)
 		val |= MVPP2_GMAC_IN_BAND_AUTONEG;
 
-	if (port->phy_interface == PHY_INTERFACE_MODE_1000BASEX)
+	/* Clear all fields we may want to explicitly set below */
+	val &= ~(MVPP2_GMAC_CONFIG_FULL_DUPLEX | MVPP2_GMAC_CONFIG_GMII_SPEED |
+		 MVPP2_GMAC_CONFIG_MII_SPEED | MVPP2_GMAC_AN_SPEED_EN |
+		 MVPP2_GMAC_AN_DUPLEX_EN);
+
+	if (port->phy_interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    port->phy_interface == PHY_INTERFACE_MODE_2500BASEX)
 		/* 1000BaseX port cannot negotiate speed nor can it
 		 * negotiate duplex: they are always operating with a
 		 * fixed speed of 1000Mbps in full duplex, so force
@@ -4693,7 +4718,8 @@ static void mvpp2_port_mii_gmac_configure(struct mvpp2_port *port)
 	/* Configure the PCS and in-band AN */
 	val = readl(port->base + MVPP2_GMAC_CTRL_2_REG);
 	if (port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
-	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
+	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    port->phy_interface == PHY_INTERFACE_MODE_2500BASEX) {
 	        val |= MVPP2_GMAC_INBAND_AN_MASK | MVPP2_GMAC_PCS_ENABLE_MASK;
 	} else if (phy_interface_mode_is_rgmii(port->phy_interface)) {
 		val &= ~MVPP2_GMAC_PCS_ENABLE_MASK;
@@ -4756,7 +4782,8 @@ static void mvpp2_port_mii_set(struct mvpp2_port *port)
 
 	if (phy_interface_mode_is_rgmii(port->phy_interface) ||
 	    port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
-	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX)
+	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    port->phy_interface == PHY_INTERFACE_MODE_2500BASEX)
 		mvpp2_port_mii_gmac_configure(port);
 	else if (port->phy_interface == PHY_INTERFACE_MODE_10GKR)
 		mvpp2_port_mii_xlg_configure(port);
@@ -4834,7 +4861,8 @@ static void mvpp2_port_loopback_set(struct mvpp2_port *port)
 		val &= ~MVPP2_GMAC_GMII_LB_EN_MASK;
 
 	if (port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
-	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX)
+	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    port->phy_interface == PHY_INTERFACE_MODE_2500BASEX)
 		val |= MVPP2_GMAC_PCS_LB_EN_MASK;
 	else
 		val &= ~MVPP2_GMAC_PCS_LB_EN_MASK;
@@ -6048,7 +6076,8 @@ static irqreturn_t mvpp2_link_status_isr(int irq, void *dev_id)
 		}
 	} else if (phy_interface_mode_is_rgmii(port->phy_interface) ||
 		   port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
-		   port->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
+		   port->phy_interface == PHY_INTERFACE_MODE_1000BASEX ||
+		   port->phy_interface == PHY_INTERFACE_MODE_2500BASEX) {
 		val = readl(port->base + MVPP22_GMAC_INT_STAT);
 		if (val & MVPP22_GMAC_INT_STAT_LINK) {
 			event = true;
-- 
2.14.3
