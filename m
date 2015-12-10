From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:24 +0100
Subject: [PATCH v4 40/58] mtd: nand: sharpsl: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-41-git-send-email-boris.brezillon@free-electrons.com>
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
 drivers/mtd/nand/sharpsl.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/sharpsl.c b/drivers/mtd/nand/sharpsl.c
index 84129e5..4b649fb 100644
--- a/drivers/mtd/nand/sharpsl.c
+++ b/drivers/mtd/nand/sharpsl.c
@@ -29,13 +29,15 @@
 #include <asm/mach-types.h>
 
 struct sharpsl_nand {
-	struct mtd_info		mtd;
 	struct nand_chip	chip;
 
 	void __iomem		*io;
 };
 
-#define mtd_to_sharpsl(_mtd)	container_of(_mtd, struct sharpsl_nand, mtd)
+static inline struct sharpsl_nand *mtd_to_sharpsl(struct mtd_info *mtd)
+{
+	return container_of(mtd_to_nand(mtd), struct sharpsl_nand, chip);
+}
 
 /* register offset */
 #define ECCLPLB		0x00	/* line parity 7 - 0 bit */
@@ -109,6 +111,7 @@ static int sharpsl_nand_calculate_ecc(struct mtd_info *mtd, const u_char * dat,
 static int sharpsl_nand_probe(struct platform_device *pdev)
 {
 	struct nand_chip *this;
+	struct mtd_info *mtd;
 	struct resource *r;
 	int err = 0;
 	struct sharpsl_nand *sharpsl;
@@ -143,8 +146,9 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	this = (struct nand_chip *)(&sharpsl->chip);
 
 	/* Link the private data with the MTD structure */
-	sharpsl->mtd.priv = this;
-	sharpsl->mtd.dev.parent = &pdev->dev;
+	mtd = nand_to_mtd(this);
+	mtd->priv = this;
+	mtd->dev.parent = &pdev->dev;
 
 	platform_set_drvdata(pdev, sharpsl);
 
@@ -173,14 +177,14 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	this->ecc.correct = nand_correct_data;
 
 	/* Scan to find existence of the device */
-	err = nand_scan(&sharpsl->mtd, 1);
+	err = nand_scan(mtd, 1);
 	if (err)
 		goto err_scan;
 
 	/* Register the partitions */
-	sharpsl->mtd.name = "sharpsl-nand";
+	mtd->name = "sharpsl-nand";
 
-	err = mtd_device_parse_register(&sharpsl->mtd, NULL, NULL,
+	err = mtd_device_parse_register(mtd, NULL, NULL,
 					data->partitions, data->nr_partitions);
 	if (err)
 		goto err_add;
@@ -189,7 +193,7 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	return 0;
 
 err_add:
-	nand_release(&sharpsl->mtd);
+	nand_release(mtd);
 
 err_scan:
 	iounmap(sharpsl->io);
@@ -207,7 +211,7 @@ static int sharpsl_nand_remove(struct platform_device *pdev)
 	struct sharpsl_nand *sharpsl = platform_get_drvdata(pdev);
 
 	/* Release resources, unregister device */
-	nand_release(&sharpsl->mtd);
+	nand_release(nand_to_mtd(&sharpsl->chip));
 
 	iounmap(sharpsl->io);
 
-- 
2.1.4
