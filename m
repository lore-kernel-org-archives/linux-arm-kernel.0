From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Oct 2015 15:08:44 +0200
Subject: [PATCH 01/10] mtd: afs: rename structs and functions for v1
In-Reply-To: <1444914533-27782-1-git-send-email-linus.walleij@linaro.org>
References: <1444914533-27782-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1444914533-27782-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we're gonna add the v2 version of flash information
structure and we want to avoid confusion, rename the old
functions to *v1. Cut the word "structure" from the struct
name, it is pretty obvious that it is a struct already from
the keyword.

Cc: Ryan Harkin <ryan.harkin@linaro.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/afs.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/afs.c b/drivers/mtd/afs.c
index 96a33e3f7b00..9af00528586f 100644
--- a/drivers/mtd/afs.c
+++ b/drivers/mtd/afs.c
@@ -34,7 +34,7 @@
 #include <linux/mtd/map.h>
 #include <linux/mtd/partitions.h>
 
-struct footer_struct {
+struct footer_v1 {
 	u32 image_info_base;	/* Address of first word of ImageFooter  */
 	u32 image_start;	/* Start of area reserved by this footer */
 	u32 signature;		/* 'Magic' number proves it's a footer   */
@@ -42,7 +42,7 @@ struct footer_struct {
 	u32 checksum;		/* Just this structure                   */
 };
 
-struct image_info_struct {
+struct image_info_v1 {
 	u32 bootFlags;		/* Boot flags, compression etc.          */
 	u32 imageNumber;	/* Unique number, selects for boot etc.  */
 	u32 loadAddress;	/* Address program should be loaded to   */
@@ -67,10 +67,10 @@ static u32 word_sum(void *words, int num)
 }
 
 static int
-afs_read_footer(struct mtd_info *mtd, u_int *img_start, u_int *iis_start,
-		u_int off, u_int mask)
+afs_read_footer_v1(struct mtd_info *mtd, u_int *img_start, u_int *iis_start,
+		   u_int off, u_int mask)
 {
-	struct footer_struct fs;
+	struct footer_v1 fs;
 	u_int ptr = off + mtd->erasesize - sizeof(fs);
 	size_t sz;
 	int ret;
@@ -126,7 +126,7 @@ afs_read_footer(struct mtd_info *mtd, u_int *img_start, u_int *iis_start,
 }
 
 static int
-afs_read_iis(struct mtd_info *mtd, struct image_info_struct *iis, u_int ptr)
+afs_read_iis_v1(struct mtd_info *mtd, struct image_info_v1 *iis, u_int ptr)
 {
 	size_t sz;
 	int ret, i;
@@ -182,16 +182,16 @@ static int parse_afs_partitions(struct mtd_info *mtd,
 	 * the strings.
 	 */
 	for (idx = off = sz = 0; off < mtd->size; off += mtd->erasesize) {
-		struct image_info_struct iis;
+		struct image_info_v1 iis;
 		u_int iis_ptr, img_ptr;
 
-		ret = afs_read_footer(mtd, &img_ptr, &iis_ptr, off, mask);
+		ret = afs_read_footer_v1(mtd, &img_ptr, &iis_ptr, off, mask);
 		if (ret < 0)
 			break;
 		if (ret == 0)
 			continue;
 
-		ret = afs_read_iis(mtd, &iis, iis_ptr);
+		ret = afs_read_iis_v1(mtd, &iis, iis_ptr);
 		if (ret < 0)
 			break;
 		if (ret == 0)
@@ -215,18 +215,18 @@ static int parse_afs_partitions(struct mtd_info *mtd,
 	 * Identify the partitions
 	 */
 	for (idx = off = 0; off < mtd->size; off += mtd->erasesize) {
-		struct image_info_struct iis;
+		struct image_info_v1 iis;
 		u_int iis_ptr, img_ptr;
 
 		/* Read the footer. */
-		ret = afs_read_footer(mtd, &img_ptr, &iis_ptr, off, mask);
+		ret = afs_read_footer_v1(mtd, &img_ptr, &iis_ptr, off, mask);
 		if (ret < 0)
 			break;
 		if (ret == 0)
 			continue;
 
 		/* Read the image info block */
-		ret = afs_read_iis(mtd, &iis, iis_ptr);
+		ret = afs_read_iis_v1(mtd, &iis, iis_ptr);
 		if (ret < 0)
 			break;
 		if (ret == 0)
-- 
2.4.3
