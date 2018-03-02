From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:40 +0100
Subject: [PATCH 32/52] mtd: rawnand: omap2: convert driver to nand_scan()
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-33-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/omap2.c | 517 +++++++++++++++++++++----------------------
 1 file changed, 255 insertions(+), 262 deletions(-)

diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index 88c43334d777..4d7a2ccb0725 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -1915,17 +1915,267 @@ static const struct mtd_ooblayout_ops omap_sw_ooblayout_ops = {
 	.free = omap_sw_ooblayout_free,
 };
 
+static int omap_nand_attach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct omap_nand_info *info = mtd_to_omap(mtd);
+	struct device *dev = &info->pdev->dev;
+	int min_oobbytes = BADBLOCK_MARKER_LENGTH;
+	int oobbytes_per_step;
+	dma_cap_mask_t mask;
+	int err;
+
+	if (chip->bbt_options & NAND_BBT_USE_FLASH)
+		chip->bbt_options |= NAND_BBT_NO_OOB;
+	else
+		chip->options |= NAND_SKIP_BBTSCAN;
+
+	/* Re-populate low-level callbacks based on xfer modes */
+	switch (info->xfer_type) {
+	case NAND_OMAP_PREFETCH_POLLED:
+		chip->read_buf = omap_read_buf_pref;
+		chip->write_buf = omap_write_buf_pref;
+		break;
+
+	case NAND_OMAP_POLLED:
+		/* Use nand_base defaults for {read,write}_buf */
+		break;
+
+	case NAND_OMAP_PREFETCH_DMA:
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+		info->dma = dma_request_chan(dev, "rxtx");
+
+		if (IS_ERR(info->dma)) {
+			dev_err(dev, "DMA engine request failed\n");
+			return PTR_ERR(info->dma);
+		} else {
+			struct dma_slave_config cfg;
+
+			memset(&cfg, 0, sizeof(cfg));
+			cfg.src_addr = info->phys_base;
+			cfg.dst_addr = info->phys_base;
+			cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+			cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+			cfg.src_maxburst = 16;
+			cfg.dst_maxburst = 16;
+			err = dmaengine_slave_config(info->dma, &cfg);
+			if (err) {
+				dev_err(dev,
+					"DMA engine slave config failed: %d\n",
+					err);
+				return err;
+			}
+			chip->read_buf = omap_read_buf_dma_pref;
+			chip->write_buf = omap_write_buf_dma_pref;
+		}
+		break;
+
+	case NAND_OMAP_PREFETCH_IRQ:
+		info->gpmc_irq_fifo = platform_get_irq(info->pdev, 0);
+		if (info->gpmc_irq_fifo <= 0) {
+			dev_err(dev, "Error getting fifo IRQ\n");
+			return -ENODEV;
+		}
+		err = devm_request_irq(dev, info->gpmc_irq_fifo,
+				       omap_nand_irq, IRQF_SHARED,
+				       "gpmc-nand-fifo", info);
+		if (err) {
+			dev_err(dev, "Requesting IRQ %d, error %d\n",
+				info->gpmc_irq_fifo, err);
+			info->gpmc_irq_fifo = 0;
+			return err;
+		}
+
+		info->gpmc_irq_count = platform_get_irq(info->pdev, 1);
+		if (info->gpmc_irq_count <= 0) {
+			dev_err(dev, "Error getting IRQ count\n");
+			return -ENODEV;
+		}
+		err = devm_request_irq(dev, info->gpmc_irq_count,
+				       omap_nand_irq, IRQF_SHARED,
+				       "gpmc-nand-count", info);
+		if (err) {
+			dev_err(dev, "Requesting IRQ %d, error %d\n",
+				info->gpmc_irq_count, err);
+			info->gpmc_irq_count = 0;
+			return err;
+		}
+
+		chip->read_buf = omap_read_buf_irq_pref;
+		chip->write_buf = omap_write_buf_irq_pref;
+
+		break;
+
+	default:
+		dev_err(dev, "xfer_type %d not supported!\n", info->xfer_type);
+		return -EINVAL;
+	}
+
+	if (!omap2_nand_ecc_check(info))
+		return -EINVAL;
+
+	/*
+	 * Bail out earlier to let NAND_ECC_SOFT code create its own
+	 * ooblayout instead of using ours.
+	 */
+	if (info->ecc_opt == OMAP_ECC_HAM1_CODE_SW) {
+		chip->ecc.mode = NAND_ECC_SOFT;
+		chip->ecc.algo = NAND_ECC_HAMMING;
+		return 0;
+	}
+
+	/* Populate MTD interface based on ECC scheme */
+	switch (info->ecc_opt) {
+	case OMAP_ECC_HAM1_CODE_HW:
+		dev_info(dev, "nand: using OMAP_ECC_HAM1_CODE_HW\n");
+		chip->ecc.mode		= NAND_ECC_HW;
+		chip->ecc.bytes		= 3;
+		chip->ecc.size		= 512;
+		chip->ecc.strength	= 1;
+		chip->ecc.calculate	= omap_calculate_ecc;
+		chip->ecc.hwctl		= omap_enable_hwecc;
+		chip->ecc.correct	= omap_correct_data;
+		mtd_set_ooblayout(mtd, &omap_ooblayout_ops);
+		oobbytes_per_step	= chip->ecc.bytes;
+
+		if (!(chip->options & NAND_BUSWIDTH_16))
+			min_oobbytes	= 1;
+
+		break;
+
+	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
+		pr_info("nand: using OMAP_ECC_BCH4_CODE_HW_DETECTION_SW\n");
+		chip->ecc.mode		= NAND_ECC_HW;
+		chip->ecc.size		= 512;
+		chip->ecc.bytes		= 7;
+		chip->ecc.strength	= 4;
+		chip->ecc.hwctl		= omap_enable_hwecc_bch;
+		chip->ecc.correct	= nand_bch_correct_data;
+		chip->ecc.calculate	= omap_calculate_ecc_bch_sw;
+		mtd_set_ooblayout(mtd, &omap_sw_ooblayout_ops);
+		/* Reserve one byte for the OMAP marker */
+		oobbytes_per_step	= chip->ecc.bytes + 1;
+		/* Software BCH library is used for locating errors */
+		chip->ecc.priv		= nand_bch_init(mtd);
+		if (!chip->ecc.priv) {
+			dev_err(dev, "Unable to use BCH library\n");
+			return -EINVAL;
+		}
+		break;
+
+	case OMAP_ECC_BCH4_CODE_HW:
+		pr_info("nand: using OMAP_ECC_BCH4_CODE_HW ECC scheme\n");
+		chip->ecc.mode		= NAND_ECC_HW;
+		chip->ecc.size		= 512;
+		/* 14th bit is kept reserved for ROM-code compatibility */
+		chip->ecc.bytes		= 7 + 1;
+		chip->ecc.strength	= 4;
+		chip->ecc.hwctl		= omap_enable_hwecc_bch;
+		chip->ecc.correct	= omap_elm_correct_data;
+		chip->ecc.read_page	= omap_read_page_bch;
+		chip->ecc.write_page	= omap_write_page_bch;
+		chip->ecc.write_subpage	= omap_write_subpage_bch;
+		mtd_set_ooblayout(mtd, &omap_ooblayout_ops);
+		oobbytes_per_step	= chip->ecc.bytes;
+
+		err = elm_config(info->elm_dev, BCH4_ECC,
+				 mtd->writesize / chip->ecc.size,
+				 chip->ecc.size, chip->ecc.bytes);
+		if (err < 0)
+			return err;
+		break;
+
+	case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
+		pr_info("nand: using OMAP_ECC_BCH8_CODE_HW_DETECTION_SW\n");
+		chip->ecc.mode		= NAND_ECC_HW;
+		chip->ecc.size		= 512;
+		chip->ecc.bytes		= 13;
+		chip->ecc.strength	= 8;
+		chip->ecc.hwctl		= omap_enable_hwecc_bch;
+		chip->ecc.correct	= nand_bch_correct_data;
+		chip->ecc.calculate	= omap_calculate_ecc_bch_sw;
+		mtd_set_ooblayout(mtd, &omap_sw_ooblayout_ops);
+		/* Reserve one byte for the OMAP marker */
+		oobbytes_per_step	= chip->ecc.bytes + 1;
+		/* Software BCH library is used for locating errors */
+		chip->ecc.priv		= nand_bch_init(mtd);
+		if (!chip->ecc.priv) {
+			dev_err(dev, "unable to use BCH library\n");
+			return -EINVAL;
+		}
+		break;
+
+	case OMAP_ECC_BCH8_CODE_HW:
+		pr_info("nand: using OMAP_ECC_BCH8_CODE_HW ECC scheme\n");
+		chip->ecc.mode		= NAND_ECC_HW;
+		chip->ecc.size		= 512;
+		/* 14th bit is kept reserved for ROM-code compatibility */
+		chip->ecc.bytes		= 13 + 1;
+		chip->ecc.strength	= 8;
+		chip->ecc.hwctl		= omap_enable_hwecc_bch;
+		chip->ecc.correct	= omap_elm_correct_data;
+		chip->ecc.read_page	= omap_read_page_bch;
+		chip->ecc.write_page	= omap_write_page_bch;
+		chip->ecc.write_subpage	= omap_write_subpage_bch;
+		mtd_set_ooblayout(mtd, &omap_ooblayout_ops);
+		oobbytes_per_step	= chip->ecc.bytes;
+
+		err = elm_config(info->elm_dev, BCH8_ECC,
+				 mtd->writesize / chip->ecc.size,
+				 chip->ecc.size, chip->ecc.bytes);
+		if (err < 0)
+			return err;
+
+		break;
+
+	case OMAP_ECC_BCH16_CODE_HW:
+		pr_info("Using OMAP_ECC_BCH16_CODE_HW ECC scheme\n");
+		chip->ecc.mode		= NAND_ECC_HW;
+		chip->ecc.size		= 512;
+		chip->ecc.bytes		= 26;
+		chip->ecc.strength	= 16;
+		chip->ecc.hwctl		= omap_enable_hwecc_bch;
+		chip->ecc.correct	= omap_elm_correct_data;
+		chip->ecc.read_page	= omap_read_page_bch;
+		chip->ecc.write_page	= omap_write_page_bch;
+		chip->ecc.write_subpage	= omap_write_subpage_bch;
+		mtd_set_ooblayout(mtd, &omap_ooblayout_ops);
+		oobbytes_per_step	= chip->ecc.bytes;
+
+		err = elm_config(info->elm_dev, BCH16_ECC,
+				 mtd->writesize / chip->ecc.size,
+				 chip->ecc.size, chip->ecc.bytes);
+		if (err < 0)
+			return err;
+
+		break;
+	default:
+		dev_err(dev, "Invalid or unsupported ECC scheme\n");
+		return -EINVAL;
+	}
+
+	/* Check if NAND device's OOB is enough to store ECC signatures */
+	min_oobbytes += (oobbytes_per_step *
+			 (mtd->writesize / chip->ecc.size));
+	if (mtd->oobsize < min_oobbytes) {
+		dev_err(dev,
+			"Not enough OOB bytes: required = %d, available=%d\n",
+			min_oobbytes, mtd->oobsize);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int omap_nand_probe(struct platform_device *pdev)
 {
 	struct omap_nand_info		*info;
 	struct mtd_info			*mtd;
 	struct nand_chip		*nand_chip;
 	int				err;
-	dma_cap_mask_t			mask;
 	struct resource			*res;
 	struct device			*dev = &pdev->dev;
-	int				min_oobbytes = BADBLOCK_MARKER_LENGTH;
-	int				oobbytes_per_step;
 
 	info = devm_kzalloc(&pdev->dev, sizeof(struct omap_nand_info),
 				GFP_KERNEL);
@@ -1998,266 +2248,9 @@ static int omap_nand_probe(struct platform_device *pdev)
 
 	/* scan NAND device connected to chip controller */
 	nand_chip->options |= info->devsize & NAND_BUSWIDTH_16;
-	err = nand_scan_ident(mtd, 1, NULL);
-	if (err) {
-		dev_err(&info->pdev->dev,
-			"scan failed, may be bus-width mismatch\n");
-		goto return_error;
-	}
 
-	if (nand_chip->bbt_options & NAND_BBT_USE_FLASH)
-		nand_chip->bbt_options |= NAND_BBT_NO_OOB;
-	else
-		nand_chip->options |= NAND_SKIP_BBTSCAN;
-
-	/* re-populate low-level callbacks based on xfer modes */
-	switch (info->xfer_type) {
-	case NAND_OMAP_PREFETCH_POLLED:
-		nand_chip->read_buf   = omap_read_buf_pref;
-		nand_chip->write_buf  = omap_write_buf_pref;
-		break;
-
-	case NAND_OMAP_POLLED:
-		/* Use nand_base defaults for {read,write}_buf */
-		break;
-
-	case NAND_OMAP_PREFETCH_DMA:
-		dma_cap_zero(mask);
-		dma_cap_set(DMA_SLAVE, mask);
-		info->dma = dma_request_chan(pdev->dev.parent, "rxtx");
-
-		if (IS_ERR(info->dma)) {
-			dev_err(&pdev->dev, "DMA engine request failed\n");
-			err = PTR_ERR(info->dma);
-			goto return_error;
-		} else {
-			struct dma_slave_config cfg;
-
-			memset(&cfg, 0, sizeof(cfg));
-			cfg.src_addr = info->phys_base;
-			cfg.dst_addr = info->phys_base;
-			cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-			cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-			cfg.src_maxburst = 16;
-			cfg.dst_maxburst = 16;
-			err = dmaengine_slave_config(info->dma, &cfg);
-			if (err) {
-				dev_err(&pdev->dev, "DMA engine slave config failed: %d\n",
-					err);
-				goto return_error;
-			}
-			nand_chip->read_buf   = omap_read_buf_dma_pref;
-			nand_chip->write_buf  = omap_write_buf_dma_pref;
-		}
-		break;
-
-	case NAND_OMAP_PREFETCH_IRQ:
-		info->gpmc_irq_fifo = platform_get_irq(pdev, 0);
-		if (info->gpmc_irq_fifo <= 0) {
-			dev_err(&pdev->dev, "error getting fifo irq\n");
-			err = -ENODEV;
-			goto return_error;
-		}
-		err = devm_request_irq(&pdev->dev, info->gpmc_irq_fifo,
-					omap_nand_irq, IRQF_SHARED,
-					"gpmc-nand-fifo", info);
-		if (err) {
-			dev_err(&pdev->dev, "requesting irq(%d) error:%d",
-						info->gpmc_irq_fifo, err);
-			info->gpmc_irq_fifo = 0;
-			goto return_error;
-		}
-
-		info->gpmc_irq_count = platform_get_irq(pdev, 1);
-		if (info->gpmc_irq_count <= 0) {
-			dev_err(&pdev->dev, "error getting count irq\n");
-			err = -ENODEV;
-			goto return_error;
-		}
-		err = devm_request_irq(&pdev->dev, info->gpmc_irq_count,
-					omap_nand_irq, IRQF_SHARED,
-					"gpmc-nand-count", info);
-		if (err) {
-			dev_err(&pdev->dev, "requesting irq(%d) error:%d",
-						info->gpmc_irq_count, err);
-			info->gpmc_irq_count = 0;
-			goto return_error;
-		}
-
-		nand_chip->read_buf  = omap_read_buf_irq_pref;
-		nand_chip->write_buf = omap_write_buf_irq_pref;
-
-		break;
-
-	default:
-		dev_err(&pdev->dev,
-			"xfer_type(%d) not supported!\n", info->xfer_type);
-		err = -EINVAL;
-		goto return_error;
-	}
-
-	if (!omap2_nand_ecc_check(info)) {
-		err = -EINVAL;
-		goto return_error;
-	}
-
-	/*
-	 * Bail out earlier to let NAND_ECC_SOFT code create its own
-	 * ooblayout instead of using ours.
-	 */
-	if (info->ecc_opt == OMAP_ECC_HAM1_CODE_SW) {
-		nand_chip->ecc.mode = NAND_ECC_SOFT;
-		nand_chip->ecc.algo = NAND_ECC_HAMMING;
-		goto scan_tail;
-	}
-
-	/* populate MTD interface based on ECC scheme */
-	switch (info->ecc_opt) {
-	case OMAP_ECC_HAM1_CODE_HW:
-		pr_info("nand: using OMAP_ECC_HAM1_CODE_HW\n");
-		nand_chip->ecc.mode             = NAND_ECC_HW;
-		nand_chip->ecc.bytes            = 3;
-		nand_chip->ecc.size             = 512;
-		nand_chip->ecc.strength         = 1;
-		nand_chip->ecc.calculate        = omap_calculate_ecc;
-		nand_chip->ecc.hwctl            = omap_enable_hwecc;
-		nand_chip->ecc.correct          = omap_correct_data;
-		mtd_set_ooblayout(mtd, &omap_ooblayout_ops);
-		oobbytes_per_step		= nand_chip->ecc.bytes;
-
-		if (!(nand_chip->options & NAND_BUSWIDTH_16))
-			min_oobbytes		= 1;
-
-		break;
-
-	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
-		pr_info("nand: using OMAP_ECC_BCH4_CODE_HW_DETECTION_SW\n");
-		nand_chip->ecc.mode		= NAND_ECC_HW;
-		nand_chip->ecc.size		= 512;
-		nand_chip->ecc.bytes		= 7;
-		nand_chip->ecc.strength		= 4;
-		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
-		nand_chip->ecc.correct		= nand_bch_correct_data;
-		nand_chip->ecc.calculate	= omap_calculate_ecc_bch_sw;
-		mtd_set_ooblayout(mtd, &omap_sw_ooblayout_ops);
-		/* Reserve one byte for the OMAP marker */
-		oobbytes_per_step		= nand_chip->ecc.bytes + 1;
-		/* software bch library is used for locating errors */
-		nand_chip->ecc.priv		= nand_bch_init(mtd);
-		if (!nand_chip->ecc.priv) {
-			dev_err(&info->pdev->dev, "unable to use BCH library\n");
-			err = -EINVAL;
-			goto return_error;
-		}
-		break;
-
-	case OMAP_ECC_BCH4_CODE_HW:
-		pr_info("nand: using OMAP_ECC_BCH4_CODE_HW ECC scheme\n");
-		nand_chip->ecc.mode		= NAND_ECC_HW;
-		nand_chip->ecc.size		= 512;
-		/* 14th bit is kept reserved for ROM-code compatibility */
-		nand_chip->ecc.bytes		= 7 + 1;
-		nand_chip->ecc.strength		= 4;
-		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
-		nand_chip->ecc.correct		= omap_elm_correct_data;
-		nand_chip->ecc.read_page	= omap_read_page_bch;
-		nand_chip->ecc.write_page	= omap_write_page_bch;
-		nand_chip->ecc.write_subpage	= omap_write_subpage_bch;
-		mtd_set_ooblayout(mtd, &omap_ooblayout_ops);
-		oobbytes_per_step		= nand_chip->ecc.bytes;
-
-		err = elm_config(info->elm_dev, BCH4_ECC,
-				 mtd->writesize / nand_chip->ecc.size,
-				 nand_chip->ecc.size, nand_chip->ecc.bytes);
-		if (err < 0)
-			goto return_error;
-		break;
-
-	case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
-		pr_info("nand: using OMAP_ECC_BCH8_CODE_HW_DETECTION_SW\n");
-		nand_chip->ecc.mode		= NAND_ECC_HW;
-		nand_chip->ecc.size		= 512;
-		nand_chip->ecc.bytes		= 13;
-		nand_chip->ecc.strength		= 8;
-		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
-		nand_chip->ecc.correct		= nand_bch_correct_data;
-		nand_chip->ecc.calculate	= omap_calculate_ecc_bch_sw;
-		mtd_set_ooblayout(mtd, &omap_sw_ooblayout_ops);
-		/* Reserve one byte for the OMAP marker */
-		oobbytes_per_step		= nand_chip->ecc.bytes + 1;
-		/* software bch library is used for locating errors */
-		nand_chip->ecc.priv		= nand_bch_init(mtd);
-		if (!nand_chip->ecc.priv) {
-			dev_err(&info->pdev->dev, "unable to use BCH library\n");
-			err = -EINVAL;
-			goto return_error;
-		}
-		break;
-
-	case OMAP_ECC_BCH8_CODE_HW:
-		pr_info("nand: using OMAP_ECC_BCH8_CODE_HW ECC scheme\n");
-		nand_chip->ecc.mode		= NAND_ECC_HW;
-		nand_chip->ecc.size		= 512;
-		/* 14th bit is kept reserved for ROM-code compatibility */
-		nand_chip->ecc.bytes		= 13 + 1;
-		nand_chip->ecc.strength		= 8;
-		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
-		nand_chip->ecc.correct		= omap_elm_correct_data;
-		nand_chip->ecc.read_page	= omap_read_page_bch;
-		nand_chip->ecc.write_page	= omap_write_page_bch;
-		nand_chip->ecc.write_subpage	= omap_write_subpage_bch;
-		mtd_set_ooblayout(mtd, &omap_ooblayout_ops);
-		oobbytes_per_step		= nand_chip->ecc.bytes;
-
-		err = elm_config(info->elm_dev, BCH8_ECC,
-				 mtd->writesize / nand_chip->ecc.size,
-				 nand_chip->ecc.size, nand_chip->ecc.bytes);
-		if (err < 0)
-			goto return_error;
-
-		break;
-
-	case OMAP_ECC_BCH16_CODE_HW:
-		pr_info("using OMAP_ECC_BCH16_CODE_HW ECC scheme\n");
-		nand_chip->ecc.mode		= NAND_ECC_HW;
-		nand_chip->ecc.size		= 512;
-		nand_chip->ecc.bytes		= 26;
-		nand_chip->ecc.strength		= 16;
-		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
-		nand_chip->ecc.correct		= omap_elm_correct_data;
-		nand_chip->ecc.read_page	= omap_read_page_bch;
-		nand_chip->ecc.write_page	= omap_write_page_bch;
-		nand_chip->ecc.write_subpage	= omap_write_subpage_bch;
-		mtd_set_ooblayout(mtd, &omap_ooblayout_ops);
-		oobbytes_per_step		= nand_chip->ecc.bytes;
-
-		err = elm_config(info->elm_dev, BCH16_ECC,
-				 mtd->writesize / nand_chip->ecc.size,
-				 nand_chip->ecc.size, nand_chip->ecc.bytes);
-		if (err < 0)
-			goto return_error;
-
-		break;
-	default:
-		dev_err(&info->pdev->dev, "invalid or unsupported ECC scheme\n");
-		err = -EINVAL;
-		goto return_error;
-	}
-
-	/* check if NAND device's OOB is enough to store ECC signatures */
-	min_oobbytes += (oobbytes_per_step *
-			 (mtd->writesize / nand_chip->ecc.size));
-	if (mtd->oobsize < min_oobbytes) {
-		dev_err(&info->pdev->dev,
-			"not enough OOB bytes required = %d, available=%d\n",
-			min_oobbytes, mtd->oobsize);
-		err = -EINVAL;
-		goto return_error;
-	}
-
-scan_tail:
-	/* second phase scan */
-	err = nand_scan_tail(mtd);
+	nand_chip->ecc.attach_chip = omap_nand_attach_chip;
+	err = nand_scan(mtd, 1);
 	if (err)
 		goto return_error;
 
-- 
2.14.1
