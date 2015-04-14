From: rsahu@apm.com (Rameshwar Prasad Sahu)
Date: Tue, 14 Apr 2015 12:34:00 +0530
Subject: [PATCH] dmaengine: xgene-dma: Fix sparse wannings and coccinelle
 warnings
Message-ID: <1428995040-11815-1-git-send-email-rsahu@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes compilation sparse warnings like incorrect type in assignment
(different base types), cast to restricted __le64, symbol
'__UNIQUE_ID_author__COUNTER__' has multiple initializers etc and
coccinelle warnings (No need to set .owner here. The core will do it.)

This patch is based on slave-dma / for-linus branch.
(commit: 9f2fd0dfa594d857fbdaeda523ff7a46f16567f5 [26/28]
	dmaengine: Add support for APM X-Gene SoC DMA engine driver)

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
---
 drivers/dma/xgene-dma.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
index aa61935..59f95db 100755
--- a/drivers/dma/xgene-dma.c
+++ b/drivers/dma/xgene-dma.c
@@ -238,10 +238,10 @@
 	dev_err(chan->dev, "%s: " fmt, chan->name, ##arg)

 struct xgene_dma_desc_hw {
-	u64 m0;
-	u64 m1;
-	u64 m2;
-	u64 m3;
+	__le64 m0;
+	__le64 m1;
+	__le64 m2;
+	__le64 m3;
 };

 enum xgene_dma_ring_cfgsize {
@@ -388,12 +388,12 @@ static bool is_pq_enabled(struct xgene_dma *pdma)
 	return !(val & XGENE_DMA_PQ_DISABLE_MASK);
 }

-static void xgene_dma_cpu_to_le64(u64 *desc, int count)
+static void xgene_dma_cpu_to_le64(struct xgene_dma_desc_hw *desc)
 {
-	int i;
-
-	for (i = 0; i < count; i++)
-		desc[i] = cpu_to_le64(desc[i]);
+	desc->m0 = cpu_to_le64(((u64 *)desc)[0]);
+	desc->m1 = cpu_to_le64(((u64 *)desc)[1]);
+	desc->m2 = cpu_to_le64(((u64 *)desc)[2]);
+	desc->m3 = cpu_to_le64(((u64 *)desc)[3]);
 }

 static u16 xgene_dma_encode_len(u32 len)
@@ -499,9 +499,9 @@ static void xgene_dma_prep_cpy_desc(struct xgene_dma_chan *chan,

 skip_additional_src:
 	/* Hardware stores descriptor in little endian format */
-	xgene_dma_cpu_to_le64(desc1, 4);
+	xgene_dma_cpu_to_le64(desc1);
 	if (desc2)
-		xgene_dma_cpu_to_le64(desc2, 4);
+		xgene_dma_cpu_to_le64(desc2);
 }

 static void xgene_dma_prep_xor_desc(struct xgene_dma_chan *chan,
@@ -540,8 +540,8 @@ static void xgene_dma_prep_xor_desc(struct xgene_dma_chan *chan,
 	}

 	/* Hardware stores descriptor in little endian format */
-	xgene_dma_cpu_to_le64(desc1, 4);
-	xgene_dma_cpu_to_le64(desc2, 4);
+	xgene_dma_cpu_to_le64(desc1);
+	xgene_dma_cpu_to_le64(desc2);

 	/* Update meta data */
 	*nbytes = len;
@@ -1895,9 +1895,9 @@ static int xgene_dma_get_resources(struct platform_device *pdev,

 	pdma->csr_dma = devm_ioremap(&pdev->dev, res->start,
 				     resource_size(res));
-	if (IS_ERR(pdma->csr_dma)) {
+	if (!pdma->csr_dma) {
 		dev_err(&pdev->dev, "Failed to ioremap csr region");
-		return PTR_ERR(pdma->csr_dma);
+		return -ENOMEM;
 	}

 	/* Get DMA ring csr region */
@@ -1909,9 +1909,9 @@ static int xgene_dma_get_resources(struct platform_device *pdev,

 	pdma->csr_ring =  devm_ioremap(&pdev->dev, res->start,
 				       resource_size(res));
-	if (IS_ERR(pdma->csr_ring)) {
+	if (!pdma->csr_ring) {
 		dev_err(&pdev->dev, "Failed to ioremap ring csr region");
-		return PTR_ERR(pdma->csr_ring);
+		return -ENOMEM;
 	}

 	/* Get DMA ring cmd csr region */
@@ -1923,9 +1923,9 @@ static int xgene_dma_get_resources(struct platform_device *pdev,

 	pdma->csr_ring_cmd = devm_ioremap(&pdev->dev, res->start,
 					  resource_size(res));
-	if (IS_ERR(pdma->csr_ring_cmd)) {
+	if (!pdma->csr_ring_cmd) {
 		dev_err(&pdev->dev, "Failed to ioremap ring cmd csr region");
-		return PTR_ERR(pdma->csr_ring_cmd);
+		return -ENOMEM;
 	}

 	/* Get efuse csr region */
@@ -1937,9 +1937,9 @@ static int xgene_dma_get_resources(struct platform_device *pdev,

 	pdma->csr_efuse = devm_ioremap(&pdev->dev, res->start,
 				       resource_size(res));
-	if (IS_ERR(pdma->csr_efuse)) {
+	if (!pdma->csr_efuse) {
 		dev_err(&pdev->dev, "Failed to ioremap efuse csr region");
-		return PTR_ERR(pdma->csr_efuse);
+		return -ENOMEM;
 	}

 	/* Get DMA error interrupt */
@@ -2076,7 +2076,6 @@ static struct platform_driver xgene_dma_driver = {
 	.remove = xgene_dma_remove,
 	.driver = {
 		.name = "X-Gene-DMA",
-		.owner = THIS_MODULE,
 		.of_match_table = xgene_dma_of_match_ptr,
 	},
 };
@@ -2085,6 +2084,5 @@ module_platform_driver(xgene_dma_driver);

 MODULE_DESCRIPTION("APM X-Gene SoC DMA driver");
 MODULE_AUTHOR("Rameshwar Prasad Sahu <rsahu@apm.com>");
-MODULE_AUTHOR("Loc Ho <lho@apm.com>");
 MODULE_LICENSE("GPL");
 MODULE_VERSION("1.0");
--
1.8.2.1
