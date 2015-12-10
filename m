From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:29 +0100
Subject: [PATCH v4 45/58] mtd: nand: vf610: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-46-git-send-email-boris.brezillon@free-electrons.com>
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
 drivers/mtd/nand/vf610_nfc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
index 1c86c6b..1bbb93a 100644
--- a/drivers/mtd/nand/vf610_nfc.c
+++ b/drivers/mtd/nand/vf610_nfc.c
@@ -156,7 +156,6 @@ enum vf610_nfc_variant {
 };
 
 struct vf610_nfc {
-	struct mtd_info mtd;
 	struct nand_chip chip;
 	struct device *dev;
 	void __iomem *regs;
@@ -171,7 +170,10 @@ struct vf610_nfc {
 	u32 ecc_mode;
 };
 
-#define mtd_to_nfc(_mtd) container_of(_mtd, struct vf610_nfc, mtd)
+static inline struct vf610_nfc *mtd_to_nfc(struct mtd_info *mtd)
+{
+	return container_of(mtd_to_nand(mtd), struct vf610_nfc, chip);
+}
 
 static struct nand_ecclayout vf610_nfc_ecc45 = {
 	.eccbytes = 45,
@@ -674,8 +676,8 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	nfc->dev = &pdev->dev;
-	mtd = &nfc->mtd;
 	chip = &nfc->chip;
+	mtd = nand_to_mtd(chip);
 
 	mtd->priv = chip;
 	mtd->owner = THIS_MODULE;
-- 
2.1.4
