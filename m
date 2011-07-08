From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 08 Jul 2011 16:35:56 -0000
Subject: [PATCH 1/8] mtd: nand: remove NAND_BBT_SCANBYTE1AND6 option
In-Reply-To: <1306884687-1824-1-git-send-email-computersforpeace@gmail.com>
References: <1306884687-1824-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1306884687-1824-2-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch reverts most of:
    commit 58373ff0afff4cc8ac40608872995f4d87eb72ec
    mtd: nand: more BB Detection refactoring and dynamic scan options

According to the discussion at:
    http://lists.infradead.org/pipermail/linux-mtd/2011-May/035696.html
the NAND_BBT_SCANBYTE1AND6 flag, although technically valid, can break
some existing ECC layouts that use the 6th byte in the OOB for ECC data.
Furthermore, we apparently do not need to scan both bytes 1 and 6 in
the OOB region of the devices under consideration; instead, we only need
to scan one or the other.

Thus, the NAND_BBT_SCANBYTE1AND6 flag is at best unnecessary and at
worst a regression.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/mtd/nand/nand_base.c |   29 +++++------------------------
 drivers/mtd/nand/nand_bbt.c  |   32 +-------------------------------
 include/linux/mtd/bbm.h      |    2 --
 3 files changed, 6 insertions(+), 57 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index a46e9bb..456fb34 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -410,10 +410,11 @@ static int nand_default_block_markbad(struct mtd_info *mtd, loff_t ofs)
 	else {
 		nand_get_device(chip, mtd, FL_WRITING);
 
-		/* Write to first two pages and to byte 1 and 6 if necessary.
-		 * If we write to more than one location, the first error
-		 * encountered quits the procedure. We write two bytes per
-		 * location, so we dont have to mess with 16 bit access.
+		/*
+		 * Write to first two pages if necessary. If we write to more
+		 * than one location, the first error encountered quits the
+		 * procedure. We write two bytes per location, so we dont have
+		 * to mess with 16 bit access.
 		 */
 		do {
 			chip->ops.len = chip->ops.ooblen = 2;
@@ -423,11 +424,6 @@ static int nand_default_block_markbad(struct mtd_info *mtd, loff_t ofs)
 
 			ret = nand_do_write_oob(mtd, ofs, &chip->ops);
 
-			if (!ret && (chip->options & NAND_BBT_SCANBYTE1AND6)) {
-				chip->ops.ooboffs = NAND_SMALL_BADBLOCK_POS
-					& ~0x01;
-				ret = nand_do_write_oob(mtd, ofs, &chip->ops);
-			}
 			i++;
 			ofs += mtd->writesize;
 		} while (!ret && (chip->options & NAND_BBT_SCAN2NDPAGE) &&
@@ -3131,16 +3127,6 @@ ident_done:
 			 *maf_id == NAND_MFR_MICRON))
 		chip->options |= NAND_BBT_SCAN2NDPAGE;
 
-	/*
-	 * Numonyx/ST 2K pages, x8 bus use BOTH byte 1 and 6
-	 */
-	if (!(busw & NAND_BUSWIDTH_16) &&
-			*maf_id == NAND_MFR_STMICRO &&
-			mtd->writesize == 2048) {
-		chip->options |= NAND_BBT_SCANBYTE1AND6;
-		chip->badblockpos = 0;
-	}
-
 	/* Check for AND chips with 4 page planes */
 	if (chip->options & NAND_4PAGE_ARRAY)
 		chip->erase_cmd = multi_erase_cmd;
@@ -3538,11 +3524,6 @@ void nand_release(struct mtd_info *mtd)
 	kfree(chip->bbt);
 	if (!(chip->options & NAND_OWN_BUFFERS))
 		kfree(chip->buffers);
-
-	/* Free bad block descriptor memory */
-	if (chip->badblock_pattern && chip->badblock_pattern->options
-			& NAND_BBT_DYNAMICSTRUCT)
-		kfree(chip->badblock_pattern);
 }
 EXPORT_SYMBOL_GPL(nand_release);
 
diff --git a/drivers/mtd/nand/nand_bbt.c b/drivers/mtd/nand/nand_bbt.c
index ccbeaa1..5ffb9a4 100644
--- a/drivers/mtd/nand/nand_bbt.c
+++ b/drivers/mtd/nand/nand_bbt.c
@@ -114,28 +114,6 @@ static int check_pattern(uint8_t *buf, int len, int paglen, struct nand_bbt_desc
 			return -1;
 	}
 
-	/* Check both positions 1 and 6 for pattern? */
-	if (td->options & NAND_BBT_SCANBYTE1AND6) {
-		if (td->options & NAND_BBT_SCANEMPTY) {
-			p += td->len;
-			end += NAND_SMALL_BADBLOCK_POS - td->offs;
-			/* Check region between positions 1 and 6 */
-			for (i = 0; i < NAND_SMALL_BADBLOCK_POS - td->offs - td->len;
-					i++) {
-				if (*p++ != 0xff)
-					return -1;
-			}
-		}
-		else {
-			p += NAND_SMALL_BADBLOCK_POS - td->offs;
-		}
-		/* Compare the pattern */
-		for (i = 0; i < td->len; i++) {
-			if (p[i] != td->pattern[i])
-				return -1;
-		}
-	}
-
 	if (td->options & NAND_BBT_SCANEMPTY) {
 		p += td->len;
 		end += td->len;
@@ -167,13 +145,6 @@ static int check_short_pattern(uint8_t *buf, struct nand_bbt_descr *td)
 		if (p[td->offs + i] != td->pattern[i])
 			return -1;
 	}
-	/* Need to check location 1 AND 6? */
-	if (td->options & NAND_BBT_SCANBYTE1AND6) {
-		for (i = 0; i < td->len; i++) {
-			if (p[NAND_SMALL_BADBLOCK_POS + i] != td->pattern[i])
-				return -1;
-		}
-	}
 	return 0;
 }
 
@@ -1330,8 +1301,7 @@ static struct nand_bbt_descr bbt_mirror_no_bbt_descr = {
 	.pattern = mirror_pattern
 };
 
-#define BBT_SCAN_OPTIONS (NAND_BBT_SCANLASTPAGE | NAND_BBT_SCAN2NDPAGE | \
-		NAND_BBT_SCANBYTE1AND6)
+#define BBT_SCAN_OPTIONS (NAND_BBT_SCANLASTPAGE | NAND_BBT_SCAN2NDPAGE)
 /**
  * nand_create_default_bbt_descr - [Internal] Creates a BBT descriptor structure
  * @this:	NAND chip to create descriptor for
diff --git a/include/linux/mtd/bbm.h b/include/linux/mtd/bbm.h
index 57cc0e6..08ffa21 100644
--- a/include/linux/mtd/bbm.h
+++ b/include/linux/mtd/bbm.h
@@ -98,8 +98,6 @@ struct nand_bbt_descr {
 #define NAND_BBT_SCAN2NDPAGE	0x00004000
 /* Search good / bad pattern on the last page of the eraseblock */
 #define NAND_BBT_SCANLASTPAGE	0x00008000
-/* Chip stores bad block marker on BOTH 1st and 6th bytes of OOB */
-#define NAND_BBT_SCANBYTE1AND6 0x00100000
 /* The nand_bbt_descr was created dynamicaly and must be freed */
 #define NAND_BBT_DYNAMICSTRUCT 0x00200000
 /* The bad block table does not OOB for marker */
-- 
1.7.0.4



______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
