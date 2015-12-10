From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:15 +0100
Subject: [PATCH v4 31/58] mtd: nand: nuc900: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-32-git-send-email-boris.brezillon@free-electrons.com>
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
 drivers/mtd/nand/nuc900_nand.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/nuc900_nand.c b/drivers/mtd/nand/nuc900_nand.c
index 65908c0..4dad170 100644
--- a/drivers/mtd/nand/nuc900_nand.c
+++ b/drivers/mtd/nand/nuc900_nand.c
@@ -55,7 +55,6 @@
 	__raw_writel((val), (dev)->reg + REG_SMADDR)
 
 struct nuc900_nand {
-	struct mtd_info mtd;
 	struct nand_chip chip;
 	void __iomem *reg;
 	struct clk *clk;
@@ -64,7 +63,7 @@ struct nuc900_nand {
 
 static inline struct nuc900_nand *mtd_to_nuc900(struct mtd_info *mtd)
 {
-	return container_of(mtd, struct nuc900_nand, mtd);
+	return container_of(mtd_to_nand(mtd), struct nuc900_nand, chip);
 }
 
 static const struct mtd_partition partitions[] = {
@@ -236,6 +235,7 @@ static int nuc900_nand_probe(struct platform_device *pdev)
 {
 	struct nuc900_nand *nuc900_nand;
 	struct nand_chip *chip;
+	struct mtd_info *mtd;
 	struct resource *res;
 
 	nuc900_nand = devm_kzalloc(&pdev->dev, sizeof(struct nuc900_nand),
@@ -243,9 +243,10 @@ static int nuc900_nand_probe(struct platform_device *pdev)
 	if (!nuc900_nand)
 		return -ENOMEM;
 	chip = &(nuc900_nand->chip);
+	mtd = nand_to_mtd(chip);
 
-	nuc900_nand->mtd.priv	= chip;
-	nuc900_nand->mtd.dev.parent = &pdev->dev;
+	mtd->priv		= chip;
+	mtd->dev.parent		= &pdev->dev;
 	spin_lock_init(&nuc900_nand->lock);
 
 	nuc900_nand->clk = devm_clk_get(&pdev->dev, NULL);
@@ -269,11 +270,10 @@ static int nuc900_nand_probe(struct platform_device *pdev)
 
 	nuc900_nand_enable(nuc900_nand);
 
-	if (nand_scan(&(nuc900_nand->mtd), 1))
+	if (nand_scan(mtd, 1))
 		return -ENXIO;
 
-	mtd_device_register(&(nuc900_nand->mtd), partitions,
-			    ARRAY_SIZE(partitions));
+	mtd_device_register(mtd, partitions, ARRAY_SIZE(partitions));
 
 	platform_set_drvdata(pdev, nuc900_nand);
 
@@ -284,7 +284,7 @@ static int nuc900_nand_remove(struct platform_device *pdev)
 {
 	struct nuc900_nand *nuc900_nand = platform_get_drvdata(pdev);
 
-	nand_release(&nuc900_nand->mtd);
+	nand_release(nand_to_mtd(&nuc900_nand->chip));
 	clk_disable(nuc900_nand->clk);
 
 	return 0;
-- 
2.1.4
