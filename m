From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Fri,  4 May 2018 15:56:39 +0200
Subject: [PATCH net-next v2 09/13] net: mvpp2: 2500baseX support
In-Reply-To: <20180504135643.23466-1-antoine.tenart@bootlin.com>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
Message-ID: <20180504135643.23466-10-antoine.tenart@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the 2500Base-X PHY mode support in the Marvell PPv2
driver. 2500Base-X is quite close to 1000Base-X and SGMII modes and uses
nearly the same code path.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 51 +++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 4775ab56075e..ec061d971b1c 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -4870,6 +4870,7 @@ static int mvpp22_gop_init(struct mvpp2_port *port)
 		break;
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
 		mvpp22_gop_init_sgmii(port);
 		break;
 	case PHY_INTERFACE_MODE_10GKR:
@@ -4908,7 +4909,8 @@ static void mvpp22_gop_unmask_irq(struct mvpp2_port *port)
 
 	if (phy_interface_mode_is_rgmii(port->phy_interface) ||
 	    port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
-	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
+	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    port->phy_interface == PHY_INTERFACE_MODE_2500BASEX) {
 		/* Enable the GMAC link status irq for this port */
 		val = readl(port->base + MVPP22_GMAC_INT_SUM_MASK);
 		val |= MVPP22_GMAC_INT_SUM_MASK_LINK_STAT;
@@ -4939,7 +4941,8 @@ static void mvpp22_gop_mask_irq(struct mvpp2_port *port)
 
 	if (phy_interface_mode_is_rgmii(port->phy_interface) ||
 	    port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
-	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
+	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    port->phy_interface == PHY_INTERFACE_MODE_2500BASEX) {
 		val = readl(port->base + MVPP22_GMAC_INT_SUM_MASK);
 		val &= ~MVPP22_GMAC_INT_SUM_MASK_LINK_STAT;
 		writel(val, port->base + MVPP22_GMAC_INT_SUM_MASK);
@@ -4952,7 +4955,8 @@ static void mvpp22_gop_setup_irq(struct mvpp2_port *port)
 
 	if (phy_interface_mode_is_rgmii(port->phy_interface) ||
 	    port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
-	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
+	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    port->phy_interface == PHY_INTERFACE_MODE_2500BASEX) {
 		val = readl(port->base + MVPP22_GMAC_INT_MASK);
 		val |= MVPP22_GMAC_INT_MASK_LINK_STAT;
 		writel(val, port->base + MVPP22_GMAC_INT_MASK);
@@ -4967,6 +4971,16 @@ static void mvpp22_gop_setup_irq(struct mvpp2_port *port)
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
@@ -4980,6 +4994,9 @@ static int mvpp22_comphy_init(struct mvpp2_port *port)
 	case PHY_INTERFACE_MODE_1000BASEX:
 		mode = PHY_MODE_SGMII;
 		break;
+	case PHY_INTERFACE_MODE_2500BASEX:
+		mode = PHY_MODE_2500SGMII;
+		break;
 	case PHY_INTERFACE_MODE_10GKR:
 		mode = PHY_MODE_10GKR;
 		break;
@@ -5058,7 +5075,8 @@ static void mvpp2_port_loopback_set(struct mvpp2_port *port,
 		val &= ~MVPP2_GMAC_GMII_LB_EN_MASK;
 
 	if (port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
-	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX)
+	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    port->phy_interface == PHY_INTERFACE_MODE_2500BASEX)
 		val |= MVPP2_GMAC_PCS_LB_EN_MASK;
 	else
 		val &= ~MVPP2_GMAC_PCS_LB_EN_MASK;
@@ -6269,7 +6287,8 @@ static irqreturn_t mvpp2_link_status_isr(int irq, void *dev_id)
 		}
 	} else if (phy_interface_mode_is_rgmii(port->phy_interface) ||
 		   port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
-		   port->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
+		   port->phy_interface == PHY_INTERFACE_MODE_1000BASEX ||
+		   port->phy_interface == PHY_INTERFACE_MODE_2500BASEX) {
 		val = readl(port->base + MVPP22_GMAC_INT_STAT);
 		if (val & MVPP22_GMAC_INT_STAT_LINK) {
 			event = true;
@@ -8053,8 +8072,10 @@ static void mvpp2_phylink_validate(struct net_device *dev,
 		phylink_set(mask, 10000baseT_Full);
 		/* Fall-through */
 	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
 		phylink_set(mask, 1000baseT_Full);
 		phylink_set(mask, 1000baseX_Full);
+		phylink_set(mask, 2500baseX_Full);
 	}
 
 	bitmap_and(supported, supported, mask, __ETHTOOL_LINK_MODE_MASK_NBITS);
@@ -8097,6 +8118,9 @@ static void mvpp2_gmac_link_state(struct mvpp2_port *port,
 	case PHY_INTERFACE_MODE_1000BASEX:
 		state->speed = SPEED_1000;
 		break;
+	case PHY_INTERFACE_MODE_2500BASEX:
+		state->speed = SPEED_2500;
+		break;
 	default:
 		if (val & MVPP2_GMAC_STATUS0_GMII_SPEED)
 			state->speed = SPEED_1000;
@@ -8195,11 +8219,12 @@ static void mvpp2_gmac_config(struct mvpp2_port *port, unsigned int mode,
 	ctrl0 &= ~MVPP2_GMAC_PORT_TYPE_MASK;
 	ctrl2 &= ~(MVPP2_GMAC_PORT_RESET_MASK | MVPP2_GMAC_PCS_ENABLE_MASK);
 
-	if (state->interface == PHY_INTERFACE_MODE_1000BASEX) {
-		/* 1000BaseX port cannot negotiate speed nor can it negotiate
-		 * duplex: they are always operating with a fixed speed of
-		 * 1000Mbps in full duplex, so force 1000 speed and full duplex
-		 * here.
+	if (state->interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    state->interface == PHY_INTERFACE_MODE_2500BASEX) {
+		/* 1000BaseX and 2500BaseX ports cannot negotiate speed nor can
+		 * they negotiate duplex: they are always operating with a fixed
+		 * speed of 1000/2500Mbps in full duplex, so force 1000/2500
+		 * speed and full duplex here.
 		 */
 		ctrl0 |= MVPP2_GMAC_PORT_TYPE_MASK;
 		an |= MVPP2_GMAC_CONFIG_GMII_SPEED |
@@ -8216,7 +8241,8 @@ static void mvpp2_gmac_config(struct mvpp2_port *port, unsigned int mode,
 		an |= MVPP2_GMAC_FC_ADV_ASM_EN;
 
 	if (state->interface == PHY_INTERFACE_MODE_SGMII ||
-	    state->interface == PHY_INTERFACE_MODE_1000BASEX) {
+	    state->interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    state->interface == PHY_INTERFACE_MODE_2500BASEX) {
 		an |= MVPP2_GMAC_IN_BAND_AUTONEG;
 		ctrl2 |= MVPP2_GMAC_INBAND_AN_MASK | MVPP2_GMAC_PCS_ENABLE_MASK;
 
@@ -8279,7 +8305,8 @@ static void mvpp2_mac_config(struct net_device *dev, unsigned int mode,
 		mvpp2_xlg_config(port, mode, state);
 	else if (phy_interface_mode_is_rgmii(state->interface) ||
 		 state->interface == PHY_INTERFACE_MODE_SGMII ||
-		 state->interface == PHY_INTERFACE_MODE_1000BASEX)
+		 state->interface == PHY_INTERFACE_MODE_1000BASEX ||
+		 state->interface == PHY_INTERFACE_MODE_2500BASEX)
 		mvpp2_gmac_config(port, mode, state);
 
 	if (port->priv->hw_version == MVPP21 && port->flags & MVPP2_F_LOOPBACK)
-- 
2.17.0
