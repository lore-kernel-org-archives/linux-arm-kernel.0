From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue,  9 Jan 2018 09:59:44 +0100
Subject: [PATCH net-next v3 3/4] net: mvpp2: 1000baseX support
In-Reply-To: <20180109085945.11916-1-antoine.tenart@free-electrons.com>
References: <20180109085945.11916-1-antoine.tenart@free-electrons.com>
Message-ID: <20180109085945.11916-4-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the 1000Base-X PHY mode support in the Marvell PPv2
driver. 1000Base-X is quite close the SGMII and uses nearly the same
code path.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 45 ++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index a19760736b71..257a6b99b4ca 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -4501,6 +4501,7 @@ static int mvpp22_gop_init(struct mvpp2_port *port)
 		mvpp22_gop_init_rgmii(port);
 		break;
 	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
 		mvpp22_gop_init_sgmii(port);
 		break;
 	case PHY_INTERFACE_MODE_10GKR:
@@ -4538,7 +4539,8 @@ static void mvpp22_gop_unmask_irq(struct mvpp2_port *port)
 	u32 val;
 
 	if (phy_interface_mode_is_rgmii(port->phy_interface) ||
-	    port->phy_interface == PHY_INTERFACE_MODE_SGMII) {
+	    port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
+	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
 		/* Enable the GMAC link status irq for this port */
 		val = readl(port->base + MVPP22_GMAC_INT_SUM_MASK);
 		val |= MVPP22_GMAC_INT_SUM_MASK_LINK_STAT;
@@ -4568,7 +4570,8 @@ static void mvpp22_gop_mask_irq(struct mvpp2_port *port)
 	}
 
 	if (phy_interface_mode_is_rgmii(port->phy_interface) ||
-	    port->phy_interface == PHY_INTERFACE_MODE_SGMII) {
+	    port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
+	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
 		val = readl(port->base + MVPP22_GMAC_INT_SUM_MASK);
 		val &= ~MVPP22_GMAC_INT_SUM_MASK_LINK_STAT;
 		writel(val, port->base + MVPP22_GMAC_INT_SUM_MASK);
@@ -4580,7 +4583,8 @@ static void mvpp22_gop_setup_irq(struct mvpp2_port *port)
 	u32 val;
 
 	if (phy_interface_mode_is_rgmii(port->phy_interface) ||
-	    port->phy_interface == PHY_INTERFACE_MODE_SGMII) {
+	    port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
+	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
 		val = readl(port->base + MVPP22_GMAC_INT_MASK);
 		val |= MVPP22_GMAC_INT_MASK_LINK_STAT;
 		writel(val, port->base + MVPP22_GMAC_INT_MASK);
@@ -4605,6 +4609,7 @@ static int mvpp22_comphy_init(struct mvpp2_port *port)
 
 	switch (port->phy_interface) {
 	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
 		mode = PHY_MODE_SGMII;
 		break;
 	case PHY_INTERFACE_MODE_10GKR:
@@ -4625,7 +4630,8 @@ static void mvpp2_port_mii_gmac_configure_mode(struct mvpp2_port *port)
 {
 	u32 val;
 
-	if (port->phy_interface == PHY_INTERFACE_MODE_SGMII) {
+	if (port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
+	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
 		val = readl(port->base + MVPP22_GMAC_CTRL_4_REG);
 		val |= MVPP22_CTRL4_SYNC_BYPASS_DIS | MVPP22_CTRL4_DP_CLK_SEL |
 		       MVPP22_CTRL4_QSGMII_BYPASS_ACTIVE;
@@ -4640,9 +4646,11 @@ static void mvpp2_port_mii_gmac_configure_mode(struct mvpp2_port *port)
 		writel(val, port->base + MVPP22_GMAC_CTRL_4_REG);
 	}
 
-	/* The port is connected to a copper PHY */
 	val = readl(port->base + MVPP2_GMAC_CTRL_0_REG);
-	val &= ~MVPP2_GMAC_PORT_TYPE_MASK;
+	if (port->phy_interface == PHY_INTERFACE_MODE_1000BASEX)
+		val |= MVPP2_GMAC_PORT_TYPE_MASK;
+	else
+		val &= ~MVPP2_GMAC_PORT_TYPE_MASK;
 	writel(val, port->base + MVPP2_GMAC_CTRL_0_REG);
 
 	val = readl(port->base + MVPP2_GMAC_AUTONEG_CONFIG);
@@ -4651,6 +4659,19 @@ static void mvpp2_port_mii_gmac_configure_mode(struct mvpp2_port *port)
 	       MVPP2_GMAC_AN_DUPLEX_EN;
 	if (port->phy_interface == PHY_INTERFACE_MODE_SGMII)
 		val |= MVPP2_GMAC_IN_BAND_AUTONEG;
+
+	if (port->phy_interface == PHY_INTERFACE_MODE_1000BASEX)
+		/* 1000BaseX port cannot negotiate speed nor can it
+		 * negotiate duplex: they are always operating with a
+		 * fixed speed of 1000Mbps in full duplex, so force
+		 * 1000 speed and full duplex here.
+		 */
+		val |= MVPP2_GMAC_CONFIG_GMII_SPEED |
+		       MVPP2_GMAC_CONFIG_FULL_DUPLEX;
+	else
+		val |= MVPP2_GMAC_AN_SPEED_EN |
+		       MVPP2_GMAC_AN_DUPLEX_EN;
+
 	writel(val, port->base + MVPP2_GMAC_AUTONEG_CONFIG);
 }
 
@@ -4671,7 +4692,8 @@ static void mvpp2_port_mii_gmac_configure(struct mvpp2_port *port)
 
 	/* Configure the PCS and in-band AN */
 	val = readl(port->base + MVPP2_GMAC_CTRL_2_REG);
-	if (port->phy_interface == PHY_INTERFACE_MODE_SGMII) {
+	if (port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
+	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
 	        val |= MVPP2_GMAC_INBAND_AN_MASK | MVPP2_GMAC_PCS_ENABLE_MASK;
 	} else if (phy_interface_mode_is_rgmii(port->phy_interface)) {
 		val &= ~MVPP2_GMAC_PCS_ENABLE_MASK;
@@ -4733,7 +4755,8 @@ static void mvpp2_port_mii_set(struct mvpp2_port *port)
 		mvpp22_port_mii_set(port);
 
 	if (phy_interface_mode_is_rgmii(port->phy_interface) ||
-	    port->phy_interface == PHY_INTERFACE_MODE_SGMII)
+	    port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
+	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX)
 		mvpp2_port_mii_gmac_configure(port);
 	else if (port->phy_interface == PHY_INTERFACE_MODE_10GKR)
 		mvpp2_port_mii_xlg_configure(port);
@@ -4810,7 +4833,8 @@ static void mvpp2_port_loopback_set(struct mvpp2_port *port)
 	else
 		val &= ~MVPP2_GMAC_GMII_LB_EN_MASK;
 
-	if (port->phy_interface == PHY_INTERFACE_MODE_SGMII)
+	if (port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
+	    port->phy_interface == PHY_INTERFACE_MODE_1000BASEX)
 		val |= MVPP2_GMAC_PCS_LB_EN_MASK;
 	else
 		val &= ~MVPP2_GMAC_PCS_LB_EN_MASK;
@@ -6023,7 +6047,8 @@ static irqreturn_t mvpp2_link_status_isr(int irq, void *dev_id)
 				link = true;
 		}
 	} else if (phy_interface_mode_is_rgmii(port->phy_interface) ||
-		   port->phy_interface == PHY_INTERFACE_MODE_SGMII) {
+		   port->phy_interface == PHY_INTERFACE_MODE_SGMII ||
+		   port->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
 		val = readl(port->base + MVPP22_GMAC_INT_STAT);
 		if (val & MVPP22_GMAC_INT_STAT_LINK) {
 			event = true;
-- 
2.14.3
