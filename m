From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 19 Nov 2010 22:12:11 +0100
Subject: [PATCH 3/4] mtd: FSMC NAND use the PrimeCell identifier macros
Message-ID: <1290201131-15297-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The FSMC actually has a standard ARM PrimeCell ID register, and
the "revision" part of that register contains the thing that
the code is looking at. Reuse the infrastructure from the AMBA
bus abstraction and rid local defines.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mtd/nand/fsmc_nand.c |   23 ++++++++++++++++++++---
 include/linux/mtd/fsmc.h     |   19 -------------------
 2 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index 7405bf5..204e156 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -31,6 +31,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/mtd/fsmc.h>
+#include <linux/amba/bus.h>
 #include <mtd/mtd-abi.h>
 
 static struct nand_ecclayout fsmc_ecc1_layout = {
@@ -184,8 +185,9 @@ const char *part_probes[] = { "cmdlinepart", NULL };
 #endif
 
 /**
- * struct fsmc_nand_data - atructure for FSMC NAND device state
+ * struct fsmc_nand_data - structure for FSMC NAND device state
  *
+ * @pid:		Part ID on the AMBA PrimeCell format
  * @mtd:		MTD info for a NAND flash.
  * @nand:		Chip related info for a NAND flash.
  * @partitions:		Partition info for a NAND Flash.
@@ -201,6 +203,7 @@ const char *part_probes[] = { "cmdlinepart", NULL };
  * @regs_va:		FSMC regs base address.
  */
 struct fsmc_nand_data {
+	u32			pid;
 	struct mtd_info		mtd;
 	struct nand_chip	nand;
 	struct mtd_partition	*partitions;
@@ -541,6 +544,8 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	struct fsmc_regs *regs;
 	struct resource *res;
 	int ret = 0;
+	u32 pid;
+	int i;
 
 	if (!pdata) {
 		dev_err(&pdev->dev, "platform data is NULL\n");
@@ -630,6 +635,18 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_probe1;
 
+	/*
+	 * This device ID is actually a common AMBA ID as used on the
+	 * AMBA PrimeCell bus. However it is not a PrimeCell.
+	 */
+	for (pid = 0, i = 0; i < 4; i++)
+		pid |= (readl(host->regs_va + resource_size(res) - 0x20 + 4 * i) & 255) << (i * 8);
+	host->pid = pid;
+	dev_info(&pdev->dev, "FSMC device partno %03x, manufacturer %02x, "
+		 "revision %02x, config %02x\n",
+		 AMBA_PART_BITS(pid), AMBA_MANF_BITS(pid),
+		 AMBA_REV_BITS(pid), AMBA_CONFIG_BITS(pid));
+
 	host->bank = pdata->bank;
 	host->select_chip = pdata->select_bank;
 	regs = host->regs_va;
@@ -657,7 +674,7 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 
 	fsmc_nand_setup(regs, host->bank, nand->options & NAND_BUSWIDTH_16);
 
-	if (get_fsmc_version(host->regs_va) == FSMC_VER8) {
+	if (AMBA_REV_BITS(host->pid) >= 8) {
 		nand->ecc.read_page = fsmc_read_page_hwecc;
 		nand->ecc.calculate = fsmc_read_hwecc_ecc4;
 		nand->ecc.correct = fsmc_correct_data;
@@ -677,7 +694,7 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 		goto err_probe;
 	}
 
-	if (get_fsmc_version(host->regs_va) == FSMC_VER8) {
+	if (AMBA_REV_BITS(host->pid) >= 8) {
 		if (host->mtd.writesize == 512) {
 			nand->ecc.layout = &fsmc_ecc4_sp_layout;
 			host->ecc_place = &fsmc_ecc4_sp_place;
diff --git a/include/linux/mtd/fsmc.h b/include/linux/mtd/fsmc.h
index ed14564..91f5e6f 100644
--- a/include/linux/mtd/fsmc.h
+++ b/include/linux/mtd/fsmc.h
@@ -114,25 +114,6 @@ struct fsmc_regs {
 #define FSMC_THOLD_4		(4 << 16)
 #define FSMC_THIZ_1		(1 << 24)
 
-/* peripid2 register definitions */
-#define FSMC_REVISION_MSK	(0xf)
-#define FSMC_REVISION_SHFT	(0x4)
-
-#define FSMC_VER1		1
-#define FSMC_VER2		2
-#define FSMC_VER3		3
-#define FSMC_VER4		4
-#define FSMC_VER5		5
-#define FSMC_VER6		6
-#define FSMC_VER7		7
-#define FSMC_VER8		8
-
-static inline u32 get_fsmc_version(struct fsmc_regs *regs)
-{
-	return (readl(&regs->peripid2) >> FSMC_REVISION_SHFT) &
-				FSMC_REVISION_MSK;
-}
-
 /*
  * There are 13 bytes of ecc for every 512 byte block in FSMC version 8
  * and it has to be read consecutively and immediately after the 512
-- 
1.7.3.2
