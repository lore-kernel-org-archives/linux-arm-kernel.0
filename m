From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 31 May 2011 16:31:24 -0700
Subject: [PATCH 5/8] mtd: nand: move NAND_CREATE_EMPTY_BBT flag
In-Reply-To: <1306884687-1824-1-git-send-email-computersforpeace@gmail.com>
References: <1306884687-1824-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1306884687-1824-6-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAND_CREATE_EMPTY_BBT flag was added by commit:
  453281a973c10bce941b240d1c654d536623b16b
  mtd: nand: introduce NAND_CREATE_EMPTY_BBT
This flag is not used within the kernel and not explained well, so I
took the liberty to edit its comments.

Also, this is a BBT-related flag (and closely tied with NAND_BBT_CREATE)
so I'm moving it to bbm.h next to NAND_BBT_CREATE, thus requiring that
we use the flag in nand_chip.bbt_options, *not* in nand_chip.options.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/mtd/nand/nand_bbt.c |    2 +-
 include/linux/mtd/bbm.h     |    7 +++++++
 include/linux/mtd/nand.h    |    2 --
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/nand_bbt.c b/drivers/mtd/nand/nand_bbt.c
index dfea9fd..2e4e259 100644
--- a/drivers/mtd/nand/nand_bbt.c
+++ b/drivers/mtd/nand/nand_bbt.c
@@ -970,7 +970,7 @@ static int check_create(struct mtd_info *mtd, uint8_t *buf, struct nand_bbt_desc
 			continue;
 
 		/* Create the table in memory by scanning the chip(s) */
-		if (!(this->options & NAND_CREATE_EMPTY_BBT))
+		if (!(this->bbt_options & NAND_CREATE_EMPTY_BBT))
 			create_bbt(mtd, buf, bd, chipsel);
 
 		td->version[i] = 1;
diff --git a/include/linux/mtd/bbm.h b/include/linux/mtd/bbm.h
index ff18c08..3cf4a8a 100644
--- a/include/linux/mtd/bbm.h
+++ b/include/linux/mtd/bbm.h
@@ -86,6 +86,13 @@ struct nand_bbt_descr {
 #define NAND_BBT_VERSION	0x00000100
 /* Create a bbt if none exists */
 #define NAND_BBT_CREATE		0x00000200
+/*
+ * Create an empty BBT with no vendor information. Vendor's information may be
+ * unavailable, for example, if the NAND controller has a different data and OOB
+ * layout or if this information is already purged. Must be used in conjunction
+ * with NAND_BBT_CREATE.
+ */
+#define NAND_CREATE_EMPTY_BBT	0x01000000
 /* Search good / bad pattern through all pages of a block */
 #define NAND_BBT_SCANALLPAGES	0x00000400
 /* Scan block empty during good / bad block scan */
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index f68e8cb..4e9e88b 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -228,8 +228,6 @@ typedef enum {
 #define NAND_OWN_BUFFERS	0x00040000
 /* Chip may not exist, so silence any errors in scan */
 #define NAND_SCAN_SILENT_NODEV	0x00080000
-/* Create an empty BBT with no vendor information if the BBT is available */
-#define NAND_CREATE_EMPTY_BBT		0x01000000
 
 /* Options set by nand scan */
 /* Nand scan has allocated controller struct */
-- 
1.7.0.4
