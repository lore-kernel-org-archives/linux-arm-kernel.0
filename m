From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:16 +0100
Subject: [PATCH v4 32/58] mtd: nand: omap2: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-33-git-send-email-boris.brezillon@free-electrons.com>
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
 drivers/mtd/nand/omap2.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 1fb40db..f9d0b58 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -152,7 +152,6 @@ static struct nand_hw_control omap_gpmc_controller = {
 
 struct omap_nand_info {
 	struct omap_nand_platform_data	*pdata;
-	struct mtd_info			mtd;
 	struct nand_chip		nand;
 	struct platform_device		*pdev;
 
@@ -179,8 +178,9 @@ struct omap_nand_info {
 
 static inline struct omap_nand_info *mtd_to_omap(struct mtd_info *mtd)
 {
-	return container_of(mtd, struct omap_nand_info, mtd);
+	return container_of(mtd_to_nand(mtd), struct omap_nand_info, nand);
 }
+
 /**
  * omap_prefetch_enable - configures and starts prefetch transfer
  * @cs: cs (chip select) number
@@ -1670,10 +1670,10 @@ static int omap_nand_probe(struct platform_device *pdev)
 	info->reg		= pdata->reg;
 	info->of_node		= pdata->of_node;
 	info->ecc_opt		= pdata->ecc_opt;
-	mtd			= &info->mtd;
+	nand_chip		= &info->nand;
+	mtd			= nand_to_mtd(nand_chip);
 	mtd->priv		= &info->nand;
 	mtd->dev.parent		= &pdev->dev;
-	nand_chip		= &info->nand;
 	nand_chip->ecc.priv	= NULL;
 	nand_set_flash_node(nand_chip, pdata->of_node);
 
@@ -1897,7 +1897,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 				ecclayout->eccpos[ecclayout->eccbytes - 1] + 1;
 
 		err = elm_config(info->elm_dev, BCH4_ECC,
-				 info->mtd.writesize / nand_chip->ecc.size,
+				 mtd->writesize / nand_chip->ecc.size,
 				 nand_chip->ecc.size, nand_chip->ecc.bytes);
 		if (err < 0)
 			goto return_error;
@@ -1951,7 +1951,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.write_page	= omap_write_page_bch;
 
 		err = elm_config(info->elm_dev, BCH8_ECC,
-				 info->mtd.writesize / nand_chip->ecc.size,
+				 mtd->writesize / nand_chip->ecc.size,
 				 nand_chip->ecc.size, nand_chip->ecc.bytes);
 		if (err < 0)
 			goto return_error;
@@ -1981,7 +1981,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.write_page	= omap_write_page_bch;
 
 		err = elm_config(info->elm_dev, BCH16_ECC,
-				 info->mtd.writesize / nand_chip->ecc.size,
+				 mtd->writesize / nand_chip->ecc.size,
 				 nand_chip->ecc.size, nand_chip->ecc.bytes);
 		if (err < 0)
 			goto return_error;
-- 
2.1.4
