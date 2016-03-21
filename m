From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Mon, 21 Mar 2016 11:01:39 -0500
Subject: [PATCHv3 2/9] EDAC,
 altera: Move Device structs and defines to header file
In-Reply-To: <1458576106-24505-1-git-send-email-tthayer@opensource.altera.com>
References: <1458576106-24505-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1458576106-24505-3-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Move the device structs and defines to altera_edac.h in preparation
for adding the Arria10 L2 cache ECC.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2: Split original patch into smaller patches. Move private data
    and defines into header file.
v3: Commented description above defines.
---
 drivers/edac/altera_edac.c |   43 -------------------------------------------
 drivers/edac/altera_edac.h |   44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 63e4209..eee7a39 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -78,27 +78,6 @@ static const struct altr_sdram_prv_data a10_data = {
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
-
 /*********************** EDAC Memory Controller Functions ****************/
 
 /* The SDRAM controller uses the EDAC Memory Controller framework.       */
@@ -571,28 +550,6 @@ module_platform_driver(altr_edac_driver);
 const struct edac_device_prv_data ocramecc_data;
 const struct edac_device_prv_data l2ecc_data;
 
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
-
 static irqreturn_t altr_edac_device_handler(int irq, void *dev_id)
 {
 	irqreturn_t ret_value = IRQ_NONE;
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 953077d..993bb0a 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -195,4 +195,48 @@ struct altr_sdram_mc_data {
 	const struct altr_sdram_prv_data *data;
 };
 
+/************************** EDAC Device Defines **************************/
+/***** General Device Trigger Defines *****/
+#define ALTR_UE_TRIGGER_CHAR            'U'   /* Trigger for UE */
+#define ALTR_TRIGGER_READ_WRD_CNT       32    /* Line size x 4 */
+#define ALTR_TRIG_OCRAM_BYTE_SIZE       128   /* Line size x 4 */
+#define ALTR_TRIG_L2C_BYTE_SIZE         4096  /* Full Page */
+
+/******* Cyclone5 and Arria5 Defines *******/
+/* OCRAM ECC Management Group Defines */
+#define ALTR_MAN_GRP_OCRAM_ECC_OFFSET   0x04
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
+struct edac_device_prv_data {
+	int (*setup)(struct platform_device *pdev, void __iomem *base);
+	int ce_clear_mask;
+	int ue_clear_mask;
+	char dbgfs_name[20];
+	void * (*alloc_mem)(size_t size, void **other);
+	void (*free_mem)(void *p, size_t size, void *other);
+	int ecc_enable_mask;
+	int ce_set_mask;
+	int ue_set_mask;
+	int trig_alloc_sz;
+};
+
+struct altr_edac_device_dev {
+	void __iomem *base;
+	int sb_irq;
+	int db_irq;
+	const struct edac_device_prv_data *data;
+	struct dentry *debugfs_dir;
+	char *edac_dev_name;
+};
+
 #endif	/* #ifndef _ALTERA_EDAC_H */
-- 
1.7.9.5
