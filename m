From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:22 +0100
Subject: [PATCH v4 38/58] mtd: nand: s3c2410: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-39-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct nand_chip now embeds an mtd device. Make use of this mtd instance.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Changes generated with the following coccinelle script

--->8---
virtual patch

@fix1@
identifier __chipfield, __mtdfield;
type __type;
@@
(
	__type {
		...
		struct nand_chip __chipfield;
		...
-		struct mtd_info __mtdfield;
		...
	};
|
	__type {
		...
-		struct mtd_info __mtdfield;
		...
		struct nand_chip __chipfield;
		...
	};
)

@fix2 depends on fix1@
identifier fix1.__chipfield, fix1.__mtdfield;
identifier __subfield;
type fix1.__type;
__type *__priv;
@@
(
-	__priv->__mtdfield.__subfield
+	nand_to_mtd(&__priv->__chipfield)->__subfield
|
-	&(__priv->__mtdfield)
+	nand_to_mtd(&__priv->__chipfield)
)
--->8---
---
 drivers/mtd/nand/s3c2410.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
index e658b29..c074a49 100644
--- a/drivers/mtd/nand/s3c2410.c
+++ b/drivers/mtd/nand/s3c2410.c
@@ -104,7 +104,6 @@ struct s3c2410_nand_info;
  * @scan_res: The result from calling nand_scan_ident().
 */
 struct s3c2410_nand_mtd {
-	struct mtd_info			mtd;
 	struct nand_chip		chip;
 	struct s3c2410_nand_set		*set;
 	struct s3c2410_nand_info	*info;
@@ -168,7 +167,8 @@ struct s3c2410_nand_info {
 
 static struct s3c2410_nand_mtd *s3c2410_nand_mtd_toours(struct mtd_info *mtd)
 {
-	return container_of(mtd, struct s3c2410_nand_mtd, mtd);
+	return container_of(mtd_to_nand(mtd), struct s3c2410_nand_mtd,
+			    chip);
 }
 
 static struct s3c2410_nand_info *s3c2410_nand_mtd_toinfo(struct mtd_info *mtd)
@@ -745,7 +745,7 @@ static int s3c24xx_nand_remove(struct platform_device *pdev)
 
 		for (mtdno = 0; mtdno < info->mtd_count; mtdno++, ptr++) {
 			pr_debug("releasing mtd %d (%p)\n", mtdno, ptr);
-			nand_release(&ptr->mtd);
+			nand_release(nand_to_mtd(&ptr->chip));
 		}
 	}
 
@@ -762,9 +762,11 @@ static int s3c2410_nand_add_partition(struct s3c2410_nand_info *info,
 				      struct s3c2410_nand_set *set)
 {
 	if (set) {
-		mtd->mtd.name = set->name;
+		struct mtd_info *mtdinfo = nand_to_mtd(&mtd->chip);
 
-		return mtd_device_parse_register(&mtd->mtd, NULL, NULL,
+		mtdinfo->name = set->name;
+
+		return mtd_device_parse_register(mtdinfo, NULL, NULL,
 					 set->partitions, set->nr_partitions);
 	}
 
@@ -786,6 +788,7 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 				   struct s3c2410_nand_set *set)
 {
 	struct nand_chip *chip = &nmtd->chip;
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	void __iomem *regs = info->regs;
 
 	chip->write_buf    = s3c2410_nand_write_buf;
@@ -831,7 +834,7 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 	chip->IO_ADDR_R = chip->IO_ADDR_W;
 
 	nmtd->info	   = info;
-	nmtd->mtd.priv	   = chip;
+	mtd->priv	   = chip;
 	nmtd->set	   = set;
 
 #ifdef CONFIG_MTD_NAND_S3C2410_HWECC
@@ -1012,19 +1015,21 @@ static int s3c24xx_nand_probe(struct platform_device *pdev)
 	nmtd = info->mtds;
 
 	for (setno = 0; setno < nr_sets; setno++, nmtd++) {
+		struct mtd_info *mtd = nand_to_mtd(&nmtd->chip);
+
 		pr_debug("initialising set %d (%p, info %p)\n",
 			 setno, nmtd, info);
 
-		nmtd->mtd.dev.parent = &pdev->dev;
+		mtd->dev.parent = &pdev->dev;
 		s3c2410_nand_init_chip(info, nmtd, sets);
 
-		nmtd->scan_res = nand_scan_ident(&nmtd->mtd,
+		nmtd->scan_res = nand_scan_ident(mtd,
 						 (sets) ? sets->nr_chips : 1,
 						 NULL);
 
 		if (nmtd->scan_res == 0) {
 			s3c2410_nand_update_chip(info, nmtd);
-			nand_scan_tail(&nmtd->mtd);
+			nand_scan_tail(mtd);
 			s3c2410_nand_add_partition(info, nmtd, sets);
 		}
 
-- 
2.1.4
