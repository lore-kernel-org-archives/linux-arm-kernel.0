From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Mon, 13 Jun 2016 16:19:08 -0500
Subject: [PATCHv3 3/7] EDAC, altera: Share Arria10 check_deps & IRQ functions
In-Reply-To: <1465852752-11018-1-git-send-email-tthayer@opensource.altera.com>
References: <1465852752-11018-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1465852752-11018-4-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

In preparation for additional memory module ECCs, the IRQ and
check_deps() functions are being made available to all the memory
buffers. Move them outside of the OCRAM only area.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2  New patch. Move shared functions outside OCRAM only area.
v3  Change title line - check_deps & IRQ.
---
 drivers/edac/altera_edac.c |   62 ++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index a9d8fa7..a3f490d 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -825,9 +825,9 @@ static struct platform_driver altr_edac_device_driver = {
 };
 module_platform_driver(altr_edac_device_driver);
 
-/*********************** OCRAM EDAC Device Functions *********************/
+/******************* Arria10 Device ECC Shared Functions *****************/
 
-#ifdef CONFIG_EDAC_ALTERA_OCRAM
+#if defined(CONFIG_EDAC_ALTERA_OCRAM) || defined(CONFIG_EDAC_ALTERA_ETHERNET)
 /*
  *  Test for memory's ECC dependencies upon entry because platform specific
  *  startup should have initialized the memory and enabled the ECC.
@@ -848,6 +848,38 @@ static int altr_check_ecc_deps(struct altr_edac_device_dev *device)
 	return -ENODEV;
 }
 
+static irqreturn_t altr_edac_a10_ecc_irq(int irq, void *dev_id)
+{
+	struct altr_edac_device_dev *dci = dev_id;
+	void __iomem  *base = dci->base;
+
+	if (irq == dci->sb_irq) {
+		writel(ALTR_A10_ECC_SERRPENA,
+		       base + ALTR_A10_ECC_INTSTAT_OFST);
+		edac_device_handle_ce(dci->edac_dev, 0, 0, dci->edac_dev_name);
+
+		return IRQ_HANDLED;
+	} else if (irq == dci->db_irq) {
+		writel(ALTR_A10_ECC_DERRPENA,
+		       base + ALTR_A10_ECC_INTSTAT_OFST);
+		edac_device_handle_ue(dci->edac_dev, 0, 0, dci->edac_dev_name);
+		if (dci->data->panic)
+			panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
+
+		return IRQ_HANDLED;
+	}
+
+	WARN_ON(1);
+
+	return IRQ_NONE;
+}
+
+#endif /* CONFIG_EDAC_ALTERA_OCRAM || CONFIG_EDAC_ALTERA_ETHERNET */
+
+/*********************** OCRAM EDAC Device Functions *********************/
+
+#ifdef CONFIG_EDAC_ALTERA_OCRAM
+
 static void *ocram_alloc_mem(size_t size, void **other)
 {
 	struct device_node *np;
@@ -882,32 +914,6 @@ static void ocram_free_mem(void *p, size_t size, void *other)
 	gen_pool_free((struct gen_pool *)other, (u32)p, size);
 }
 
-static irqreturn_t altr_edac_a10_ecc_irq(int irq, void *dev_id)
-{
-	struct altr_edac_device_dev *dci = dev_id;
-	void __iomem  *base = dci->base;
-
-	if (irq == dci->sb_irq) {
-		writel(ALTR_A10_ECC_SERRPENA,
-		       base + ALTR_A10_ECC_INTSTAT_OFST);
-		edac_device_handle_ce(dci->edac_dev, 0, 0, dci->edac_dev_name);
-
-		return IRQ_HANDLED;
-	} else if (irq == dci->db_irq) {
-		writel(ALTR_A10_ECC_DERRPENA,
-		       base + ALTR_A10_ECC_INTSTAT_OFST);
-		edac_device_handle_ue(dci->edac_dev, 0, 0, dci->edac_dev_name);
-		if (dci->data->panic)
-			panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
-
-		return IRQ_HANDLED;
-	}
-
-	WARN_ON(1);
-
-	return IRQ_NONE;
-}
-
 const struct edac_device_prv_data ocramecc_data = {
 	.setup = altr_check_ecc_deps,
 	.ce_clear_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_SERR),
-- 
1.7.9.5
