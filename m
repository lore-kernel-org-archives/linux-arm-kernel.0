From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Mon, 7 Mar 2016 13:43:01 -0600
Subject: [PATCHv2 05/11] EDAC, altera: Add register offset for ECC Error Clear
In-Reply-To: <1457379787-8327-1-git-send-email-tthayer@opensource.altera.com>
References: <1457379787-8327-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1457379787-8327-6-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

In preparation for the Arria10 peripheral ECCs, a register
offset from the ECC base was added to the private data
structure to index to the error clear register. Since
the Arria10 L2 cache ECC registers are not contiguous,
a status base address was added.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2: Split large patch into smaller patches. Add an ECC
    error clear offset to support the different register
    layout of Arria10 peripheral ECCs.
---
 drivers/edac/altera_edac.c |   10 ++++++++--
 drivers/edac/altera_edac.h |    2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 9e62a49..c28cd78 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -556,15 +556,16 @@ static irqreturn_t altr_edac_device_handler(int irq, void *dev_id)
 	struct edac_device_ctl_info *dci = dev_id;
 	struct altr_edac_device_dev *drvdata = dci->pvt_info;
 	const struct edac_device_prv_data *priv = drvdata->data;
+	void __iomem *clear_addr = drvdata->status + priv->clear_err_ofst;
 
 	if (irq == drvdata->sb_irq) {
 		if (priv->ce_clear_mask)
-			writel(priv->ce_clear_mask, drvdata->base);
+			writel(priv->ce_clear_mask, clear_addr);
 		edac_device_handle_ce(dci, 0, 0, drvdata->edac_dev_name);
 		ret_value = IRQ_HANDLED;
 	} else if (irq == drvdata->db_irq) {
 		if (priv->ue_clear_mask)
-			writel(priv->ue_clear_mask, drvdata->base);
+			writel(priv->ue_clear_mask, clear_addr);
 		edac_device_handle_ue(dci, 0, 0, drvdata->edac_dev_name);
 		panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
 		ret_value = IRQ_HANDLED;
@@ -742,6 +743,9 @@ static int altr_edac_device_probe(struct platform_device *pdev)
 	if (!drvdata->base)
 		goto fail1;
 
+	/* Except for A10 L2 cache, status reg is within alloced base mem */
+	drvdata->status = drvdata->base;
+
 	/* Get driver specific data for this EDAC device */
 	drvdata->data = of_match_node(altr_edac_device_of_match, np)->data;
 
@@ -875,6 +879,7 @@ const struct edac_device_prv_data ocramecc_data = {
 	.setup = altr_ocram_check_deps,
 	.ce_clear_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_SERR),
 	.ue_clear_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_DERR),
+	.clear_err_ofst = ALTR_OCR_ECC_REG_OFFSET,
 	.dbgfs_name = "altr_ocram_trigger",
 	.alloc_mem = ocram_alloc_mem,
 	.free_mem = ocram_free_mem,
@@ -949,6 +954,7 @@ const struct edac_device_prv_data l2ecc_data = {
 	.setup = altr_l2_check_deps,
 	.ce_clear_mask = 0,
 	.ue_clear_mask = 0,
+	.clear_err_ofst = ALTR_L2_ECC_REG_OFFSET,
 	.dbgfs_name = "altr_l2_trigger",
 	.alloc_mem = l2_alloc_mem,
 	.free_mem = l2_free_mem,
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index d4105b0..f15b4ad 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -225,6 +225,7 @@ struct edac_device_prv_data {
 		     struct altr_edac_device_dev *drvdata);
 	int ce_clear_mask;
 	int ue_clear_mask;
+	int clear_err_ofst;
 	char dbgfs_name[20];
 	void * (*alloc_mem)(size_t size, void **other);
 	void (*free_mem)(void *p, size_t size, void *other);
@@ -238,6 +239,7 @@ struct edac_device_prv_data {
 
 struct altr_edac_device_dev {
 	void __iomem *base;
+	void __iomem *status;
 	int sb_irq;
 	int db_irq;
 	const struct edac_device_prv_data *data;
-- 
1.7.9.5
