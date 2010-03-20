From: leiwen@marvell.com (Lei Wen)
Date: Sat, 20 Mar 2010 19:01:23 +0800
Subject: [PATCH 01/29] pxa3xx_nand: condense the flash definition
Message-ID: <mailman.93.1280296561.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding a new flash definition would need less code.
Keep the platform passing flash definition method.
If one flash is both defined in platform data and builtin table,
driver would select the one from platform data first.

By this way, platform could select the timing most suit for itself,
not need to follow the common settings.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/plat-pxa/include/plat/pxa3xx_nand.h |   17 ++--
 drivers/mtd/nand/Kconfig                     |    7 -
 drivers/mtd/nand/pxa3xx_nand.c               |  175 +++-----------------------
 3 files changed, 27 insertions(+), 172 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
index 3478eae..0bf1bcf 100644
--- a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
+++ b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
@@ -30,15 +30,14 @@ struct pxa3xx_nand_cmdset {
 };

 struct pxa3xx_nand_flash {
-	const struct pxa3xx_nand_timing *timing; /* NAND Flash timing */
-	const struct pxa3xx_nand_cmdset *cmdset;
-
-	uint32_t page_per_block;/* Pages per block (PG_PER_BLK) */
-	uint32_t page_size;	/* Page size in bytes (PAGE_SZ) */
-	uint32_t flash_width;	/* Width of Flash memory (DWIDTH_M) */
-	uint32_t dfc_width;	/* Width of flash controller(DWIDTH_C) */
-	uint32_t num_blocks;	/* Number of physical blocks in Flash */
-	uint32_t chip_id;
+	uint32_t	chip_id;
+	uint16_t	page_per_block; /* Pages per block (PG_PER_BLK) */
+	uint16_t 	page_size;	/* Page size in bytes (PAGE_SZ) */
+	uint8_t		flash_width;	/* Width of Flash memory (DWIDTH_M) */
+	uint8_t 	dfc_width;	/* Width of flash controller(DWIDTH_C) */
+	uint32_t	num_blocks;	/* Number of physical blocks in Flash */
+	struct pxa3xx_nand_cmdset *cmdset;	/* NAND command set */
+	struct pxa3xx_nand_timing *timing;	/* NAND Flash timing */
 };

 struct pxa3xx_nand_platform_data {
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index ffc3720..cd30a5c 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -400,13 +400,6 @@ config MTD_NAND_PXA3xx
 	  This enables the driver for the NAND flash device found on
 	  PXA3xx processors

-config MTD_NAND_PXA3xx_BUILTIN
-	bool "Use builtin definitions for some NAND chips (deprecated)"
-	depends on MTD_NAND_PXA3xx
-	help
-	  This enables builtin definitions for some NAND chips. This
-	  is deprecated in favor of platform specific data.
-
 config MTD_NAND_CM_X270
 	tristate "Support for NAND Flash on CM-X270 modules"
 	depends on MTD_NAND && MACH_ARMCORE
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index e02fa4f..3ffcbcd 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -176,21 +176,7 @@ MODULE_PARM_DESC(use_dma, "enable DMA for data
transfering to/from NAND HW");
  */
 static struct pxa3xx_nand_timing default_timing;
 static struct pxa3xx_nand_flash default_flash;
-
-static struct pxa3xx_nand_cmdset smallpage_cmdset = {
-	.read1		= 0x0000,
-	.read2		= 0x0050,
-	.program	= 0x1080,
-	.read_status	= 0x0070,
-	.read_id	= 0x0090,
-	.erase		= 0xD060,
-	.reset		= 0x00FF,
-	.lock		= 0x002A,
-	.unlock		= 0x2423,
-	.lock_status	= 0x007A,
-};
-
-static struct pxa3xx_nand_cmdset largepage_cmdset = {
+static struct pxa3xx_nand_cmdset default_cmdset = {
 	.read1		= 0x3000,
 	.read2		= 0x0050,
 	.program	= 0x1080,
@@ -203,143 +189,26 @@ static struct pxa3xx_nand_cmdset largepage_cmdset = {
 	.lock_status	= 0x007A,
 };

-#ifdef CONFIG_MTD_NAND_PXA3xx_BUILTIN
-static struct pxa3xx_nand_timing samsung512MbX16_timing = {
-	.tCH	= 10,
-	.tCS	= 0,
-	.tWH	= 20,
-	.tWP	= 40,
-	.tRH	= 30,
-	.tRP	= 40,
-	.tR	= 11123,
-	.tWHR	= 110,
-	.tAR	= 10,
-};
-
-static struct pxa3xx_nand_flash samsung512MbX16 = {
-	.timing		= &samsung512MbX16_timing,
-	.cmdset		= &smallpage_cmdset,
-	.page_per_block	= 32,
-	.page_size	= 512,
-	.flash_width	= 16,
-	.dfc_width	= 16,
-	.num_blocks	= 4096,
-	.chip_id	= 0x46ec,
-};
-
-static struct pxa3xx_nand_flash samsung2GbX8 = {
-	.timing		= &samsung512MbX16_timing,
-	.cmdset		= &smallpage_cmdset,
-	.page_per_block	= 64,
-	.page_size	= 2048,
-	.flash_width	= 8,
-	.dfc_width	= 8,
-	.num_blocks	= 2048,
-	.chip_id	= 0xdaec,
-};
-
-static struct pxa3xx_nand_flash samsung32GbX8 = {
-	.timing		= &samsung512MbX16_timing,
-	.cmdset		= &smallpage_cmdset,
-	.page_per_block	= 128,
-	.page_size	= 4096,
-	.flash_width	= 8,
-	.dfc_width	= 8,
-	.num_blocks	= 8192,
-	.chip_id	= 0xd7ec,
+static struct pxa3xx_nand_timing __devinitdata timing[] = {
+	{ 10,  0, 20, 40, 30, 40, 11123, 110, 10, },
+	{ 10, 25, 15, 25, 15, 30, 25000,  60, 10, },
+	{ 10, 35, 15, 25, 15, 25, 25000,  60, 10, },
 };

-static struct pxa3xx_nand_timing micron_timing = {
-	.tCH	= 10,
-	.tCS	= 25,
-	.tWH	= 15,
-	.tWP	= 25,
-	.tRH	= 15,
-	.tRP	= 30,
-	.tR	= 25000,
-	.tWHR	= 60,
-	.tAR	= 10,
+#define NAND_SETTING_SAMSUNG     &default_cmdset, &timing[0]
+#define NAND_SETTING_MICRON      &default_cmdset, &timing[1]
+#define NAND_SETTING_ST          &default_cmdset, &timing[2]
+static struct pxa3xx_nand_flash __devinitdata builtin_flash_types[] = {
+	{ 0x46ec,  32,  512, 16, 16, 4096, NAND_SETTING_SAMSUNG, },
+	{ 0xdaec,  64, 2048,  8,  8, 2048, NAND_SETTING_SAMSUNG, },
+	{ 0xd7ec, 128, 4096,  8,  8, 8192, NAND_SETTING_SAMSUNG, },
+	{ 0xa12c,  64, 2048,  8,  8, 1024, NAND_SETTING_MICRON, },
+	{ 0xb12c,  64, 2048, 16, 16, 1024, NAND_SETTING_MICRON, },
+	{ 0xdc2c,  64, 2048,  8,  8, 4096, NAND_SETTING_MICRON, },
+	{ 0xcc2c,  64, 2048, 16, 16, 4096, NAND_SETTING_MICRON, },
+	{ 0xba20,  64, 2048, 16, 16, 2048, NAND_SETTING_ST, },
 };

-static struct pxa3xx_nand_flash micron1GbX8 = {
-	.timing		= &micron_timing,
-	.cmdset		= &largepage_cmdset,
-	.page_per_block	= 64,
-	.page_size	= 2048,
-	.flash_width	= 8,
-	.dfc_width	= 8,
-	.num_blocks	= 1024,
-	.chip_id	= 0xa12c,
-};
-
-static struct pxa3xx_nand_flash micron1GbX16 = {
-	.timing		= &micron_timing,
-	.cmdset		= &largepage_cmdset,
-	.page_per_block	= 64,
-	.page_size	= 2048,
-	.flash_width	= 16,
-	.dfc_width	= 16,
-	.num_blocks	= 1024,
-	.chip_id	= 0xb12c,
-};
-
-static struct pxa3xx_nand_flash micron4GbX8 = {
-	.timing		= &micron_timing,
-	.cmdset		= &largepage_cmdset,
-	.page_per_block	= 64,
-	.page_size	= 2048,
-	.flash_width	= 8,
-	.dfc_width	= 8,
-	.num_blocks	= 4096,
-	.chip_id	= 0xdc2c,
-};
-
-static struct pxa3xx_nand_flash micron4GbX16 = {
-	.timing		= &micron_timing,
-	.cmdset		= &largepage_cmdset,
-	.page_per_block	= 64,
-	.page_size	= 2048,
-	.flash_width	= 16,
-	.dfc_width	= 16,
-	.num_blocks	= 4096,
-	.chip_id	= 0xcc2c,
-};
-
-static struct pxa3xx_nand_timing stm2GbX16_timing = {
-	.tCH = 10,
-	.tCS = 35,
-	.tWH = 15,
-	.tWP = 25,
-	.tRH = 15,
-	.tRP = 25,
-	.tR = 25000,
-	.tWHR = 60,
-	.tAR = 10,
-};
-
-static struct pxa3xx_nand_flash stm2GbX16 = {
-	.timing = &stm2GbX16_timing,
-	.cmdset	= &largepage_cmdset,
-	.page_per_block = 64,
-	.page_size = 2048,
-	.flash_width = 16,
-	.dfc_width = 16,
-	.num_blocks = 2048,
-	.chip_id = 0xba20,
-};
-
-static struct pxa3xx_nand_flash *builtin_flash_types[] = {
-	&samsung512MbX16,
-	&samsung2GbX8,
-	&samsung32GbX8,
-	&micron1GbX8,
-	&micron1GbX16,
-	&micron4GbX8,
-	&micron4GbX16,
-	&stm2GbX16,
-};
-#endif /* CONFIG_MTD_NAND_PXA3xx_BUILTIN */
-
 #define NDTR0_tCH(c)	(min((c), 7) << 19)
 #define NDTR0_tCS(c)	(min((c), 7) << 16)
 #define NDTR0_tWH(c)	(min((c), 7) << 11)
@@ -1027,11 +896,6 @@ static int pxa3xx_nand_detect_config(struct
pxa3xx_nand_info *info)
 	default_flash.flash_width = ndcr & NDCR_DWIDTH_M ? 16 : 8;
 	default_flash.dfc_width = ndcr & NDCR_DWIDTH_C ? 16 : 8;

-	if (default_flash.page_size == 2048)
-		default_flash.cmdset = &largepage_cmdset;
-	else
-		default_flash.cmdset = &smallpage_cmdset;
-
 	/* set info fields needed to __readid */
 	info->flash_info = &default_flash;
 	info->read_id_bytes = (default_flash.page_size == 2048) ? 4 : 2;
@@ -1068,6 +932,7 @@ static int pxa3xx_nand_detect_config(struct
pxa3xx_nand_info *info)

 	pxa3xx_nand_detect_timing(info, &default_timing);
 	default_flash.timing = &default_timing;
+	default_flash.cmdset = &default_cmdset;

 	return 0;
 }
@@ -1096,10 +961,9 @@ static int pxa3xx_nand_detect_flash(struct
pxa3xx_nand_info *info,
 			return 0;
 	}

-#ifdef CONFIG_MTD_NAND_PXA3xx_BUILTIN
 	for (i = 0; i < ARRAY_SIZE(builtin_flash_types); i++) {

-		f = builtin_flash_types[i];
+		f = &builtin_flash_types[i];

 		if (pxa3xx_nand_config_flash(info, f))
 			continue;
@@ -1110,7 +974,6 @@ static int pxa3xx_nand_detect_flash(struct
pxa3xx_nand_info *info,
 		if (id == f->chip_id)
 			return 0;
 	}
-#endif

 	dev_warn(&info->pdev->dev,
 		 "failed to detect configured nand flash; found %04x instead of\n",
-- 
1.7.0.4
