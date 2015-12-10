From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:27 +0100
Subject: [PATCH v4 43/58] mtd: nand: tmio: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-44-git-send-email-boris.brezillon@free-electrons.com>
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
 drivers/mtd/nand/tmio_nand.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/tmio_nand.c b/drivers/mtd/nand/tmio_nand.c
index 6d0cbe9..e7b82e1 100644
--- a/drivers/mtd/nand/tmio_nand.c
+++ b/drivers/mtd/nand/tmio_nand.c
@@ -103,7 +103,6 @@
 /*--------------------------------------------------------------------------*/
 
 struct tmio_nand {
-	struct mtd_info mtd;
 	struct nand_chip chip;
 
 	struct platform_device *dev;
@@ -119,7 +118,10 @@ struct tmio_nand {
 	unsigned read_good:1;
 };
 
-#define mtd_to_tmio(m)			container_of(m, struct tmio_nand, mtd)
+static inline struct tmio_nand *mtd_to_tmio(struct mtd_info *mtd)
+{
+	return container_of(mtd_to_nand(mtd), struct tmio_nand, chip);
+}
 
 
 /*--------------------------------------------------------------------------*/
@@ -378,8 +380,8 @@ static int tmio_probe(struct platform_device *dev)
 	tmio->dev = dev;
 
 	platform_set_drvdata(dev, tmio);
-	mtd = &tmio->mtd;
 	nand_chip = &tmio->chip;
+	mtd = nand_to_mtd(nand_chip);
 	mtd->priv = nand_chip;
 	mtd->name = "tmio-nand";
 	mtd->dev.parent = &dev->dev;
@@ -456,7 +458,7 @@ static int tmio_remove(struct platform_device *dev)
 {
 	struct tmio_nand *tmio = platform_get_drvdata(dev);
 
-	nand_release(&tmio->mtd);
+	nand_release(nand_to_mtd(&tmio->chip));
 	tmio_hw_stop(dev, tmio);
 	return 0;
 }
-- 
2.1.4
