From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Tue, 7 Feb 2017 09:43:44 -0600
Subject: [PATCH v3 01/10] staging: fsl-mc: drop root dprc counting
In-Reply-To: <20170207154353.20691-1-laurentiu.tudor@nxp.com>
References: <20170207154353.20691-1-laurentiu.tudor@nxp.com>
Message-ID: <20170207154353.20691-2-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

It was used just to sanity check some obscure
cases that are unlikely to ever happen.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
v3:
 - no changes

 drivers/staging/fsl-mc/bus/fsl-mc-bus.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
index 5ac373c..cc20dc4 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
@@ -77,9 +77,6 @@ static int fsl_mc_bus_match(struct device *dev, struct device_driver *drv)
 	struct fsl_mc_driver *mc_drv = to_fsl_mc_driver(drv);
 	bool found = false;
 
-	if (WARN_ON(!fsl_mc_bus_exists()))
-		goto out;
-
 	if (!mc_drv->match_id_table)
 		goto out;
 
@@ -149,8 +146,6 @@ struct bus_type fsl_mc_bus_type = {
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_type);
 
-static atomic_t root_dprc_count = ATOMIC_INIT(0);
-
 static int fsl_mc_driver_probe(struct device *dev)
 {
 	struct fsl_mc_driver *mc_drv;
@@ -246,15 +241,6 @@ void fsl_mc_driver_unregister(struct fsl_mc_driver *mc_driver)
 EXPORT_SYMBOL_GPL(fsl_mc_driver_unregister);
 
 /**
- * fsl_mc_bus_exists - check if a root dprc exists
- */
-bool fsl_mc_bus_exists(void)
-{
-	return atomic_read(&root_dprc_count) > 0;
-}
-EXPORT_SYMBOL_GPL(fsl_mc_bus_exists);
-
-/**
  * fsl_mc_get_root_dprc - function to traverse to the root dprc
  */
 void fsl_mc_get_root_dprc(struct device *dev,
@@ -506,8 +492,6 @@ int fsl_mc_device_add(struct dprc_obj_desc *obj_desc,
 			}
 
 			mc_io2 = mc_io;
-
-			atomic_inc(&root_dprc_count);
 		}
 
 		error = get_dprc_icid(mc_io2, obj_desc->id, &mc_dev->icid);
@@ -588,17 +572,9 @@ void fsl_mc_device_remove(struct fsl_mc_device *mc_dev)
 	device_del(&mc_dev->dev);
 	put_device(&mc_dev->dev);
 
-	if (strcmp(mc_dev->obj_desc.type, "dprc") == 0) {
+	if (strcmp(mc_dev->obj_desc.type, "dprc") == 0)
 		mc_bus = to_fsl_mc_bus(mc_dev);
 
-		if (fsl_mc_is_root_dprc(&mc_dev->dev)) {
-			if (atomic_read(&root_dprc_count) > 0)
-				atomic_dec(&root_dprc_count);
-			else
-				WARN_ON(1);
-		}
-	}
-
 	if (mc_bus)
 		devm_kfree(mc_dev->dev.parent, mc_bus);
 	else
-- 
1.8.3.1
