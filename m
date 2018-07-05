From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Thu,  5 Jul 2018 12:27:30 +0200
Subject: [PATCH 5/8] mtd: rawnand: Rename nand_default_bbt() into
 nand_create_bbt()
In-Reply-To: <20180705102733.29673-1-boris.brezillon@bootlin.com>
References: <20180705102733.29673-1-boris.brezillon@bootlin.com>
Message-ID: <20180705102733.29673-6-boris.brezillon@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename nand_default_bbt() into nand_create_bbt() and pass it a nand_chip
object to prepare removal of the chip->scan_bbt() hook.

We add a temporary nand_default_bbt() wrapper which will be dropped
after the removal of ->scan_bbt().

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c |  5 +++++
 drivers/mtd/nand/raw/nand_bbt.c  | 10 +++++-----
 include/linux/mtd/rawnand.h      |  2 +-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index faac82b1e058..0476e13d47b1 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4924,6 +4924,11 @@ static void nand_shutdown(struct mtd_info *mtd)
 	nand_get_device(mtd, FL_PM_SUSPENDED);
 }
 
+static int nand_default_bbt(struct mtd_info *mtd)
+{
+	return nand_create_bbt(mtd_to_nand(mtd));
+}
+
 /* Set default functions */
 static void nand_set_defaults(struct nand_chip *chip)
 {
diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
index d9f4ceff2568..39db352f8757 100644
--- a/drivers/mtd/nand/raw/nand_bbt.c
+++ b/drivers/mtd/nand/raw/nand_bbt.c
@@ -1349,15 +1349,14 @@ static int nand_create_badblock_pattern(struct nand_chip *this)
 }
 
 /**
- * nand_default_bbt - [NAND Interface] Select a default bad block table for the device
- * @mtd: MTD device structure
+ * nand_create_bbt - [NAND Interface] Select a default bad block table for the device
+ * @this: NAND chip object
  *
  * This function selects the default bad block table support for the device and
  * calls the nand_scan_bbt function.
  */
-int nand_default_bbt(struct mtd_info *mtd)
+int nand_create_bbt(struct nand_chip *this)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	int ret;
 
 	/* Is a flash based bad block table requested? */
@@ -1383,8 +1382,9 @@ int nand_default_bbt(struct mtd_info *mtd)
 			return ret;
 	}
 
-	return nand_scan_bbt(mtd, this->badblock_pattern);
+	return nand_scan_bbt(nand_to_mtd(this), this->badblock_pattern);
 }
+EXPORT_SYMBOL(nand_create_bbt);
 
 /**
  * nand_isreserved_bbt - [NAND Interface] Check if a block is reserved
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 83ab6779144e..186f9fb1e7eb 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1538,7 +1538,7 @@ extern const struct nand_manufacturer_ops micron_nand_manuf_ops;
 extern const struct nand_manufacturer_ops amd_nand_manuf_ops;
 extern const struct nand_manufacturer_ops macronix_nand_manuf_ops;
 
-int nand_default_bbt(struct mtd_info *mtd);
+int nand_create_bbt(struct nand_chip *chip);
 int nand_markbad_bbt(struct mtd_info *mtd, loff_t offs);
 int nand_isreserved_bbt(struct mtd_info *mtd, loff_t offs);
 int nand_isbad_bbt(struct mtd_info *mtd, loff_t offs, int allowbbt);
-- 
2.14.1
