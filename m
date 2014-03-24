From: simon.kagstrom@netinsight.net (Simon =?UTF-8?B?S8OlZ3N0csO2bQ==?=)
Date: Mon, 24 Mar 2014 15:17:29 +0100
Subject: [PATCH RFC] ixp4xx_eth: Allow setting the MDIO bus name in platform
 data
Message-ID: <20140324151729.1b8e3bb5@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allows using e.g., a fixed MDIO bus with the ixp4xx_eth driver.
Example:

  static struct eth_plat_info board_plat_eth_internal[] = {
	{
		.mdio_bus_id	= "fixed-0",
		.phy		= 31,
		.rxq		= 4,
		.txreadyq	= 21,
		.hwaddr		= {0x02, 0x00, 0x00, 0x00, 0x00, 0x00},
	}
  };

  static struct platform_device board_eth_internal = {
	.name			= "ixp4xx_eth",
	.id			= IXP4XX_ETH_NPEC,
	.dev.platform_data	= board_plat_eth_internal,
  };

Signed-off-by: Simon Kagstrom <simon.kagstrom@netinsight.net>
---
I'm unsure if this is the correct way of doing it for the legacy ixp4xx
platform. It seems most boards which use the fixed PHYs are DT-based			
PPC ones.

 arch/arm/mach-ixp4xx/include/mach/platform.h |    1 +
 drivers/net/ethernet/xscale/ixp4xx_eth.c     |    7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ixp4xx/include/mach/platform.h b/arch/arm/mach-ixp4xx/include/mach/platform.h
index 75c4c65..c6114b9 100644
--- a/arch/arm/mach-ixp4xx/include/mach/platform.h
+++ b/arch/arm/mach-ixp4xx/include/mach/platform.h
@@ -97,6 +97,7 @@ struct ixp4xx_pata_data {
 
 /* Information about built-in Ethernet MAC interfaces */
 struct eth_plat_info {
+	const char *mdio_bus_id; /* MDIO bus name. NULL is the ixp4xx_eth bus */
 	u8 phy;		/* MII PHY ID, 0 - 31 */
 	u8 rxq;		/* configurable, currently 0 - 31 only */
 	u8 txreadyq;
diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index e540e51..31fe055 100644
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -1410,6 +1410,7 @@ static int eth_init_one(struct platform_device *pdev)
 	struct net_device *dev;
 	struct eth_plat_info *plat = dev_get_platdata(&pdev->dev);
 	u32 regs_phys;
+	const char *mdio_bus_id;
 	char phy_id[MII_BUS_ID_SIZE + 3];
 	int err;
 
@@ -1477,8 +1478,12 @@ static int eth_init_one(struct platform_device *pdev)
 	__raw_writel(DEFAULT_CORE_CNTRL, &port->regs->core_control);
 	udelay(50);
 
+	mdio_bus_id = mdio_bus->id;
+	if (plat->mdio_bus_id)
+		mdio_bus_id = plat->mdio_bus_id;
+
 	snprintf(phy_id, MII_BUS_ID_SIZE + 3, PHY_ID_FMT,
-		mdio_bus->id, plat->phy);
+		mdio_bus_id, plat->phy);
 	port->phydev = phy_connect(dev, phy_id, &ixp4xx_adjust_link,
 				   PHY_INTERFACE_MODE_MII);
 	if (IS_ERR(port->phydev)) {
-- 
1.7.9.6
