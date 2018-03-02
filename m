From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:21 +0100
Subject: [PATCH 13/52] mtd: rawnand: fsl_elbc: convert driver to nand_scan()
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-14-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/fsl_elbc_nand.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/raw/fsl_elbc_nand.c b/drivers/mtd/nand/raw/fsl_elbc_nand.c
index fc6b18fc704c..ffbef01ab540 100644
--- a/drivers/mtd/nand/raw/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_elbc_nand.c
@@ -637,9 +637,9 @@ static int fsl_elbc_wait(struct mtd_info *mtd, struct nand_chip *chip)
 	return (elbc_fcm_ctrl->mdr & 0xff) | NAND_STATUS_WP;
 }
 
-static int fsl_elbc_chip_init_tail(struct mtd_info *mtd)
+static int fsl_elbc_attach_chip(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct fsl_elbc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_lbc_ctrl *ctrl = priv->ctrl;
 	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
@@ -912,15 +912,8 @@ static int fsl_elbc_nand_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	ret = nand_scan_ident(mtd, 1, NULL);
-	if (ret)
-		goto err;
-
-	ret = fsl_elbc_chip_init_tail(mtd);
-	if (ret)
-		goto err;
-
-	ret = nand_scan_tail(mtd);
+	priv->chip.ecc.attach_chip = fsl_elbc_attach_chip;
+	ret = nand_scan(mtd, 1);
 	if (ret)
 		goto err;
 
-- 
2.14.1
