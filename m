From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Oct 2015 15:08:47 +0200
Subject: [PATCH 04/10] mtd: afs: refactor v1 partition parsing
In-Reply-To: <1444914533-27782-1-git-send-email-linus.walleij@linaro.org>
References: <1444914533-27782-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1444914533-27782-5-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return immediately if we are not finding a valid v1 partition
in afs_read_footer_v1(), invert scanning logic so we continue
to read image information on v1 if we found a footer. This is
needed for the logic we introduce to parse v2 footers.

Cc: Ryan Harkin <ryan.harkin@linaro.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/afs.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/afs.c b/drivers/mtd/afs.c
index d09280ae12bd..a1eea50ce180 100644
--- a/drivers/mtd/afs.c
+++ b/drivers/mtd/afs.c
@@ -87,25 +87,23 @@ afs_read_footer_v1(struct mtd_info *mtd, u_int *img_start, u_int *iis_start,
 		return ret;
 	}
 
-	ret = 1;
-
 	/*
 	 * Does it contain the magic number?
 	 */
 	if (fs.signature != AFSV1_FOOTER_MAGIC)
-		ret = 0;
+		return 0;
 
 	/*
 	 * Check the checksum.
 	 */
 	if (word_sum(&fs, sizeof(fs) / sizeof(u32)) != 0xffffffff)
-		ret = 0;
+		return 0;
 
 	/*
 	 * Don't touch the SIB.
 	 */
 	if (fs.type == 2)
-		ret = 0;
+		return 0;
 
 	*iis_start = fs.image_info_base & mask;
 	*img_start = fs.image_start & mask;
@@ -115,16 +113,16 @@ afs_read_footer_v1(struct mtd_info *mtd, u_int *img_start, u_int *iis_start,
 	 * be located after the footer structure.
 	 */
 	if (*iis_start >= ptr)
-		ret = 0;
+		return 0;
 
 	/*
 	 * Check the start of this image.  The image
 	 * data can not be located after this block.
 	 */
 	if (*img_start > off)
-		ret = 0;
+		return 0;
 
-	return ret;
+	return 1;
 }
 
 static int
@@ -190,18 +188,17 @@ static int parse_afs_partitions(struct mtd_info *mtd,
 		ret = afs_read_footer_v1(mtd, &img_ptr, &iis_ptr, off, mask);
 		if (ret < 0)
 			break;
-		if (ret == 0)
-			continue;
-
-		ret = afs_read_iis_v1(mtd, &iis, iis_ptr);
-		if (ret < 0)
-			break;
-		if (ret == 0)
-			continue;
-
-		sz += sizeof(struct mtd_partition);
-		sz += strlen(iis.name) + 1;
-		idx += 1;
+		if (ret) {
+			ret = afs_read_iis_v1(mtd, &iis, iis_ptr);
+			if (ret < 0)
+				break;
+			if (ret == 0)
+				continue;
+
+			sz += sizeof(struct mtd_partition);
+			sz += strlen(iis.name) + 1;
+			idx += 1;
+		}
 	}
 
 	if (!sz)
-- 
2.4.3
