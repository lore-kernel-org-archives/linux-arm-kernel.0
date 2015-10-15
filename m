From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Oct 2015 15:08:49 +0200
Subject: [PATCH 06/10] mtd: afs: simplify partition detection
In-Reply-To: <1444914533-27782-1-git-send-email-linus.walleij@linaro.org>
References: <1444914533-27782-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1444914533-27782-7-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of reading out the AFS footers twice, create a separate
function to just check if there is a footer or not. Rids a few
local variables and prepare us to join the actual parser into
one function.

Cc: Ryan Harkin <ryan.harkin@linaro.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/afs.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/afs.c b/drivers/mtd/afs.c
index 9e6089615f16..2307f54195f5 100644
--- a/drivers/mtd/afs.c
+++ b/drivers/mtd/afs.c
@@ -68,6 +68,26 @@ static u32 word_sum(void *words, int num)
 	return sum;
 }
 
+static bool afs_is_v1(struct mtd_info *mtd, u_int off)
+{
+	/* The magic is 12 bytes from the end of the erase block */
+	u_int ptr = off + mtd->erasesize - 12;
+	u32 magic;
+	size_t sz;
+	int ret;
+
+	ret = mtd_read(mtd, ptr, 4, &sz, (u_char *)&magic);
+	if (ret < 0) {
+		printk(KERN_ERR "AFS: mtd read failed@0x%x: %d\n",
+		       ptr, ret);
+		return false;
+	}
+	if (ret >= 0 && sz != 4)
+		return false;
+
+	return (magic == AFSV1_FOOTER_MAGIC);
+}
+
 static int
 afs_read_footer_v1(struct mtd_info *mtd, u_int *img_start, u_int *iis_start,
 		   u_int off, u_int mask)
@@ -176,18 +196,9 @@ static int parse_afs_partitions(struct mtd_info *mtd,
 	 */
 	mask = mtd->size - 1;
 
-	/*
-	 * First, calculate the size of the array we need for the
-	 * partition information.  We include in this the size of
-	 * the strings.
-	 */
+	/* Count the partitions by looping over all erase blocks */
 	for (i = off = sz = 0; off < mtd->size; off += mtd->erasesize) {
-		u_int iis_ptr, img_ptr;
-
-		ret = afs_read_footer_v1(mtd, &img_ptr, &iis_ptr, off, mask);
-		if (ret < 0)
-			return ret;
-		if (ret) {
+		if (afs_is_v1(mtd, off)) {
 			sz += sizeof(struct mtd_partition);
 			i += 1;
 		}
-- 
2.4.3
