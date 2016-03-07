From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Mon, 7 Mar 2016 13:43:05 -0600
Subject: [PATCHv2 09/11] EDAC, altera: Addition of Arria10 L2 Cache ECC
In-Reply-To: <1457379787-8327-1-git-send-email-tthayer@opensource.altera.com>
References: <1457379787-8327-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1457379787-8327-10-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Addition of the Arria10 L2 Cache ECC handling. Addition
of private data structure for Arria10 L2 cache ECC and
the initialization function for it.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2: Split large patch into smaller patches. Addition of
    Arria10 L2 cache dependency check and private data.
---
 drivers/edac/altera_edac.c |   57 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/edac/altera_edac.h |   21 +++++++++++++++-
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 11b7291..8afdf8b 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -549,6 +549,7 @@ module_platform_driver(altr_edac_driver);
 
 const struct edac_device_prv_data ocramecc_data;
 const struct edac_device_prv_data l2ecc_data;
+const struct edac_device_prv_data a10_l2ecc_data;
 
 static irqreturn_t altr_edac_device_handler(int irq, void *dev_id)
 {
@@ -687,6 +688,8 @@ static void altr_create_edacdev_dbgfs(struct edac_device_ctl_info *edac_dci,
 static const struct of_device_id altr_edac_device_of_match[] = {
 #ifdef CONFIG_EDAC_ALTERA_L2C
 	{ .compatible = "altr,socfpga-l2-ecc", .data = (void *)&l2ecc_data },
+	{ .compatible = "altr,socfpga-a10-l2-ecc",
+	  .data = (void *)&a10_l2ecc_data },
 #endif
 #ifdef CONFIG_EDAC_ALTERA_OCRAM
 	{ .compatible = "altr,socfpga-ocram-ecc",
@@ -970,6 +973,40 @@ static int altr_l2_check_deps(struct platform_device *pdev,
 	return -ENODEV;
 }
 
+static int altr_a10_l2_check_deps(struct platform_device *pdev,
+				  struct altr_edac_device_dev *drvdata)
+{
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
+}
+
 const struct edac_device_prv_data l2ecc_data = {
 	.setup = altr_l2_check_deps,
 	.ce_clear_mask = 0,
@@ -991,6 +1028,26 @@ const struct edac_device_prv_data l2ecc_data = {
 	.irq_flags = 0,
 };
 
+const struct edac_device_prv_data a10_l2ecc_data = {
+	.setup = altr_a10_l2_check_deps,
+	.ce_clear_mask = ALTR_A10_L2_ECC_SERR_CLR,
+	.ue_clear_mask = ALTR_A10_L2_ECC_MERR_CLR,
+	.clear_err_ofst = ALTR_A10_L2_ECC_CLR_OFST,
+	.ce_status_mask = ALTR_A10_L2_ECC_SERR_PEND,
+	.ue_status_mask = ALTR_A10_L2_ECC_MERR_PEND,
+	.err_status_ofst = ALTR_A10_L2_ECC_STAT_OFST,
+	.dbgfs_name = "altr_l2_trigger",
+	.alloc_mem = l2_alloc_mem,
+	.free_mem = l2_free_mem,
+	.ecc_enable_mask = ALTR_A10_L2_ECC_EN_CTL,
+	.ecc_en_ofst = ALTR_A10_L2_ECC_CTL_OFST,
+	.ce_set_mask = ALTR_A10_L2_ECC_CE_INJ_MASK,
+	.ue_set_mask = ALTR_A10_L2_ECC_UE_INJ_MASK,
+	.set_err_ofst = ALTR_A10_L2_ECC_INJ_OFST,
+	.trig_alloc_sz = ALTR_TRIG_L2C_BYTE_SIZE,
+	.irq_flags = IRQF_SHARED,
+};
+
 #endif	/* CONFIG_EDAC_ALTERA_L2C */
 
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 43e0dae..a9177c8 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -196,12 +196,13 @@ struct altr_sdram_mc_data {
 };
 
 /************************** EDAC Device Defines **************************/
-
+/***** General Device Trigger Defines *****/
 #define ALTR_UE_TRIGGER_CHAR            'U'   /* Trigger for UE */
 #define ALTR_TRIGGER_READ_WRD_CNT       32    /* Line size x 4 */
 #define ALTR_TRIG_OCRAM_BYTE_SIZE       128   /* Line size x 4 */
 #define ALTR_TRIG_L2C_BYTE_SIZE         4096  /* Full Page */
 
+/******* Cyclone5 and Arria5 Defines *******/
 /* OCRAM ECC Management Group Defines */
 #define ALTR_MAN_GRP_OCRAM_ECC_OFFSET   0x04
 #define ALTR_OCR_ECC_REG_OFFSET         0x00
@@ -218,6 +219,24 @@ struct altr_sdram_mc_data {
 #define ALTR_L2_ECC_INJS                BIT(1)
 #define ALTR_L2_ECC_INJD                BIT(2)
 
+/************* Arria10 Defines *************/
+/* Arria 10 L2 ECC Management Group Defines */
+#define ALTR_A10_L2_ECC_CTL_OFST        0x0
+#define ALTR_A10_L2_ECC_EN_CTL          BIT(0)
+
+#define ALTR_A10_L2_ECC_STATUS          0xFFD060A4
+#define ALTR_A10_L2_ECC_STAT_OFST       0x0
+#define ALTR_A10_L2_ECC_SERR_PEND       BIT(15)
+#define ALTR_A10_L2_ECC_MERR_PEND       BIT(31)
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
-- 
1.7.9.5
