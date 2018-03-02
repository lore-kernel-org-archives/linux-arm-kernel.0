From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:57 +0100
Subject: [PATCH 49/52] mtd: rawnand: qcom: convert driver to nand_scan()
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-50-miquel.raynal@bootlin.com>
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
index b554fb6e609c..d45b4e50e6a5 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2315,10 +2315,10 @@ static const struct mtd_ooblayout_ops qcom_nand_ooblayout_ops = {
 	.free = qcom_nand_ooblayout_free,
 };
 
-static int qcom_nand_host_setup(struct qcom_nand_host *host)
+static int qcom_nand_attach_chip(struct nand_chip *chip)
 {
-	struct nand_chip *chip = &host->chip;
 	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct qcom_nand_host *host = to_qcom_nand_host(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	int cwperpage, bad_block_byte;
@@ -2623,9 +2623,9 @@ static int qcom_nandc_setup(struct qcom_nand_controller *nandc)
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
@@ -2672,30 +2672,14 @@ static int qcom_nand_host_init(struct qcom_nand_controller *nandc,
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
+	chip->ecc.attach_chip = qcom_nand_attach_chip;
+	ret = nand_scan(mtd, 1);
 	if (ret)
 		return ret;
 
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret)
-		nand_cleanup(mtd_to_nand(mtd));
+		nand_cleanup(chip);
 
 	return ret;
 }
@@ -2704,9 +2688,19 @@ static int qcom_probe_nand_devices(struct qcom_nand_controller *nandc)
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
@@ -2714,7 +2708,7 @@ static int qcom_probe_nand_devices(struct qcom_nand_controller *nandc)
 			return -ENOMEM;
 		}
 
-		ret = qcom_nand_host_init(nandc, host, child);
+		ret = qcom_nand_host_init_and_register(nandc, host, child);
 		if (ret) {
 			devm_kfree(dev, host);
 			continue;
@@ -2723,27 +2717,6 @@ static int qcom_probe_nand_devices(struct qcom_nand_controller *nandc)
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
