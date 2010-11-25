From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 25 Nov 2010 11:33:13 +0800
Subject: [PATCH] ARM: mmp: append brownstone support
Message-ID: <1290655993-27748-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-mmp/Kconfig      |   15 +++-
 arch/arm/mach-mmp/Makefile     |    1 +
 arch/arm/mach-mmp/brownstone.c |  167 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 181 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-mmp/brownstone.c

diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index fd18d33..67793a6 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -37,6 +37,17 @@ config MACH_TTC_DKB
 	  Say 'Y' here if you want to support the Marvell PXA910-based
 	  TTC_DKB Development Board.
 
+config MACH_BROWNSTONE
+	bool "Marvell's Brownstone Development Platform"
+	depends on !CPU_MOHAWK
+	select CPU_MMP2
+	help
+	  Say 'Y' here if you want to support the Marvell MMP2-based
+	  Brown Development Platform.
+	  MMP2-based board can't be co-existed with PXA168-based &
+	  PXA910-based development board. Since MMP2 is compatible to
+	  ARMv7 architecture.
+
 config MACH_FLINT
 	bool "Marvell's Flint Development Platform"
 	depends on !CPU_MOHAWK
@@ -46,7 +57,7 @@ config MACH_FLINT
 	  Flint Development Platform.
 	  MMP2-based board can't be co-existed with PXA168-based &
 	  PXA910-based development board. Since MMP2 is compatible to
-	  ARMv6 architecture.
+	  ARMv7 architecture.
 
 config MACH_MARVELL_JASPER
 	bool "Marvell's Jasper Development Platform"
@@ -57,7 +68,7 @@ config MACH_MARVELL_JASPER
 	  Jasper Development Platform.
 	  MMP2-based board can't be co-existed with PXA168-based &
 	  PXA910-based development board. Since MMP2 is compatible to
-	  ARMv6 architecture.
+	  ARMv7 architecture.
 
 config MACH_TETON_BGA
 	bool "Marvell's PXA168 Teton BGA Development Board"
diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index 751cdbf..5c68382 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_MACH_ZYLONITE2)	+= aspenite.o
 obj-$(CONFIG_MACH_AVENGERS_LITE)+= avengers_lite.o
 obj-$(CONFIG_MACH_TAVOREVB)	+= tavorevb.o
 obj-$(CONFIG_MACH_TTC_DKB)	+= ttc_dkb.o
+obj-$(CONFIG_MACH_BROWNSTONE)	+= brownstone.o
 obj-$(CONFIG_MACH_FLINT)	+= flint.o
 obj-$(CONFIG_MACH_MARVELL_JASPER) += jasper.o
 obj-$(CONFIG_MACH_TETON_BGA)	+= teton_bga.o
diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
new file mode 100644
index 0000000..ae7daab
--- /dev/null
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -0,0 +1,167 @@
+/*
+ *  linux/arch/arm/mach-mmp/brownstone.c
+ *
+ *  Support for the Marvell Brownstone Development Platform.
+ *
+ *  Copyright (C) 2009-2010 Marvell International Ltd.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/max8649.h>
+#include <linux/mfd/max8925.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <mach/addr-map.h>
+#include <mach/mfp-mmp2.h>
+#include <mach/mmp2.h>
+#include <mach/irqs.h>
+
+#include "common.h"
+
+#define BROWNSTONE_NR_IRQS	(IRQ_BOARD_START + 40)
+
+static unsigned long brownstone_pin_config[] __initdata = {
+	/* UART1 */
+	GPIO29_UART1_RXD,
+	GPIO30_UART1_TXD,
+
+	/* UART3 */
+	GPIO51_UART3_RXD,
+	GPIO52_UART3_TXD,
+
+	/* DFI */
+	GPIO168_DFI_D0,
+	GPIO167_DFI_D1,
+	GPIO166_DFI_D2,
+	GPIO165_DFI_D3,
+	GPIO107_DFI_D4,
+	GPIO106_DFI_D5,
+	GPIO105_DFI_D6,
+	GPIO104_DFI_D7,
+	GPIO111_DFI_D8,
+	GPIO164_DFI_D9,
+	GPIO163_DFI_D10,
+	GPIO162_DFI_D11,
+	GPIO161_DFI_D12,
+	GPIO110_DFI_D13,
+	GPIO109_DFI_D14,
+	GPIO108_DFI_D15,
+	GPIO143_ND_nCS0,
+	GPIO144_ND_nCS1,
+	GPIO147_ND_nWE,
+	GPIO148_ND_nRE,
+	GPIO150_ND_ALE,
+	GPIO149_ND_CLE,
+	GPIO112_ND_RDY0,
+	GPIO160_ND_RDY1,
+
+	/* PMIC */
+	PMIC_PMIC_INT | MFP_LPM_EDGE_FALL,
+
+	/* MMC0 */
+	GPIO131_MMC1_DAT3 | MFP_PULL_HIGH,
+	GPIO132_MMC1_DAT2 | MFP_PULL_HIGH,
+	GPIO133_MMC1_DAT1 | MFP_PULL_HIGH,
+	GPIO134_MMC1_DAT0 | MFP_PULL_HIGH,
+	GPIO136_MMC1_CMD | MFP_PULL_HIGH,
+	GPIO139_MMC1_CLK,
+	GPIO140_MMC1_CD | MFP_PULL_LOW,
+	GPIO141_MMC1_WP | MFP_PULL_LOW,
+
+	/* MMC1 */
+	GPIO37_MMC2_DAT3 | MFP_PULL_HIGH,
+	GPIO38_MMC2_DAT2 | MFP_PULL_HIGH,
+	GPIO39_MMC2_DAT1 | MFP_PULL_HIGH,
+	GPIO40_MMC2_DAT0 | MFP_PULL_HIGH,
+	GPIO41_MMC2_CMD | MFP_PULL_HIGH,
+	GPIO42_MMC2_CLK,
+
+	/* MMC2 */
+	GPIO165_MMC3_DAT7 | MFP_PULL_HIGH,
+	GPIO162_MMC3_DAT6 | MFP_PULL_HIGH,
+	GPIO166_MMC3_DAT5 | MFP_PULL_HIGH,
+	GPIO163_MMC3_DAT4 | MFP_PULL_HIGH,
+	GPIO167_MMC3_DAT3 | MFP_PULL_HIGH,
+	GPIO164_MMC3_DAT2 | MFP_PULL_HIGH,
+	GPIO168_MMC3_DAT1 | MFP_PULL_HIGH,
+	GPIO111_MMC3_DAT0 | MFP_PULL_HIGH,
+	GPIO112_MMC3_CMD | MFP_PULL_HIGH,
+	GPIO151_MMC3_CLK,
+};
+
+static struct regulator_consumer_supply max8649_supply[] = {
+	REGULATOR_SUPPLY("vcc_core", NULL),
+};
+
+static struct regulator_init_data max8649_init_data = {
+	.constraints	= {
+		.name		= "vcc_core range",
+		.min_uV		= 1150000,
+		.max_uV		= 1280000,
+		.always_on	= 1,
+		.boot_on	= 1,
+		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &max8649_supply[0],
+};
+
+static struct max8649_platform_data brownstone_max8649_info = {
+	.mode		= 2,	/* VID1 = 1, VID0 = 0 */
+	.extclk		= 0,
+	.ramp_timing	= MAX8649_RAMP_32MV,
+	.regulator	= &max8649_init_data,
+};
+
+static struct max8925_platform_data brownstone_max8925_info = {
+	.irq_base		= IRQ_BOARD_START,
+};
+
+static struct i2c_board_info brownstone_twsi1_info[] = {
+	[0] = {
+		.type		= "max8649",
+		.addr		= 0x60,
+		.platform_data	= &brownstone_max8649_info,
+	},
+	[1] = {
+		.type		= "max8925",
+		.addr		= 0x3c,
+		.irq		= IRQ_MMP2_PMIC,
+		.platform_data	= &brownstone_max8925_info,
+	},
+};
+
+static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 = {
+	.max_speed	= 25000000,
+};
+
+static void __init brownstone_init(void)
+{
+	mfp_config(ARRAY_AND_SIZE(brownstone_pin_config));
+
+	/* on-chip devices */
+	mmp2_add_uart(1);
+	mmp2_add_uart(3);
+	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(brownstone_twsi1_info));
+	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
+}
+
+MACHINE_START(BROWNSTONE, "Brownstone Development Platform")
+	/* Maintainer: Haojian Zhuang <haojian.zhuang@marvell.com> */
+	.map_io		= mmp_map_io,
+	.nr_irqs	= BROWNSTONE_NR_IRQS,
+	.init_irq	= mmp2_init_irq,
+	.timer		= &mmp2_timer,
+	.init_machine	= brownstone_init,
+MACHINE_END
+
-- 
1.5.6.5
