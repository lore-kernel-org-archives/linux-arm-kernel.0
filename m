From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Sep 2016 17:16:11 +0200
Subject: [PATCH 08/24] ste_dma40: Less checks in d40_hw_detect_init() after
 error detection
In-Reply-To: <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
Message-ID: <e1895f0f-187a-976d-5064-e3022a2c9ea4@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 17 Sep 2016 14:10:47 +0200

Four checks could be repeated by the d40_hw_detect_init() function during
error handling even if the passed variables contained a null pointer.

* Adjust jump targets according to the Linux coding style convention.

* Call the interface "iounmap" only once at the end.

* Delete the repeated checks which became unnecessary with
  this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/ste_dma40.c | 67 ++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index f813056..c680dd3 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3158,27 +3158,27 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 	clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		d40_err(&pdev->dev, "No matching clock found\n");
-		goto failure;
+		goto check_prepare_enabled;
 	}
 
 	clk_ret = clk_prepare_enable(clk);
 	if (clk_ret) {
 		d40_err(&pdev->dev, "Failed to prepare/enable clock\n");
-		goto failure;
+		goto disable_unprepare;
 	}
 
 	/* Get IO for DMAC base address */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "base");
 	if (!res)
-		goto failure;
+		goto disable_unprepare;
 
 	if (request_mem_region(res->start, resource_size(res),
 			       D40_NAME " I/O base") == NULL)
-		goto failure;
+		goto release_region;
 
 	virtbase = ioremap(res->start, resource_size(res));
 	if (!virtbase)
-		goto failure;
+		goto release_region;
 
 	/* This is just a regular AMBA PrimeCell ID actually */
 	for (pid = 0, i = 0; i < 4; i++)
@@ -3190,13 +3190,13 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 
 	if (cid != AMBA_CID) {
 		d40_err(&pdev->dev, "Unknown hardware! No PrimeCell ID\n");
-		goto failure;
+		goto unmap_io;
 	}
 	if (AMBA_MANF_BITS(pid) != AMBA_VENDOR_ST) {
 		d40_err(&pdev->dev, "Unknown designer! Got %x wanted %x\n",
 			AMBA_MANF_BITS(pid),
 			AMBA_VENDOR_ST);
-		goto failure;
+		goto unmap_io;
 	}
 	/*
 	 * HW revision:
@@ -3210,7 +3210,7 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 	rev = AMBA_REV_BITS(pid);
 	if (rev < 2) {
 		d40_err(&pdev->dev, "hardware revision: %d is not supported", rev);
-		goto failure;
+		goto unmap_io;
 	}
 
 	/* The number of physical channels on this HW */
@@ -3236,7 +3236,7 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 		       sizeof(struct d40_chan), GFP_KERNEL);
 
 	if (base == NULL)
-		goto failure;
+		goto unmap_io;
 
 	base->rev = rev;
 	base->clk = clk;
@@ -3285,63 +3285,62 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 				sizeof(*base->phy_res),
 				GFP_KERNEL);
 	if (!base->phy_res)
-		goto failure;
+		goto free_base;
 
 	base->lookup_phy_chans = kcalloc(num_phy_chans,
 					 sizeof(*base->lookup_phy_chans),
 					 GFP_KERNEL);
 	if (!base->lookup_phy_chans)
-		goto failure;
+		goto free_phy_res;
 
 	base->lookup_log_chans = kcalloc(num_log_chans,
 					 sizeof(*base->lookup_log_chans),
 					 GFP_KERNEL);
 	if (!base->lookup_log_chans)
-		goto failure;
+		goto free_phy_chans;
 
 	base->reg_val_backup_chan = kmalloc_array(base->num_phy_chans,
 						  sizeof(d40_backup_regs_chan),
 						  GFP_KERNEL);
 	if (!base->reg_val_backup_chan)
-		goto failure;
+		goto free_log_chans;
 
 	base->lcla_pool.alloc_map = kcalloc(num_phy_chans
 					    * D40_LCLA_LINK_PER_EVENT_GRP,
 					    sizeof(*base->lcla_pool.alloc_map),
 					    GFP_KERNEL);
 	if (!base->lcla_pool.alloc_map)
-		goto failure;
+		goto free_backup_chan;
 
 	base->desc_slab = kmem_cache_create(D40_NAME, sizeof(struct d40_desc),
 					    0, SLAB_HWCACHE_ALIGN,
 					    NULL);
 	if (base->desc_slab == NULL)
-		goto failure;
+		goto free_map;
 
 	return base;
-
-failure:
+ free_map:
+	kfree(base->lcla_pool.alloc_map);
+ free_backup_chan:
+	kfree(base->reg_val_backup_chan);
+ free_log_chans:
+	kfree(base->lookup_log_chans);
+ free_phy_chans:
+	kfree(base->lookup_phy_chans);
+ free_phy_res:
+	kfree(base->phy_res);
+ free_base:
+	kfree(base);
+ unmap_io:
+	iounmap(virtbase);
+ release_region:
+	release_mem_region(res->start, resource_size(res));
+ check_prepare_enabled:
 	if (!clk_ret)
+ disable_unprepare:
 		clk_disable_unprepare(clk);
 	if (!IS_ERR(clk))
 		clk_put(clk);
-	if (virtbase)
-		iounmap(virtbase);
-	if (res)
-		release_mem_region(res->start,
-				   resource_size(res));
-	if (virtbase)
-		iounmap(virtbase);
-
-	if (base) {
-		kfree(base->lcla_pool.alloc_map);
-		kfree(base->reg_val_backup_chan);
-		kfree(base->lookup_log_chans);
-		kfree(base->lookup_phy_chans);
-		kfree(base->phy_res);
-		kfree(base);
-	}
-
 	return NULL;
 }
 
-- 
2.10.0
