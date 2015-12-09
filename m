From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Wed, 9 Dec 2015 18:22:00 -0500
Subject: [PATCH 4/6] drivers/dma: make pxa_dma.c explicitly non-modular
In-Reply-To: <1449703322-17762-1-git-send-email-paul.gortmaker@windriver.com>
References: <1449703322-17762-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <1449703322-17762-5-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig currently controlling compilation of this code is:

drivers/dma/Kconfig:config PXA_DMA
drivers/dma/Kconfig:    bool "PXA DMA support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: dmaengine at vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/dma/pxa_dma.c | 38 +++-----------------------------------
 1 file changed, 3 insertions(+), 35 deletions(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index f2a0310ae771..5d6ab9ff2222 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -1,4 +1,5 @@
 /*
+ * Marvell PXA Peripheral DMA Driver
  * Copyright 2015 Robert Jarzmik <robert.jarzmik@free.fr>
  *
  * This program is free software; you can redistribute it and/or modify
@@ -7,7 +8,6 @@
  */
 
 #include <linux/err.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
@@ -400,13 +400,8 @@ err_root:
 	pr_err("pxad: debugfs is not available\n");
 }
 
-static void pxad_cleanup_debugfs(struct pxad_device *pdev)
-{
-	debugfs_remove_recursive(pdev->dbgfs_root);
-}
 #else
 static inline void pxad_init_debugfs(struct pxad_device *pdev) {}
-static inline void pxad_cleanup_debugfs(struct pxad_device *pdev) {}
 #endif
 
 /*
@@ -1246,27 +1241,6 @@ static enum dma_status pxad_tx_status(struct dma_chan *dchan,
 	return ret;
 }
 
-static void pxad_free_channels(struct dma_device *dmadev)
-{
-	struct pxad_chan *c, *cn;
-
-	list_for_each_entry_safe(c, cn, &dmadev->channels,
-				 vc.chan.device_node) {
-		list_del(&c->vc.chan.device_node);
-		tasklet_kill(&c->vc.task);
-	}
-}
-
-static int pxad_remove(struct platform_device *op)
-{
-	struct pxad_device *pdev = platform_get_drvdata(op);
-
-	pxad_cleanup_debugfs(pdev);
-	pxad_free_channels(&pdev->slave);
-	dma_async_device_unregister(&pdev->slave);
-	return 0;
-}
-
 static int pxad_init_phys(struct platform_device *op,
 			  struct pxad_device *pdev,
 			  unsigned int nb_phy_chans)
@@ -1315,7 +1289,6 @@ static const struct of_device_id const pxad_dt_ids[] = {
 	{ .compatible = "marvell,pdma-1.0", },
 	{}
 };
-MODULE_DEVICE_TABLE(of, pxad_dt_ids);
 
 static struct dma_chan *pxad_dma_xlate(struct of_phandle_args *dma_spec,
 					   struct of_dma *ofdma)
@@ -1448,12 +1421,13 @@ static const struct platform_device_id pxad_id_table[] = {
 static struct platform_driver pxad_driver = {
 	.driver		= {
 		.name	= "pxa-dma",
+		.suppress_bind_attrs = true,
 		.of_match_table = pxad_dt_ids,
 	},
 	.id_table	= pxad_id_table,
 	.probe		= pxad_probe,
-	.remove		= pxad_remove,
 };
+builtin_platform_driver(pxad_driver);
 
 bool pxad_filter_fn(struct dma_chan *chan, void *param)
 {
@@ -1478,9 +1452,3 @@ int pxad_toggle_reserved_channel(int legacy_channel)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pxad_toggle_reserved_channel);
-
-module_platform_driver(pxad_driver);
-
-MODULE_DESCRIPTION("Marvell PXA Peripheral DMA Driver");
-MODULE_AUTHOR("Robert Jarzmik <robert.jarzmik@free.fr>");
-MODULE_LICENSE("GPL v2");
-- 
2.6.1
