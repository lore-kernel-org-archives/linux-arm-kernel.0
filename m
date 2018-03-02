From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:14 +0100
Subject: [PATCH 06/52] mtd: rawnand: cafe: fix probe function error path
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-7-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An error after nand_scan_tail() should trigger a nand_release().
The helper mtd_device_parse_register() returns an error code that should
be checked and nand_release() called accordingly.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/cafe_nand.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index b4c4032a2d83..15cec32383a6 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -774,21 +774,26 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 	pci_set_drvdata(pdev, mtd);
 
 	mtd->name = "cafe_nand";
-	mtd_device_parse_register(mtd, part_probes, NULL, NULL, 0);
+	err = mtd_device_parse_register(mtd, part_probes, NULL, NULL, 0);
+	if (err)
+		goto out_release_nand;
 
 	goto out;
 
- out_free_dma:
+out_release_nand:
+	nand_release(mtd);
+out_free_dma:
 	dma_free_coherent(&cafe->pdev->dev, 2112, cafe->dmabuf, cafe->dmaaddr);
- out_irq:
+out_irq:
 	/* Disable NAND IRQ in global IRQ mask register */
 	cafe_writel(cafe, ~1 & cafe_readl(cafe, GLOBAL_IRQ_MASK), GLOBAL_IRQ_MASK);
 	free_irq(pdev->irq, mtd);
- out_ior:
+out_ior:
 	pci_iounmap(pdev, cafe->mmio);
- out_free_mtd:
+out_free_mtd:
 	kfree(cafe);
- out:
+out:
+
 	return err;
 }
 
-- 
2.14.1
