From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 15 Feb 2014 11:20:21 +0100
Subject: [PATCH v2 23/23] ARM: Kirkwood: Remove DT support
In-Reply-To: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
Message-ID: <1392459621-24003-24-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all the device tree support is in mach-mvebu, remove it from
mach-kirkwood.

Regenerate kirkwood_defconfig, removing all DT support, and a couple
of other redundent options have been removed in the process.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/configs/kirkwood_defconfig |   6 -
 arch/arm/mach-kirkwood/Kconfig      |  18 ---
 arch/arm/mach-kirkwood/Makefile     |   2 -
 arch/arm/mach-kirkwood/board-dt.c   | 227 ------------------------------------
 4 files changed, 253 deletions(-)
 delete mode 100644 arch/arm/mach-kirkwood/board-dt.c

diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index 2e762d94e94b..95b5585c1fbb 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -20,13 +20,9 @@ CONFIG_MACH_RD88F6281=y
 CONFIG_MACH_T5325=y
 CONFIG_MACH_TS219=y
 CONFIG_MACH_TS41X=y
-CONFIG_ARCH_KIRKWOOD_DT=y
-CONFIG_MACH_MV88F6281GTW_GE_DT=y
 # CONFIG_CPU_FEROCEON_OLD_ID is not set
-CONFIG_PCI_MVEBU=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
-# CONFIG_OABI_COMPAT is not set
 CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
@@ -85,7 +81,6 @@ CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_RUNTIME_UARTS=2
-CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 # CONFIG_I2C_COMPAT is not set
@@ -176,5 +171,4 @@ CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_DEV_MV_CESA=y
 CONFIG_CRC_CCITT=y
-CONFIG_CRC16=y
 CONFIG_LIBCRC32C=y
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index df4b26340ae4..fb4560d2605f 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -88,24 +88,6 @@ config MACH_TS41X
 	  QNAP TS-410, TS-410U, TS-419P, TS-419P+ and TS-419U Turbo
 	  NAS devices.
 
-comment "Device tree entries"
-
-config ARCH_KIRKWOOD_DT
-	bool "Marvell Kirkwood Flattened Device Tree"
-	select KIRKWOOD_CLK
-	select OF_IRQ
-	select ORION_IRQCHIP
-	select ORION_TIMER
-	select POWER_SUPPLY
-	select POWER_RESET
-	select POWER_RESET_GPIO
-	select REGULATOR
-	select REGULATOR_FIXED_VOLTAGE
-	select USE_OF
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Marvell Kirkwood using flattened device tree.
-
 endmenu
 
 endif
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 3a72c5c6e747..c772d7584937 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -10,5 +10,3 @@ obj-$(CONFIG_MACH_RD88F6281)		+= rd88f6281-setup.o
 obj-$(CONFIG_MACH_T5325)		+= t5325-setup.o
 obj-$(CONFIG_MACH_TS219)		+= ts219-setup.o tsx1x-common.o
 obj-$(CONFIG_MACH_TS41X)		+= ts41x-setup.o tsx1x-common.o
-
-obj-$(CONFIG_ARCH_KIRKWOOD_DT)		+= board-dt.o
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
deleted file mode 100644
index 2ef59ee2182d..000000000000
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ /dev/null
@@ -1,227 +0,0 @@
-/*
- * Copyright 2012 (C), Jason Cooper <jason@lakedaemon.net>
- *
- * arch/arm/mach-kirkwood/board-dt.c
- *
- * Flattened Device Tree board initialization
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/clk.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_net.h>
-#include <linux/of_platform.h>
-#include <linux/dma-mapping.h>
-#include <linux/irqchip.h>
-#include <linux/kexec.h>
-#include <asm/hardware/cache-feroceon-l2.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <mach/bridge-regs.h>
-#include <plat/common.h>
-#include <plat/pcie.h>
-#include "pm.h"
-
-static struct map_desc kirkwood_io_desc[] __initdata = {
-	{
-		.virtual	= (unsigned long) KIRKWOOD_REGS_VIRT_BASE,
-		.pfn		= __phys_to_pfn(KIRKWOOD_REGS_PHYS_BASE),
-		.length		= KIRKWOOD_REGS_SIZE,
-		.type		= MT_DEVICE,
-	},
-};
-
-static void __init kirkwood_map_io(void)
-{
-	iotable_init(kirkwood_io_desc, ARRAY_SIZE(kirkwood_io_desc));
-}
-
-static struct resource kirkwood_cpufreq_resources[] = {
-	[0] = {
-		.start  = CPU_CONTROL_PHYS,
-		.end    = CPU_CONTROL_PHYS + 3,
-		.flags  = IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device kirkwood_cpufreq_device = {
-	.name		= "kirkwood-cpufreq",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(kirkwood_cpufreq_resources),
-	.resource	= kirkwood_cpufreq_resources,
-};
-
-static void __init kirkwood_cpufreq_init(void)
-{
-	platform_device_register(&kirkwood_cpufreq_device);
-}
-
-static struct resource kirkwood_cpuidle_resource[] = {
-	{
-		.flags	= IORESOURCE_MEM,
-		.start	= DDR_OPERATION_BASE,
-		.end	= DDR_OPERATION_BASE + 3,
-	},
-};
-
-static struct platform_device kirkwood_cpuidle = {
-	.name		= "kirkwood_cpuidle",
-	.id		= -1,
-	.resource	= kirkwood_cpuidle_resource,
-	.num_resources	= 1,
-};
-
-static void __init kirkwood_cpuidle_init(void)
-{
-	platform_device_register(&kirkwood_cpuidle);
-}
-
-/* Temporary here since mach-mvebu has a function we can use */
-static void kirkwood_restart(enum reboot_mode mode, const char *cmd)
-{
-	/*
-	 * Enable soft reset to assert RSTOUTn.
-	 */
-	writel(SOFT_RESET_OUT_EN, RSTOUTn_MASK);
-
-	/*
-	 * Assert soft reset.
-	 */
-	writel(SOFT_RESET, SYSTEM_SOFT_RESET);
-
-	while (1)
-		;
-}
-
-#define MV643XX_ETH_MAC_ADDR_LOW	0x0414
-#define MV643XX_ETH_MAC_ADDR_HIGH	0x0418
-
-static void __init kirkwood_dt_eth_fixup(void)
-{
-	struct device_node *np;
-
-	/*
-	 * The ethernet interfaces forget the MAC address assigned by u-boot
-	 * if the clocks are turned off. Usually, u-boot on kirkwood boards
-	 * has no DT support to properly set local-mac-address property.
-	 * As a workaround, we get the MAC address from mv643xx_eth registers
-	 * and update the port device node if no valid MAC address is set.
-	 */
-	for_each_compatible_node(np, NULL, "marvell,kirkwood-eth-port") {
-		struct device_node *pnp = of_get_parent(np);
-		struct clk *clk;
-		struct property *pmac;
-		void __iomem *io;
-		u8 *macaddr;
-		u32 reg;
-
-		if (!pnp)
-			continue;
-
-		/* skip disabled nodes or nodes with valid MAC address*/
-		if (!of_device_is_available(pnp) || of_get_mac_address(np))
-			goto eth_fixup_skip;
-
-		clk = of_clk_get(pnp, 0);
-		if (IS_ERR(clk))
-			goto eth_fixup_skip;
-
-		io = of_iomap(pnp, 0);
-		if (!io)
-			goto eth_fixup_no_map;
-
-		/* ensure port clock is not gated to not hang CPU */
-		clk_prepare_enable(clk);
-
-		/* store MAC address register contents in local-mac-address */
-		pr_err(FW_INFO "%s: local-mac-address is not set\n",
-		       np->full_name);
-
-		pmac = kzalloc(sizeof(*pmac) + 6, GFP_KERNEL);
-		if (!pmac)
-			goto eth_fixup_no_mem;
-
-		pmac->value = pmac + 1;
-		pmac->length = 6;
-		pmac->name = kstrdup("local-mac-address", GFP_KERNEL);
-		if (!pmac->name) {
-			kfree(pmac);
-			goto eth_fixup_no_mem;
-		}
-
-		macaddr = pmac->value;
-		reg = readl(io + MV643XX_ETH_MAC_ADDR_HIGH);
-		macaddr[0] = (reg >> 24) & 0xff;
-		macaddr[1] = (reg >> 16) & 0xff;
-		macaddr[2] = (reg >> 8) & 0xff;
-		macaddr[3] = reg & 0xff;
-
-		reg = readl(io + MV643XX_ETH_MAC_ADDR_LOW);
-		macaddr[4] = (reg >> 8) & 0xff;
-		macaddr[5] = reg & 0xff;
-
-		of_update_property(np, pmac);
-
-eth_fixup_no_mem:
-		iounmap(io);
-		clk_disable_unprepare(clk);
-eth_fixup_no_map:
-		clk_put(clk);
-eth_fixup_skip:
-		of_node_put(pnp);
-	}
-}
-
-/*
- * Disable propagation of mbus errors to the CPU local bus, as this
- * causes mbus errors (which can occur for example for PCI aborts) to
- * throw CPU aborts, which we're not set up to deal with.
- */
-void kirkwood_disable_mbus_error_propagation(void)
-{
-	void __iomem *cpu_config;
-
-	cpu_config = ioremap(CPU_CONFIG_PHYS, 4);
-	writel(readl(cpu_config) & ~CPU_CONFIG_ERROR_PROP, cpu_config);
-}
-
-
-static void __init kirkwood_dt_init(void)
-{
-	kirkwood_disable_mbus_error_propagation();
-
-	BUG_ON(mvebu_mbus_dt_init());
-
-	feroceon_of_init();
-
-	kirkwood_cpufreq_init();
-	kirkwood_cpuidle_init();
-
-	kirkwood_pm_init();
-	kirkwood_dt_eth_fixup();
-
-#ifdef CONFIG_KEXEC
-	kexec_reinit = kirkwood_enable_pcie;
-#endif
-
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
-static const char * const kirkwood_dt_board_compat[] = {
-	"marvell,kirkwood",
-	NULL
-};
-
-DT_MACHINE_START(KIRKWOOD_DT, "Marvell Kirkwood (Flattened Device Tree)")
-	/* Maintainer: Jason Cooper <jason@lakedaemon.net> */
-	.map_io		= kirkwood_map_io,
-	.init_machine	= kirkwood_dt_init,
-	.restart	= kirkwood_restart,
-	.dt_compat	= kirkwood_dt_board_compat,
-MACHINE_END
-- 
1.8.5.3
