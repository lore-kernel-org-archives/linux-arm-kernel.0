From: rubini-list@gnudd.com (Alessandro Rubini)
Date: Sun, 20 Sep 2009 23:18:38 +0200
Subject: [PATCH 1/3] mtd: use bbm.h in nand.h
In-Reply-To: <cover.1253481164.git.rubini@unipv.it>
References: <cover.1253481164.git.rubini@unipv.it>
Message-ID: <cf7affcc226890e3d4cdb5a834a9f09d463bf9ab.1253481164.git.rubini@
	unipv.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alessandro Rubini <rubini@unipv.it>

This consolidates common code in nand.h and bbm.h. The
comments and data structures were the same, this keeps
the comment from nand.h as it fits 80 columns, while the one
in bbm.h did not.

Signed-off-by: Alessandro Rubini <rubini@unipv.it>
---
 include/linux/mtd/bbm.h  |   35 +++++++++++----------
 include/linux/mtd/nand.h |   76 +---------------------------------------------
 2 files changed, 19 insertions(+), 92 deletions(-)

diff --git a/include/linux/mtd/bbm.h b/include/linux/mtd/bbm.h
index fff8c53..9c3757c 100644
--- a/include/linux/mtd/bbm.h
+++ b/include/linux/mtd/bbm.h
@@ -19,22 +19,21 @@
 
 /**
  * struct nand_bbt_descr - bad block table descriptor
- * @options:		options for this descriptor
- * @pages:		the page(s) where we find the bbt, used with
- * 			option BBT_ABSPAGE when bbt is searched,
- * 			then we store the found bbts pages here.
- *			Its an array and supports up to 8 chips now
- * @offs:		offset of the pattern in the oob area of the page
- * @veroffs:		offset of the bbt version counter in the oob area of the page
- * @version:		version read from the bbt page during scan
- * @len:		length of the pattern, if 0 no pattern check is performed
- * @maxblocks:		maximum number of blocks to search for a bbt. This
- *			number of blocks is reserved at the end of the device
- *			where the tables are written.
- * @reserved_block_code: if non-0, this pattern denotes a reserved
- *			(rather than bad) block in the stored bbt
- * @pattern:		pattern to identify bad block table or factory marked
- *			good / bad blocks, can be NULL, if len = 0
+ * @options:	options for this descriptor
+ * @pages:	the page(s) where we find the bbt, used with option BBT_ABSPAGE
+ *		when bbt is searched, then we store the found bbts pages here.
+ *		Its an array and supports up to 8 chips now
+ * @offs:	offset of the pattern in the oob area of the page
+ * @veroffs:	offset of the bbt version counter in the oob are of the page
+ * @version:	version read from the bbt page during scan
+ * @len:	length of the pattern, if 0 no pattern check is performed
+ * @maxblocks:	maximum number of blocks to search for a bbt. This number of
+ *		blocks is reserved at the end of the device where the tables are
+ *		written.
+ * @reserved_block_code: if non-0, this pattern denotes a reserved (rather than
+ *              bad) block in the stored bbt
+ * @pattern:	pattern to identify bad block table or factory marked good /
+ *		bad blocks, can be NULL, if len = 0
  *
  * Descriptor for the bad block table marker and the descriptor for the
  * pattern which identifies good and bad blocks. The assumption is made
@@ -90,7 +89,9 @@ struct nand_bbt_descr {
 /*
  * Constants for oob configuration
  */
-#define ONENAND_BADBLOCK_POS	0
+#define NAND_SMALL_BADBLOCK_POS		5
+#define NAND_LARGE_BADBLOCK_POS		0
+#define ONENAND_BADBLOCK_POS		0
 
 /*
  * Bad block scanning errors
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 7a232a9..d87ada5 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -21,6 +21,7 @@
 #include <linux/wait.h>
 #include <linux/spinlock.h>
 #include <linux/mtd/mtd.h>
+#include <linux/mtd/bbm.h>
 
 struct mtd_info;
 /* Scan and identify a NAND device */
@@ -470,75 +471,6 @@ struct nand_manufacturers {
 extern struct nand_flash_dev nand_flash_ids[];
 extern struct nand_manufacturers nand_manuf_ids[];
 
-/**
- * struct nand_bbt_descr - bad block table descriptor
- * @options:	options for this descriptor
- * @pages:	the page(s) where we find the bbt, used with option BBT_ABSPAGE
- *		when bbt is searched, then we store the found bbts pages here.
- *		Its an array and supports up to 8 chips now
- * @offs:	offset of the pattern in the oob area of the page
- * @veroffs:	offset of the bbt version counter in the oob are of the page
- * @version:	version read from the bbt page during scan
- * @len:	length of the pattern, if 0 no pattern check is performed
- * @maxblocks:	maximum number of blocks to search for a bbt. This number of
- *		blocks is reserved at the end of the device where the tables are
- *		written.
- * @reserved_block_code: if non-0, this pattern denotes a reserved (rather than
- *              bad) block in the stored bbt
- * @pattern:	pattern to identify bad block table or factory marked good /
- *		bad blocks, can be NULL, if len = 0
- *
- * Descriptor for the bad block table marker and the descriptor for the
- * pattern which identifies good and bad blocks. The assumption is made
- * that the pattern and the version count are always located in the oob area
- * of the first block.
- */
-struct nand_bbt_descr {
-	int	options;
-	int	pages[NAND_MAX_CHIPS];
-	int	offs;
-	int	veroffs;
-	uint8_t	version[NAND_MAX_CHIPS];
-	int	len;
-	int	maxblocks;
-	int	reserved_block_code;
-	uint8_t	*pattern;
-};
-
-/* Options for the bad block table descriptors */
-
-/* The number of bits used per block in the bbt on the device */
-#define NAND_BBT_NRBITS_MSK	0x0000000F
-#define NAND_BBT_1BIT		0x00000001
-#define NAND_BBT_2BIT		0x00000002
-#define NAND_BBT_4BIT		0x00000004
-#define NAND_BBT_8BIT		0x00000008
-/* The bad block table is in the last good block of the device */
-#define	NAND_BBT_LASTBLOCK	0x00000010
-/* The bbt is at the given page, else we must scan for the bbt */
-#define NAND_BBT_ABSPAGE	0x00000020
-/* The bbt is at the given page, else we must scan for the bbt */
-#define NAND_BBT_SEARCH		0x00000040
-/* bbt is stored per chip on multichip devices */
-#define NAND_BBT_PERCHIP	0x00000080
-/* bbt has a version counter at offset veroffs */
-#define NAND_BBT_VERSION	0x00000100
-/* Create a bbt if none axists */
-#define NAND_BBT_CREATE		0x00000200
-/* Search good / bad pattern through all pages of a block */
-#define NAND_BBT_SCANALLPAGES	0x00000400
-/* Scan block empty during good / bad block scan */
-#define NAND_BBT_SCANEMPTY	0x00000800
-/* Write bbt if neccecary */
-#define NAND_BBT_WRITE		0x00001000
-/* Read and write back block contents when writing bbt */
-#define NAND_BBT_SAVECONTENT	0x00002000
-/* Search good / bad pattern on the first and the second page */
-#define NAND_BBT_SCAN2NDPAGE	0x00004000
-
-/* The maximum number of blocks to scan for a bbt */
-#define NAND_BBT_SCAN_MAXBLOCKS	4
-
 extern int nand_scan_bbt(struct mtd_info *mtd, struct nand_bbt_descr *bd);
 extern int nand_update_bbt(struct mtd_info *mtd, loff_t offs);
 extern int nand_default_bbt(struct mtd_info *mtd);
@@ -548,12 +480,6 @@ extern int nand_erase_nand(struct mtd_info *mtd, struct erase_info *instr,
 extern int nand_do_read(struct mtd_info *mtd, loff_t from, size_t len,
 			size_t * retlen, uint8_t * buf);
 
-/*
-* Constants for oob configuration
-*/
-#define NAND_SMALL_BADBLOCK_POS		5
-#define NAND_LARGE_BADBLOCK_POS		0
-
 /**
  * struct platform_nand_chip - chip level device structure
  * @nr_chips:		max. number of chips to scan for
-- 
1.6.0.2
