From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:09 +0100
Subject: [PATCH v4 25/58] mtd: nand: jz4740: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-26-git-send-email-boris.brezillon@free-electrons.com>
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
 drivers/mtd/nand/jz4740_nand.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/jz4740_nand.c b/drivers/mtd/nand/jz4740_nand.c
index 5a06fba..03239a5 100644
--- a/drivers/mtd/nand/jz4740_nand.c
+++ b/drivers/mtd/nand/jz4740_nand.c
@@ -59,7 +59,6 @@
 #define JZ_NAND_MEM_ADDR_OFFSET 0x10000
 
 struct jz_nand {
-	struct mtd_info mtd;
 	struct nand_chip chip;
 	void __iomem *base;
 	struct resource *mem;
@@ -76,7 +75,7 @@ struct jz_nand {
 
 static inline struct jz_nand *mtd_to_jz_nand(struct mtd_info *mtd)
 {
-	return container_of(mtd, struct jz_nand, mtd);
+	return container_of(mtd_to_nand(mtd), struct jz_nand, chip);
 }
 
 static void jz_nand_select_chip(struct mtd_info *mtd, int chipnr)
@@ -334,8 +333,8 @@ static int jz_nand_detect_bank(struct platform_device *pdev,
 	char gpio_name[9];
 	char res_name[6];
 	uint32_t ctrl;
-	struct mtd_info *mtd = &nand->mtd;
 	struct nand_chip *chip = &nand->chip;
+	struct mtd_info *mtd = nand_to_mtd(chip);
 
 	/* Request GPIO port. */
 	gpio = JZ_GPIO_MEM_CS0 + bank - 1;
@@ -432,8 +431,8 @@ static int jz_nand_probe(struct platform_device *pdev)
 		goto err_iounmap_mmio;
 	}
 
-	mtd		= &nand->mtd;
 	chip		= &nand->chip;
+	mtd		= nand_to_mtd(chip);
 	mtd->priv	= chip;
 	mtd->dev.parent = &pdev->dev;
 	mtd->name	= "jz4740-nand";
@@ -543,7 +542,7 @@ static int jz_nand_remove(struct platform_device *pdev)
 	struct jz_nand *nand = platform_get_drvdata(pdev);
 	size_t i;
 
-	nand_release(&nand->mtd);
+	nand_release(nand_to_mtd(&nand->chip));
 
 	/* Deassert and disable all chips */
 	writel(0, nand->base + JZ_REG_NAND_CTRL);
-- 
2.1.4
