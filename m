From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Tue, 1 Mar 2016 10:38:19 -0600
Subject: [PATCH 3/5] EDAC, altera: Addition of Arria10 L2 Cache ECC
In-Reply-To: <1456850301-22066-1-git-send-email-tthayer@opensource.altera.com>
References: <1456850301-22066-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1456850301-22066-3-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Addition of the Arria10 L2 Cache ECC handling. The major
changes affect the L2 ECC registers not being grouped
together. The Arria10 IRQ status needs to be mapped into
a different region. The mapping occurs in the L2 specific
function.
Important changes include:
1) Move private data structure definition to altera_edac.h
2) Move Cyclone5 device defines to altera_edac.h
3) Split IRQ status and ECC enable/control into separate
   memory areas.
4) Add IRQ status mapping in L2 ECC dependency checks
   function.
5) Addition of register offsets in private data structure.
6) Changes to code to use register offset define.
7) Addition of Arria10 L2 cache private data.
8) Add IRQ flags to indicate Exclusive/Shared.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 drivers/edac/altera_edac.c |  172 ++++++++++++++++++++++++++++----------------
 drivers/edac/altera_edac.h |   77 ++++++++++++++++++++
 2 files changed, 186 insertions(+), 63 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 63e4209..7fca74b 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -78,26 +78,6 @@ static const struct altr_sdram_prv_data a10_data = {
 	.ue_set_mask        = A10_DIAGINT_TDERRA_MASK,
 };
 
-/************************** EDAC Device Defines **************************/
-
-/* OCRAM ECC Management Group Defines */
-#define ALTR_MAN_GRP_OCRAM_ECC_OFFSET   0x04
-#define ALTR_OCR_ECC_EN                 BIT(0)
-#define ALTR_OCR_ECC_INJS               BIT(1)
-#define ALTR_OCR_ECC_INJD               BIT(2)
-#define ALTR_OCR_ECC_SERR               BIT(3)
-#define ALTR_OCR_ECC_DERR               BIT(4)
-
-/* L2 ECC Management Group Defines */
-#define ALTR_MAN_GRP_L2_ECC_OFFSET      0x00
-#define ALTR_L2_ECC_EN                  BIT(0)
-#define ALTR_L2_ECC_INJS                BIT(1)
-#define ALTR_L2_ECC_INJD                BIT(2)
-
-#define ALTR_UE_TRIGGER_CHAR            'U'   /* Trigger for UE */
-#define ALTR_TRIGGER_READ_WRD_CNT       32    /* Line size x 4 */
-#define ALTR_TRIG_OCRAM_BYTE_SIZE       128   /* Line size x 4 */
-#define ALTR_TRIG_L2C_BYTE_SIZE         4096  /* Full Page */
 
 /*********************** EDAC Memory Controller Functions ****************/
 
@@ -570,28 +550,7 @@ module_platform_driver(altr_edac_driver);
 
 const struct edac_device_prv_data ocramecc_data;
 const struct edac_device_prv_data l2ecc_data;
-
-struct edac_device_prv_data {
-	int (*setup)(struct platform_device *pdev, void __iomem *base);
-	int ce_clear_mask;
-	int ue_clear_mask;
-	char dbgfs_name[20];
-	void * (*alloc_mem)(size_t size, void **other);
-	void (*free_mem)(void *p, size_t size, void *other);
-	int ecc_enable_mask;
-	int ce_set_mask;
-	int ue_set_mask;
-	int trig_alloc_sz;
-};
-
-struct altr_edac_device_dev {
-	void __iomem *base;
-	int sb_irq;
-	int db_irq;
-	const struct edac_device_prv_data *data;
-	struct dentry *debugfs_dir;
-	char *edac_dev_name;
-};
+const struct edac_device_prv_data a10_l2ecc_data;
 
 static irqreturn_t altr_edac_device_handler(int irq, void *dev_id)
 {
@@ -599,18 +558,32 @@ static irqreturn_t altr_edac_device_handler(int irq, void *dev_id)
 	struct edac_device_ctl_info *dci = dev_id;
 	struct altr_edac_device_dev *drvdata = dci->pvt_info;
 	const struct edac_device_prv_data *priv = drvdata->data;
+	void __iomem *status_addr = drvdata->status + priv->err_status_ofst;
+	void __iomem *clear_addr = drvdata->status + priv->clear_err_ofst;
 
+	/*
+	 * CycloneV is directly mapped to a specific IRQ. Arria10
+	 * shares the IRQ with other ECCs so we must match first.
+	 */
 	if (irq == drvdata->sb_irq) {
-		if (priv->ce_clear_mask)
-			writel(priv->ce_clear_mask, drvdata->base);
-		edac_device_handle_ce(dci, 0, 0, drvdata->edac_dev_name);
-		ret_value = IRQ_HANDLED;
+		if (!priv->ce_status_mask ||
+		    (priv->ce_status_mask & readl(status_addr))) {
+			if (priv->ce_clear_mask)
+				writel(priv->ce_clear_mask, clear_addr);
+			edac_device_handle_ce(dci, 0, 0,
+					      drvdata->edac_dev_name);
+			ret_value = IRQ_HANDLED;
+		}
 	} else if (irq == drvdata->db_irq) {
-		if (priv->ue_clear_mask)
-			writel(priv->ue_clear_mask, drvdata->base);
-		edac_device_handle_ue(dci, 0, 0, drvdata->edac_dev_name);
-		panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
-		ret_value = IRQ_HANDLED;
+		if (!priv->ue_status_mask ||
+		    (priv->ue_status_mask & readl(status_addr))) {
+			if (priv->ue_clear_mask)
+				writel(priv->ue_clear_mask, clear_addr);
+			edac_device_handle_ue(dci, 0, 0,
+					      drvdata->edac_dev_name);
+			panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
+			ret_value = IRQ_HANDLED;
+		}
 	} else {
 		WARN_ON(1);
 	}
@@ -665,8 +638,9 @@ static ssize_t altr_edac_device_trig(struct file *file,
 		if (ACCESS_ONCE(ptemp[i]))
 			result = -1;
 		/* Toggle Error bit (it is latched), leave ECC enabled */
-		writel(error_mask, drvdata->base);
-		writel(priv->ecc_enable_mask, drvdata->base);
+		writel(error_mask, (drvdata->base + priv->set_err_ofst));
+		writel(priv->ecc_enable_mask, (drvdata->base +
+					       priv->set_err_ofst));
 		ptemp[i] = i;
 	}
 	/* Ensure it has been written out */
@@ -715,6 +689,8 @@ static void altr_create_edacdev_dbgfs(struct edac_device_ctl_info *edac_dci,
 static const struct of_device_id altr_edac_device_of_match[] = {
 #ifdef CONFIG_EDAC_ALTERA_L2C
 	{ .compatible = "altr,socfpga-l2-ecc", .data = (void *)&l2ecc_data },
+	{ .compatible = "altr,socfpga-a10-l2-ecc",
+	  .data = (void *)&a10_l2ecc_data },
 #endif
 #ifdef CONFIG_EDAC_ALTERA_OCRAM
 	{ .compatible = "altr,socfpga-ocram-ecc",
@@ -784,12 +760,15 @@ static int altr_edac_device_probe(struct platform_device *pdev)
 	if (!drvdata->base)
 		goto fail1;
 
+	/* Except for A10 L2 cache, status reg is within alloced base mem */
+	drvdata->status = drvdata->base;
+
 	/* Get driver specific data for this EDAC device */
 	drvdata->data = of_match_node(altr_edac_device_of_match, np)->data;
 
 	/* Check specific dependencies for the module */
 	if (drvdata->data->setup) {
-		res = drvdata->data->setup(pdev, drvdata->base);
+		res = drvdata->data->setup(pdev, drvdata);
 		if (res)
 			goto fail1;
 	}
@@ -797,14 +776,16 @@ static int altr_edac_device_probe(struct platform_device *pdev)
 	drvdata->sb_irq = platform_get_irq(pdev, 0);
 	res = devm_request_irq(&pdev->dev, drvdata->sb_irq,
 			       altr_edac_device_handler,
-			       0, dev_name(&pdev->dev), dci);
+			       drvdata->data->irq_flags,
+			       dev_name(&pdev->dev), dci);
 	if (res)
 		goto fail1;
 
 	drvdata->db_irq = platform_get_irq(pdev, 1);
 	res = devm_request_irq(&pdev->dev, drvdata->db_irq,
 			       altr_edac_device_handler,
-			       0, dev_name(&pdev->dev), dci);
+			       drvdata->data->irq_flags,
+			       dev_name(&pdev->dev), dci);
 	if (res)
 		goto fail1;
 
@@ -900,9 +881,12 @@ static void ocram_free_mem(void *p, size_t size, void *other)
  *	memory will cause CE/UE errors possibly causing an ABORT.
  */
 static int altr_ocram_check_deps(struct platform_device *pdev,
-				 void __iomem *base)
+				 struct altr_edac_device_dev *drvdata)
 {
-	if (readl(base) & ALTR_OCR_ECC_EN)
+	void __iomem  *base = drvdata->base;
+	const struct edac_device_prv_data *prv = drvdata->data;
+
+	if (readl(base + prv->ecc_en_ofst) & prv->ecc_enable_mask)
 		return 0;
 
 	edac_printk(KERN_ERR, EDAC_DEVICE,
@@ -914,13 +898,21 @@ const struct edac_device_prv_data ocramecc_data = {
 	.setup = altr_ocram_check_deps,
 	.ce_clear_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_SERR),
 	.ue_clear_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_DERR),
+	.clear_err_ofst = ALTR_OCR_ECC_REG_OFFSET,
+	/* Cyclone5 & Arria5 have separate IRQs so status = 0 */
+	.ce_status_mask = 0,
+	.ue_status_mask = 0,
+	.err_status_ofst = 0,
 	.dbgfs_name = "altr_ocram_trigger",
 	.alloc_mem = ocram_alloc_mem,
 	.free_mem = ocram_free_mem,
 	.ecc_enable_mask = ALTR_OCR_ECC_EN,
+	.ecc_en_ofst = ALTR_OCR_ECC_REG_OFFSET,
 	.ce_set_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_INJS),
 	.ue_set_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_INJD),
+	.set_err_ofst = ALTR_OCR_ECC_REG_OFFSET,
 	.trig_alloc_sz = ALTR_TRIG_OCRAM_BYTE_SIZE,
+	.irq_flags = 0,
 };
 
 #endif	/* CONFIG_EDAC_ALTERA_OCRAM */
@@ -967,27 +959,81 @@ static void l2_free_mem(void *p, size_t size, void *other)
  *	Note that L2 Cache Enable is forced at build time.
  */
 static int altr_l2_check_deps(struct platform_device *pdev,
-			      void __iomem *base)
+			      struct altr_edac_device_dev *drvdata)
 {
-	if (readl(base) & ALTR_L2_ECC_EN)
+	void __iomem  *status_base, *base = drvdata->base;
+	const struct edac_device_prv_data *prv = drvdata->data;
+
+	if ((readl(base + prv->ecc_en_ofst) & prv->ecc_enable_mask) !=
+	     prv->ecc_enable_mask) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "L2: No ECC present, or ECC disabled\n");
+		return -ENODEV;
+	}
+
+	if (!of_machine_is_compatible("altr,socfpga-arria10"))
 		return 0;
 
-	edac_printk(KERN_ERR, EDAC_DEVICE,
-		    "L2: No ECC present, or ECC disabled\n");
-	return -ENODEV;
+	/* A10 L2 cache status registers are not contiguous with base */
+	if (!devm_request_mem_region(&pdev->dev, ALTR_A10_L2_ECC_STATUS,
+				     2 * sizeof(u32), dev_name(&pdev->dev))) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "Unable to request mem region\n");
+		return -EBUSY;
+	}
+
+	status_base = devm_ioremap(&pdev->dev, ALTR_A10_L2_ECC_STATUS,
+				   2 * sizeof(u32));
+	if (!status_base) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "Unable to ioremap L2 status\n");
+		return -ENOMEM;
+	}
+
+	drvdata->status = status_base;
+
+	return 0;
 }
 
 const struct edac_device_prv_data l2ecc_data = {
 	.setup = altr_l2_check_deps,
 	.ce_clear_mask = 0,
 	.ue_clear_mask = 0,
+	.clear_err_ofst = ALTR_MAN_GRP_L2_ECC_OFFSET,
+	/* Cyclone5 & Arria5 have separate IRQs so status = 0 */
+	.ce_status_mask = 0,
+	.ue_status_mask = 0,
+	.err_status_ofst = 0,
 	.dbgfs_name = "altr_l2_trigger",
 	.alloc_mem = l2_alloc_mem,
 	.free_mem = l2_free_mem,
 	.ecc_enable_mask = ALTR_L2_ECC_EN,
+	.ecc_en_ofst = ALTR_MAN_GRP_L2_ECC_OFFSET,
 	.ce_set_mask = (ALTR_L2_ECC_EN | ALTR_L2_ECC_INJS),
 	.ue_set_mask = (ALTR_L2_ECC_EN | ALTR_L2_ECC_INJD),
+	.set_err_ofst = ALTR_MAN_GRP_L2_ECC_OFFSET,
+	.trig_alloc_sz = ALTR_TRIG_L2C_BYTE_SIZE,
+	.irq_flags = 0,
+};
+
+const struct edac_device_prv_data a10_l2ecc_data = {
+	.setup = altr_l2_check_deps,
+	.ce_clear_mask = ALTR_A10_L2_ECC_CE_CLR,
+	.ue_clear_mask = ALTR_A10_L2_ECC_UE_CLR,
+	.clear_err_ofst = ALTR_A10_L2_ECC_CLR_OFFSET,
+	.ce_status_mask = ALTR_A10_L2_ECC_CE_STAT,
+	.ue_status_mask = ALTR_A10_L2_ECC_UE_STAT,
+	.err_status_ofst = ALTR_A10_L2_ECC_STAT_OFFSET,
+	.dbgfs_name = "altr_l2_trigger",
+	.alloc_mem = l2_alloc_mem,
+	.free_mem = l2_free_mem,
+	.ecc_enable_mask = ALTR_A10_L2_ECC_EN_CTL,
+	.ecc_en_ofst = ALTR_A10_L2_ECC_CTL_OFFSET,
+	.ce_set_mask = ALTR_A10_L2_ECC_CE_INJ_MASK,
+	.ue_set_mask = ALTR_A10_L2_ECC_UE_INJ_MASK,
+	.set_err_ofst = ALTR_A10_L2_ECC_INJ_OFFSET,
 	.trig_alloc_sz = ALTR_TRIG_L2C_BYTE_SIZE,
+	.irq_flags = IRQF_SHARED,
 };
 
 #endif	/* CONFIG_EDAC_ALTERA_L2C */
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 953077d..a028cf9 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -195,4 +195,81 @@ struct altr_sdram_mc_data {
 	const struct altr_sdram_prv_data *data;
 };
 
+/************************** EDAC Device Defines **************************/
+struct altr_edac_device_dev;
+
+struct edac_device_prv_data {
+	int (*setup)(struct platform_device *pdev,
+		     struct altr_edac_device_dev *drvdata);
+	int ce_clear_mask;
+	int ue_clear_mask;
+	int clear_err_ofst;
+	int ce_status_mask;
+	int ue_status_mask;
+	int err_status_ofst;
+	char dbgfs_name[20];
+	void * (*alloc_mem)(size_t size, void **other);
+	void (*free_mem)(void *p, size_t size, void *other);
+	int ecc_enable_mask;
+	int ecc_en_ofst;
+	int ce_set_mask;
+	int ue_set_mask;
+	int set_err_ofst;
+	int trig_alloc_sz;
+	int irq_flags;
+};
+
+struct altr_edac_device_dev {
+	void __iomem *base;
+	void __iomem *status;
+	int sb_irq;
+	int db_irq;
+	const struct edac_device_prv_data *data;
+	struct dentry *debugfs_dir;
+	char *edac_dev_name;
+};
+
+/***** General Device Trigger Defines *****/
+/* Trigger for UE */
+#define ALTR_UE_TRIGGER_CHAR            'U'
+/* Line size x 4 */
+#define ALTR_TRIGGER_READ_WRD_CNT       32
+#define ALTR_TRIG_OCRAM_BYTE_SIZE       128
+/* Full Page */
+#define ALTR_TRIG_L2C_BYTE_SIZE         4096
+
+/******* Cyclone5 and Arria5 Defines *******/
+/* OCRAM ECC Management Group Defines */
+#define ALTR_MAN_GRP_OCRAM_ECC_OFFSET   0x04
+#define ALTR_OCR_ECC_REG_OFFSET         0x00
+#define ALTR_OCR_ECC_EN                 BIT(0)
+#define ALTR_OCR_ECC_INJS               BIT(1)
+#define ALTR_OCR_ECC_INJD               BIT(2)
+#define ALTR_OCR_ECC_SERR               BIT(3)
+#define ALTR_OCR_ECC_DERR               BIT(4)
+
+/* L2 ECC Management Group Defines */
+#define ALTR_MAN_GRP_L2_ECC_OFFSET      0x00
+#define ALTR_L2_ECC_EN                  BIT(0)
+#define ALTR_L2_ECC_INJS                BIT(1)
+#define ALTR_L2_ECC_INJD                BIT(2)
+
+/************* Arria10 Defines *************/
+/* Arria 10 L2 ECC Management Group Defines */
+#define ALTR_A10_L2_ECC_CTL_OFFSET      0x0
+#define ALTR_A10_L2_ECC_EN_CTL          BIT(0)
+
+#define ALTR_A10_L2_ECC_STATUS          0xFFD060A4
+#define ALTR_A10_L2_ECC_STAT_OFFSET     0x0
+#define ALTR_A10_L2_ECC_CE_STAT         BIT(15)
+#define ALTR_A10_L2_ECC_UE_STAT         BIT(31)
+
+#define ALTR_A10_L2_ECC_CLR_OFFSET      0x4
+#define ALTR_A10_L2_ECC_CE_CLR          BIT(15)
+#define ALTR_A10_L2_ECC_UE_CLR          BIT(31)
+
+#define ALTR_A10_L2_ECC_INJ_OFFSET      ALTR_A10_L2_ECC_CTL_OFFSET
+#define ALTR_A10_L2_ECC_CE_INJ_MASK     0x00000101
+#define ALTR_A10_L2_ECC_UE_INJ_MASK     0x00010101
+
 #endif	/* #ifndef _ALTERA_EDAC_H */
-- 
1.7.9.5
