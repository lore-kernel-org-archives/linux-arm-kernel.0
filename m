From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:56 +0100
Subject: [PATCH 48/52] mtd: rawnand: docg4: convert driver to nand_scan()
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-49-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/docg4.c | 51 ++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/mtd/nand/raw/docg4.c b/drivers/mtd/nand/raw/docg4.c
index 1d3d5ac24381..dce040d75af0 100644
--- a/drivers/mtd/nand/raw/docg4.c
+++ b/drivers/mtd/nand/raw/docg4.c
@@ -1227,10 +1227,9 @@ static void __init init_mtd_structs(struct mtd_info *mtd)
 	 * required within a nand driver because they are performed by the nand
 	 * infrastructure code as part of nand_scan().  In this case they need
 	 * to be initialized here because we skip call to nand_scan_ident() (the
-	 * first half of nand_scan()).  The call to nand_scan_ident() is skipped
-	 * because for this device the chip id is not read in the manner of a
-	 * standard nand device.  Unfortunately, nand_scan_ident() does other
-	 * things as well, such as call nand_set_defaults().
+	 * first half of nand_scan()).  The call to nand_scan_ident() could be
+	 * skipped because for this device the chip id is not read in the manner
+	 * of a standard nand device.
 	 */
 
 	struct nand_chip *nand = mtd_to_nand(mtd);
@@ -1315,6 +1314,23 @@ static int __init read_id_reg(struct mtd_info *mtd)
 
 static char const *part_probes[] = { "cmdlinepart", "saftlpart", NULL };
 
+static int docg4_attach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct docg4_priv *doc = (struct docg4_priv *)(chip + 1);
+
+	init_mtd_structs(mtd);
+
+	/* Initialize kernel BCH algorithm */
+	doc->bch = init_bch(DOCG4_M, DOCG4_T, DOCG4_PRIMITIVE_POLY);
+	if (!doc->bch)
+		return -EINVAL;
+
+	reset(mtd);
+
+	return read_id_reg(mtd);
+}
+
 static int __init probe_docg4(struct platform_device *pdev)
 {
 	struct mtd_info *mtd;
@@ -1350,26 +1366,16 @@ static int __init probe_docg4(struct platform_device *pdev)
 	mtd->dev.parent = &pdev->dev;
 	doc->virtadr = virtadr;
 	doc->dev = dev;
-
-	init_mtd_structs(mtd);
-
-	/* initialize kernel bch algorithm */
-	doc->bch = init_bch(DOCG4_M, DOCG4_T, DOCG4_PRIMITIVE_POLY);
-	if (doc->bch == NULL) {
-		retval = -EINVAL;
-		goto free_nand;
-	}
-
 	platform_set_drvdata(pdev, doc);
 
-	reset(mtd);
-	retval = read_id_reg(mtd);
-	if (retval == -ENODEV) {
-		dev_warn(dev, "No diskonchip G4 device found.\n");
-		goto free_bch;
-	}
-
-	retval = nand_scan_tail(mtd);
+	/*
+	 * Asking for 0 chips is useless here but it warns the user that the use
+	 * of the nand_scan() function is a bit abused here because the
+	 * initialization is actually a bit specific and re-handled again in the
+	 * ->attach_chip() hook. It will probably leak some memory though.
+	 */
+	nand->ecc.attach_chip = docg4_attach_chip;
+	retval = nand_scan(mtd, 0);
 	if (retval)
 		goto free_bch;
 
@@ -1389,7 +1395,6 @@ static int __init probe_docg4(struct platform_device *pdev)
 	nand_release(mtd); /* deletes partitions and mtd devices */
 free_bch:
 	free_bch(doc->bch);
-free_nand:
 	kfree(nand);
 unmap:
 	iounmap(virtadr);
-- 
2.14.1
