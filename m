From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Oct 2015 15:08:52 +0200
Subject: [PATCH 09/10] mtd: afs: factor the IIS read into partition parser
In-Reply-To: <1444914533-27782-1-git-send-email-linus.walleij@linaro.org>
References: <1444914533-27782-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1444914533-27782-10-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Factor the IIS (Image Information Structure) reading into the
partition parser, giving us a single, clean partition parser
function.

Cc: Ryan Harkin <ryan.harkin@linaro.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/afs.c | 59 +++++++++++++++++++------------------------------------
 1 file changed, 20 insertions(+), 39 deletions(-)

diff --git a/drivers/mtd/afs.c b/drivers/mtd/afs.c
index cdee8295d4c0..1ce6842c917c 100644
--- a/drivers/mtd/afs.c
+++ b/drivers/mtd/afs.c
@@ -88,42 +88,6 @@ static bool afs_is_v1(struct mtd_info *mtd, u_int off)
 	return (magic == AFSV1_FOOTER_MAGIC);
 }
 
-static int
-afs_read_iis_v1(struct mtd_info *mtd, struct image_info_v1 *iis, u_int ptr)
-{
-	size_t sz;
-	int ret, i;
-
-	memset(iis, 0, sizeof(*iis));
-	ret = mtd_read(mtd, ptr, sizeof(*iis), &sz, (u_char *)iis);
-	if (ret < 0)
-		goto failed;
-
-	if (sz != sizeof(*iis)) {
-		ret = -EINVAL;
-		goto failed;
-	}
-
-	ret = 0;
-
-	/*
-	 * Validate the name - it must be NUL terminated.
-	 */
-	for (i = 0; i < sizeof(iis->name); i++)
-		if (iis->name[i] == '\0')
-			break;
-
-	if (i < sizeof(iis->name))
-		ret = 1;
-
-	return ret;
-
- failed:
-	printk(KERN_ERR "AFS: mtd read failed at 0x%x: %d\n",
-		ptr, ret);
-	return ret;
-}
-
 static int afs_parse_v1_partition(struct mtd_info *mtd,
 				  u_int off, struct mtd_partition *part)
 {
@@ -139,6 +103,7 @@ static int afs_parse_v1_partition(struct mtd_info *mtd,
 	u_int ptr;
 	size_t sz;
 	int ret;
+	int i;
 
 	/*
 	 * This is the address mask; we use this to mask off out of
@@ -185,9 +150,25 @@ static int afs_parse_v1_partition(struct mtd_info *mtd,
 		return 0;
 
 	/* Read the image info block */
-	ret = afs_read_iis_v1(mtd, &iis, iis_ptr);
-	if (ret < 0)
-		return ret;
+	memset(&iis, 0, sizeof(iis));
+	ret = mtd_read(mtd, iis_ptr, sizeof(iis), &sz, (u_char *)&iis);
+	if (ret < 0) {
+		printk(KERN_ERR "AFS: mtd read failed@0x%x: %d\n",
+		       iis_ptr, ret);
+		return -EINVAL;
+	}
+
+	if (sz != sizeof(iis))
+		return -EINVAL;
+
+	/*
+	 * Validate the name - it must be NUL terminated.
+	 */
+	for (i = 0; i < sizeof(iis.name); i++)
+		if (iis.name[i] == '\0')
+			break;
+	if (i > sizeof(iis.name))
+		return -EINVAL;
 
 	part->name = kstrdup(iis.name, GFP_KERNEL);
 	if (!part->name)
-- 
2.4.3
