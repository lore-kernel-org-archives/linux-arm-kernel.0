From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:23 +0100
Subject: [PATCH 15/52] mtd: rawnand: fsl_ifc: convert driver to nand_scan()
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-16-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/fsl_ifc_nand.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index f9c042d69b1c..ec0e7918fb51 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -717,9 +717,9 @@ static int fsl_ifc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 	return nand_prog_page_end_op(chip);
 }
 
-static int fsl_ifc_chip_init_tail(struct mtd_info *mtd)
+static int fsl_ifc_attach_chip(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct fsl_ifc_mtd *priv = nand_get_controller_data(chip);
 
 	dev_dbg(priv->dev, "%s: nand->numchips = %d\n", __func__,
@@ -1051,15 +1051,8 @@ static int fsl_ifc_nand_probe(struct platform_device *dev)
 	if (ret)
 		goto err;
 
-	ret = nand_scan_ident(mtd, 1, NULL);
-	if (ret)
-		goto err;
-
-	ret = fsl_ifc_chip_init_tail(mtd);
-	if (ret)
-		goto err;
-
-	ret = nand_scan_tail(mtd);
+	priv->chip.ecc.attach_chip = fsl_ifc_attach_chip;
+	ret = nand_scan(mtd, 1);
 	if (ret)
 		goto err;
 
-- 
2.14.1
