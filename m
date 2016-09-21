From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 21 Sep 2016 13:26:30 +0300
Subject: [PATCH v2 2/9] dmaengine: edma: Use enum for eDMA binding type
 (legacy vs TPCC)
In-Reply-To: <20160921102637.24845-1-peter.ujfalusi@ti.com>
References: <20160921102637.24845-1-peter.ujfalusi@ti.com>
Message-ID: <20160921102637.24845-3-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes the following warning when compiling the driver for 64bit
architectures (x86_64 for example):
drivers/dma/edma.c:2185:16: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
   if (match && (u32)match->data == EDMA_BINDING_TPCC)
                ^

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index c2098a4b4dcf..4c8818278fcc 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -261,8 +261,11 @@ static const struct edmacc_param dummy_paramset = {
 	.ccnt = 1,
 };
 
-#define EDMA_BINDING_LEGACY	0
-#define EDMA_BINDING_TPCC	1
+enum edma_binding_type {
+	EDMA_BINDING_LEGACY = 0,
+	EDMA_BINDING_TPCC,
+};
+
 static const struct of_device_id edma_of_ids[] = {
 	{
 		.compatible = "ti,edma3",
@@ -2184,7 +2187,8 @@ static int edma_probe(struct platform_device *pdev)
 		const struct of_device_id *match;
 
 		match = of_match_node(edma_of_ids, node);
-		if (match && (u32)match->data == EDMA_BINDING_TPCC)
+		if (match &&
+		    (enum edma_binding_type)match->data == EDMA_BINDING_TPCC)
 			legacy_mode = false;
 
 		info = edma_setup_info_from_dt(dev, legacy_mode);
-- 
2.10.0
