From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 16 Nov 2015 22:24:38 +0100
Subject: [PATCH 2/3] ste_dma40: Delete another unnecessary check in d40_probe()
In-Reply-To: <564A4899.8040109@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <564A4899.8040109@users.sourceforge.net>
Message-ID: <564A4996.2000406@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 16 Nov 2015 21:56:07 +0100

A single jump label was used by the d40_probe() function in several cases
for error handling which was a bit inefficient here.

* This implementation detail could be improved by the introduction
  of another jump label.

* Remove an extra check for the variable "base".

* Omit its explicit initialisation at the beginning then.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/ste_dma40.c | 82 ++++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 42 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 9132ae0..8ebfde1 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3543,7 +3543,7 @@ static int __init d40_probe(struct platform_device *pdev)
 	struct stedma40_platform_data *plat_data = dev_get_platdata(&pdev->dev);
 	struct device_node *np = pdev->dev.of_node;
 	int ret = -ENOENT;
-	struct d40_base *base = NULL;
+	struct d40_base *base;
 	struct resource *res = NULL;
 	int num_reserved_chans;
 	u32 val;
@@ -3552,17 +3552,17 @@ static int __init d40_probe(struct platform_device *pdev)
 		if (np) {
 			if (d40_of_probe(pdev, np)) {
 				ret = -ENOMEM;
-				goto failure;
+				goto report_failure;
 			}
 		} else {
 			d40_err(&pdev->dev, "No pdata or Device Tree provided\n");
-			goto failure;
+			goto report_failure;
 		}
 	}
 
 	base = d40_hw_detect_init(pdev);
 	if (!base)
-		goto failure;
+		goto report_failure;
 
 	num_reserved_chans = d40_phy_res_init(base);
 
@@ -3693,50 +3693,48 @@ static int __init d40_probe(struct platform_device *pdev)
 	return 0;
 
 failure:
-	if (base) {
-		kmem_cache_destroy(base->desc_slab);
-		if (base->virtbase)
-			iounmap(base->virtbase);
+	kmem_cache_destroy(base->desc_slab);
+	if (base->virtbase)
+		iounmap(base->virtbase);
 
-		if (base->lcla_pool.base && base->plat_data->use_esram_lcla) {
-			iounmap(base->lcla_pool.base);
-			base->lcla_pool.base = NULL;
-		}
+	if (base->lcla_pool.base && base->plat_data->use_esram_lcla) {
+		iounmap(base->lcla_pool.base);
+		base->lcla_pool.base = NULL;
+	}
 
-		if (base->lcla_pool.dma_addr)
-			dma_unmap_single(base->dev, base->lcla_pool.dma_addr,
-					 SZ_1K * base->num_phy_chans,
-					 DMA_TO_DEVICE);
-
-		if (!base->lcla_pool.base_unaligned && base->lcla_pool.base)
-			free_pages((unsigned long)base->lcla_pool.base,
-				   base->lcla_pool.pages);
-
-		kfree(base->lcla_pool.base_unaligned);
-
-		if (base->phy_lcpa)
-			release_mem_region(base->phy_lcpa,
-					   base->lcpa_size);
-		if (base->phy_start)
-			release_mem_region(base->phy_start,
-					   base->phy_size);
-		if (base->clk) {
-			clk_disable_unprepare(base->clk);
-			clk_put(base->clk);
-		}
+	if (base->lcla_pool.dma_addr)
+		dma_unmap_single(base->dev, base->lcla_pool.dma_addr,
+				 SZ_1K * base->num_phy_chans,
+				 DMA_TO_DEVICE);
 
-		if (base->lcpa_regulator) {
-			regulator_disable(base->lcpa_regulator);
-			regulator_put(base->lcpa_regulator);
-		}
+	if (!base->lcla_pool.base_unaligned && base->lcla_pool.base)
+		free_pages((unsigned long)base->lcla_pool.base,
+			   base->lcla_pool.pages);
 
-		kfree(base->lcla_pool.alloc_map);
-		kfree(base->lookup_log_chans);
-		kfree(base->lookup_phy_chans);
-		kfree(base->phy_res);
-		kfree(base);
+	kfree(base->lcla_pool.base_unaligned);
+
+	if (base->phy_lcpa)
+		release_mem_region(base->phy_lcpa,
+				   base->lcpa_size);
+	if (base->phy_start)
+		release_mem_region(base->phy_start,
+				   base->phy_size);
+	if (base->clk) {
+		clk_disable_unprepare(base->clk);
+		clk_put(base->clk);
+	}
+
+	if (base->lcpa_regulator) {
+		regulator_disable(base->lcpa_regulator);
+		regulator_put(base->lcpa_regulator);
 	}
 
+	kfree(base->lcla_pool.alloc_map);
+	kfree(base->lookup_log_chans);
+	kfree(base->lookup_phy_chans);
+	kfree(base->phy_res);
+	kfree(base);
+report_failure:
 	d40_err(&pdev->dev, "probe failed\n");
 	return ret;
 }
-- 
2.6.2
