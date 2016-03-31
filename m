From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Thu, 31 Mar 2016 13:48:02 -0500
Subject: [PATCHv2 2/7] EDAC, altera: Add register offset for ECC Enable
In-Reply-To: <1459450087-24792-1-git-send-email-tthayer@opensource.altera.com>
References: <1459450087-24792-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1459450087-24792-3-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

In preparation for the Arria10 peripheral ECCs, a register
offset from the ECC base was added to the private data
structure to index to the ECC enable register.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2: No change
---
 drivers/edac/altera_edac.c |    3 ++-
 drivers/edac/altera_edac.h |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index fb6fe56..f0a6de7 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -866,7 +866,7 @@ static int altr_ocram_check_deps(struct altr_edac_device_dev *device)
 	void __iomem  *base = device->base;
 	const struct edac_device_prv_data *prv = device->data;
 
-	if (readl(base) & prv->ecc_enable_mask)
+	if (readl(base + prv->ecc_en_ofst) & prv->ecc_enable_mask)
 		return 0;
 
 	edac_printk(KERN_ERR, EDAC_DEVICE,
@@ -882,6 +882,7 @@ const struct edac_device_prv_data ocramecc_data = {
 	.alloc_mem = ocram_alloc_mem,
 	.free_mem = ocram_free_mem,
 	.ecc_enable_mask = ALTR_OCR_ECC_EN,
+	.ecc_en_ofst = ALTR_OCR_ECC_REG_OFFSET,
 	.ce_set_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_INJS),
 	.ue_set_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_INJD),
 	.set_err_ofst = ALTR_OCR_ECC_REG_OFFSET,
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index c995388..cb6b2b9 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -256,6 +256,7 @@ struct edac_device_prv_data {
 	void * (*alloc_mem)(size_t size, void **other);
 	void (*free_mem)(void *p, size_t size, void *other);
 	int ecc_enable_mask;
+	int ecc_en_ofst;
 	int ce_set_mask;
 	int ue_set_mask;
 	int set_err_ofst;
-- 
1.7.9.5
