From: rubini-list@gnudd.com (Alessandro Rubini)
Date: Sun, 20 Sep 2009 23:18:49 +0200
Subject: [PATCH 2/3] mtd: unify status enum from three headers
In-Reply-To: <cover.1253481164.git.rubini@unipv.it>
References: <cover.1253481164.git.rubini@unipv.it>
Message-ID: <76d4b7a30354d0395de737427674d87fc5c9cb4d.1253481164.git.rubini@
	unipv.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alessandro Rubini <rubini@unipv.it>

nand.h, onenand.h and flashchip.h defined enumeration types
for chip status using the same symbolic names. This prevented
a board file to include more than one of them. In particular,
no nand and onenand platform devices could live in the same file.
This patch augments flashchip.h with a few status values in order
to cover all cases, so nand.h and onenand.h can use flstate_t
without declaring their own status enum.

Signed-off-by: Alessandro Rubini <rubini@unipv.it>
---
 include/linux/mtd/flashchip.h |    7 +++++++
 include/linux/mtd/nand.h      |   17 ++---------------
 include/linux/mtd/onenand.h   |   19 ++-----------------
 3 files changed, 11 insertions(+), 32 deletions(-)

diff --git a/include/linux/mtd/flashchip.h b/include/linux/mtd/flashchip.h
index d4f38c5..f350a48 100644
--- a/include/linux/mtd/flashchip.h
+++ b/include/linux/mtd/flashchip.h
@@ -38,6 +38,13 @@ typedef enum {
 	FL_XIP_WHILE_ERASING,
 	FL_XIP_WHILE_WRITING,
 	FL_SHUTDOWN,
+	/* These 2 come from nand_state_t, which has been unified here */
+	FL_READING,
+	FL_CACHEDPRG,
+	/* These 2 come from onenand_state_t, which has been unified here */
+	FL_RESETING,
+	FL_OTPING,
+
 	FL_UNKNOWN
 } flstate_t;
 
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index d87ada5..2476078 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -21,6 +21,7 @@
 #include <linux/wait.h>
 #include <linux/spinlock.h>
 #include <linux/mtd/mtd.h>
+#include <linux/mtd/flashchip.h>
 #include <linux/mtd/bbm.h>
 
 struct mtd_info;
@@ -203,20 +204,6 @@ typedef enum {
 #define NAND_CI_CHIPNR_MSK	0x03
 #define NAND_CI_CELLTYPE_MSK	0x0C
 
-/*
- * nand_state_t - chip states
- * Enumeration for NAND flash chip state
- */
-typedef enum {
-	FL_READY,
-	FL_READING,
-	FL_WRITING,
-	FL_ERASING,
-	FL_SYNCING,
-	FL_CACHEDPRG,
-	FL_PM_SUSPENDED,
-} nand_state_t;
-
 /* Keep gcc happy */
 struct nand_chip;
 
@@ -403,7 +390,7 @@ struct nand_chip {
 	uint8_t		cellinfo;
 	int		badblockpos;
 
-	nand_state_t	state;
+	flstate_t	state;
 
 	uint8_t		*oob_poi;
 	struct nand_hw_control  *controller;
diff --git a/include/linux/mtd/onenand.h b/include/linux/mtd/onenand.h
index 4e49f33..f57e29e 100644
--- a/include/linux/mtd/onenand.h
+++ b/include/linux/mtd/onenand.h
@@ -14,6 +14,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/completion.h>
+#include <linux/mtd/flashchip.h>
 #include <linux/mtd/onenand_regs.h>
 #include <linux/mtd/bbm.h>
 
@@ -25,22 +26,6 @@ extern int onenand_scan(struct mtd_info *mtd, int max_chips);
 /* Free resources held by the OneNAND device */
 extern void onenand_release(struct mtd_info *mtd);
 
-/*
- * onenand_state_t - chip states
- * Enumeration for OneNAND flash chip state
- */
-typedef enum {
-	FL_READY,
-	FL_READING,
-	FL_WRITING,
-	FL_ERASING,
-	FL_SYNCING,
-	FL_LOCKING,
-	FL_RESETING,
-	FL_OTPING,
-	FL_PM_SUSPENDED,
-} onenand_state_t;
-
 /**
  * struct onenand_bufferram - OneNAND BufferRAM Data
  * @blockpage:		block & page address in BufferRAM
@@ -137,7 +122,7 @@ struct onenand_chip {
 
 	spinlock_t		chip_lock;
 	wait_queue_head_t	wq;
-	onenand_state_t		state;
+	flstate_t		state;
 	unsigned char		*page_buf;
 	unsigned char		*oob_buf;
 
-- 
1.6.0.2
