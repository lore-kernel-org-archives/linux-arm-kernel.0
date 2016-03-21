From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Mon, 21 Mar 2016 11:01:44 -0500
Subject: [PATCHv3 7/9] EDAC, altera: Addition of Arria10 L2 Cache ECC
In-Reply-To: <1458576106-24505-1-git-send-email-tthayer@opensource.altera.com>
References: <1458576106-24505-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1458576106-24505-8-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Addition of the Arria10 L2 Cache ECC handling. Addition
of private data structure for Arria10 L2 cache ECC and
the probe function for it.
The Arria10 ECC device IRQs are in a shared register so
the ECC Manager parent/child relationship requires a
different probe function.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2: Split large patch into smaller patches. Addition of
    Arria10 L2 cache dependency check and private data.
v3: Use new probe function to maintain parental/child
    relationship for shared IRQ in ECC manager and
    individual ECC module probes.
---
 drivers/edac/altera_edac.c |  231 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/edac/altera_edac.h |   42 ++++++++
 2 files changed, 273 insertions(+)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 502bf1f..0afdc58 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
+#include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -549,6 +550,7 @@ module_platform_driver(altr_edac_driver);
 
 const struct edac_device_prv_data ocramecc_data;
 const struct edac_device_prv_data l2ecc_data;
+const struct edac_device_prv_data a10_l2ecc_data;
 
 static irqreturn_t altr_edac_device_handler(int irq, void *dev_id)
 {
@@ -673,6 +675,8 @@ static void altr_create_edacdev_dbgfs(struct edac_device_ctl_info *edac_dci,
 static const struct of_device_id altr_edac_device_of_match[] = {
 #ifdef CONFIG_EDAC_ALTERA_L2C
 	{ .compatible = "altr,socfpga-l2-ecc", .data = (void *)&l2ecc_data },
+	{ .compatible = "altr,socfpga-a10-l2-ecc",
+	  .data = (void *)&a10_l2ecc_data },
 #endif
 #ifdef CONFIG_EDAC_ALTERA_OCRAM
 	{ .compatible = "altr,socfpga-ocram-ecc",
@@ -941,6 +945,24 @@ static int altr_l2_check_deps(struct altr_edac_device_dev *device)
 	return -ENODEV;
 }
 
+static irqreturn_t altr_edac_a10_l2_irq(struct altr_edac_device_dev *dci,
+					bool sberr)
+{
+	if (sberr) {
+		regmap_write(dci->edac->ecc_mgr_map,
+			     A10_SYSGMR_MPU_CLEAR_L2_ECC_OFST,
+			     A10_SYSGMR_MPU_CLEAR_L2_ECC_SB);
+		edac_device_handle_ce(dci->edac_dev, 0, 0, dci->edac_dev_name);
+	} else {
+		regmap_write(dci->edac->ecc_mgr_map,
+			     A10_SYSGMR_MPU_CLEAR_L2_ECC_OFST,
+			     A10_SYSGMR_MPU_CLEAR_L2_ECC_MB);
+		edac_device_handle_ue(dci->edac_dev, 0, 0, dci->edac_dev_name);
+		panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
+	}
+	return IRQ_HANDLED;
+}
+
 const struct edac_device_prv_data l2ecc_data = {
 	.setup = altr_l2_check_deps,
 	.ce_clear_mask = 0,
@@ -955,8 +977,217 @@ const struct edac_device_prv_data l2ecc_data = {
 	.trig_alloc_sz = ALTR_TRIG_L2C_BYTE_SIZE,
 };
 
+const struct edac_device_prv_data a10_l2ecc_data = {
+	.setup = altr_l2_check_deps,
+	.ce_clear_mask = ALTR_A10_L2_ECC_SERR_CLR,
+	.ue_clear_mask = ALTR_A10_L2_ECC_MERR_CLR,
+	.irq_status_mask = A10_SYSMGR_ECC_INTSTAT_L2,
+	.dbgfs_name = "altr_l2_trigger",
+	.alloc_mem = l2_alloc_mem,
+	.free_mem = l2_free_mem,
+	.ecc_enable_mask = ALTR_A10_L2_ECC_EN_CTL,
+	.ce_set_mask = ALTR_A10_L2_ECC_CE_INJ_MASK,
+	.ue_set_mask = ALTR_A10_L2_ECC_UE_INJ_MASK,
+	.set_err_ofst = ALTR_A10_L2_ECC_INJ_OFST,
+	.ecc_irq_handler = altr_edac_a10_l2_irq,
+	.trig_alloc_sz = ALTR_TRIG_L2C_BYTE_SIZE,
+};
+
 #endif	/* CONFIG_EDAC_ALTERA_L2C */
 
+/********************* Arria10 EDAC Device Functions *************************/
+
+/*
+ * The Arria10 EDAC Device Functions differ from the Cyclone5/Arria5
+ * because 2 IRQs are shared among the all ECC peripherals. The ECC
+ * manager manages the IRQs and the children.
+ * Based on xgene_edac.c peripheral code.
+ */
+
+static irqreturn_t altr_edac_a10_irq_handler(int irq, void *dev_id)
+{
+	irqreturn_t rc = IRQ_NONE;
+	struct altr_arria10_edac *edac = dev_id;
+	struct altr_edac_device_dev *dci;
+	int irq_status;
+	bool sberr = (irq == edac->sb_irq) ? 1 : 0;
+	int sm_offset = sberr ? A10_SYSMGR_ECC_INTSTAT_SERR_OFST :
+				A10_SYSMGR_ECC_INTSTAT_DERR_OFST;
+
+	regmap_read(edac->ecc_mgr_map, sm_offset, &irq_status);
+
+	if ((irq != edac->sb_irq) && (irq != edac->db_irq)) {
+		WARN_ON(1);
+	} else {
+		list_for_each_entry(dci, &edac->a10_ecc_devices, next) {
+			if (irq_status & dci->data->irq_status_mask)
+				rc = dci->data->ecc_irq_handler(dci, sberr);
+		}
+	}
+
+	return rc;
+}
+
+static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
+				    struct device_node *np)
+{
+	struct edac_device_ctl_info *dci;
+	struct altr_edac_device_dev *altdev;
+	char *ecc_name = (char *)np->name;
+	struct resource res;
+	int edac_idx;
+	int rc = 0;
+	const struct edac_device_prv_data *prv;
+	/* Get matching node and check for valid result */
+	const struct of_device_id *pdev_id =
+		of_match_node(altr_edac_device_of_match, np);
+	if (IS_ERR_OR_NULL(pdev_id))
+		return -ENODEV;
+
+	/* Get driver specific data for this EDAC device */
+	prv = pdev_id->data;
+	if (IS_ERR_OR_NULL(prv))
+		return -ENODEV;
+
+	if (!devres_open_group(edac->dev, altr_edac_a10_device_add, GFP_KERNEL))
+		return -ENOMEM;
+
+	rc = of_address_to_resource(np, 0, &res);
+	if (rc < 0) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "%s: no resource address\n", ecc_name);
+		goto err_release_group;
+	}
+
+	edac_idx = edac_device_alloc_index();
+	dci = edac_device_alloc_ctl_info(sizeof(*altdev), ecc_name,
+					 1, ecc_name, 1, 0, NULL, 0,
+					 edac_idx);
+
+	if (!dci) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "%s: Unable to allocate EDAC device\n", ecc_name);
+		rc = -ENOMEM;
+		goto err_release_group;
+	}
+
+	altdev = dci->pvt_info;
+	dci->dev = edac->dev;
+	altdev->edac_dev_name = ecc_name;
+	altdev->edac_idx = edac_idx;
+	altdev->edac = edac;
+	altdev->edac_dev = dci;
+	altdev->data = prv;
+	altdev->ddev = *edac->dev;
+	dci->dev = &altdev->ddev;
+	dci->ctl_name = "Altera ECC Manager";
+	dci->mod_name = ecc_name;
+	dci->dev_name = ecc_name;
+
+	altdev->base = devm_ioremap_resource(edac->dev, &res);
+	if (IS_ERR(altdev->base)) {
+		rc = PTR_ERR(altdev->base);
+		goto err_release_group1;
+	}
+
+	/* Check specific dependencies for the module */
+	if (altdev->data->setup) {
+		rc = altdev->data->setup(altdev);
+		if (rc)
+			goto err_release_group1;
+	}
+
+	rc = edac_device_add_device(dci);
+	if (rc) {
+		dev_err(edac->dev, "edac_device_add_device failed\n");
+		rc = -ENOMEM;
+		goto err_release_group1;
+	}
+
+	altr_create_edacdev_dbgfs(dci, prv);
+
+	list_add(&altdev->next, &edac->a10_ecc_devices);
+
+	devres_remove_group(edac->dev, altr_edac_a10_device_add);
+
+	return 0;
+
+err_release_group1:
+	edac_device_free_ctl_info(dci);
+err_release_group:
+	edac_printk(KERN_ALERT, EDAC_DEVICE, "%s: %d\n", __func__, __LINE__);
+	devres_release_group(edac->dev, NULL);
+	edac_printk(KERN_ERR, EDAC_DEVICE,
+		    "%s:Error setting up EDAC device: %d\n", ecc_name, rc);
+
+	return rc;
+}
+
+static int altr_edac_a10_probe(struct platform_device *pdev)
+{
+	struct altr_arria10_edac *edac;
+	struct device_node *child;
+	int rc;
+
+	edac = devm_kzalloc(&pdev->dev, sizeof(*edac), GFP_KERNEL);
+	if (!edac)
+		return -ENOMEM;
+
+	edac->dev = &pdev->dev;
+	platform_set_drvdata(pdev, edac);
+	INIT_LIST_HEAD(&edac->a10_ecc_devices);
+
+	edac->ecc_mgr_map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+							"altr,sysmgr-syscon");
+	if (IS_ERR(edac->ecc_mgr_map)) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "Unable to get syscon altr,sysmgr-syscon\n");
+		return PTR_ERR(edac->ecc_mgr_map);
+	}
+
+	edac->sb_irq = platform_get_irq(pdev, 0);
+	rc = devm_request_irq(&pdev->dev, edac->sb_irq,
+			      altr_edac_a10_irq_handler,
+			      IRQF_SHARED, dev_name(&pdev->dev), edac);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_DEVICE, "No SBERR IRQ resource\n");
+		return rc;
+	}
+
+	edac->db_irq = platform_get_irq(pdev, 1);
+	rc = devm_request_irq(&pdev->dev, edac->db_irq,
+			      altr_edac_a10_irq_handler,
+			      IRQF_SHARED, dev_name(&pdev->dev), edac);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_DEVICE, "No DBERR IRQ resource\n");
+		return rc;
+	}
+
+	for_each_child_of_node(pdev->dev.of_node, child) {
+		if (!of_device_is_available(child))
+			continue;
+		if (of_device_is_compatible(child, "altr,socfpga-a10-l2-ecc"))
+			altr_edac_a10_device_add(edac, child);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id altr_edac_a10_of_match[] = {
+	{ .compatible = "altr,socfpga-a10-ecc-manager" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, altr_edac_a10_of_match);
+
+static struct platform_driver altr_edac_a10_driver = {
+	.probe =  altr_edac_a10_probe,
+	.driver = {
+		.name = "socfpga_a10_ecc_manager",
+		.of_match_table = altr_edac_a10_of_match,
+	},
+};
+module_platform_driver(altr_edac_a10_driver);
+
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Thor Thayer");
 MODULE_DESCRIPTION("EDAC Driver for Altera Memories");
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index d7ef94c..b0a17d0 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -219,12 +219,39 @@ struct altr_sdram_mc_data {
 #define ALTR_L2_ECC_INJS                BIT(1)
 #define ALTR_L2_ECC_INJD                BIT(2)
 
+/* Arria10 General ECC Block Module Defines */
+#define A10_SYSMGR_ECC_INTSTAT_SERR_OFST  0x9C
+#define A10_SYSMGR_ECC_INTSTAT_DERR_OFST  0xA0
+#define A10_SYSMGR_ECC_INTSTAT_L2         BIT(0)
+
+#define A10_SYSGMR_MPU_CLEAR_L2_ECC_OFST  0xA8
+#define A10_SYSGMR_MPU_CLEAR_L2_ECC_SB    BIT(15)
+#define A10_SYSGMR_MPU_CLEAR_L2_ECC_MB    BIT(31)
+
+/* Arria 10 L2 ECC Management Group Defines */
+#define ALTR_A10_L2_ECC_CTL_OFST        0x0
+#define ALTR_A10_L2_ECC_EN_CTL          BIT(0)
+
+#define ALTR_A10_L2_ECC_STATUS          0xFFD060A4
+#define ALTR_A10_L2_ECC_STAT_OFST       0xA4
+#define ALTR_A10_L2_ECC_SERR_PEND       BIT(0)
+#define ALTR_A10_L2_ECC_MERR_PEND       BIT(0)
+
+#define ALTR_A10_L2_ECC_CLR_OFST        0x4
+#define ALTR_A10_L2_ECC_SERR_CLR        BIT(15)
+#define ALTR_A10_L2_ECC_MERR_CLR        BIT(31)
+
+#define ALTR_A10_L2_ECC_INJ_OFST        ALTR_A10_L2_ECC_CTL_OFST
+#define ALTR_A10_L2_ECC_CE_INJ_MASK     0x00000101
+#define ALTR_A10_L2_ECC_UE_INJ_MASK     0x00010101
+
 struct altr_edac_device_dev;
 
 struct edac_device_prv_data {
 	int (*setup)(struct altr_edac_device_dev *device);
 	int ce_clear_mask;
 	int ue_clear_mask;
+	int irq_status_mask;
 	char dbgfs_name[20];
 	void * (*alloc_mem)(size_t size, void **other);
 	void (*free_mem)(void *p, size_t size, void *other);
@@ -232,16 +259,31 @@ struct edac_device_prv_data {
 	int ce_set_mask;
 	int ue_set_mask;
 	int set_err_ofst;
+	irqreturn_t (*ecc_irq_handler)(struct altr_edac_device_dev *dci,
+				       bool sb);
 	int trig_alloc_sz;
 };
 
 struct altr_edac_device_dev {
+	struct list_head next;
 	void __iomem *base;
 	int sb_irq;
 	int db_irq;
 	const struct edac_device_prv_data *data;
 	struct dentry *debugfs_dir;
 	char *edac_dev_name;
+	struct altr_arria10_edac *edac;
+	struct edac_device_ctl_info *edac_dev;
+	struct device ddev;
+	int edac_idx;
+};
+
+struct altr_arria10_edac {
+	struct device		*dev;
+	struct regmap		*ecc_mgr_map;
+	int sb_irq;
+	int db_irq;
+	struct list_head	a10_ecc_devices;
 };
 
 #endif	/* #ifndef _ALTERA_EDAC_H */
-- 
1.7.9.5
