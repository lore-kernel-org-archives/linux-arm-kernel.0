From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 6 Oct 2009 18:19:36 -0400
Subject: [PATCH 1/2] Update ts72xx to use generic platform nand driver
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB7967@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the ts72xx platform's nand driver support.

This changes the ts72xx platform from using a custom nand driver
(ts7250.c) to the generic platform nand driver (plat_nand.c).

Tested on TS-7250 with 32MB NAND.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Tested-by: Matthieu Crapet <mcrapet@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: <linux-mtd@lists.infradead.org>

---

diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 259f782..bbb757b 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -16,6 +16,8 @@
 #include <linux/io.h>
 #include <linux/m48t86.h>
 #include <linux/mtd/physmap.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
 
 #include <mach/hardware.h>
 #include <mach/ts72xx.h>
@@ -54,92 +56,185 @@ static struct map_desc ts72xx_io_desc[] __initdata = {
 	}
 };
 
-static struct map_desc ts72xx_nand_io_desc[] __initdata = {
+static void __init ts72xx_map_io(void)
+{
+	ep93xx_map_io();
+	iotable_init(ts72xx_io_desc, ARRAY_SIZE(ts72xx_io_desc));
+}
+
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
+	struct nand_chip *chip = mtd->priv;
+
+	if (ctrl & NAND_CTRL_CHANGE) {
+		void __iomem *addr = chip->IO_ADDR_R;
+		unsigned char bits;
+
+		addr += (1 << TS72XX_NAND_CONTROL_ADDR_LINE);
+
+		bits = (ctrl & NAND_NCE) << 2;	/* bit 0 -> bit 2 */
+		bits |= ctrl & NAND_CLE;	/* bit 1 -> bit 1 */
+		bits |= (ctrl & NAND_ALE) >> 2;	/* bit 2 -> bit 0 */
+
+		__raw_writeb((__raw_readb(addr) & ~0x7) | bits, addr);
+	}
+
+	if (cmd != NAND_CMD_NONE)
+		__raw_writeb(cmd, chip->IO_ADDR_W);
+}
+
+static int ts72xx_nand_device_ready(struct mtd_info *mtd)
+{
+	struct nand_chip *chip = mtd->priv;
+	void __iomem *addr = chip->IO_ADDR_R;
+
+	addr += (1 << TS72XX_NAND_BUSY_ADDR_LINE);
+
+	return __raw_readb(addr) & 0x20;
+}
+
+static const char *ts72xx_nand_part_probes[] = { "cmdlinepart", NULL };
+
+#define TS72XX_BOOTROM_PART_SIZE	(SZ_16K)
+#define TS72XX_REDBOOT_PART_SIZE	(SZ_2M + SZ_1M)
+
+static struct mtd_partition ts72xx_part_info32[] = {
 	{
-		.virtual	= TS72XX_NAND_DATA_VIRT_BASE,
-		.pfn		= __phys_to_pfn(TS72XX_NAND1_DATA_PHYS_BASE),
-		.length		= TS72XX_NAND_DATA_SIZE,
-		.type		= MT_DEVICE,
+		.name		= "TS-BOOTROM",
+		.offset		= 0,
+		.size		= TS72XX_BOOTROM_PART_SIZE,
 	}, {
-		.virtual	= TS72XX_NAND_CONTROL_VIRT_BASE,
-		.pfn		= __phys_to_pfn(TS72XX_NAND1_CONTROL_PHYS_BASE),
-		.length		= TS72XX_NAND_CONTROL_SIZE,
-		.type		= MT_DEVICE,
+		.name		= "Linux",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= SZ_32M - TS72XX_REDBOOT_PART_SIZE,
 	}, {
-		.virtual	= TS72XX_NAND_BUSY_VIRT_BASE,
-		.pfn		= __phys_to_pfn(TS72XX_NAND1_BUSY_PHYS_BASE),
-		.length		= TS72XX_NAND_BUSY_SIZE,
-		.type		= MT_DEVICE,
-	}
+		.name		= "RedBoot",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= MTDPART_SIZ_FULL,
+	},
 };
 
-static struct map_desc ts72xx_alternate_nand_io_desc[] __initdata = {
+static struct mtd_partition ts72xx_part_info128[] = {
 	{
-		.virtual	= TS72XX_NAND_DATA_VIRT_BASE,
-		.pfn		= __phys_to_pfn(TS72XX_NAND2_DATA_PHYS_BASE),
-		.length		= TS72XX_NAND_DATA_SIZE,
-		.type		= MT_DEVICE,
+		.name		= "TS-BOOTROM",
+		.offset		= 0,
+		.size		= TS72XX_BOOTROM_PART_SIZE,
 	}, {
-		.virtual	= TS72XX_NAND_CONTROL_VIRT_BASE,
-		.pfn		= __phys_to_pfn(TS72XX_NAND2_CONTROL_PHYS_BASE),
-		.length		= TS72XX_NAND_CONTROL_SIZE,
-		.type		= MT_DEVICE,
+		.name		= "Linux",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= SZ_128M - TS72XX_REDBOOT_PART_SIZE,
 	}, {
-		.virtual	= TS72XX_NAND_BUSY_VIRT_BASE,
-		.pfn		= __phys_to_pfn(TS72XX_NAND2_BUSY_PHYS_BASE),
-		.length		= TS72XX_NAND_BUSY_SIZE,
-		.type		= MT_DEVICE,
-	}
+		.name		= "RedBoot",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= MTDPART_SIZ_FULL,
+	},
 };
 
-static void __init ts72xx_map_io(void)
+static void ts72xx_nand_set_parts(uint64_t size,
+				  struct platform_nand_chip *chip)
 {
-	ep93xx_map_io();
-	iotable_init(ts72xx_io_desc, ARRAY_SIZE(ts72xx_io_desc));
-
-	/*
-	 * The TS-7200 has NOR flash, the other models have NAND flash.
-	 */
-	if (!board_is_ts7200()) {
-		if (is_ts9420_installed()) {
-			iotable_init(ts72xx_alternate_nand_io_desc,
-				ARRAY_SIZE(ts72xx_alternate_nand_io_desc));
-		} else {
-			iotable_init(ts72xx_nand_io_desc,
-				ARRAY_SIZE(ts72xx_nand_io_desc));
-		}
+	switch (size) {
+	case SZ_32M:
+		chip->partitions = ts72xx_part_info32;
+		chip->nr_partitions = ARRAY_SIZE(ts72xx_part_info32);
+		break;
+	case SZ_128M:
+		chip->partitions = ts72xx_part_info128;
+		chip->nr_partitions = ARRAY_SIZE(ts72xx_part_info128);
+		break;
+	default:
+		pr_warning("ts72xx: Unknown nand disk size:%lluMB\n", size >> 20);
+		break;
 	}
 }
 
+static struct platform_nand_data ts72xx_nand_data = {
+	.chip = {
+		.nr_chips	= 1,
+		.chip_offset	= 0,
+		.chip_delay	= 15,
+		.part_probe_types = ts72xx_nand_part_probes,
+		.set_parts	= ts72xx_nand_set_parts,
+	},
+	.ctrl = {
+		.cmd_ctrl	= ts72xx_nand_hwcontrol,
+		.dev_ready	= ts72xx_nand_device_ready,
+	},
+};
+
+static struct resource ts7250_nand_resource[] = {
+	{
+		.start		= EP93XX_CS6_PHYS_BASE,
+		.end		= EP93XX_CS6_PHYS_BASE + SZ_16M - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct resource ts9420_nand_resource[] = {
+	{
+		.start		= EP93XX_CS7_PHYS_BASE,
+		.end		= EP93XX_CS7_PHYS_BASE + SZ_16M - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device ts72xx_nand_flash = {
+	.name			= "gen_nand",
+	.id			= -1,
+	.dev.platform_data	= &ts72xx_nand_data,
+};
+
+
 /*************************************************************************
  * NOR flash (TS-7200 only)
  *************************************************************************/
-static struct physmap_flash_data ts72xx_flash_data = {
+static struct physmap_flash_data ts72xx_nor_data = {
 	.width		= 2,
 };
 
-static struct resource ts72xx_flash_resource = {
+static struct resource ts72xx_nor_resource = {
 	.start		= EP93XX_CS6_PHYS_BASE,
 	.end		= EP93XX_CS6_PHYS_BASE + SZ_16M - 1,
 	.flags		= IORESOURCE_MEM,
 };
 
-static struct platform_device ts72xx_flash = {
+static struct platform_device ts72xx_nor_flash = {
 	.name		= "physmap-flash",
 	.id		= 0,
 	.dev		= {
-		.platform_data	= &ts72xx_flash_data,
+		.platform_data	= &ts72xx_nor_data,
 	},
 	.num_resources	= 1,
-	.resource	= &ts72xx_flash_resource,
+	.resource	= &ts72xx_nor_resource,
 };
 
 static void __init ts72xx_register_flash(void)
 {
-	if (board_is_ts7200())
-		platform_device_register(&ts72xx_flash);
+	if (board_is_ts7200()) {
+		platform_device_register(&ts72xx_nor_flash);
+	} else {
+		if (is_ts9420_installed()) {
+			ts72xx_nand_flash.resource = ts9420_nand_resource;
+			ts72xx_nand_flash.num_resources =
+					ARRAY_SIZE(ts9420_nand_resource);
+		} else {
+			ts72xx_nand_flash.resource = ts7250_nand_resource;
+			ts72xx_nand_flash.num_resources =
+					ARRAY_SIZE(ts7250_nand_resource);
+		}
+		platform_device_register(&ts72xx_nand_flash);
+	}
 }
 
+
 static unsigned char ts72xx_rtc_readbyte(unsigned long addr)
 {
 	__raw_writeb(addr, TS72XX_RTC_INDEX_VIRT_BASE); 
