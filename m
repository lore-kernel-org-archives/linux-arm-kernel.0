From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:52 +0100
Subject: [PATCH 44/52] mtd: rawnand: add a field in nand_chip to fill an array
 of IDs
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-45-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an alternate way to give to the core another ID table to later
remove the one given in nand_scan_ident() as part of the migration to
nand_scan().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c | 8 ++++++--
 include/linux/mtd/rawnand.h      | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 182904b2fc07..0d850dbf843d 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5594,8 +5594,12 @@ static int nand_detect(struct nand_chip *chip, struct nand_flash_dev *type)
 	manufacturer = nand_get_manufacturer(maf_id);
 	chip->manufacturer.desc = manufacturer;
 
-	if (!type)
-		type = nand_flash_ids;
+	if (!type) {
+		if (chip->flash_ids)
+			type = chip->flash_ids;
+		else
+			type = nand_flash_ids;
+	}
 
 	/*
 	 * Save the NAND_BUSWIDTH_16 flag before letting auto-detection logic
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 53bb6ef1a7c2..318c73a206fc 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1201,6 +1201,7 @@ int nand_op_parser_exec_op(struct nand_chip *chip,
  *			  chipnr is set to %NAND_DATA_IFACE_CHECK_ONLY this
  *			  means the configuration should not be applied but
  *			  only checked.
+ * @flash_ids:		[OPTIONAL] local NAND flash ID table
  * @bbt:		[INTERN] bad block table pointer
  * @bbt_td:		[REPLACEABLE] bad block table descriptor for flash
  *			lookup.
@@ -1287,6 +1288,8 @@ struct nand_chip {
 	unsigned long buf_align;
 	struct nand_hw_control hwcontrol;
 
+	struct nand_flash_dev *flash_ids;
+
 	uint8_t *bbt;
 	struct nand_bbt_descr *bbt_td;
 	struct nand_bbt_descr *bbt_md;
-- 
2.14.1
