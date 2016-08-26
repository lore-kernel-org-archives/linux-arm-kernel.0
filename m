From: jm@lentin.co.uk (Jamie Lentin)
Date: Fri, 26 Aug 2016 10:21:03 +0100
Subject: [PATCH 7/8] arm: orion5x: Remove old non-DT-based WNR854T support
In-Reply-To: <1472203264-21089-1-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1472203264-21089-1-git-send-email-jm@lentin.co.uk>
Message-ID: <1472203264-21089-8-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The non-DT-based support is now redundant, remove it and replace it
with the DT-support in defconfigs.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 arch/arm/configs/multi_v5_defconfig   |   2 +-
 arch/arm/configs/mvebu_v5_defconfig   |   2 +-
 arch/arm/configs/orion5x_defconfig    |   2 +-
 arch/arm/mach-orion5x/Kconfig         |   6 --
 arch/arm/mach-orion5x/Makefile        |   1 -
 arch/arm/mach-orion5x/wnr854t-setup.c | 185 ----------------------------------
 6 files changed, 3 insertions(+), 195 deletions(-)
 delete mode 100644 arch/arm/mach-orion5x/wnr854t-setup.c

diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index 2658b80..8b417b1 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -44,7 +44,7 @@ CONFIG_MACH_MV2120=y
 CONFIG_MACH_D2NET_DT=y
 CONFIG_MACH_NET2BIG=y
 CONFIG_MACH_MSS2_DT=y
-CONFIG_MACH_WNR854T=y
+CONFIG_MACH_WNR854T_DT=y
 CONFIG_MACH_RD88F5181L_GE=y
 CONFIG_MACH_RD88F5181L_FXO=y
 CONFIG_MACH_RD88F6183AP_GE=y
diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
index 6051c51..81dabae 100644
--- a/arch/arm/configs/mvebu_v5_defconfig
+++ b/arch/arm/configs/mvebu_v5_defconfig
@@ -31,7 +31,7 @@ CONFIG_MACH_MV2120=y
 CONFIG_MACH_D2NET_DT=y
 CONFIG_MACH_NET2BIG=y
 CONFIG_MACH_MSS2_DT=y
-CONFIG_MACH_WNR854T=y
+CONFIG_MACH_WNR854T_DT=y
 CONFIG_MACH_RD88F5181L_GE=y
 CONFIG_MACH_RD88F5181L_FXO=y
 CONFIG_MACH_RD88F6183AP_GE=y
diff --git a/arch/arm/configs/orion5x_defconfig b/arch/arm/configs/orion5x_defconfig
index 27a70a7..93b63aa 100644
--- a/arch/arm/configs/orion5x_defconfig
+++ b/arch/arm/configs/orion5x_defconfig
@@ -37,7 +37,7 @@ CONFIG_MACH_D2NET=y
 CONFIG_MACH_BIGDISK=y
 CONFIG_MACH_NET2BIG=y
 CONFIG_MACH_MSS2=y
-CONFIG_MACH_WNR854T=y
+CONFIG_MACH_WNR854T_DT=y
 CONFIG_MACH_RD88F5181L_GE=y
 CONFIG_MACH_RD88F5181L_FXO=y
 CONFIG_MACH_RD88F6183AP_GE=y
diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
index 9acb37b..7dff2a5 100644
--- a/arch/arm/mach-orion5x/Kconfig
+++ b/arch/arm/mach-orion5x/Kconfig
@@ -157,12 +157,6 @@ config MACH_WNR854T_DT
 	  Say 'Y' here if you want your kernel to support the
 	  Netgear WNR854T platform.
 
-config MACH_WNR854T
-	bool "Netgear WNR854T"
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Netgear WNR854T platform.
-
 config MACH_RD88F5181L_GE
 	bool "Marvell Orion-VoIP GE Reference Design"
 	help
diff --git a/arch/arm/mach-orion5x/Makefile b/arch/arm/mach-orion5x/Makefile
index 9dff2d3..a2c9ebc 100644
--- a/arch/arm/mach-orion5x/Makefile
+++ b/arch/arm/mach-orion5x/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_MACH_WRT350N_V2)	+= wrt350n-v2-setup.o
 obj-$(CONFIG_MACH_TS78XX)	+= ts78xx-setup.o
 obj-$(CONFIG_MACH_MV2120)	+= mv2120-setup.o
 obj-$(CONFIG_MACH_NET2BIG)	+= net2big-setup.o
-obj-$(CONFIG_MACH_WNR854T)	+= wnr854t-setup.o
 obj-$(CONFIG_MACH_RD88F5181L_GE)	+= rd88f5181l-ge-setup.o
 obj-$(CONFIG_MACH_RD88F5181L_FXO)	+= rd88f5181l-fxo-setup.o
 obj-$(CONFIG_MACH_RD88F6183AP_GE)	+= rd88f6183ap-ge-setup.o
diff --git a/arch/arm/mach-orion5x/wnr854t-setup.c b/arch/arm/mach-orion5x/wnr854t-setup.c
deleted file mode 100644
index 4e1e5c8..0000000
--- a/arch/arm/mach-orion5x/wnr854t-setup.c
+++ /dev/null
@@ -1,185 +0,0 @@
-/*
- * arch/arm/mach-orion5x/wnr854t-setup.c
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-#include <linux/gpio.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/pci.h>
-#include <linux/irq.h>
-#include <linux/delay.h>
-#include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
-#include <linux/ethtool.h>
-#include <net/dsa.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/pci.h>
-#include "orion5x.h"
-#include "common.h"
-#include "mpp.h"
-
-static unsigned int wnr854t_mpp_modes[] __initdata = {
-	MPP0_GPIO,		/* Power LED green (0=on) */
-	MPP1_GPIO,		/* Reset Button (0=off) */
-	MPP2_GPIO,		/* Power LED blink (0=off) */
-	MPP3_GPIO,		/* WAN Status LED amber (0=off) */
-	MPP4_GPIO,		/* PCI int */
-	MPP5_GPIO,		/* ??? */
-	MPP6_GPIO,		/* ??? */
-	MPP7_GPIO,		/* ??? */
-	MPP8_UNUSED,		/* ??? */
-	MPP9_GIGE,		/* GE_RXERR */
-	MPP10_UNUSED,		/* ??? */
-	MPP11_UNUSED,		/* ??? */
-	MPP12_GIGE,		/* GE_TXD[4] */
-	MPP13_GIGE,		/* GE_TXD[5] */
-	MPP14_GIGE,		/* GE_TXD[6] */
-	MPP15_GIGE,		/* GE_TXD[7] */
-	MPP16_GIGE,		/* GE_RXD[4] */
-	MPP17_GIGE,		/* GE_RXD[5] */
-	MPP18_GIGE,		/* GE_RXD[6] */
-	MPP19_GIGE,		/* GE_RXD[7] */
-	0,
-};
-
-/*
- * 8M NOR flash Device bus boot chip select
- */
-#define WNR854T_NOR_BOOT_BASE	0xf4000000
-#define WNR854T_NOR_BOOT_SIZE	SZ_8M
-
-static struct mtd_partition wnr854t_nor_flash_partitions[] = {
-	{
-		.name		= "kernel",
-		.offset		= 0x00000000,
-		.size		= 0x00100000,
-	}, {
-		.name		= "rootfs",
-		.offset		= 0x00100000,
-		.size		= 0x00660000,
-	}, {
-		.name		= "uboot",
-		.offset		= 0x00760000,
-		.size		= 0x00040000,
-	},
-};
-
-static struct physmap_flash_data wnr854t_nor_flash_data = {
-	.width		= 2,
-	.parts		= wnr854t_nor_flash_partitions,
-	.nr_parts	= ARRAY_SIZE(wnr854t_nor_flash_partitions),
-};
-
-static struct resource wnr854t_nor_flash_resource = {
-	.flags		= IORESOURCE_MEM,
-	.start		= WNR854T_NOR_BOOT_BASE,
-	.end		= WNR854T_NOR_BOOT_BASE + WNR854T_NOR_BOOT_SIZE - 1,
-};
-
-static struct platform_device wnr854t_nor_flash = {
-	.name			= "physmap-flash",
-	.id			= 0,
-	.dev		= {
-		.platform_data	= &wnr854t_nor_flash_data,
-	},
-	.num_resources		= 1,
-	.resource		= &wnr854t_nor_flash_resource,
-};
-
-static struct mv643xx_eth_platform_data wnr854t_eth_data = {
-	.phy_addr	= MV643XX_ETH_PHY_NONE,
-	.speed		= SPEED_1000,
-	.duplex		= DUPLEX_FULL,
-};
-
-static struct dsa_chip_data wnr854t_switch_chip_data = {
-	.port_names[0] = "lan3",
-	.port_names[1] = "lan4",
-	.port_names[2] = "wan",
-	.port_names[3] = "cpu",
-	.port_names[5] = "lan1",
-	.port_names[7] = "lan2",
-};
-
-static struct dsa_platform_data wnr854t_switch_plat_data = {
-	.nr_chips	= 1,
-	.chip		= &wnr854t_switch_chip_data,
-};
-
-static void __init wnr854t_init(void)
-{
-	/*
-	 * Setup basic Orion functions. Need to be called early.
-	 */
-	orion5x_init();
-
-	orion5x_mpp_conf(wnr854t_mpp_modes);
-
-	/*
-	 * Configure peripherals.
-	 */
-	orion5x_eth_init(&wnr854t_eth_data);
-	orion5x_eth_switch_init(&wnr854t_switch_plat_data, NO_IRQ);
-	orion5x_uart0_init();
-
-	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
-				    ORION_MBUS_DEVBUS_BOOT_ATTR,
-				    WNR854T_NOR_BOOT_BASE,
-				    WNR854T_NOR_BOOT_SIZE);
-	platform_device_register(&wnr854t_nor_flash);
-}
-
-static int __init wnr854t_pci_map_irq(const struct pci_dev *dev, u8 slot,
-	u8 pin)
-{
-	int irq;
-
-	/*
-	 * Check for devices with hard-wired IRQs.
-	 */
-	irq = orion5x_pci_map_irq(dev, slot, pin);
-	if (irq != -1)
-		return irq;
-
-	/*
-	 * Mini-PCI slot.
-	 */
-	if (slot == 7)
-		return gpio_to_irq(4);
-
-	return -1;
-}
-
-static struct hw_pci wnr854t_pci __initdata = {
-	.nr_controllers	= 2,
-	.setup		= orion5x_pci_sys_setup,
-	.scan		= orion5x_pci_sys_scan_bus,
-	.map_irq	= wnr854t_pci_map_irq,
-};
-
-static int __init wnr854t_pci_init(void)
-{
-	if (machine_is_wnr854t())
-		pci_common_init(&wnr854t_pci);
-
-	return 0;
-}
-subsys_initcall(wnr854t_pci_init);
-
-MACHINE_START(WNR854T, "Netgear WNR854T")
-	/* Maintainer: Imre Kaloz <kaloz@openwrt.org> */
-	.atag_offset	= 0x100,
-	.nr_irqs	= ORION5X_NR_IRQS,
-	.init_machine	= wnr854t_init,
-	.map_io		= orion5x_map_io,
-	.init_early	= orion5x_init_early,
-	.init_irq	= orion5x_init_irq,
-	.init_time	= orion5x_timer_init,
-	.fixup		= tag_fixup_mem32,
-	.restart	= orion5x_restart,
-MACHINE_END
-- 
2.8.1
