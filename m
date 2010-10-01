From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:52 -0700
Subject: [PATCH 28/47] davinci: Initial support for MityDSP-L138/MityARM-1808
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-29-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Williamson <michael.williamson@criticallink.com>

This patch adds initial support for the MityDSP-L138 and MityDSP-1808 system
on Module (SOM) under the machine name "mityomapl138".  These SOMs are based
on the da850 davinci CPU architecture.  Information on these SOMs may be
found at http://www.mitydsp.com.

Basic support for the console UART, NAND, and EMAC (MII interface) is
included in this patch.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/configs/da8xx_omapl_defconfig          |    1 +
 arch/arm/mach-davinci/Kconfig                   |    8 +
 arch/arm/mach-davinci/Makefile                  |    1 +
 arch/arm/mach-davinci/board-mityomapl138.c      |  221 +++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/uncompress.h |    1 +
 5 files changed, 232 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-davinci/board-mityomapl138.c

diff --git a/arch/arm/configs/da8xx_omapl_defconfig b/arch/arm/configs/da8xx_omapl_defconfig
index 3952a4e..f8a47ee 100644
--- a/arch/arm/configs/da8xx_omapl_defconfig
+++ b/arch/arm/configs/da8xx_omapl_defconfig
@@ -17,6 +17,7 @@ CONFIG_MODVERSIONS=y
 CONFIG_ARCH_DAVINCI=y
 CONFIG_ARCH_DAVINCI_DA830=y
 CONFIG_ARCH_DAVINCI_DA850=y
+CONFIG_MACH_MITYOMAPL138=y
 CONFIG_DAVINCI_RESET_CLOCKS=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 2bf03e9..9aca60c 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -185,6 +185,14 @@ config MACH_TNETV107X
 	help
 	  Say Y here to select the TI TNETV107X Evaluation Module.
 
+config MACH_MITYOMAPL138
+	bool "Critical Link MityDSP-L138/MityARM-1808 SoM"
+	depends on ARCH_DAVINCI_DA850
+	help
+	  Say Y here to select the Critical Link MityDSP-L138/MityARM-1808
+	  System on Module.  Information on this SoM may be found at
+	  http://www.mitydsp.com
+
 config DAVINCI_MUX
 	bool "DAVINCI multiplexing support"
 	depends on ARCH_DAVINCI
diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index 77a0f71..a7a70d1 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_MACH_DAVINCI_DM365_EVM)	+= board-dm365-evm.o
 obj-$(CONFIG_MACH_DAVINCI_DA830_EVM)	+= board-da830-evm.o
 obj-$(CONFIG_MACH_DAVINCI_DA850_EVM)	+= board-da850-evm.o
 obj-$(CONFIG_MACH_TNETV107X)		+= board-tnetv107x-evm.o
+obj-$(CONFIG_MACH_MITYOMAPL138)		+= board-mityomapl138.o
 
 # Power Management
 obj-$(CONFIG_CPU_FREQ)			+= cpufreq.o
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
new file mode 100644
index 0000000..7146916
--- /dev/null
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -0,0 +1,221 @@
+/*
+ * Critical Link MityOMAP-L138 SoM
+ *
+ * Copyright (C) 2010 Critical Link LLC - http://www.criticallink.com
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of
+ * any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/partitions.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <mach/common.h>
+#include <mach/cp_intc.h>
+#include <mach/da8xx.h>
+#include <mach/nand.h>
+#include <mach/mux.h>
+
+#define MITYOMAPL138_PHY_MASK		0x08 /* hardcoded for now */
+#define MITYOMAPL138_MDIO_FREQUENCY	(2200000) /* PHY bus frequency */
+
+/*
+ * MityDSP-L138 includes a 256 MByte large-page NAND flash
+ * (128K blocks).
+ */
+struct mtd_partition mityomapl138_nandflash_partition[] = {
+	{
+		.name		= "rootfs",
+		.offset		= 0,
+		.size		= SZ_128M,
+		.mask_flags	= 0, /* MTD_WRITEABLE, */
+	},
+	{
+		.name		= "homefs",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= MTDPART_SIZ_FULL,
+		.mask_flags	= 0,
+	},
+};
+
+static struct davinci_nand_pdata mityomapl138_nandflash_data = {
+	.parts		= mityomapl138_nandflash_partition,
+	.nr_parts	= ARRAY_SIZE(mityomapl138_nandflash_partition),
+	.ecc_mode	= NAND_ECC_HW,
+	.options	= NAND_USE_FLASH_BBT | NAND_BUSWIDTH_16,
+	.ecc_bits	= 1, /* 4 bit mode is not supported with 16 bit NAND */
+};
+
+static struct resource mityomapl138_nandflash_resource[] = {
+	{
+		.start	= DA8XX_AEMIF_CS3_BASE,
+		.end	= DA8XX_AEMIF_CS3_BASE + SZ_512K + 2 * SZ_1K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= DA8XX_AEMIF_CTL_BASE,
+		.end	= DA8XX_AEMIF_CTL_BASE + SZ_32K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device mityomapl138_nandflash_device = {
+	.name		= "davinci_nand",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &mityomapl138_nandflash_data,
+	},
+	.num_resources	= ARRAY_SIZE(mityomapl138_nandflash_resource),
+	.resource	= mityomapl138_nandflash_resource,
+};
+
+static struct platform_device *mityomapl138_devices[] __initdata = {
+	&mityomapl138_nandflash_device,
+};
+
+static void __init mityomapl138_setup_nand(void)
+{
+	platform_add_devices(mityomapl138_devices,
+				 ARRAY_SIZE(mityomapl138_devices));
+}
+
+static struct davinci_uart_config mityomapl138_uart_config __initdata = {
+	.enabled_uarts = 0x7,
+};
+
+static const short mityomap_mii_pins[] = {
+	DA850_MII_TXEN, DA850_MII_TXCLK, DA850_MII_COL, DA850_MII_TXD_3,
+	DA850_MII_TXD_2, DA850_MII_TXD_1, DA850_MII_TXD_0, DA850_MII_RXER,
+	DA850_MII_CRS, DA850_MII_RXCLK, DA850_MII_RXDV, DA850_MII_RXD_3,
+	DA850_MII_RXD_2, DA850_MII_RXD_1, DA850_MII_RXD_0, DA850_MDIO_CLK,
+	DA850_MDIO_D,
+	-1
+};
+
+static const short mityomap_rmii_pins[] = {
+	DA850_RMII_TXD_0, DA850_RMII_TXD_1, DA850_RMII_TXEN,
+	DA850_RMII_CRS_DV, DA850_RMII_RXD_0, DA850_RMII_RXD_1,
+	DA850_RMII_RXER, DA850_RMII_MHZ_50_CLK, DA850_MDIO_CLK,
+	DA850_MDIO_D,
+	-1
+};
+
+static void __init mityomapl138_config_emac(void)
+{
+	void __iomem *cfg_chip3_base;
+	int ret;
+	u32 val;
+	struct davinci_soc_info *soc_info = &davinci_soc_info;
+
+	soc_info->emac_pdata->rmii_en = 0; /* hardcoded for now */
+
+	cfg_chip3_base = DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG);
+	val = __raw_readl(cfg_chip3_base);
+
+	if (soc_info->emac_pdata->rmii_en) {
+		val |= BIT(8);
+		ret = davinci_cfg_reg_list(mityomap_rmii_pins);
+		pr_info("RMII PHY configured\n");
+	} else {
+		val &= ~BIT(8);
+		ret = davinci_cfg_reg_list(mityomap_mii_pins);
+		pr_info("MII PHY configured\n");
+	}
+
+	if (ret) {
+		pr_warning("mii/rmii mux setup failed: %d\n", ret);
+		return;
+	}
+
+	/* configure the CFGCHIP3 register for RMII or MII */
+	__raw_writel(val, cfg_chip3_base);
+
+	soc_info->emac_pdata->phy_mask = MITYOMAPL138_PHY_MASK;
+	pr_debug("setting phy_mask to %x\n", soc_info->emac_pdata->phy_mask);
+	soc_info->emac_pdata->mdio_max_freq = MITYOMAPL138_MDIO_FREQUENCY;
+
+	ret = da8xx_register_emac();
+	if (ret)
+		pr_warning("emac registration failed: %d\n", ret);
+}
+
+static struct davinci_pm_config da850_pm_pdata = {
+	.sleepcount = 128,
+};
+
+static struct platform_device da850_pm_device = {
+	.name	= "pm-davinci",
+	.dev = {
+		.platform_data  = &da850_pm_pdata,
+	},
+	.id	= -1,
+};
+
+static void __init mityomapl138_init(void)
+{
+	int ret;
+
+	/* for now, no special EDMA channels are reserved */
+	ret = da850_register_edma(NULL);
+	if (ret)
+		pr_warning("edma registration failed: %d\n", ret);
+
+	ret = da8xx_register_watchdog();
+	if (ret)
+		pr_warning("watchdog registration failed: %d\n", ret);
+
+	davinci_serial_init(&mityomapl138_uart_config);
+
+	mityomapl138_setup_nand();
+
+	mityomapl138_config_emac();
+
+	ret = da8xx_register_rtc();
+	if (ret)
+		pr_warning("rtc setup failed: %d\n", ret);
+
+	ret = da850_register_cpufreq("pll0_sysclk3");
+	if (ret)
+		pr_warning("cpufreq registration failed: %d\n", ret);
+
+	ret = da8xx_register_cpuidle();
+	if (ret)
+		pr_warning("cpuidle registration failed: %d\n", ret);
+
+	ret = da850_register_pm(&da850_pm_device);
+	if (ret)
+		pr_warning("da850_evm_init: suspend registration failed: %d\n",
+				ret);
+}
+
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+static int __init mityomapl138_console_init(void)
+{
+	if (!machine_is_mityomapl138())
+		return 0;
+
+	return add_preferred_console("ttyS", 1, "115200");
+}
+console_initcall(mityomapl138_console_init);
+#endif
+
+static void __init mityomapl138_map_io(void)
+{
+	da850_init();
+}
+
+MACHINE_START(MITYOMAPL138, "MityDSP-L138/MityARM-1808")
+	.phys_io	= IO_PHYS,
+	.io_pg_offst	= (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
+	.boot_params	= (DA8XX_DDR_BASE + 0x100),
+	.map_io		= mityomapl138_map_io,
+	.init_irq	= cp_intc_init,
+	.timer		= &davinci_timer,
+	.init_machine	= mityomapl138_init,
+MACHINE_END
diff --git a/arch/arm/mach-davinci/include/mach/uncompress.h b/arch/arm/mach-davinci/include/mach/uncompress.h
index 15a6192..d370391 100644
--- a/arch/arm/mach-davinci/include/mach/uncompress.h
+++ b/arch/arm/mach-davinci/include/mach/uncompress.h
@@ -88,6 +88,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 		/* DA8xx boards */
 		DEBUG_LL_DA8XX(davinci_da830_evm,	2);
 		DEBUG_LL_DA8XX(davinci_da850_evm,	2);
+		DEBUG_LL_DA8XX(mityomapl138,		1);
 
 		/* TNETV107x boards */
 		DEBUG_LL_TNETV107X(tnetv107x,		1);
-- 
1.7.2.1
