From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:25 +0100
Subject: [PATCH 17/52] mtd: rawnand: fsmc: convert driver to nand_scan()
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-18-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/fsmc_nand.c | 148 ++++++++++++++++++++-------------------
 1 file changed, 76 insertions(+), 72 deletions(-)

diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 1bf73d4d4c0d..8e0c27f9961b 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -918,6 +918,78 @@ static int fsmc_nand_probe_config_dt(struct platform_device *pdev,
 	return 0;
 }
 
+static int fsmc_nand_attach_chip(struct nand_chip *nand)
+{
+	struct mtd_info *mtd = nand_to_mtd(nand);
+	struct fsmc_nand_data *host = mtd_to_fsmc(mtd);
+
+	if (AMBA_REV_BITS(host->pid) >= 8) {
+		switch (mtd->oobsize) {
+		case 16:
+		case 64:
+		case 128:
+		case 224:
+		case 256:
+			break;
+		default:
+			dev_warn(host->dev,
+				 "No oob scheme defined for oobsize %d\n",
+				 mtd->oobsize);
+			return -EINVAL;
+		}
+
+		mtd_set_ooblayout(mtd, &fsmc_ecc4_ooblayout_ops);
+
+		return 0;
+	}
+
+	switch (nand->ecc.mode) {
+	case NAND_ECC_HW:
+		dev_info(host->dev, "Using 1-bit HW ECC scheme\n");
+		nand->ecc.calculate = fsmc_read_hwecc_ecc1;
+		nand->ecc.correct = nand_correct_data;
+		nand->ecc.bytes = 3;
+		nand->ecc.strength = 1;
+		break;
+
+	case NAND_ECC_SOFT:
+		if (nand->ecc.algo == NAND_ECC_BCH) {
+			dev_info(host->dev,
+				 "Using 4-bit SW BCH ECC scheme\n");
+			break;
+		}
+
+	case NAND_ECC_ON_DIE:
+		break;
+
+	default:
+		dev_err(host->dev, "Unsupported ECC mode!\n");
+		return -ENOTSUPP;
+	}
+
+	/*
+	 * Don't set layout for BCH4 SW ECC. This will be
+	 * generated later in nand_bch_init() later.
+	 */
+	if (nand->ecc.mode == NAND_ECC_HW) {
+		switch (mtd->oobsize) {
+		case 16:
+		case 64:
+		case 128:
+			mtd_set_ooblayout(mtd,
+					  &fsmc_ecc1_ooblayout_ops);
+			break;
+		default:
+			dev_warn(host->dev,
+				 "No oob scheme defined for oobsize %d\n",
+				 mtd->oobsize);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * fsmc_nand_probe - Probe function
  * @pdev:       platform device structure
@@ -1047,78 +1119,10 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	/*
 	 * Scan to find existence of the device
 	 */
-	ret = nand_scan_ident(mtd, 1, NULL);
-	if (ret) {
-		dev_err(&pdev->dev, "No NAND Device found!\n");
-		goto err_scan_ident;
-	}
-
-	if (AMBA_REV_BITS(host->pid) >= 8) {
-		switch (mtd->oobsize) {
-		case 16:
-		case 64:
-		case 128:
-		case 224:
-		case 256:
-			break;
-		default:
-			dev_warn(&pdev->dev, "No oob scheme defined for oobsize %d\n",
-				 mtd->oobsize);
-			ret = -EINVAL;
-			goto err_probe;
-		}
-
-		mtd_set_ooblayout(mtd, &fsmc_ecc4_ooblayout_ops);
-	} else {
-		switch (nand->ecc.mode) {
-		case NAND_ECC_HW:
-			dev_info(&pdev->dev, "Using 1-bit HW ECC scheme\n");
-			nand->ecc.calculate = fsmc_read_hwecc_ecc1;
-			nand->ecc.correct = nand_correct_data;
-			nand->ecc.bytes = 3;
-			nand->ecc.strength = 1;
-			break;
-
-		case NAND_ECC_SOFT:
-			if (nand->ecc.algo == NAND_ECC_BCH) {
-				dev_info(&pdev->dev, "Using 4-bit SW BCH ECC scheme\n");
-				break;
-			}
-
-		case NAND_ECC_ON_DIE:
-			break;
-
-		default:
-			dev_err(&pdev->dev, "Unsupported ECC mode!\n");
-			goto err_probe;
-		}
-
-		/*
-		 * Don't set layout for BCH4 SW ECC. This will be
-		 * generated later in nand_bch_init() later.
-		 */
-		if (nand->ecc.mode == NAND_ECC_HW) {
-			switch (mtd->oobsize) {
-			case 16:
-			case 64:
-			case 128:
-				mtd_set_ooblayout(mtd,
-						  &fsmc_ecc1_ooblayout_ops);
-				break;
-			default:
-				dev_warn(&pdev->dev,
-					 "No oob scheme defined for oobsize %d\n",
-					 mtd->oobsize);
-				ret = -EINVAL;
-				goto err_probe;
-			}
-		}
-	}
-
-	/* Second stage of scan to fill MTD data-structures */
-	ret = nand_scan_tail(mtd);
+	nand->ecc.attach_chip = fsmc_nand_attach_chip;
+	ret = nand_scan(mtd, 1);
 	if (ret)
-		goto err_probe;
+		goto err_scan;
 
 	mtd->name = "nand";
 	ret = mtd_device_register(mtd, NULL, 0);
@@ -1132,7 +1136,7 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 
 err_release_nand:
 	nand_release(mtd);
-err_probe:
+err_scan:
 	if (host->mode == USE_DMA_ACCESS)
 		dma_release_channel(host->write_dma_chan);
 err_req_write_chnl:
-- 
2.14.1
