From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 08:59:55 +0100
Subject: [PATCH v4 11/58] mtd: nand: cafe: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-12-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct nand_chip now embeds an mtd device. Make use of this mtd instance.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/cafe_nand.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/cafe_nand.c b/drivers/mtd/nand/cafe_nand.c
index 77c92f1..7d6a142 100644
--- a/drivers/mtd/nand/cafe_nand.c
+++ b/drivers/mtd/nand/cafe_nand.c
@@ -605,11 +605,11 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	mtd = kzalloc(sizeof(*mtd) + sizeof(struct cafe_priv), GFP_KERNEL);
-	if (!mtd)
+	cafe = kzalloc(sizeof(*cafe), GFP_KERNEL);
+	if (!cafe)
 		return  -ENOMEM;
-	cafe = (void *)(&mtd[1]);
 
+	mtd = nand_to_mtd(&cafe->nand);
 	mtd->dev.parent = &pdev->dev;
 	mtd->priv = &cafe->nand;
 	cafe->nand.priv = cafe;
@@ -792,7 +792,7 @@ static int cafe_nand_probe(struct pci_dev *pdev,
  out_ior:
 	pci_iounmap(pdev, cafe->mmio);
  out_free_mtd:
-	kfree(mtd);
+	kfree(cafe);
  out:
 	return err;
 }
@@ -813,7 +813,7 @@ static void cafe_nand_remove(struct pci_dev *pdev)
 			2112 + sizeof(struct nand_buffers) +
 			mtd->writesize + mtd->oobsize,
 			cafe->dmabuf, cafe->dmaaddr);
-	kfree(mtd);
+	kfree(cafe);
 }
 
 static const struct pci_device_id cafe_nand_tbl[] = {
-- 
2.1.4
