From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Mar 2017 12:15:41 +0200
Subject: [PATCH] ARM: orion5x: only call into phylib when available
Message-ID: <20170328101606.53008-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Board code cannot call mdiobus_register_board_info() when phylib
or mdio_device is a loadable module:

arch/arm/plat-orion/common.o: In function `orion_ge00_switch_init':
:(.init.text+0x474): undefined reference to `mdiobus_register_board_info'

I had a number of ideas for how this could be solved, but after the MDIO
code got split out from PHYLIB it has gotten too hard, so I'm basically
giving up, and only call the mdiobus_register_board_info() function
if the MDIO layer is built-in to avoid the link error. This is similar
to how we handle PHY registration on other ARM platforms.

Fixes: 90eff9096c01 ("net: phy: Allow splitting MDIO bus/device support from PHYs")
Fixes: 648ea0134069 ("net: phy: Allow pre-declaration of MDIO devices")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-orion5x/Kconfig | 1 +
 arch/arm/plat-orion/common.c  | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
index 468b8cb7fd5f..e3429c8c2e38 100644
--- a/arch/arm/mach-orion5x/Kconfig
+++ b/arch/arm/mach-orion5x/Kconfig
@@ -6,6 +6,7 @@ menuconfig ARCH_ORION5X
 	select GPIOLIB
 	select MVEBU_MBUS
 	select PCI
+	select PHYLIB if NETDEVICES
 	select PLAT_ORION_LEGACY
 	help
 	  Support for the following Marvell Orion 5x series SoCs:
diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index 9255b6d67ba5..aff6994950ba 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -468,6 +468,7 @@ void __init orion_ge11_init(struct mv643xx_eth_platform_data *eth_data,
 		    eth_data, &orion_ge11);
 }
 
+#ifdef CONFIG_ARCH_ORION5X
 /*****************************************************************************
  * Ethernet switch
  ****************************************************************************/
@@ -480,6 +481,9 @@ void __init orion_ge00_switch_init(struct dsa_chip_data *d)
 	struct mdio_board_info *bd;
 	unsigned int i;
 
+	if (!IS_BUILTIN(CONFIG_PHYLIB))
+		return;
+
 	for (i = 0; i < ARRAY_SIZE(d->port_names); i++)
 		if (!strcmp(d->port_names[i], "cpu"))
 			break;
@@ -493,6 +497,7 @@ void __init orion_ge00_switch_init(struct dsa_chip_data *d)
 
 	mdiobus_register_board_info(&orion_ge00_switch_board_info, 1);
 }
+#endif
 
 /*****************************************************************************
  * I2C
-- 
2.9.0
