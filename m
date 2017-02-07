From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Tue, 7 Feb 2017 09:43:47 -0600
Subject: [PATCH v3 04/10] staging: fsl-mc: don't use devres api for refcounted
 objects
In-Reply-To: <20170207154353.20691-1-laurentiu.tudor@nxp.com>
References: <20170207154353.20691-1-laurentiu.tudor@nxp.com>
Message-ID: <20170207154353.20691-5-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Mixing two memory management systems, in this case
managed device resource api and refcounted objects
is a bad idea. Lifetime of an object is controlled
by its refcount so allocating it with other apis
that have their own lifetime control is not ok.
Drop devm_*() apis in favor of plain allocations.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
v3:
 - left only devm api removal and moved slab cache removal in its own patch

 drivers/staging/fsl-mc/bus/fsl-mc-bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
index 5963e98..f310687 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
@@ -430,7 +430,7 @@ static void fsl_mc_device_release(struct device *dev)
 		mc_bus = to_fsl_mc_bus(mc_dev);
 
 	if (mc_bus)
-		devm_kfree(mc_dev->dev.parent, mc_bus);
+		kfree(mc_bus);
 	else
 		kmem_cache_free(mc_dev_cache, mc_dev);
 }
@@ -457,7 +457,7 @@ int fsl_mc_device_add(struct dprc_obj_desc *obj_desc,
 		/*
 		 * Allocate an MC bus device object:
 		 */
-		mc_bus = devm_kzalloc(parent_dev, sizeof(*mc_bus), GFP_KERNEL);
+		mc_bus = kzalloc(sizeof(*mc_bus), GFP_KERNEL);
 		if (!mc_bus)
 			return -ENOMEM;
 
@@ -562,7 +562,7 @@ int fsl_mc_device_add(struct dprc_obj_desc *obj_desc,
 error_cleanup_dev:
 	kfree(mc_dev->regions);
 	if (mc_bus)
-		devm_kfree(parent_dev, mc_bus);
+		kfree(mc_bus);
 	else
 		kmem_cache_free(mc_dev_cache, mc_dev);
 
-- 
1.8.3.1
