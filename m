From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 29 Nov 2010 13:52:06 +0100
Subject: [PATCH 1/3] mtd: FSMC NAND remove PARTITION macro and fix compile
	noise
Message-ID: <1291035126-17770-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the PARTITION macro that David didn't like and also
removes a local variable that was dangling unused in some #ifdefs
by being a bit more clever.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mtd/nand/fsmc_nand.c |   66 ++++++++++++++++++++++++++++++-----------
 1 files changed, 48 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index 02edfba..5af4b3c 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -119,21 +119,36 @@ static struct fsmc_eccplace fsmc_ecc4_sp_place = {
 	}
 };
 
-/*
- * Default partition tables to be used if the partition information not
- * provided through platform data
- */
-#define PARTITION(n, off, sz)	{.name = n, .offset = off, .size = sz}
 
+#ifdef CONFIG_MTD_PARTITIONS
 /*
+ * Default partition tables to be used if the partition information not
+ * provided through platform data.
+ *
  * Default partition layout for small page(= 512 bytes) devices
  * Size for "Root file system" is updated in driver based on actual device size
  */
 static struct mtd_partition partition_info_16KB_blk[] = {
-	PARTITION("X-loader", 0, 4 * 0x4000),
-	PARTITION("U-Boot", 0x10000, 20 * 0x4000),
-	PARTITION("Kernel", 0x60000, 256 * 0x4000),
-	PARTITION("Root File System", 0x460000, 0),
+	{
+		.name = "X-loader",
+		.offset = 0,
+		.size = 4*0x4000,
+	},
+	{
+		.name = "U-Boot",
+		.offset = 0x10000,
+		.size = 20*0x4000,
+	},
+	{
+		.name = "Kernel",
+		.offset = 0x60000,
+		.size = 256*0x4000,
+	},
+	{
+		.name = "Root File System",
+		.offset = 0x460000,
+		.size = 0,
+	},
 };
 
 /*
@@ -141,15 +156,32 @@ static struct mtd_partition partition_info_16KB_blk[] = {
  * Size for "Root file system" is updated in driver based on actual device size
  */
 static struct mtd_partition partition_info_128KB_blk[] = {
-	PARTITION("X-loader", 0, 4 * 0x20000),
-	PARTITION("U-Boot", 0x80000, 12 * 0x20000),
-	PARTITION("Kernel", 0x200000, 48 * 0x20000),
-	PARTITION("Root File System", 0x800000, 0),
+	{
+		.name = "X-loader",
+		.offset = 0,
+		.size = 4*0x20000,
+	},
+	{
+		.name = "U-Boot",
+		.offset = 0x80000,
+		.size = 12*0x20000,
+	},
+	{
+		.name = "Kernel",
+		.offset = 0x200000,
+		.size = 48*0x20000,
+	},
+	{
+		.name = "Root File System",
+		.offset = 0x800000,
+		.size = 0,
+	},
 };
 
 #ifdef CONFIG_MTD_CMDLINE_PARTS
 const char *part_probes[] = { "cmdlinepart", NULL };
 #endif
+#endif
 
 /**
  * struct fsmc_nand_data - atructure for FSMC NAND device state
@@ -508,7 +540,7 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	struct nand_chip *nand;
 	struct fsmc_regs *regs;
 	struct resource *res;
-	int nr_parts, ret = 0;
+	int ret = 0;
 
 	if (!pdata) {
 		dev_err(&pdev->dev, "platform data is NULL\n");
@@ -676,11 +708,9 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	 * Check if partition info passed via command line
 	 */
 	host->mtd.name = "nand";
-	nr_parts = parse_mtd_partitions(&host->mtd, part_probes,
+	host->nr_partitions = parse_mtd_partitions(&host->mtd, part_probes,
 			&host->partitions, 0);
-	if (nr_parts > 0) {
-		host->nr_partitions = nr_parts;
-	} else {
+	if (host->nr_partitions <= 0) {
 #endif
 		/*
 		 * Check if partition info passed via command line
-- 
1.7.3.2
