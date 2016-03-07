From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 10:46:56 +0100
Subject: [PATCH v4 06/52] mtd: use mtd_ooblayout_xxx() helpers where
 appropriate
In-Reply-To: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457344062-11633-7-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mtd_ooblayout_xxx() helper functions have been added to avoid direct
accesses to the ecclayout field, and thus ease for future reworks.
Use these helpers in all places where the oobfree[] and eccpos[] arrays
where directly accessed.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/mtdchar.c | 107 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 88 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 6d19835..cd64ab7 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -472,28 +472,101 @@ static int mtdchar_readoob(struct file *file, struct mtd_info *mtd,
  * nand_ecclayout flexibly (i.e. the struct may change size in new
  * releases without requiring major rewrites).
  */
-static int shrink_ecclayout(const struct nand_ecclayout *from,
-		struct nand_ecclayout_user *to)
+static int shrink_ecclayout(struct mtd_info *mtd,
+			    struct nand_ecclayout_user *to)
 {
-	int i;
+	struct mtd_oob_region oobregion;
+	int i, section = 0, ret;
 
-	if (!from || !to)
+	if (!mtd || !to)
 		return -EINVAL;
 
 	memset(to, 0, sizeof(*to));
 
-	to->eccbytes = min((int)from->eccbytes, MTD_MAX_ECCPOS_ENTRIES);
-	for (i = 0; i < to->eccbytes; i++)
-		to->eccpos[i] = from->eccpos[i];
+	to->eccbytes = 0;
+	for (i = 0; i < MTD_MAX_ECCPOS_ENTRIES;) {
+		u32 eccpos;
+
+		ret = mtd_ooblayout_ecc(mtd, section, &oobregion);
+		if (ret < 0) {
+			if (ret != -ERANGE)
+				return ret;
+
+			break;
+		}
+
+		eccpos = oobregion.offset;
+		for (; i < MTD_MAX_ECCPOS_ENTRIES &&
+		       eccpos < oobregion.offset + oobregion.length; i++) {
+			to->eccpos[i] = eccpos++;
+			to->eccbytes++;
+		}
+	}
 
 	for (i = 0; i < MTD_MAX_OOBFREE_ENTRIES; i++) {
-		if (from->oobfree[i].length == 0 &&
-				from->oobfree[i].offset == 0)
+		ret = mtd_ooblayout_free(mtd, i, &oobregion);
+		if (ret < 0) {
+			if (ret != -ERANGE)
+				return ret;
+
+			break;
+		}
+
+		to->oobfree[i].offset = oobregion.offset;
+		to->oobfree[i].length = oobregion.length;
+		to->oobavail += to->oobfree[i].length;
+	}
+
+	return 0;
+}
+
+static int get_oobinfo(struct mtd_info *mtd, struct nand_oobinfo *to)
+{
+	struct mtd_oob_region oobregion;
+	int i, section = 0, ret;
+
+	if (!mtd || !to)
+		return -EINVAL;
+
+	memset(to, 0, sizeof(*to));
+
+	to->eccbytes = 0;
+	for (i = 0; i < ARRAY_SIZE(to->eccpos);) {
+		u32 eccpos;
+
+		ret = mtd_ooblayout_ecc(mtd, section, &oobregion);
+		if (ret < 0) {
+			if (ret != -ERANGE)
+				return ret;
+
 			break;
-		to->oobavail += from->oobfree[i].length;
-		to->oobfree[i] = from->oobfree[i];
+		}
+
+		if (oobregion.length + i > ARRAY_SIZE(to->eccpos))
+			return -EINVAL;
+
+		eccpos = oobregion.offset;
+		for (; eccpos < oobregion.offset + oobregion.length; i++) {
+			to->eccpos[i] = eccpos++;
+			to->eccbytes++;
+		}
 	}
 
+	for (i = 0; i < 8; i++) {
+		ret = mtd_ooblayout_free(mtd, i, &oobregion);
+		if (ret < 0) {
+			if (ret != -ERANGE)
+				return ret;
+
+			break;
+		}
+
+		to->oobfree[i][0] = oobregion.offset;
+		to->oobfree[i][1] = oobregion.length;
+	}
+
+	to->useecc = MTD_NANDECC_AUTOPLACE;
+
 	return 0;
 }
 
@@ -817,14 +890,10 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 
 		if (!mtd->ecclayout)
 			return -EOPNOTSUPP;
-		if (mtd->ecclayout->eccbytes > ARRAY_SIZE(oi.eccpos))
-			return -EINVAL;
 
-		oi.useecc = MTD_NANDECC_AUTOPLACE;
-		memcpy(&oi.eccpos, mtd->ecclayout->eccpos, sizeof(oi.eccpos));
-		memcpy(&oi.oobfree, mtd->ecclayout->oobfree,
-		       sizeof(oi.oobfree));
-		oi.eccbytes = mtd->ecclayout->eccbytes;
+		ret = get_oobinfo(mtd, &oi);
+		if (ret)
+			return ret;
 
 		if (copy_to_user(argp, &oi, sizeof(struct nand_oobinfo)))
 			return -EFAULT;
@@ -920,7 +989,7 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 		if (!usrlay)
 			return -ENOMEM;
 
-		shrink_ecclayout(mtd->ecclayout, usrlay);
+		shrink_ecclayout(mtd, usrlay);
 
 		if (copy_to_user(argp, usrlay, sizeof(*usrlay)))
 			ret = -EFAULT;
-- 
2.1.4
