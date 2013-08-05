From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 05 Aug 2013 14:26:50 +0200
Subject: [PATCH 2/2] media: s5p-mfc: remove DT hacks and simplify
 initialization code
In-Reply-To: <1375705610-12724-1-git-send-email-m.szyprowski@samsung.com>
References: <1375705610-12724-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1375705610-12724-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes custom initialization of reserved memory regions from
s5p-mfc driver. Memory initialization can be now handled by generic
code.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc.c |   75 ++++++------------------------
 1 file changed, 15 insertions(+), 60 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
index a130dcd..696e0e0 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -1011,51 +1011,11 @@ static int match_child(struct device *dev, void *data)
 {
 	if (!dev_name(dev))
 		return 0;
-	return !strcmp(dev_name(dev), (char *)data);
+	return !!strstr(dev_name(dev), (char *)data);
 }
 
 static void *mfc_get_drv_data(struct platform_device *pdev);
 
-static int s5p_mfc_alloc_memdevs(struct s5p_mfc_dev *dev)
-{
-	unsigned int mem_info[2] = { };
-
-	dev->mem_dev_l = devm_kzalloc(&dev->plat_dev->dev,
-			sizeof(struct device), GFP_KERNEL);
-	if (!dev->mem_dev_l) {
-		mfc_err("Not enough memory\n");
-		return -ENOMEM;
-	}
-	device_initialize(dev->mem_dev_l);
-	of_property_read_u32_array(dev->plat_dev->dev.of_node,
-			"samsung,mfc-l", mem_info, 2);
-	if (dma_declare_coherent_memory(dev->mem_dev_l, mem_info[0],
-				mem_info[0], mem_info[1],
-				DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE) == 0) {
-		mfc_err("Failed to declare coherent memory for\n"
-		"MFC device\n");
-		return -ENOMEM;
-	}
-
-	dev->mem_dev_r = devm_kzalloc(&dev->plat_dev->dev,
-			sizeof(struct device), GFP_KERNEL);
-	if (!dev->mem_dev_r) {
-		mfc_err("Not enough memory\n");
-		return -ENOMEM;
-	}
-	device_initialize(dev->mem_dev_r);
-	of_property_read_u32_array(dev->plat_dev->dev.of_node,
-			"samsung,mfc-r", mem_info, 2);
-	if (dma_declare_coherent_memory(dev->mem_dev_r, mem_info[0],
-				mem_info[0], mem_info[1],
-				DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE) == 0) {
-		pr_err("Failed to declare coherent memory for\n"
-		"MFC device\n");
-		return -ENOMEM;
-	}
-	return 0;
-}
-
 /* MFC probe function */
 static int s5p_mfc_probe(struct platform_device *pdev)
 {
@@ -1107,25 +1067,20 @@ static int s5p_mfc_probe(struct platform_device *pdev)
 		goto err_res;
 	}
 
-	if (pdev->dev.of_node) {
-		ret = s5p_mfc_alloc_memdevs(dev);
-		if (ret < 0)
-			goto err_res;
-	} else {
-		dev->mem_dev_l = device_find_child(&dev->plat_dev->dev,
-				"s5p-mfc-l", match_child);
-		if (!dev->mem_dev_l) {
-			mfc_err("Mem child (L) device get failed\n");
-			ret = -ENODEV;
-			goto err_res;
-		}
-		dev->mem_dev_r = device_find_child(&dev->plat_dev->dev,
-				"s5p-mfc-r", match_child);
-		if (!dev->mem_dev_r) {
-			mfc_err("Mem child (R) device get failed\n");
-			ret = -ENODEV;
-			goto err_res;
-		}
+	dev->mem_dev_l = device_find_child(&dev->plat_dev->dev, "-l",
+					   match_child);
+	if (!dev->mem_dev_l) {
+		mfc_err("Mem child (L) device get failed\n");
+		ret = -ENODEV;
+		goto err_res;
+	}
+
+	dev->mem_dev_r = device_find_child(&dev->plat_dev->dev, "-r",
+					   match_child);
+	if (!dev->mem_dev_r) {
+		mfc_err("Mem child (R) device get failed\n");
+		ret = -ENODEV;
+		goto err_res;
 	}
 
 	dev->alloc_ctx[0] = vb2_dma_contig_init_ctx(dev->mem_dev_l);
-- 
1.7.9.5
