From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Dec 2015 23:26:00 +0100
Subject: [PATCH 05/23] mtd: nand: jz4770: kill the ->ecc_layout field
In-Reply-To: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449527178-5930-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

->ecc_layout is not used by any board file. Kill this field to avoid any
confusion. New boards are encouraged to use the default ECC layout defined
in NAND core.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/mips/include/asm/mach-jz4740/jz4740_nand.h | 2 --
 drivers/mtd/nand/jz4740_nand.c                  | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/arch/mips/include/asm/mach-jz4740/jz4740_nand.h b/arch/mips/include/asm/mach-jz4740/jz4740_nand.h
index 79cff26..398733e 100644
--- a/arch/mips/include/asm/mach-jz4740/jz4740_nand.h
+++ b/arch/mips/include/asm/mach-jz4740/jz4740_nand.h
@@ -25,8 +25,6 @@ struct jz_nand_platform_data {
 	int			num_partitions;
 	struct mtd_partition	*partitions;
 
-	struct nand_ecclayout	*ecc_layout;
-
 	unsigned char banks[JZ_NAND_NUM_BANKS];
 
 	void (*ident_callback)(struct platform_device *, struct nand_chip *,
diff --git a/drivers/mtd/nand/jz4740_nand.c b/drivers/mtd/nand/jz4740_nand.c
index 5a99a93..c4fe446 100644
--- a/drivers/mtd/nand/jz4740_nand.c
+++ b/drivers/mtd/nand/jz4740_nand.c
@@ -446,9 +446,6 @@ static int jz_nand_probe(struct platform_device *pdev)
 	chip->ecc.bytes		= 9;
 	chip->ecc.strength	= 4;
 
-	if (pdata)
-		chip->ecc.layout = pdata->ecc_layout;
-
 	chip->chip_delay = 50;
 	chip->cmd_ctrl = jz_nand_cmd_ctrl;
 	chip->select_chip = jz_nand_select_chip;
-- 
2.1.4
