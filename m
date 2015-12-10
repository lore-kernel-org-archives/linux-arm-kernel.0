From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 08:59:53 +0100
Subject: [PATCH v4 09/58] mtd: nand: bf5xx: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-10-git-send-email-boris.brezillon@free-electrons.com>
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
 drivers/mtd/nand/bf5xx_nand.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/bf5xx_nand.c b/drivers/mtd/nand/bf5xx_nand.c
index d9da5ed..928d599 100644
--- a/drivers/mtd/nand/bf5xx_nand.c
+++ b/drivers/mtd/nand/bf5xx_nand.c
@@ -142,7 +142,6 @@ static struct nand_ecclayout bootrom_ecclayout = {
 struct bf5xx_nand_info {
 	/* mtd info */
 	struct nand_hw_control		controller;
-	struct mtd_info			mtd;
 	struct nand_chip		chip;
 
 	/* platform info */
@@ -160,7 +159,8 @@ struct bf5xx_nand_info {
  */
 static struct bf5xx_nand_info *mtd_to_nand_info(struct mtd_info *mtd)
 {
-	return container_of(mtd, struct bf5xx_nand_info, mtd);
+	return container_of(mtd_to_nand(mtd), struct bf5xx_nand_info,
+			    chip);
 }
 
 static struct bf5xx_nand_info *to_nand_info(struct platform_device *pdev)
@@ -660,7 +660,7 @@ static int bf5xx_nand_hw_init(struct bf5xx_nand_info *info)
  */
 static int bf5xx_nand_add_partition(struct bf5xx_nand_info *info)
 {
-	struct mtd_info *mtd = &info->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&info->chip);
 	struct mtd_partition *parts = info->platform->partitions;
 	int nr = info->platform->nr_partitions;
 
@@ -675,7 +675,7 @@ static int bf5xx_nand_remove(struct platform_device *pdev)
 	 * and their partitions, then go through freeing the
 	 * resources used
 	 */
-	nand_release(&info->mtd);
+	nand_release(nand_to_mtd(&info->chip));
 
 	peripheral_free_list(bfin_nfc_pin_req);
 	bf5xx_nand_dma_remove(info);
@@ -756,6 +756,7 @@ static int bf5xx_nand_probe(struct platform_device *pdev)
 
 	/* initialise chip data struct */
 	chip = &info->chip;
+	mtd = nand_to_mtd(&info->chip);
 
 	if (plat->data_width)
 		chip->options |= NAND_BUSWIDTH_16;
@@ -772,7 +773,7 @@ static int bf5xx_nand_probe(struct platform_device *pdev)
 	chip->cmd_ctrl     = bf5xx_nand_hwcontrol;
 	chip->dev_ready    = bf5xx_nand_devready;
 
-	chip->priv	   = &info->mtd;
+	chip->priv	   = mtd;
 	chip->controller   = &info->controller;
 
 	chip->IO_ADDR_R    = (void __iomem *) NFC_READ;
@@ -781,7 +782,6 @@ static int bf5xx_nand_probe(struct platform_device *pdev)
 	chip->chip_delay   = 0;
 
 	/* initialise mtd info data struct */
-	mtd 		= &info->mtd;
 	mtd->priv	= chip;
 	mtd->dev.parent = &pdev->dev;
 
-- 
2.1.4
