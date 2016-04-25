From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Mon, 25 Apr 2016 12:52:44 -0500
Subject: [PATCHv2 3/7] EDAC, altera: Move Arria10 IRQ function
In-Reply-To: <1461606768-14404-1-git-send-email-tthayer@opensource.altera.com>
References: <1461606768-14404-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1461606768-14404-4-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

In preparation for additional memory module ECCs, the IRQ and
check_deps() functions are being made available to all the
memory buffers. Move it outside of the OCRAM only area.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2  New patch. Move shared functions outside OCRAM only area.
---
 drivers/edac/altera_edac.c |   48 +++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index d4afecc..dc09627 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -825,9 +825,9 @@ static struct platform_driver altr_edac_device_driver = {
 };
 module_platform_driver(altr_edac_device_driver);
 
-/*********************** OCRAM EDAC Device Functions *********************/
+/*********************** Arria10 Shared ECC Functions ********************/
 
-#ifdef CONFIG_EDAC_ALTERA_OCRAM
+#if defined(CONFIG_EDAC_ALTERA_OCRAM) || defined(CONFIG_EDAC_ALTERA_ETHERNET)
 /*
  *  Test for memory's ECC dependencies upon entry because platform specific
  *  startup should have initialized the memory and enabled the ECC.
@@ -848,6 +848,31 @@ static int altr_check_ecc_deps(struct altr_edac_device_dev *device)
 	return -ENODEV;
 }
 
+static irqreturn_t altr_edac_a10_ecc_irq(struct altr_edac_device_dev *dci,
+					 bool sberr)
+{
+	void __iomem  *base = dci->base;
+
+	if (sberr) {
+		writel(ALTR_A10_ECC_SERRPENA,
+		       base + ALTR_A10_ECC_INTSTAT_OFST);
+		edac_device_handle_ce(dci->edac_dev, 0, 0, dci->edac_dev_name);
+	} else {
+		writel(ALTR_A10_ECC_DERRPENA,
+		       base + ALTR_A10_ECC_INTSTAT_OFST);
+		edac_device_handle_ue(dci->edac_dev, 0, 0, dci->edac_dev_name);
+		if (dci->data->panic)
+			panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
+	}
+	return IRQ_HANDLED;
+}
+
+#endif	/* CONFIG_EDAC_ALTERA_OCRAM || CONFIG_EDAC_ALTERA_ETHERNET */
+
+/*********************** OCRAM EDAC Device Functions *********************/
+
+#ifdef CONFIG_EDAC_ALTERA_OCRAM
+
 static void *ocram_alloc_mem(size_t size, void **other)
 {
 	struct device_node *np;
@@ -882,25 +907,6 @@ static void ocram_free_mem(void *p, size_t size, void *other)
 	gen_pool_free((struct gen_pool *)other, (u32)p, size);
 }
 
-static irqreturn_t altr_edac_a10_ecc_irq(struct altr_edac_device_dev *dci,
-					 bool sberr)
-{
-	void __iomem  *base = dci->base;
-
-	if (sberr) {
-		writel(ALTR_A10_ECC_SERRPENA,
-		       base + ALTR_A10_ECC_INTSTAT_OFST);
-		edac_device_handle_ce(dci->edac_dev, 0, 0, dci->edac_dev_name);
-	} else {
-		writel(ALTR_A10_ECC_DERRPENA,
-		       base + ALTR_A10_ECC_INTSTAT_OFST);
-		edac_device_handle_ue(dci->edac_dev, 0, 0, dci->edac_dev_name);
-		if (dci->data->panic)
-			panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
-	}
-	return IRQ_HANDLED;
-}
-
 const struct edac_device_prv_data ocramecc_data = {
 	.setup = altr_check_ecc_deps,
 	.ce_clear_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_SERR),
-- 
1.7.9.5
