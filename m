From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 6 Sep 2011 08:53:43 +0200
Subject: [PATCH v4] mach-realview: expose PB1176 ROM using physmap and map_rom
Message-ID: <1315292023-4125-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This exposes the PB1176 ROM if you compile in the MTD physmap
mapping and also the map_rom chiptype.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-realview/include/mach/board-pb1176.h |    1 +
 arch/arm/mach-realview/realview_pb1176.c           |   45 ++++++++++++++++----
 2 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-realview/include/mach/board-pb1176.h b/arch/arm/mach-realview/include/mach/board-pb1176.h
index 002ab5d..2a15fef 100644
--- a/arch/arm/mach-realview/include/mach/board-pb1176.h
+++ b/arch/arm/mach-realview/include/mach/board-pb1176.h
@@ -70,6 +70,7 @@
 
 #define REALVIEW_DC1176_GIC_CPU_BASE		0x10120000 /* GIC CPU interface, on devchip */
 #define REALVIEW_DC1176_GIC_DIST_BASE		0x10121000 /* GIC distributor, on devchip */
+#define REALVIEW_DC1176_ROM_BASE		0x10200000 /* 16KiB NRAM preudo-ROM, on devchip */
 #define REALVIEW_PB1176_GIC_CPU_BASE		0x10040000 /* GIC CPU interface, on FPGA */
 #define REALVIEW_PB1176_GIC_DIST_BASE		0x10041000 /* GIC distributor, on FPGA */
 #define REALVIEW_PB1176_L220_BASE		0x10110000 /* L220 registers */
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index ad5671a..dfbaeca 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -26,6 +26,8 @@
 #include <linux/amba/pl061.h>
 #include <linux/amba/mmci.h>
 #include <linux/amba/pl022.h>
+#include <linux/mtd/physmap.h>
+#include <linux/mtd/partitions.h>
 #include <linux/io.h>
 
 #include <mach/hardware.h>
@@ -204,22 +206,48 @@ static struct amba_device *amba_devs[] __initdata = {
  * RealView PB1176 platform devices
  */
 static struct resource realview_pb1176_flash_resources[] = {
-	[0] = {
+	{
 		.start		= REALVIEW_PB1176_FLASH_BASE,
 		.end		= REALVIEW_PB1176_FLASH_BASE + REALVIEW_PB1176_FLASH_SIZE - 1,
 		.flags		= IORESOURCE_MEM,
 	},
-	[1] = {
+#ifdef CONFIG_REALVIEW_PB1176_SECURE_FLASH
+	{
 		.start		= REALVIEW_PB1176_SEC_FLASH_BASE,
 		.end		= REALVIEW_PB1176_SEC_FLASH_BASE + REALVIEW_PB1176_SEC_FLASH_SIZE - 1,
 		.flags		= IORESOURCE_MEM,
 	},
-};
-#ifdef CONFIG_REALVIEW_PB1176_SECURE_FLASH
-#define PB1176_FLASH_BLOCKS	2
-#else
-#define PB1176_FLASH_BLOCKS	1
 #endif
+};
+
+static struct physmap_flash_data pb1176_rom_pdata = {
+	.probe_type	= "map_rom",
+	.width		= 4,
+	.nr_parts	= 0,
+};
+
+static struct resource pb1176_rom_resources[] = {
+	/*
+	 * This exposes the PB1176 DevChip ROM as an MTD ROM mapping.
+	 * The reference manual states that this is actually a pseudo-ROM
+	 * programmed in NVRAM.
+	 */
+	{
+		.start		= REALVIEW_DC1176_ROM_BASE,
+		.end		= REALVIEW_DC1176_ROM_BASE + SZ_16K - 1,
+		.flags		= IORESOURCE_MEM,
+	}
+};
+
+static struct platform_device pb1176_rom_device = {
+	.name		= "physmap-flash",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(pb1176_rom_resources),
+	.resource	= pb1176_rom_resources,
+	.dev = {
+		.platform_data = &pb1176_rom_pdata,
+	},
+};
 
 static struct resource realview_pb1176_smsc911x_resources[] = {
 	[0] = {
@@ -338,7 +366,8 @@ static void __init realview_pb1176_init(void)
 #endif
 
 	realview_flash_register(realview_pb1176_flash_resources,
-				PB1176_FLASH_BLOCKS);
+				ARRAY_SIZE(realview_pb1176_flash_resources));
+	platform_device_register(&pb1176_rom_device);
 	realview_eth_register(NULL, realview_pb1176_smsc911x_resources);
 	platform_device_register(&realview_i2c_device);
 	realview_usb_register(realview_pb1176_isp1761_resources);
-- 
1.7.3.2
