From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Wed,  4 Jul 2018 00:00:02 +0200
Subject: [PATCH v2 05/32] mtd: rawnand: denali: convert to nand_scan()
In-Reply-To: <20180703220029.19565-1-miquel.raynal@bootlin.com>
References: <20180703220029.19565-1-miquel.raynal@bootlin.com>
Message-ID: <20180703220029.19565-6-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/denali.c | 134 +++++++++++++++++++++++-------------------
 1 file changed, 73 insertions(+), 61 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 4d53f41ada08..09b85d749552 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -1205,62 +1205,12 @@ static int denali_multidev_fixup(struct denali_nand_info *denali)
 	return 0;
 }
 
-int denali_init(struct denali_nand_info *denali)
+static int denali_attach_chip(struct nand_chip *chip)
 {
-	struct nand_chip *chip = &denali->nand;
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	u32 features = ioread32(denali->reg + FEATURES);
+	struct denali_nand_info *denali = mtd_to_denali(mtd);
 	int ret;
 
-	mtd->dev.parent = denali->dev;
-	denali_hw_init(denali);
-
-	init_completion(&denali->complete);
-	spin_lock_init(&denali->irq_lock);
-
-	denali_clear_irq_all(denali);
-
-	ret = devm_request_irq(denali->dev, denali->irq, denali_isr,
-			       IRQF_SHARED, DENALI_NAND_NAME, denali);
-	if (ret) {
-		dev_err(denali->dev, "Unable to request IRQ\n");
-		return ret;
-	}
-
-	denali_enable_irq(denali);
-	denali_reset_banks(denali);
-
-	denali->active_bank = DENALI_INVALID_BANK;
-
-	nand_set_flash_node(chip, denali->dev->of_node);
-	/* Fallback to the default name if DT did not give "label" property */
-	if (!mtd->name)
-		mtd->name = "denali-nand";
-
-	chip->select_chip = denali_select_chip;
-	chip->read_byte = denali_read_byte;
-	chip->write_byte = denali_write_byte;
-	chip->read_word = denali_read_word;
-	chip->cmd_ctrl = denali_cmd_ctrl;
-	chip->dev_ready = denali_dev_ready;
-	chip->waitfunc = denali_waitfunc;
-
-	if (features & FEATURES__INDEX_ADDR) {
-		denali->host_read = denali_indexed_read;
-		denali->host_write = denali_indexed_write;
-	} else {
-		denali->host_read = denali_direct_read;
-		denali->host_write = denali_direct_write;
-	}
-
-	/* clk rate info is needed for setup_data_interface */
-	if (denali->clk_rate && denali->clk_x_rate)
-		chip->setup_data_interface = denali_setup_data_interface;
-
-	ret = nand_scan_ident(mtd, denali->max_banks, NULL);
-	if (ret)
-		goto disable_irq;
-
 	if (ioread32(denali->reg + FEATURES) & FEATURES__DMA)
 		denali->dma_avail = 1;
 
@@ -1293,7 +1243,7 @@ int denali_init(struct denali_nand_info *denali)
 				   mtd->oobsize - denali->oob_skip_bytes);
 	if (ret) {
 		dev_err(denali->dev, "Failed to setup ECC settings.\n");
-		goto disable_irq;
+		return ret;
 	}
 
 	dev_dbg(denali->dev,
@@ -1337,7 +1287,7 @@ int denali_init(struct denali_nand_info *denali)
 
 	ret = denali_multidev_fixup(denali);
 	if (ret)
-		goto disable_irq;
+		return ret;
 
 	/*
 	 * This buffer is DMA-mapped by denali_{read,write}_page_raw.  Do not
@@ -1345,26 +1295,88 @@ int denali_init(struct denali_nand_info *denali)
 	 * guarantee DMA-safe alignment.
 	 */
 	denali->buf = kmalloc(mtd->writesize + mtd->oobsize, GFP_KERNEL);
-	if (!denali->buf) {
-		ret = -ENOMEM;
-		goto disable_irq;
+	if (!denali->buf)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void denali_detach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct denali_nand_info *denali = mtd_to_denali(mtd);
+
+	kfree(denali->buf);
+}
+
+int denali_init(struct denali_nand_info *denali)
+{
+	struct nand_chip *chip = &denali->nand;
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	u32 features = ioread32(denali->reg + FEATURES);
+	int ret;
+
+	mtd->dev.parent = denali->dev;
+	denali_hw_init(denali);
+
+	init_completion(&denali->complete);
+	spin_lock_init(&denali->irq_lock);
+
+	denali_clear_irq_all(denali);
+
+	ret = devm_request_irq(denali->dev, denali->irq, denali_isr,
+			       IRQF_SHARED, DENALI_NAND_NAME, denali);
+	if (ret) {
+		dev_err(denali->dev, "Unable to request IRQ\n");
+		return ret;
 	}
 
-	ret = nand_scan_tail(mtd);
+	denali_enable_irq(denali);
+	denali_reset_banks(denali);
+
+	denali->active_bank = DENALI_INVALID_BANK;
+
+	nand_set_flash_node(chip, denali->dev->of_node);
+	/* Fallback to the default name if DT did not give "label" property */
+	if (!mtd->name)
+		mtd->name = "denali-nand";
+
+	chip->select_chip = denali_select_chip;
+	chip->read_byte = denali_read_byte;
+	chip->write_byte = denali_write_byte;
+	chip->read_word = denali_read_word;
+	chip->cmd_ctrl = denali_cmd_ctrl;
+	chip->dev_ready = denali_dev_ready;
+	chip->waitfunc = denali_waitfunc;
+
+	if (features & FEATURES__INDEX_ADDR) {
+		denali->host_read = denali_indexed_read;
+		denali->host_write = denali_indexed_write;
+	} else {
+		denali->host_read = denali_direct_read;
+		denali->host_write = denali_direct_write;
+	}
+
+	/* clk rate info is needed for setup_data_interface */
+	if (denali->clk_rate && denali->clk_x_rate)
+		chip->setup_data_interface = denali_setup_data_interface;
+
+	chip->hwcontrol.attach_chip = denali_attach_chip;
+	chip->hwcontrol.detach_chip = denali_detach_chip;
+	ret = nand_scan(mtd, denali->max_banks);
 	if (ret)
-		goto free_buf;
+		goto disable_irq;
 
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret) {
 		dev_err(denali->dev, "Failed to register MTD: %d\n", ret);
 		goto cleanup_nand;
 	}
+
 	return 0;
 
 cleanup_nand:
 	nand_cleanup(chip);
-free_buf:
-	kfree(denali->buf);
 disable_irq:
 	denali_disable_irq(denali);
 
-- 
2.14.1
