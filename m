From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Wed,  4 Jul 2018 00:00:26 +0200
Subject: [PATCH v2 29/32] mtd: rawnand: qcom: convert driver to nand_scan()
In-Reply-To: <20180703220029.19565-1-miquel.raynal@bootlin.com>
References: <20180703220029.19565-1-miquel.raynal@bootlin.com>
Message-ID: <20180703220029.19565-30-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 67 ++++++++++++---------------------------
 1 file changed, 20 insertions(+), 47 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 160acdff7d86..9407357ff77a 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2423,10 +2423,10 @@ qcom_nandc_calc_ecc_bytes(int step_size, int strength)
 NAND_ECC_CAPS_SINGLE(qcom_nandc_ecc_caps, qcom_nandc_calc_ecc_bytes,
 		     NANDC_STEP_SIZE, 4, 8);
 
-static int qcom_nand_host_setup(struct qcom_nand_host *host)
+static int qcom_nand_attach_chip(struct nand_chip *chip)
 {
-	struct nand_chip *chip = &host->chip;
 	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct qcom_nand_host *host = to_qcom_nand_host(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	int cwperpage, bad_block_byte, ret;
@@ -2729,9 +2729,9 @@ static int qcom_nandc_setup(struct qcom_nand_controller *nandc)
 	return 0;
 }
 
-static int qcom_nand_host_init(struct qcom_nand_controller *nandc,
-			       struct qcom_nand_host *host,
-			       struct device_node *dn)
+static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
+					    struct qcom_nand_host *host,
+					    struct device_node *dn)
 {
 	struct nand_chip *chip = &host->chip;
 	struct mtd_info *mtd = nand_to_mtd(chip);
@@ -2778,30 +2778,14 @@ static int qcom_nand_host_init(struct qcom_nand_controller *nandc,
 	/* set up initial status value */
 	host->status = NAND_STATUS_READY | NAND_STATUS_WP;
 
-	ret = nand_scan_ident(mtd, 1, NULL);
-	if (ret)
-		return ret;
-
-	ret = qcom_nand_host_setup(host);
-
-	return ret;
-}
-
-static int qcom_nand_mtd_register(struct qcom_nand_controller *nandc,
-				  struct qcom_nand_host *host,
-				  struct device_node *dn)
-{
-	struct nand_chip *chip = &host->chip;
-	struct mtd_info *mtd = nand_to_mtd(chip);
-	int ret;
-
-	ret = nand_scan_tail(mtd);
+	chip->controller->attach_chip = qcom_nand_attach_chip;
+	ret = nand_scan(mtd, 1);
 	if (ret)
 		return ret;
 
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret)
-		nand_cleanup(mtd_to_nand(mtd));
+		nand_cleanup(chip);
 
 	return ret;
 }
@@ -2810,9 +2794,19 @@ static int qcom_probe_nand_devices(struct qcom_nand_controller *nandc)
 {
 	struct device *dev = nandc->dev;
 	struct device_node *dn = dev->of_node, *child;
-	struct qcom_nand_host *host, *tmp;
+	struct qcom_nand_host *host;
 	int ret;
 
+	if (nandc->props->is_bam) {
+		free_bam_transaction(nandc);
+		nandc->bam_txn = alloc_bam_transaction(nandc);
+		if (!nandc->bam_txn) {
+			dev_err(nandc->dev,
+				"failed to allocate bam transaction\n");
+			return -ENOMEM;
+		}
+	}
+
 	for_each_available_child_of_node(dn, child) {
 		host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
 		if (!host) {
@@ -2820,7 +2814,7 @@ static int qcom_probe_nand_devices(struct qcom_nand_controller *nandc)
 			return -ENOMEM;
 		}
 
-		ret = qcom_nand_host_init(nandc, host, child);
+		ret = qcom_nand_host_init_and_register(nandc, host, child);
 		if (ret) {
 			devm_kfree(dev, host);
 			continue;
@@ -2829,27 +2823,6 @@ static int qcom_probe_nand_devices(struct qcom_nand_controller *nandc)
 		list_add_tail(&host->node, &nandc->host_list);
 	}
 
-	if (list_empty(&nandc->host_list))
-		return -ENODEV;
-
-	if (nandc->props->is_bam) {
-		free_bam_transaction(nandc);
-		nandc->bam_txn = alloc_bam_transaction(nandc);
-		if (!nandc->bam_txn) {
-			dev_err(nandc->dev,
-				"failed to allocate bam transaction\n");
-			return -ENOMEM;
-		}
-	}
-
-	list_for_each_entry_safe(host, tmp, &nandc->host_list, node) {
-		ret = qcom_nand_mtd_register(nandc, host, child);
-		if (ret) {
-			list_del(&host->node);
-			devm_kfree(dev, host);
-		}
-	}
-
 	if (list_empty(&nandc->host_list))
 		return -ENODEV;
 
-- 
2.14.1
