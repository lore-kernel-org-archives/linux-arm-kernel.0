From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Thu,  5 Jul 2018 12:27:26 +0200
Subject: [PATCH 1/8] mtd: rawnand: Kill cafe_nand_bug()
In-Reply-To: <20180705102733.29673-1-boris.brezillon@bootlin.com>
References: <20180705102733.29673-1-boris.brezillon@bootlin.com>
Message-ID: <20180705102733.29673-2-boris.brezillon@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Leaving a function pointer to NULL should be enough to trigger a NULL
pointer exception, and anyway, if we want to BUG() when some missing
hooks are called, this should be done in the core, so let's drop the
cafe_nand_bug() dummy function.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/cafe_nand.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index d721f489b38b..ac0be933a490 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -345,11 +345,6 @@ static irqreturn_t cafe_nand_interrupt(int irq, void *id)
 	return IRQ_HANDLED;
 }
 
-static void cafe_nand_bug(struct mtd_info *mtd)
-{
-	BUG();
-}
-
 static int cafe_nand_write_oob(struct mtd_info *mtd,
 			       struct nand_chip *chip, int page)
 {
@@ -760,9 +755,6 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 	cafe->nand.ecc.size = mtd->writesize;
 	cafe->nand.ecc.bytes = 14;
 	cafe->nand.ecc.strength = 4;
-	cafe->nand.ecc.hwctl  = (void *)cafe_nand_bug;
-	cafe->nand.ecc.calculate = (void *)cafe_nand_bug;
-	cafe->nand.ecc.correct  = (void *)cafe_nand_bug;
 	cafe->nand.ecc.write_page = cafe_nand_write_page_lowlevel;
 	cafe->nand.ecc.write_oob = cafe_nand_write_oob;
 	cafe->nand.ecc.read_page = cafe_nand_read_page;
-- 
2.14.1
