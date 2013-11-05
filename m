From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue,  5 Nov 2013 09:55:20 -0300
Subject: [PATCH v3 13/28] mtd: nand: pxa3xx: Add bad block handling
In-Reply-To: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1383656135-8627-14-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for flash-based bad block table using Marvell's
custom in-flash bad block table layout. The support is enabled
a 'flash_bbt' platform data or device tree parameter.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c                | 33 +++++++++++++++++++++++++++
 include/linux/platform_data/mtd-nand-pxa3xx.h |  3 +++
 2 files changed, 36 insertions(+)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index e198c94..9a5913d 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_mtd.h>
 
 #if defined(CONFIG_ARCH_PXA) || defined(CONFIG_ARCH_MMP)
 #define ARCH_HAS_DMA
@@ -245,6 +246,29 @@ static struct pxa3xx_nand_flash builtin_flash_types[] = {
 { "256MiB 16-bit", 0xba20,  64, 2048, 16, 16, 2048, &timing[3] },
 };
 
+static u8 bbt_pattern[] = {'M', 'V', 'B', 'b', 't', '0' };
+static u8 bbt_mirror_pattern[] = {'1', 't', 'b', 'B', 'V', 'M' };
+
+static struct nand_bbt_descr bbt_main_descr = {
+	.options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE
+		| NAND_BBT_2BIT | NAND_BBT_VERSION,
+	.offs =	8,
+	.len = 6,
+	.veroffs = 14,
+	.maxblocks = 8,		/* Last 8 blocks in each chip */
+	.pattern = bbt_pattern
+};
+
+static struct nand_bbt_descr bbt_mirror_descr = {
+	.options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE
+		| NAND_BBT_2BIT | NAND_BBT_VERSION,
+	.offs =	8,
+	.len = 6,
+	.veroffs = 14,
+	.maxblocks = 8,		/* Last 8 blocks in each chip */
+	.pattern = bbt_mirror_pattern
+};
+
 /* Define a default flash type setting serve as flash detecting only */
 #define DEFAULT_FLASH_TYPE (&builtin_flash_types[0])
 
@@ -1128,6 +1152,14 @@ KEEP_CONFIG:
 
 	if (nand_scan_ident(mtd, 1, def))
 		return -ENODEV;
+
+	if (pdata->flash_bbt) {
+		chip->bbt_options |= NAND_BBT_USE_FLASH |
+				     NAND_BBT_NO_OOB_BBM;
+		chip->bbt_td = &bbt_main_descr;
+		chip->bbt_md = &bbt_mirror_descr;
+	}
+
 	/* calculate addressing information */
 	if (mtd->writesize >= 2048)
 		host->col_addr_cycles = 2;
@@ -1323,6 +1355,7 @@ static int pxa3xx_nand_probe_dt(struct platform_device *pdev)
 	if (of_get_property(np, "marvell,nand-keep-config", NULL))
 		pdata->keep_config = 1;
 	of_property_read_u32(np, "num-cs", &pdata->num_cs);
+	pdata->flash_bbt = of_get_nand_on_flash_bbt(np);
 
 	pdev->dev.platform_data = pdata;
 
diff --git a/include/linux/platform_data/mtd-nand-pxa3xx.h b/include/linux/platform_data/mtd-nand-pxa3xx.h
index ffb8019..a941471 100644
--- a/include/linux/platform_data/mtd-nand-pxa3xx.h
+++ b/include/linux/platform_data/mtd-nand-pxa3xx.h
@@ -55,6 +55,9 @@ struct pxa3xx_nand_platform_data {
 	/* indicate how many chip selects will be used */
 	int	num_cs;
 
+	/* use an flash-based bad block table */
+	bool	flash_bbt;
+
 	const struct mtd_partition		*parts[NUM_CHIP_SELECT];
 	unsigned int				nr_parts[NUM_CHIP_SELECT];
 
-- 
1.8.1.5
