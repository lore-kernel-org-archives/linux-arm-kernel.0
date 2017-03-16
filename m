From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 16 Mar 2017 09:02:42 +0100
Subject: [PATCH v3 3/3] mtd: nand: Remove unused chip->write_page() hook
In-Reply-To: <1489651362-17077-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1489651362-17077-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1489651362-17077-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The last/only user of the chip->write_page() hook (the Atmel NAND
controller driver) has been reworked and is no longer specifying a custom
->write_page() implementation.
Drop this hook before someone else start abusing it.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/nand_base.c | 12 +++++-------
 include/linux/mtd/nand.h     |  4 ----
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index b0524f8accb6..a28be471ebe0 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -2637,7 +2637,7 @@ static int nand_write_page_syndrome(struct mtd_info *mtd,
 }
 
 /**
- * nand_write_page - [REPLACEABLE] write one page
+ * nand_write_page - write one page
  * @mtd: MTD device structure
  * @chip: NAND chip descriptor
  * @offset: address offset within the page
@@ -2840,9 +2840,10 @@ static int nand_do_write_ops(struct mtd_info *mtd, loff_t to,
 			/* We still need to erase leftover OOB data */
 			memset(chip->oob_poi, 0xff, mtd->oobsize);
 		}
-		ret = chip->write_page(mtd, chip, column, bytes, wbuf,
-					oob_required, page, cached,
-					(ops->mode == MTD_OPS_RAW));
+
+		ret = nand_write_page(mtd, chip, column, bytes, wbuf,
+				      oob_required, page, cached,
+				      (ops->mode == MTD_OPS_RAW));
 		if (ret)
 			break;
 
@@ -4663,9 +4664,6 @@ int nand_scan_tail(struct mtd_info *mtd)
 		}
 	}
 
-	if (!chip->write_page)
-		chip->write_page = nand_write_page;
-
 	/*
 	 * Check ECC mode, default to software if 3byte/512byte hardware ECC is
 	 * selected and we have 256 byte pagesize fallback to software ECC
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 9591e0fbe5bd..37f02cbb7a06 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -822,7 +822,6 @@ nand_get_sdr_timings(const struct nand_data_interface *conf)
  * @errstat:		[OPTIONAL] hardware specific function to perform
  *			additional error status checks (determine if errors are
  *			correctable).
- * @write_page:		[REPLACEABLE] High-level page write function
  */
 
 struct nand_chip {
@@ -847,9 +846,6 @@ struct nand_chip {
 	int (*scan_bbt)(struct mtd_info *mtd);
 	int (*errstat)(struct mtd_info *mtd, struct nand_chip *this, int state,
 			int status, int page);
-	int (*write_page)(struct mtd_info *mtd, struct nand_chip *chip,
-			uint32_t offset, int data_len, const uint8_t *buf,
-			int oob_required, int page, int cached, int raw);
 	int (*onfi_set_features)(struct mtd_info *mtd, struct nand_chip *chip,
 			int feature_addr, uint8_t *subfeature_para);
 	int (*onfi_get_features)(struct mtd_info *mtd, struct nand_chip *chip,
-- 
2.7.4
