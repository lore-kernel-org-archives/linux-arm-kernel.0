From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Mon, 7 Mar 2016 13:43:00 -0600
Subject: [PATCHv2 04/11] EDAC, altera: Add register offset for ECC Error Inject
In-Reply-To: <1457379787-8327-1-git-send-email-tthayer@opensource.altera.com>
References: <1457379787-8327-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1457379787-8327-5-git-send-email-tthayer@opensource.altera.com>
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
---
 drivers/edac/altera_edac.c |    7 +++++--
 drivers/edac/altera_edac.h |    1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 138446c..9e62a49 100644
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
@@ -881,6 +882,7 @@ const struct edac_device_prv_data ocramecc_data = {
 	.ecc_en_ofst = ALTR_OCR_ECC_REG_OFFSET,
 	.ce_set_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_INJS),
 	.ue_set_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_INJD),
+	.set_err_ofst = ALTR_OCR_ECC_REG_OFFSET,
 	.trig_alloc_sz = ALTR_TRIG_OCRAM_BYTE_SIZE,
 };
 
@@ -954,6 +956,7 @@ const struct edac_device_prv_data l2ecc_data = {
 	.ecc_en_ofst = ALTR_L2_ECC_REG_OFFSET,
 	.ce_set_mask = (ALTR_L2_ECC_EN | ALTR_L2_ECC_INJS),
 	.ue_set_mask = (ALTR_L2_ECC_EN | ALTR_L2_ECC_INJD),
+	.set_err_ofst = ALTR_L2_ECC_REG_OFFSET,
 	.trig_alloc_sz = ALTR_TRIG_L2C_BYTE_SIZE,
 };
 
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 54e2742..d4105b0 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -232,6 +232,7 @@ struct edac_device_prv_data {
 	int ecc_en_ofst;
 	int ce_set_mask;
 	int ue_set_mask;
+	int set_err_ofst;
 	int trig_alloc_sz;
 };
 
-- 
1.7.9.5
