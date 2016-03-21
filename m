From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Mon, 21 Mar 2016 11:01:42 -0500
Subject: [PATCHv3 5/9] EDAC, altera: Add register offset for ECC Error Inject
In-Reply-To: <1458576106-24505-1-git-send-email-tthayer@opensource.altera.com>
References: <1458576106-24505-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1458576106-24505-6-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

In preparation for the Arria10 peripheral ECCs, a register
offset from the ECC base was added to the private data
structure to index to the error injection register.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2: Split large patch into smaller patches. Add an ECC
    error inject offset to support the different register
    layout of Arria10 peripheral ECCs.
v3: Addition of offset defines (previously in ECC Enable
    patch that was dropped).
---
 drivers/edac/altera_edac.c |    7 +++++--
 drivers/edac/altera_edac.h |    3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 0dbfa47..502bf1f 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -622,8 +622,9 @@ static ssize_t altr_edac_device_trig(struct file *file,
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
@@ -879,6 +880,7 @@ const struct edac_device_prv_data ocramecc_data = {
 	.ecc_enable_mask = ALTR_OCR_ECC_EN,
 	.ce_set_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_INJS),
 	.ue_set_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_INJD),
+	.set_err_ofst = ALTR_OCR_ECC_REG_OFFSET,
 	.trig_alloc_sz = ALTR_TRIG_OCRAM_BYTE_SIZE,
 };
 
@@ -949,6 +951,7 @@ const struct edac_device_prv_data l2ecc_data = {
 	.ecc_enable_mask = ALTR_L2_ECC_EN,
 	.ce_set_mask = (ALTR_L2_ECC_EN | ALTR_L2_ECC_INJS),
 	.ue_set_mask = (ALTR_L2_ECC_EN | ALTR_L2_ECC_INJD),
+	.set_err_ofst = ALTR_L2_ECC_REG_OFFSET,
 	.trig_alloc_sz = ALTR_TRIG_L2C_BYTE_SIZE,
 };
 
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 32c798a..d7ef94c 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -205,6 +205,7 @@ struct altr_sdram_mc_data {
 /******* Cyclone5 and Arria5 Defines *******/
 /* OCRAM ECC Management Group Defines */
 #define ALTR_MAN_GRP_OCRAM_ECC_OFFSET   0x04
+#define ALTR_OCR_ECC_REG_OFFSET         0x00
 #define ALTR_OCR_ECC_EN                 BIT(0)
 #define ALTR_OCR_ECC_INJS               BIT(1)
 #define ALTR_OCR_ECC_INJD               BIT(2)
@@ -213,6 +214,7 @@ struct altr_sdram_mc_data {
 
 /* L2 ECC Management Group Defines */
 #define ALTR_MAN_GRP_L2_ECC_OFFSET      0x00
+#define ALTR_L2_ECC_REG_OFFSET          0x00
 #define ALTR_L2_ECC_EN                  BIT(0)
 #define ALTR_L2_ECC_INJS                BIT(1)
 #define ALTR_L2_ECC_INJD                BIT(2)
@@ -229,6 +231,7 @@ struct edac_device_prv_data {
 	int ecc_enable_mask;
 	int ce_set_mask;
 	int ue_set_mask;
+	int set_err_ofst;
 	int trig_alloc_sz;
 };
 
-- 
1.7.9.5
