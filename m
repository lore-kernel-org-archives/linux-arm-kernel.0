From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Tue, 7 Feb 2017 09:43:48 -0600
Subject: [PATCH v3 05/10] staging: fsl-mc: remove slab cache for mc devices
In-Reply-To: <20170207154353.20691-1-laurentiu.tudor@nxp.com>
References: <20170207154353.20691-1-laurentiu.tudor@nxp.com>
Message-ID: <20170207154353.20691-6-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Let's drop the slab cache for objects
until we actually have proof that it improves
performance. This makes the code cleaner.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
v3:
 - made distinct patch with slab cache removal

 drivers/staging/fsl-mc/bus/fsl-mc-bus.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
index f310687..e607e98 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
@@ -27,8 +27,6 @@
 #include "fsl-mc-private.h"
 #include "dprc-cmd.h"
 
-static struct kmem_cache *mc_dev_cache;
-
 /**
  * Default DMA mask for devices on a fsl-mc bus
  */
@@ -432,7 +430,7 @@ static void fsl_mc_device_release(struct device *dev)
 	if (mc_bus)
 		kfree(mc_bus);
 	else
-		kmem_cache_free(mc_dev_cache, mc_dev);
+		kfree(mc_dev);
 }
 
 /**
@@ -466,7 +464,7 @@ int fsl_mc_device_add(struct dprc_obj_desc *obj_desc,
 		/*
 		 * Allocate a regular fsl_mc_device object:
 		 */
-		mc_dev = kmem_cache_zalloc(mc_dev_cache, GFP_KERNEL);
+		mc_dev = kzalloc(sizeof(*mc_dev), GFP_KERNEL);
 		if (!mc_dev)
 			return -ENOMEM;
 	}
@@ -564,7 +562,7 @@ int fsl_mc_device_add(struct dprc_obj_desc *obj_desc,
 	if (mc_bus)
 		kfree(mc_bus);
 	else
-		kmem_cache_free(mc_dev_cache, mc_dev);
+		kfree(mc_dev);
 
 	return error;
 }
@@ -823,14 +821,6 @@ static int __init fsl_mc_bus_driver_init(void)
 {
 	int error;
 
-	mc_dev_cache = kmem_cache_create("fsl_mc_device",
-					 sizeof(struct fsl_mc_device), 0, 0,
-					 NULL);
-	if (!mc_dev_cache) {
-		pr_err("Could not create fsl_mc_device cache\n");
-		return -ENOMEM;
-	}
-
 	error = bus_register(&fsl_mc_bus_type);
 	if (error < 0) {
 		pr_err("bus type registration failed: %d\n", error);
@@ -870,7 +860,6 @@ static int __init fsl_mc_bus_driver_init(void)
 	bus_unregister(&fsl_mc_bus_type);
 
 error_cleanup_cache:
-	kmem_cache_destroy(mc_dev_cache);
 	return error;
 }
 postcore_initcall(fsl_mc_bus_driver_init);
-- 
1.8.3.1
