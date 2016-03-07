From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Mon, 7 Mar 2016 13:42:59 -0600
Subject: [PATCHv2 03/11] EDAC, altera: Add register offset for ECC Enable
In-Reply-To: <1457379787-8327-1-git-send-email-tthayer@opensource.altera.com>
References: <1457379787-8327-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1457379787-8327-4-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

In preparation for the Arria10 peripheral ECCs, a register
offset from the ECC base was added to the private data
structure to index into the ECC enable register.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2: Split large patch into smaller patches. Add an ECC
    control offset to support the different register layout
    of Arria10 peripheral ECCs.
---
 drivers/edac/altera_edac.c |   20 +++++++++++++++-----
 drivers/edac/altera_edac.h |    8 +++++++-
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index eee7a39..138446c 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -746,7 +746,7 @@ static int altr_edac_device_probe(struct platform_device *pdev)
 
 	/* Check specific dependencies for the module */
 	if (drvdata->data->setup) {
-		res = drvdata->data->setup(pdev, drvdata->base);
+		res = drvdata->data->setup(pdev, drvdata);
 		if (res)
 			goto fail1;
 	}
@@ -857,9 +857,12 @@ static void ocram_free_mem(void *p, size_t size, void *other)
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
@@ -875,6 +878,7 @@ const struct edac_device_prv_data ocramecc_data = {
 	.alloc_mem = ocram_alloc_mem,
 	.free_mem = ocram_free_mem,
 	.ecc_enable_mask = ALTR_OCR_ECC_EN,
+	.ecc_en_ofst = ALTR_OCR_ECC_REG_OFFSET,
 	.ce_set_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_INJS),
 	.ue_set_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_INJD),
 	.trig_alloc_sz = ALTR_TRIG_OCRAM_BYTE_SIZE,
@@ -924,10 +928,15 @@ static void l2_free_mem(void *p, size_t size, void *other)
  *	Note that L2 Cache Enable is forced at build time.
  */
 static int altr_l2_check_deps(struct platform_device *pdev,
-			      void __iomem *base)
+			      struct altr_edac_device_dev *drvdata)
 {
-	if (readl(base) & ALTR_L2_ECC_EN)
+	void __iomem  *base = drvdata->base;
+	const struct edac_device_prv_data *prv = drvdata->data;
+
+	if ((readl(base + prv->ecc_en_ofst) & prv->ecc_enable_mask) ==
+	     prv->ecc_enable_mask) {
 		return 0;
+	}
 
 	edac_printk(KERN_ERR, EDAC_DEVICE,
 		    "L2: No ECC present, or ECC disabled\n");
@@ -942,6 +951,7 @@ const struct edac_device_prv_data l2ecc_data = {
 	.alloc_mem = l2_alloc_mem,
 	.free_mem = l2_free_mem,
 	.ecc_enable_mask = ALTR_L2_ECC_EN,
+	.ecc_en_ofst = ALTR_L2_ECC_REG_OFFSET,
 	.ce_set_mask = (ALTR_L2_ECC_EN | ALTR_L2_ECC_INJS),
 	.ue_set_mask = (ALTR_L2_ECC_EN | ALTR_L2_ECC_INJD),
 	.trig_alloc_sz = ALTR_TRIG_L2C_BYTE_SIZE,
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index e531da4..54e2742 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -204,6 +204,7 @@ struct altr_sdram_mc_data {
 
 /* OCRAM ECC Management Group Defines */
 #define ALTR_MAN_GRP_OCRAM_ECC_OFFSET   0x04
+#define ALTR_OCR_ECC_REG_OFFSET         0x00
 #define ALTR_OCR_ECC_EN                 BIT(0)
 #define ALTR_OCR_ECC_INJS               BIT(1)
 #define ALTR_OCR_ECC_INJD               BIT(2)
@@ -212,18 +213,23 @@ struct altr_sdram_mc_data {
 
 /* L2 ECC Management Group Defines */
 #define ALTR_MAN_GRP_L2_ECC_OFFSET      0x00
+#define ALTR_L2_ECC_REG_OFFSET          0x00
 #define ALTR_L2_ECC_EN                  BIT(0)
 #define ALTR_L2_ECC_INJS                BIT(1)
 #define ALTR_L2_ECC_INJD                BIT(2)
 
+struct altr_edac_device_dev;
+
 struct edac_device_prv_data {
-	int (*setup)(struct platform_device *pdev, void __iomem *base);
+	int (*setup)(struct platform_device *pdev,
+		     struct altr_edac_device_dev *drvdata);
 	int ce_clear_mask;
 	int ue_clear_mask;
 	char dbgfs_name[20];
 	void * (*alloc_mem)(size_t size, void **other);
 	void (*free_mem)(void *p, size_t size, void *other);
 	int ecc_enable_mask;
+	int ecc_en_ofst;
 	int ce_set_mask;
 	int ue_set_mask;
 	int trig_alloc_sz;
-- 
1.7.9.5
