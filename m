From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 25 May 2016 11:29:40 -0500
Subject: [PATCH 2/5] EDAC, altera: ECC Manager IRQ controller support
In-Reply-To: <1464193783-5071-1-git-send-email-tthayer@opensource.altera.com>
References: <1464193783-5071-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1464193783-5071-3-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

To better support child devices, the ECC manager needs to be
implemented as an IRQ controller.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 drivers/edac/altera_edac.c |  162 +++++++++++++++++++++++++++++++++-----------
 drivers/edac/altera_edac.h |    5 +-
 2 files changed, 125 insertions(+), 42 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 5b4d223..3eb73bc 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -22,9 +22,11 @@
 #include <linux/edac.h>
 #include <linux/genalloc.h>
 #include <linux/interrupt.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -882,22 +884,27 @@ static void ocram_free_mem(void *p, size_t size, void *other)
 	gen_pool_free((struct gen_pool *)other, (u32)p, size);
 }
 
-static irqreturn_t altr_edac_a10_ecc_irq(struct altr_edac_device_dev *dci,
-					 bool sberr)
+static irqreturn_t altr_edac_a10_ecc_irq(int irq, void *dev_id)
 {
+	irqreturn_t ret_value = IRQ_NONE;
+	struct altr_edac_device_dev *dci = dev_id;
 	void __iomem  *base = dci->base;
 
-	if (sberr) {
+	if (irq == dci->sb_irq) {
+		ret_value = IRQ_HANDLED;
 		writel(ALTR_A10_ECC_SERRPENA,
 		       base + ALTR_A10_ECC_INTSTAT_OFST);
 		edac_device_handle_ce(dci->edac_dev, 0, 0, dci->edac_dev_name);
-	} else {
+	} else if (irq == dci->db_irq) {
+		ret_value = IRQ_HANDLED;
 		writel(ALTR_A10_ECC_DERRPENA,
 		       base + ALTR_A10_ECC_INTSTAT_OFST);
 		edac_device_handle_ue(dci->edac_dev, 0, 0, dci->edac_dev_name);
 		panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
+	} else {
+		WARN_ON(1);
 	}
-	return IRQ_HANDLED;
+	return ret_value;
 }
 
 const struct edac_device_prv_data ocramecc_data = {
@@ -988,22 +995,28 @@ static int altr_l2_check_deps(struct altr_edac_device_dev *device)
 	return -ENODEV;
 }
 
-static irqreturn_t altr_edac_a10_l2_irq(struct altr_edac_device_dev *dci,
-					bool sberr)
+static irqreturn_t altr_edac_a10_l2_irq(int irq, void *dev_id)
 {
-	if (sberr) {
+	irqreturn_t ret_value = IRQ_NONE;
+	struct altr_edac_device_dev *dci = dev_id;
+
+	if (irq == dci->sb_irq) {
+		ret_value = IRQ_HANDLED;
 		regmap_write(dci->edac->ecc_mgr_map,
 			     A10_SYSGMR_MPU_CLEAR_L2_ECC_OFST,
 			     A10_SYSGMR_MPU_CLEAR_L2_ECC_SB);
 		edac_device_handle_ce(dci->edac_dev, 0, 0, dci->edac_dev_name);
-	} else {
+	} else if (irq == dci->db_irq) {
+		ret_value = IRQ_HANDLED;
 		regmap_write(dci->edac->ecc_mgr_map,
 			     A10_SYSGMR_MPU_CLEAR_L2_ECC_OFST,
 			     A10_SYSGMR_MPU_CLEAR_L2_ECC_MB);
 		edac_device_handle_ue(dci->edac_dev, 0, 0, dci->edac_dev_name);
 		panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
+	} else {
+		WARN_ON(1);
 	}
-	return IRQ_HANDLED;
+	return ret_value;
 }
 
 const struct edac_device_prv_data l2ecc_data = {
@@ -1075,28 +1088,27 @@ static ssize_t altr_edac_a10_device_trig(struct file *file,
 	return count;
 }
 
-static irqreturn_t altr_edac_a10_irq_handler(int irq, void *dev_id)
+static void altr_edac_a10_irq_handler(struct irq_desc *desc)
 {
-	irqreturn_t rc = IRQ_NONE;
-	struct altr_arria10_edac *edac = dev_id;
-	struct altr_edac_device_dev *dci;
-	int irq_status;
-	bool sberr = (irq == edac->sb_irq) ? 1 : 0;
-	int sm_offset = sberr ? A10_SYSMGR_ECC_INTSTAT_SERR_OFST :
-				A10_SYSMGR_ECC_INTSTAT_DERR_OFST;
+	int dberr, bit, sm_offset, irq_status;
+	struct altr_arria10_edac *edac = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	int irq = irq_desc_get_irq(desc);
+
+	chained_irq_enter(chip, desc);
+	dberr = (irq == edac->db_irq) ? 1 : 0;
+	sm_offset = dberr ? A10_SYSMGR_ECC_INTSTAT_DERR_OFST :
+			    A10_SYSMGR_ECC_INTSTAT_SERR_OFST;
 
 	regmap_read(edac->ecc_mgr_map, sm_offset, &irq_status);
 
-	if ((irq != edac->sb_irq) && (irq != edac->db_irq)) {
-		WARN_ON(1);
-	} else {
-		list_for_each_entry(dci, &edac->a10_ecc_devices, next) {
-			if (irq_status & dci->data->irq_status_mask)
-				rc = dci->data->ecc_irq_handler(dci, sberr);
-		}
+	for_each_set_bit(bit, (unsigned long *)&irq_status, 32) {
+		irq = irq_linear_revmap(edac->domain, dberr * 32 + bit);
+		if (irq)
+			generic_handle_irq(irq);
 	}
 
-	return rc;
+	chained_irq_exit(chip, desc);
 }
 
 static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
@@ -1168,6 +1180,34 @@ static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 			goto err_release_group1;
 	}
 
+	altdev->sb_irq = irq_of_parse_and_map(np, 0);
+	if (!altdev->sb_irq) {
+		edac_printk(KERN_ERR, EDAC_DEVICE, "Error allocating SBIRQ\n");
+		rc = -ENODEV;
+		goto err_release_group1;
+	}
+	rc = devm_request_irq(edac->dev, altdev->sb_irq,
+			      prv->ecc_irq_handler,
+			      IRQF_SHARED, ecc_name, altdev);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_DEVICE, "No DBERR IRQ resource\n");
+		goto err_release_group1;
+	}
+
+	altdev->db_irq = irq_of_parse_and_map(np, 1);
+	if (!altdev->db_irq) {
+		edac_printk(KERN_ERR, EDAC_DEVICE, "Error allocating DBIRQ\n");
+		rc = -ENODEV;
+		goto err_release_group1;
+	}
+	rc = devm_request_irq(edac->dev, altdev->db_irq,
+			      prv->ecc_irq_handler,
+			      IRQF_SHARED, ecc_name, altdev);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_DEVICE, "No DBERR IRQ resource\n");
+		goto err_release_group1;
+	}
+
 	rc = edac_device_add_device(dci);
 	if (rc) {
 		dev_err(edac->dev, "edac_device_add_device failed\n");
@@ -1186,7 +1226,6 @@ static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 err_release_group1:
 	edac_device_free_ctl_info(dci);
 err_release_group:
-	edac_printk(KERN_ALERT, EDAC_DEVICE, "%s: %d\n", __func__, __LINE__);
 	devres_release_group(edac->dev, NULL);
 	edac_printk(KERN_ERR, EDAC_DEVICE,
 		    "%s:Error setting up EDAC device: %d\n", ecc_name, rc);
@@ -1194,11 +1233,43 @@ err_release_group:
 	return rc;
 }
 
+static void a10_eccmgr_irq_mask(struct irq_data *d)
+{
+	struct altr_arria10_edac *edac = irq_data_get_irq_chip_data(d);
+
+	regmap_write(edac->ecc_mgr_map,	A10_SYSMGR_ECC_INTMASK_SET_OFST,
+		     BIT(d->hwirq));
+}
+
+static void a10_eccmgr_irq_unmask(struct irq_data *d)
+{
+	struct altr_arria10_edac *edac = irq_data_get_irq_chip_data(d);
+
+	regmap_write(edac->ecc_mgr_map,	A10_SYSMGR_ECC_INTMASK_CLR_OFST,
+		     BIT(d->hwirq));
+}
+
+static int a10_eccmgr_irqdomain_map(struct irq_domain *d, unsigned int irq,
+				    irq_hw_number_t hwirq)
+{
+	struct altr_arria10_edac *edac = d->host_data;
+
+	irq_set_chip_and_handler(irq, &edac->irq_chip, handle_simple_irq);
+	irq_set_chip_data(irq, edac);
+	irq_set_noprobe(irq);
+
+	return 0;
+}
+
+struct irq_domain_ops a10_eccmgr_ic_ops = {
+	.map = a10_eccmgr_irqdomain_map,
+	.xlate = irq_domain_xlate_twocell,
+};
+
 static int altr_edac_a10_probe(struct platform_device *pdev)
 {
 	struct altr_arria10_edac *edac;
 	struct device_node *child;
-	int rc;
 
 	edac = devm_kzalloc(&pdev->dev, sizeof(*edac), GFP_KERNEL);
 	if (!edac)
@@ -1216,23 +1287,34 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 		return PTR_ERR(edac->ecc_mgr_map);
 	}
 
+	edac->irq_chip.name = pdev->dev.of_node->name;
+	edac->irq_chip.irq_mask = a10_eccmgr_irq_mask;
+	edac->irq_chip.irq_unmask = a10_eccmgr_irq_unmask;
+	edac->domain = irq_domain_add_linear(pdev->dev.of_node, 64,
+					     &a10_eccmgr_ic_ops, edac);
+	if (!edac->domain) {
+		dev_err(&pdev->dev, "Error adding IRQ domain\n");
+		return -ENOMEM;
+	}
+
 	edac->sb_irq = platform_get_irq(pdev, 0);
-	rc = devm_request_irq(&pdev->dev, edac->sb_irq,
-			      altr_edac_a10_irq_handler,
-			      IRQF_SHARED, dev_name(&pdev->dev), edac);
-	if (rc) {
-		edac_printk(KERN_ERR, EDAC_DEVICE, "No SBERR IRQ resource\n");
-		return rc;
+	if (edac->sb_irq < 0) {
+		dev_err(&pdev->dev, "No SBERR IRQ resource\n");
+		return edac->sb_irq;
 	}
 
+	irq_set_chained_handler_and_data(edac->sb_irq,
+					 altr_edac_a10_irq_handler,
+					 edac);
+
 	edac->db_irq = platform_get_irq(pdev, 1);
-	rc = devm_request_irq(&pdev->dev, edac->db_irq,
-			      altr_edac_a10_irq_handler,
-			      IRQF_SHARED, dev_name(&pdev->dev), edac);
-	if (rc) {
-		edac_printk(KERN_ERR, EDAC_DEVICE, "No DBERR IRQ resource\n");
-		return rc;
+	if (edac->db_irq < 0) {
+		dev_err(&pdev->dev, "No DBERR IRQ resource\n");
+		return edac->db_irq;
 	}
+	irq_set_chained_handler_and_data(edac->db_irq,
+					 altr_edac_a10_irq_handler,
+					 edac);
 
 	for_each_child_of_node(pdev->dev.of_node, child) {
 		if (!of_device_is_available(child))
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 42090f3..62b0fa0 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -295,8 +295,7 @@ struct edac_device_prv_data {
 	int ce_set_mask;
 	int ue_set_mask;
 	int set_err_ofst;
-	irqreturn_t (*ecc_irq_handler)(struct altr_edac_device_dev *dci,
-				       bool sb);
+	irqreturn_t (*ecc_irq_handler)(int irq, void *dev_id);
 	int trig_alloc_sz;
 	const struct file_operations *inject_fops;
 };
@@ -320,6 +319,8 @@ struct altr_arria10_edac {
 	struct regmap		*ecc_mgr_map;
 	int sb_irq;
 	int db_irq;
+	struct irq_domain	*domain;
+	struct irq_chip		irq_chip;
 	struct list_head	a10_ecc_devices;
 };
 
-- 
1.7.9.5
