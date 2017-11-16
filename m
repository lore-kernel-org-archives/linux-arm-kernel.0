From: lukma@denx.de (Lukasz Majewski)
Date: Fri, 17 Nov 2017 00:22:38 +0100
Subject: [PATCH 3/4] ARM: ep93xx: ts72xx: Exclude reusable part of the ts72xx
 board
In-Reply-To: <20171116232239.16823-1-lukma@denx.de>
References: <20171116232239.16823-1-lukma@denx.de>
Message-ID: <20171116232239.16823-4-lukma@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit creates a new file ts72xx-common.c [1], which consists
of code being potentially re-usable by other clones of reference
ts72xx design.

To achieve this goal, a new symbol - TS72XX_COMMON has been introduced.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 arch/arm/mach-ep93xx/Kconfig         |   4 +
 arch/arm/mach-ep93xx/Makefile        |   1 +
 arch/arm/mach-ep93xx/ts72xx-common.c | 158 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-ep93xx/ts72xx.c        | 122 +--------------------------
 arch/arm/mach-ep93xx/ts72xx.h        |   5 ++
 5 files changed, 172 insertions(+), 118 deletions(-)
 create mode 100644 arch/arm/mach-ep93xx/ts72xx-common.c

diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
index 61a75ca3684e..16c5d6eedf45 100644
--- a/arch/arm/mach-ep93xx/Kconfig
+++ b/arch/arm/mach-ep93xx/Kconfig
@@ -131,10 +131,14 @@ config MACH_SNAPPER_CL15
 
 config MACH_TS72XX
 	bool "Support Technologic Systems TS-72xx SBC"
+	select TS72XX_COMMON
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Technologic Systems TS-72xx board.
 
+config TS72XX_COMMON
+	bool
+
 config MACH_VISION_EP9307
 	bool "Support Vision Engraving Systems EP9307 SoM"
 	help
diff --git a/arch/arm/mach-ep93xx/Makefile b/arch/arm/mach-ep93xx/Makefile
index b7ae4345ac08..f2692a072864 100644
--- a/arch/arm/mach-ep93xx/Makefile
+++ b/arch/arm/mach-ep93xx/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_MACH_SIM_ONE)	+= simone.o
 obj-$(CONFIG_MACH_SNAPPER_CL15)	+= snappercl15.o
 obj-$(CONFIG_MACH_TS72XX)	+= ts72xx.o
 obj-$(CONFIG_MACH_VISION_EP9307)+= vision_ep9307.o
+obj-$(CONFIG_TS72XX_COMMON)	+= ts72xx-common.o
diff --git a/arch/arm/mach-ep93xx/ts72xx-common.c b/arch/arm/mach-ep93xx/ts72xx-common.c
new file mode 100644
index 000000000000..6d8b3896a75b
--- /dev/null
+++ b/arch/arm/mach-ep93xx/ts72xx-common.c
@@ -0,0 +1,158 @@
+/*
+ * ts72xx - common platform code (like NAND access)
+ *
+ * Copyright (C) 2017
+ * Lukasz Majewski, DENX Software Engineering, lukma at denx.de
+ *
+ * SPDX-License-Identifier:	GPL-2.0+
+ */
+
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/mtd/rawnand.h>
+#include <linux/mtd/partitions.h>
+
+#include <mach/hardware.h>
+
+#include <asm/mach/map.h>
+
+#include "soc.h"
+#include "ts72xx.h"
+
+/*************************************************************************
+ * IO map
+ *************************************************************************/
+static struct map_desc ts72xx_common_io_desc[] __initdata = {
+	{
+		.virtual	= (unsigned long)TS72XX_MODEL_VIRT_BASE,
+		.pfn		= __phys_to_pfn(TS72XX_MODEL_PHYS_BASE),
+		.length		= TS72XX_MODEL_SIZE,
+		.type		= MT_DEVICE,
+	}
+};
+
+void __init ts72xx_common_map_io(void)
+{
+	ep93xx_map_io();
+	iotable_init(ts72xx_common_io_desc, ARRAY_SIZE(ts72xx_common_io_desc));
+}
+
+/*************************************************************************
+ * NAND flash
+ *************************************************************************/
+#define TS72XX_NAND_CONTROL_ADDR_LINE	22	/* 0xN0400000 */
+#define TS72XX_NAND_BUSY_ADDR_LINE	23	/* 0xN0800000 */
+
+static void ts72xx_nand_hwcontrol(struct mtd_info *mtd,
+				  int cmd, unsigned int ctrl)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (ctrl & NAND_CTRL_CHANGE) {
+		void __iomem *addr = chip->IO_ADDR_R;
+		unsigned char bits;
+
+		addr += (1 << TS72XX_NAND_CONTROL_ADDR_LINE);
+
+		bits = __raw_readb(addr) & ~0x07;
+		bits |= (ctrl & NAND_NCE) << 2;	/* bit 0 -> bit 2 */
+		bits |= (ctrl & NAND_CLE);	/* bit 1 -> bit 1 */
+		bits |= (ctrl & NAND_ALE) >> 2;	/* bit 2 -> bit 0 */
+
+		__raw_writeb(bits, addr);
+	}
+
+	if (cmd != NAND_CMD_NONE)
+		__raw_writeb(cmd, chip->IO_ADDR_W);
+}
+
+static int ts72xx_nand_device_ready(struct mtd_info *mtd)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	void __iomem *addr = chip->IO_ADDR_R;
+
+	addr += (1 << TS72XX_NAND_BUSY_ADDR_LINE);
+
+	return !!(__raw_readb(addr) & 0x20);
+}
+
+static struct platform_nand_data ts72xx_nand_data = {
+	.chip = {
+		.nr_chips	= 1,
+		.chip_offset	= 0,
+		.chip_delay	= 15,
+	},
+	.ctrl = {
+		.cmd_ctrl	= ts72xx_nand_hwcontrol,
+		.dev_ready	= ts72xx_nand_device_ready,
+	},
+};
+
+static struct resource ts72xx_nand_resource[] = {
+	DEFINE_RES_MEM(EP93XX_CS6_PHYS_BASE, SZ_16M),
+};
+
+static struct platform_device ts72xx_nand_flash = {
+	.name			= "gen_nand",
+	.id			= -1,
+	.dev.platform_data	= &ts72xx_nand_data,
+	.resource		= ts72xx_nand_resource,
+	.num_resources		= ARRAY_SIZE(ts72xx_nand_resource),
+};
+
+void __init ts72xx_register_flash(struct mtd_partition *parts, int n)
+{
+	/*
+	 * TS7200 has NOR flash all other TS72xx board have NAND flash.
+	 */
+	if (board_is_ts7200()) {
+		ep93xx_register_flash(2, EP93XX_CS6_PHYS_BASE, SZ_16M);
+	} else {
+		resource_size_t start;
+
+		if (is_ts9420_installed())
+			start = EP93XX_CS7_PHYS_BASE;
+		else
+			start = EP93XX_CS6_PHYS_BASE;
+
+		ts72xx_nand_resource[0].start = start;
+		ts72xx_nand_resource[0].end = start + SZ_16M - 1;
+
+		ts72xx_nand_data.chip.partitions = parts;
+		ts72xx_nand_data.chip.nr_partitions = n;
+
+		platform_device_register(&ts72xx_nand_flash);
+	}
+}
+
+/*************************************************************************
+ * WATCHDOG
+ *************************************************************************/
+static struct resource ts72xx_wdt_resources[] = {
+	DEFINE_RES_MEM(TS72XX_WDT_CONTROL_PHYS_BASE, SZ_4K),
+	DEFINE_RES_MEM(TS72XX_WDT_FEED_PHYS_BASE, SZ_4K),
+};
+
+static struct platform_device ts72xx_wdt_device = {
+	.name		= "ts72xx-wdt",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(ts72xx_wdt_resources),
+	.resource	= ts72xx_wdt_resources,
+};
+
+void __init ts72xx_register_watchdog(void)
+{
+	platform_device_register(&ts72xx_wdt_device);
+}
+
+/*************************************************************************
+ * ETH
+ *************************************************************************/
+static struct ep93xx_eth_data ts72xx_eth_data = {
+	.phy_id		= 1,
+};
+
+void __init ts72xx_register_eth(void)
+{
+	ep93xx_register_eth(&ts72xx_eth_data, 1);
+}
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 06345b85f27c..d8bb352a5422 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -30,11 +30,6 @@
 
 static struct map_desc ts72xx_io_desc[] __initdata = {
 	{
-		.virtual	= (unsigned long)TS72XX_MODEL_VIRT_BASE,
-		.pfn		= __phys_to_pfn(TS72XX_MODEL_PHYS_BASE),
-		.length		= TS72XX_MODEL_SIZE,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (unsigned long)TS72XX_OPTIONS_VIRT_BASE,
 		.pfn		= __phys_to_pfn(TS72XX_OPTIONS_PHYS_BASE),
 		.length		= TS72XX_OPTIONS_SIZE,
@@ -49,50 +44,10 @@ static struct map_desc ts72xx_io_desc[] __initdata = {
 
 static void __init ts72xx_map_io(void)
 {
-	ep93xx_map_io();
+	ts72xx_common_map_io();
 	iotable_init(ts72xx_io_desc, ARRAY_SIZE(ts72xx_io_desc));
 }
 
-
-/*************************************************************************
- * NAND flash
- *************************************************************************/
-#define TS72XX_NAND_CONTROL_ADDR_LINE	22	/* 0xN0400000 */
-#define TS72XX_NAND_BUSY_ADDR_LINE	23	/* 0xN0800000 */
-
-static void ts72xx_nand_hwcontrol(struct mtd_info *mtd,
-				  int cmd, unsigned int ctrl)
-{
-	struct nand_chip *chip = mtd_to_nand(mtd);
-
-	if (ctrl & NAND_CTRL_CHANGE) {
-		void __iomem *addr = chip->IO_ADDR_R;
-		unsigned char bits;
-
-		addr += (1 << TS72XX_NAND_CONTROL_ADDR_LINE);
-
-		bits = __raw_readb(addr) & ~0x07;
-		bits |= (ctrl & NAND_NCE) << 2;	/* bit 0 -> bit 2 */
-		bits |= (ctrl & NAND_CLE);	/* bit 1 -> bit 1 */
-		bits |= (ctrl & NAND_ALE) >> 2;	/* bit 2 -> bit 0 */
-
-		__raw_writeb(bits, addr);
-	}
-
-	if (cmd != NAND_CMD_NONE)
-		__raw_writeb(cmd, chip->IO_ADDR_W);
-}
-
-static int ts72xx_nand_device_ready(struct mtd_info *mtd)
-{
-	struct nand_chip *chip = mtd_to_nand(mtd);
-	void __iomem *addr = chip->IO_ADDR_R;
-
-	addr += (1 << TS72XX_NAND_BUSY_ADDR_LINE);
-
-	return !!(__raw_readb(addr) & 0x20);
-}
-
 #define TS72XX_BOOTROM_PART_SIZE	(SZ_16K)
 #define TS72XX_REDBOOT_PART_SIZE	(SZ_2M + SZ_1M)
 
@@ -115,59 +70,6 @@ static struct mtd_partition ts72xx_nand_parts[] = {
 	},
 };
 
-static struct platform_nand_data ts72xx_nand_data = {
-	.chip = {
-		.nr_chips	= 1,
-		.chip_offset	= 0,
-		.chip_delay	= 15,
-		.partitions	= ts72xx_nand_parts,
-		.nr_partitions	= ARRAY_SIZE(ts72xx_nand_parts),
-	},
-	.ctrl = {
-		.cmd_ctrl	= ts72xx_nand_hwcontrol,
-		.dev_ready	= ts72xx_nand_device_ready,
-	},
-};
-
-static struct resource ts72xx_nand_resource[] = {
-	{
-		.start		= 0,			/* filled in later */
-		.end		= 0,			/* filled in later */
-		.flags		= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device ts72xx_nand_flash = {
-	.name			= "gen_nand",
-	.id			= -1,
-	.dev.platform_data	= &ts72xx_nand_data,
-	.resource		= ts72xx_nand_resource,
-	.num_resources		= ARRAY_SIZE(ts72xx_nand_resource),
-};
-
-
-static void __init ts72xx_register_flash(void)
-{
-	/*
-	 * TS7200 has NOR flash all other TS72xx board have NAND flash.
-	 */
-	if (board_is_ts7200()) {
-		ep93xx_register_flash(2, EP93XX_CS6_PHYS_BASE, SZ_16M);
-	} else {
-		resource_size_t start;
-
-		if (is_ts9420_installed())
-			start = EP93XX_CS7_PHYS_BASE;
-		else
-			start = EP93XX_CS6_PHYS_BASE;
-
-		ts72xx_nand_resource[0].start = start;
-		ts72xx_nand_resource[0].end = start + SZ_16M - 1;
-
-		platform_device_register(&ts72xx_nand_flash);
-	}
-}
-
 /*************************************************************************
  * RTC M48T86
  *************************************************************************/
@@ -186,22 +88,6 @@ static struct platform_device ts72xx_rtc_device = {
 	.num_resources 	= ARRAY_SIZE(ts72xx_rtc_resources),
 };
 
-static struct resource ts72xx_wdt_resources[] = {
-	DEFINE_RES_MEM(TS72XX_WDT_CONTROL_PHYS_BASE, SZ_4K),
-	DEFINE_RES_MEM(TS72XX_WDT_FEED_PHYS_BASE, SZ_4K),
-};
-
-static struct platform_device ts72xx_wdt_device = {
-	.name		= "ts72xx-wdt",
-	.id		= -1,
-	.num_resources 	= ARRAY_SIZE(ts72xx_wdt_resources),
-	.resource	= ts72xx_wdt_resources,
-};
-
-static struct ep93xx_eth_data __initdata ts72xx_eth_data = {
-	.phy_id		= 1,
-};
-
 #if IS_ENABLED(CONFIG_FPGA_MGR_TS73XX)
 
 /* Relative to EP93XX_CS1_PHYS_BASE */
@@ -223,11 +109,11 @@ static struct platform_device ts73xx_fpga_device = {
 static void __init ts72xx_init_machine(void)
 {
 	ep93xx_init_devices();
-	ts72xx_register_flash();
+	ts72xx_register_flash(ts72xx_nand_parts, ARRAY_SIZE(ts72xx_nand_parts));
 	platform_device_register(&ts72xx_rtc_device);
-	platform_device_register(&ts72xx_wdt_device);
+	ts72xx_register_watchdog();
+	ts72xx_register_eth();
 
-	ep93xx_register_eth(&ts72xx_eth_data, 1);
 #if IS_ENABLED(CONFIG_FPGA_MGR_TS73XX)
 	if (board_is_ts7300())
 		platform_device_register(&ts73xx_fpga_device);
diff --git a/arch/arm/mach-ep93xx/ts72xx.h b/arch/arm/mach-ep93xx/ts72xx.h
index d67f203f769a..a9d3bb49f666 100644
--- a/arch/arm/mach-ep93xx/ts72xx.h
+++ b/arch/arm/mach-ep93xx/ts72xx.h
@@ -87,5 +87,10 @@ static inline int is_ts9420_installed(void)
 	return !!(__raw_readb(TS72XX_OPTIONS2_VIRT_BASE) &
 					TS72XX_OPTIONS2_TS9420);
 }
+
+void __init ts72xx_register_flash(struct mtd_partition *parts, int n);
+void __init ts72xx_register_watchdog(void);
+void __init ts72xx_common_map_io(void);
+void __init ts72xx_register_eth(void);
 #endif
 #endif /* __TS72XX_H_ */
-- 
2.11.0
