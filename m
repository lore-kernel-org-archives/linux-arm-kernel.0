From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:42 +0100
Subject: [PATCH 34/52] mtd: rawnand: s3c2410: convert driver to nand_scan()
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-35-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/s3c2410.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
index 1bc0458063d8..67cf185ed116 100644
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -915,20 +915,19 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 }
 
 /**
- * s3c2410_nand_update_chip - post probe update
- * @info: The controller instance.
- * @nmtd: The driver version of the MTD instance.
+ * s3c2410_nand_attach_chip - Init the ECC engine after NAND scan
+ * @chip: The NAND chip
  *
- * This routine is called after the chip probe has successfully completed
- * and the relevant per-chip information updated. This call ensure that
+ * This hook is called by the core after the identification of the NAND chip,
+ * once the relevant per-chip information is up to date.. This call ensure that
  * we update the internal state accordingly.
  *
  * The internal state is currently limited to the ECC state information.
 */
-static int s3c2410_nand_update_chip(struct s3c2410_nand_info *info,
-				    struct s3c2410_nand_mtd *nmtd)
+static int s3c2410_nand_attach_chip(struct nand_chip *chip)
 {
-	struct nand_chip *chip = &nmtd->chip;
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct s3c2410_nand_info *info = s3c2410_nand_mtd_toinfo(mtd);
 
 	switch (chip->ecc.mode) {
 
@@ -1161,15 +1160,8 @@ static int s3c24xx_nand_probe(struct platform_device *pdev)
 		mtd->dev.parent = &pdev->dev;
 		s3c2410_nand_init_chip(info, nmtd, sets);
 
-		err = nand_scan_ident(mtd, (sets) ? sets->nr_chips : 1, NULL);
-		if (err)
-			goto exit_error;
-
-		err = s3c2410_nand_update_chip(info, nmtd);
-		if (err < 0)
-			goto exit_error;
-
-		err = nand_scan_tail(mtd);
+		nmtd->chip.ecc.attach_chip = s3c2410_nand_attach_chip;
+		err = nand_scan(mtd, sets ? sets->nr_chips : 1);
 		if (err)
 			goto exit_error;
 
-- 
2.14.1
