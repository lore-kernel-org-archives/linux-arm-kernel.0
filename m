From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Sep 2016 17:19:34 +0200
Subject: [PATCH 11/24] ste_dma40: Rename a jump label in d40_probe()
In-Reply-To: <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
Message-ID: <02a8a05c-c0d7-0791-eddb-d6ad18d78e27@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 17 Sep 2016 14:50:53 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/ste_dma40.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 4ebc825..ed96039 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3570,7 +3570,7 @@ static int __init d40_probe(struct platform_device *pdev)
 	if (!res) {
 		ret = -ENOENT;
 		d40_err(&pdev->dev, "No \"lcpa\" memory resource\n");
-		goto failure;
+		goto destroy_cache;
 	}
 	base->lcpa_size = resource_size(res);
 	base->phy_lcpa = res->start;
@@ -3579,7 +3579,7 @@ static int __init d40_probe(struct platform_device *pdev)
 			       D40_NAME " I/O lcpa") == NULL) {
 		ret = -EBUSY;
 		d40_err(&pdev->dev, "Failed to request LCPA region %pR\n", res);
-		goto failure;
+		goto destroy_cache;
 	}
 
 	/* We make use of ESRAM memory for this. */
@@ -3595,7 +3595,7 @@ static int __init d40_probe(struct platform_device *pdev)
 	if (!base->lcpa_base) {
 		ret = -ENOMEM;
 		d40_err(&pdev->dev, "Failed to ioremap LCPA region\n");
-		goto failure;
+		goto destroy_cache;
 	}
 	/* If lcla has to be located in ESRAM we don't need to allocate */
 	if (base->plat_data->use_esram_lcla) {
@@ -3605,14 +3605,14 @@ static int __init d40_probe(struct platform_device *pdev)
 			ret = -ENOENT;
 			d40_err(&pdev->dev,
 				"No \"lcla_esram\" memory resource\n");
-			goto failure;
+			goto destroy_cache;
 		}
 		base->lcla_pool.base = ioremap(res->start,
 						resource_size(res));
 		if (!base->lcla_pool.base) {
 			ret = -ENOMEM;
 			d40_err(&pdev->dev, "Failed to ioremap LCLA region\n");
-			goto failure;
+			goto destroy_cache;
 		}
 		writel(res->start, base->virtbase + D40_DREG_LCLA);
 
@@ -3620,7 +3620,7 @@ static int __init d40_probe(struct platform_device *pdev)
 		ret = d40_lcla_allocate(base);
 		if (ret) {
 			d40_err(&pdev->dev, "Failed to allocate LCLA area\n");
-			goto failure;
+			goto destroy_cache;
 		}
 	}
 
@@ -3631,7 +3631,7 @@ static int __init d40_probe(struct platform_device *pdev)
 	ret = request_irq(base->irq, d40_handle_interrupt, 0, D40_NAME, base);
 	if (ret) {
 		d40_err(&pdev->dev, "No IRQ defined\n");
-		goto failure;
+		goto destroy_cache;
 	}
 
 	if (base->plat_data->use_esram_lcla) {
@@ -3641,7 +3641,7 @@ static int __init d40_probe(struct platform_device *pdev)
 			d40_err(&pdev->dev, "Failed to get lcpa_regulator\n");
 			ret = PTR_ERR(base->lcpa_regulator);
 			base->lcpa_regulator = NULL;
-			goto failure;
+			goto destroy_cache;
 		}
 
 		ret = regulator_enable(base->lcpa_regulator);
@@ -3650,7 +3650,7 @@ static int __init d40_probe(struct platform_device *pdev)
 				"Failed to enable lcpa_regulator\n");
 			regulator_put(base->lcpa_regulator);
 			base->lcpa_regulator = NULL;
-			goto failure;
+			goto destroy_cache;
 		}
 	}
 
@@ -3665,13 +3665,13 @@ static int __init d40_probe(struct platform_device *pdev)
 
 	ret = d40_dmaengine_init(base, num_reserved_chans);
 	if (ret)
-		goto failure;
+		goto destroy_cache;
 
 	base->dev->dma_parms = &base->dma_parms;
 	ret = dma_set_max_seg_size(base->dev, STEDMA40_MAX_SEG_SIZE);
 	if (ret) {
 		d40_err(&pdev->dev, "Failed to set dma max seg size\n");
-		goto failure;
+		goto destroy_cache;
 	}
 
 	d40_hw_init(base);
@@ -3685,8 +3685,7 @@ static int __init d40_probe(struct platform_device *pdev)
 
 	dev_info(base->dev, "initialized\n");
 	return 0;
-
-failure:
+ destroy_cache:
 	kmem_cache_destroy(base->desc_slab);
 	if (base->virtbase)
 		iounmap(base->virtbase);
-- 
2.10.0
