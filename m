From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 20 Jul 2018 17:15:25 +0200
Subject: [PATCH v4 33/35] mtd: rawnand: do not export nand_scan_[ident|tail]()
 anymore
In-Reply-To: <20180720151527.16038-1-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
Message-ID: <20180720151527.16038-34-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both nand_scan_ident() and nand_scan_tail() helpers used to be called
directly from controller drivers that needed to tweak some ECC-related
parameters before nand_scan_tail(). This separation prevented dynamic
allocations during the phase of NAND identification, which was
inconvenient.

All controller drivers have been moved to use nand_scan(), in
conjunction with the chip->ecc.[attach|detach]_chip() hooks that
actually do the required tweaking sequence between both ident/tail
calls, allowing programmers to use dynamic allocation as they need all
across the scanning sequence.

Declare nand_scan_[ident|tail]() statically now.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c | 16 +++++++++-------
 include/linux/mtd/rawnand.h      |  9 ++-------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index e7f135c100c2..da99232702a4 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5924,7 +5924,7 @@ static int nand_dt_init(struct nand_chip *chip)
 }
 
 /**
- * nand_scan_ident - [NAND Interface] Scan for the NAND device
+ * nand_scan_ident - Scan for the NAND device
  * @mtd: MTD device structure
  * @maxchips: number of chips to scan for, returns immediately if 0
  * @table: alternative NAND ID table
@@ -5932,9 +5932,13 @@ static int nand_dt_init(struct nand_chip *chip)
  * This is the first phase of the normal nand_scan() function. It reads the
  * flash ID and sets up MTD fields accordingly.
  *
+ * This helper used to be called directly from controller drivers that needed
+ * to tweak some ECC-related parameters before nand_scan_tail(). This separation
+ * prevented dynamic allocations during this phase which was unconvenient and
+ * as been banned for the benefit of the ->init_ecc()/cleanup_ecc() hooks.
  */
-int nand_scan_ident(struct mtd_info *mtd, int maxchips,
-		    struct nand_flash_dev *table)
+static int nand_scan_ident(struct mtd_info *mtd, int maxchips,
+			   struct nand_flash_dev *table)
 {
 	int i, nand_maf_id, nand_dev_id;
 	struct nand_chip *chip = mtd_to_nand(mtd);
@@ -6016,7 +6020,6 @@ int nand_scan_ident(struct mtd_info *mtd, int maxchips,
 
 	return 0;
 }
-EXPORT_SYMBOL(nand_scan_ident);
 
 static int nand_set_ecc_soft_ops(struct mtd_info *mtd)
 {
@@ -6393,14 +6396,14 @@ static bool nand_ecc_strength_good(struct mtd_info *mtd)
 }
 
 /**
- * nand_scan_tail - [NAND Interface] Scan for the NAND device
+ * nand_scan_tail - Scan for the NAND device
  * @mtd: MTD device structure
  *
  * This is the second phase of the normal nand_scan() function. It fills out
  * all the uninitialized function pointers with the defaults and scans for a
  * bad block table if appropriate.
  */
-int nand_scan_tail(struct mtd_info *mtd)
+static int nand_scan_tail(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
@@ -6724,7 +6727,6 @@ int nand_scan_tail(struct mtd_info *mtd)
 
 	return ret;
 }
-EXPORT_SYMBOL(nand_scan_tail);
 
 static int nand_attach(struct nand_chip *chip)
 {
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index a20c78e25878..a928771a7ae4 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -36,14 +36,9 @@ static inline int nand_scan(struct mtd_info *mtd, int max_chips)
 }
 
 /*
- * Separate phases of nand_scan(), allowing board driver to intervene
- * and override command or ECC setup according to flash type.
+ * Unregister the MTD device and free resources held by the NAND device, must be
+ * called on error after a successful nand_scan().
  */
-int nand_scan_ident(struct mtd_info *mtd, int max_chips,
-			   struct nand_flash_dev *table);
-int nand_scan_tail(struct mtd_info *mtd);
-
-/* Unregister the MTD device and free resources held by the NAND device */
 void nand_release(struct mtd_info *mtd);
 
 /* Internal helper for board drivers which need to override command function */
-- 
2.14.1
