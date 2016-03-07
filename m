From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 17:18:22 +0100
Subject: [PATCH 05/16] mtd: nand: export default read/write oob functions
In-Reply-To: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457367513-26069-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Export the default read/write oob functions (for the standard and syndrome
scheme), so that drivers can use them for their raw implementation and
implement their own functions for the normal oob operation.

This is required if your ECC engine is capable of fixing some of the OOB
data. In this case you have to overload the ->read_oob() and ->write_oob(),
but if you don't specify the ->read/write_oob_raw() functions they are
assigned to the ->read/write_oob() implementation, which is not what you
want.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/nand_base.c | 18 ++++++++++--------
 include/linux/mtd/nand.h     | 14 ++++++++++++++
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index f2c8ff3..b8cfeb7 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -1924,13 +1924,13 @@ static int nand_read(struct mtd_info *mtd, loff_t from, size_t len,
  * @chip: nand chip info structure
  * @page: page number to read
  */
-static int nand_read_oob_std(struct mtd_info *mtd, struct nand_chip *chip,
-			     int page)
+int nand_read_oob_std(struct mtd_info *mtd, struct nand_chip *chip, int page)
 {
 	chip->cmdfunc(mtd, NAND_CMD_READOOB, 0, page);
 	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
 	return 0;
 }
+EXPORT_SYMBOL(nand_read_oob_std);
 
 /**
  * nand_read_oob_syndrome - [REPLACEABLE] OOB data read function for HW ECC
@@ -1939,8 +1939,8 @@ static int nand_read_oob_std(struct mtd_info *mtd, struct nand_chip *chip,
  * @chip: nand chip info structure
  * @page: page number to read
  */
-static int nand_read_oob_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
-				  int page)
+int nand_read_oob_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
+			   int page)
 {
 	int length = mtd->oobsize;
 	int chunk = chip->ecc.bytes + chip->ecc.prepad + chip->ecc.postpad;
@@ -1968,6 +1968,7 @@ static int nand_read_oob_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
 
 	return 0;
 }
+EXPORT_SYMBOL(nand_read_oob_syndrome);
 
 /**
  * nand_write_oob_std - [REPLACEABLE] the most common OOB data write function
@@ -1975,8 +1976,7 @@ static int nand_read_oob_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
  * @chip: nand chip info structure
  * @page: page number to write
  */
-static int nand_write_oob_std(struct mtd_info *mtd, struct nand_chip *chip,
-			      int page)
+int nand_write_oob_std(struct mtd_info *mtd, struct nand_chip *chip, int page)
 {
 	int status = 0;
 	const uint8_t *buf = chip->oob_poi;
@@ -1991,6 +1991,7 @@ static int nand_write_oob_std(struct mtd_info *mtd, struct nand_chip *chip,
 
 	return status & NAND_STATUS_FAIL ? -EIO : 0;
 }
+EXPORT_SYMBOL(nand_write_oob_std);
 
 /**
  * nand_write_oob_syndrome - [REPLACEABLE] OOB data write function for HW ECC
@@ -1999,8 +2000,8 @@ static int nand_write_oob_std(struct mtd_info *mtd, struct nand_chip *chip,
  * @chip: nand chip info structure
  * @page: page number to write
  */
-static int nand_write_oob_syndrome(struct mtd_info *mtd,
-				   struct nand_chip *chip, int page)
+int nand_write_oob_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
+			    int page)
 {
 	int chunk = chip->ecc.bytes + chip->ecc.prepad + chip->ecc.postpad;
 	int eccsize = chip->ecc.size, length = mtd->oobsize;
@@ -2050,6 +2051,7 @@ static int nand_write_oob_syndrome(struct mtd_info *mtd,
 
 	return status & NAND_STATUS_FAIL ? -EIO : 0;
 }
+EXPORT_SYMBOL(nand_write_oob_syndrome);
 
 /**
  * nand_do_read_oob - [INTERN] NAND read out-of-band
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 7604f4b..19b2f7d 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -1070,4 +1070,18 @@ int nand_check_erased_ecc_chunk(void *data, int datalen,
 				void *ecc, int ecclen,
 				void *extraoob, int extraooblen,
 				int threshold);
+
+/* Default write_oob implementation */
+int nand_write_oob_std(struct mtd_info *mtd, struct nand_chip *chip, int page);
+
+/* Default write_oob syndrome implementation */
+int nand_write_oob_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
+			    int page);
+
+/* Default read_oob implementation */
+int nand_read_oob_std(struct mtd_info *mtd, struct nand_chip *chip, int page);
+
+/* Default read_oob syndrome implementation */
+int nand_read_oob_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
+			   int page);
 #endif /* __LINUX_MTD_NAND_H */
-- 
2.1.4
